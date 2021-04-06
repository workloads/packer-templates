# see https://www.packer.io/docs/templates/hcl_templates/blocks/packer
packer {
  required_version = ">= 1.7.1"
}

# see https://www.packer.io/docs/builders/azure/arm
source "azure-arm" "image" {
  # the following configuration represents a minimally viable selection
  # for all options see: https://www.packer.io/docs/builders/azure/arm

  # TODO: add support for azure_tags
  azure_tags = {}

  cloud_environment_name = var.cloud_environment_name

  # cloud-init configuration
  custom_data_file = var.custom_data_file

  # base image
  image_offer     = var.image_offer
  image_publisher = var.image_publisher
  image_sku       = var.image_sku
  image_version   = var.image_version

  location = var.location

  # artifact configuration
  managed_image_name                = local.managed_image_name_full
  managed_image_resource_group_name = var.managed_image_resource_group_name

  os_type = var.os_type

  ssh_clear_authorized_keys = var.ssh_clear_authorized_keys

  # authentication with `az` CLI supplied credentials
  use_azure_cli_auth = var.use_azure_cli_auth

  # authentication with explicitly defined credentials
  # NOTE: to use this section, disable the `use_azure_cli_auth` property and
  # NOTE: enable the `subscription_id`, `client_id`, and `client_secret` properties
  # subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret

  vm_size = var.vm_size
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
    "source.file.version_description"
  ]
}

build {
  sources = [
    "source.azure-arm.image"
  ]

  # see https://www.packer.io/docs/provisioners/ansible
  provisioner "ansible" {
    ansible_env_vars = var.build_config.ansible_env_vars
    playbook_file    = var.build_config.playbook_file
    command          = var.build_config.command
    extra_arguments  = var.build_config.extra_arguments
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
}
