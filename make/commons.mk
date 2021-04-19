# configuration
color_off    = $(shell tput sgr0)
color_bright = $(shell tput bold)

# convenience function to alert user to missing target
define missing_target
	$(error Missing target. Specify with `target=<provider>`)
endef

.SILENT .PHONY: clear
clear:
	@clear

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

# function to print version information when binary (temp variable $(1)) is available
define print_version_if_available
	echo "  * \`$(1)\` version:" $(if $(shell which $(1)),"\`$(shell $(1) $(2))\`", "\`not available\`")
endef

# helper to print version information
.SILENT .PHONY: env-info
env-info: # Prints Version Information
	@echo "* Output of \`make env-info\`:\r\n"

	# TODO: consider adding a `foreach` for this function

	# expected output: `1.7.2`
	$(call print_version_if_available,"packer", "--version")

	# expected output: `Terraform v0.14.10`
	$(call print_version_if_available,"terraform", "--version")

	# expected output: `Vagrant 2.2.15`
	$(call print_version_if_available,"vagrant", "--version")

	# expected output: `Oracle VM [...] 6.1.18r142142`
	$(call print_version_if_available,"VBoxHeadless", "--version")

	# expected output: `aws-cli/2.1.36 [..]`
	$(call print_version_if_available,"aws", "--version")

	# expected output: `{"azure-cli": "2.22.0", [...] }`
	$(call print_version_if_available,"az", "version")

	# expected output: `Google Cloud SDK 321.0.0 [...]`
	$(call print_version_if_available,"gcloud", "--version")

	# expected output: `4.32.0`
	$(call print_version_if_available,"inspec", "--version")
