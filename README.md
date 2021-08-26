# manage_secrets_terraform
Pre-Requisite
AWS Account with restricted access.
Ansible and terraform (Terraform1.0) should be installed on machine on which terraform templates are running.
AWS CLI Installed on the machine
Install boto3 and botocore on machine

## Export the Region ##
export AWS_DEFAULT_REGION=us-east-1


## Initialise your working directory ##
terraform init

## Create the resources ##
terraform apply
