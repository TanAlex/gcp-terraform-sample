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