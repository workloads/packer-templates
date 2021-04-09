# see https://www.packer.io/docs/templates/hcl_templates/blocks/packer
packer {
  required_version = ">= 1.7.2"
}

# see https://www.packer.io/docs/datasources/amazon/ami
data "amazon-ami" "image" {
  filters = var.image.filters

  most_recent = var.image.most_recent
  owners      = var.image.owners
  region      = var.region
}

# see https://www.packer.io/docs/builders/amazon/ebs
source "amazon-ebs" "image" {
  # the following configuration represents a minimally viable selection
  # for all options see: https://www.packer.io/docs/builders/amazon/ebs

  ami_description = var.ami_description
  ami_name        = local.ami_name
  instance_type   = var.instance_type
  region          = var.region
  ssh_username    = var.ssh_username
  source_ami      = data.amazon-ami.image.id
  subnet_id       = var.subnet_id
  tags            = var.tags

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
    "source.file.version_description",
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
