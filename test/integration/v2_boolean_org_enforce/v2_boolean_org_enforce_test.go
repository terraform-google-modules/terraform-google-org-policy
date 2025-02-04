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

package v2_boolean_org_enforce

import (
    "testing"

    "github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
    "github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
    "github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/utils"
    "github.com/stretchr/testify/assert"
)

func TestVersion2BooleanOrgEnforce(t *testing.T) {

    orgPolicyv2T := tft.NewTFBlueprintTest(t)

    orgPolicyv2T.DefineVerify(
    func(assert *assert.Assertions) {
            constraintName := "constraints/" + orgPolicyv2T.GetStringOutput("constraint")
            policyRoot := "--" + orgPolicyv2T.GetStringOutput("policy_root")
            policyRootId := orgPolicyv2T.GetStringOutput("policy_root_id")

            gcOps := gcloud.WithCommonArgs([]string{policyRoot, policyRootId, "--format", "json"})
            op := gcloud.Run(t, "beta resource-manager org-policies list", gcOps).Array()

            constraintImplemented := utils.GetFirstMatchResult(t, op, "constraint", constraintName).Get("constraint").String()
            assert.Equal(constraintImplemented, constraintName, "Org policy is created and exists")

	    parameterizedConstraintName := "constraints/" + orgPolicyv2T.GetStringOutput("parameterized_constraint")
	    parameterizedConstraintImplemented := utils.GetFirstMatchResult(t, op, "constraint", parameterizedConstraintName).Get("constraint").String()
	    assert.Equal(parameterizedConstraintImplemented, parameterizedConstraintName, "Org policy is created and exists")
        })
    orgPolicyv2T.Test()
}
