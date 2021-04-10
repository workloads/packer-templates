# This file is automatically loaded by Packer

# If you do not wish to use credentials supplied through the `az` CLI, set `use_azure_cli_auth` to false
# and enable the variables for `subscription_id`, `client_id`, and `client_secret`
# Then, move `credentials.auto.pkrvars.hcl.sample` to `azure-credentials.auto.pkrvars.hcl` and populate it.

# see https://www.packer.io/docs/builders/azure/arm#subscription_id
#variable "subscription_id" {
#  type        = string
#  description = "Subscription under which the build will be performed."
#}

# see https://www.packer.io/docs/builders/azure/arm#client_id
#variable "client_id" {
#  type        = string
#  description = "The Active Directory service principal associated with your builder."
#}

# see https://www.packer.io/docs/builders/azure/arm#client_secret
#variable "client_secret" {
#  type        = string
#  description = "The password or secret for your service principal."
#
#  # sensitive values are hidden from outputs
#  sensitive = true
#}

# see https://www.packer.io/docs/builders/azure/arm#azure_tags
variable "azure_tags" {
  type        = map(string)
  description = "Name/value pair tags to apply to every resource deployed."
  default     = {}
}

variable "build_config" {
  type = object({
    ansible = object({
      ansible_env_vars = list(string)
      command          = string
      extra_arguments  = list(string)
      galaxy_file      = string
      playbook_file    = string
    })

    apt_repos = map(string)

    generated_files = object({
      configuration = string
      versions      = string
    })

    image_version_date_format = string

    inspec = object({
      attributes           = list(string)
      attributes_directory = string
      backend              = string
      command              = string
      inspec_env_vars      = list(string)
      profile              = string
      user                 = string
    })

    name = string

    packages = object({
      docker = list(object({
        name    = string
        version = string
      }))

      hashicorp = list(object({
        name    = string
        version = string
      }))

      hashicorp_nomad_plugins = list(object({
        name    = string
        version = string
      }))

      podman = list(object({
        name    = string
        version = string
      }))

      to_install = list(string)
      to_remove  = list(string)
    })

    templates = object({
      configuration = string
      versions      = string
    })

    toggles = object({
      enable_debug_statements = bool
      enable_docker           = bool
      enable_hashicorp        = bool
      enable_os               = bool
      enable_podman           = bool

      docker            = map(bool)
      hashicorp         = map(bool)
      hashicorp_enabled = map(bool)
      misc              = map(bool)
      os                = map(bool)
      podman            = map(bool)
    })
  })

  description = "Shared Configuration for all Images"

  # The default for this is specified in ./packer/_shared/shared.pkrvars.hcl
}

# see https://www.packer.io/docs/builders/azure/arm#cloud_environment_name
variable "cloud_environment_name" {
  type        = string
  description = "Specify a Cloud Environment Name."
  default     = "Public"
}

# see https://www.packer.io/docs/builders/azure/arm#custom_data_file
variable "custom_data_file" {
  type        = string
  description = "Specify a file containing custom data to inject into the cloud-init process."
  default     = ""
}

# see https://www.packer.io/docs/builders/azure/arm#image_publisher
variable "image_publisher" {
  type        = string
  description = "Name of the publisher to use for your base image."
  default     = "Canonical"
}

# see https://www.packer.io/docs/builders/azure/arm#image_offer
variable "image_offer" {
  type        = string
  description = "Name of the publisher's offer to use for your base image."
  default     = "0001-com-ubuntu-server-focal"
}

# see https://www.packer.io/docs/builders/azure/arm#image_sku
variable "image_sku" {
  type        = string
  description = "SKU of the image offer to use for your base image."
  default     = "20_04-lts"
}

# see https://www.packer.io/docs/builders/azure/arm#image_version
variable "image_version" {
  type        = string
  description = "Specify a specific version of an OS to boot from."
  default     = "latest"
}

# see https://www.packer.io/docs/builders/azure/arm#location
variable "location" {
  type        = string
  description = "Azure datacenter in which your VM will build."

  # this value is set in `terraform-generated.auto.pkrvars.hcl`
}

# see https://www.packer.io/docs/builders/azure/arm#managed_image_name
variable "managed_image_name" {
  type        = string
  description = "Name to use for the image."
  default     = ""
}

variable "managed_image_version" {
  type        = string
  description = "Version to use for the image."
  default     = ""
}

# see https://www.packer.io/docs/builders/azure/arm#ssh_clear_authorized_keys
variable "ssh_clear_authorized_keys" {
  type        = bool
  description = "If true, Packer will attempt to remove its temporary key from the image."
  default     = true
}

# see https://www.packer.io/docs/builders/azure/arm#vm_size
variable "vm_size" {
  type        = string
  description = "Size of the VM used for building."
  default     = "Standard_A1"
}

# see https://www.packer.io/docs/builders/azure/arm#managed_image_resource_group_name
variable "managed_image_resource_group_name" {
  type        = string
  description = "Resource group under which the final artifact will be stored."

  # this value is set in `terraform-generated.auto.pkrvars.hcl`
}

# see https://www.packer.io/docs/builders/azure/arm#os_type
variable "os_type" {
  type        = string
  description = "OS Type to use for configuration of authentication credentials."
  default     = "Linux"
}

# see https://www.packer.io/docs/builders/azure/arm#use_azure_cli_auth
variable "use_azure_cli_auth" {
  type        = bool
  description = "Flag to use Azure CLI authentication."
  default     = true
}

locals {
  # set `azure_tags` to generated value, unless it is user-specified
  //  generated_azure_tags =
  //  azure_tags = var.azure_tags == {} ? local.generated_azure_tags : var.azure_tags

  # set `image_name_prefix` to shared value, unless it is user-specified
  managed_image_name = var.managed_image_name == "" ? var.build_config.name : var.managed_image_name

  # set `image_version` to generated value, unless it is user-defined
  managed_image_version = var.managed_image_version == "" ? formatdate(var.build_config.image_version_date_format, timestamp()) : var.managed_image_version

  managed_image_name_full = "${local.managed_image_name}-${local.managed_image_version}"
}
