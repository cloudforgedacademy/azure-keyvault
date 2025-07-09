resource "azurerm_resource_group" "rg01" {
  name     = var.rgname01
  location = var.rglocation01
  tags     = var.tags
}


data "azurerm_client_config" "current" {}

data "azuread_user" "user1" {
  user_principal_name = var.user1
}

data "azuread_user" "user2" {
  user_principal_name = var.user2
}


resource "azurerm_key_vault" "kvt1" {
  name                          = var.kvt1
  location                      = var.rglocation01
  resource_group_name           = azurerm_resource_group.rg01.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days    = 90
  purge_protection_enabled      = false
  sku_name                      = "standard"
  public_network_access_enabled = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id


    key_permissions = [
      "List",
      "Create",
      "Delete",
      "Get",
      "Recover",
      "Update",
    ]

    secret_permissions = [
      "List",
      "Set",
      "Delete",
      "Get",
    ]

    certificate_permissions = [
      "List",
      "Import",
      "Create",
      "Delete",
      "Get",
    ]

    storage_permissions = [
      "Get",
      "List",
      "Set",
    ]
  }
  #accesspolicy for user1
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azuread_user.user1.object_id

    key_permissions = [
      "List",
      "Create",
      "Delete",
      "Get",
      "Recover",
      "Update",
    ]

    secret_permissions = [
      "List",
      "Set",
      "Delete",
      "Get",
    ]

    certificate_permissions = [
      "List",
      "Import",
      "Create",
      "Delete",
      "Get",
    ]

    storage_permissions = [
      "Get",
      "List",
      "Set",
    ]

  }

  #accesspolicy for user2
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azuread_user.user2.object_id

    key_permissions = [
      "List",
      "Create",
      "Delete",
      "Get",
      "Recover",
      "Update",
    ]

    secret_permissions = [
      "List",
      "Set",
      "Delete",
      "Get",
    ]

    certificate_permissions = [
      "List",
      "Import",
      "Create",
      "Delete",
      "Get",
    ]

    storage_permissions = [
      "Get",
      "List",
      "Set",
    ]

  }



  #accesspolicy for user3
  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = data.azuread_user.user3.object_id

  #   key_permissions = [
  #     "List",
  #     "Create",
  #     "Delete",
  #     "Get",
  #     "Recover",
  #     "Update",
  #   ]

  #   secret_permissions = [
  #     "List",
  #     "Set",
  #     "Delete",
  #     "Get",
  #   ]

  #   certificate_permissions = [
  #     "List",
  #     "Import",
  #     "Create",
  #     "Delete",
  #     "Get",
  #   ]

  #   storage_permissions = [
  #     "Get",
  #     "List",
  #     "Set",
  #   ]

  # }

  tags = var.tags
}




// PRIVATE ENDPOINT

resource "azurerm_private_endpoint" "private-endpoint" {
  name                = var.pepname
  location            = var.rglocation01
  resource_group_name = var.rgname01
  subnet_id           = data.azurerm_subnet.exisitng_subnet.id

  private_service_connection {
    name                           = var.pep_connection_name
    private_connection_resource_id = azurerm_key_vault.kvt1.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "privatelink.vaultcore.azure.net"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.vault.id]
  }
  tags = var.tags


}



  