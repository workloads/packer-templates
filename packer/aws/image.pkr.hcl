# see https://www.packer.io/docs/templates/hcl_templates/blocks/packer
packer {
  required_version = ">= 1.7.1"
}

# see https://www.packer.io/docs/builders/amazon/ebs
source "amazon-ebs" "image" {
  # the following configuration represents a minimally viable selection
  # for all options see: https://www.packer.io/docs/builders/amazon/ebs

  access_key = var.access_key

  # TODO: add support for block variable "ami_block_device_mappings"

  ami_description             = var.ami_description
  ami_name                    = local.ami_name
  ami_groups                  = var.ami_groups
  ami_product_codes           = var.ami_product_codes
  ami_regions                 = var.ami_regions
  ami_users                   = var.ami_users
  ami_virtualization_type     = var.ami_virtualization_type
  associate_public_ip_address = var.associate_public_ip_address

  # TODO: add support for block variable "assume_role"

  availability_zone = var.availability_zone

  # TODO: add support for block variable "aws_polling"

  # TODO: add support for variable "block_duration_minutes"

  custom_endpoint_ec2           = var.custom_endpoint_ec2
  decode_authorization_messages = var.decode_authorization_messages
  disable_stop_instance         = var.disable_stop_instance
  ebs_optimized                 = var.ebs_optimized
  enable_t2_unlimited           = var.enable_t2_unlimited
  # TODO: add support for variable "ena_support"

  # TODO: add support for variable "encrypt_boot"

  # TODO: add support for variable "engine_name"

  force_delete_snapshot    = var.force_delete_snapshot
  force_deregister         = var.force_deregister
  iam_instance_profile     = var.iam_instance_profile
  instance_type            = var.instance_type
  insecure_skip_tls_verify = var.insecure_skip_tls_verify

  # TODO: add support for variable "kms_key_id"

  # TODO: add support for block variable "launch_block_device_mappings"

  max_retries = var.max_retries
  mfa_code    = var.mfa_code

  # TODO: add support for variable "no_ephemeral" when Windows support is added

  profile = var.profile
  region  = var.region

  # TODO: add support for variable "region_kms_key_ids"

  run_tags           = var.run_tags
  run_volume_tags    = var.run_volume_tags
  secret_key         = var.secret_key
  security_group_ids = var.security_group_ids

  # TODO: add support for block variable "security_group_filter"

  # shared_credentials_file    = var.shared_credentials_file

  shutdown_behavior = var.shutdown_behavior

  skip_create_ami            = var.skip_create_ami
  skip_credential_validation = var.skip_credential_validation
  skip_metadata_api_check    = var.skip_metadata_api_check
  skip_profile_validation    = var.skip_profile_validation
  skip_region_validation     = var.skip_region_validation
  skip_save_build_region     = var.skip_save_build_region
  snapshot_groups            = var.snapshot_groups
  snapshot_tags              = var.snapshot_tags
  snapshot_users             = var.snapshot_users

  # TODO: add support for block variable "source_ami_filter"

  ssh_username              = var.ssh_username
  ssh_port                  = var.ssh_port
  ssh_password              = var.ssh_password
  ssh_clear_authorized_keys = var.ssh_clear_authorized_keys

  tags  = var.tags
  token = var.token

  # TODO: add support for variable "vault_aws_engine"
}

# see https://www.packer.io/docs/builders/file
source "file" "image_configuration" {
  content = yamlencode(var.build_config)
  target  = var.build_config.generated_files.configuration
}

# see https://www.packer.io/docs/builders/file
source "file" "version_description" {
  content = local.version_description
  target  = var.build_config.generated_files.versions
}

build {
  sources = [
    "source.file.image_configuration",
    "source.file.version_description"
  ]
}

build {
  sources = [
    "source.amazon-ebs.image"
  ]

  # see https://www.packer.io/docs/provisioners/ansible
  provisioner "ansible" {
    ansible_env_vars = var.build_config.ansible_env_vars
    playbook_file    = var.build_config.playbook_file
    command          = var.build_config.command
    extra_arguments  = var.build_config.extra_arguments
  }
}
