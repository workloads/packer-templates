# configuration
MAKEFLAGS      = --no-builtin-rules --warn-undefined-variables
SHELL         := sh

.DEFAULT_GOAL := help
.ONESHELL     :
.SHELLFLAGS   := -eu -o pipefail -c

color_off      = $(shell tput sgr0)
color_bright   = $(shell tput bold)

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

.PHONY: azure
azure: # Create Packer Image(s) for Azure
	@packer \
		build \
			-force \
			"./azure"

#.PHONY: azure-init
#azure-init: # Install and upgrade plugins for Packer Template(s) for Azure
#	@packer \
#		init \
#			"./azure"

.PHONY: azure-fmt
azure-lint: # Formats and validates Packer Template(s) for Azure
	@packer \
		fmt \
			-diff \
			"./azure" \
	&& \
	packer \
		validate \
			"./azure"

.PHONY: azure-terraform-apply
azure-terraform-apply: # Create prerequisite resources for Azure with Terraform
	@terraform \
		-chdir="./terraform/azure" \
		apply

.PHONY: azure-terraform-destroy
azure-terraform-destroy: # Destroy prerequisite resources for Azure with Terraform
	@terraform \
		-chdir="./terraform/azure" \
		destroy

.PHONY: azure-terraform-init
azure-terraform-init: # Initializes Terraform for Azure
	@terraform \
		-chdir="./terraform/azure" \
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
