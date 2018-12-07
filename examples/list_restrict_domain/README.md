# Restrict Domain Constraint

This example shows how to set a list constraint on an org level.

Specifically, it sets a restricted domain policy so only users from a specified domains can be added to IAM policies.

[^]: (autogen_docs_start)


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| credentials_file_path | Service account json auth path | string | - | yes |
| organization_id | The organization id the policy is applied to | string | - | yes |
| domain_customer_ids | The list of customer ids to restrict access to (see [details](https://cloud.google.com/resource-manager/docs/organization-policy/restricting-domains#retrieving_customer_id)] | list | - | yes | 

[^]: (autogen_docs_end)