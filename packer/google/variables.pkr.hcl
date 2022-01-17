# This file is automatically loaded by Packer

# see https://www.packer.io/docs/builders/googlecompute#disk_name
variable "disk_name" {
  type        = string
  description = "The name of the disk"
  default     = null
}

# see https://www.packer.io/docs/builders/googlecompute#disk_size
variable "disk_size" {
  type        = number
  description = "The size of the disk in GB"
  default     = 10
}

# see https://www.packer.io/docs/builders/googlecompute#disk_type
variable "disk_type" {
  type        = string
  description = "Type of disk used to back your instance, like `pd-ssd` or `pd-standard`."
  default     = "pd-standard"

  validation {
    condition     = can(contains(["pd-standard", "pd-ssd"], var.disk_type))
    error_message = "The Disk Type must be one of \"pd-standard\", \"pd-ssd\"."
  }
}

# see https://www.packer.io/docs/builders/googlecompute#enable_secure_boot
variable "enable_secure_boot" {
  type        = bool
  description = "Create a Shielded VM image with Secure Boot enabled."
  default     = false
}

# see https://www.packer.io/docs/builders/googlecompute#enable_vtpm
variable "enable_vtpm" {
  type        = bool
  description = "Create a Shielded VM image with virtual trusted platform module Measured Boot enabled."
  default     = false
}

# see https://www.packer.io/docs/builders/googlecompute#enable_integrity_monitoring
variable "enable_integrity_monitoring" {
  type        = bool
  description = "Integrity monitoring helps you understand and make decisions about the state of your VM instances."
  default     = false
}

# see https://www.packer.io/docs/builders/googlecompute#image_information
variable "image_information" {
  type        = string
  description = "The description of the resulting image."
  default     = null
}

# see https://www.packer.io/docs/builders/googlecompute#image_family
variable "image_family" {
  type        = string
  description = "The name of the image family to which the resulting image belongs."
  default     = null
}

# see https://www.packer.io/docs/builders/googlecompute#image_licenses
variable "image_licenses" {
  type        = list(string)
  description = "Licenses to apply to the created image."
  default     = []
}

# see https://www.packer.io/docs/builders/googlecompute#image_name
variable "image_name" {
  type        = string
  description = "The unique name of the resulting image."
  default     = "packer-{{ timestamp }}"
}

# see https://www.packer.io/docs/builders/googlecompute#image_storage_locations
variable "image_storage_locations" {
  type        = list(string)
  description = " Storage location, either regional or multi-regional, where snapshot content is to be stored and only accepts 1 value."
  default     = []
}

# see https://www.packer.io/docs/builders/googlecompute#machine_type
variable "machine_type" {
  type        = string
  description = "The machine type."
  default     = "n1-standard-1"

  validation {
    condition     = can(!contains(["f1-micro", "pd-ssd"], var.machine_type))
    error_message = "The Machine Type must not be one of \"f1-micro\", \"g1-small\"."
  }
}

# see https://www.packer.io/docs/builders/googlecompute#min_cpu_platform
variable "min_cpu_platform" {
  type        = string
  description = "A Minimum CPU Platform for VM Instance."
  default     = null
}

# see https://www.packer.io/docs/builders/googlecompute#network
variable "network" {
  type        = string
  description = "The Google Compute Network ID or URL to use for the launched instance."
  default     = "default"
}

# see https://www.packer.io/docs/builders/googlecompute#omit_external_ip
variable "omit_external_ip" {
  type        = bool
  description = "If true, the instance will not have an external IP."
  default     = false
}

# see https://www.packer.io/docs/builders/googlecompute#preemptible
variable "preemptible" {
  type        = bool
  description = "If true, launch a preemptible instance."
  default     = true
}

# see https://www.packer.io/docs/builders/googlecompute#project_id
variable "project_id" {
  type        = string
  description = "(Required) The project ID that will be used to launch instances and store images."
}

# see https://www.packer.io/docs/builders/googlecompute#region
variable "region" {
  type        = string
  description = "The name of the region in which to launch the EC2 instance to create the AMI."
  default     = null
}

# see https://www.packer.io/docs/builders/googlecompute#scopes
variable "scopes" {
  type        = list(string)
  description = "The service account scopes for launched instance."
  default = [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.full_control"
  ]
}

# see https://www.packer.io/docs/builders/googlecompute#skip_create_image
variable "skip_create_image" {
  type        = bool
  description = "Skip creating the image."
  default     = false
}

# shared configuration
variable "shared" {
  type = object({
    enable_debug_statements = bool
    enable_post_validation  = bool

    ansible = object({
      ansible_env_vars = list(string)
      command          = string
      extra_arguments  = list(string)
      galaxy_file      = string
      playbook_file    = string
    })

    checksum_output = string
    checksum_types  = list(string)

    communicator = object({
      ssh_clear_authorized_keys    = bool
      ssh_disable_agent_forwarding = bool
      ssh_username                 = string
      type                         = string
    })

    docker = object({
      enabled = bool

      packages = list(object({
        name    = string
        version = string
      }))

      repository = object({
        keyring = string
        url     = string
      })

      toggles = map(bool)
    })

    generated_files = object({
      configuration = string
      versions      = string
    })

    hashicorp = object({
      enabled          = bool
      enabled_products = map(bool)

      nomad_plugins = list(object({
        name    = string
        version = string
      }))

      packages = list(object({
        name    = string
        version = string
      }))

      repository = object({
        url = string
      })

      toggles = map(bool)
    })

    image_version_date_format     = string
    image_information_date_format = string

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

    os = object({
      enabled = bool

      directories = object({
        ansible   = list(string)
        to_remove = list(string)
      })

      packages = object({
        to_install = list(string)
        to_remove  = list(string)
      })

      shell_helpers = object({
        destination = string
        base_url    = string
        helpers     = list(string)
      })

      toggles = map(bool)
    })

    osquery = object({
      enabled = bool

      packages = list(object({
        name    = string
        version = string
      }))

      paths = list(string)

      repository = object({
        key        = string
        key_server = string
        url        = string
      })

      toggles = map(bool)
    })

    podman = object({
      enabled = bool

      packages = list(object({
        name    = string
        version = string
      }))

      repository = object({
        url = string
      })

      toggles = map(bool)
    })

    prompt = object({
      enabled = bool
    })

    templates = object({
      configuration = string
      versions      = string
    })
  })

  description = "Shared Configuration for all Images"

  # The default for this is specified in `../_shared/shared.pkrvars.hcl`
}

# see https://www.packer.io/docs/builders/googlecompute#source_image
variable "source_image" {
  type        = string
  description = "(Required) The source image to use to create the new image from."
  default     = "ubuntu-minimal-2004-focal-v20210429"
}

# `target` as received from `make`
variable "target" {
  type        = string
  description = "Build Target as received from `make`."
}

# see https://www.packer.io/docs/builders/googlecompute#use_internal_ip
variable "use_internal_ip" {
  type        = bool
  description = "If true, use the instance's internal IP instead of its external IP during building."
  default     = false
}

# see https://www.packer.io/docs/builders/googlecompute#zone
variable "zone" {
  type        = string
  description = "(Required) The zone in which to launch the instance used to create the image."
}

locals {
  //  # set `box_name` to shared value, unless it is user-specified
  //  box_name = var.box_name == "" ? var.shared.name : var.box_name
  //  box_tag  = "${var.box_organization}/${local.box_name}"
  //
  //  # set `box_version` to generated value, unless it is user-defined
  //  box_version_timestamp = formatdate(var.shared.image_version_date_format, timestamp())
  //  box_version           = var.box_version == "" ? local.box_version_timestamp : var.box_version
  //
  //  version_description = templatefile(var.shared.templates.versions, {
  //    shared    = var.shared
  //    name      = local.box_tag
  //    version   = local.box_version
  //    timestamp = local.box_version_timestamp
  //  })
  //

  # concatenate repository-defined extra arguments for Ansible with user-defined ones
  # see https://www.packer.io/docs/provisioners/ansible#ansible_env_vars
  ansible_extra_arguments = concat(
    # repository-defined extra arguments for Ansible
    [
      "--extra-vars", "build_target=${var.target}"
    ],

    # user-defined extra arguments for Ansible
  var.shared.ansible.extra_arguments)

  # see https://www.packer.io/docs/builders/googlecompute#image_labels
  image_labels = {
    key = "value"
  }
}
