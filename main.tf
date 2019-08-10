locals {
  is_folder_constraints  = length(var.folder) > 0
  is_org_constraints     = length(var.org_id) > 0
  is_project_constraints = length(var.project) > 0
}

