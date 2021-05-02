packer {
  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#version-constraint-syntax
  required_version = ">= 1.7.2"

  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#specifying-plugin-requirements
  required_plugins {
    # see # see https://github.com/hashicorp/packer-plugin-amazon/releases/
    amazon = {
      version = ">= 0.0.1"
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
    name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    # local.image_filter_name
    root-device-type    = "ebs"
    virtualization-type = var.ami_virtualization_type
  }

  most_recent = var.image.most_recent
  owners      = var.image.owners
}

# see https://www.packer.io/docs/builders/amazon/ebs
source "amazon-ebs" "image" {
  # the following configuration represents a minimally viable selection
  # for all options see: https://www.packer.io/docs/builders/amazon/ebs

  ami_description = var.ami_description
  ami_name        = local.ami_name

  aws_polling {
    delay_seconds = var.aws_polling.delay_seconds
    max_attempts  = var.aws_polling.max_attempts
  }

  communicator       = var.shared.communicator.type
  ena_support        = var.ena_support
  encrypt_boot       = var.encrypt_boot
  instance_type      = var.instance_type
  kms_key_id         = var.kms_key_id
  region             = var.region
  region_kms_key_ids = var.region_kms_key_ids

  security_group_filter {
    filters = var.security_group_filter
  }

  ssh_clear_authorized_keys    = var.shared.communicator.ssh_clear_authorized_keys
  ssh_disable_agent_forwarding = var.shared.communicator.ssh_disable_agent_forwarding
  ssh_username                 = var.shared.communicator.ssh_username
  source_ami                   = data.amazon-ami.image.id
  subnet_id                    = var.subnet_id
  tags                         = local.tags
}

# see https://www.packer.io/docs/builders/file
source "file" "image_configuration" {
  content = templatefile(var.shared.templates.configuration, {
    timestamp     = formatdate(var.shared.image_version_date_format, timestamp())
    configuration = yamlencode(var.shared)
  })

  target = var.shared.generated_files.configuration
}

# see https://www.packer.io/docs/builders/file
source "file" "version_description" {
  content = local.version_description
  target  = var.shared.generated_files.versions
}

build {
  name = "templates"

  sources = [
    "source.file.image_configuration",
    "source.file.version_description"
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

  # see https://www.packer.io/docs/post-processors/checksum#checksum-post-processor
  post-processor "checksum" {
    checksum_types = var.shared.checksum_types
    output         = var.shared.checksum_output
  }
}
