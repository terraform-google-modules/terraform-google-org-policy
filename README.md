# Google Cloud Organization Policy Terraform Module

This Terraform module makes it easier to manage [organization policies](https://cloud.google.com/resource-manager/docs/organization-policy/overview) for your Google Cloud environment, particularly when you want to have exclusion rules. This module will allow you to set a top-level org policy and then disable it on individual projects or folders easily.

## Compatibility
This module is meant for use with Terraform 1.3+ and tested using Terraform 1.10+. If you find incompatibilities using Terraform >=1.3, please open an issue.

## Usage
Many examples are included in the [examples](./examples/) folder, but simple usage is as follows:

```hcl
module "org-policy" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 7.0"

  policy_for        = "organization"
  constraint        = "constraints/serviceuser.services"
  policy_type       = "list"
  organization_id   = "123456789"
  enforce           = true
  exclude_folders   = ["folders/folder-1-id", "folders/folder-2-id"]
  exclude_projects  = ["project3", "project4"]
}
```

### Variables
To control module's behavior, change variables' values regarding the following:

- `constraint`: set this variable with the [constraint value](https://cloud.google.com/resource-manager/docs/organization-policy/org-policy-constraints#available_constraints) in the form `constraints/{constraint identifier}`. For example, `constraints/serviceuser.services`
- `policy_type`: Specify either `boolean` for boolean policies or `list` for list policies. (default `list`)
- Policy Root: set one of the following values to determine where the policy is applied:
  - `organization_id`
  - `project_id`
  - `folder_id`
- `policy_for`: Specify the hierarchy level where the policy is applied. Can be **one of** the following values.
  - `organization`
  - `folder`
  - `project`
- `exclude_folders`: a list of folder IDs to be excluded from this policy. These folders must be lower in the hierarchy than the policy root.
- `exclude_projects`: a list of project IDs to be excluded from this policy. They must be lower in the hierarchy than the policy root.
- Boolean policies (with `policy_type: "boolean"`) can set the following variables:
  - `enforce`: if `true` or `null` then the policy is enforced at the root; if `false` then policy is not enforced at the root. (default `null`)
- List policies (with `policy_type: "list"`) can set **one of** the following variables. Only one may be set.
  - `enforce`: if `true` or `null` then policy will deny all; if `false` then policy will allow all (default `null`)
  - `allow`: list of values to include in the policy with ALLOW behavior. Set `enforce` to `null` to use it.
  - `deny`: list of values to include in the policy with DENY behavior. Set `enforce` to `null` to use it.
- List policies with allow or deny values require the length to be set (a workaround for [this terraform issue](https://github.com/hashicorp/terraform/issues/10857))
  - `allow_list_length`
  - `deny_list_length`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow | (Only for list constraints) List of values which should be allowed | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| allow\_list\_length | The number of elements in the allow list | `number` | `0` | no |
| constraint | The constraint to be applied | `string` | n/a | yes |
| deny | (Only for list constraints) List of values which should be denied | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| deny\_list\_length | The number of elements in the deny list | `number` | `0` | no |
| enforce | If boolean constraint, whether the policy is enforced at the root; if list constraint, whether to deny all (true) or allow all | `bool` | `null` | no |
| exclude\_folders | Set of folders to exclude from the policy | `set(string)` | `[]` | no |
| exclude\_projects | Set of projects to exclude from the policy | `set(string)` | `[]` | no |
| folder\_id | The folder id for putting the policy | `string` | `null` | no |
| organization\_id | The organization id for putting the policy | `string` | `null` | no |
| policy\_for | Resource hierarchy node to apply the policy to: can be one of `organization`, `folder`, or `project`. | `string` | n/a | yes |
| policy\_type | The constraint type to work with (either 'boolean' or 'list') | `string` | `"list"` | no |
| project\_id | The project id for putting the policy | `string` | `null` | no |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements
### Terraform plugins
- [Terraform](https://www.terraform.io/downloads.html) >= 1.3

### Permissions
In order to execute this module, the Service Account you run as must have the **Organization Policy Administrator** (`roles/orgpolicy.PolicyAdmin`) role.
