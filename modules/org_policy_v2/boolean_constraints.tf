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
  Organization policy (boolean constraint)
 *****************************************/
resource "google_org_policy_policy" "org_policy_boolean" {
  count = local.organization && local.boolean_policy ? 1 : 0

  name   = "${local.policy_root}/${var.policy_root_id}/policies/${var.constraint}"
  parent = "${local.policy_root}/${var.policy_root_id}"

  dynamic "spec" {
    for_each = length(local.rules) > 0 ? ["rules"] : []
    content {
      dynamic "rules" {
        for_each = local.rules
        content {
          enforce    = rules.value.enforcement != false ? "TRUE" : "FALSE"
          parameters = rules.value.parameters
          dynamic "condition" {
            for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
            content {
              description = condition.value.description
              expression  = condition.value.expression
              location    = condition.value.location
              title       = condition.value.title
            }
          }
        }
      }
    }
  }

  dynamic "dry_run_spec" {
    for_each = length(local.rules_dry_run) > 0 ? ["dry_run_rules"] : []
    content {
      dynamic "rules" {
        for_each = local.rules_dry_run
        content {
          enforce    = rules.value.enforcement != false ? "TRUE" : "FALSE"
          parameters = rules.value.parameters
          dynamic "condition" {
            for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
            content {
              description = condition.value.description
              expression  = condition.value.expression
              location    = condition.value.location
              title       = condition.value.title
            }
          }
        }
      }
    }
  }

}

/******************************************
  Folder policy (boolean constraint)
 *****************************************/
resource "google_org_policy_policy" "folder_policy_boolean" {
  count = local.folder && local.boolean_policy ? 1 : 0

  name   = "${local.policy_root}/${var.policy_root_id}/policies/${var.constraint}"
  parent = "${local.policy_root}/${var.policy_root_id}"

  dynamic "spec" {
    for_each = length(local.rules) > 0 ? ["rules"] : []
    content {
      dynamic "rules" {
        for_each = local.rules
        content {
          enforce    = rules.value.enforcement != false ? "TRUE" : "FALSE"
          parameters = rules.value.parameters
          dynamic "condition" {
            for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
            content {
              description = condition.value.description
              expression  = condition.value.expression
              location    = condition.value.location
              title       = condition.value.title
            }
          }
        }
      }
    }
  }

  dynamic "dry_run_spec" {
    for_each = length(local.rules_dry_run) > 0 ? ["dry_run_rules"] : []
    content {
      dynamic "rules" {
        for_each = local.rules_dry_run
        content {
          enforce    = rules.value.enforcement != false ? "TRUE" : "FALSE"
          parameters = rules.value.parameters
          dynamic "condition" {
            for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
            content {
              description = condition.value.description
              expression  = condition.value.expression
              location    = condition.value.location
              title       = condition.value.title
            }
          }
        }
      }
    }
  }

}

/******************************************
  Project policy (boolean constraint)
 *****************************************/
resource "google_org_policy_policy" "project_policy_boolean" {
  count = local.project && local.boolean_policy ? 1 : 0

  name   = "${local.policy_root}/${var.policy_root_id}/policies/${var.constraint}"
  parent = "${local.policy_root}/${var.policy_root_id}"

  dynamic "spec" {
    for_each = length(local.rules) > 0 ? ["rules"] : []
    content {
      dynamic "rules" {
        for_each = local.rules
        content {
          enforce    = rules.value.enforcement != false ? "TRUE" : "FALSE"
          parameters = rules.value.parameters
          dynamic "condition" {
            for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
            content {
              description = condition.value.description
              expression  = condition.value.expression
              location    = condition.value.location
              title       = condition.value.title
            }
          }
        }
      }
    }
  }

  dynamic "dry_run_spec" {
    for_each = length(local.rules_dry_run) > 0 ? ["dry_run_rules"] : []
    content {
      dynamic "rules" {
        for_each = local.rules_dry_run
        content {
          enforce    = rules.value.enforcement != false ? "TRUE" : "FALSE"
          parameters = rules.value.parameters
          dynamic "condition" {
            for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
            content {
              description = condition.value.description
              expression  = condition.value.expression
              location    = condition.value.location
              title       = condition.value.title
            }
          }
        }
      }
    }
  }

}

/******************************************
  Exclude folders from policy (boolean constraint)
 *****************************************/
resource "google_org_policy_policy" "policy_boolean_exclude_folders" {
  for_each = (local.boolean_policy && !local.project) ? var.exclude_folders : []

  name   = "folders/${each.value}/policies/${var.constraint}"
  parent = "folders/${each.value}"

  spec {
    rules {
      enforce = "FALSE"
    }
  }
}
/******************************************
  Exclude projects from policy (boolean constraint)
 *****************************************/
resource "google_org_policy_policy" "policy_boolean_exclude_projects" {
  for_each = (local.boolean_policy && !local.project) ? var.exclude_projects : []

  name   = "projects/${each.value}/policies/${var.constraint}"
  parent = "projects/${each.value}"

  spec {
    rules {
      enforce = "FALSE"
    }
  }
}
