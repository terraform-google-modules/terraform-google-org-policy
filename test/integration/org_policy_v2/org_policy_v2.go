// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package org_policy_v2

import (
	"fmt"
     "testing"

    "github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
    "github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
    "github.com/stretchr/testify/assert"
)

func TestOrgPolicyVersion2(t *testing.T) {

    orgPolicyv2T := tft.NewTFBlueprintTest(t)

    orgPolicyv2T.DefineVerify(
        func(assert *assert.Assertions) {
            contraint_name := orgPolicyv2T.GetStringOutput("org_policies")

            /*organization_id := orgPolicyv2T.Get("org_policies").Get("organization_id")
            project_id := orgPolicyv2T.Get("org_policies").Get("project_id")
            folder_id := orgPolicyv2T.Get("org_policies").Get("folder_id")
            org_id := orgPolicyv2T.Get("org_id")

            if organization_id != 'null' {
                 var label string = "organization"
                 var label_value string = organization_id
            } else if folder_id != 'null' {
                 var label string = "folder"
                 var label_value string = folder_id
            } else if project_id != 'null' {
                 var label string = "project"
                 var label_value string = project_id
            }
            gcOps := gcloud.WithCommonArgs([]string{label, label_value, "--format", "json"})

            op := gcloud.Run(t, "beta resource-manager org-policies list", gcOps).Array()[0]
            contraint_implemented := op.Get("constraint").String()
            assert.Contains(contraint_implemented, contraint_name, "Org policy is created and exists")*/
        })
    orgPolicyv2T.Test()
}
