# This file is automatically loaded by Packer

variable "source_path" {
  type        = string
  description = "Name of the Vagrant Box to use for your base image"

  # see https://app.vagrantup.com/ubuntu/boxes/bionic64
  default = "ubuntu/bionic64"
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

variable "compression_level" {
  type        = number
  description = "An integer representing the compression level to use when creating the Vagrant box"
  default     = 9
}
