# see https://developer.hashicorp.com/vagrant/docs/cli/box#box-add
# and https://developer.hashicorp.com/packer/plugins/builders/vagrant#add_clean
variable "add_clean" {
  type        = bool
  description = "Toggle to remove prior downloads of Input Vagrant Box."
  default     = false
}

# see https://developer.hashicorp.com/vagrant/docs/cli/box#box-add
# and https://developer.hashicorp.com/packer/plugins/builders/vagrant#add_force
variable "add_force" {
  type        = bool
  description = "Toggle to (re-)download and overwrite existing Input Vagrant Box."
  default     = false
}

# see https://developer.hashicorp.com/packer/plugins/builders/vagrant#skip_add
variable "skip_add" {
  type        = bool
  description = "Toggle to prevent the Output Vagrant Box from being added to the local environment."
  default     = false
}

# see https://developer.hashicorp.com/packer/plugins/builders/vagrant#teardown_method
variable "teardown_method" {
  type        = string
  description = "Action to take when the build process has completed."
  default     = "destroy"
}

locals {
  # load Vagrant Cloud Access Token from well-known file
  vagrant_cloud_access_token = file("~/.vagrant.d/data/vagrant_login_token")
}

# see https://developer.hashicorp.com/packer/plugins/post-processors/vagrant/vagrant-cloud#keep_input_artifact
variable "vagrant_cloud_keep_input_artifact" {
  type        = bool
  description = "Toggle to keep Output Vagrant Box on local system."
  default     = true
}

# see https://developer.hashicorp.com/packer/plugins/post-processors/vagrant/vagrant-cloud#no_direct_upload
variable "vagrant_cloud_no_direct_upload" {
  type        = bool
  description = "Toggle to prevent direct upload to Vagrant Cloud Backend Storage (and therefore require a Vagrant Cloud UI-started upload)."
  default     = true
}

# see https://developer.hashicorp.com/packer/plugins/post-processors/vagrant/vagrant-cloud#no_release
variable "vagrant_cloud_no_release" {
  type        = bool
  description = "Toggle to prevent release of Output Vagrant Box on Vagrant Cloud."
  default     = true
}

# see https://developer.hashicorp.com/packer/plugins/post-processors/vagrant/vagrant-cloud#box_tag
variable "vagrant_cloud_organization" {
  type        = string
  description = "Vagrant Cloud Organization to publish Output Vagrant Box in."
  default     = "workloads"
}
