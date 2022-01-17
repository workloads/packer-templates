output "digitalocean_ssh_key_id" {
  description = "The unique ID of the SSH key"
  value       = digitalocean_ssh_key.packer.id
}

output "digitalocean_ssh_key_name" {
  description = "The name of the SSH key"
  value       = digitalocean_ssh_key.packer.name
}
