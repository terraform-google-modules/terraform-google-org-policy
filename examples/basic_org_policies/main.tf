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

module "domain-restricted-sharing" {
  source           = "../../modules/domain_restricted_sharing"
  policy_for       = "organization"
  organization_id  = var.organization_id
  domains_to_allow = var.domains_to_allow
}

module "skip-default-network" {
  source          = "../../modules/skip_default_network"
  policy_for      = "organization"
  organization_id = var.organization_id
}

module "bucket-policy-only" {
  source          = "../../modules/bucket_policy_only"
  policy_for      = "organization"
  organization_id = var.organization_id
}

module "restrict-vm-external-ips" {
  source          = "../../modules/restrict_vm_external_ips"
  policy_for      = "organization"
  organization_id = var.organization_id
  vms_to_allow    = var.vms_to_allow
}
