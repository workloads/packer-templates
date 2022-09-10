# expose build target to Packer
arg_var_dist_dir = -var "dist_dir=$(dist_dir)"
arg_var_os       = -var "os=$(os)"
arg_var_target   = -var "target=$(target)"

# enable debug mode for builds
ifdef debug
arg_debug = -debug
else
arg_debug =
endif

# force a build to continue if artifacts exist, deletes existing artifacts.
ifdef force
arg_force = -force
else
arg_force =
endif

# produce machine-readable output.
ifdef machine-readable
arg_machine_readable = -machine-readable
else
arg_machine_readable =
endif

# see https://www.packer.io/docs/commands/init
.PHONY: init
init: # Installs and upgrades Packer Plugins      Usage: `make init target=<provider> os=<os>`
	$(if $(target),,$(call missing_target))
	$(if $(os),,$(call missing_os))
	packer \
		init \
			-upgrade \
			$(arg_debug) \
			$(arg_force) \
			$(arg_machine_readable) \
			$(arg_var_dist_dir) \
			$(arg_var_os) \
      $(arg_var_target) \
			"$(packer_dir)/$(target)"

# see https://www.packer.io/docs/commands/build
.PHONY: build
build: # Builds an Image with Packer               Usage: `make build target=<provider>`
	$(if $(target),,$(call missing_target))
	$(if $(os),,$(call missing_os))
	packer \
		build \
			$(arg_debug) \
			$(arg_force) \
			$(arg_machine_readable) \
			$(arg_var_dist_dir) \
			$(arg_var_os) \
      $(arg_var_target) \
			"$(packer_dir)/$(target)"

# see https://www.packer.io/docs/commands/fmt
# and https://www.packer.io/docs/commands/validate
.PHONY: lint
lint: # Formats and validates Packer Template     Usage: `make lint target=<provider>`
	$(if $(target),,$(call missing_target))
	$(if $(os),,$(call missing_os))
	packer \
		fmt \
			$(arg_debug) \
			$(arg_force) \
			$(arg_machine_readable) \
			$(arg_var_dist_dir) \
			$(arg_var_os) \
      $(arg_var_target) \
      -diff \
      -recursive \
			"$(packer_dir)/$(target)/" \
	&& \
	packer \
		validate \
			$(arg_debug) \
			$(arg_force) \
			$(arg_machine_readable) \
			$(arg_var_dist_dir) \
			$(arg_var_os) \
      $(arg_var_target) \
			"$(packer_dir)/$(target)/"
