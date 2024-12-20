resource "github_repository_environment" "main" {

  for_each = var.environments

  environment = each.key
  repository  = var.repository_name

  dynamic "reviewers" {
    for_each = each.value.reviewing_users != null && length(each.value.reviewing_users) > 0 ? [each.value.reviewing_users] : []

    content {
      users = [reviewers.value]
    }
  }

  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }

}

# Add a null_resource for delay
resource "null_resource" "delay_after_environment_creation" {
  depends_on = [github_repository_environment.main]

  provisioner "local-exec" {
    # Adjust the delay (in seconds) as needed
    command = "sleep ${var.delay_after_environment_creation}"
  }
}
