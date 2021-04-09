# see https://www.packer.io/docs/templates/hcl_templates/blocks/packer
packer {
  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#version-constraint-syntax
  required_version = ">= 1.7.2"
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
  target  = var.build_config.generated_files.configuration
}

# see https://www.packer.io/docs/builders/file
source "file" "version_description" {
  content = local.version_description
  target  = var.build_config.generated_files.versions
}

build {
  sources = [
    "source.file.image_configuration",
    "source.file.version_description",
    "source.vagrant.image"
  ]

  # see https://www.packer.io/docs/provisioners/ansible
  provisioner "ansible" {
    ansible_env_vars = var.build_config.ansible.ansible_env_vars
    command          = var.build_config.ansible.command
    extra_arguments  = var.build_config.ansible.extra_arguments
    galaxy_file      = var.build_config.ansible.galaxy_file
    playbook_file    = var.build_config.ansible.playbook_file
  }

  #  # see https://www.packer.io/docs/provisioners/inspec
  #  provisioner "inspec" {
  #    attributes           = var.build_config.inspec.attributes
  #    attributes_directory = var.build_config.inspec.attributes_directory
  #    backend              = var.build_config.inspec.backend
  #    command              = var.build_config.inspec.command
  #    inspec_env_vars      = var.build_config.inspec.inspec_env_vars
  #    profile              = var.build_config.inspec.profile
  #    user                 = var.build_config.inspec.user
  #  }

  # uncomment this stanza to build images for Vagrant Cloud
  # see https://www.packer.io/docs/post-processors/vagrant-cloud
  #post-processor "vagrant-cloud" {
  #  box_tag             = local.box_tag
  #  no_release          = var.no_release
  #  version             = local.box_version
  #  version_description = file(var.build_config.generated_files.versions)
  #}
}
