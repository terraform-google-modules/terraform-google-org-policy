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

module "gcp_org_policy" {
  source = "../../../examples/org_policy_v2"
  org_policies = {
    "gcp-org-policy-list-01" = {
      constraint      = "compute.vmExternalIpAccess"
      type            = "list"
      organization_id = var.org_id
      folder_id       = null
      project_id      = null
      rules = [
        # allow all, enforcement false
        # deny all, enforcement true
        {
          enforcement = true
          allow       = []
          deny        = []
          conditions  = []
        },
      ]
      exclude_folders  = []
      exclude_projects = []
    },
    "gcp-org-policy-bool-01" = {
      constraint      = "compute.requireOsLogin"
      type            = "boolean"
      organization_id = var.org_id
      folder_id       = null
      project_id      = null
      rules = [
        {
          enforcement = true
          allow       = []
          deny        = []
          conditions  = []
        }
      ]
      exclude_folders  = []
      exclude_projects = []
    }
  }
}
