variable "resource_group_name" {}

variable "location" {}

variable "adminUsername" {}

variable "adminPassword" {}

variable "allowed_src_ip" {}

variable "virtualNetworkName" {
    default = "onebox-vnet"
}

variable "virtualNetworkCIDR" {
    default = ["172.16.0.0/23"]
}

variable "subnetName" {
    default = "onebox-subnet"
}

variable "subnetCIDR" {
    default = ["172.16.0.0/28"]
}

variable "vmName" {
    default = "onebox"
}

variable "vmSize" {}

variable "onebox_nsg_name" {
    default = "onebox-nsg"
}

variable "dns_label_prefix" {
    default = "onebox-pip"
}

variable "twistlock_download_url" {}

variable "license_key" {}
