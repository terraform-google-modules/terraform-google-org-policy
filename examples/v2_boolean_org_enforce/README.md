# Boolean Constraint with option to add multiple rules and conditions

This example shows how to set a boolean constraint on an org level, with option to add multiple rules and conditions supported by latest Organization Policy APIs.

This boolean constraint, when set to true, enables OS Login on all newly created Projects. All VM instances created in new projects will have OS Login enabled. On new and existing projects, this constraint prevents metadata updates that disable OS Login at the project or instance level. By default, the OS Login feature is disabled on Compute Engine projects. GKE instances in private clusters running node pool versions 1.20.5-gke.2000 and later support OS Login. GKE instances in public clusters do not currently support OS Login. If this constraint is applied to a Project running public clusters, GKE instances running in that Project may not function properly.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| org\_id | The organization id for applying the policy | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| constraint | Policy Constraint Identifier |
| policy\_root | Policy Root in the hierarchy for the given policy |
| policy\_root\_id | Project Root ID at which the policy is applied |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
