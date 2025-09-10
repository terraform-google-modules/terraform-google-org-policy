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

variable "policy_root" {
  description = "Resource hierarchy node to apply the policy to: can be one of `organization`, `folder`, or `project`."
  type        = string
  default     = "organization"
  validation {
    condition     = contains(["organization", "folder", "project"], var.policy_root)
    error_message = "policy_root should be one of organization, folder, or project"
  }
}

variable "policy_root_id" {
  description = "The policy root id, either of organization_id, folder_id or project_id"
  type        = string
  default     = null
}

variable "exclude_folders" {
  description = "Set of folders to exclude from the policy"
  type        = set(string)
  default     = []
}

variable "exclude_projects" {
  description = "Set of projects to exclude from the policy"
  type        = set(string)
  default     = []
}

variable "constraint" {
  description = "The constraint to be applied"
  type        = string
}

variable "policy_type" {
  description = "The constraint type to work with (either 'boolean' or 'list')"
  type        = string
  default     = "list"
}

variable "inherit_from_parent" {
  description = "Determines the inheritance behavior for this policy (only supported on list constraints)"
  type        = bool
  default     = "false"
}

variable "rules" {
  description = "List of rules per policy."
  type = list(object(
    {
      enforcement = bool
      dry_run     = optional(bool, false)
      parameters  = optional(string, null)
      allow       = optional(list(string), [])
      deny        = optional(list(string), [])
      conditions = optional(list(object(
        {
          description = string
          expression  = string
          title       = string
          location    = string
        }
      )), [])
    }
  ))
}
