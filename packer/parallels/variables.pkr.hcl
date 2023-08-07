# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#cpus
variable "parallels_cpus" {
  type        = number
  description = "Number of CPUs to use for building the VM."
  default     = 2
}

variable "parallels_dev_tools" {
  type        = bool
  description = "Toggle to enable Developer Tools in the VM."
  default     = false
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#disk_size
variable "parallels_disk_size" {
  type        = number
  description = "Size of the Virtual Disk Drive to create for the VM."
  default     = 65536 # value is in MB
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#disk_type
variable "parallels_disk_type" {
  type        = string
  description = "Type of Virtual Disk Drive to create for the VM."
  default     = "expand"
}

# enable OS-specific performance optimizations, possible values available via `prlctl create x --distribution list`
# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#guest_os_type
variable "parallels_guest_os_type" {
  type        = string
  description = "OS Type identifier for OS-specific performance optimizations."
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#hard_drive_interface
variable "parallels_hard_drive_interface" {
  type        = string
  description = "Type of Controller that attaches to the Virtual Disk Drive."
  default     = "sata"
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#http_bind_address
variable "parallels_http_bind_address" {
  type        = string
  description = "Address to bind HTTP Server to."
  default     = "0.0.0.0"
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#memory
variable "parallels_memory" {
  type        = number
  description = "Amount of memory to use for building the VM."
  default     = 4096 # value is in MB
}

# see https://download.parallels.com/desktop/v18/docs/en_US/Parallels%20Desktop%20Command-Line%20Reference/
# and https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#prlctl-commands
variable "parallels_prlctl_commands" {
  default = []
}

# TODO re-enable
variable "_parallels_prlctl_commands" {
  type        = list(list(string))
  description = "Custom `prlctl` commands to execute to customize the VM."

  default = [
    # disable 3D acceleration
    ["set", "{{ .Name }}", "--3d-accelerate", "off"],

    # enable automatic compression after VM is shut down
    ["set", "{{ .Name }}", "--auto-compress", "on"],

    # disable Bluetooth, webcam, gamepad and SmartCard sharing
    ["set", "{{ .Name }}", "--auto-share-bluetooth", "off"],
    ["set", "{{ .Name }}", "--auto-share-camera", "off"],
    ["set", "{{ .Name }}", "--auto-share-gamepad", "off"],
    ["set", "{{ .Name }}", "--auto-share-smart-card", "off"],

    # disable VM autostart
    ["set", "{{ .Name }}", "--autostart", "off"],

    # disable battery status sharing
    ["set", "{{ .Name }}", "--battery-status", "off"],

    ["set", "{{ .Name }}", "--bounce-dock-icon-when-app-flashes", "off"],
    ["set", "{{ .Name }}", "--cpu-type", "arm"],

    # set number of virtual CPUs, value is in number of cores
    ["set", "{{ .Name }}", "--cpus", "2"],

    # enable optimizations for a faster VM
    ["set", "{{ .Name }}", "--faster-vm", "on"],

    # enable high-resolution mode
    ["set", "{{ .Name }}", "--high-resolution", "on"],

    # isolate VM from host
    ["set", "{{ .Name }}", "--isolate-vm", "on"],

    # disable keyboard optimization
    ["set", "{{ .Name }}", "--keyboard-optimize", "off"],

    # disable battery optimization in favor of faster VM
    ["set", "{{ .Name }}", "--longer-battery-life", "off"],

    # set amount of memory available to the VM, value is in MB
    ["set", "{{ .Name }}", "--memsize", "4096"],

    # close VM window after VM is shut down
    ["set", "{{ .Name }}", "--on-shutdown", "close"],

    # keep VM running after window is closed
    ["set", "{{ .Name }}", "--on-window-close", "keep-running"],

    # disable pausing of idle VM
    ["set", "{{ .Name }}", "--pause-idle", "off"],

    # remove resource constraints for the VM
    ["set", "{{ .Name }}", "--resource-quota", "unlimited"],

    # disable sharing guest applications with the host
    ["set", "{{ .Name }}", "--sh-app-guest-to-host", "off"],

    # disable sharing host applications with the VM
    ["set", "{{ .Name }}", "--sh-app-host-to-guest", "off"],

    # enable shared clipboard
    ["set", "{{ .Name }}", "--shared-clipboard", "on"],

    # disable shared Cloud functionality and shared profile
    ["set", "{{ .Name }}", "--shared-cloud", "off"],
    ["set", "{{ .Name }}", "--shared-profile", "off"],

    # disable sharing of user-defined VM folders
    ["set", "{{ .Name }}", "--shf-guest", "off"],

    # disables VM applications listing in Dock
    ["set", "{{ .Name }}", "--show-guest-app-folder-in-dock", "off"],

    # disable VM notifications
    ["set", "{{ .Name }}", "--show-guest-notifications", "off"],

    # disable shared mounts
    ["set", "{{ .Name }}", "--smart-mount", "off"],

    # disable mouse optimization
    ["set", "{{ .Name }}", "--smart-mouse-optimize", "off"],

    # enable smooth scrolling
    ["set", "{{ .Name }}", "--smooth-scrolling", "on"],

    # start VM in headless mode
    ["set", "{{ .Name }}", "--startup-view", "headless"],

    # disable sticky mouse
    ["set", "{{ .Name }}", "--sticky-mouse", "off"],

    # disable support for USB 3.0
    ["set", "{{ .Name }}", "--support-usb30", "off"],

    # disable host printer synchronization
    ["set", "{{ .Name }}", "--sync-default-printer", "off"],
    ["set", "{{ .Name }}", "--sync-host-printers", "off"],

    # enable time synchronization with the host
    ["set", "{{ .Name }}", "--time-sync", "on"],

    # disable updating of Parallels Tools Agent
    ["set", "{{ .Name }}", "--tools-autoupdate", "no"],

    # disable TPM support
    ["set", "{{ .Name }}", "--tpm", "off"],

    # disable Travel Mode
    ["set", "{{ .Name }}", "--travel-enter", "never"],
    ["set", "{{ .Name }}", "--travel-quit", "never"],

    # disable undo-disk mechanic
    ["set", "{{ .Name }}", "--undo-disks", "off"],

    # value in MB
    ["set", "{{ .Name }}", "--videosize", "1024"],

    # enable VSync
    ["set", "{{.Name }}", "--vertical-sync", "on"]
  ]
}

# see https://download.parallels.com/desktop/v18/docs/en_US/Parallels%20Desktop%20Command-Line%20Reference/
# and https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#prlctl_post
variable "parallels_prlctl_post_commands" {
  type        = list(list(string))
  description = "Custom `prlctl` commands to execute to customize the VM."

  default = []
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#shutdown_command
variable "parallels_shutdown_command" {
  type        = string
  description = "Command to use to gracefully shut down the VM."
  default     = "sudo shutdown -h now"
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#shutdown_timeout
variable "parallels_shutdown_timeout" {
  type        = string
  description = "Amount of time to wait after executing `shutdown_command`."
  default     = "15m"
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#skip_compaction
variable "parallels_skip_compaction" {
  type        = bool
  description = "Toggle to skip Virtual Disk Drive compaction."
  default     = false
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#sound
variable "parallels_sound" {
  type        = bool
  description = "Toggle to enable Sound Devices in the VM."
  default     = false
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#parallels_tools_flavor
variable "parallels_tools_flavor" {
  type        = string
  description = "Flavor of Parallels Tools to install on the VM."
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#parallels_tools_mode
variable "parallels_tools_mode" {
  type        = string
  description = "Method to use to make Parallels Tools disk image available to the VM."

  # valid options are `upload`, `attach`, or `disable`
  default = "disable"
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#usb
variable "parallels_usb" {
  type        = bool
  description = "Toggle to enable USB Devices in the VM."
  default     = false
}

# see https://developer.hashicorp.com/packer/plugins/builders/parallels/iso#prlctl_version_file
variable "prlctl_version_file" {
  type        = string
  description = "Path in the VM to store `prlctl` version information at."
  default     = ".prlctl_version"
}

locals {
  # merge static and dynamic `prlctl` commands
  # see https://developer.hashicorp.com/packer/docs/templates/hcl_templates/functions/collection/concat
  parallels_prlctl_commands = concat(var.parallels_prlctl_commands, [
    # set VM description
    ["set", "{{ .Name }}", "--description", local.image.description],

    # set VM distribution type
    ["set", "{{ .Name }}", "--distribution", var.parallels_guest_os_type],

    # enable Parallels Developer Tools in Menu if `var.parallels_dev_tools` is true
    ["set", "{{ .Name }}", "--show-dev-tools", var.parallels_dev_tools ? "on" : "off"],
  ])
}
