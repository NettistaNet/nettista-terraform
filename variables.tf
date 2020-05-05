variable "ssh_private_key" {
  description = "Private Key to access the machines"
  default     = "../keys/nodes.key"
}

variable "ssh_public_key" {
  description = "Public Key to authorized the access for the machines"
  default     = "../keys/nodes.key.pub"
}

variable "node_count" {
  default = 5
}

variable "node_image" {
  description = "Predefined Image that will be used to spin up the machines (Currently supported: ubuntu-16.04, debian-9,centos-7,fedora-27)"
  default     = "ubuntu-18.04"
}

variable "node_type" {
  description = "For more types have a look at https://www.hetzner.de/cloud"
  default     = "cx21"
}

variable "node_location" {
  description = "Default location is nbg1. Other available locations are fsn1 and hel1"
  default = "nbg1"
}
