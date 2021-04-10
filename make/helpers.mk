# configuration
ansible_playbooks = ansible/playbooks
generated_dir     = ./generated/vagrant
vagrant_box_name ?= "ubuntu-hashicorp"

# unsupported helper to open "generated" directory
.SILENT .PHONY: _gen
_gen:
	@open $(generated_dir)

# unsupported helper to open "VirtualBox.app"
.SILENT .PHONY: _vb
_vb:
	@open -a "VirtualBox"

# unsupported helper to execute `vagrant up`
.SILENT .PHONY: _up
_up:
	cd $(generated_dir) \
	&& \
	vagrant up

# unsupported helper to execute `vagrant ssh`
.SILENT .PHONY: _ssh
_ssh:
	@cd $(generated_dir) \
	&& \
	vagrant ssh $(vagrant_box_name)

.PHONY: _lint_ansible
_lint_ansible: # Lints Ansible playbook(s)
	@cd $(ansible_playbooks) \
	&& \
	ansible-lint \
		"main.yml"

.PHONY: _lint_yaml
_lint_yaml: # Lints YAML files
	@yamllint \
		--config-file ".yamllint" \
		"."

.PHONY: _lint
_lint: _lint_yaml _lint_ansible
