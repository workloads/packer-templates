packer {
  required_plugins {
    # see https://www.packer.io/plugins/builders/vagrant
    vagrant = {
      # see https://github.com/hashicorp/packer-plugin-vagrant/releases/
      version = ">= 1.0.3"
      source  = "github.com/hashicorp/vagrant"
    }

    # see https://www.packer.io/plugins/provisioners/ansible/ansible
    ansible = {
      # see https://github.com/hashicorp/packer-plugin-ansible/releases/
      version = ">= 1.0.3"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

# see https://www.packer.io/plugins/builders/vagrant
source "vagrant" "template" {
  # the following configuration represents a curated variable selection
  # for all options see: https://www.packer.io/plugins/builders/vagrant#optional

  add_force                    = var.add_force
  box_name                     = "todo-renameme"
  box_version                  = local.sources[var.os][var.target].source.version
  checksum                     = "sha256:${local.sources[var.os][var.target].source.checksum}"
  communicator                 = "ssh"
  output_dir                   = "${var.dist_dir}/${var.target}"
  provider                     = "virtualbox"
  skip_add                     = var.skip_add
  source_path                  = local.sources[var.os][var.target].source.path
  ssh_clear_authorized_keys    = var.shared.communicator.ssh_clear_authorized_keys
  ssh_disable_agent_forwarding = var.shared.communicator.ssh_disable_agent_forwarding
  #ssh_username                 = local.sources[var.os][var.target].username
  teardown_method = var.teardown_method
  template        = "./packer/${var.target}/Vagrantfile"
}

build {
  name = "1-provisioners"

  sources = [
    "source.vagrant.template"
  ]

  # see https://www.packer.io/plugins/provisioners/ansible/ansible
  provisioner "ansible" {
    ansible_env_vars   = var.shared.ansible.ansible_env_vars
    command            = var.shared.ansible.command
    extra_arguments    = local.ansible_extra_arguments
    galaxy_file        = var.shared.ansible.galaxy_file
    playbook_file      = var.shared.ansible.playbook_file
    skip_version_check = var.shared.ansible.skip_version_check
  }

  # see https://www.packer.io/docs/post-processors/checksum#checksum-post-processor
  post-processor "checksum" {
    checksum_types = var.shared.checksum_types
    output         = local.templates.checksum.output
  }
}
