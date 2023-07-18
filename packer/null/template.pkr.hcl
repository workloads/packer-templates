packer {
  required_plugins {
    # see https://developer.hashicorp.com/packer/plugins/provisioners/ansible/ansible
    ansible = {
      # see https://github.com/hashicorp/packer-plugin-ansible/releases/
      version = "1.1.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

## TODO: add support for provisioning local Ansible environment
#
## see https://developer.hashicorp.com/packer/docs/builders/null
#source "null" "main" {
#    ssh_host     = "0.0.0.0" # TODO: get IP from CLI input
#    ssh_username = "vagrant" # TODO: get username from CLI input
#    ssh_password = "vagrant" # TODO: get password from CLI input
#}
#
## see https://developer.hashicorp.com/packer/docs/templates/hcl_templates/blocks/build
#build {
#  name = "1-provisioners"
#
#  sources = [
#    "source.null.main",
#  ]
#
#  # see https://developer.hashicorp.com/packer/plugins/provisioners/ansible/ansible
#  provisioner "ansible" {
#    ansible_env_vars   = var.ansible_env_vars
#    command            = var.ansible_command
#    extra_arguments    = local.ansible_extra_arguments
#    galaxy_file        = var.ansible_galaxy_file
#    playbook_file      = var.ansible_playbook_file
#    skip_version_check = var.ansible_skip_version_check
#  }
#}
