
output "OneBox_URL" {
  value = "Access the Console via:  https://${azurerm_linux_virtual_machine.onebox.public_ip_address}:8083"
}
