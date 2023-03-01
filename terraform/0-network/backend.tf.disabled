/*
A cloud block in your terraform configuration specifies which organization and workspace(s) to use.
Cloud block configuration is only required, when using CLI-Driven workflow of terraform cloud.
When using the VCS-driven workflow for Terraform Cloud, there is no need to define the cloud block.
*/

// Terraform cloud configuration
terraform {
  cloud {
    organization = "foundations"

    workspaces {
      name = "network-tst"
    }
  }
}