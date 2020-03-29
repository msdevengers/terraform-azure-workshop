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

  # azurerm_resource_group.pamir-rg will be created
  + resource "azurerm_resource_group" "pamir-rg" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "pamir-rg"
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

```bash
tf apply
az group list --output table | grep pamir
```


```bash
tf destroy
az group list --output table | grep pamir
```