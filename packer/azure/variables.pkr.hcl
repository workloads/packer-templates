# This file is automatically loaded by Packer

# If you do not wish to use credentials supplied through the `az` CLI, set `use_azure_cli_auth` to false
# and enable the variables for `subscription_id`, `client_id`, and `client_secret`
# Then, move `credentials.auto.pkrvars.hcl.sample` to `azure-credentials.auto.pkrvars.hcl` and populate it.

#variable "subscription_id" {
#  type = string
#}

#variable "client_id" {
#  type = string
#}

#variable "client_secret" {
#  type = string
#
#  # sensitive values are hidden from outputs
#  sensitive = true
#}

variable "azure_tags" {
  type        = map
  description = "Name/value pair tags to apply to every resource deployed."
  default     = {}
}

variable "cloud_environment_name" {
  type        = string
  description = "Specify a Cloud Environment Name."
  default     = "Public"
}

variable "custom_data_file" {
  type        = string
  description = "Specify a file containing custom data to inject into the cloud-init process."
  default     = ""
}

variable "image_publisher" {
  type        = string
  description = "Name of the publisher to use for your base image."
  default     = "Canonical"
}

# see https://www.packer.io/docs/builders/azure/arm#image_offer
variable "image_offer" {
  type        = string
  description = "Name of the publisher's offer to use for your base image."
  default     = "UbuntuServer"
}

# see https://www.packer.io/docs/builders/azure/arm#image_sku
variable "image_sku" {
  type        = string
  description = "SKU of the image offer to use for your base image."
  default     = "18.04-LTS"
}

# see https://www.packer.io/docs/builders/azure/arm#image_version
variable "image_version" {
  type        = string
  description = "Specify a specific version of an OS to boot from."
  default     = "latest"
}

variable "location" {
  type = string
  description = "Azure datacenter in which your VM will build."

  # this value is set in `terraform-generated.auto.pkrvars.hcl`
}

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

variable "ssh_clear_authorized_keys" {
  type = bool
  description = "If true, Packer will attempt to remove its temporary key from the image."
  default = true
}

variable "vm_size" {
  type        = string
  default     = "Standard_A1"
  description = "Size of the VM used for building."
}

variable "managed_image_resource_group_name" {
  type = string
  description = "Resource group under which the final artifact will be stored."

  # this value is set in `terraform-generated.auto.pkrvars.hcl`
}

variable "os_type" {
  type        = string
  description = "OS Type to use for configuration of authentication credentials."
  default     = "Linux"
}

variable "shared" {
  type = object({
    ansible_env_vars          = list(string)
    extra_arguments           = list(string)
    image_version_date_format = string
    name                      = string
  })

  description = "List of shared variables"

  # The default for this is specified in ./packer/_shared/shared.pkrvars.hcl
}

locals {
  # set `image_name_prefix` to shared value, unless it is user-specified
  managed_image_name = var.managed_image_name == "" ? var.shared.name : var.managed_image_name

  # set `image_version` to generated value, unless it is user-defined
  managed_image_version = var.managed_image_version == "" ? formatdate(var.shared.image_version_date_format, timestamp()) : var.managed_image_version

  managed_image_name = "${local.image_name}-${local.managed_image_version}"
}
