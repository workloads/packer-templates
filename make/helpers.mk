# configuration
ansible_playbooks  = ./ansible/playbooks
envconsul_config   = ./envconsul.hcl
envconsul_loglevel = trace
generated_dir      = ./generated/vagrant
vagrant_box_name   ?= "ubuntu-hashicorp"

ifdef enable-envconsul
envconsul_toggle = envconsul -log-level $(envconsul_loglevel) -config="$(envconsul_config)"
else
envconsul_toggle =
endif

# unsupported helper to remove "generated" directory
.SILENT .PHONY: _clean
_clean:
	rm \
 		-rf \
 		$(generated_dir)

# unsupported helper to open "generated" directory
.SILENT .PHONY: _gen
_gen:
	open $(generated_dir)

.PHONY: ansible-init
ansible-init: # Fetch and Install Ansible Galaxy Collections and Roles
	ansible-galaxy \
		install \
			--role-file="ansible/requirements.yml" \
			--force

# Lints Ansible playbook(s)
.PHONY: ansible-lint
ansible-lint:
	$(if $(target),,$(call missing_target))
# run minimal Packer build to generate Ansible configuration files
	packer \
		build \
			$(packer_debug) \
			-only "*.file.image_configuration" \
			-force \
			$(packer_machine_readable) \
			$(packer_timestamp_ui) \
			$(packer_var_target) \
			$(packer_shared_var_file) \
			$(packer_var_file) \
			"./packer/$(target)" \
	&& \
	cd $(ansible_playbooks) \
	&& \
	ansible-lint \
		-f "rich" \
		--progressive \
		-v \
		"main.yml"

# Lints YAML files
.PHONY: yaml-lint
yaml-lint:
	yamllint \
		--config-file ".yamllint" \
		"."

.PHONY: _lint
_lint: yaml-lint ansible-lint

# unsupported helper to execute `vagrant ssh`
.SILENT .PHONY: _ssh
_ssh:
	cd $(generated_dir) \
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
	open -a "VirtualBox"
