# see https://www.packer.io/docs/templates/hcl_templates/blocks/packer
packer {
  required_version = ">= 1.7.0"
}

# see https://www.packer.io/docs/builders/vagrant
source "vagrant" "image" {
  # the following configuration represents a minimally viable selection
  # for all options see: https://www.packer.io/docs/builders/vagrant

  communicator = "ssh"
  source_path  = var.source_path
  provider     = "virtualbox"
  add_force    = true
  output_dir   = "vagrant-nomad"
}

build {
  sources = [
    "source.vagrant.image"
  ]

  provisioner "ansible" {
    playbook_file    = "./ansible/playbooks/main.yml"
    command          = "ansible-playbook"
    ansible_env_vars = var.shared_ansible_env_vars
  }

  # uncomment this stanza to build images for Vagrant Cloud
  # see https://www.packer.io/docs/post-processors/vagrant-cloud
  #post-processor "vagrant-cloud" {
  # TODO: add better support for Vagrant Cloud
  #  box_tag = var.box_tag
  #  version = var.version
  #}
}
