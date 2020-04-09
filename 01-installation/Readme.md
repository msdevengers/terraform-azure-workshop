#### Macos Installation

In this workshop we will use terraform 12. Syntax is changed from 11 to 12. Be careful with quotation marks

```bash
mkdir -p ~/dev/tools/hashicorp/terraform
cd ~/dev/tools/hashicorp/terraform
wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_darwin_amd64.zip
unzip terraform_0.12.24_darwin_amd64.zip
chmod +x terraform
echo 'export PATH=$PATH:~/dev/tools/hashicorp/terraform' >> ~/.bash_profile
echo 'alias terraform=tf' >> ~/.bash_profile
source ~/.bash_profile
```

#### Linux Installation
```bash
mkdir -p ~/dev/tools/hashicorp/terraform
cd ~/dev/tools/hashicorp/terraform
wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
unzip terraform_0.12.24_linux_amd64.zip
chmod +x terraform
echo 'export PATH=$PATH:~/dev/tools/hashicorp/terraform' >> ~/.bashrc
echo 'alias tf=terraform' >> ~/.bashrc
source ~/.bashrc
```

#### Install VS Code and its extensions
```
https://vscode-docs.readthedocs.io/en/stable/editor/setup/
Install Terraform Support to VS Code
Install Language Support Server for Terraform
```

```
https://releases.hashicorp.com/terraform-provider-azurerm/
```

```bash
terraform -install-autocomplete
terraform -uninstall-autocomplete
```

#### Environtment variables
https://www.terraform.io/docs/commands/environment-variables.html
```bash
export TF_CLI_CONFIG_FILE=$PWD/terraform.rc
export TF_LOG=TRACE
export TF_LOG_PATH=./terraform.log
```