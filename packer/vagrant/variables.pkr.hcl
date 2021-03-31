# This file is automatically loaded by Packer

variable "add_clean" {
  type        = bool
  description = "Should Vagrant remove any old temporary fdiles from prior downloads?"
  default     = false
}

variable "add_force" {
  type        = bool
  description = "Should the box be downloaded and overwrite any existing box with this name?"
  default     = null
}

variable "box_name" {
  type        = string
  description = "What box name to use when initializing Vagrant."
  default     = ""
}

variable "box_organization" {
  type        = string
  description = "Name of the Vagrant Organization to use for Vagrant Cloud"
  default     = "operatehappy"
}

variable "box_tag" {
  type        = string
  description = "Name of the Vagrant Box to upload to Vagrant Cloud"
  default     = ""
}

variable "box_version" {
  type        = string
  description = "What box version to use when initializing Vagrant."
  default     = ""
}

variable "communicator" {
  type        = string
  description = "Which communicator to use when initializing Vagrant."
  default     = "ssh"
}

variable "output_dir" {
  type        = string
  description = "The directory to create that will contain your output box."
  default     = "generated/vagrant"
}

variable "provider" {
  type        = string
  description = "The Vagrant provider."
  default     = "virtualbox"
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

variable "skip_add" {
  type        = bool
  description = "Don't add the box to your local environment."
  default     = false
}

variable "source_path" {
  type        = string
  description = "Name of the Vagrant Box to use for your base image"

  # see https://app.vagrantup.com/ubuntu/boxes/focal64
  default = "ubuntu/focal64"
}

variable "teardown_method" {
  type        = string
  description = "Whether to halt, suspend, or destroy the box when the build has completed."
  default     = "destroy"
}

variable "template" {
  type        = string
  description = "A path to a Go Template for a Vagrantfile."
  default     = "./packer/vagrant/Vagrantfile"
}

locals {
  # set `box_name` to shared value, unless it is user-specified
  box_name = var.box_name == "" ? var.shared.name : var.box_name

  box_tag = "${var.box_organization}/${local.box_name}"

  # set `box_version` to generated value, unless it is user-defined
  box_version_timestamp = formatdate(var.shared.image_version_date_format, timestamp())
  box_version           = var.box_version == "" ? local.box_version_timestamp : var.box_version
}
