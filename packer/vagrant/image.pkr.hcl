# see https://www.packer.io/docs/templates/hcl_templates/blocks/packer
packer {
  required_version = ">= 1.7.0"
}

# see https://www.packer.io/docs/builders/vagrant
source "vagrant" "image" {
  # the following configuration represents a minimally viable selection
  # for all options see: https://www.packer.io/docs/builders/vagrant
  add_force       = var.add_force
  box_name        = local.box_name
  box_version     = var.box_version
  communicator    = var.communicator
  output_dir      = var.output_dir
  provider        = var.provider
  skip_add        = var.skip_add
  source_path     = var.source_path
  teardown_method = var.teardown_method
  template        = var.template
}

# see https://www.packer.io/docs/builders/file
source "file" "image_configuration" {
  content = yamlencode(var.build_config)
  target  = "ansible/playbooks/vars/generated_configuration.yml"
}

build {
  sources = ["source.file.image_configuration"]
}

build {
  sources = [
    "source.vagrant.image"
  ]

  # see https://www.packer.io/docs/provisioners/ansible
  provisioner "ansible" {
    playbook_file    = "./ansible/playbooks/main.yml"
    command          = "ansible-playbook"
    ansible_env_vars = var.build_config.ansible_env_vars
  }

  # uncomment this stanza to build images for Vagrant Cloud
  # see https://www.packer.io/docs/post-processors/vagrant-cloud
  #post-processor "vagrant-cloud" {
  # TODO: add better support for Vagrant Cloud
  #  box_tag    = local.box_tag
  #  no_release = var.no_release
  #  version    = var.box_version
  #  version_description = local.version_description
  #}
}
