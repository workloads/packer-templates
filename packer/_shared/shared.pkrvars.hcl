# these variables are shared across all images
shared = {
  # Extra arguments to pass to Ansible
  extra_arguments = [
    "-v",
  ]

  # Environment variables to set before running Ansible
  ansible_env_vars = [
    "ANSIBLE_NOCOWS=True",
  ]

  # Formatting sequence to use for date formats
  image_version_date_format = "YYYYMMDD-hhmmss"

  # Shared name for Images
  name = "ubuntu-hashicorp"
}
