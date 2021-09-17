# Create NSG for OneBox VM
resource "azurerm_network_security_group" "onebox" {
  name                = var.onebox_nsg_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.allowed_src_ip
    destination_address_prefix = azurerm_network_interface.eth0.private_ip_address
  }

  security_rule {
    name                       = "Console"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_ranges    = [8081,8083,8084]
    source_address_prefix      = "${var.AllowedSourceIPRange}"
    destination_address_prefix = azurerm_network_interface.eth0.private_ip_address
  }

  tags = local.common_tags
}

resource "azurerm_network_interface_security_group_association" "onebox" {
  network_interface_id      = azurerm_network_interface.eth0.id
  network_security_group_id = azurerm_network_security_group.onebox.id
}
