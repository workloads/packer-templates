# configuration
MAKEFLAGS      = --no-builtin-rules --warn-undefined-variables
SHELL         := sh

.DEFAULT_GOAL := help
.ONESHELL     :
.SHELLFLAGS   := -eu -o pipefail -c

# NOTE: specify files in the order they should be loaded
# NOTE: this allows for a more logical `help` experience
include make/commons.mk
include make/packer.mk
include make/terraform.mk
include make/ansible.mk
