# Parallels-specific configuration

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#guest_os_type
parallels_guest_os_type = "ubuntu"

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#parallels_tools_flavor
parallels_tools_flavor = "lin"

# Source Image-specific configuration
source_image_file     = "https://releases.ubuntu.com/jammy/ubuntu-22.04.2-live-server-amd64.iso"
source_image_checksum = "file:https://releases.ubuntu.com/jammy/SHA256SUMS"

# Template-specific configuration
template_boot_command = [
  # enter Grub and wait for it to be ready
  "c",
  "<wait>",

  # load Live Server-specific kernel and set autoinstall parameters
  "linux /casper/vmlinuz --- ",
  "autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'",
  "<enter><wait>",

  # load initrd
  "initrd /casper/initrd",
  "<enter><wait>",

  # boot the kernel
  "boot",
  "<enter>",
]

template_image_hostname = "ubuntu"
template_image_password = "ubuntu"
template_image_username = "ubuntu"
