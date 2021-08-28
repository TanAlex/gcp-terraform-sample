## use workspace
```
gcloud auth application-default login
> Credentials saved to file: [/Users/ttan/.config/gcloud/application_default_credentials.json]

export ENVIRONMENT=dev
export REGION=us-west1
export WORKSPACE=${ENVIRONMENT}-${REGION}
terraform workspace new ${WORKSPACE}
terraform workspace select ${WORKSPACE}
terraform workspace show
terraform init -var-file=vars-${WORKSPACE}.tfvars
terraform plan -var-file=vars-${WORKSPACE}.tfvars
terraform apply -var-file=vars-${WORKSPACE}.tfvars

```