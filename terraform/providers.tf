// Provider credential configuration
provider "google" {
  region = var.default_region
}

provider "google-beta" {
  region = var.default_region
}
