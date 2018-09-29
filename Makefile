SHELL=/bin/bash
MANIFEST=./manifest
SCRIPT=./scripts

all: deploy

deploy: export OP=create 
deploy: check
	-@kubectl ${OP} -f ${MANIFEST}/namespace.yaml
	@kubectl ${OP} -f ${MANIFEST}/volumes.yaml
	@kubectl ${OP} -f ${MANIFEST}/postgres.yaml
	@kubectl ${OP} -f ${MANIFEST}/redis.yaml
	@kubectl ${OP} -f ${MANIFEST}/gitlab.yaml

check:
	@$(SCRIPT)/check-kubectl.sh

clean: export OP=delete
clean:
	@kubectl ${OP} -f ${MANIFEST}/.
