# see https://www.packer.io/docs/templates/hcl_templates/blocks/packer
packer {
  required_version = ">= 1.7.0"
}

# see https://www.packer.io/docs/builders/vagrant
source "vagrant" "image" {
  # the following configuration represents a minimally viable selection
  # for all options see: https://www.packer.io/docs/builders/vagrant
  add_force       = var.add_force
  box_name        = var.box_name
  box_version     = var.box_version
  output_dir      = var.output_dir
  communicator    = "ssh"
  provider        = var.provider
  skip_add        = var.skip_add
  source_path     = var.source_path
  teardown_method = var.teardown_method
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
  #  version = var.box_version
  #}
}
