#!/usr/bin/env bats

load helpers

# #################################### #
#             Terraform tests          #
# #################################### #

@test "Ensure that Terraform configures the dirs and download the plugins" {

  run terraform init
  [ "$status" -eq 0 ]
}

@test "Ensure that Terraform updates the plugins" {

  run terraform get
  [ "$status" -eq 0 ]
}

@test "Terraform plan, ensure connection and creation of IAM binding resources" {

  run terraform plan
  [ "$status" -eq 0 ]
  [[ "$output" =~ 7\ to\ add ]]
  [[ "$output" =~ 0\ to\ change ]]
  [[ "$output" =~ 0\ to\ destroy ]]
}

@test "Terraform apply" {

  run terraform apply -auto-approve -parallelism=1
  [ "$status" -eq 0 ]
  [[ "$output" =~ 7\ added ]]
  [[ "$output" =~ 0\ changed ]]
  [[ "$output" =~ 0\ destroyed ]]
}

# #################################### #
#             gcloud tests             #
# #################################### #

@test "Test constraints on project $PROJECT_ID" {

  POLICY=$(gcloud beta resource-manager org-policies list --project "$PROJECT_ID" --format="json")
  RESULT=$(check_list_policy_all "$PROJECT_CONSTRAINT_DENY_ALL" "$POLICY" "deny")
  run echo "$RESULT"
  [ "$status" -eq 0 ]
  [[ "$output" = "true" ]]
}

@test "Test constraints on folder $FOLDER_ID" {

  POLICY=$(gcloud beta resource-manager org-policies list --folder "$FOLDER_ID" --format="json")
  RESULT=$(check_list_policy_all "$FOLDER_CONSTRAINT_ALLOW_ALL" "$POLICY" "allow")
  run echo "$RESULT"
  [ "$status" -eq 0 ]
  [[ "$output" = "true" ]]
}

@test "Test constraints on organization $ORGANIZATION_ID (restrict values) constraining $ORG_RESTRICT_DOMAIN_CONSTRAINT to $ORG_RESTRICT_DOMAIN_CONSTRAINT_VALUE_1" {

  POLICY=$(gcloud beta resource-manager org-policies list --organization "$ORGANIZATION_ID" --format="json")
  RESULT=$(check_list_policy_values "$ORG_RESTRICT_DOMAIN_CONSTRAINT" "$POLICY" "allow" "$ORG_RESTRICT_DOMAIN_CONSTRAINT_VALUE_1")
  run echo "$RESULT"
  [ "$status" -eq 0 ]
  [[ "$output" = "true" ]]

}

@test "Test constraints on organization $ORGANIZATION_ID (deny values) and project $PROJECT_EXCLUDE and folder $FOLDER_EXCLUDE (exclusions)" {

  POLICY=$(gcloud beta resource-manager org-policies list --organization "$ORGANIZATION_ID" --format="json")
  RESULT=$(check_list_policy_values "$ORG_CONSTRAINT" "$POLICY" "deny" "$ORG_CONSTRAINT_VALUE_1,$ORG_CONSTRAINT_VALUE_2")
  run echo "$RESULT"
  [ "$status" -eq 0 ]
  [[ "$output" = "true" ]]

  POLICY=$(gcloud beta resource-manager org-policies list --folder "$FOLDER_EXCLUDE" --format="json")
  RESULT=$(check_list_policy_all "$ORG_CONSTRAINT" "$POLICY" "default")
  run echo "$RESULT"
  [ "$status" -eq 0 ]
  [[ "$output" = "true" ]]

  POLICY=$(gcloud beta resource-manager org-policies list --project "$PROJECT_EXCLUDE" --format="json")
  RESULT=$(check_list_policy_all "$ORG_CONSTRAINT" "$POLICY" "default")
  run echo "$RESULT"
  [ "$status" -eq 0 ]
  [[ "$output" = "true" ]]
}

@test "Test constraints on folder $FOLDER_2_ID (allow values)" {

  POLICY=$(gcloud beta resource-manager org-policies list --folder "$FOLDER_2_ID" --format="json")
  RESULT=$(check_list_policy_values "$FOLDER_2_CONSTRAINT" "$POLICY" "allow" "$FOLDER_2_CONSTRAINT_VALUE_1")
  run echo "$RESULT"
  [ "$status" -eq 0 ]
  [[ "$output" = "true" ]]
}

# #################################### #
#      Terraform destroy test          #
# #################################### #

@test "Terraform destroy" {

  run terraform destroy -force
  [ "$status" -eq 0 ]
  [[ "$output" =~ 7\ destroyed ]]
}