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

data "google_organization" "orgs" {
  for_each = toset(var.domains_to_allow)
  domain   = each.value
}
locals {
  customer_ids    = [for org in data.google_organization.orgs : org["directory_customer_id"]]
  principal_sets  = [for id in var.principal_set_org_ids : "principalSet://iam.googleapis.com/organizations/${id}"]
  allowed_members = concat(local.customer_ids, local.principal_sets)
}

module "allowed-policy-member-domains" {
  source            = "../../"
  policy_for        = var.policy_for
  organization_id   = var.organization_id
  folder_id         = var.folder_id
  project_id        = var.project_id
  constraint        = "constraints/iam.allowedPolicyMemberDomains"
  policy_type       = "list"
  allow             = local.allowed_members
  allow_list_length = length(var.domains_to_allow) + length(var.principal_set_org_ids)
  exclude_folders   = var.exclude_folders
  exclude_projects  = var.exclude_projects
}

resource "null_resource" "input_validation" {
  lifecycle {
    precondition {
      condition     = length(var.domains_to_allow) > 0 || length(var.principal_set_org_ids) > 0
      error_message = "Error: You must provide at least one domain in 'domains_to_allow' or at least one Org ID in 'principal_set_org_ids'."
    }
  }
}
