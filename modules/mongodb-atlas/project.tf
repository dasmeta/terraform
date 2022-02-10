resource "mongodbatlas_project" "main" {
  name                         = var.project_name
  org_id                       = var.org_id
  with_default_alerts_settings = var.with_default_alerts_settings

  # teams {
  #   role_names = var.team_roles
  #   team_id    = var.team_id
  # }

  # teams {
  #   team_id    = "5e1dd7b4f2a30ba80a70cd4rw"
  #   role_names = ["GROUP_READ_ONLY", "GROUP_DATA_ACCESS_READ_WRITE"]
  # }
}
