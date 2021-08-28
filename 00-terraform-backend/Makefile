# dev, qa, prod; default=sandbox
ENVIRONMENT ?= dev
REGION ?= us-west1

ifeq ($(ENVIRONMENT), dev)
	REGION = us-west1
else ifeq ($(ENVIRONMENT), prod)
	REGION = us-west1
else
	REGION = us-west1
endif

print-token:
	gcloud auth print-access-token > /tmp/access_token.txt

init:
	rm -rf ./.terraform
	terraform init -var-file=./vars-$(ENVIRONMENT)-${REGION}.tfvars -upgrade

plan:
	terraform plan -var-file=./vars-$(ENVIRONMENT)-${REGION}.tfvars --out /tmp/plan.out

apply:
	terraform apply -auto-approve /tmp/plan.out