
![PNG LOGO](https://github.com/user-attachments/assets/e0fba218-6059-4c69-9d46-c9354e392b93)
#                              🔐 Azure Key Vault Deployment

This repository contains infrastructure-as-code (IaC) templates and instructions to deploy:

1. A **simple Azure Key Vault**
2. An **Azure Key Vault with Private Endpoint** integration for enhanced security

---

## 📦 Components

| Feature                      | Simple Key Vault | Key Vault with Private Endpoint |
|-----------------------------|------------------|----------------------------------|
| Azure Key Vault             | ✅               | ✅                               |
| Private Endpoint            | ❌               | ✅                               |
| Network Interface/NSG       | ❌               | ✅                               |
| Private DNS Zone (optional) | ❌               | ✅                               |

---

## 🧰 Prerequisites

- Azure Subscription
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://developer.hashicorp.com/terraform/install) (optional)
- Service Principal or User with appropriate RBAC permissions

---

## 🚀 Deploy Simple Azure Key Vault

### 🔹 Using Azure CLI

```bash
# Variables
RESOURCE_GROUP="rg-keyvault-simple"
LOCATION="canadaeast"
KEYVAULT_NAME="kv-simple-001"

# Create resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Deploy Key Vault
az keyvault create \
  --name $KEYVAULT_NAME \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku standard \
  --enable-soft-delete true
