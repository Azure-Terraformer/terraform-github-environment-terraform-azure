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