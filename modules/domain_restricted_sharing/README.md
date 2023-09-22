# Domain Restricted Sharing Module

This Terraform module allows to set a `Domain Restricted Sharing` [Organization Policy](https://cloud.google.com/resource-manager/docs/organization-policy/restricting-domains) for a list of domains. The policy may be applied on organization, folder or project level.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domains\_to\_allow | The list of domains to allow users from | `list(string)` | n/a | yes |
| exclude\_folders | Set of folders to exclude from the policy | `set(string)` | `[]` | no |
| exclude\_projects | Set of projects to exclude from the policy | `set(string)` | `[]` | no |
| folder\_id | The folder id for putting the policy | `string` | `null` | no |
| organization\_id | The organization id for putting the policy | `string` | `null` | no |
| policy\_for | Resource hierarchy node to apply the policy to: can be one of `organization`, `folder`, or `project`. | `string` | n/a | yes |
| project\_id | The project id for putting the policy | `string` | `null` | no |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
