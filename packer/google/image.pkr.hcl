packer {
  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#version-constraint-syntax
  required_version = ">= 1.7.4"

  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#specifying-plugin-requirements
  required_plugins {
    # see https://github.com/hashicorp/packer-plugin-googlecompute/releases/
    googlecompute = {
      version = "0.0.2"
      source  = "github.com/hashicorp/googlecompute"
    }

    # see https://github.com/hashicorp/packer-plugin-ansible/releases/
    ansible = {
      version = "0.0.2"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

# see https://www.packer.io/docs/builders/googlecompute
source "googlecompute" "image" {
  # the following configuration represents a curated variable selection
  # for all options see: https://www.packer.io/docs/builders/googlecompute
  communicator                 = var.shared.communicator.type
  disk_name                    = var.disk_name
  disk_size                    = var.disk_size
  disk_type                    = var.disk_type
  project_id                   = var.project_id
  enable_secure_boot           = var.enable_secure_boot
  enable_vtpm                  = var.enable_vtpm
  enable_integrity_monitoring  = var.enable_integrity_monitoring
  image_name                   = var.image_name
  image_description            = var.image_information
  image_labels                 = local.image_labels
  image_licenses               = var.image_licenses
  image_storage_locations      = var.image_storage_locations
  machine_type                 = var.machine_type
  min_cpu_platform             = var.min_cpu_platform
  network                      = var.network
  omit_external_ip             = var.omit_external_ip
  preemptible                  = var.preemptible
  scopes                       = var.scopes
  skip_create_image            = var.skip_create_image
  ssh_clear_authorized_keys    = var.shared.communicator.ssh_clear_authorized_keys
  ssh_disable_agent_forwarding = var.shared.communicator.ssh_disable_agent_forwarding
  ssh_username                 = var.shared.communicator.ssh_username
  source_image                 = var.source_image
  region                       = var.region
  use_internal_ip              = var.use_internal_ip
  zone                         = var.zone
}

# see https://www.packer.io/docs/builders/file
source "file" "image_configuration" {
  content = templatefile(var.shared.templates.configuration, {
    timestamp     = formatdate(var.shared.image_information_date_format, timestamp())
    configuration = yamlencode(var.shared)
  })

  target = var.shared.generated_files.configuration
}

# see https://www.packer.io/docs/builders/file
#source "file" "image_information" {
#  content = local.version_description
#  target  = var.shared.generated_files.versions
#}

# see https://www.packer.io/docs/builders/file
source "file" "image_information" {
  content = local.version_description
  target  = local.version_description_filename
}

build {
  name = "templates"

  sources = [
    "source.file.image_configuration",
    #"source.file.image_information"
  ]
}

build {
  name = "provisioners"

  sources = [
    "source.googlecompute.image"
  ]

  # see https://www.packer.io/docs/provisioners/ansible
  //  provisioner "ansible" {
  //    ansible_env_vars = var.shared.ansible.ansible_env_vars
  //    command          = var.shared.ansible.command
  //    #extra_arguments  = local.ansible_extra_arguments
  //    galaxy_file   = var.shared.ansible.galaxy_file
  //    playbook_file = var.shared.ansible.playbook_file
  //  }

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
}
