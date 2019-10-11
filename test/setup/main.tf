/**
 * Copyright 2019 Google LLC
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

module "project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 3.0"

  name              = "ci-org-policy"
  random_project_id = true
  org_id            = var.org_id
  folder_id         = var.folder_id
  billing_account   = var.billing_account

  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "storage-api.googleapis.com",
    "serviceusage.googleapis.com"
  ]
}

module "project_exclude" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 3.0"

  name              = "ci-org-policy-exclude"
  random_project_id = true
  org_id            = var.org_id
  folder_id         = var.folder_id
  billing_account   = var.billing_account

  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "storage-api.googleapis.com",
    "serviceusage.googleapis.com"
  ]
}

resource "random_id" "folders" {
  byte_length = 8
}

resource "google_folder" "org_policy_1" {
  display_name = "test-folder-1-${random_id.folders.hex}"
  parent       = "folders/${var.folder_id}"
}

resource "google_folder" "org_policy_2" {
  display_name = "test-folder-2-${random_id.folders.hex}"
  parent       = "folders/${var.folder_id}"
}

resource "null_resource" "wait_apis" {
  # Adding a pause as a workaround for of the provider issue
  # https://github.com/terraform-providers/terraform-provider-google/issues/1131
  provisioner "local-exec" {
    command = "echo sleep 30s for APIs to get enabled; sleep 30"
  }
  depends_on = [module.project.project_id,
    module.project_exclude.project_id
  ]
}

