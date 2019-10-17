# Upgrading to v3.0

The v3.0 release of *org-policy* is a backwards incompatible
release.

## Migration Instructions

In previous versions of this module the resource hirerarchy node was not defined explicitly which caused problems when the module is combined with project/folder creation. The `policy_for` variable was introduced to address that issue.

### Update for project policies
```diff
 module "project_policy" {
   source  = "terraform-google-modules/org-policy/google"
-  version = "~> 2.0"
+  version = "~> 3.0"

+  policy_for = "project"
   # ...
 }
```

### Update for folder policies
```diff
 module "folder_policy" {
   source  = "terraform-google-modules/org-policy/google"
-  version = "~> 2.0"
+  version = "~> 3.0"

+  policy_for = "folder"
   # ...
 }
```

### Update for organization policies
```diff
 module "org_policy" {
   source  = "terraform-google-modules/org-policy/google"
-  version = "~> 2.0"
+  version = "~> 3.0"

+  policy_for = "organization"
   # ...
 }
```
