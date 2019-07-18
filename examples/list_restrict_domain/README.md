# Restrict Domain Constraint

This example shows how to set a list constraint on an org level.

Specifically, it sets a restricted domain policy so only users from a specified domains can be added to IAM policies.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| credentials\_file\_path | Service account json auth path | string | n/a | yes |
| domain\_to\_allow | The domain to allow users from | string | n/a | yes |
| organization\_id | The organization id the policy is applied to | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->