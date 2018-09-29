SHELL=/bin/bash
MANIFEST=./manifest
SCRIPT=./scripts

all: deploy

deploy: export OP=create 
deploy: check
	-@kubectl create -f namespace.yaml
	@kubectl create -f local-volumes.yaml
	@kubectl create -f postgres.yaml
	@kubectl create -f redis.yaml
	@kubectl create -f gitlab.yaml

check:
	@$(SCRIPT)/check-kubectl.sh
