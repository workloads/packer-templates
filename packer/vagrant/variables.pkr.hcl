# This file is automatically loaded by Packer

variable "source_path" {
  type        = string
  description = "Name of the Vagrant Box to use for your base image"

  # see https://app.vagrantup.com/ubuntu/boxes/focal64
  default = "ubuntu/focal64"
}

variable "box_tag" {
  type        = string
  description = "Name of the Vagrant Box to upload to Vagrant Cloud"
  default     = "operatehappy/ubuntu-nomad"
}

variable "version" {
  type        = string
  description = "Version of the Vagrant Box to upload to Vagrant Cloud"
  default     = "0.0.1"
}

variable "shared_ansible_env_vars" {
  type        = list(string)
  description = "Environment variables to set before running Ansible."

  # The default for this is specified in ./packer/_shared/shared.pkrvars.hcl
}
