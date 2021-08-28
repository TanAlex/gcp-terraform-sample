# GCP Terraform Samples

It uses remote_state to refer to previously build resources so we don't have to run all TF files at same time.

## Auth and login

```
PROJECT_ID=xxxxx
gcloud auth login
gcloud auth application-default login
gcloud config set project $PROJECT_ID
gcloud info
```

## Plan and apply for all resources

If you just want to plan for all
```
make plan
```

If you want to plan and apply with auto_approve turned off
```
make apply
```

If you want to plan and apply with `--auto_approve`   
**CAUTION:** auto_approve is dangerous but it's necessary for CICD Pipelines

```
make AUTO=true apply
```

## Plan and apply for individual resources folders

This is useful when you develop or simply only want to trigger changes for those resources in that folder.

This will limit your explosion radius, say if you are making changes to 10-instance for that Bastion VM instance, it will only make changes to the resources in 10-instance folder and won't impact anything else.

You can also take use of git-branch naming convention or git-tags for your CI/CD pipeline to apply changes to only one folder.  

One example is to make a branch called `/10-instance/issue-12345` and write code in CI/CD pipeline to only change 10-instance folder's resources.

```
# cd <the-folder-of-your-resource>
# For example:
cd 10-instance
make AUTO=true all

# or when you debug or develop
# just do plan or apply (without auto-approve)
cd 10-instance
make print-token
make init
make plan
make apply
```


## Handle multiple ENVIRONMENTs and REGIONs

The naming convension for those `tfvars` files are:
* backend tfvars use this convension: `backend-$(ENVIRONMENT)-${REGION}.tfvars`
* variables tfvars use this convension: `vars-$(ENVIRONMENT)-${REGION}.tfvars`

For example:  
Assuming we have `dev`, `qa` and `prod` ENVIRONMENTs and `us-east1` and `us-west1` REGIONs, we need to prepare tfvars like these
* backend-dev-us-west1.tfvars
* backend-dev-us-east1.tfvars
* vars-dev-us-west1.tfvars
* vars-dev-us-east1.tfvars
* backend-qa-us-west1.tfvars
* backend-qa-us-east1.tfvars
* vars-qa-us-west1.tfvars
* vars-qa-us-east1.tfvars

...

To apply them, override the Makefile arguments like these:

```
make ENVIRONMENT=qa REGION=us-west1 AUTO=true all
```

