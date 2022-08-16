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
            fmt.Print(contraint_name)

        })
    orgPolicyv2T.Test()
}
