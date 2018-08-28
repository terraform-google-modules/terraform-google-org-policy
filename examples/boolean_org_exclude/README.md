# Boolean Constraint with Exclusion
This example shows how a boolean constraint (compute.disableSerialPortAccess) can be applied at an org level and selectively disabled on certain folders.

## Folder-level
If you wanted to set the policy on a folder level and selectively disable it on certain projects in that folder, you could use a config like this:

```hcl
module "folder-disable-serial-port-access-enforce-with-excludes" {
  source            = "github.com/terraform-google-modules/terraform-google-org-policy"

  folder_id   = "folders/my-folder-id"
  constraint  = "compute.disableSerialPortAccess"
  enforce     = "true"
  policy_type = "boolean"

  exclude_projects = ["my-project"]
}
```

[^]: (autogen_docs_start)
[^]: (autogen_docs_end)
