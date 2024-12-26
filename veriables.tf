
variable "repository_name" {
  type        = string
  description = <<DESCRIPTION
The name of the GitHub repository where the environments and configurations will be managed.

This repository will store the Terraform configuration files, GitHub Actions workflows, and environment-specific settings necessary for provisioning and managing the Azure infrastructure.
DESCRIPTION
}
variable "terraform_version" {
  type        = string
  default     = "1.9.8"
  description = <<DESCRIPTION
The version of Terraform to be used in GitHub Actions workflows.

Specifying the Terraform version ensures consistency across different environments and prevents compatibility issues. It is essential to align the Terraform version with the modules and configurations used in your project.
DESCRIPTION
}
variable "terraform_working_directory" {
  type        = string
  description = <<DESCRIPTION
The working directory path for Terraform operations within GitHub Actions.

**Example**: `src/terraform`

This variable defines the directory where Terraform commands will be executed, aligning with the repository's directory structure. Proper configuration of the working directory ensures that Terraform operates within the correct context and accesses the necessary configuration files.
DESCRIPTION
}
variable "delay_after_environment_creation" {
  type        = number
  default     = 10
  description = <<DESCRIPTION
The number of seconds to delay after creating the GitHub repository environments before configuring environment variables and backend/authentication modules.

**Default**: `10`

This delay ensures that the environments are fully set up and ready before subsequent configurations are applied. Adjusting the delay may be necessary based on the responsiveness of your GitHub repository and the complexity of environment setups.
DESCRIPTION
}
variable "environments" {
  type = map(object({
    subscription_id = string
    tenant_id       = string
    client_id       = string
    branch_name     = string
    reviewing_teams = list(string)
    reviewing_users = list(string)
    backend = object({
      resource_group_name  = string
      storage_account_name = string
      state_container_name = string
      plan_container_name  = string
    })
  }))
  description = <<DESCRIPTION
A map defining the environments to be provisioned, where each key is the environment name and the value is an object containing configuration details for that environment.
DESCRIPTION
}
