packer {
  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#version-constraint-syntax
  required_version = ">= 1.7.2"

  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#specifying-plugin-requirements
  required_plugins {
    # see https://github.com/hashicorp/packer-plugin-azure/releases/
    //    azure = {
    //      version = "0.0.1"
    //      source  = "github.com/hashicorp/azure"
    //    }

    # see https://github.com/hashicorp/packer-plugin-ansible/releases/
    ansible = {
      version = "0.0.2"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

# see https://www.packer.io/docs/builders/azure/arm
source "azure-arm" "image" {
  # the following configuration represents a curated variable selection
  # for all options see: https://www.packer.io/docs/builders/azure/arm

  # TODO: add support for azure_tags
  azure_tags = {}

  cloud_environment_name            = var.cloud_environment_name
  communicator                      = var.shared.communicator.type
  custom_data_file                  = var.custom_data_file
  image_offer                       = var.image_offer
  image_publisher                   = var.image_publisher
  image_sku                         = var.image_sku
  image_version                     = var.image_version
  location                          = var.location
  managed_image_name                = local.managed_image_name_full
  managed_image_resource_group_name = var.managed_image_resource_group_name
  os_type                           = var.os_type
  ssh_clear_authorized_keys         = var.shared.communicator.ssh_clear_authorized_keys
  ssh_disable_agent_forwarding      = var.shared.communicator.ssh_disable_agent_forwarding

  # authentication with `az` CLI supplied credentials
  use_azure_cli_auth = var.use_azure_cli_auth

  # authentication with explicitly defined credentials
  # to use this section, disable the `use_azure_cli_auth` property and
  # enable the `subscription_id`, `client_id`, and `client_secret` properties
  # subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret

  vm_size = var.vm_size
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
  content = local.managed_image_version
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
    "source.azure-arm.image"
  ]

  # see https://www.packer.io/docs/provisioners/ansible
  provisioner "ansible" {
    ansible_env_vars = var.shared.ansible.ansible_env_vars
    command          = var.shared.ansible.command
    extra_arguments  = local.ansible_extra_arguments
    galaxy_file      = var.shared.ansible.galaxy_file
    playbook_file    = var.shared.ansible.playbook_file
  }

  # carry out deprovisioning steps: https://www.packer.io/docs/builders/azure/arm#linux
  # for information on the Azure Linux Guest Agent, see https://github.com/Azure/WALinuxAgent
  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"

    inline = [
      "/usr/sbin/waagent -force -deprovision+user",
      "sync"
    ]

    inline_shebang = "/bin/sh -x"
  }

  # see https://www.packer.io/docs/post-processors/checksum#checksum-post-processor
  post-processor "checksum" {
    checksum_types = var.shared.checksum_types
    output         = var.shared.checksum_output
  }
}
