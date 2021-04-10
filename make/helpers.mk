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

.PHONY: ansible-lint
ansible-lint: # Lints Ansible playbook(s)
	@cd $(ansible_playbooks) \
	&& \
	ansible-lint \
		"main.yml"

.PHONY: yamllint
yamllint: # Lints YAML files
	@yamllint \
		--config-file ".yamllint" \
		"."

.PHONY: lint
lint: yamllint ansible-lint
