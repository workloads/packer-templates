# configuration
MAKEFLAGS      = --no-builtin-rules --warn-undefined-variables
SHELL         := sh

.DEFAULT_GOAL := help
.ONESHELL     :
.SHELLFLAGS   := -eu -o pipefail -c

color_off      = $(shell tput sgr0)
color_bright   = $(shell tput bold)

# convenience function to alert user to missing target
define missing_target
	$(error Missing target. Specify with `target=<provider>`)
endef

.SILENT .PHONY: clear
clear:
	clear

.SILENT .PHONY: help
help: # Displays this help text
	$(info )
	$(info $(color_bright)PACKER TEMPLATES$(color_off))
	grep \
		--context=0 \
		--devices=skip \
		--extended-regexp \
		--no-filename \
			"(^[a-z-]+):{1} ?(?:[a-z-])* #" $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?# "}; {printf "\033[1m%s\033[0m;%s\n", $$1, $$2}' | \
	column \
		-c2 \
		-s ";" \
		-t
	$(info )

.PHONY: build
build: # Build a Packer Image(s) for a target
	@: $(if $(target),,$(call missing_target))
	@packer \
		build \
			-force \
			"./$(target)"

.PHONY: init
init: # Install and upgrade plugins for Packer Template(s) for a target
	@: $(if $(target),,$(call missing_target))
	@packer \
		init \
			"./$(target)"

.PHONY: lint
lint: # Formats and validates Packer Template(s) for a target
	@: $(if $(target),,$(call missing_target))
	@packer \
		fmt \
			-diff \
			"./$(target)" \
	&& \
	packer \
		validate \
			"./$(target)"

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

.PHONY: ansible-lint
ansible-lint: # Lints Ansible playbook(s)
	@yamllint \
		--config-data "{ rules: {line-length: { max: 125 } } }" \
		"playbooks/$(wildcard *.yml)" \
	&& \
	ansible-lint \
		playbooks/main.yml
