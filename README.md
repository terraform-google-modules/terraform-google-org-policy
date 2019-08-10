# Google Cloud Organization Policy Terraform Module

This Terraform module makes it easier to manage to manage [organization policies](https://cloud.google.com/resource-manager/docs/organization-policy/overview) for your Google Cloud environment, particularly when you want to have exclusion rules. This module will allow you to set a top-level org policy and then disable it on individual projects or folders easily.

Disclaimer: this module is a for_each/dynamic blocks rewrite of [terraform-google-org-policy](https://github.com/terraform-google-modules/terraform-google-org-policy).

## Compatibility
This module is meant for use with Terraform 0.12.6. If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-12.html) and
need a Terraform 0.11.x-compatible version of this module, you're out of luck!

## Usage
Many examples are included in the [examples](./examples/) folder, but simle usage is as follows:

```hcl
variable iam_policy_constraints {
  default = {
    "iam.allowedPolicyMemberDomains" = {
       #allow             = [ "all" ]
       allow             = [ "test", "test2" ]
       #deny              = [ "test", "test2" ]
       #deny              = [ "all" ]
       exclude_folders   = ["folders/folder-1-id", "folders/folder-2-id"]
       exclude_projects  = ["project1-id", "project2-id"]
    }

    "compute.disableSerialPortAccess" = {
       enforced        = true
       exclude_folders = ["folders/folder-1-id", "folders/folder-2-id"]
    }
  }
}

module "org-policy" {
  source = "../modules/gcp-org-policy"

  org_id            = "123456789"
  policy_constraint = var.iam_policy_constraints
}
```

### Variables
To control module's behavior, change variables' values regarding the following:

- `policy_constraints`: set this variable with [constraints values](https://cloud.google.com/resource-manager/docs/organization-policy/org-policy-constraints#available_constraints). See examples above.
- Policies Root: set one of the following values to determine where the policy is applied:
  - `org_id`
  - `project`
  - `folder`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| folder | The folder id the policy constraints are applied to | string | `""` | no |
| org\_id | The organization id the policy constraints are applied to | string | `""` | no |
| policy_constraints | Maps of maps defining policy constraints to be applied | map | n/a | yes |
| project | The project id the policy constraints are applied to | string | `""` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements
### Terraform plugins
- [Terraform](https://www.terraform.io/downloads.html) >= 0.12.6
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) >= v2.5.0

### Permissions
In order to execute this module, the Service Account you run as must have the **Organization Policy Administrator** (`roles/orgpolicy.PolicyAdmin`) role.

## Install
### Terraform
Be sure you have the correct Terraform version (>=0.12.6), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

### Terraform plugins

- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) >= v2.5.0

