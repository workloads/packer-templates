# configuration for Terraform-specific variables
ifdef auto-approve
terraform_auto_approve = -auto-approve
else
terraform_auto_approve =
endif

.PHONY: terraform-plan
terraform-plan: # Plans prerequisite resources with Terraform
	$(if $(target),,$(call missing_target))
	terraform \
		-chdir="./terraform/$(target)" \
		plan \

.PHONY: terraform-apply
terraform-apply: # Creates prerequisite resources with Terraform
	$(if $(target),,$(call missing_target))
	terraform \
		-chdir="./terraform/$(target)" \
		apply \
			$(terraform_auto_approve)

.PHONY: terraform-destroy
terraform-destroy: # Destroys prerequisite resources with Terraform
	$(if $(target),,$(call missing_target))
	terraform \
		-chdir="./terraform/$(target)" \
		destroy \
			$(terraform_auto_approve)

.PHONY: terraform-init
terraform-init: # Initializes Terraform
	$(if $(target),,$(call missing_target))
	terraform \
		-chdir="./terraform/$(target)" \
		init \
			-upgrade

.PHONY: terraform-lint
terraform-lint: # Formats and validates Terraform
	$(if $(target),,$(call missing_target))
	terraform \
		-chdir="./terraform/$(target)" \
		fmt \
	&& \
	terraform \
		-chdir="./terraform/$(target)" \
		validate
