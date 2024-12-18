
variable "repository_name" {
  type = string
}
variable "terraform_version" {
  type    = string
  default = "1.9.8"
}
variable "terraform_working_directory" {
  type = string
}
variable "delay_after_environment_creation" {
  type    = number
  default = 10
}
variable "environments" {
  type = map(object({
    subscription_id = string
    tenant_id       = string
    client_id       = string
    branch_name     = string
    reviewers       = list(string)
    backend = object({
      resource_group_name  = string
      storage_account_name = string
      state_container_name = string
      plan_container_name  = string
    })
  }))
}
