// Terraform cloud configuration
terraform {
  cloud {
    organization = "foundations"

    workspaces {
      name = "app-infra-tst"
    }
  }
}
