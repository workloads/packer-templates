provider "digitalocean" {}

# create an Azure Resource Group for use with Packer
# see https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/ssh_key
resource "digitalocean_ssh_key" "packer" {
  name       = "${var.ssh_key_name}-${random_string.string.id}"
  public_key = file(pathexpand(var.ssh_key_public_key_path))
}
