# configuration
MAKEFLAGS      = --no-builtin-rules --silent --warn-undefined-variables
SHELL         := sh

.DEFAULT_GOAL := help
.ONESHELL     :
.SHELLFLAGS   := -eu -c

# Specify files in the order they should be loaded
# This allows for a more logical `help` experience

# common Targets
include make/commons.mk

# Targets for Packer interactions
include make/packer.mk

# Targets for Terraform interactions
include make/terraform.mk

# (unsupported) helpers and convenience functions
include make/helpers.mk
