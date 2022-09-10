# see https://www.vagrantup.com/docs/cli/box#box-add
# and https://www.packer.io/docs/builders/vagrant#add_clean
variable "add_clean" {
  type        = bool
  description = "Toggle to remove prior downloads of Input Vagrant Box."
  default     = false
}

# see https://www.vagrantup.com/docs/cli/box#box-add
# and https://www.packer.io/docs/builders/vagrant#add_force
variable "add_force" {
  type        = bool
  description = "Toggle to (re-)download and overwrite existing Input Vagrant Box."
  default     = false
}

# see https://app.vagrantup.com/ubuntu/boxes/jammy64/versions/20220902.0.0
# and https://www.packer.io/docs/builders/vagrant#box_version
variable "box_version" {
  type        = string
  description = "Version of the Input Vagrant Box."
  default     = "20220902.0.0"
}

# see https://www.packer.io/plugins/post-processors/vagrant/vagrant-cloud#no_release
variable "no_release" {
  type        = bool
  description = "Toggle to prevent release of Output Vagrant Box on Vagrant Cloud."
  default     = true
}

# see https://www.packer.io/docs/builders/vagrant#provider
variable "provider" {
  type        = string
  description = "Vagrant Provider to build the Output Vagrant Box with."
  default     = "virtualbox"
}

# see https://www.packer.io/docs/builders/vagrant#skip_add
variable "skip_add" {
  type        = bool
  description = "Toggle to prevent the Output Vagrant Box from being added to the local environment."
  default     = false
}

# see https://www.packer.io/docs/builders/vagrant#source_path
variable "source_path" {
  type        = string
  description = "Name of the Input Vagrant Box."

  # see https://app.vagrantup.com/ubuntu/boxes/jammy64
  default = "ubuntu/jammy64"
}

# see https://www.packer.io/docs/builders/vagrant#teardown_method
variable "teardown_method" {
  type        = string
  description = "Action to take when the build process has completed."
  default     = "destroy"
}
