# This file is automatically loaded by Packer

# see https://www.packer.io/docs/builders/vagrant#add_clean
variable "add_clean" {
  type        = bool
  description = "Should Vagrant remove any old temporary fdiles from prior downloads?"
  default     = false
}

# see https://www.packer.io/docs/builders/vagrant#add_force
variable "add_force" {
  type        = bool
  description = "Should the box be downloaded and overwrite any existing box with this name?"
  default     = null
}

# see https://www.packer.io/docs/builders/vagrant#box_name
variable "box_name" {
  type        = string
  description = "What box name to use when initializing Vagrant."
  default     = ""
}

# see https://www.packer.io/docs/builders/vagrant#box_organization
variable "box_organization" {
  type        = string
  description = "Name of the Vagrant Organization to use for Vagrant Cloud"
  default     = "operatehappy"
}

# see https://www.packer.io/docs/builders/vagrant#box_tag
variable "box_tag" {
  type        = string
  description = "Name of the Vagrant Box to upload to Vagrant Cloud"
  default     = ""
}

# see https://www.packer.io/docs/builders/vagrant#box_version
variable "box_version" {
  type        = string
  description = "What box version to use when initializing Vagrant."
  default     = ""
}

# shared configuration
variable "build_config" {
  type = object({
    ansible = object({
      ansible_env_vars = list(string)
      command          = string
      extra_arguments  = list(string)
      galaxy_file      = string
      playbook_file    = string
    })

    apt_repos = map(string)

    communicator = object({
      ssh_port                     = number
      ssh_clear_authorized_keys    = bool
      ssh_disable_agent_forwarding = bool
      type                         = string
    })

    generated_files = object({
      configuration = string
      versions      = string
    })

    image_version_date_format = string

    inspec = object({
      attributes           = list(string)
      attributes_directory = string
      backend              = string
      command              = string
      inspec_env_vars      = list(string)
      profile              = string
      user                 = string
    })

    name = string

    packages = object({
      docker = list(object({
        name    = string
        version = string
      }))

      hashicorp = list(object({
        name    = string
        version = string
      }))

      hashicorp_nomad_plugins = list(object({
        name    = string
        version = string
      }))

      podman = list(object({
        name    = string
        version = string
      }))

      to_install = list(string)
      to_remove  = list(string)
    })

    templates = object({
      configuration = string
      versions      = string
    })

    toggles = object({
      enable_debug_statements = bool
      enable_docker           = bool
      enable_hashicorp        = bool
      enable_os               = bool
      enable_podman           = bool

      docker            = map(bool)
      hashicorp         = map(bool)
      hashicorp_enabled = map(bool)
      misc              = map(bool)
      os                = map(bool)
      podman            = map(bool)
    })
  })

  description = "Shared Configuration for all Images"

  # The default for this is specified in ./packer/_shared/shared.pkrvars.hcl
}

# see https://www.packer.io/docs/builders/vagrant#no_release
variable "no_release" {
  type        = bool
  description = "If set to true, does not release the version on Vagrant Cloud, making it active."
  default     = true
}

# see https://www.packer.io/docs/builders/vagrant#output_dir
variable "output_dir" {
  type        = string
  description = "The directory to create that will contain your output box."
  default     = "generated/vagrant"
}

# see https://www.packer.io/docs/builders/vagrant#provider
variable "provider" {
  type        = string
  description = "The Vagrant provider."
  default     = "virtualbox"
}

# see https://www.packer.io/docs/builders/vagrant#skip_add
variable "skip_add" {
  type        = bool
  description = "Don't add the box to your local environment."
  default     = false
}

# see https://www.packer.io/docs/builders/vagrant#source_path
variable "source_path" {
  type        = string
  description = "Name of the Vagrant Box to use for your base image"

  # see https://app.vagrantup.com/ubuntu/boxes/focal64
  default = "ubuntu/focal64"
}

# see https://www.packer.io/docs/builders/vagrant#teardown_method
variable "teardown_method" {
  type        = string
  description = "Whether to halt, suspend, or destroy the box when the build has completed."
  default     = "destroy"
}

# see https://www.packer.io/docs/builders/vagrant#template
variable "template" {
  type        = string
  description = "A path to a Go Template for a Vagrantfile."
  default     = "./packer/vagrant/Vagrantfile"
}

locals {
  # set `box_name` to shared value, unless it is user-specified
  box_name = var.box_name == "" ? var.build_config.name : var.box_name

  box_tag = "${var.box_organization}/${local.box_name}"

  # set `box_version` to generated value, unless it is user-defined
  box_version_timestamp = formatdate(var.build_config.image_version_date_format, timestamp())
  box_version           = var.box_version == "" ? local.box_version_timestamp : var.box_version

  version_description_data = {
    build_config = var.build_config
    name         = local.box_tag
    version      = local.box_version
    timestamp    = local.box_version_timestamp
  }

  version_description = templatefile(var.build_config.templates.versions, local.version_description_data)
}
