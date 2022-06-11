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
  Organization policy (boolean constraint)
 *****************************************/
resource "google_org_policy_policy" "org_policy_policy_boolean" {
  count = var.use_google_org_policy_policy && local.organization && local.boolean_policy ? 1 : 0
  name = "organization/${var.organization_id}/policies/${var.constraint}"
  parent = "organization/${var.organization_id}"

  spec {
    rules {
      enforce = local.enforce_v2
      dynamic "condition" {
        for_each    = var.conditions

        content {
          description = each.key.description
          expression  = each.key.expression
          location    = each.key.location
          title       = each.key.title
        }
      }
    }
  }
}

/******************************************
 Exclude folders from policy (boolean constraint)
 *****************************************/
resource "google_org_policy_policy" "policy_policy_boolean_exclude_folders" {
  for_each = (var.use_google_org_policy_policy && local.boolean_policy && !local.project) ? var.exclude_folders : []

  name = "folders/${var.organization_id}/policies/${var.constraint}"
  parent = "folders/${var.organization_id}"
  spec {
    rules {
      enforce = local.enforce_v2 == false ? "TRUE": "FALSE"
    }
  }
}

/******************************************
 Exclude projects from policy (boolean constraint)
 *****************************************/
resource "google_org_policy_policy" "policy_policy_boolean_exclude_projects" {
  for_each = (var.use_google_org_policy_policy && local.boolean_policy && !local.project) ? var.exclude_projects : []

  name = "projects/${var.organization_id}/policies/${var.constraint}"
  parent = "projects/${var.organization_id}"
  spec {
    rules {
      enforce = local.enforce_v2 == false ? "TRUE": "FALSE"
    }
  }
}
