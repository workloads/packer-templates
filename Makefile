# Makefile for Packer Image Building Management

# configuration
ARGS                  :=
ANSIBLE_INVENTORY     ?= $(DIR_DIST)/inventory.txt
ANSIBLE_PLAYBOOK      ?= $(DIR_ANSIBLE)/playbooks/main.yml
ANSIBLE_REQUIREMENTS  ?= $(DIR_ANSIBLE)/requirements.yml
ANSIBLELINT_CONFIG    ?= .ansible-lint.yml
ANSIBLELINT_FORMAT    ?= full
ANSIBLELINT_SARIF_FILE = $(DIR_DIST)/ansible-lint.sarif
BINARY_ANSIBLE        ?= ansible-playbook
BINARY_ANSIBLE_GALAXY ?= ansible-galaxy
BINARY_ANSIBLE_LINT   ?= ansible-lint
BINARY_DOCKER 				?= docker
BINARY_PACKER     		?= packer
BINARY_VAGRANT        ?= vagrant
BINARY_YAMLLINT       ?= yamllint
CLOUDINIT_DIRECTORY   ?= $(shell dirname ${path})
CLOUDINIT_FILE        ?= $(shell basename ${path})
CLOUDINIT_LINT_IMAGE  ?= "ghcr.io/workloads/alpine-with-cloudinit:latest" # full content address is supported but not required
DIR_ANSIBLE						?= ansible
DIR_DIST							?= dist
DIR_PACKER            ?= packer
DOCS_CONFIG            = .packer-docs.yml
YAMLLINT_CONFIG       ?= .yaml-lint.yml
YAMLLINT_FORMAT				?= colored
TITLE                  = 🔵 PACKER TEMPLATES

# conditionally load Target-specific configuration if present
ifneq ($(wildcard $(DIR_PACKER)/$(strip $(target))/extras.mk),)
	include $(DIR_PACKER)/$(strip $(target))/extras.mk
endif

# expose relevant information to Packer
arg_var_ansible_command       = -var 'ansible_command=$(BINARY_ANSIBLE)'
arg_var_ansible_galaxy_file   = -var 'ansible_galaxy_file=$(ANSIBLE_REQUIREMENTS)'
arg_var_ansible_playbook_file = -var 'ansible_playbook_file=$(ANSIBLE_PLAYBOOK)'
arg_var_dist_dir              = -var 'dist_dir=$(DIR_DIST)'
arg_var_os                    = -var 'os=$(os)'
arg_var_target                = -var 'target=$(target)'

# enable dev mode and configure corresponding packages
ifdef dev
arg_var_developer_mode = -var 'developer_mode=true'
else
arg_var_developer_mode = -var 'developer_mode=false'
endif

# see https://developer.hashicorp.com/packer/docs/templates/hcl_templates/onlyexcept#except-foo-bar-baz
extra_except_args =
args_only         =
args_except       =

# if `target` is not null, pass `builder` to Packer
ifneq ($(target),null)
	args_only = -only="1-provisioners.$(builder).main"
endif

ifneq ($(extra_except_args),)
	args_except = -except="$(extra_except_args)"
endif

# convenience handle for ALL CLI arguments
cli_args = $(args_only) $(args_except) $(arg_var_ansible_command) $(arg_var_ansible_galaxy_file) $(arg_var_ansible_playbook_file) $(arg_var_dist_dir) $(arg_var_os) $(arg_var_target)

include ../tooling/make/configs/shared.mk

include ../tooling/make/functions/shared.mk

include ../tooling/make/targets/shared.mk

.SILENT .PHONY: init
init: # initialize a Packer Image [Usage: `make init target=my_target os=my_os`]
	$(if $(target),,$(call missing_argument,init,target=my_target))
	$(if $(os),,$(call missing_argument,init,os=my_os))

	$(call print_args,$(ARGS))

	# see https://developer.hashicorp.com/packer/docs/commands/init
	$(BINARY_PACKER) \
		init \
			-upgrade \
			$(ARGS) \
			"$(DIR_PACKER)/$(target)"

.SILENT .PHONY: lint
lint: # lint a Packer Image [Usage: `make lint target=my_target os=my_os`]
	$(if $(target),,$(call missing_argument,lint,target=my_target))
	$(if $(os),,$(call missing_argument,lint,os=my_os))

	$(call print_args,$(ARGS))

	# see https://developer.hashicorp.com/packer/docs/commands/fmt
  # and https://developer.hashicorp.com/packer/docs/commands/validate
	$(BINARY_PACKER) \
		fmt \
			-diff \
			-recursive \
			"$(DIR_PACKER)/$(target)" \
	&& \
	$(BINARY_PACKER) \
		validate \
			$(cli_args) \
			$(ARGS) \
			"$(DIR_PACKER)/$(target)" \
	;

.SILENT .PHONY: build
build: # build a Packer Image [Usage: `make build target=my_target builder=my_builder os=my_os`]
	$(if $(target),,$(call missing_argument,build,target=my_target))
	$(if $(builder),,$(call missing_argument,builder,builder=my_builder))
	$(if $(os),,$(call missing_argument,build,os=my_os))

	$(call print_args,$(ARGS))

	# see https://developer.hashicorp.com/packer/docs/commands/build
	$(BINARY_PACKER) \
		build \
			$(cli_args) \
			$(ARGS) \
			"$(DIR_PACKER)/$(target)"

.SILENT .PHONY: docs
docs: # generate documentation for all Packer Images [Usage: `make docs target=my_target`]
	$(if $(target),,$(call missing_argument,docs,target=my_target))

	# TODO: align with overall `render_documentation` function
	$(call render_documentation,$(DIR_PACKER)/$(strip $(target)),shared.pkr.hcl,$(DOCS_CONFIG),sample.pkrvars.hcl)

.SILENT .PHONY: console
console: # start Packer Console [Usage: `make console target=my_target os=my_os`]
	$(if $(target),,$(call missing_argument,console,target=my_target))
	$(if $(os),,$(call missing_argument,console,os=my_os))

	$(call print_args,$(ARGS))

	# see https://developer.hashicorp.com/packer/docs/commands/console
	$(BINARY_PACKER) \
		console \
			$(cli_args) \
			$(ARGS) \
			"$(DIR_PACKER)/$(target)"

.SILENT .PHONY: ansible_init
ansible_init: # initialize Ansible Collections and Roles [Usage: `make ansible_init`]
	$(call print_reference,$(ANSIBLE_REQUIREMENTS))

	echo

	# see https://docs.ansible.com/ansible/latest/cli/ansible-galaxy.html
	$(BINARY_ANSIBLE_GALAXY) \
		install \
			--role-file "$(ANSIBLE_REQUIREMENTS)" \
			--force

	echo

.SILENT .PHONY: ansible_inventory
ansible_inventory: # construct an Ansible Inventory [Usage: `make ansible_inventory host=my_host user=my_user`]
	$(if $(host),,$(call missing_argument,console,host=my_host))
	$(if $(user),,$(call missing_argument,console,user=my_user))

	echo "\
[all:vars] \n \
\t ansible_user=$(user) \n \
\t ansible_port=22 \n \
\t ansible_ssh_pass=$(user) \n \
\n \
[default] \n \
\t $(host)" \
> $(ANSIBLE_INVENTORY)

.SILENT .PHONY: ansible_lint
ansible_lint: # lint Ansible Playbooks [Usage: `make ansible_lint`]
	# create directory for `ansible-lint` SARIF output
	$(call safely_create_directory,$(DIR_DIST))

	# lint Ansible files and output SARIF results
	$(BINARY_ANSIBLE_LINT) \
		--config "$(ANSIBLELINT_CONFIG)" \
		--format "$(ANSIBLELINT_FORMAT)" \
    --sarif-file="$(ANSIBLELINT_SARIF_FILE)" \
		--write="all" \
		"$(ANSIBLE_PLAYBOOK)"

.SILENT .PHONY: ansible_local
ansible_local: # run Ansible directly, outside of Packer [Usage: `make ansible_local`]
	export ANSIBLE_CONFIG="$(DIR_ANSIBLE)/ansible.cfg" \
	&& \
	$(BINARY_ANSIBLE) \
		--ask-pass \
		--ask-become-pass \
		--connection="smart" \
		--extra-vars "ConfigFile=$(DIR_DIST)/configuration.yml InfoFile=$(DIR_DIST)/README.md" \
		--inventory-file "$(ANSIBLE_INVENTORY)" \
		$(ANSIBLE_PLAYBOOK)

.SILENT .PHONY: cloudinit_lint
cloudinit_lint: # lint cloud-init user data files using Alpine (via Docker) [Usage: `make cloudinit_lint path=./packer/templates/user-data.yml`]
	$(if $(path),,$(call missing_argument,path,path=./packer/templates/user-data.yml))

	$(call print_arg,path,$(path))

	# run an interactive Docker container that self-removes on completion
	$(BINARY_DOCKER) \
		run \
			--interactive \
			--quiet \
			--rm \
			--tty \
			--volume "$(CLOUDINIT_DIRECTORY):/config/" \
			$(CLOUDINIT_LINT_IMAGE)

.SILENT .PHONY: yaml_lint
yaml_lint: # lint YAML files
	$(BINARY_YAMLLINT) \
		--config-file "$(YAMLLINT_CONFIG)" \
		--format "$(YAMLLINT_FORMAT)" \
		--strict \
		.

.SILENT .PHONY: _clean
_clean: # remove generated files [Usage: `make clean`]
	$(call delete_target_path,$(DIR_DIST))

.SILENT .PHONY: _dist
_dist: # quickly open the generated files directory (macOS only) [Usage: `make _dist`]
	open $(DIR_DIST)

.SILENT .PHONY: _pd
_pd: # quickly open Parallels Desktop (macOS only) [Usage: `make _pd`]
	open \
		-a "Parallels Desktop"

.SILENT .PHONY: _vb
_vb: # quickly open VirtualBox (macOS only) [Usage: `make _vb`]
	open \
		-a "VirtualBox"

.SILENT .PHONY: _kill_vb
_kill_vb: # force-kill all VirtualBox processes (macOS only) [Usage: `make _kill_vb`]
	# `9`  = signal number
	# `-f` = match against the full argument list instead of just process names
	pkill \
		-9 \
		-f "VBox"

.SILENT .PHONY: _link_vars
_link_vars: # create a symlink to the shared variables file for a new target [Usage: `make _link_vars target=my_target`]
	$(if $(target),,$(call missing_argument,build,target=my_target))

	$(call safely_create_directory,$(DIR_PACKER)/$(target))

	# remove and unlink existing file (`-F` and `-f`),
	# write to stderr if the target exists (`-i`),
	# attempt to create a soft symbolic link (`-P` and `-s`)
	#	verbosely describe the operations (`-v` and `-w`)
	ln \
		-F \
		-f \
		-P \
		-i \
		-s \
		-v \
			../shared.pkr.hcl \
			$(DIR_PACKER)/$(target)/shared.pkr.hcl
