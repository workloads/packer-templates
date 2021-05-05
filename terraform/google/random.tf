# see https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "string" {
  lower   = true
  length  = 4
  special = false
  upper   = false
}
