SHELL=/bin/bash
MANIFEST=./manifest
SCRIPT=./scripts

all: deploy

deploy: export OP=create 
deploy: 
	-@kubectl ${OP} -f ${MANIFEST}/namespace.yaml
	@kubectl ${OP} -f ${MANIFEST}/rbac.yaml
	@kubectl ${OP} -f ${MANIFEST}/ingress.yaml
	@kubectl ${OP} -f ${MANIFEST}/gitlab.yaml

check:
	@$(SCRIPT)/check-kubectl.sh

clean: export OP=delete
clean:
	@kubectl ${OP} -f ${MANIFEST}/.

ingress:
	@kubectl delete -f ${MANIFEST}/ingress.yaml
	@kubectl create -f ${MANIFEST}/ingress.yaml
