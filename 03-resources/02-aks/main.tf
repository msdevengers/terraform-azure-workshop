resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "exampleaks1"

  addon_profile{
    kube_dashboard {
        enabled =false
    }
  }

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}


##Ref https://blog.dbi-services.com/provisioning-a-aks-cluster-and-kubeinvaders-with-terraform-aks/
###############################################
#            Load Provider K8s                #
###############################################  
 
provider "kubernetes" {
    host                   = azurerm_kubernetes_cluster.example.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.example.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.example.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.example.kube_config.0.cluster_ca_certificate)
    alias                  = "aks-ci"
}

###############################################
#       Create tiller service account         #
###############################################  
resource "kubernetes_service_account" "tiller" {
    provider = "kubernetes.aks-ci"
     
    metadata {
        name      = "tiller"
        namespace = "kube-system"
    }
      
    automount_service_account_token = true
 
    depends_on = [ "azurerm_kubernetes_cluster.example" ]
}
 
###############################################
#     Create tiller cluster role binding      #
############################################### 
 resource "kubernetes_cluster_role_binding" "tiller" {
    provider = "kubernetes.aks-ci"
 
    metadata {
        name = "tiller"
    }
 
    role_ref {
         kind      = "ClusterRole"
         name      = "cluster-admin"
         api_group = "rbac.authorization.k8s.io"
    }
 
    subject {
        kind      = "ServiceAccount"
        name      = "${kubernetes_service_account.tiller.metadata.0.name}"
        api_group = ""
        namespace = "kube-system"
    }
 
    depends_on = ["kubernetes_service_account.tiller"]
 }
 
###############################################
#   Save kube-config into azure_config file   #
###############################################
resource "null_resource" "save-kube-config" {
 
    triggers = {
        config = "${azurerm_kubernetes_cluster.example.kube_config_raw}"
    }
    provisioner "local-exec" {
        command = "mkdir -p ${path.module}/.kube && echo '${azurerm_kubernetes_cluster.example.kube_config_raw}' > ${path.module}/.kube/azure_config && chmod 0600 ${path.module}/.kube/azure_config"
    }
 
    depends_on = [ "azurerm_kubernetes_cluster.example" ]
}

###############################################
#    Create Azure public IP and DNS for       #
#    Azure load balancer                      #
###############################################
resource "azurerm_public_ip" "nginx_ingress" {
   
    name                = "nginx_ingress-ip"
    location            = "WestEurope"
    resource_group_name = "${azurerm_kubernetes_cluster.example.node_resource_group}" #"${azurerm_resource_group.example.name}"
    allocation_method   = "Static"
    domain_name_label   = "${var.domain_name_label}"
 
    tags = {
        environment = "CI"
    }
 
    depends_on = [ "azurerm_kubernetes_cluster.example" ]
}
 
###############################################
#       Create namespace nginx_ingress        #
###############################################
resource "kubernetes_namespace" "nginx_ingress" {
    provider = "kubernetes.aks-ci"
 
    metadata {
        name = "ingress-basic"
    } 
 
    depends_on = [ "azurerm_kubernetes_cluster.example" ]
}
 
###############################################
#       Create namespace cert-manager         #
###############################################
resource "kubernetes_namespace" "cert-manager" {
    provider = "kubernetes.aks-ci"
 
    metadata {
        name = "cert-manager"
    } 
 
    depends_on = [ "azurerm_kubernetes_cluster.example" ]
}
 
###############################################
#       Create namespace kubeinvaders         #
###############################################
resource "kubernetes_namespace" "kubeinvaders" {
    provider = "kubernetes.aks-ci"
     
    metadata {
        name = "foobar"
    } 
     
    depends_on = [ "azurerm_kubernetes_cluster.example" ]
}
 
###############################################
#             Load Provider helm              #
###############################################
 
provider "helm" {
    version = "0.10.4"
    install_tiller  = true
    service_account = kubernetes_service_account.tiller.metadata.0.name
 
    kubernetes {
        host                   = "${azurerm_kubernetes_cluster.example.kube_config.0.host}"
        client_certificate     = "${base64decode(azurerm_kubernetes_cluster.example.kube_config.0.client_certificate)}"
        client_key             = "${base64decode(azurerm_kubernetes_cluster.example.kube_config.0.client_key)}"
        cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.example.kube_config.0.cluster_ca_certificate)}"
    }
 
}
 
###############################################
#        Load helm stable repository          #
###############################################
data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}
 
###############################################
#       Install nginx ingress controller      #
###############################################
variable domain_name_label {
    default = "tf-ingress"
}

resource "helm_release" "nginx_ingress" {
 
     name       = "nginx-ingress"
     repository = "${data.helm_repository.stable.metadata.0.name}"
     chart      = "nginx-ingress"
     timeout    = 2400
     namespace  = "${kubernetes_namespace.nginx_ingress.metadata.0.name}"
 
     set {
         name  = "controller.replicaCount"
         value = "1"
     }
     set {
         name  = "controller.service.loadBalancerIP"
         value = "${azurerm_public_ip.nginx_ingress.ip_address}"
     }
     set_string {
         name  = "service.beta.kubernetes.io/azure-load-balancer-resource-group"
         value = "${azurerm_resource_group.example.name}"
     }
 
    depends_on = [ "kubernetes_cluster_role_binding.tiller" ]
}
 

output "client_certificate" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw
}