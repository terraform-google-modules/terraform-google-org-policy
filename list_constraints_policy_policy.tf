/**
 * Copyright 2018 Google LLC
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
 The resources below will be provisioned if variable use_google_org_policy_policy is true
******************************************/

/******************************************
  Organization policy
 *****************************************/
resource "google_org_policy_policy" "org_policy_policy_list" {
  count = var.use_google_org_policy_policy && local.organization && local.list_policy ? 1 : 0

  name   = "${local.parent_root}/${local.policy_for_id}/policies/${var.constraint}"
  parent = "${local.parent_root}/${local.policy_for_id}"

  spec {
    rules {
      dynamic "condition" {
        for_each    = var.conditions

        content {
        description = each.key.description
        expression  = each.key.expression
        location    = each.key.location
        title       = each.key.title
      }
      }

      values {
        allowed_values = var.allow
        denied_values  = var.deny
      }
    }

    rules {
      allow_all = var.enforce == false ? "TRUE" : null
      deny_all  = var.enforce == true ? "TRUE" : null
    }
  }
}

/******************************************
  Exclude folders from policy (list constraint)
 *****************************************/
resource "google_org_policy_policy" "folder_policy_list_exclude_folders" {
  for_each = (var.use_google_org_policy_policy && local.list_policy && ! local.project) ? var.exclude_folders : []

  name   = "folders/${each.value}/policies/${var.constraint}"
  parent = "folders/${each.value}"


  spec {
    inherit_from_parent = false
    reset = true
  }
}

/******************************************
  Exclude projects from policy (list constraint)
 *****************************************/
resource "google_org_policy_policy" "project_policy_list_exclude_projects" {
  for_each = (var.use_google_org_policy_policy && local.list_policy && ! local.project) ? var.exclude_projects : []

  name   = "projects/${each.value}/policies/${var.constraint}"
  parent = "projects/${each.value}"


  spec {
    inherit_from_parent = false
    reset = true
  }
}
