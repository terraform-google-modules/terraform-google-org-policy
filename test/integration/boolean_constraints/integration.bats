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
  [[ "$output" =~ 5\ to\ add ]]
  [[ "$output" =~ 0\ to\ change ]]
  [[ "$output" =~ 0\ to\ destroy ]]
}

@test "Terraform apply" {

  run terraform apply -auto-approve -parallelism=1
  [ "$status" -eq 0 ]
  [[ "$output" =~ 5\ added ]]
  [[ "$output" =~ 0\ changed ]]
  [[ "$output" =~ 0\ destroyed ]]
}

# #################################### #
#             gcloud tests             #
# #################################### #

@test "Test constraints on project $PROJECT_ID" {

  POLICY=$(gcloud beta resource-manager org-policies list --project "$PROJECT_ID" --format="json")
  RESULT=$(check_boolean_policy "$PROJECT_CONSTRAINT" "$POLICY" "true")
  run echo "$RESULT"
  [ "$status" -eq 0 ]
  [[ "$output" = "true" ]]
}

@test "Test constraints on folder $FOLDER_ID and project $PROJECT_EXCLUDE" {

  POLICY=$(gcloud beta resource-manager org-policies list --folder "$FOLDER_ID" --format="json")
  RESULT=$(check_boolean_policy "$FOLDER_CONSTRAINT" "$POLICY" "true")
  run echo "$RESULT"
  [ "$status" -eq 0 ]
  [[ "$output" = "true" ]]

  POLICY=$(gcloud beta resource-manager org-policies list --project "$PROJECT_EXCLUDE" --format="json")
  RESULT=$(check_boolean_policy "$FOLDER_CONSTRAINT" "$POLICY" "false")
  run echo "$RESULT"
  [ "$status" -eq 0 ]
  [[ "$output" = "true" ]]
}

@test "Test constraints on organization $ORGANIZATION_ID and folder $FOLDER_EXCLUDE" {

  POLICY=$(gcloud beta resource-manager org-policies list --organization "$ORGANIZATION_ID" --format="json")
  RESULT=$(check_boolean_policy "$ORG_CONSTRAINT" "$POLICY" "true")
  run echo "$RESULT"
  [ "$status" -eq 0 ]
  [[ "$output" = "true" ]]

  POLICY=$(gcloud beta resource-manager org-policies list --folder "$FOLDER_EXCLUDE" --format="json")
  RESULT=$(check_boolean_policy "$ORG_CONSTRAINT" "$POLICY" "false")
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
  [[ "$output" =~ 5\ destroyed ]]
}