variable "project_name" {
  type        = string
  description = "The display name of the project."
}

variable "org_id" {
  type        = number
  description = "The numeric ID of the organization this project belongs to."
  default     = null
}

locals {
  project_id = "${var.project_name}-${random_string.string.id}"
}
