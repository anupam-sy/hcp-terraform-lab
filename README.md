# Terraform Cloud (TFC) Lab 
This repository contains Terraform code to run using VCS-Driven / CLI-Driven workflow of TFC for infrastructure deployment on Google Public Cloud.

## Prerequisites
Below prerequisites must be fulfilled for successful execution of code.

### Software Requirement
Resources in this repository are meant for use with Terraform 1.3.6 (Check the version using `terraform version`). If you don't have the compatible version, download it from official Terraform repository.

-   [Terraform](https://www.terraform.io/downloads.html) >= 1.3.6

### Permissions Requirement
In order to execute terraform code using CLI-Driven workflow of TFC (Terraform Cloud):

1. Create a Service Account on Google Cloud Platform and grant the following roles. Access can be more fine-grained to follow Principle of least privilege (PoLP).
- `roles/resourcemanager.projectOwner` on all the projects where you want to house your resources using service account's email.

2. Create a JSON Key for your service account and save the service account key content in a Terraform Cloud environment variable called "GOOGLE_CREDENTIALS". Make sure to get the content of the JSON file using (Remove the newline characters from your JSON key file): `cat sa-key.json | tr -s '\n' ' '`. Don't forget to mark the env variable as Sensitive on TFC workspace. All runs within the workspace will use the GOOGLE_CREDENTIALS variable to authenticate with Google Cloud Platform.

3. Create an account on terraform cloud (https://app.terraform.io/) and create an organization. Then create a workspace inside the organization.

4. For CLI-Driven workflow, configure the following settings to use Terraform Cloud for a particular working directory:
- Provide credentials to access Terraform Cloud, preferably by using the `terraform login` command.
- Add a cloud block in your terraform configuration, to specify which organization and workspace(s) to use.

**Note:** When using the VCS-driven workflow for Terraform Cloud, you do not need to define the cloud block in your configuration.

## Terraform Code Execution
- In VCS-Driven workflow of terraform cloud, terraform cloud automatically queues plans whenever changes are committed to your configuration's VCS repo. So, In this approach, Terraform Cloud can automatically fetch content from supported VCS providers, and uses webhooks to get notified of code changes.

- In CLI-Driven workflow of terraform cloud, you initiate Terraform operations in your Terminal, and use Terraform Cloud's ephemeral remote execution environments for your operations. In this approach, the `terraform plan` and `terraform apply` commands will perform remote runs by uploading a configuration from a local working directory.

## References
- https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
- https://developer.hashicorp.com/terraform/cli/commands/login
- https://developer.hashicorp.com/terraform/cli/cloud/settings