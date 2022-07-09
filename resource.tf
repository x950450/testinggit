resource "azurerm_resource_group" "resourceg" {
  name     = var.resourcegroup
  location = var.location
}

resource "azurerm_storage_account" "azuresa1" {
  count = "${var.env == "prod" ? 3:1}"
  name                     = "sujeeshstorageioiusj${count.index}"
  resource_group_name      = azurerm_resource_group.resourceg.name
  location                 = azurerm_resource_group.resourceg.location
  account_tier             = var.accountt
  account_replication_type = var.accountreplicationtype

}

# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "mynet"
    address_space       = ["10.1.0.0/16"]
    location                 = azurerm_resource_group.resourceg.location
    resource_group_name      = azurerm_resource_group.resourceg.name

}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
    count = length(var.cidrs)
    name                 = "mysubnet${count.index+1}"
    resource_group_name      = azurerm_resource_group.resourceg.name
    virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
    address_prefixes       = ["${element(var.cidrs, count.index)}"]
}

terraform {
  backend "azurerm" {
    resource_group_name   = "Terraform001"
    storage_account_name  = "terraformstracc007"
    container_name        = "tstate"
    key                   = "terraform.tfstate"
  }
}




#---------------------------------------------------------
# https://gist.github.com/devops-school/1f3efed15d390748b208a109f9765e0c
# Use Case of for_each
variable "account_name" {
   type = "map"
  default = {
      "account1" = "devops1"
      "account2" = "devops2"
      "account3" = "devops3"
}
}

resource "aws_iam_user" "iamuser" {
  for_each = var.account_name
  name = "${each.value}-iam"
}
