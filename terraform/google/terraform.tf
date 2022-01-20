terraform {
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/google/4.6.0
    google = {
      source  = "hashicorp/google"
      version = "4.6.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/local/2.1.0
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/random/3.1.0
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  required_version = "1.1.4"
}
