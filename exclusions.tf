/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  iam_folder_policy_exclusions_pairs = flatten([
    for constraint, policy in var.policy_constraints: [
      for key, items in policy: [
        for folder in items: {
          constraint = constraint
          folder     = folder
        }
      ]
      if key == "exclude_folders"
    ]
  ])

  iam_folder_policy_exclusions = {
    for item in local.iam_folder_policy_exclusions_pairs:
      "${item.constraint}_${item.folder}" => item.folder
  }

  iam_project_policy_exclusions_pairs = flatten([
    for constraint, policy in var.policy_constraints: [
      for key, items in policy: [
        for project in items: {
          constraint = constraint
          project     = project
        }
      ]
      if key == "exclude_projects"
    ]
  ])

  iam_project_policy_exclusions = {
    for item in local.iam_project_policy_exclusions_pairs:
      "${item.constraint}_${item.project}" => item.project
  }
}

/******************************************
  Folder(s) exclusion
 *****************************************/
resource "google_folder_organization_policy" "exclude" {
  for_each = local.iam_folder_policy_exclusions

  constraint = "constraints/${split("_", each.key)[0]}"
  folder     = each.value

  restore_policy {
    default = true
  }
}

/******************************************
  Project(s) exclusion
 *****************************************/
resource "google_project_organization_policy" "exclude" {
  for_each = local.iam_project_policy_exclusions

  constraint = "constraints/${split("_", each.key)[0]}"
  project     = each.value

  restore_policy {
    default = true
  }
}

