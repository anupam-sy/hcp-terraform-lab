// Resource outputs
output "storage_bucket_selflink" {
  value       = google_storage_bucket.static_site_bkt.self_link
  description = "The self link of the created cloud storage bucket"
}