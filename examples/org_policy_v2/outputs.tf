/**
 * Copyright 2019 Google LLC
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
  value = module.gcp_org_policy_v2.policy_roots[0] != null ? module.gcp_org_policy_v2.policy_roots[0] : null
}

output "organization_ids" {
  value = module.gcp_org_policy_v2.organization_ids[0] != null ? module.gcp_org_policy_v2.organization_ids[0] : null
}

output "folder_ids" {
  value = module.gcp_org_policy_v2.folder_ids[0] != null ? module.gcp_org_policy_v2.folder_ids[0] : ""
}

output "project_ids" {
  value = module.gcp_org_policy_v2.project_ids[0] != null ? module.gcp_org_policy_v2.project_ids[0] : ""
}

output "constraint_names" {
  value = module.gcp_org_policy_v2.constraint_names[0] != null ? module.gcp_org_policy_v2.constraint_names[0] : null
}

