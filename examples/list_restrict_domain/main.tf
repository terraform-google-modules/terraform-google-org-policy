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
  Provider configuration
 *****************************************/
provider "google" {
  credentials = "${file(var.credentials_file_path)}"
}

/******************************************
  Look up customer id if necessary
 *****************************************/
data "google_organization" "org" {
  domain = "${var.domain_to_allow}"
}

/******************************************
  Specify specific resource for policy
 *****************************************/
resource "google_organization_policy" "org_policy_list_allow_values" {
  org_id     = "${var.organization_id}"
  constraint = "constraints/iam.allowedPolicyMemberDomains"

  list_policy {
    allow {
      values = ["${data.google_organization.org.directory_customer_id}"]
    }
  }
}