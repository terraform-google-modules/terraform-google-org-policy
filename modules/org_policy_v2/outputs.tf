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

output "policy_root" {
  description = "Policy Root in the hierarchy for the given policy"
  value       = var.policy_root
}

output "policy_root_id" {
  description = "Project Root ID at which the policy is applied"
  value       = var.policy_root_id
}

output "constraint" {
  description = "Policy Constraint Identifier without constraints/ prefix"
  value       = var.constraint
}
