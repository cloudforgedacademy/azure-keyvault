data "azurerm_resource_group" "rg01" {
  name = var.rgname01
}


data "azurerm_client_config" "current" {}

data "azuread_user" "user2" {
  user_principal_name = var.user2
}

resource "azurerm_key_vault" "kvt1" {
  name                          = var.kvt1
  location                      = var.rglocation01
  resource_group_name           = data.azurerm_resource_group.rg01.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days    = 90
  purge_protection_enabled      = false
  sku_name                      = "standard"
  public_network_access_enabled = true

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
    object_id = ""

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

  network_acls {
    default_action = "Deny"

    bypass   = "AzureServices"
    ip_rules = ["52.228.82.0/24"]
  }



  tags = var.tags
}