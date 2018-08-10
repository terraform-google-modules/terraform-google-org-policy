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
  Locals configuration for module logic
 *****************************************/
locals {
  organization                 = "${var.organization_id != ""}"
  folder                       = "${var.folder_id != ""}"
  project                      = "${var.project_id != ""}"
  boolean_policy               = "${var.policy_type == "boolean" }"
  list_policy                  = "${var.policy_type == "list" && !local.invalid_config}"
  deny_list_length             = "${length(compact(var.deny))}"
  allow_list_length            = "${length(compact(var.allow))}"
  enforce                      = "${(local.allow_list_length > 0 || local.deny_list_length > 0) ? "" : var.enforce}"
  exclude_folders_list_length  = "${length(compact(var.exclude_folders))}"
  exclude_projects_list_length = "${length(compact(var.exclude_projects))}"
  invalid_config_case_1        = "${local.deny_list_length > 0 && local.allow_list_length > 0}"
  invalid_config_case_2        = "${(local.allow_list_length + local.deny_list_length) > 0 && (var.enforce == "true" || local.enforce == "false")}"
  invalid_config               = "${var.policy_type == "list" && (local.invalid_config_case_1 || local.invalid_config_case_2)}"
}

/******************************************
  Checks a valid configuration for list constraint
 *****************************************/
resource "null_resource" "config_check" {
  /*
     * This resource shows the user a message intentionally
     *
     * If user sets two (or more) of following variables when policy type is "list":
     * - allow
     * - deny
     * - enforce ("true" or "false")
     * the configuration is invalid and the message below is shown
     *
     * ( This approach is taken from https://github.com/hashicorp/terraform/issues/15469 )
     */
  count = "${local.invalid_config ? 1 : 0}"

  "For list constraints only one of enforce, allow, and deny may be included." = true
}
