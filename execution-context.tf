
resource "github_actions_environment_variable" "environment_name" {

  for_each = var.environments

  repository    = var.repository_name
  environment   = each.key
  variable_name = "ENVIRONMENT_NAME"
  value         = each.key

  depends_on = [null_resource.delay_after_environment_creation]

}

resource "github_actions_environment_variable" "terraform_working_directory" {

  for_each = var.environments

  repository    = var.repository_name
  environment   = each.key
  variable_name = "TERRAFORM_WORKING_DIRECTORY"
  value         = module.terraform_simple_codebase.path

  depends_on = [null_resource.delay_after_environment_creation]

}

resource "github_actions_environment_variable" "terraform_version" {

  for_each = var.environments

  repository    = var.repository_name
  environment   = each.key
  variable_name = "TERRAFORM_VERSION"
  value         = var.terraform_version

  depends_on = [null_resource.delay_after_environment_creation]

}
