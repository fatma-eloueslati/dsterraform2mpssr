provider "azurerm" {
  subscription_id = "..."
  client_id       = "..."
  client_secret   = "..."
  tenant_id       = "..."
}


resource "azurerm_resource_group" "test" {
  name     = "HelloWorld"
  location = var.location
}

resource "azurerm_virtual_network" "test" {
  name                = "test"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_subnet" "test" {
  name                 = "test"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_subnet" "test2" {
  name                 = "test2"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefix       = "10.0.3.0/24"
}

resource "azurerm_subnet" "test3" {
  name                 = "test3"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefix       = "10.0.4.0/24"
}

resource "azurerm_network_interface" "test" {
  name                = "test"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_network_interface" "test2" {
  name                = "test2"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = azurerm_subnet.test2.id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_network_interface" "test3" {
  name                = "test3"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
  ip_configuration {
    name                          = "testconfiguration3"
    subnet_id                     = azurerm_subnet.test3.id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_storage_account" "test" {
  name                = "helloworld25662"
  resource_group_name = azurerm_resource_group.test.name
  location            = var.location
  account_type        = "Standard_LRS"
}

resource "azurerm_storage_container" "test" {
  name                  = "helloworld"
  resource_group_name   = azurerm_resource_group.test.name
  storage_account_name  = azurerm_storage_account.test.name
  container_access_type = "private"
}

resource "azurerm_virtual_machine" "test" {
  name                  = "helloworld"
  location              = var.location
  resource_group_name   = azurerm_resource_group.test.name
  network_interface_ids = ["${azurerm_network_interface.test.id}"]
  vm_size               = "Standard_A0"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Nano-Server-Technical-Preview"
    version   = "latest"
  }

  storage_os_disk {
    name          = "myosdisk1"
    vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/myosdisk1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "helloworld"
    admin_username = var.username
    admin_password = var.password
  }
}

resource "azurerm_virtual_machine" "test2" {
  name                  = "helloworld2"
  location              = var.location
  resource_group_name   = azurerm_resource_group.test.name
  network_interface_ids = ["${azurerm_network_interface.test2.id}"]
  vm_size               = "Standard_A0"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Nano-Server-Technical-Preview"
    version   = "latest"
  }

  storage_os_disk {
    name          = "myosdisk2"
    vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/myosdisk2.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "helloworld2"
    admin_username = var.username
    admin_password = var.password
  }
}

resource "azurerm_virtual_machine" "test3" {
  name                  = "helloworld3"
  location              = var.location
  resource_group_name   = azurerm_resource_group.test.name
  network_interface_ids = ["${azurerm_network_interface.test3.id}"]
  vm_size               = "Standard_A1"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Nano-Server-Technical-Preview"
    version   = "latest"
  }

  storage_os_disk {
    name          = "myosdisk3"
    vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/myosdisk3.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "helloworld3"
    admin_username = var.username
    admin_password = var.password
  }
}
