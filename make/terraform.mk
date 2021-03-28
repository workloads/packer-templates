# configuration for Terraform-specific variables
ifdef auto-approve
terraform_auto_approve = -auto-approve
else
terraform_auto_approve =
endif

.PHONY: terraform-plan
terraform-plan: # Plan prerequisite resources for a target with Terraform
	@: $(if $(target),,$(call missing_target))
	@terraform \
		-chdir="./terraform/$(target)" \
		plan \

.PHONY: terraform-apply
terraform-apply: # Create prerequisite resources for a target with Terraform
	@: $(if $(target),,$(call missing_target))
	@terraform \
		-chdir="./terraform/$(target)" \
		apply \
			$(terraform_auto_approve)

.PHONY: terraform-destroy
terraform-destroy: # Destroy prerequisite resources for a target with Terraform
	@: $(if $(target),,$(call missing_target))
	@terraform \
		-chdir="./terraform/$(target)" \
		destroy \
			$(terraform_auto_approve)

.PHONY: terraform-init
terraform-init: # Initializes Terraform for a target
	@: $(if $(target),,$(call missing_target))
	@terraform \
		-chdir="./terraform/$(target)" \
		init \
			-upgrade
