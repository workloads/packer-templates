# This file contains shared configurations.
#
# The contents are made available to ALL Packer Templates through a symlink
# from `/packer/<target>/shared.pkr.hcl` to `/packer/shared.pkr.hcl`.

# Advanced Users only: Dev Mode installs packages that are helpful
# when developing on one or more of the installed HashiCorp products;
variable "dev_mode" {
  type        = bool
  description = "Toggle to enable Dev Mode and configure developer-friendly tooling."
  default     = false
}

variable "dist_dir" {
  type        = string
  description = "Directory to store distributable artifacts in."
}

variable "shared" {
  type = object({
    enable_cis_hardening    = bool
    enable_debug_statements = bool
    enable_facts_statement  = bool

    ansible = object({
      ansible_env_vars   = list(string)
      command            = string
      galaxy_file        = string
      playbook_file      = string
      skip_version_check = bool
    })

    checksum_types = list(string)

    communicator = object({
      ssh_clear_authorized_keys    = bool
      ssh_disable_agent_forwarding = bool
    })

    os = object({
      enabled = bool

      directories = map(object({
        to_create = list(string)
        to_remove = list(string)
      }))

      toggles = map(bool)

      packages = map(object({
        to_install = list(string)
        to_remove  = list(string)
      }))
    })

    post_cleanup = object({
      enabled = bool
    })
  })

  description = "Shared Configuration for all Packer Templates."

  default = {
    # Enable Ansible-Lockdown CIS roles for OS-hardening
    enable_cis_hardening = false

    # feature flag to enable debug statements
    enable_debug_statements = true

    # feature flag to enable printing of Ansible Facts
    enable_facts_statement = false

    # Ansible-specific configuration:
    ansible = {
      # Environment variables to set before running Ansible
      # When in doubt, edit `ansible/ansible.cfg` instead of `ansible_env_vars`
      ansible_env_vars = [
        "ANSIBLE_CONFIG=ansible/ansible.cfg",
      ]

      # The command to invoke Ansible with.
      command = "ansible-playbook"

      # A requirements file which provides a way to install roles with the `ansible-galaxy` CLI on the remote machine.
      galaxy_file = "./ansible/requirements.yml"

      # The playbook to be run by Ansible.
      playbook_file = "./ansible/playbooks/main.yml"

      skip_version_check = true
    }

    # Packer Checksum Post-Processor configuration
    # see https://developer.hashicorp.com/packer/docs/post-processors/checksum#checksum_types
    checksum_types = [
      "sha256"
    ]

    # Packer Machine Communicator-specific configuration:
    communicator = {
      # If true, Packer will attempt to remove its temporary keys.
      ssh_clear_authorized_keys = true

      # If true, SSH agent forwarding will be disabled.
      ssh_disable_agent_forwarding = true
    }

    # OS-specific configuration
    os = {
      enabled = true

      # Directories to create and remove
      directories = {
        # Amazon Linux directories to lifecycle
        Amazon = {
          to_create = []
          to_remove = []
        }

        # Debian / Ubuntu directories to lifecycle
        Debian = {
          to_create = []
          to_remove = []
        }

        # generic Linux directories to lifecycle
        Linux = {
          to_create = []

          to_remove = [
            "/etc/machine-id",
            "/tmp/ansible",
            "/var/lib/dbus/machine-id"
          ]
        }
      }

      # Packages to install and remove
      packages = {
        # Amazon Linux packages to lifecycle
        Amazon = {
          to_install = [
            "amazon-ssm-agent"
          ]

          to_remove = []
        }

        # Debian / Ubuntu packages to lifecycle
        Debian = {
          to_install = [
            "apt-transport-https",
          ]

          to_remove = [
            "ubuntu-release-upgrader-core"
          ]
        }

        # generic Linux packages to lifecycle
        Linux = {
          to_install = [
            "ca-certificates",
            "curl", # see https://curl.se
            "gnupg",
            "jq", # see https://stedolan.github.io/jq/
            "libcap2",
            "lsb-release",
            "nano",
            "podman",
            "sudo",
            "unzip",
          ]

          to_remove = [
            "dosfstools",
            "ftp",
            "fuse",
            "ntfs-3g",
            "ntp",
            "open-iscsi",
            "pastebinit",
            "snapd",
          ]
        }
      }

      toggles = {
        copy_nologin_file  = true
        copy_versions_file = true
        create_directories = true
        install_packages   = true
        remove_directories = true
        remove_packages    = true
        update_apt_cache   = true
        update_yum_cache   = true
      }
    }

    # Post-Cleanup Actions
    post_cleanup = {
      enabled = true
    }
  }
}

# `os` as received from `make`
variable "os" {
  type        = string
  description = "Build OS as received from `make`."
}

# `target` as received from `make`
variable "target" {
  type        = string
  description = "Build Target as received from `make`."
}

locals {
  # see https://developer.hashicorp.com/packer/plugins/provisioners/ansible/ansible-local#extra_arguments
  ansible_extra_arguments = [
    # set verbosity level
    #"-v",
    "--extra-vars", "ConfigFile=../../${local.templates.configuration.output} InfoFile=../../${local.templates.information.output}",
  ]

  # Nomad Plugins-specific information
  nomad_plugins = {
    hashicorp_base_url = "https://releases.hashicorp.com"
    destination        = "/tmp" # "/var/lib/nomad/plugins" # TODO: change

    plugins = {
      # see https://github.com/Roblox/nomad-driver-containerd
      nomad-driver-containerd = {
        url = "https://github.com/Roblox/nomad-driver-containerd/releases/download/v0.9.3/containerd-driver"
      }

      # see https://releases.hashicorp.com/nomad-driver-ecs/
      nomad-driver-ecs = {
        # is this an official plugin? (e.g.: is it on `releases.hashicorp.com`)
        official = true
        version  = "0.1.0"
      }

      # see https://releases.hashicorp.com/nomad-driver-lxc/
      nomad-driver-lxc = {
        # is this an official plugin? (e.g.: is it on `releases.hashicorp.com`)
        official = true
        version  = "0.1.0"
      }

      # see https://releases.hashicorp.com/nomad-driver-podman/
      nomad-driver-podman = {
        # is this an official plugin? (e.g.: is it on `releases.hashicorp.com`)
        official = true
        version  = "0.4.0"
      }
    }
  }

  repositories = {
    docker = {
      create_user  = true
      create_group = true

      packages = {
        to_remove = [
          "docker",
          "docker-engine",
          "docker.io",
          "containerd",
          "runc",
        ]

        to_install = [
          {
            # see https://github.com/containerd/containerd/releases/
            name    = "containerd.io"
            version = "1.6.*"
          },
          {
            # see https://docs.docker.com/engine/release-notes/
            name    = "docker-ce"
            version = "5:20.10.*"
          },
          {
            # see https://docs.docker.com/engine/release-notes/
            name    = "docker-ce-cli"
            version = "5:20.10.*"
          },
        ]
      }
    }

    hashicorp = {
      create_user  = true
      create_group = true

      packages = {
        to_remove = []

        to_install = [
          {
            # see https://releases.hashicorp.com/boundary-worker/
            name    = "boundary-worker-hcp"
            version = "0.10.5+hcp-*"
          },
          {
            # see https://releases.hashicorp.com/consul/
            name    = "consul"
            version = "1.13.2-*"
          },
          {
            # see https://releases.hashicorp.com/hcdiag/
            name    = "hcdiag"
            version = "0.4.0-*"
          },
          {
            # see https://releases.hashicorp.com/nomad/
            name    = "nomad"
            version = "1.3.5-*"
          },
          {
            # see https://releases.hashicorp.com/nomad-autoscaler/
            name    = "nomad-autoscaler"
            version = "0.3.7-*"
          },
          # TODO: add when `tfc-agent` is available via Releases
          #{
          #  # see https://releases.hashicorp.com/tfc-agent/
          #  name    = "tfc-agent"
          #  version = "1.3.0"
          #},
          {
            # see https://releases.hashicorp.com/vault/
            name    = "vault"
            version = "1.11.3-*"
          }
        ]
      }
    }

    osquery = {
      create_user  = false
      create_group = false

      packages = {
        to_remove = []

        to_install = [
          {
            # see https://osquery.io/downloads/official/
            name    = "osquery"
            version = "5.4.0-*"
          }
        ]
      }
    }
  }

  # mappings table for OS source image and connection information
  sources = {
    # Ubuntu 20.04 LTS (Focal Fossa)
    # see https://releases.ubuntu.com/20.04/
    ubuntu20 = {
      vagrant = {
        communicator = "ssh"

        # see https://app.vagrantup.com/ubuntu/boxes/focal64
        source = {
          # see https://cloud-images.ubuntu.com/focal/current/SHA256SUMS
          checksum = "sha256:49b0eef456a741fe462968f4d35f29feaee7410e1b737957aeb2d2fb56daa2a4"
          path     = "ubuntu/focal64"
          version  = "20220920.0.0"
        }

        username = "ubuntu"
      }
    }

    # Ubuntu 22.04 LTS (Jammy Jellyfish)
    # see https://releases.ubuntu.com/22.04/
    ubuntu22 = {
      vagrant = {
        communicator = "ssh"

        # see https://app.vagrantup.com/ubuntu/boxes/jammy64
        source = {
          # see https://cloud-images.ubuntu.com/jammy/current/SHA256SUMS
          checksum = "sha256:df56aae7251548bea361db4ca015a9a8075c8e68229abb4c4d8e4944df8a22ea"
          path     = "ubuntu/jammy64"
          version  = "20220921.1.0"
        }

        tools = {
          docker = {
            component = "stable"
            key       = "https://download.docker.com/linux/ubuntu/gpg"
            packages  = local.repositories.docker.packages
            url       = "https://download.docker.com/linux/ubuntu"
          }

          hashicorp = {
            component = "main"
            key       = "https://apt.releases.hashicorp.com/gpg"
            packages  = local.repositories.hashicorp.packages
            url       = "https://apt.releases.hashicorp.com"
          }

          osquery = {
            component = "main"

            # Key ID can be retrieved from https://osquery.io/downloads/ (`Alternative Install Options`)
            # and can then be mapped to a PGP Public Key block using the upstream Keyserver (`pub`)
            key      = "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x1484120ac4e9f8a1a577aeee97a80c63c9d8b80b"
            packages = local.repositories.osquery.packages
            url      = "https://pkg.osquery.io/deb"
          }
        }

        username = "ubuntu"
      }
    }
  }

  # Packer-generated Template file naming configuration:
  templates = {
    # these paths are relative to the Packer Builder target
    configuration = {
      input  = "../templates/configuration.pkrtpl.yml"
      output = "${var.dist_dir}/configuration.yml"
    }

    # see https://developer.hashicorp.com/packer/docs/post-processors/checksum#output
    checksum = {
      output = "${var.dist_dir}/${var.target}/checksum.txt"
    }

    information = {
      input  = "../templates/information.pkrtpl.md"
      output = "${var.dist_dir}/README.md"
    }
  }

  # Packer Image-specific configuration
  image = {
    name    = var.dev_mode ? "${var.os}-${var.target}-dev" : "${var.os}-${var.target}"
    version = local.timestamp.iso
  }

  timestamp = {
    iso   = formatdate("YYYYMMDD-hhmmss", timestamp())
    human = formatdate("YYYY-MM-DD 'at' hh:mm:ss '('ZZZZ')'", timestamp())
  }
}

# see https://developer.hashicorp.com/packer/docs/builders/file
source "file" "configuration" {
  content = templatefile(local.templates.configuration.input, {
    timestamp = local.timestamp.human

    # merge common config (`var.shared`) and "tools" configuration,
    # then YAML-encode it for consumption through Ansible
    configuration = yamlencode(
      merge(var.shared, {
        dev_mode      = var.dev_mode,
        nomad_plugins = local.nomad_plugins,
        tools         = local.sources[var.os][var.target].tools,
      })
    )
  })

  target = local.templates.configuration.output
}

locals {
  # `local.information_input` is used to create an in-image `README.md` file
  # and for provider-specific cases such as Vagrant Cloud Box Descriptions
  information_input = templatefile(local.templates.information.input, {
    image = merge(local.image, {
      dev_mode  = var.dev_mode,
      timestamp = local.timestamp.human,
    })

    shared = merge(var.shared, {
      nomad_plugins = local.nomad_plugins,
      tools         = local.sources[var.os][var.target].tools,
    })
  })
}

# see https://developer.hashicorp.com/packer/docs/builders/file
source "file" "information" {
  content = local.information_input
  target  = local.templates.information.output
}

# see https://developer.hashicorp.com/packer/docs/templates/hcl_templates/blocks/build
build {
  name = "0-templates"

  sources = [
    "source.file.configuration",
    "source.file.information"
  ]
}