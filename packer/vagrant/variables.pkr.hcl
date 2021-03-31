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

variable "box_tag" {
  type        = string
  description = "Name of the Vagrant Box to upload to Vagrant Cloud"
  default     = "operatehappy/ubuntu-hashicorp"
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

variable "shared_ansible_env_vars" {
  type        = list(string)
  description = "Environment variables to set before running Ansible."

  # The default for this is specified in ./packer/_shared/shared.pkrvars.hcl
}

variable "shared_extra_arguments" {
  type        = list(string)
  description = "Extra arguments to pass to Ansible."

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
