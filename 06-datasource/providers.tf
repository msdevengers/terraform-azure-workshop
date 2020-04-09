#export TF_CLI_CONFIG_FILE=$PWD/terraform.rc
#export TF_LOG=TRACE
#export TF_LOG_PATH=./terraform.log

provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.0.0"
  features {}
}
