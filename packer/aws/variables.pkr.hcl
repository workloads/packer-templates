# This file is automatically loaded by Packer

variable "access_key" {
  type        = string
  description = "The access key used to communicate with AWS."
  default     = null
}

# TODO: add support for block variable "ami_block_device_mappings"

variable "ami_description" {
  type        = string
  description = "The description to set for the resulting AMI(s)."
  default     = ""
}

variable "ami_name" {
  type        = string
  description = "The name of the resulting AMI that will appear when managing AMIs in the AWS console or via APIs."
  default     = ""
}

variable "ami_groups" {
  type        = list(string)
  description = "A list of groups that have access to launch the resulting AMI(s)."
  default     = []
}

variable "ami_product_codes" {
  type        = list(string)
  description = "A list of product codes to associate with the AMI."
  default     = []

}

variable "ami_regions" {
  type        = list(string)
  description = "A list of regions to copy the AMI to."
  default     = []
}

variable "ami_users" {
  type        = list(string)
  description = "A list of account IDs that have access to launch the resulting AMI(s)."
  default     = []

}

variable "ami_virtualization_type" {
  type        = string
  description = "The type of virtualization for the AMI you are building."
  default     = "paravirtual"

  # TODO: add validation for valid values `paravirtual` and `hvm`
}

variable "associate_public_ip_address" {
  type        = bool
  description = "If this is true, your new instance will get a Public IP."
  default     = false
}

# TODO: add support for block variable "assume_role"

variable "availability_zone" {
  type        = string
  description = "Destination availability zone to launch instance in."
  default     = ""
}

# TODO: add support for block variable "aws_polling"

# TODO: add support for variable "block_duration_minutes"

variable "build_config" {
  type = object({
    ansible_env_vars          = list(string)
    apt_repos                 = map(string)
    extra_arguments           = list(string)
    image_version_date_format = string
    name                      = string

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

    toggles = object({
      enable_os               = bool
      enable_debug_statements = bool
      enable_docker           = bool
      enable_hashicorp        = bool
      enable_misc_operations  = bool
      enable_podman           = bool

      os                = map(bool)
      docker            = map(bool)
      hashicorp         = map(bool)
      hashicorp_enabled = map(bool)
      misc              = map(bool)
      podman            = map(bool)
    })

    version_files = object({
      source      = string
      destination = string
      templates   = list(string)
    })
  })

  description = "Configuration for Ansible"
  # The default for this is specified in ./packer/_shared/shared.pkrvars.hcl
}

# TODO: add support for block variable "aws_polling"

variable "custom_endpoint_ec2" {
  type        = string
  description = "This option is useful if you use a cloud provider whose API is compatible with AWS EC2."
  default     = ""
}

variable "decode_authorization_messages" {
  type        = bool
  description = "Enable automatic decoding of any encoded authorization (error) messages."
  default     = false
}

variable "disable_stop_instance" {
  type        = bool
  description = "Packer normally stops the build instance after all provisioners have run."
  default     = false
}

variable "ebs_optimized" {
  type        = bool
  description = "Mark instance as EBS Optimized."
  default     = false
}

variable "enable_t2_unlimited" {
  type        = bool
  description = "Enabling T2 Unlimited allows the source instance to burst additional CPU beyond its available CPU Credits for as long as the demand exists."
  default     = false
}

# TODO: add support for variable "ena_support"

# TODO: add support for variable "encrypt_boot"

# TODO: add support for variable "engine_name"

variable "force_delete_snapshot" {
  type        = bool
  description = "Force Packer to delete snapshots associated with AMIs, which have been deregistered by `force_deregister`."
  default     = false
}

variable "force_deregister" {
  type        = bool
  description = "Force Packer to first deregister an existing AMI if one with the same name already exists."
  default     = false
}

variable "iam_instance_profile" {
  type        = string
  description = "The name of an IAM instance profile to launch the EC2 instance with."
  default     = ""
}

variable "insecure_skip_tls_verify" {
  type        = bool
  description = "This allows skipping TLS verification of the AWS EC2 endpoint."
  default     = false
}

variable "instance_type" {
  type        = string
  description = "The EC2 instance type to use while building the AMI"
  default     = "t2.small"
}

# TODO: add support for variable "kms_key_id"

# TODO: add support for block variable "launch_block_device_mappings"

variable "max_retries" {
  type        = number
  description = "This is the maximum number of times an API call is retried."
  default     = 3
}

variable "mfa_code" {
  type        = string
  description = "The MFA TOTP code."
  default     = null
}

# TODO: add support for variable "no_ephemeral" when Windows support is added

variable "profile" {
  type        = string
  description = "The profile to use in the shared credentials file for AWS."
  default     = ""
}

variable "region" {
  type        = string
  description = "The name of the region in which to launch the EC2 instance to create the AMI."
  default     = null
}

# TODO: add support for variable "region_kms_key_ids"

# TODO: add support for variable "role_arn"

variable "run_tags" {
  type        = map(string)
  description = "Key/value pair tags to apply to the instance that is that is launched to create the EBS volumes."
  default     = {}
}

variable "run_volume_tags" {
  type        = map(string)
  description = "Tags to apply to the volumes that are launched to create the AMI."
  default     = {}
}

variable "secret_key" {
  type        = string
  description = "The secret key used to communicate with AWS."
  default     = null
}

# TODO: add support for block variable "security_group_filter"

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security groups as to assign to the instance."
  default     = []
}

# variable "shared_credentials_file" {
#  type        = string
#  description = "Path to a credentials file to load credentials from."
# }

variable "shutdown_behavior" {
  type        = string
  description = "Automatically terminate instances on shutdown in case Packer exits ungracefully."
  default     = "stop"

  # TODO: add validation for valid values "stop" and "terminate"
}

variable "skip_create_ami" {
  type        = bool
  description = "If true, Packer will not create the AMI."
  default     = false
}

variable "skip_credential_validation" {
  type        = bool
  description = "Set to true if you want to skip validating AWS credentials before runtime."
  default     = false
}

variable "skip_metadata_api_check" {
  type        = bool
  description = "Skip Metadata API Check."
  default     = false
}

variable "skip_profile_validation" {
  type        = bool
  description = "Whether or not to check if the IAM instance profile exists."
  default     = false
}

variable "skip_region_validation" {
  type        = bool
  description = "Set to true if you want to skip validation of the ami_regions configuration option."
  default     = false
}

variable "skip_save_build_region" {
  type        = bool
  description = "If true, Packer will not check whether an AMI with the `ami_name` exists in the region it is building in."
  default     = false
}

variable "snapshot_groups" {
  type        = list(string)
  description = "A list of groups that have access to create volumes from the snapshot(s)."
  default     = []
}

variable "snapshot_tags" {
  type        = map(string)
  description = "Key/value pair tags to apply to snapshot."
  default     = {}
}

variable "snapshot_users" {
  type        = list(string)
  description = "A list of account IDs that have access to create volumes from the snapshot(s)."
  default     = []
}

# TODO: add support for block variable "source_ami_filter"

variable "ssh_username" {
  type        = string
  description = "The username to connect to SSH with."
  default     = "ubuntu"
}

variable "ssh_port" {
  type        = number
  description = "The port to connect to SSH."
  default     = "22"
}

variable "ssh_password" {
  type        = string
  description = "A plaintext password to use to authenticate with SSH."
  default     = ""
}

variable "ssh_clear_authorized_keys" {
  type        = bool
  description = "If true, Packer will attempt to remove its temporary keys."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Key/value pair tags applied to the AMI."
  default     = {}
}

# TODO: add support for variable "temporary_iam_instance_profile_policy_document"

variable "token" {
  type        = string
  description = "The access token to use."
  default     = null
}

# TODO: add support for block variable "vault_aws_engine"

locals {
  ami_name = var.ami_name == "" ? "TODO" : var.ami_name
}
