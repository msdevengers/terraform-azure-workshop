From the previosu exercise we created resource group name example-resources </p>
We should import into our terraform state to create aks cluster
```bash
tf plan
```

```
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_kubernetes_cluster.example will be created
  + resource "azurerm_kubernetes_cluster" "example" {
      + dns_prefix            = "exampleaks1"
      + fqdn                  = (known after apply)
      + id                    = (known after apply)
      + kube_admin_config     = (known after apply)
      + kube_admin_config_raw = (sensitive value)
      + kube_config           = (known after apply)
      + kube_config_raw       = (sensitive value)
      + kubelet_identity      = (known after apply)
      + kubernetes_version    = (known after apply)
      + location              = "westeurope"
      + name                  = "example-aks1"
      + node_resource_group   = (known after apply)
      + private_fqdn          = (known after apply)
      + resource_group_name   = "example-resources"
      + tags                  = {
          + "Environment" = "Production"
        }

      + addon_profile {

          + kube_dashboard {
              + enabled = false
            }
        }

      + default_node_pool {
          + max_pods        = (known after apply)
          + name            = "default"
          + node_count      = 1
          + os_disk_size_gb = (known after apply)
          + type            = "VirtualMachineScaleSets"
          + vm_size         = "Standard_D2_v2"
        }

      + identity {
          + principal_id = (known after apply)
          + tenant_id    = (known after apply)
          + type         = "SystemAssigned"
        }

      + network_profile {
          + dns_service_ip     = (known after apply)
          + docker_bridge_cidr = (known after apply)
          + load_balancer_sku  = (known after apply)
          + network_plugin     = (known after apply)
          + network_policy     = (known after apply)
          + outbound_type      = (known after apply)
          + pod_cidr           = (known after apply)
          + service_cidr       = (known after apply)

          + load_balancer_profile {
              + effective_outbound_ips    = (known after apply)
              + managed_outbound_ip_count = (known after apply)
              + outbound_ip_address_ids   = (known after apply)
              + outbound_ip_prefix_ids    = (known after apply)
            }
        }

      + role_based_access_control {
          + enabled = (known after apply)

          + azure_active_directory {
              + client_app_id     = (known after apply)
              + server_app_id     = (known after apply)
              + server_app_secret = (sensitive value)
              + tenant_id         = (known after apply)
            }
        }

      + windows_profile {
          + admin_password = (sensitive value)
          + admin_username = (known after apply)
        }
    }

  # azurerm_resource_group.example will be created
  + resource "azurerm_resource_group" "example" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "example-resources"
    }

Plan: 2 to add, 0 to change, 0 to destroy.
```

```bash
az group show --name example-resources --query id -o table
tf import azurerm_resource_group.example /subscriptions/<SUBSID_REPLACE>/resourceGroups/example-resources
```

```bash
tf plan -out tfplan.out
tf apply tfplan.out
```



```bash
tf destroy
az group list --output table | grep pamir
```