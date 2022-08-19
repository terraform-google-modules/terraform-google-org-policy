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
     "testing"

    "github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
    "github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
    "github.com/stretchr/testify/assert"
)

func TestOrgPolicyVersion2(t *testing.T) {

    orgPolicyv2T := tft.NewTFBlueprintTest(t)

    orgPolicyv2T.DefineVerify(
    func(assert *assert.Assertions) {
            constraint_name := orgPolicyv2T.GetStringOutput("constraint_names")
            organization_id := orgPolicyv2T.GetStringOutput("organization_ids")
            folder_id := orgPolicyv2T.GetStringOutput("folder_ids")
            project_id := orgPolicyv2T.GetStringOutput("project_ids")
            policy_root := orgPolicyv2T.GetStringOutput("policy_roots")
            var label string = ""
            var label_value string = ""
            var constraint_implemented string = ""
            
            if policy_root == "organization" {
                 label = "--organization"
                 label_value = organization_id
            } else if policy_root == "folder" {
                 label = "--folder"
                 label_value = folder_id
            } else if policy_root == "project" {
                 label = "--project"
                 label_value = project_id
            }
            
            gcOps := gcloud.WithCommonArgs([]string{label, label_value, "--format", "json"})
            op := gcloud.Run(t, "beta resource-manager org-policies list", gcOps)
            t.Log("pikachu")
            for i := 0; i < len(op.Array()); i++ {
            	//t.Log(op.Array()[i].Get("constraint"))
            	if op.Array()[i].Get("constraint").String() == constraint_name {
            		constraint_implemented = op.Array()[i].Get("constraint").String()
            	}
            }
            t.Log(constraint_implemented)
            
            assert.Equal(constraint_implemented, constraint_name, "Org policy is created and exists")
            
	    //gcOps := gcloud.WithCommonArgs([]string{constraint_name, label, label_value, "--format", "json"})
	    //op := gcloud.Run(t, "beta resource-manager org-policies describe", gcOps).Array()[0]
            //constraint_implemented := op.Get("constraint").String()
            
            //is_implemented := op.Get("booleanPolicy.enforced").Bool()
            //assert.Contains(constraint_implemented, constraint_name, "Org policy is created and exists")
	    //assert.True(is_implemented, "Org policy is created and exists")
        })
    orgPolicyv2T.Test()
}
