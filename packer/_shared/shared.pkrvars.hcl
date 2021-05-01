# these variables are shared across all images
shared = {
  # feature flag to enable debug statements
  enable_debug_statements = true

  ansible = {
    # Environment variables to set before running Ansible
    # When in doubt, edit `ansible/ansible.cfg` instead of `ansible_env_vars`
    ansible_env_vars = [
      "ANSIBLE_CONFIG=ansible/ansible.cfg"
    ]

    # The command to invoke Ansible with.
    command = "ansible-playbook"

    # Extra arguments to pass to Ansible
    extra_arguments = [
      # "-v",
    ]

    # A requirements file which provides a way to install roles with the `ansible-galaxy` CLI on the remote machine.
    galaxy_file = "./ansible/requirements.yml"

    # The playbook to be run by Ansible.
    playbook_file = "./ansible/playbooks/main.yml"
  }

  checksum_output = "generated/{{.BuildName}}_{{.BuilderType}}_{{.ChecksumType}}.checksum"
  checksum_types  = ["sha256"]

  communicator = {
    # If true, Packer will attempt to remove its temporary keys.
    ssh_clear_authorized_keys = true

    # If true, SSH agent forwarding will be disabled.
    ssh_disable_agent_forwarding = false

    # The username to connect to SSH with.
    ssh_username = "ubuntu"

    # Which communicator to use when initializing a build.
    type = "ssh"
  }

  docker = {
    enabled = true

    packages = [
      { # see https://docs.docker.com/engine/release-notes/
        name    = "docker-ce"
        version = "5:20.10.6*"
      },
      { # see https://github.com/containerd/containerd/releases/
        name    = "containerd.io"
        version = "*"
      }
    ]

    repository = {
      keyring = "/usr/share/keyrings/docker-ce-archive-keyring.gpg"
      url     = "https://download.docker.com/linux/ubuntu"
    }

    toggles = {
      # add Docker APT / YUM repository
      add_repository = true

      # create `docker` Group
      create_group = true

      # create `docker` User
      create_user = true

      # install Docker Packages
      install_packages = true
    }
  }

  generated_files = {
    configuration = "generated/generated-configuration.yml"
    versions      = "generated/version-information.md"
  }

  hashicorp = {
    enabled = true

    # package definitions (name and version) for HashiCorp Nomad Plugins
    nomad_plugins = [
      { # see https://releases.hashicorp.com/nomad-driver-podman/
        name    = "nomad-driver-podman"
        version = "0.2.0"
      },
      { # see https://releases.hashicorp.com/nomad-driver-lxc/
        name    = "nomad-driver-lxc"
        version = "0.1.0"
      },
      { # see https://releases.hashicorp.com/nomad-autoscaler/
        name    = "nomad-autoscaler"
        version = "0.3.0"
      }
    ]

    # package definitions (name and version) for HashiCorp products
    packages = [
      { # see https://releases.hashicorp.com/boundary/
        name    = "boundary"
        version = "0.2.0"
      },
      { # see https://releases.hashicorp.com/consul/
        name    = "consul"
        version = "1.9.5"
      },
      { # see https://releases.hashicorp.com/nomad/
        name    = "nomad"
        version = "1.0.4"
      },
      { # see https://releases.hashicorp.com/vault/
        name    = "vault"
        version = "1.7.0"
      }
    ]

    # HashiCorp-specific feature flags
    toggles = {
      # add HashiCorp APT / YUM repository
      add_repository = true

      # add `nomad` user to `docker` group
      add_nomad_user_to_docker = true

      # copy unit files for enabled products
      copy_unit_files = true

      # create users for enabled products
      create_users = true

      # create groups for enabled products
      create_groups = true

      # enable services for enabled products
      enable_services = true

      # install Nomad plugins
      install_nomad_plugins = true

      # install packages for enabled products
      install_packages = true

      # start services for enabled products
      start_services = true
    }
  }

  # Formatting sequence to use for date formats
  image_version_date_format = "YYYYMMDD-hhmmss"

  # InSpec-specific settings
  inspec = {
    # see https://www.packer.io/docs/provisioners/inspec#attributes
    attributes = []

    # see https://www.packer.io/docs/provisioners/inspec#attributes_directory
    attributes_directory = null

    # see https://www.packer.io/docs/provisioners/inspec#backend
    backend = "ssh"

    # see https://www.packer.io/docs/provisioners/inspec#command
    command = "inspec"

    # see https://www.packer.io/docs/provisioners/inspec#inspec_env_vars
    inspec_env_vars = [
      "CHEF_LICENSE=accept"
    ]

    # see https://www.packer.io/docs/provisioners/inspec#profile
    profile = "git@github.com:dev-sec/linux-baseline.git"

    # https://www.packer.io/docs/provisioners/inspec#user
    user = null
  }

  # Shared name for Images
  name = "ubuntu-hashicorp"

  # OS-specific settings
  os = {
    enabled = true

    directories = {
      ansible = [
        "/tmp/ansible"
      ]

      to_remove = [
        "/etc/machine-id",
        "/var/lib/dbus/machine-id"
      ]
    }

    packages = {
      # packages that should be installed
      to_install = [
        "apt-transport-https",
        "ca-certificates",
        "curl",
        "gnupg",
        "jq",
        "libcap2",
        "lsb-release",
        "sudo",
        "unzip",
      ]

      # packages that should be removed
      to_remove = [
        # see https://packages.ubuntu.com/focal/dosfstools
        "dosfstools",
        "ftp",
        "fuse",
        "ntfs-3g",
        "open-iscsi",
        "pastebinit",
        "snapd",
        "ubuntu-release-upgrader-core"
      ]
    }

    # OS-specific feature flags
    toggles = {
      install_packages   = true
      remove_directories = true
      remove_packages    = true
      update_apt_cache   = true
    }
  }

  # osquery-specific settings
  osquery = {
    enabled = true

    directories = [
      "/var/log/osquery",
      "/var/osquery/osquery.db"
    ]

    packages = [
      { # see https://osquery.io/downloads/official/
        name    = "osquery"
        version = "4.8.0"
      }
    ]

    repository = {
      key        = "1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B"
      key_server = "keyserver.ubuntu.com"
      keyring    = null
      url        = "https://pkg.osquery.io/deb"
    }

    toggles = {
      # add osquery APT / YUM repository
      add_repository = true

      # install packages for osquery
      install_packages = true

      # remove osquery directories
      remove_directories = true
    }
  }

  # podman-specific settings
  podman = {
    enabled = false

    packages = [
      { # see https://releases.hashicorp.com/nomad-driver-podman/
        name    = "podman"
        version = "3.0.0"
      }
    ]

    # TODO: make `url` smarter
    repository = {
      url = "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_20.04/"
    }

    toggles = {
      # add Podman APT / YUM repository
      add_repository = true

      # install packages for Podman
      install_packages = true
    }
  }

  templates = {
    # these paths are relative to the Packer Builder target
    configuration = "../_shared/generated-configuration.pkrtpl.yml"
    versions      = "../_shared/image-description.pkrtpl.md"
  }

  # toggles to enable and disable various operations
  toggles = {
    # feature flags for product-specific operations
    hashicorp_enabled = {
      boundary = false
      consul   = true
      nomad    = true
      vault    = false
    }

    # miscellaneous feature flags
    misc = {
      # copy files with version information to image
      copy_versions_files = true
    }
  }
}
