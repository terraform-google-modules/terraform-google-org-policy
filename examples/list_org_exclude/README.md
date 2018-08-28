# List Constraint with Exclusion

This example shows how to set a list constraint on an org level and selectively disable it.

Specifically, it sets a trusted image policy so only images from a trusted image project can be used. Then it excludes that project from the policy so alternative images can be tested in that project.

[^]: (autogen_docs_start)


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| credentials_file_path | Service account json auth path | string | - | yes |
| image_project_id | The ID of a project to trust images from | string | - | yes |
| organization_id | The organization id for putting the policy | string | - | yes |

[^]: (autogen_docs_end)