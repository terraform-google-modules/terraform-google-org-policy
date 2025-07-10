/**
 * Copyright 2025 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/******************************************
  Organization policy, allow all, deny all, allow values and deny values (list constraint)
 *****************************************/
resource "google_org_policy_policy" "organization_policy" {
  count = local.organization && local.list_policy ? 1 : 0

  name   = "${local.policy_root}/${var.policy_root_id}/policies/${var.constraint}"
  parent = "${local.policy_root}/${var.policy_root_id}"

  dynamic "spec" {
    for_each = length(local.rules) > 0 ? ["rules"] : []
    content {
      inherit_from_parent = var.inherit_from_parent
      dynamic "rules" {
        for_each = local.rules
        content {
          dynamic "condition" {
            for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
            content {
              description = condition.value.description
              expression  = condition.value.expression
              location    = condition.value.location
              title       = condition.value.title
            }
          }
          allow_all = rules.value.enforcement == false ? "TRUE" : null
          deny_all  = rules.value.enforcement == true ? "TRUE" : null
          dynamic "values" {
            for_each = rules.value.allow_list_length > 0 || rules.value.deny_list_length > 0 ? rules.value.values : []
            content {
              allowed_values = rules.value.allow_list_length > 0 && rules.value.deny_list_length == 0 ? values.value.allow : null
              denied_values  = rules.value.deny_list_length > 0 && rules.value.allow_list_length == 0 ? values.value.deny : null
            }
          }
        }
      }
    }
  }

  dynamic "dry_run_spec" {
    for_each = length(local.rules_dry_run) > 0 ? ["dry_run_rules"] : []
    content {
      inherit_from_parent = var.inherit_from_parent
      dynamic "rules" {
        for_each = local.rules_dry_run
        content {
          dynamic "condition" {
            for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
            content {
              description = condition.value.description
              expression  = condition.value.expression
              location    = condition.value.location
              title       = condition.value.title
            }
          }
          allow_all = rules.value.enforcement == false ? "TRUE" : null
          deny_all  = rules.value.enforcement == true ? "TRUE" : null
          dynamic "values" {
            for_each = rules.value.allow_list_length > 0 || rules.value.deny_list_length > 0 ? rules.value.values : []
            content {
              allowed_values = rules.value.allow_list_length > 0 && rules.value.deny_list_length == 0 ? values.value.allow : null
              denied_values  = rules.value.deny_list_length > 0 && rules.value.allow_list_length == 0 ? values.value.deny : null
            }
          }
        }
      }
    }
  }


}

/******************************************
  Folder policy, allow all, deny all, allow values and deny values (list constraint)
 *****************************************/
resource "google_org_policy_policy" "folder_policy" {
  count = local.folder && local.list_policy ? 1 : 0

  name   = "${local.policy_root}/${var.policy_root_id}/policies/${var.constraint}"
  parent = "${local.policy_root}/${var.policy_root_id}"

  dynamic "spec" {
    for_each = length(local.rules) > 0 ? ["rules"] : []
    content {
      inherit_from_parent = var.inherit_from_parent
      dynamic "rules" {
        for_each = local.rules
        content {
          dynamic "condition" {
            for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
            content {
              description = condition.value.description
              expression  = condition.value.expression
              location    = condition.value.location
              title       = condition.value.title
            }
          }
          allow_all = rules.value.enforcement == false ? "TRUE" : null
          deny_all  = rules.value.enforcement == true ? "TRUE" : null
          dynamic "values" {
            for_each = rules.value.allow_list_length > 0 || rules.value.deny_list_length > 0 ? rules.value.values : []
            content {
              allowed_values = rules.value.allow_list_length > 0 && rules.value.deny_list_length == 0 ? values.value.allow : null
              denied_values  = rules.value.deny_list_length > 0 && rules.value.allow_list_length == 0 ? values.value.deny : null
            }
          }
        }
      }
    }
  }

  dynamic "dry_run_spec" {
    for_each = length(local.rules_dry_run) > 0 ? ["dry_run_rules"] : []
    content {
      inherit_from_parent = var.inherit_from_parent
      dynamic "rules" {
        for_each = local.rules_dry_run
        content {
          dynamic "condition" {
            for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
            content {
              description = condition.value.description
              expression  = condition.value.expression
              location    = condition.value.location
              title       = condition.value.title
            }
          }
          allow_all = rules.value.enforcement == false ? "TRUE" : null
          deny_all  = rules.value.enforcement == true ? "TRUE" : null
          dynamic "values" {
            for_each = rules.value.allow_list_length > 0 || rules.value.deny_list_length > 0 ? rules.value.values : []
            content {
              allowed_values = rules.value.allow_list_length > 0 && rules.value.deny_list_length == 0 ? values.value.allow : null
              denied_values  = rules.value.deny_list_length > 0 && rules.value.allow_list_length == 0 ? values.value.deny : null
            }
          }
        }
      }
    }
  }

}

/******************************************
  Project policy, allow all, deny all, allow values and deny values (list constraint)
 *****************************************/
resource "google_org_policy_policy" "project_policy" {
  count = local.project && local.list_policy ? 1 : 0

  name   = "${local.policy_root}/${var.policy_root_id}/policies/${var.constraint}"
  parent = "${local.policy_root}/${var.policy_root_id}"

  dynamic "spec" {
    for_each = length(local.rules) > 0 ? ["rules"] : []
    content {
      inherit_from_parent = var.inherit_from_parent
      dynamic "rules" {
        for_each = local.rules
        content {
          dynamic "condition" {
            for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
            content {
              description = condition.value.description
              expression  = condition.value.expression
              location    = condition.value.location
              title       = condition.value.title
            }
          }
          allow_all = rules.value.enforcement == false ? "TRUE" : null
          deny_all  = rules.value.enforcement == true ? "TRUE" : null
          dynamic "values" {
            for_each = rules.value.allow_list_length > 0 || rules.value.deny_list_length > 0 ? rules.value.values : []
            content {
              allowed_values = rules.value.allow_list_length > 0 && rules.value.deny_list_length == 0 ? values.value.allow : null
              denied_values  = rules.value.deny_list_length > 0 && rules.value.allow_list_length == 0 ? values.value.deny : null
            }
          }
        }
      }
    }
  }

  dynamic "dry_run_spec" {
    for_each = length(local.rules_dry_run) > 0 ? ["dry_run_rules"] : []
    content {
      inherit_from_parent = var.inherit_from_parent
      dynamic "rules" {
        for_each = local.rules_dry_run
        content {
          dynamic "condition" {
            for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
            content {
              description = condition.value.description
              expression  = condition.value.expression
              location    = condition.value.location
              title       = condition.value.title
            }
          }
          allow_all = rules.value.enforcement == false ? "TRUE" : null
          deny_all  = rules.value.enforcement == true ? "TRUE" : null
          dynamic "values" {
            for_each = rules.value.allow_list_length > 0 || rules.value.deny_list_length > 0 ? rules.value.values : []
            content {
              allowed_values = rules.value.allow_list_length > 0 && rules.value.deny_list_length == 0 ? values.value.allow : null
              denied_values  = rules.value.deny_list_length > 0 && rules.value.allow_list_length == 0 ? values.value.deny : null
            }
          }
        }
      }
    }
  }

}

/******************************************
  Exclude folders from policy (list constraint)
 *****************************************/
resource "google_org_policy_policy" "folder_policy_list_exclude_folders" {
  for_each = (local.list_policy && !local.project) ? var.exclude_folders : []

  name   = "folders/${each.value}/policies/${var.constraint}"
  parent = "folders/${each.value}"


  spec {
    reset = true
  }
}

/******************************************
  Exclude projects from policy (list constraint)
 *****************************************/
resource "google_org_policy_policy" "project_policy_list_exclude_projects" {
  for_each = (local.list_policy && !local.project) ? var.exclude_projects : []

  name   = "projects/${each.value}/policies/${var.constraint}"
  parent = "projects/${each.value}"

  spec {
    reset = true
  }
}
