packer {
  required_version = ">= 1.7.0"
}

# see https://www.packer.io/docs/builders/azure/arm
source "azure-arm" "nomad" {
  # the following configuration represents a minimally viable selection
  # for all options see: https://www.packer.io/docs/builders/azure/arm

  # authentication with `az` CLI supplied credentials
  use_azure_cli_auth = true

  # authentication with explicitly defined credentials
  # NOTE: to use this section, disable the `use_azure_cli_auth` property and
  # NOTE: enable the `subscription_id`, `client_id`, and `client_secret` properties
  # subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret

  # base image
  image_publisher = var.image_publisher
  image_offer     = var.image_offer
  image_sku       = var.image_sku

  # capture machine configuration
  location = var.location
  vm_size  = var.vm_size
  os_type  = var.os_type

  # artifact configuration
  managed_image_resource_group_name = var.managed_image_resource_group_name
  managed_image_name                = local.managed_image_name
}

build {
  sources = [
    "source.azure-arm.nomad"
  ]

  provisioner "ansible" {
    playbook_file = "./playbooks/main.yml"
    command       = "ansible-playbook"

    ansible_env_vars = [
      "ANSIBLE_NOCOWS=True"
    ]
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
