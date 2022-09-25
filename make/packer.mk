# expose build target to Packer
arg_var_dist_dir = -var 'dist_dir=$(dist_dir)'
arg_var_os       = -var 'os=$(os)'
arg_var_target   = -var 'target=$(target)'

# enable debug mode for builds
ifdef debug
arg_debug = -debug
else
arg_debug =
endif

# enable dev mode and configure corresponding packages
ifdef dev
arg_var_developer_mode = -var 'developer_mode=true'
else
arg_var_developer_mode = -var 'developer_mode=false'
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

# enable prepending of timestamp for build steps
ifdef timestamp
arg_timestamp = -timestamp-ui
else
arg_timestamp =
endif

# enable Vagrant Cloud functionality
ifdef vagrant-cloud
arg_vagrant_cloud =
else
arg_vagrant_cloud = vagrant-cloud
endif

arg_except = -except="$(arg_vagrant_cloud)"

# see https://www.packer.io/docs/commands/init
.PHONY: init
init: # Installs and upgrades Packer Plugins      Usage: `make init target=<target> os=<os> os=<os>`
	$(if $(target),,$(call missing_target))
	$(if $(os),,$(call missing_os))
	packer \
		init \
			-upgrade \
			$(arg_machine_readable) \
			"$(packer_dir)/$(target)"

# see https://www.packer.io/docs/commands/build
.PHONY: build
build: # Builds an Image with Packer               Usage: `make build target=<target> os=<os>`
	$(if $(target),,$(call missing_target))
	$(if $(os),,$(call missing_os))
	packer \
		build \
			$(arg_debug) \
			$(arg_except) \
			$(arg_force) \
			$(arg_machine_readable) \
			$(arg_timestamp) \
			$(arg_var_developer_mode) \
			$(arg_var_dist_dir) \
			$(arg_var_os) \
      $(arg_var_target) \
			"$(packer_dir)/$(target)"

# see https://www.packer.io/docs/commands/fmt
# and https://www.packer.io/docs/commands/validate
.PHONY: lint
lint: # Formats and validates Packer Template     Usage: `make lint target=<target> os=<os>`
	$(if $(target),,$(call missing_target))
	$(if $(os),,$(call missing_os))
	packer \
		fmt \
			$(arg_machine_readable) \
      -diff \
      -recursive \
			"$(packer_dir)/$(target)/" \
	&& \
	packer \
		validate \
			$(arg_machine_readable) \
			$(arg_var_developer_mode) \
			$(arg_var_dist_dir) \
			$(arg_var_os) \
      $(arg_var_target) \
			"$(packer_dir)/$(target)/"
