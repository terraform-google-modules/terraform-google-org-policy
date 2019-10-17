#!/bin/bash
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

# VARIABLES

# Constraints
export PROJECT_CONSTRAINT='constraints/compute.disableSerialPortAccess'
export FOLDER_CONSTRAINT='constraints/compute.restrictXpnProjectLienRemoval'
export ORG_CONSTRAINT_BOOL='constraints/compute.disableSerialPortAccess'

# Make sure required vars are defined
# shellcheck disable=SC2153
if [[ -z "$FOLDER_1_ID" || -z "$PROJECT_ID" || -z "$PROJECT_EXCLUDE" || -z "$FOLDER_EXCLUDE" ]]; then
    echo "Please, make sure that following variables are set: FOLDER_ID, PROJECT_ID, PROJECT_EXCLUDE, FOLDER_EXCLUDE"
    env
    exit 3
fi

# shellcheck disable=SC2155,SC2153
export FOLDER_ID=$(echo "${FOLDER_1_ID}" | awk -F / '{print $2}')
# shellcheck disable=SC2155,SC2153
export FOLDER_EXCLUDE=$(echo "${FOLDER_EXCLUDE}" | awk -F / '{print $2}')

#################################################################
#   FUNCTIONS FOR PREPARING WORKSPACE AND CALLING BATS          #
#################################################################

# Cleans the workdir
function clean_workdir() {
  echo "Cleaning workdir"
  rm -rf terraform.tfstate*
  rm -rf -- *.tf
  rm -rf .terraform
}

# Creates the main.tf file for Terraform
function create_main_tf_file() {
  echo "Creating main.tf file"
  touch main.tf
  cat <<EOF > main.tf
provider "google" {
  version     = "~> 2.5.0"
}
module "org-policy-boolean-project" {
  source = "../../../"
  policy_for  = "project"
  constraint  = "$PROJECT_CONSTRAINT"
  project_id  = "$PROJECT_ID"
  enforce     = "true"
  policy_type = "boolean"
}
module "org-policy-boolean-folder" {
  source = "../../../"
  policy_for  = "folder"
  constraint  = "$FOLDER_CONSTRAINT"
  folder_id   = "$FOLDER_1_ID"
  enforce     = "true"
  policy_type = "boolean"
  exclude_projects = ["$PROJECT_EXCLUDE"]
}
module "org-policy-boolean-org" {
  source = "../../../"
  policy_for       = "organization"
  constraint       = "$ORG_CONSTRAINT_BOOL"
  organization_id  = "$ORGANIZATION_ID"
  enforce          = "true"
  policy_type      = "boolean"
  exclude_folders  = ["$FOLDER_EXCLUDE"]
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
bats_exitcode=$?

# Clean the environment
clean_workdir
echo "Integration test finished"
exit $bats_exitcode
