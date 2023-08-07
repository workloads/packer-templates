# Parallels-specific configuration

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#guest_os_type
parallels_guest_os_type = "ubuntu"

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#parallels_tools_flavor
parallels_tools_flavor = "lin-arm"

# Source Image-specific configuration
source_image_file     = "https://cdimage.ubuntu.com/releases/22.04/release/ubuntu-22.04.2-live-server-arm64.iso"
source_image_checksum = "file:https://releases.ubuntu.com/jammy/SHA256SUMS"

# Template-specific configuration
template_boot_command = [
"<wait>c<wait>set gfxpayload=keep<enter><wait>linux /casper/vmlinuz quiet autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ ---<enter><wait>initrd /casper/initrd<wait><enter><wait>boot<enter><wait>"]

template_image_hostname = "ubuntu"
template_image_password = "ubuntu"
template_image_username = "ubuntu"
