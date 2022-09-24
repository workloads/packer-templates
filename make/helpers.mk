# convenience function to alert user to missing target
define missing_target
	$(error Missing target. Specify with `target=<target>`)
endef

# convenience function to alert user to missing os
define missing_os
	$(error Missing OS. Specify with `os=<os>`)
endef

.SILENT .PHONY: clean
clean: # Remove "distributables" directory
	rm \
 		-rf \
 		$(dist_dir)/

.PHONY: roles
roles: # Install Ansible Collections and Roles
	ansible-galaxy \
		install \
			--role-file "ansible/requirements.yml" \
			--force

# unsupported helper to open "distributables" directory
.SILENT .PHONY: _dist
_dist:
	open $(dist_dir)

# Lints YAML files
.PHONY: _lint_yaml
_lint_yaml:
	yamllint \
		--config-file ".yaml-lint.yml" \
		.

# Lints Ansible files
.PHONY: _lint_ansible
_lint_ansible:
	ansible-lint \
		--exclude "../../../.ansible" \
		--profile "production" \
		--progressive \
		"ansible/playbooks/main.yml"

.PHONY: _lint
_lint: _lint_yaml _lint_ansible

# unsupported helper to open "VirtualBox.app" (macOS only)
.SILENT .PHONY: _vb
_vb:
	open -a "VirtualBox"
