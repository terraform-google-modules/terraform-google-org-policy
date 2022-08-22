# Google Cloud Organization Policy Terraform Module

This Terraform module makes it easier to manage [organization policies](https://cloud.google.com/resource-manager/docs/organization-policy/overview) for your Google Cloud environment, particularly when you want to have exclusion rules. This module will allow you to set a top-level org policy and then disable it on individual projects or folders easily. This module allows **_conditional policy enforcements based on the latest version_** of the organization policies API.

Organization Policies are of two types `boolean` and `list`. See the documentation below for more information on:
 - [Customizing policies for boolean constraints](https://cloud.google.com/resource-manager/docs/organization-policy/creating-managing-policies#boolean_constraints)


## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v4.0.0](https://registry.terraform.io/modules/terraform-google-modules/-org-policy/google/v4.0.0).

## Usage
Example usage is included in the [examples](./examples/org_policy_v2) folder, but simple usage is as follows:

```hcl
module "gcp_org_policy" {
  source            = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version           = "~> 4.0.0"

  org_policies = {
    "gcp-org-policy-list-01" = {
      constraint       = "constraint name" # constraint identifier without constriants/ prefix
      type             = "list"
      organization_id  = "123456789"       # either of org id, folder id or project id
      folder_id        = null
      project_id       = null
      rules            = [
        {
          enforcement = true
          allow       = []
          deny        = []
          conditions  = [
            {
              description = "description of the condition"
              expression  = "resource.matchTagId('tagKeys/123456789', 'tagValues/123456789') && resource.matchTag('123456789/1234', 'abcd')"
              location    = "sample-location.log"
              title       = "Title of the condition"
            }
          ]
        },
      ]
      exclude_folders  = []
      exclude_projects = []
    },
  }
}
```

### Variables
To control module's behavior, change variables' values regarding the following:

- `constraint`: set this variable with the [constraint value](https://cloud.google.com/resource-manager/docs/organization-policy/org-policy-constraints#available_constraints) in the form `{constraint identifier}`. For example, `serviceuser.services`
- `type`: Specify either `boolean` for boolean policies or `list` for list policies.
- Policy Root: set one of the following values to determine where the policy is applied. Only one needs to be specified, others should be null for a given policy.
  - `organization_id`
  - `project_id`
  - `folder_id`
- `exclude_folders`: a list of folder IDs to be excluded from this policy. These folders must be lower in the hierarchy than the policy root.
- `exclude_projects`: a list of project IDs to be excluded from this policy. They must be lower in the hierarchy than the policy root.
- `rules`: Specify policy rules and conditions. Rules contain the following parameters:
  - `enforcement`: if `true` or `null`then policy will `deny_all`; if `false` then policy will `allow_all`. Applies for `boolean` based policies.
  - `allow`: list of values to include in the policy with ALLOW behavior. Set `enforce` to `null` to use it.
  - `deny`: list of values to include in the policy with DENY behavior. Set `enforce` to `null` to use it.
  - `conditions`: [Organization tags](https://cloud.google.com/resource-manager/docs/organization-policy/tags-organization-policy) provides a way to conditionally allow or deny policies based on whether a resource has a specific tag. You can use tags and conditional enforcement of organization policies to provide centralized control of the resources in your hierarchy. Each condition has the following properties:
    - `description`: Description of the condition
    - `expression`: Common Expression Language, or CEL, is the expression language used to specify conditional expressions. A conditional expression consists of one or more statements that are joined using logical operators (&&, ||, or !). For more information, see the [CEL spec](https://github.com/google/cel-spec) and its [language definition](https://github.com/google/cel-spec/blob/master/doc/langdef.md).
    - `location`: Log location
    - `title`: Title of the condition

### IMPORTANT
- Boolean policies (with `type: "boolean"`) can set the following variables:
  - `enforcement`: if `true` or `null` then the policy is enforced at the root; if `false` then policy is not enforced at the root.
  - Following requirements apply, refer [Terraform Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/org_policy_policy#rules):
  	- There must be one and only one Policy Rule where condition is unset.
  	- Boolean Policy Rules with conditions must set enforced to the opposite of the PolicyRule without a condition.
  	- During policy evaluation, Policy Rules with conditions that are true for a target resource take precedence.

- List policies (with `type: "list"`) can set `allow` and `deny` with a list of resources to allow or deny. For `enforcement` you can set it as follows:
  - set `enforcement` = false for `allow all`
  - set `enforcement` = true for `deny all`
- Each policy can have [maximum of 10 rules](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/org_policy_policy#rules)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| org\_policies | Map of organization policies to be implemented at org/folder/project level | `map(any)` | <pre>{<br>  "gcp-org-policy-bool-01": {<br>    "constraint": "compute.requireOsLogin",<br>    "exclude_folders": [],<br>    "exclude_projects": [],<br>    "folder_id": null,<br>    "organization_id": "407684723642",<br>    "project_id": null,<br>    "rules": [<br>      {<br>        "allow": [],<br>        "conditions": [],<br>        "deny": [],<br>        "enforcement": true<br>      }<br>    ],<br>    "type": "boolean"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| constraint\_names | Policy Constraint Identifiers |
| folder\_ids | Folder IDs if policy applied at folder level |
| organization\_ids | Organization IDs if policy applied at org level |
| policy\_roots | Policy Root in the hierarchy for the policies |
| project\_ids | Project IDs if policy applied at project level |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements
### Terraform plugins
- [Terraform](https://www.terraform.io/downloads.html) >= 0.13.0
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) >= v2.5.0

### Permissions
In order to execute this module, the Service Account you run as must have the **Organization Policy Administrator** (`roles/orgpolicy.PolicyAdmin`) role.

## Install
### Terraform
Be sure you have the correct Terraform version (0.12.x), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

### Terraform plugins

- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) >= v2.5.0

