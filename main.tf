# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {}
variable "cluster_base_path" {}

terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.32.2"
    }
  }
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = "${var.hcloud_token}"
}

resource "hcloud_ssh_key" "node_admin" {
  name       = "node_admin"
  public_key = "${file(var.ssh_public_key)}"
}

resource "hcloud_server" "nodes" {
  count       = "${var.node_count}"
  name        = "node${count.index + 1}"
  server_type = "${var.node_type}"
  image       = "${var.node_image}"
  ssh_keys    = ["${hcloud_ssh_key.node_admin.id}"]
  location    = "${var.node_location}"

  connection {
    private_key = "${file(var.ssh_private_key)}"
  } 
}

data "template_file" "bootstrap_data" {
  template = "${file("${path.module}/templates/bootstrap_data.tpl")}"
  count = "${var.node_count}"
  vars = {
    vpn_host = "${element(hcloud_server.nodes.*.ipv4_address, count.index)}"
  }
}

data "template_file" "bootstrap_hosts" {
  template = "${file("${path.module}/templates/bootstrap_hosts.tpl")}"
  vars = {
    value = "${join("\n",data.template_file.bootstrap_data.*.rendered)}"
  }
}
data "template_file" "k8s_hosts" {
  template = "${file("${path.module}/templates/k8s_hosts.tpl")}"
  vars = {
    value = "${join("\n",data.template_file.bootstrap_data.*.rendered)}"
  }
}

resource "local_file" "hosts_ini" {
    content  = "${data.template_file.bootstrap_hosts.rendered}"
    filename = "${var.cluster_base_path}/tf/hosts.ini"
}
