#!bin/bash
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


#!/bin/bash

#################################################################
#   PLEASE FILL THE VARIABLES WITH VALID VALUES FOR TESTING     #
#   DO NOT REMOVE/ADD ANY OF THE VARIABLES                      #
#################################################################

#################################################################
#   RESOURCE IDENTIFIERS, VARIABLES AND ROLES                   #
#################################################################

# Project
export PROJECT_ID="base-project-196723"

# Organization
export ORGANIZATION_ID="65779779009"

# 1 above organization's folder to exclude from policy
export FOLDER_EXCLUDE="886025180534"

# Folder
export FOLDER_ID="886025180534"

# Folder 2 (must be different from folder above)
export FOLDER_2_ID="560109990580"

# 1 above organization's project to exclude from policy
export PROJECT_EXCLUDE="base-project-196723"


# Constraints

# Applied to: project
export PROJECT_CONSTRAINT_DENY_ALL="constraints/compute.trustedImageProjects"

# Applied to: folder
export FOLDER_CONSTRAINT_ALLOW_ALL="constraints/compute.trustedImageProjects"

# Applied to: org
export ORG_CONSTRAINT="constraints/serviceuser.services"
export ORG_CONSTRAINT_VALUE_1="doubleclicksearch.googleapis.com"
export ORG_CONSTRAINT_VALUE_2="resourceviews.googleapis.com"

# Applied to: folder 2
export FOLDER_2_CONSTRAINT="constraints/compute.trustedImageProjects"
export FOLDER_2_CONSTRAINT_VALUE_1="projects/base-project-196723"

# Credentials
export CREDENTIALS_PATH="/vagrant/terraform5.json"
export CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE=$CREDENTIALS_PATH

#################################################################
#   FUNCTIONS FOR PREPARING WORKSPACE AND CALLING BATS          #
#################################################################

# Cleans the workdir
function clean_workdir() {
  echo "Cleaning workdir"
  yes | rm -f terraform.tfstate*
  yes | rm -f *.tf
  yes | rm -rf .terraform
}

# Creates the main.tf file for Terraform
function create_main_tf_file() {
  echo "Creating main.tf file"
  touch main.tf
  cat <<EOF > main.tf
locals {
  credentials_file_path    = "$CREDENTIALS_PATH"
}

provider "google" {
  credentials              = "\${file(local.credentials_file_path)}"
}

module "org-policy-list-project" {
  source = "../../../"

  constraint  = "$PROJECT_CONSTRAINT_DENY_ALL"
  project_id  = "$PROJECT_ID"
  enforce     = "true"
  policy_type = "list"
}

module "org-policy-list-folder" {
  source = "../../../"

  constraint  = "$FOLDER_CONSTRAINT_ALLOW_ALL"
  folder_id   = "$FOLDER_ID"
  enforce     = "false"
  policy_type = "list"
}

module "org-policy-list-org" {
  source = "../../../"

  constraint       = "$ORG_CONSTRAINT"
  organization_id  = "$ORGANIZATION_ID"
  policy_type      = "list"

  exclude_folders  = ["$FOLDER_EXCLUDE"]
  exclude_projects = ["$PROJECT_EXCLUDE"]

  deny             = ["$ORG_CONSTRAINT_VALUE_1", "$ORG_CONSTRAINT_VALUE_2"]

}

module "org-policy-list-folder-2" {
  source = "../../../"

  constraint       = "$FOLDER_2_CONSTRAINT"
  folder_id        = "$FOLDER_2_ID"
  policy_type      = "list"

  allow             = ["$FOLDER_2_CONSTRAINT_VALUE_1"]

}

EOF
}

#################################################################
#   WORKSPACE CLEANING, BATS CALLING                            #
#################################################################

# Preparing environment
clean_workdir
create_main_tf_file

# Call to bats
echo "Test to execute: $(bats integration.bats -c)"
bats integration.bats

export CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE=""
unset CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE

# Clean the environment
clean_workdir
echo "Integration test finished"