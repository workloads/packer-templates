# these variables are shared across all images
build_config = {
  # Environment variables to set before running Ansible
  # When in doubt, edit `ansible/ansible.cfg` instead of `ansible_env_vars`
  ansible_env_vars = [
    "ANSIBLE_CONFIG=ansible/ansible.cfg"
  ]

  # TODO: make `podman` smarter
  apt_repos = {
    docker    = "https://download.docker.com"
    hashicorp = "https://apt.releases.hashicorp.com"
    podman    = "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_20.04/"
  }

  # The command to invoke Ansible with.
  command = "ansible-playbook"

  # Extra arguments to pass to Ansible
  extra_arguments = [
    # "-v",
  ]

  # Formatting sequence to use for date formats
  image_version_date_format = "YYYYMMDD-hhmmss"

  # Shared name for Images
  name = "ubuntu-hashicorp"

  # The playbook to be run by Ansible.
  playbook_file = "./ansible/playbooks/main.yml"

  # toggles to enable and disable various operations
  toggles = {
    # feature flags to enable (complete) playbooks
    enable_debug_statements = false
    enable_os               = true
    enable_docker           = true
    enable_hashicorp        = true
    enable_podman           = false

    # OS-specific feature flags
    os = {
      install_packages = true
      remove_packages  = true
      update_apt_cache = true
    }

    # Docker-specific feature flags
    docker = {
      add_apt_repository = true
      create_group       = true
      create_user        = true
      install_packages   = true
    }

    # HashiCorp-specific feature flags
    hashicorp = {
      # add HashiCorp APT repository
      add_apt_repository = true

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

    # feature flags for product-specific operations
    hashicorp_enabled = {
      boundary = false
      consul   = true
      nomad    = true
      vault    = false
    }

    # miscellaneous feature flags
    misc = {
      # create files with version information
      create_versions_files = true

      # copy files with version information to image
      copy_versions_files = true
    }

    # Podman-specific feature flags
    podman = {
      # add Podman APT repository
      add_apt_repository = true

      # install packages for Podman
      install_packages = true
    }
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
    to_remove = []

    # package definitions (name and version) for Docker(-related) products
    docker = [
      { # see https://docs.docker.com/release-notes/
        name    = "docker-ce"
        version = "5:20.10.5*"
      },
      { # see https://docs.docker.com/release-notes/
        name    = "containerd.io"
        version = "*"
      }
    ]

    # package definitions (name and version) for HashiCorp products
    hashicorp = [
      { # see https://releases.hashicorp.com/boundary/
        name    = "boundary"
        version = "0.1.8"
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

  templates = {
    versions = "../_shared/image-description.pkrtpl.md"
  }

  generated_files = {
    configuration = "generated/generated_configuration.yml"
    versions      = "generated/version-information.md"
  }
}
