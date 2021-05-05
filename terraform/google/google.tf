provider "google" {}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project
resource "google_project" "packer" {
  name       = local.project_name
  project_id = local.project_id
  org_id     = var.org_id
}
