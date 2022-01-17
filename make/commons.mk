# configuration
color_off    = $(shell tput sgr0)
color_bright = $(shell tput bold)

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

# convenience function to print version information when binary (temp variable $(1)) is available
define print_version_if_available
	echo "  * \`$(1)\` version:" $(if $(shell which $(1)),"\`$(shell $(1) $(2))\`", "not available")
endef

# convenience function to pretty-print version information when `az` binary is available
define print_az_version_if_available
	# expected output: `2.22.0`
	echo "  * \`az\` version: \`"$(if $(shell which az),$(shell az version --output=json --query="[\"azure-cli\"][0]")"\`", "not available")
endef

# convenience function to pretty-print version information when `ansible` binary is available
define print_ansible_version_if_available
	# expected output: `ansible 2.10.7`
	echo "  * \`ansible\` version: \`"$(if $(shell which ansible),$(shell ansible --version | head -n 1)"\`", "not available")
endef

# convenience function to pretty-print version information when `envconsul` binary is available
define print_envconsul_version_if_available
	# expected output: `envconsul v0.12.1 (265f933)`
	echo "  * \`envconsul\` version: \`"$(if $(shell which envconsul),$(shell envconsul -once --version)"\`", "not available")
endef

# convenience function to pretty-print version information when `gcloud` binary is available
define print_gcloud_version_if_available
	# expected output: `321.0.0`
	echo "  * \`gcloud\` version: \`"$(if $(shell which gcloud),$(shell gcloud version --format="value(\"Google Cloud SDK\")")"\`", "not available")
endef

# helper to print version information
.SILENT .PHONY: env-info
env-info: # Prints Version Information
	echo "* Output of \`make env-info\`:"

	# expected output: `1.7.8`
	$(call print_version_if_available,"packer", "--version")

	# expected output: `Terraform v1.1.1`
	$(call print_version_if_available,"terraform", "--version")

	$(call print_envconsul_version_if_available)

	$(call print_ansible_version_if_available)

	# expected output: `Vagrant 2.2.19`
	$(call print_version_if_available,"vagrant", "--version")

	# expected output: `6.1.30r142142`
	$(call print_version_if_available,"vboxmanage", "--version")

	# expected output: `aws-cli/2.4.10 [..]`
	$(call print_version_if_available,"aws", "--version")

	# expected output: `4.52.9`
	$(call print_version_if_available,"inspec", "version")

	# expected output: `2.30.3`
	$(call print_version_if_available,"direnv", "--version")

	$(call print_az_version_if_available)

	$(call print_gcloud_version_if_available)
