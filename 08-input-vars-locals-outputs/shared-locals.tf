locals {
  project       = "08-input-vars-locals-outputs"
  project_owner = "Priyanka"
  cost_center   = "CC1001"
  managed_by    = "DevOpsTeam"
}

locals {
  common_tags = {
    project       = local.project
    project_owner = local.project_owner
    cost_center   = local.cost_center
    managed_by    = local.managed_by
  }
}