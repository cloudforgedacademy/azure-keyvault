data "azurerm_subnet" "exisitng_subnet" {
  name                 = ""
  virtual_network_name = ""
  resource_group_name  = ""
}

data "azurerm_private_dns_zone" "vault" {
  name                = ""
  resource_group_name = ""
}