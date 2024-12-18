module "azure_backend" {

  source  = "Azure-Terraformer/azure-backend/github"
  version = "1.0.1"

  for_each = var.environments

  repository  = var.repository_name
  environment = each.key

  resource_group_name  = each.value.backend.resource_group_name
  storage_account_name = each.value.backend.storage_account_name
  state_container_name = each.value.backend.state_container_name
  plan_container_name  = each.value.backend.plan_container_name

  depends_on = [null_resource.delay_after_environment_creation]

}
