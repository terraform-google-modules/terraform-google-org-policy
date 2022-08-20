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

output "policy_roots" {
  value = {
    for k, v in module.gcp_org_policy : index(keys(module.gcp_org_policy), k) => v.policy_root
  }
}

output "organization_ids" {
  value = {
    for k, v in module.gcp_org_policy : index(keys(module.gcp_org_policy), k) => v.organization_id
  }
}

output "folder_ids" {
  value = {
    for k, v in module.gcp_org_policy : index(keys(module.gcp_org_policy), k) => v.folder_id
  }
}

output "project_ids" {
  value = {
    for k, v in module.gcp_org_policy : index(keys(module.gcp_org_policy), k) => v.project_id
  }
}

output "constraint_names" {
  value = {
    for k, v in module.gcp_org_policy : index(keys(module.gcp_org_policy), k) => v.constraint_name
  }
}

