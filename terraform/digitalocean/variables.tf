# see https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/ssh_key#name
variable "ssh_key_name" {
  type        = string
  description = "The name of the SSH key for identification"
  default     = "packer"
}

# see https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/ssh_key#public_key
variable "ssh_key_public_key_path" {
  type        = string
  description = "The path to the public key"
  default     = "~/.ssh/id_rsa.pub"
}
