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

module "org-disable-serial-port-access-deny-all-with-excludes" {
  source = "../../"

  organization_id  = "${var.organization_id}"
  constraint       = "compute.disableSerialPortAccess"
  enforce          = "true"
  policy_type      = "boolean"

  exclude_folders  = "${var.exclude_folders}"
  exclude_projects = "${var.exclude_projects}"
}

/*
To set policy with a boolean constraint, set the following variables:
  - One (and only one) of organization_id, folder_id or project_id and determines where the root of the policy is specified
  - policy_type: "boolean"
  - enforce: "true", then the policy is enforced. If "false", then any configuration is acceptable.

  module "folder-disable-serial-port-access-allow-all" {
    source = "source_path"

    folder_id    = "${var.folder_id}"
    constraint   = "compute.disableSerialPortAccess"
    enforce      = "true"
    policy_type  = "boolean"
  }


To excludes some services:
  - To exclude folders and/or projects as organization root set the following variables:
    - organization_id: root of the policy
    - policy_type: "boolean"
    - enforce: "true", then the Policy is enforced. If "false", then any configuration is acceptable.
    - exclude_folders: list of folders to exclude from the policy
    - exclude_projects: list of projects to exclude from the policy

    module "org-disable-serial-port-access-enforce-with-excludes" {
      source = "source_path"

      organization_id = "${var.organization_id}"
      constraint      = "compute.disableSerialPortAccess"
      enforce         = "true"
      policy_type     = "boolean"

      exclude_folders  = "${var.exclude_folders}"
      exclude_projects = "${var.exclude_projects}"
    }

  - To exclude projects as folder root:
    - folder_id: root of the policy
    - policy_type: "boolean"
    - enforce: "true", then the Policy is enforced. If "false", then any configuration is acceptable.
    - exclude_projects: list of projects to exclude from the policy

    module "folder-disable-serial-port-access-enforce-with-excludes" {
      source = "source_path"

      folder_id  = "${var.folder_id}"
      constraint  = "compute.disableSerialPortAccess"
      enforce     = "boolean"
      policy_type = "list"

      exclude_projects = "${var.exclude_projects}"
    }
*/
