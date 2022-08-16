output "policy_roots" {
  value = {
    for k, v in module.gcp_org_policy_v2 : k => v.policy_root
  }
}

output "organization_ids" {
  value = {
    for k, v in module.gcp_org_policy_v2 : k => v.organization_id
  }
}

output "folder_ids" {
  value = {
    for k, v in module.gcp_org_policy_v2 : k => v.folder_id
  }
}

output "project_ids" {
  value = {
    for k, v in module.gcp_org_policy_v2 : k => v.project_id
  }
}

output "constraint_names" {
  value = {
    for k, v in module.gcp_org_policy_v2 : k => v.constraint_name
  }
}