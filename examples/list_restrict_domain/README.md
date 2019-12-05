# Restrict Domain Constraint

This example shows how to set a list constraint on a folder level.

Specifically, it sets a restricted domain policy so only users from a specified domains can be added to IAM policies.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| domains\_to\_allow | The list of domains to allow users from | list(string) | n/a | yes |
| folder\_id | The folder id for putting the policy | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
