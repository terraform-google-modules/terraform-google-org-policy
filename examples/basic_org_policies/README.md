# Recommended Starting Constraints

This example shows how to set a basic list of [organization policies](https://cloud.google.com/resource-manager/docs/organization-policy/org-policy-constraints) including:
- Bucket Policy Only (uniform bucket-level access)
- Domain Restricted Sharing
- Allowed External IPs for VM instances
- Skip Default Network Creation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| domains\_to\_allow | The list of domains to allow users from | list(string) | n/a | yes |
| organization\_id | The organization id for putting the policy | string | n/a | yes |
| vms\_to\_allow | The list of VMs are allowed to use external IP, every element of the list must be identified by the VM instance name, in the form: projects/PROJECT_ID/zones/ZONE/instances/INSTANCE | list(string) | `<list>` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
