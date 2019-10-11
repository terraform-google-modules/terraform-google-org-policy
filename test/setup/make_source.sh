#!/usr/bin/env bash

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

organization_id=$(terraform output org_id)
project_id=$(terraform output project_id)
sa_json=$(terraform output sa_key)
folder_1_id=$(terraform output folder_1_id)
folder_2_id=$(terraform output folder_2_id)
project_exclude=$(terraform output project_exclude_id)

# shellcheck disable=SC2086,SC2154
{ echo "export TF_VAR_project_id='$project_id'"; \
echo "export ORGANIZATION_ID='$organization_id'"; \
echo "export FOLDER_EXCLUDE='$folder_2_id'"; \
echo "export FOLDER_1_ID='$folder_1_id'"; \
echo "export FOLDER_2_ID='$folder_2_id'"; \
echo "export PROJECT_ID='$project_id'"; \
echo "export PROJECT_EXCLUDE='$project_exclude'"; \
echo "export FOLDER_2_CONSTRAINT_VALUE_1='projects/'$project_id"; \
echo "export SERVICE_ACCOUNT_JSON='$(echo $sa_json | base64 --decode)'"; }  >> ../source.sh
