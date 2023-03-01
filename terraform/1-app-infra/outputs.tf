// Resource outputs
output "storage_bucket_selflink" {
  value       = google_storage_bucket.static_site.self_link
  description = "The URL of the created cloud storage bucket"
}