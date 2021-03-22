# This file is automatically loaded by Packer

variable "source_path" {
  type        = string
  description = "Name of the Vagrant Box to use for your base image"

  # see https://app.vagrantup.com/ubuntu/boxes/bionic64
  default = "ubuntu/bionic64"
}
