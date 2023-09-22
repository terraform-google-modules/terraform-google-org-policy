# List Constraint with Exclusion

This example shows how to set a list constraint on an org level and selectively disable it.

Specifically, it sets a trusted image policy so only images from a trusted image project can be used. Then it excludes that project from the policy so alternative images can be tested in that project.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| organization\_id | The organization id for putting the policy | `string` | n/a | yes |
| shared\_reservation\_project\_id | The ID of a project that are allowed to create and own shared reservations in the org | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
