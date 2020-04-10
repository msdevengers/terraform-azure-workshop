```hc
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = ">2.0.0"
  features {}
}
```

```bash
tf init
tf console
"${var.resource_grouop_name}"
var.resource_group_name
var.location_list[0]
exit
```

### tf plan out parameter
```bash
tf plan --out tf.out
tf apply tf.out
tf plan --out tf.out
tf show
tf destroy 
ls -lartgit st
```


```bash
brew install graphviz
terraform graph | dot -Tsvg > graph.svg

```

Convert to terraform.tfvars
```hc
resource_group_name="westeurope"
```


