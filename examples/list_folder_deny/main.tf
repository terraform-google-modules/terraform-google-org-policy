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

locals {
  credentials_file_path = "${var.credentials_file_path}"
}

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  credentials = "${file(local.credentials_file_path)}"
}

module "folder-trusted-image-projects-deny-all" {
  source = "../../"

  folder_id   = "${var.folder_id}"
  constraint  = "compute.trustedImageProjects"
  policy_type = "list"
  allow       = ["projects/${var.image_project_id}"]
}

/*
To set a policy with list contraint, set the following variables:
  - One (and only one) of organization_id, folder_id or project_id and determines where the root of the policy is specified
  - policy_type: "list"
  - enforce: "true" to root policy is to deny all or "false" to allow all

To allow/deny some services, set the following variables:
  - One (and only one) of organization_id, folder_id or project_id and determines where the root of the policy is specified
  - policy_type: "list"
  - allow/deny: list of services allowed/denied

  module "folder-service-user-services-custom-deny" {
    source = "source_path"

    folder_id   = "${var.folder_id}"
    constraint  = "serviceuser.services"
    policy_type = "list"

    deny = ["compute.googleapis.com", "deploymentmanager.googleapis.com"]
 }


To excludes some services:
  - To exclude folders and/or projects as organization root set the following variables:
    - organization_id: root of the policy
    - policy_type: "list"
    - enforce: "true" to root policy is to deny all or "false" to allow all
    - exclude_folders: list of folders to exclude from the policy
    - exclude_projects: list of projects to exclude from the policy

    module "org-trusted-image-projects-deny-all-with-excludes" {
      source = "../../../"

      organization_id = "${var.organization_id}"
      constraint      = "compute.trustedImageProjects"
      enforce         = "true"
      policy_type     = "list"

      exclude_folders  = "${var.exclude_folders}"
      exclude_projects = "${var.exclude_projects}"
    }

  - To exclude projects as folder root:
    - project_id: root of the policy
    - policy_type: "list"
    - enforce: "true" to root policy is to deny all or "false" to allow all
    - exclude_projects: list of projects to exclude from the policy

    module "folder-trusted-image-projects-deny-all-with-excludes" {
      source = "../../../"

      folder_id       = "${var.folder_id}"
      constraint      = "compute.trustedImageProjects"
      enforce         = "true"
      policy_type     = "list"

      exclude_projects = "${var.exclude_projects}"
    }
*/

