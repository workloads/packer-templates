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

# see https://www.packer.io/plugins/post-processors/vagrant/vagrant-cloud#no_release
variable "no_release" {
  type        = bool
  description = "Toggle to prevent release of Output Vagrant Box on Vagrant Cloud."
  default     = true
}

# see https://www.packer.io/docs/builders/vagrant#skip_add
variable "skip_add" {
  type        = bool
  description = "Toggle to prevent the Output Vagrant Box from being added to the local environment."
  default     = true
}

# see https://www.packer.io/docs/builders/vagrant#teardown_method
variable "teardown_method" {
  type        = string
  description = "Action to take when the build process has completed."
  default     = "destroy"
}
