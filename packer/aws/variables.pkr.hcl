# This file is automatically loaded by Packer

# see https://www.packer.io/docs/builders/amazon/ebs#ami_description
variable "ami_description" {
  type        = string
  description = "The description to set for the resulting AMI(s)."
  default     = ""
}

# see https://www.packer.io/docs/builders/amazon/ebs#ami_groups
variable "ami_groups" {
  type        = list(string)
  description = "A list of groups that have access to launch the resulting AMI(s)."
  default     = []
}

# see https://www.packer.io/docs/builders/amazon/ebs#ami_name
variable "ami_name" {
  type        = string
  description = "(Required) The name of the resulting AMI that will appear when managing AMIs in the AWS console or via APIs."
  default     = ""
}

# see https://www.packer.io/docs/builders/amazon/ebs#ami_product_codes
variable "ami_product_codes" {
  type        = list(string)
  description = "A list of product codes to associate with the AMI."
  default     = []
}

# see https://www.packer.io/docs/builders/amazon/ebs#ami_regions
variable "ami_regions" {
  type        = list(string)
  description = "A list of regions to copy the AMI to."
  default     = []
}

# see https://www.packer.io/docs/builders/amazon/ebs#ami_users
variable "ami_users" {
  type        = list(string)
  description = "A list of account IDs that have access to launch the resulting AMI(s)."
  default     = []
}

# see https://www.packer.io/docs/builders/amazon/ebs#ami_virtualization_type
variable "ami_virtualization_type" {
  type        = string
  description = "The type of virtualization for the AMI you are building."
  default     = "hvm"

  validation {
    condition     = can(contains(["hvm", "paravirtual"], var.ami_virtualization_type))
    error_message = "The AMI Virtualization Type must be one of \"hvm\", \"paravirtual\"."
  }
}

# see https://www.packer.io/docs/builders/amazon/ebs#associate_public_ip_address
variable "associate_public_ip_address" {
  type        = bool
  description = "If this is true, your new instance will get a Public IP."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#availability_zone
variable "availability_zone" {
  type        = string
  description = "Destination availability zone to launch instance in."

  # The default for this should be specified in `./overrides.auto.pkrvars.hcl`
}

# see https://www.packer.io/docs/builders/amazon/ebs#aws_polling
variable "aws_polling" {
  type = object({
    delay_seconds = number
    max_attempts  = number
  })

  description = "Polling configuration for the AWS waiter."
  default = {
    delay_seconds = 30
    max_attempts  = 50
  }
}

# see https://www.packer.io/docs/builders/amazon/ebs#custom_endpoint_ec2
variable "custom_endpoint_ec2" {
  type        = string
  description = "This option is useful if you use a cloud provider whose API is compatible with AWS EC2."
  default     = null
}

# see https://www.packer.io/docs/builders/amazon/ebs#disable_stop_instance
variable "disable_stop_instance" {
  type        = bool
  description = "Packer normally stops the build instance after all provisioners have run."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#ebs_optimized
variable "ebs_optimized" {
  type        = bool
  description = "Mark instance as EBS Optimized."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#enable_t2_unlimited
variable "enable_t2_unlimited" {
  type        = bool
  description = "Enabling T2 Unlimited allows the source instance to burst additional CPU beyond its available CPU Credits for as long as the demand exists."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#ena_support
variable "ena_support" {
  type        = bool
  description = "Enable enhanced networking (ENA but not SriovNetSupport) on HVM-compatible AMIs."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#encrypt_boot
variable "encrypt_boot" {
  type        = bool
  description = "Whether or not to encrypt the resulting AMI when copying a provisioned instance to an AMI."
  default     = null
}

# see https://www.packer.io/docs/builders/amazon/ebs#force_delete_snapshot
variable "force_delete_snapshot" {
  type        = bool
  description = "Force Packer to delete snapshots associated with AMIs, which have been deregistered by `force_deregister`."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#force_deregister
variable "force_deregister" {
  type        = bool
  description = "Force Packer to first deregister an existing AMI if one with the same name already exists."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#iam_instance_profile
variable "iam_instance_profile" {
  type        = string
  description = "The name of an IAM instance profile to launch the EC2 instance with."
  default     = null
}

# the `filters` of `image` is defined in the `locals` stanza at the bottom of this file
variable "image" {
  type = object({
    most_recent = bool
    owners      = list(string)
  })

  description = "Amazon AMI Image Filter"

  default = {
    # Selects the newest created image when true.
    most_recent = true

    # Filters the images by their owner.
    owners = ["099720109477"]
  }
}

# see https://www.packer.io/docs/builders/amazon/ebs#instance_type
variable "instance_type" {
  type        = string
  description = "The EC2 instance type to use while building the AMI"
  default     = "t2.small"
}

# see https://www.packer.io/docs/builders/amazon/ebs#kms_key_id
variable "kms_key_id" {
  type        = string
  description = "ID, alias or ARN of the KMS key to use for AMI encryption."
  default     = null
}

# see https://www.packer.io/docs/builders/amazon/ebs#profile
variable "profile" {
  type        = string
  description = "The profile to use in the shared credentials file for AWS."
  default     = null
}

# see https://www.packer.io/docs/builders/amazon/ebs#region
variable "region" {
  type        = string
  description = "The name of the region in which to launch the EC2 instance to create the AMI."

  # The default for this should be specified in `./overrides.auto.pkrvars.hcl`
}

# see https://www.packer.io/docs/builders/amazon/ebs#region_kms_key_ids
variable "region_kms_key_ids" {
  type        = map(string)
  description = "Regions to copy the AMI to, along with the custom KMS Key ID(Alias or ARN) to use for encryption for that region."
  default     = {}
}

# see https://www.packer.io/docs/builders/amazon/ebs#run_tags
# this value will be enriched with the contents of local.tags_base
variable "run_tags" {
  type        = map(string)
  description = "Key/value pair tags to apply to the instance that is that is launched to create the EBS volumes."
  default     = {}
}

# see https://www.packer.io/docs/builders/amazon/ebs#security_group_filter
variable "security_group_filter" {
  type        = map(string)
  description = "Filters used to populate the `security_group_ids` field."
  default     = {}
}

# see https://www.packer.io/docs/builders/amazon/ebs#security_group_ids
variable "security_group_ids" {
  type        = list(string)
  description = "A list of security groups as to assign to the instance."
  default     = []
}

# shared configuration
variable "shared" {
  type = object({
    enable_debug_statements = bool

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

    templates = object({
      configuration = string
      versions      = string
    })
  })

  description = "Shared Configuration for all Images"

  # The default for this is specified in `../_shared/shared.pkrvars.hcl`
}

# see https://www.packer.io/docs/builders/amazon/ebs#shutdown_behavior
variable "shutdown_behavior" {
  type        = string
  description = "Automatically terminate instances on shutdown in case Packer exits ungracefully."
  default     = "stop"

  validation {
    condition     = can(contains(["stop", "terminate"], var.shutdown_behavior))
    error_message = "The Shutdown Behavior must be one of \"stop\", \"terminate\"."
  }
}

# see https://www.packer.io/docs/builders/amazon/ebs#skip_create_ami
variable "skip_create_ami" {
  type        = bool
  description = "If true, Packer will not create the AMI."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#skip_credential_validation
variable "skip_credential_validation" {
  type        = bool
  description = "Set to true if you want to skip validating AWS credentials before runtime."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#skip_metadata_api_check
variable "skip_metadata_api_check" {
  type        = bool
  description = "Skip Metadata API Check."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#skip_profile_validation
variable "skip_profile_validation" {
  type        = bool
  description = "Whether or not to check if the IAM instance profile exists."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#skip_region_validation
variable "skip_region_validation" {
  type        = bool
  description = "Set to true if you want to skip validation of the ami_regions configuration option."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#skip_save_build_region
variable "skip_save_build_region" {
  type        = bool
  description = "If true, Packer will not check whether an AMI with the `ami_name` exists in the region it is building in."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#snapshot_groups
variable "snapshot_groups" {
  type        = list(string)
  description = "A list of groups that have access to create volumes from the snapshot(s)."
  default     = []
}

# see https://www.packer.io/docs/builders/amazon/ebs#snapshot_users
variable "snapshot_users" {
  type        = list(string)
  description = "A list of account IDs that have access to create volumes from the snapshot(s)."
  default     = []
}

# see https://www.packer.io/docs/builders/amazon/ebs#subnet_id
variable "subnet_id" {
  type        = string
  description = "If using VPC, the ID of the subnet, such as subnet-12345def, where Packer will launch the EC2 instance. This field is required if you are using an non-default VPC."
  default     = ""
}

variable "source_image_family" {
  type        = string
  description = "Family to filter AMI search on"
  default     = "ubuntu"
}

variable "source_image_name" {
  type        = string
  description = "Name to filter AMI search on"
  default     = "ubuntu-focal-20.04-amd64-server-*"
}

# see https://www.packer.io/docs/builders/amazon/ebs#tags
variable "tags" {
  type        = map(string)
  description = "Key/value pair tags applied to the AMI."
  default     = {}
}

# `target` as received from `make`
variable "target" {
  type        = string
  description = "Build Target as received from `make`."
}

variable "version_description" {
  type        = string
  description = "Version to use for the image."
  default     = ""
}

# see https://www.packer.io/docs/builders/amazon/ebs#vpc_id
variable "vpc_id" {
  type        = string
  description = "Requires subnet_id to be set. Used to create a temporary security group within the VPC. If this field is left blank, Packer will try to get the VPC ID from the subnet_id."
  default     = ""
}

locals {
  # TODO: add `timestamp`
  ami_name = var.ami_name == "" ? var.shared.name : var.ami_name

  # concatenate repository-defined extra arguments for Ansible with user-defined ones
  # see https://www.packer.io/docs/provisioners/ansible#ansible_env_vars
  ansible_extra_arguments = concat(
    # repository-defined extra arguments for Ansible
    [
      "--extra-vars", "build_target=${var.target}"
    ],

    # user-defined extra arguments for Ansible
    var.shared.ansible.extra_arguments
  )

  tags_base = {
    "Name"                = local.ami_name
    "image:builder"       = "Packer"
    "image:source-id"     = data.amazon-ami.image.id
    "image:source-name"   = data.amazon-ami.image.name
    "image:source-region" = var.region
  }

  tags_versions = {

  }

  version_timestamp = formatdate(var.shared.image_information_date_format, timestamp())

  version_description = templatefile(var.shared.templates.versions, {
    shared    = var.shared
    name      = local.ami_name
    version   = "{{ isotime }}"
    timestamp = local.version_timestamp
  })
}

locals {
  run_tags = merge(local.tags_base, var.run_tags)

  # assemble tags from common tags and version information
  tags = merge(local.tags_base, local.tags_versions)
}
