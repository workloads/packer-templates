packer {
  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#version-constraint-syntax
  required_version = ">= 1.7.8"

  # see https://www.packer.io/docs/templates/hcl_templates/blocks/packer#specifying-plugin-requirements
  required_plugins {
    # see https://github.com/hashicorp/packer-plugin-digitalocean/releases/
    digitalocean = {
      version = "1.0.1"
      source  = "github.com/hashicorp/digitalocean"
    }

    # see https://github.com/hashicorp/packer-plugin-ansible/releases/
    ansible = {
      version = "1.0.1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

# see https://www.packer.io/plugins/builders/digitalocean
source "digitalocean" "image" {
  # the following configuration represents a curated variable selection
  # for all options see: https://www.packer.io/plugins/builders/digitalocean

  # DIGITALOCEAN_API_TOKEN
  api_token = "791707bd3a10a76ef5ca2278be8cb4d77f48b295cbad3114f5324585627adda5"
  region    = "ams3"
  size      = "s-1vcpu-1gb"
  image     = "ubuntu-20-04-x64"
  ssh_username = "root"

  private_networking = false
  monitoring         = false
  ipv6               = false
  snapshot_name      = "test"
  #  snapshot_regions = ""
  state_timeout    = "60m"
  snapshot_timeout = "60m"
  droplet_name     = "hashicorp-ubuntu"
  #  user_data = "TODO"
  #  user_data_file = "TODO"
  #  tags = "TODO"
  #  vpc_uuid = "TODO"
  connect_with_private_ip = false
  #  ssh_key_id = "TODO"
  #  ssh_private_key_file = "TODO"
}

## see https://www.packer.io/docs/builders/file
#source "file" "image_configuration" {
#  content = templatefile(var.shared.templates.configuration, {
#    timestamp     = formatdate(var.shared.image_information_date_format, timestamp())
#    configuration = yamlencode(var.shared)
#  })
#
#  target = var.shared.generated_files.configuration
#}

## see https://www.packer.io/docs/builders/file
#source "file" "image_information" {
#  content = local.version_description
#  target  = var.shared.generated_files.versions
#}

#build {
#  name = "templates"
#
#  sources = [
#    "source.file.image_configuration",
#    "source.file.image_information"
#  ]
#}


build {
  name = "provisioners"

  sources = [
    "source.digitalocean.image"
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
