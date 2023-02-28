// Terraform cloud configuration
terraform {
  cloud {
    organization = "foundations"

    workspaces {
      name = "network-tst"
    }
  }
}
