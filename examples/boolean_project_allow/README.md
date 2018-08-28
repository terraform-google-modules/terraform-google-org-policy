# Enabling Boolean Constraint
This example shows how the boolean constraint policy can be used to explicitly **allow** a particular constraint on an individual project, regardless of higher level policies.

It disables enforcement of the `compute.disableSerialPortAccess` constraint on the given project, ensuring that serial port access can be used in the project.

[^]: (autogen_docs_start)


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| credentials_file_path | Service account json auth path | string | - | yes |
| project_id | The project ID to apply the policy to | string | - | yes |

[^]: (autogen_docs_end)