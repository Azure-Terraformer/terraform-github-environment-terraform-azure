
module "azure-credential" {
  source  = "Azure-Terraformer/azure-credential/github"
  version = "1.0.0"

  for_each = var.environments

  repository      = var.repository_name
  environment     = each.key
  subscription_id = each.value.subscription_id
  tenant_id       = each.value.tenant_id
  client_id       = each.value.client_id

  client_id_label = "TERRAFORM_ARM_CLIENT_ID"

  depends_on = [null_resource.delay_after_environment_creation]
}
