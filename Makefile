# configuration
MAKEFLAGS      = --no-builtin-rules --silent --warn-undefined-variables
SHELL         := sh

.DEFAULT_GOAL := help
.ONESHELL     :
.SHELLFLAGS   := -eu -o pipefail -c

# NOTE: specify files in the order they should be loaded
# NOTE: this allows for a more logical `help` experience

# common Targets
include make/commons.mk

# Targets for Packer interactions
include make/packer.mk

# Targets for Terraform interactions
include make/terraform.mk
include make/helpers.mk
