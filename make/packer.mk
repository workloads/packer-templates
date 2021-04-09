# configuration for Packer-specific variables

# Debug mode enabled for builds.
debug ?=

ifdef debug
packer_debug = -debug
else
packer_debug =
endif

# Toggle to enable the Vagrant Cloud post-processor
ifdef enable-vagrant-cloud

# Verify that the current target is Vagrant
ifneq ($(target),vagrant)
$(error Vagrant Cloud post-processing support can only be enabled for Vagrant builds)
endif

except_vagrant_cloud =
else
except_vagrant_cloud = post-processor.vagrant-cloud
endif

# Run all builds and post-processors other than these.
except ?=

ifdef except
packer_except = -except="$(except), $(except_vagrant_cloud)"
else
packer_except = -except="$(except_vagrant_cloud)"
endif

# Force a build to continue if artifacts exist, deletes existing artifacts.
ifdef force
packer_force = -force
else
packer_force =
endif

# Ignore the shared variables file
ifndef ignore-shared-vars
packer_shared_var_file = -var-file="./packer/_shared/shared.pkrvars.hcl"
else
packer_shared_var_file =
endif

# Produce machine-readable output.
ifdef machine-readable
packer_machine_readable = -machine-readable
else
packer_machine_readable =
endif

# Build only the specified builds.
only ?=

ifdef only
packer_only = -only=$(only)
else
packer_only =
endif

# If the build fails do: clean up (default), abort, ask, or run-cleanup-provisioner.
ifdef on-error
packer_on_error = -on-error=$(on-error)
else
packer_on_error = -on-error=cleanup
endif

# Number of builds to run in parallel. 1 disables parallelization. 0 means no limit
ifdef parallel-builds
packer_parallel_builds = -parallel-builds=$(parallel-builds)
else
packer_parallel_builds = -parallel-builds=0
endif

# Enable prefixing of each ui output with an RFC3339 timestamp.
ifdef timestamp-ui
packer_timestamp_ui = -timestamp-ui
else
packer_timestamp_ui =
endif

ifdef var-file
packer_var_file = -var-file=$(var-file)
else
packer_var_file =
endif

# see https://www.packer.io/docs/commands/build
.PHONY: build
build: # Build a Packer Image(s) for a target
	@: $(if $(target),,$(call missing_target))
	@packer \
		build \
			$(packer_debug) \
			$(packer_except) \
			$(packer_only) \
			$(packer_force) \
			$(packer_machine_readable) \
			$(packer_on_error) \
			$(packer_parallel_builds) \
			$(packer_timestamp_ui) \
			$(packer_shared_var_file) \
			$(packer_var_file) \
			"./packer/$(target)"

# see https://www.packer.io/docs/commands/init
.PHONY: init
init: # Install and upgrade plugins for Packer Template(s) for a target
	@: $(if $(target),,$(call missing_target))
	@packer \
		init \
			-upgrade \
			"./packer/$(target)"

# see https://www.packer.io/docs/commands/fmt
# and https://www.packer.io/docs/commands/validate
.PHONY: lint
lint: # Formats and validates Packer Template(s) for a target
	@: $(if $(target),,$(call missing_target))
	@packer \
		fmt \
			-recursive \
			"./packer/_shared/" \
	&& \
	packer \
		fmt \
			-recursive \
			"./packer/$(target)" \
	&& \
	packer \
		validate \
			$(packer_except) \
			$(packer_only) \
			$(packer_shared_var_file) \
			$(packer_var_file) \
			"./packer/$(target)"
