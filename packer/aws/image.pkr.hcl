packer {
  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#version-constraint-syntax
  required_version = ">= 1.7.4"

  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#specifying-plugin-requirements
  required_plugins {
    # see # see https://github.com/hashicorp/packer-plugin-amazon/releases/
    amazon = {
      version = "0.0.1"
      source  = "github.com/hashicorp/amazon"
    }

    # see https://github.com/hashicorp/packer-plugin-ansible/releases/
    ansible = {
      version = "0.0.2"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

# see https://www.packer.io/docs/datasources/amazon/ami
data "amazon-ami" "image" {
  filters = {
    name                = "${var.source_image_family}/images/${var.ami_virtualization_type}-ssd/${var.source_image_name}"
    root-device-type    = "ebs"
    virtualization-type = var.ami_virtualization_type
  }

  most_recent = var.image.most_recent
  owners      = var.image.owners
  region      = var.region
}

# see https://www.packer.io/docs/builders/amazon/ebs
source "amazon-ebs" "image" {
  # the following configuration represents a curated variable selection
  # for all options see: https://www.packer.io/docs/builders/amazon/ebs

  ami_description             = var.ami_description
  ami_groups                  = var.ami_groups
  ami_name                    = local.ami_name
  ami_product_codes           = var.ami_product_codes
  ami_regions                 = var.ami_regions
  ami_users                   = var.ami_users
  ami_virtualization_type     = var.ami_virtualization_type
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone           = var.availability_zone

  aws_polling {
    delay_seconds = var.aws_polling.delay_seconds
    max_attempts  = var.aws_polling.max_attempts
  }

  communicator          = var.shared.communicator.type
  custom_endpoint_ec2   = var.custom_endpoint_ec2
  disable_stop_instance = var.disable_stop_instance
  ebs_optimized         = var.ebs_optimized
  enable_t2_unlimited   = var.enable_t2_unlimited
  ena_support           = var.ena_support
  encrypt_boot          = var.encrypt_boot
  force_delete_snapshot = var.force_delete_snapshot
  force_deregister      = var.force_deregister
  iam_instance_profile  = var.iam_instance_profile
  instance_type         = var.instance_type
  kms_key_id            = var.kms_key_id
  profile               = var.profile
  region                = var.region
  region_kms_key_ids    = var.region_kms_key_ids
  run_tags              = local.run_tags

  security_group_filter {
    filters = var.security_group_filter
  }

  security_group_ids           = var.security_group_ids
  shutdown_behavior            = var.shutdown_behavior
  skip_create_ami              = var.skip_create_ami
  skip_credential_validation   = var.skip_credential_validation
  skip_metadata_api_check      = var.skip_metadata_api_check
  skip_profile_validation      = var.skip_profile_validation
  skip_region_validation       = var.skip_region_validation
  skip_save_build_region       = var.skip_save_build_region
  snapshot_groups              = var.snapshot_groups
  snapshot_users               = var.snapshot_users
  ssh_clear_authorized_keys    = var.shared.communicator.ssh_clear_authorized_keys
  ssh_disable_agent_forwarding = var.shared.communicator.ssh_disable_agent_forwarding
  ssh_username                 = var.shared.communicator.ssh_username
  source_ami                   = data.amazon-ami.image.id
  subnet_id                    = var.subnet_id
  tags                         = local.tags
  vpc_id                       = var.vpc_id
}

# see https://www.packer.io/docs/builders/file
source "file" "image_configuration" {
  content = templatefile(var.shared.templates.configuration, {
    timestamp     = formatdate(var.shared.image_information_date_format, timestamp())
    configuration = yamlencode(var.shared)
  })

  target = var.shared.generated_files.configuration
}

# see https://www.packer.io/docs/builders/file
source "file" "image_information" {
  content = local.version_description
  target  = var.shared.generated_files.versions
}

build {
  name = "templates"

  sources = [
    "source.file.image_configuration",
    "source.file.image_information"
  ]
}

build {
  name = "provisioners"

  sources = [
    "source.amazon-ebs.image"
  ]

  # see https://www.packer.io/docs/provisioners/ansible
  provisioner "ansible" {
    ansible_env_vars = var.shared.ansible.ansible_env_vars
    command          = var.shared.ansible.command
    extra_arguments  = local.ansible_extra_arguments
    galaxy_file      = var.shared.ansible.galaxy_file
    playbook_file    = var.shared.ansible.playbook_file
  }
}
