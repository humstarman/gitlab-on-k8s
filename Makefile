SHELL=/bin/bash
MANIFEST=./manifest
SCRIPT=./scripts

all: deploy

deploy: export OP=create 
deploy: check
	-@kubectl ${OP} -f namespace.yaml
	@kubectl ${OP} -f volumes.yaml
	@kubectl ${OP} -f postgres.yaml
	@kubectl ${OP} -f redis.yaml
	@kubectl ${OP} -f gitlab.yaml

check:
	@$(SCRIPT)/check-kubectl.sh

clean: export OP=delete
clean:
	@kubectl ${OP} -f ${MANIFEST}/.
