# see https://developer.hashicorp.com/packer/docs/templates/hcl_templates/blocks/packer
packer {
  required_plugins {
    # see https://developer.hashicorp.com/packer/plugins/builders/parallels
    parallels = {
      # see https://github.com/Parallels/packer-plugin-parallels/releases
      version = "1.1.0"
      source  = "github.com/Parallels/parallels"
    }

    # see https://developer.hashicorp.com/packer/plugins/provisioners/ansible/ansible
    ansible = {
      # see https://github.com/hashicorp/packer-plugin-ansible/releases/
      version = "1.1.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso
source "parallels-iso" "main" {
  # see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#iso_url
  iso_url = var.source_image_file

  # see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#iso_checksum
  iso_checksum = var.source_image_checksum

  # see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#boot_command
  boot_command = var.template_boot_command

  # see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#boot_wait
  boot_wait = var.template_boot_wait

  cpus = var.parallels_cpus

  communicator = var.template_communicator

  disk_size = var.parallels_disk_size
  disk_type = var.parallels_disk_type

  guest_os_type = var.parallels_guest_os_type

  hard_drive_interface = var.parallels_hard_drive_interface

  http_bind_address = var.parallels_http_bind_address

  http_content = {
    # TODO: make path dynamic to take "identifier"
    "/user-data" = templatefile("../${var.dir_templates}/user-data/${var.template_os}.pkrtpl.yml", {
      hostname = var.template_image_hostname
      username = var.template_image_username

      # see https://developer.hashicorp.com/packer/docs/templates/hcl_templates/functions/crypto/bcrypt
      # bcrypt-encrypted password; may also be directly generated with `openssl passwd -6 -salt <salt> <password>`
      password = bcrypt(var.template_image_password)
    })

    "/meta-data" = ""
  }

  memory = var.parallels_memory

  output_directory = local.image.output_path

  parallels_tools_flavor = var.parallels_tools_flavor
  parallels_tools_mode   = var.parallels_tools_mode

  prlctl = local.parallels_prlctl_commands

  prlctl_post         = var.parallels_prlctl_post_commands
  prlctl_version_file = var.prlctl_version_file

  shutdown_command = var.parallels_shutdown_command
  shutdown_timeout = var.parallels_shutdown_timeout

  skip_compaction = var.parallels_skip_compaction

  sound = var.parallels_sound

  ssh_clear_authorized_keys = true
  ssh_password              = var.template_image_password
  ssh_port                  = var.template_communicator_port
  ssh_username              = var.template_image_username
  ssh_timeout               = var.template_communicator_timeout

  # disable USB support
  usb = var.parallels_usb

  vm_name = local.image.output_name
}
