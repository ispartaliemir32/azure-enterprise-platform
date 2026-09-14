.PHONY: fmt validate-dev validate-prod

fmt:
	terraform fmt -recursive .

validate-dev:
	terraform -chdir=envs/dev init -backend=false
	terraform -chdir=envs/dev validate

validate-prod:
	terraform -chdir=envs/prod init -backend=false
	terraform -chdir=envs/prod validate
