locals {
  website_files = ["index.html", "404.html"]
}

resource "random_id" "suffix" {
  byte_length = 2
}

resource "google_storage_bucket" "static_site_bkt" {
  project                     = var.project_id
  name                        = "${var.storage_bucket_name}-${random_id.suffix.hex}"
  location                    = var.default_region
  force_destroy               = true
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

resource "google_storage_bucket_object" "static_site_bkt_objects" {
  for_each = toset(local.website_files)

  name   = each.value
  source = "${path.module}/static-files/${each.value}"
  bucket = google_storage_bucket.static_site_bkt.name
}

resource "google_storage_bucket_iam_member" "static_site_bkt_iam" {
  bucket = google_storage_bucket.static_site_bkt.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}