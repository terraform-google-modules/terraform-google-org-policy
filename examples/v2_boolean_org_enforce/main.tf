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

/********************************************************
  Apply the sample constraint using the org_policy_v2 module
 *******************************************************/
module "gcp_org_policy_v2" {
  source  = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version = "~> 6.0"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
  }]
  constraint  = "compute.requireOsLogin"
  policy_type = "boolean"
}

module "parameterized_org_policy_v2" {
  source  = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version = "~> 7.0"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    parameters  = jsonencode({"allowedDomains" : ["@abc.com"]})
  }]
  constraint  = "essentialcontacts.managed.allowedContactDomains"
  policy_type = "boolean"
}
