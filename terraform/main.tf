variable "tenant_id" {}
variable "subscription_id" {}
variable "name" {}
variable "location" {}
variable "env" {}

provider "azurerm" {
  features {}
}

module "app" {
  source   = "./modules/spring-react-app"
  name     = var.name
  env      = var.env
  location = var.location
}