# List Constraint with Exclusion

This example shows how to set a list constraint on an org level and selectively disable it.

Specifically, it sets a trusted image policy so only images from a trusted image project can be used. Then it excludes that project from the policy so alternative images can be tested in that project.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| image\_project\_id | The ID of a project to trust images from | string | n/a | yes |
| organization\_id | The organization id for putting the policy | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
