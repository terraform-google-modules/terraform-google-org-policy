# Restrict Domain Constraint

This example shows how to set a list constraint on an org level.

Specifically, it sets a restricted domain policy so only users from a specified domains can be added to IAM policies.

[^]: (autogen_docs_start)


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| credentials_file_path | Service account json auth path | string | - | yes |
| organization_id | The organization id the policy is applied to | string | - | yes |
| domain_to_allow | The domain to restrict access to | string | - | yes | 

[^]: (autogen_docs_end)