# these variables are shared across all images
build_config = {
  # Environment variables to set before running Ansible
  ansible_env_vars = [
    "ANSIBLE_NOCOWS=True",
  ]

  apt_repos = {
    docker    = "https://download.docker.com"
    hashicorp = "https://apt.releases.hashicorp.com"
  }

  # Extra arguments to pass to Ansible
  extra_arguments = [
    "-v",
  ]

  # Formatting sequence to use for date formats
  image_version_date_format = "YYYYMMDD-hhmmss"

  # Shared name for Images
  name = "ubuntu-hashicorp"

  # toggles to enable and disable various operations
  toggles = {
    # global toggles for (complete) playbooks
    enable_os              = false
    enable_docker          = false
    enable_hashicorp       = true
    enable_misc_operations = true
    enable_podman          = false

    os = {
      install_packages = false
      remove_packages  = false
      update_apt_cache = false
    }

    docker = {
      add_apt_repository = false
      create_group       = false
      create_user        = false
      install_packages   = false
    }

    hashicorp = {
      # add HashiCorp APT repository
      add_apt_repository = false

      # add `nomad` user to `docker` group
      add_nomad_user_to_docker = false

      # copy unit files for enabled products
      copy_unit_files = false

      # create users for enabled products
      create_users = false

      # create groups for enabled products
      create_groups = false

      # enable services for enabled products
      enable_services = false

      # install Nomad plugins
      install_nomad_plugins = true

      # install packages for enabled products
      install_packages = true

      # start services for enabled products
      start_services = true
    }

    # enable product-specific operations
    hashicorp_enabled = {
      boundary = false
      consul   = true
      nomad    = true
      vault    = false
    }

    misc = {
      # create files with version information
      create_versions_files = true

      # copy files with version information to image
      copy_versions_files = true
    }

    podman = {
      # install packages for Podman
      install_packages = false
    }
  }

  packages = {
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

    to_remove = [
      "ftp",
      "snapd",
      "telnet"
    ]

    # package definitions (name and version) for Docker(-related) products
    docker = [
      { # see https://docs.docker.com/release-notes/
        name    = "docker-ce"
        version = "5:20.10.5*"
      },
      { # see https://docs.docker.com/release-notes/
        name    = "containerd"
        version = "1.4.4"
      }
    ]

    # package definitions (name and version) for HashiCorp products
    hashicorp = [
      { # see https://releases.hashicorp.com/boundary/
        name    = "boundary"
        version = "KERIM"
      },
      { # see https://releases.hashicorp.com/consul/
        name    = "consul"
        version = "1.9.4"
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

    # package definitions (name and version) for HashiCorp Nomad Plugins
    hashicorp_nomad_plugins = [
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

    # package definitions (name and version) for Podman
    podman = [
      { # see https://releases.hashicorp.com/nomad-driver-podman/
        name    = "podman"
        version = "3.0.0"
      }
    ]
  }

  version_files = {
    source = "../templates"
    destination = "../../generated"
    templates: [
      "versions.txt"
    ]
  }
}
