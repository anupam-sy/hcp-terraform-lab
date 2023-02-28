# Terraform Cloud (TFC) Lab 
This repository contains Terraform code to run using CLI-Driven workflow of TFC for infrastructure deployment on Google Public Cloud.

## Prerequisites
Below prerequisites must be fulfilled for successful execution of code.

### Software Requirement
Resources in this repository are meant for use with Terraform 1.3.6 (Check the version using `terraform version`). If you don't have the compatible version, download it from official Terraform repository.

-   [Terraform](https://www.terraform.io/downloads.html) >= 1.3.6

### Permissions Requirement
In order to execute these templates using CLI-Driven workflow of TFC (Terraform Cloud):

1. Create an account on terraform cloud (https://app.terraform.io/) and create an organization. Then create a workspace inside the organization.

2. Create a Service Account on Google Cloud Platform and grant the following roles. Access can be more fine-grained to follow Principle of least privilege (PoLP).
- `roles/resourcemanager.projectOwner` on all the projects where you want to house your resources using service account's email.

3. Create a JSON Key for your service account and Place your credentials in a Terraform Cloud environment variable:
- Create an environment variable called GOOGLE_CREDENTIALS in your Terraform Cloud workspace.
- Remove the newline characters from your JSON key file and then paste the credentials into the environment variable value field. You can use the tr command to strip newline characters. Cat `key.json | tr -s '\n' ' '` and save the content in env variable in TFC.
- Mark the variable as Sensitive and click Save variable.
- All runs within the workspace will use the GOOGLE_CREDENTIALS variable to authenticate with Google Cloud Platform.

4. Configure the following settings to use Terraform Cloud for a particular working directory:
- Provide credentials to access Terraform Cloud, preferably by using the `terraform login` command. When you run `terraform login`, terraform opens a web browser to the tokens page for `app.terraform.io`. Generate a token using your browser, and copy-paste it into this prompt. By default, Terraform saves the API token in plain text in a file called `credentials.tfrc.json` in user's home directory. 
- Add a cloud block to the directory's Terraform configuration, to specify which organization and workspace(s) to use.
- Optionally, use a .terraformignore file to specify files that shouldn't be uploaded with the Terraform configuration when running plans and applies.

**Note:**
- A configuration can only provide one cloud block. The cloud block is a nested block within the top-level terraform settings block. It specifies which Terraform Cloud workspaces to use for the current working directory.
- A cloud block cannot be used with state backends. A configuration can use one or the other, but not both.
- A cloud block cannot refer to named values (like input variables, locals, or data source attributes).

## Excluding Files from Upload
When executing a remote plan or apply in a CLI-driven run, an archive of your configuration directory is uploaded to Terraform Cloud. You can define paths to ignore from upload via a .terraformignore file at the root of your configuration directory.

## References
- https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
- https://developer.hashicorp.com/terraform/cli/commands/login
- https://developer.hashicorp.com/terraform/cli/cloud/settings