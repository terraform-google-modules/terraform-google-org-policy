credentials_file_path = "/vagrant/terraform4.json"

organization_id = "65779779009"

exclude_folders = ["1024109644757"]

exclude_projects = ["total-pad-202201"]

/*
Using environment variables:

TF_VAR_credentials_file_path=/vagrant/terraform4.json \
TF_VAR_organization_id=65779779009 \
TF_VAR_exclude_folders='["1024109644757"]' \
TF_VAR_exclude_projects='["total-pad-202201"]' \
terraform plan
*/
