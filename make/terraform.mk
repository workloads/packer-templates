.PHONY: terraform-apply
terraform-apply: # Create prerequisite resources for a target with Terraform
	@: $(if $(target),,$(call missing_target))
	@terraform \
		-chdir="./terraform/$(target)" \
		apply

.PHONY: terraform-destroy
terraform-destroy: # Destroy prerequisite resources for a target with Terraform
	@: $(if $(target),,$(call missing_target))
	@terraform \
		-chdir="./terraform/$(target)" \
		destroy

.PHONY: terraform-init
terraform-init: # Initializes Terraform for a target
	@: $(if $(target),,$(call missing_target))
	@terraform \
		-chdir="./terraform/$(target)" \
		init \
			-upgrade
