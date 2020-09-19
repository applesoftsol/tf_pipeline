resource "azurerm_resource_group" "example" {
  name     = "nsgrg1"
  location = "West US"
}

resource "azurerm_network_security_group" "example" {
  name                = "nsg100"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_virtual_network" "example" {
  name                = "virtualNetwork1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["11.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "11.0.1.0/24"
    security_group = azurerm_network_security_group.example.id
  }

  subnet {
    name           = "subnet2"
    address_prefix = "11.0.2.0/24"
    security_group = azurerm_network_security_group.example.id
  }

  subnet {
    name           = "subnet3"
    address_prefix = "11.0.3.0/24"
    security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "Production"
  }
}