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
  Organization policy, allow all (list constraint)
 *****************************************/
resource "google_organization_policy" "org_policy_list_allow_all" {
  count = local.organization && local.list_policy && local.enforce == false ? 1 : 0

  org_id     = var.organization_id
  constraint = var.constraint

  list_policy {
    allow {
      all = true
    }
  }
}

/******************************************
  Folder policy, allow all (list constraint)
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_list_allow_all" {
  count = local.folder && local.list_policy && local.enforce == false ? 1 : 0

  folder     = var.folder_id
  constraint = var.constraint

  list_policy {
    allow {
      all = true
    }
  }
}

/******************************************
  Project policy, allow all (list constraint)
 *****************************************/
resource "google_project_organization_policy" "project_policy_list_allow_all" {
  count = local.project && local.list_policy && local.enforce == false ? 1 : 0

  project    = var.project_id
  constraint = var.constraint

  list_policy {
    allow {
      all = true
    }
  }
}

/******************************************
  Organization policy, deny all (list constraint)
 *****************************************/
resource "google_organization_policy" "org_policy_list_deny_all" {
  count = local.organization && local.list_policy && local.enforce == true ? 1 : 0

  org_id     = var.organization_id
  constraint = var.constraint

  list_policy {
    deny {
      all = true
    }
  }
}

/******************************************
  Folder policy, deny all (list constraint)
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_list_deny_all" {
  count = local.folder && local.list_policy && local.enforce == true ? 1 : 0

  folder     = var.folder_id
  constraint = var.constraint

  list_policy {
    deny {
      all = true
    }
  }
}

/******************************************
  Project policy, deny all (list constraint)
 *****************************************/
resource "google_project_organization_policy" "project_policy_list_deny_all" {
  count = local.project && local.list_policy && local.enforce == true ? 1 : 0

  project    = var.project_id
  constraint = var.constraint

  list_policy {
    deny {
      all = true
    }
  }
}

/******************************************
  Organization policy, deny values (list constraint)
 *****************************************/
resource "google_organization_policy" "org_policy_list_deny_values" {
  count = local.organization && local.list_policy && var.deny_list_length > 0 ? 1 : 0

  org_id     = var.organization_id
  constraint = var.constraint

  list_policy {
    deny {
      values = var.deny
    }
  }
}

/******************************************
  Folder policy, deny values (list constraint)
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_list_deny_values" {
  count = local.folder && local.list_policy && var.deny_list_length > 0 ? 1 : 0

  folder     = var.folder_id
  constraint = var.constraint

  list_policy {
    deny {
      values = var.deny
    }
  }
}

/******************************************
  Project policy, deny values (list constraint)
 *****************************************/
resource "google_project_organization_policy" "project_policy_list_deny_values" {
  count = local.project && local.list_policy && var.deny_list_length > 0 ? 1 : 0

  project    = var.project_id
  constraint = var.constraint

  list_policy {
    deny {
      values = var.deny
    }
  }
}

/******************************************
  Organization policy, allow values (list constraint)
 *****************************************/
resource "google_organization_policy" "org_policy_list_allow_values" {
  count = local.organization && local.list_policy && var.allow_list_length > 0 ? 1 : 0

  org_id     = var.organization_id
  constraint = var.constraint

  list_policy {
    allow {
      values = var.allow
    }
  }
}

/******************************************
  Folder policy, allow values (list constraint)
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_list_allow_values" {
  count = local.folder && local.list_policy && var.allow_list_length > 0 ? 1 : 0

  folder     = var.folder_id
  constraint = var.constraint

  list_policy {
    allow {
      values = var.allow
    }
  }
}

/******************************************
  Project policy, allow values (list constraint)
 *****************************************/
resource "google_project_organization_policy" "project_policy_list_allow_values" {
  count = local.project && local.list_policy && var.allow_list_length > 0 ? 1 : 0

  project    = var.project_id
  constraint = var.constraint

  list_policy {
    allow {
      values = var.allow
    }
  }
}

/******************************************
  Exclude folders from policy (list constraint)
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_list_exclude_folders" {
  count = local.list_policy && ! local.project ? local.exclude_folders_list_length : 0

  folder     = var.exclude_folders[count.index]
  constraint = var.constraint

  restore_policy {
    default = true
  }
}

/******************************************
  Exclude projects from policy (list constraint)
 *****************************************/
resource "google_project_organization_policy" "project_policy_list_exclude_projects" {
  count = local.list_policy && ! local.project ? local.exclude_projects_list_length : 0

  project    = var.exclude_projects[count.index]
  constraint = var.constraint

  restore_policy {
    default = true
  }
}

