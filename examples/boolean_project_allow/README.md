# Enabling Boolean Constraint
This example shows how the boolean constraint policy can be used to explicitly **allow** a particular constraint on an individual project, regardless of higher level policies.

It disables enforcement of the `compute.disableSerialPortAccess` constraint on the given project, ensuring that serial port access can be used in the project.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project\_id | The project ID to apply the policy to | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
