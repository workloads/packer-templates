# Makefile for Packer Image Building Management

# configuration
ARGS                  :=
BINARY_ANSIBLE        ?= ansible
BINARY_ANSIBLE_GALAXY ?= ansible-galaxy
BINARY_ANSIBLE_LINT   ?= ansible-lint
BINARY_PACKER     		?= packer
DOCS_CONFIG            = .packer-docs.yml
PACKS                  = $(shell ls $(TEMPLATES_DIR))
YAMLLINT_CONFIG       ?= .yaml-lint.yml
YAMLLINT_FORMAT				?= colored
TITLE                  = 🔵 PACKER TEMPLATES

include ../tooling/make/configs/shared.mk

include ../tooling/make/functions/shared.mk

# build a Packer Image
define build_image
	echo $(BINARY_PACKER) build target=$(target) os=$(os)
endef

# initialize a Packer Image
define init_image
	echo $(BINARY_PACKER) init target=$(target) os=$(os)
endef

# lint a Packer Image
define lint_image
	echo $(BINARY_PACKER) lint target=$(target) os=$(os)
endef

# test a Packer Image
define test_image
	echo $(BINARY_PACKER) test target=$(target) os=$(os)
endef

include ../tooling/make/targets/shared.mk

.SILENT .PHONY: init
init: # initialize a Packer Image [Usage: `make init target=my_target os=my_os`]
	$(if $(target),,$(call missing_argument,init,target=my_target))
	$(if $(os),,$(call missing_argument,init,os=my_os))

	$(call init_image,$(target),$(os))

.SILENT .PHONY: lint
lint: # lint a Packer Image [Usage: `make lint target=my_target os=my_os`]
	$(if $(target),,$(call missing_argument,lint,target=my_target))
	$(if $(os),,$(call missing_argument,lint,os=my_os))

	$(call lint_image,$(target),$(os))

.SILENT .PHONY: build
build: # build a Packer Image [Usage: `make build target=my_target os=my_os`]
	$(if $(target),,$(call missing_argument,build,target=my_target))
	$(if $(os),,$(call missing_argument,build,os=my_os))

	$(call build_image,$(target),$(os))

.SILENT .PHONY: docs
docs: # generate documentation for all Packer Images [Usage: `make docs target=my_target os=my_os`]
	$(if $(target),,$(call missing_argument,docs,target=my_target))

	# TODO: align with overall `render_documentation` function
	$(call render_documentation,$(DIR_PACKER)/$(strip $(target)),shared.pkr.hcl,$(DOCS_CONFIG),sample.pkrvars.hcl)

.SILENT .PHONY: test
test: # test a Packer Image [Usage: `make test target=my_target os=my_os`]
	$(if $(target),,$(call missing_argument,test,target=my_target))
	$(if $(os),,$(call missing_argument,test,os=my_os))

	$(call test_image,$(target),$(os))

.SILENT .PHONY: console
console: # start Packer Console [Usage: `make console target=my_target os=my_os`]
	$(if $(target),,$(call missing_argument,console,target=my_target))
	$(if $(os),,$(call missing_argument,console,os=my_os))

	$(call console,$(target),$(os))

.SILENT .PHONY: ansible_init
ansible_init: # initialize Ansible Collections and Roles [Usage: `make ansible_init`]
	$(call ansible_init)

.SILENT .PHONY: ansible_lint
ansible_lint:# lint Ansible files [Usage: `make ansible_lint`]
	$(call ansible_lint)

.SILENT .PHONY: yaml_lint
yaml_lint: # lint YAML files
	$(call yaml_lint)

.SILENT .PHONY: clean
clean: # remove generated files [Usage: `make clean`]
	$(call delete_target_path,$(DIR_DIST))

.SILENT .PHONY: _dist
_dist: # unsupported helper to quickly open generated files directory (macOS only)
	open $(DIR_DIST)

.SILENT .PHONY: _vb
_vb: # unsupported helper to quickly open `VirtualBox.app` (macOS only)
	open \
		-a "VirtualBox"

.SILENT .PHONY: _kill_vb
_kill_vb: # unsupported helper to force-kill a (stuck) VirtualBox processes
	# `9`  = signal number
	# `-f` = match against the full argument list instead of just process names
	pkill \
		-9 \
		-f "VBox"
