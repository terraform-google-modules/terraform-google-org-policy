# Restrict External IP Addresses Constraint

This example shows how to set a vm external ip access policy so only specified list of VMs can have external IPs attached.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| folder\_id | The folder id for putting the policy | string | n/a | yes |
| vms\_to\_allow | The list of VMs are allowed to use external IP, every element of the list must be identified by the VM instance name, in the form: projects/PROJECT_ID/zones/ZONE/instances/INSTANCE | list(string) | `<list>` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
