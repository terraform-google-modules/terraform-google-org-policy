# Google Cloud Organization Policy v2 Terraform Module

This Terraform module makes it easier to manage [organization policies](https://cloud.google.com/resource-manager/docs/organization-policy/overview) for your Google Cloud environment, particularly when you want to have exclusion rules. This module will allow you to set a top-level org policy and then disable it on individual projects or folders easily. This module allows **_conditional policy enforcements based on the latest API version_** of the organization policies API.

Organization Policies are of two types `boolean` and `list`.

---

## Usage
Example usage is included in the [examples](./examples/org_policy_v2) folder, but simple usage is as follows:

- Boolean organization policy

```hcl
module "gcp_org_policy_v2_bool" {
  source           = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version          = "~> 7.0"

  policy_root      = "organization"    # either of organization, folder or project
  policy_root_id   = "123456789"       # either of org id, folder id or project id
  constraint       = "constraint name" # constraint identifier without constraints/ prefix. Example "compute.requireOsLogin"
  policy_type      = "boolean"         # either of list or boolean
  exclude_folders  = []
  exclude_projects = []

  rules = [
    # Rule 1
    {
      enforcement = false
      dry_run     = true
    },
    # Rule 2
    {
      enforcement = true
      conditions  = [{
        description = "description of the condition"
        expression  = "resource.matchTagId('tagKeys/123456789', 'tagValues/123456789') && resource.matchTag('123456789/env', 'prod')"
        location    = "sample-location.log"
        title       = "Title of the condition"
      }]
    },
  ]
}
```

- Boolean organization policy with parameters

```hcl
module "parameterized_org_policy_v2_bool" {
  source           = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version          = "~> 7.0"

  policy_root      = "organization"    # either of organization, folder or project
  policy_root_id   = "123456789"       # either of org id, folder id or project id
  constraint       = "constraint name" # constraint identifier without constraints/ prefix. Example "essentialcontacts.managed.allowedContactDomains"
  policy_type      = "boolean"         # either of list or boolean
  exclude_folders  = []
  exclude_projects = []

  rules = [
    # Rule 1
    {
      enforcement = false
    },
    # Rule 2
    {
      enforcement = true
      dry_run     = true
      parameters  = jsonencode({"parameter1" : ["value1", "value2"], "parameter2" : true})
      conditions  = [{
        description = "description of the condition"
        expression  = "resource.matchTagId('tagKeys/123456789', 'tagValues/123456789') && resource.matchTag('123456789/env', 'prod')"
        location    = "sample-location.log"
        title       = "Title of the condition"
      }]
    },
  ]
}
```

- List organization policy

```hcl
module "gcp_org_policy_v2_list" {
  source  = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version = "~> 7.2"

  policy_root    = "organization"    # either of organization, folder or project
  policy_root_id = "123456789"       # either of org id, folder id or project id
  constraint     = "constraint name" # constraint identifier without constraints/ prefix. Example "gcp.resourceLocations"
  policy_type    = "list"

  rules = [
    # Rule 1
    {
      enforcement = true
      allow       = ["in:us-locations"]
    }
  ]
}
```

### Variables
To control module's behavior, change variables' values regarding the following:

- `constraint`: set this variable with the [constraint value](https://cloud.google.com/resource-manager/docs/organization-policy/org-policy-constraints#available_constraints) in the form `{constraint identifier}`. For example, `serviceuser.services`
- `policy_type`: Specify either `boolean` for boolean policies or `list` for list policies.
- `policy_root`: set one of the following values to determine where the policy is applied. Values should be either one of the below.
  - organization
  - project
  - folder
- `policy_root_id`: set one of the following values to determine where the policy is applied. Based on `policy_root`, either one of the below IDs should be provided.
  - organization_id
  - project_id
  - folder_id
- `exclude_folders`: a list of folder IDs to be excluded from this policy. These folders must be lower in the hierarchy than the policy root.
- `exclude_projects`: a list of project IDs to be excluded from this policy. They must be lower in the hierarchy than the policy root.
- `rules`: Specify policy rules and conditions. Rules contain the following parameters:
  - `enforcement`: if `true` or `null`then policy will `deny_all`; if `false` then policy will `allow_all`. Applies for `boolean` based policies.
  - `parameters`: Applies for `boolean` type policies for `managed` constraints, if constraint has parameters defined. Pass parameter values when policy enforcement is enabled. Ensure that parameter value types match those defined in the constraint definition. For example: `{"allowedLocations" : ["us-east1", "us-west1"], "allowAll" : true }`
  - `allow`: list of values to include in the policy with ALLOW behavior. Set `enforce` to `null` to use it.
  - `deny`: list of values to include in the policy with DENY behavior. Set `enforce` to `null` to use it.
  - `conditions`: A condition which determines whether this rule is used in the evaluation of the policy. When set, the expression field in the `Expr` must include from 1 to 10 subexpressions, joined by the "||" or "&&" operators. Each subexpression must be of the form "resource.matchTag('/tag_key_short_name, 'tag_value_short_name')". or "resource.matchTagId('tagKeys/key_id', 'tagValues/value_id')". where key_name and value_name are the resource names for Label Keys and Values. These names are available from the Tag Manager Service. An example expression is: "resource.matchTag('123456789/environment, 'prod')". or "resource.matchTagId('tagKeys/123', 'tagValues/456')". Each condition has the following properties:
    - `description`: Description of the expression. This is a longer text which describes the expression, e.g. when hovered over it in a UI.
    - `expression`: Common Expression Language, or CEL, is the expression language used to specify conditional expressions. A conditional expression consists of one or more statements that are joined using logical operators (&&, ||, or !). For more information, see the [CEL spec](https://github.com/google/cel-spec) and its [language definition](https://github.com/google/cel-spec/blob/master/doc/langdef.md).
    - `location`: String indicating the location of the expression for error reporting, e.g. a file name and a position in the file.
    - `title`: Title for the expression, i.e. a short string describing its purpose. This can be used e.g. in UIs which allow to enter the expression.

---

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

---

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| constraint | The constraint to be applied | `string` | n/a | yes |
| exclude\_folders | Set of folders to exclude from the policy | `set(string)` | `[]` | no |
| exclude\_projects | Set of projects to exclude from the policy | `set(string)` | `[]` | no |
| inherit\_from\_parent | Determines the inheritance behavior for this policy (only supported on list constraints) | `bool` | `"false"` | no |
| policy\_root | Resource hierarchy node to apply the policy to: can be one of `organization`, `folder`, or `project`. | `string` | `"organization"` | no |
| policy\_root\_id | The policy root id, either of organization\_id, folder\_id or project\_id | `string` | `null` | no |
| policy\_type | The constraint type to work with (either 'boolean' or 'list') | `string` | `"list"` | no |
| rules | List of rules per policy. | <pre>list(object(<br>    {<br>      enforcement = bool<br>      dry_run     = optional(bool, false)<br>      parameters  = optional(string, null)<br>      allow       = optional(list(string), [])<br>      deny        = optional(list(string), [])<br>      conditions = optional(list(object(<br>        {<br>          description = string<br>          expression  = string<br>          title       = string<br>          location    = string<br>        }<br>      )), [])<br>    }<br>  ))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| constraint | Policy Constraint Identifier without constraints/ prefix |
| policy\_root | Policy Root in the hierarchy for the given policy |
| policy\_root\_id | Project Root ID at which the policy is applied |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

---

## Compatibility
This module is meant for use with Terraform 1.3+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=1.3, please open an issue.

## Requirements
### Terraform plugins
- [Terraform](https://www.terraform.io/downloads.html) >= 1.3.0

### Permissions
In order to execute this module, the Service Account you run as must have the **Organization Policy Administrator** (`roles/orgpolicy.PolicyAdmin`) role.
