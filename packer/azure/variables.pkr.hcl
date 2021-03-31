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

variable "image_name" {
  type        = string
  description = "Name to use for the image"
  default     = ""
}

variable "image_version" {
  type        = string
  description = "Version to use for the image"
  default     = ""
}

variable "image_publisher" {
  type        = string
  description = "Name of the publisher to use for your base image"
  default     = "Canonical"
}

# see https://www.packer.io/docs/builders/azure/arm#image_offer
variable "image_offer" {
  type        = string
  description = "Name of the publisher's offer to use for your base image"
  default     = "UbuntuServer"
}

# see https://www.packer.io/docs/builders/azure/arm#image_sku
variable "image_sku" {
  type        = string
  description = "SKU of the image offer to use for your base image"
  default     = "18.04-LTS"
}

variable "location" {
  type = string
  # this value is set in `terraform-generated.auto.pkrvars.hcl`
  description = "Azure datacenter in which your VM will build"
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2_v2"
  description = "Size of the VM used for building"
}

variable "managed_image_resource_group_name" {
  type = string
  # this value is set in `terraform-generated.auto.pkrvars.hcl`
  description = "Resource group under which the final artifact will be stored"
}

variable "os_type" {
  type        = string
  description = "OS Type to use for configuration of authentication credentials"
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
  image_name = var.image_name == "" ? var.shared.name : var.image_name

  # set `image_version` to generated value, unless it is user-defined
  image_version = var.image_version == "" ? formatdate(var.shared.image_version_date_format, timestamp()) : var.image_version

  managed_image_name = "${local.image_name}-${local.image_version}"
}
