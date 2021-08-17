.PHONY: help
help: ## Show help menu
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-35s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: terraform-plan
terraform-plan: ## Execute "terraform plan -out=plan"
	terraform -chdir=vm/infra plan -out=plan

.PHONY: terraform-apply
terraform-apply: terraform-plan ## Execute "terraform apply "plan""
	terraform -chdir=vm/infra apply "plan"

.PHONY: terraform-state-list
terraform-state-list: ## Execute "terraform state list"
	terraform -chdir=vm/infra state list

.PHONY: terraform-destroy
terraform-destroy: ## Execute terraform destroy -auto-approve"
	@echo "Waiting 20 seconds... If you want to cancel, press: ctrl+c"
	@sleep 20
	terraform -chdir=vm/infra destroy -auto-approve

.PHONY: ansible-apply
ansible-apply: ## Install packages in AWS instance using Ansible Playbooks
	@ansible-inventory -i vm/config/install_gitlab/aws_ec2.yml --graph
	ansible-playbook -i vm/config/install_gitlab/aws_ec2.yml vm/config/install_gitlab/main.yml

.DEFAULT_GOAL := help                                                          