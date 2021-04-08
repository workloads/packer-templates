# This file is automatically loaded by Packer

# see https://www.packer.io/docs/builders/amazon/ebs#access_key
variable "access_key" {
  type        = string
  description = "The access key used to communicate with AWS."
  default     = null
}

# see https://www.packer.io/docs/builders/amazon/ebs#ami_block_device_mappings
# TODO: add support for block variable "ami_block_device_mappings"

# see https://www.packer.io/docs/builders/amazon/ebs#ami_description
variable "ami_description" {
  type        = string
  description = "The description to set for the resulting AMI(s)."
  default     = "Created with Packer"
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
  description = "The name of the resulting AMI that will appear when managing AMIs in the AWS console or via APIs."
  default     = ""
}

# see https://www.packer.io/docs/builders/amazon/ebs#ami_product_codes
variable "ami_product_codes" {
  type        = list(string)
  description = "A list of product codes to associate with the AMI."
  default     = ["none"]
}

# see https://www.packer.io/docs/builders/amazon/ebs#ami_regions
variable "ami_regions" {
  type        = list(string)
  description = "A list of regions to copy the AMI to."
  default     = ["none"]
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
  default     = "paravirtual"

  validation {
    condition     = can(contains(["paravirtual", "hvm"], var.ami_virtualization_type))
    error_message = "The AMI Virtualization Type must be one of \"paravirtual\", \"hvm\"."
  }
}

# see https://www.packer.io/docs/builders/amazon/ebs#associate_public_ip_address
variable "associate_public_ip_address" {
  type        = bool
  description = "If this is true, your new instance will get a Public IP."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#assume_role
# TODO: add support for block variable "assume_role"

# see https://www.packer.io/docs/builders/amazon/ebs#availability_zone
variable "availability_zone" {
  type        = string
  description = "Destination availability zone to launch instance in."
  default     = ""
}

# see https://www.packer.io/docs/builders/amazon/ebs#aws_polling
# TODO: add support for block variable "aws_polling"

# see https://www.packer.io/docs/builders/amazon/ebs#block_duration_minutes
# TODO: add support for variable "block_duration_minutes"

variable "build_config" {
  type = object({
    ansible_env_vars          = list(string)
    apt_repos                 = map(string)
    command                   = string
    extra_arguments           = list(string)
    image_version_date_format = string
    name                      = string

    generated_files = object({
      configuration = string
      versions      = string
    })

    packages = object({
      to_install = list(string)
      to_remove  = list(string)

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
    })

    playbook_file = string

    templates = object({
      versions = string
    })

    toggles = object({
      enable_os               = bool
      enable_debug_statements = bool
      enable_docker           = bool
      enable_hashicorp        = bool
      enable_podman           = bool

      os                = map(bool)
      docker            = map(bool)
      hashicorp         = map(bool)
      hashicorp_enabled = map(bool)
      misc              = map(bool)
      podman            = map(bool)
    })
  })

  description = "Shared Configuration for all Images"

  # The default for this is specified in ./packer/_shared/shared.pkrvars.hcl
}

# see https://www.packer.io/docs/builders/amazon/ebs#aws_polling
# TODO: add support for block variable "aws_polling"

# see https://www.packer.io/docs/builders/amazon/ebs#custom_endpoint_ec2
variable "custom_endpoint_ec2" {
  type        = string
  description = "This option is useful if you use a cloud provider whose API is compatible with AWS EC2."
  default     = ""
}

# see https://www.packer.io/docs/builders/amazon/ebs#decode_authorization_messages
variable "decode_authorization_messages" {
  type        = bool
  description = "Enable automatic decoding of any encoded authorization (error) messages."
  default     = false
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
# TODO: add support for variable "ena_support"

# see https://www.packer.io/docs/builders/amazon/ebs#encrypt_boot
# TODO: add support for variable "encrypt_boot"

# see https://www.packer.io/docs/builders/amazon/ebs#engine_name
# TODO: add support for variable "engine_name"

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
  default     = ""
}

variable "image" {
  type = object({
    filters = {
      name                = string
      root-device-type    = string
      virtualization-type = string
    }

    most_recent = bool
    owners      = list(string)
  })

  description = "Amazon AMI Image Filter"

  default = {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }

    # Selects the newest created image when true.
    most_recent = true

    # Filters the images by their owner.
    owners = ["099720109477"]
  }
}

# see https://www.packer.io/docs/builders/amazon/ebs#insecure_skip_tls_verify
variable "insecure_skip_tls_verify" {
  type        = bool
  description = "This allows skipping TLS verification of the AWS EC2 endpoint."
  default     = false
}

# see https://www.packer.io/docs/builders/amazon/ebs#instance_type
variable "instance_type" {
  type        = string
  description = "The EC2 instance type to use while building the AMI"
  default     = "t2.small"
}

# see https://www.packer.io/docs/builders/amazon/ebs#kms_key_id
# TODO: add support for variable "kms_key_id"

# see https://www.packer.io/docs/builders/amazon/ebs#launch_block_device_mappings
# TODO: add support for block variable "launch_block_device_mappings"

# see https://www.packer.io/docs/builders/amazon/ebs#max_retries
variable "max_retries" {
  type        = number
  description = "This is the maximum number of times an API call is retried."
  default     = 3
}

# see https://www.packer.io/docs/builders/amazon/ebs#mfa_code
variable "mfa_code" {
  type        = string
  description = "The MFA TOTP code."
  default     = null
}

# see https://www.packer.io/docs/builders/amazon/ebs#no_ephemeral
# TODO: add support for variable "no_ephemeral" when Windows support is added

# see https://www.packer.io/docs/builders/amazon/ebs#profile
variable "profile" {
  type        = string
  description = "The profile to use in the shared credentials file for AWS."
  default     = ""
}

# see https://www.packer.io/docs/builders/amazon/ebs#region
variable "region" {
  type        = string
  description = "The name of the region in which to launch the EC2 instance to create the AMI."
  default     = null
}

# see https://www.packer.io/docs/builders/amazon/ebs#region_kms_key_ids
# TODO: add support for variable "region_kms_key_ids"

# see https://www.packer.io/docs/builders/amazon/ebs#role_arn
# TODO: add support for variable "role_arn"

# see https://www.packer.io/docs/builders/amazon/ebs#run_tags
variable "run_tags" {
  type        = map(string)
  description = "Key/value pair tags to apply to the instance that is that is launched to create the EBS volumes."
  default     = {}
}

# see https://www.packer.io/docs/builders/amazon/ebs#run_volume_tags
variable "run_volume_tags" {
  type        = map(string)
  description = "Tags to apply to the volumes that are launched to create the AMI."
  default     = {}
}

# see https://www.packer.io/docs/builders/amazon/ebs#secret_key
variable "secret_key" {
  type        = string
  description = "The secret key used to communicate with AWS."
  default     = null
}

# see https://www.packer.io/docs/builders/amazon/ebs#security_group_filter
# TODO: add support for block variable "security_group_filter"

# see https://www.packer.io/docs/builders/amazon/ebs#security_group_ids
variable "security_group_ids" {
  type        = list(string)
  description = "A list of security groups as to assign to the instance."
  default     = []
}

# see https://www.packer.io/docs/builders/amazon/ebs#shared_credentials_file
# variable "shared_credentials_file" {
#  type        = string
#  description = "Path to a credentials file to load credentials from."
# }

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

# see https://www.packer.io/docs/builders/amazon/ebs#snapshot_tags
variable "snapshot_tags" {
  type        = map(string)
  description = "Key/value pair tags to apply to snapshot."
  default     = {}
}

# see https://www.packer.io/docs/builders/amazon/ebs#snapshot_users
variable "snapshot_users" {
  type        = list(string)
  description = "A list of account IDs that have access to create volumes from the snapshot(s)."
  default     = []
}

# see https://www.packer.io/docs/builders/amazon/ebs#source_ami_filter
# TODO: add support for block variable "source_ami_filter"

# see https://www.packer.io/docs/builders/amazon/ebs#ssh_username
variable "ssh_username" {
  type        = string
  description = "The username to connect to SSH with."
  default     = "ubuntu"
}

# see https://www.packer.io/docs/builders/amazon/ebs#ssh_port
variable "ssh_port" {
  type        = number
  description = "The port to connect to SSH."
  default     = "22"
}

# see https://www.packer.io/docs/builders/amazon/ebs#ssh_password
variable "ssh_password" {
  type        = string
  description = "A plaintext password to use to authenticate with SSH."
  default     = ""
}

# see https://www.packer.io/docs/builders/amazon/ebs#ssh_clear_authorized_keys
variable "ssh_clear_authorized_keys" {
  type        = bool
  description = "If true, Packer will attempt to remove its temporary keys."
  default     = true
}

# see https://www.packer.io/docs/builders/amazon/ebs#subnet_id
variable "subnet_id" {
  type        = string
  description = "If using VPC, the ID of the subnet, such as subnet-12345def, where Packer will launch the EC2 instance. This field is required if you are using an non-default VPC."
  default     = ""
}

# see https://www.packer.io/docs/builders/amazon/ebs#tags
variable "tags" {
  type        = map(string)
  description = "Key/value pair tags applied to the AMI."
  default     = {}
}

# see https://www.packer.io/docs/builders/amazon/ebs#temporary_iam_instance_profile_policy_document
# TODO: add support for variable "temporary_iam_instance_profile_policy_document"

# see https://www.packer.io/docs/builders/amazon/ebs#token
variable "token" {
  type        = string
  description = "The access token to use."
  default     = null
}

# see https://www.packer.io/docs/builders/amazon/ebs#vault_aws_engine
# TODO: add support for block variable "vault_aws_engine"

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
  version_description = var.version_description == "" ? formatdate(var.build_config.image_version_date_format, timestamp()) : var.version_description

  ami_name = var.ami_name == "" ? var.build_config.name : var.ami_name
}
