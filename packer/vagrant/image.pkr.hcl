packer {
  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#version-constraint-syntax
  required_version = ">= 1.7.2"

  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#specifying-plugin-requirements
  required_plugins {
    # see https://github.com/hashicorp/packer-plugin-vagrant/releases/
    vagrant = {
      version = "0.0.3"
      source  = "github.com/hashicorp/vagrant"
    }

    # see https://github.com/hashicorp/packer-plugin-ansible/releases/
    ansible = {
      version = "0.0.2"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

# see https://www.packer.io/docs/builders/vagrant
source "vagrant" "image" {
  # the following configuration represents a curated variable selection
  # for all options see: https://www.packer.io/docs/builders/vagrant
  add_force                    = var.add_force
  box_name                     = local.box_name
  box_version                  = var.box_version
  communicator                 = var.shared.communicator.type
  output_dir                   = var.output_dir
  provider                     = var.provider
  skip_add                     = var.skip_add
  source_path                  = var.source_path
  ssh_clear_authorized_keys    = var.shared.communicator.ssh_clear_authorized_keys
  ssh_disable_agent_forwarding = var.shared.communicator.ssh_disable_agent_forwarding
  teardown_method              = var.teardown_method
  template                     = var.template
}

# see https://www.packer.io/docs/builders/file
source "file" "image_configuration" {
  content = templatefile(var.shared.templates.configuration, {
    timestamp     = formatdate(var.shared.image_version_date_format, timestamp())
    configuration = yamlencode(var.shared)
  })

  target = var.shared.generated_files.configuration
}

# see https://www.packer.io/docs/builders/file
source "file" "version_description" {
  content = local.version_description
  target  = var.shared.generated_files.versions
}

build {
  name = "templates"

  sources = [
    "source.file.image_configuration",
    "source.file.version_description"
  ]
}

build {
  name = "provisioners"

  sources = [
    "source.vagrant.image"
  ]

  # see https://www.packer.io/docs/provisioners/ansible
  provisioner "ansible" {
    ansible_env_vars = var.shared.ansible.ansible_env_vars
    command          = var.shared.ansible.command
    extra_arguments  = local.ansible_extra_arguments
    galaxy_file      = var.shared.ansible.galaxy_file
    playbook_file    = var.shared.ansible.playbook_file
  }

  # see https://www.packer.io/docs/provisioners/inspec
  #provisioner "inspec" {
  #  attributes           = var.shared.inspec.attributes
  #  attributes_directory = var.shared.inspec.attributes_directory
  #  backend              = var.shared.inspec.backend
  #  command              = var.shared.inspec.command
  #  inspec_env_vars      = var.shared.inspec.inspec_env_vars
  #  profile              = var.shared.inspec.profile
  #  user                 = var.shared.inspec.user
  #}

  # see https://www.packer.io/docs/post-processors/vagrant-cloud
  post-processor "vagrant-cloud" {
    box_tag             = local.box_tag
    no_release          = var.no_release
    version             = local.box_version
    version_description = local.version_description
  }

  # see https://www.packer.io/docs/post-processors/checksum#checksum-post-processor
  post-processor "checksum" {
    checksum_types = var.shared.checksum_types
    output         = var.shared.checksum_output
  }
}
