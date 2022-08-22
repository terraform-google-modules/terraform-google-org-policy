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

# List of organization policies
variable "org_policies" {
  type = map(any)
  description = "Map of organization policies to be implemented at org/folder/project level"
  default = {
    "gcp-org-policy-bool-01" = {
      constraint      = "compute.requireOsLogin"
      type            = "boolean"
      organization_id = "407684723642"
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

