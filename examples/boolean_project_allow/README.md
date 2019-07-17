# Enabling Boolean Constraint
This example shows how the boolean constraint policy can be used to explicitly **allow** a particular constraint on an individual project, regardless of higher level policies.

It disables enforcement of the `compute.disableSerialPortAccess` constraint on the given project, ensuring that serial port access can be used in the project.

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| credentials\_file\_path | Service account json auth path | string | n/a | yes |
| project\_id | The project ID to apply the policy to | string | n/a | yes |

[^]: (autogen_docs_end)