# configuration
ansible_playbooks = ./ansible/playbooks
generated_dir     = ./generated/vagrant
vagrant_box_name ?= "ubuntu-hashicorp"

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

	# unsupported helper to remove "generated" directory
.SILENT .PHONY: _clean
_clean:
	@rm \
 		-rf \
 		$(generated_dir)

	# unsupported helper to open "generated" directory
.SILENT .PHONY: _gen
_gen:
	@open $(generated_dir)

# Lints Ansible playbook(s)
.PHONY: _lint_ansible
_lint_ansible:
	@cd $(ansible_playbooks) \
	&& \
	ansible-lint \
		"main.yml"

 # Lints YAML files
.PHONY: _lint_yaml
_lint_yaml:
	@yamllint \
		--config-file ".yamllint" \
		"."

.PHONY: _lint
_lint: _lint_yaml _lint_ansible

# unsupported helper to execute `vagrant ssh`
.SILENT .PHONY: _ssh
_ssh:
	@cd $(generated_dir) \
	&& \
	vagrant ssh $(vagrant_box_name)

# unsupported helper to execute `vagrant up`
.SILENT .PHONY: _up
_up:
	cd $(generated_dir) \
	&& \
	vagrant up

# unsupported helper to open "VirtualBox.app" (macOS only)
.SILENT .PHONY: _vb
_vb:
	@open -a "VirtualBox"
