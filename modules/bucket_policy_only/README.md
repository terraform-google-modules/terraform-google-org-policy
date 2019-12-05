# Bucket Policy Only Module

This Terraform module allows to set a `Uniform Bucket-level Access` [Organization Policy](https://cloud.google.com/storage/docs/uniform-bucket-level-access). The policy may be applied on organization, folder or project level.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| exclude\_folders | List of folders to exclude from the policy | list(string) | `<list>` | no |
| exclude\_projects | List of projects to exclude from the policy | list(string) | `<list>` | no |
| folder\_id | The folder id for putting the policy | string | `"null"` | no |
| organization\_id | The organization id for putting the policy | string | `"null"` | no |
| policy\_for | Resource hierarchy node to apply the policy to: can be one of `organization`, `folder`, or `project`. | string | n/a | yes |
| project\_id | The project id for putting the policy | string | `"null"` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
