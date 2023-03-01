locals {
  website_files = ["index.html", "404.html"]
  storage_object_output_names = [
    for object in google_storage_bucket_object.static_site_objects :
    object.output_name
  ]
}

resource "random_id" "suffix" {
  byte_length = 2
}

resource "google_storage_bucket" "static_site" {
  project       = var.project_id
  name          = "${var.storage_bucket_name}-${random_id.suffix.hex}"
  location      = var.default_region
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

resource "google_storage_bucket_object" "static_site_objects" {
  for_each = toset(local.website_files)

  name   = each.value
  source = "${path.module}/static-files/${each.value}"
  bucket = google_storage_bucket.static_site.name
}

resource "google_storage_object_access_control" "static_site_objects_acl" {
  for_each = toset(local.storage_object_output_names)

  object = each.value
  bucket = google_storage_bucket.static_site.name
  role   = "READER"
  entity = "allUsers"

  depends_on = [
    google_storage_bucket_object.static_site_objects
  ]
}