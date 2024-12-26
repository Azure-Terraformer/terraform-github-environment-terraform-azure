# Overview

This Terraform module automates the provisioning and configuration of GitHub repository environments to support Terraform operations across multiple Azure environments. 

It creates GitHub repository environments with specified reviewers and deployment branch policies, ensuring that only authorized users can deploy changes. After establishing each environment, the module introduces a configurable delay to allow for proper setup before configuring essential environment variables such as ENVIRONMENT_NAME, TERRAFORM_WORKING_DIRECTORY, and TERRAFORM_VERSION. 

Additionally, the module integrates with backend and authentication modules to establish Azure backend configurations and manage Azure credentials for each environment. 

By managing these configurations through Terraform, the module ensures consistent, secure, and automated infrastructure deployments within the GitHub AT-AT framework for Terraform and Azure-based projects.

```hcl
environments = {
  dev = {
    subscription_id = "your-dev-subscription-id"
    tenant_id       = "your-tenant-id"
    client_id       = "your-client-id"
    branch_name     = "dev-branch"
    reviewing_teams = ["team-dev-reviewers"]
    reviewing_users = ["user1@example.com", "user2@example.com"]
    backend = {
      resource_group_name  = "dev-resource-group"
      storage_account_name = "devstorageacct"
      state_container_name = "dev-state"
      plan_container_name  = "dev-plan"
    }
  }
  test = {
    subscription_id = "your-staging-subscription-id"
    tenant_id       = "your-tenant-id"
    client_id       = "your-client-id"
    branch_name     = "staging-branch"
    reviewing_teams = ["team-staging-reviewers"]
    reviewing_users = ["user3@example.com", "user4@example.com"]
    backend = {
      resource_group_name  = "staging-resource-group"
      storage_account_name = "stagingstorageacct"
      state_container_name = "staging-state"
      plan_container_name  = "staging-plan"
    }
  }
  prod = {
    subscription_id = "your-prod-subscription-id"
    tenant_id       = "your-tenant-id"
    client_id       = "your-client-id"
    branch_name     = "main"
    reviewing_teams = ["team-prod-reviewers"]
    reviewing_users = ["user5@example.com", "user6@example.com"]
    backend = {
      resource_group_name  = "prod-resource-group"
      storage_account_name = "prodstorageacct"
      state_container_name = "prod-state"
      plan_container_name  = "prod-plan"
    }
  }
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure-credential"></a> [azure-credential](#module\_azure-credential) | Azure-Terraformer/azure-credential/github | 1.0.0 |
| <a name="module_azure_backend"></a> [azure\_backend](#module\_azure\_backend) | Azure-Terraformer/azure-backend/github | 1.0.1 |

## Resources

| Name | Type |
|------|------|
| [github_actions_environment_variable.environment_name](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_actions_environment_variable.terraform_version](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_actions_environment_variable.terraform_working_directory](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_repository_environment.main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment) | resource |
| [null_resource.delay_after_environment_creation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delay_after_environment_creation"></a> [delay\_after\_environment\_creation](#input\_delay\_after\_environment\_creation) | The number of seconds to delay after creating the GitHub repository environments before configuring environment variables and backend/authentication modules.<br><br>**Default**: `10`<br><br>This delay ensures that the environments are fully set up and ready before subsequent configurations are applied. Adjusting the delay may be necessary based on the responsiveness of your GitHub repository and the complexity of environment setups. | `number` | `10` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | A map defining the environments to be provisioned, where each key is the environment name and the value is an object containing configuration details for that environment. | <pre>map(object({<br>    subscription_id = string<br>    tenant_id       = string<br>    client_id       = string<br>    branch_name     = string<br>    reviewing_teams = list(string)<br>    reviewing_users = list(string)<br>    backend = object({<br>      resource_group_name  = string<br>      storage_account_name = string<br>      state_container_name = string<br>      plan_container_name  = string<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | The name of the GitHub repository where the environments and configurations will be managed.<br><br>This repository will store the Terraform configuration files, GitHub Actions workflows, and environment-specific settings necessary for provisioning and managing the Azure infrastructure. | `string` | n/a | yes |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | The version of Terraform to be used in GitHub Actions workflows.<br><br>Specifying the Terraform version ensures consistency across different environments and prevents compatibility issues. It is essential to align the Terraform version with the modules and configurations used in your project. | `string` | `"1.9.8"` | no |
| <a name="input_terraform_working_directory"></a> [terraform\_working\_directory](#input\_terraform\_working\_directory) | The working directory path for Terraform operations within GitHub Actions.<br><br>**Example**: `src/terraform`<br><br>This variable defines the directory where Terraform commands will be executed, aligning with the repository's directory structure. Proper configuration of the working directory ensures that Terraform operates within the correct context and accesses the necessary configuration files. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->