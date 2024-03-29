# dev, qa, prod; default=sandbox
ENVIRONMENT ?= dev
REGION ?= us-west1
AUTO_APPROVE ?= false

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
	@set -e; for task in $$(ls -d ??-*); do \
	    echo "\r\033[01;31mProcessing $$task ...\033[0m"; \
		( cd $$task; make init; echo; echo;) \
	done

plan: print-token
	@set -e; for task in $$(ls -d ??-*); do \
	    echo "\r\033[01;31mProcessing $$task ...\033[0m"; \
		( cd $$task; make init; make plan; echo; echo;) \
	done

apply: print-token
	@set -e; for task in $$(ls -d ??-*); do \
	    echo "\r\033[01;31mProcessing $$task ...\033[0m"; \
		( cd $$task; make init; make plan; make AUTO=$(AUTO) apply; echo; echo;) \
	done

# Delete resources in the sub-dirs in reverse order
destroy-all: print-token
	@set -e; for task in $$(ls -d ??-* | sort -rn); do \
	    echo "\r\033[01;31mProcessing $$task ...\033[0m"; \
		( cd $$task; make AUTO=$(AUTO) destroy; echo; echo;) \
	done