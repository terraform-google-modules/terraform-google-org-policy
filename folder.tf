/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  iam_folder_policy_constraints = {
    for constraint, policy in var.policy_constraints:
      constraint => policy
    if local.is_folder_constraints
  }
}

/******************************************
  Folder policies
 *****************************************/
resource "google_folder_organization_policy" "policy" {
  for_each = local.iam_folder_policy_constraints

  constraint = "constraints/${each.key}"
  folder     = var.folder

  dynamic "list_policy" {
    for_each = {
      for key, value in each.value:
          key => value
      if key == "allow" || key == "deny"
    }

    content {
      dynamic "allow" {
        for_each = [
          for key, value in each.value: {
            values = value
          }
          if key == "allow"
        ]

        content {
          all    =  contains(allow.value.values, "all") ? true : null
          values = !contains(allow.value.values, "all") ? allow.value.values : null
        }
      }

      dynamic "deny" {
        for_each = [
          for key, value in each.value: {
            values = value
          }
          if key == "deny"
        ]

        content {
          all    =  contains(deny.value.values, "all") ? true : null
          values = !contains(deny.value.values, "all") ? deny.value.values : null
        }
      }
    }
  }

  dynamic "boolean_policy" {
    for_each = [
      for key, value in each.value: {
          enforced = value
      }
      if key == "enforced"
    ]

    content {
      enforced = boolean_policy.value.enforced
    }
  }
}

