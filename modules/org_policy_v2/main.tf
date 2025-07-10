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

/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  organization = var.policy_root == "organization"
  folder       = var.policy_root == "folder"
  project      = var.policy_root == "project"
  # Making the policy roots as plural with additional 's' in the end - organizations, folders, projects
  policy_root = format("%s%s", var.policy_root, "s")

  boolean_policy = var.policy_type == "boolean"
  list_policy    = var.policy_type == "list"

  # Appends the rules variable with additional details
  # allow and deny list length
  # enforcement (true or false)
  # values with allow and deny list items
  rules = [
    for k, v in var.rules :
    merge(v, {
      allow_list_length = length(v.allow),
      deny_list_length  = length(v.deny),
      enforcement       = length(v.allow) > 0 || length(v.deny) > 0 ? null : v.enforcement,
      values            = [{ allow = v.allow, deny = v.deny }]
    }) if v.dry_run == false
  ]

  rules_dry_run = [
    for k, v in var.rules :
    merge(v, {
      allow_list_length = length(v.allow),
      deny_list_length  = length(v.deny),
      enforcement       = length(v.allow) > 0 || length(v.deny) > 0 ? null : v.enforcement,
      values            = [{ allow = v.allow, deny = v.deny }]
    }) if v.dry_run == true
  ]
}
