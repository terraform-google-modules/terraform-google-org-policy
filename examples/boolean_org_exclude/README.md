# Boolean Constraint with Exclusion
This example shows how a boolean constraint (compute.disableSerialPortAccess) can be applied at an org level and selectively disabled on certain folders.

## Folder-level
If you wanted to set the policy on a folder level and selectively disable it on certain projects in that folder, you could use a config like this:

```hcl
module "folder-disable-serial-port-access-enforce-with-excludes" {
  source      = "github.com/terraform-google-modules/terraform-google-org-policy"
  folder_id   = "folders/my-folder-id"
  constraint  = "compute.disableSerialPortAccess"
  enforce     = true
  policy_type = "boolean"
  exclude_projects = ["my-project"]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| excluded\_folder\_id | ID of a folder to exclude from the policy | string | n/a | yes |
| organization\_id | The organization id for putting the policy | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
