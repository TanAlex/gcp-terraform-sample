# dev, qa, prod; default=sandbox
ENVIRONMENT ?= dev
REGION ?= us-west1
AUTO ?= false

ifeq ($(ENVIRONMENT), dev)
	REGION = us-west1
else ifeq ($(ENVIRONMENT), prod)
	REGION = us-west1
else
	REGION = us-west1
endif

ifeq ($(AUTO), true)
	AUTO_APPROVE = -auto-approve
else
	AUTO_APPROVE =
endif

print-token:
	gcloud auth print-access-token > /tmp/access_token.txt

init:
	rm -rf ./.terraform
	terraform init -var-file=./vars-$(ENVIRONMENT)-${REGION}.tfvars -upgrade

plan:
	terraform plan -var-file=./vars-$(ENVIRONMENT)-${REGION}.tfvars --out ./plan.out

apply:
	terraform apply $(AUTO_APPROVE) ./plan.out

destroy:
	terraform apply -destroy -var-file=./vars-$(ENVIRONMENT)-${REGION}.tfvars 

all: print-token init plan apply