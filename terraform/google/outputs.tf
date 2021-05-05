output "project_name" {
  description = "Project Name"
  value       = google_project.packer.name
}

output "project_id" {
  description = "Project ID"
  value       = google_project.packer.id
}

output "project_url" {
  description = "Project Dashboard URL for Google Cloud Console"
  value       = "https://console.cloud.google.com/home/dashboard?project=${google_project.packer.id}"
}
