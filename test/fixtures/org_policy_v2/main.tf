module "gcp_org_policy" {
  source = "../../../examples/org_policy_v2"
  org_policies = {
    "gcp-org-policy-list-01" = {
      constraint      = "compute.vmExternalIpAccess"
      type            = "list"
      organization_id = var.org_id
      folder_id       = null
      project_id      = null
      rules = [
        # allow all, enforcement false
        # deny all, enforcement true
        {
          enforcement = true
          allow       = []
          deny        = []
          conditions  = []
        },
      ]
      exclude_folders  = []
      exclude_projects = []
    },
    "gcp-org-policy-bool-01" = {
      constraint      = "compute.requireOsLogin"
      type            = "boolean"
      organization_id = var.org_id
      folder_id       = null
      project_id      = null
      rules = [
        {
          enforcement = true
          allow       = []
          deny        = []
          conditions  = []
        }
      ]
      exclude_folders  = []
      exclude_projects = []
    }
  }
}
