# create a resource group if it doesn't exist
resource "azurerm_resource_group" "k8s" {
  name     = "${var.terraform_azure_resource_group}"
  location = "${var.terraform_azure_region}"
}

data "azurerm_key_vault_secret" "spsecret" {
  name      = "secret-sp"
  vault_uri = "${var.terraform_key_vault_uri}"
}

data "azurerm_key_vault_secret" "akskey" {
  name      = "linuxrsa"
  vault_uri = "${var.terraform_key_vault_uri}"
}

# create azure container service (aks)
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${var.terrafform_aks_name}"
  location            = "${azurerm_resource_group.k8s.location}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
  dns_prefix          = "${var.terrafform_aks_name}"
  kubernetes_version  = "${var.terraform_aks_kubernetes_version}"

  agent_pool_profile {
    name    = "agentpool"
    count   = "${var.terraform_aks_agent_vm_count}"
    vm_size = "${var.terraform_aks_vm_size}"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }
  
    linux_profile {
    admin_username = "${var.terraform_azure_admin_name}"
    ssh_key {
      key_data = "${data.azurerm_key_vault_secret.akskey.value}"
    }
  }
   
  service_principal {
    client_id     = "${var.terraform_azure_service_principal_client_id}"
    client_secret = "${data.azurerm_key_vault_secret.spsecret.value}"
  }
  
   tags {
        Environment = "Development"
    }
}