/**
 * Copyright 2022 Google LLC
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
  Locals configuration for module logic
 *****************************************/
locals {
  org_policies = {
    for k, v in var.org_policies : k => merge(v, { rules = [for k1, v1 in v.rules :
      merge(v1, { allow_list_length = length(v1.allow), deny_list_length = length(v1.deny), enforcement = length(v1.allow) > 0 || length(v1.deny) > 0 ? null : v1.enforcement, values = [{ allow = v1.allow, deny = v1.deny }] })
    ] })
  }
}

/******************************************
  Invoke org-policy-v2 module
 *****************************************/
module "gcp_org_policy" {
  source = "../../modules/org_policy_v2"

  for_each = local.org_policies

  constraint  = "constraints/${each.value.constraint}"
  policy_type = each.value.type

  organization_id = each.value.organization_id
  folder_id       = each.value.folder_id
  project_id      = each.value.project_id

  policy_for = each.value.organization_id != null ? "organization" : each.value.folder_id != null ? "folder" : "project"

  rules = each.value.rules

  exclude_folders  = each.value.exclude_folders
  exclude_projects = each.value.exclude_projects
}
