.PHONY: build
build: # Build a Packer Image(s) for a target
	@: $(if $(target),,$(call missing_target))
	@echo packer \
		build \
			$(debug) \
			-except="$(except)" \
			-only="$(only)" \
			$(force) \
			$(machine-readable) \
			$(on-error) \
			$(parallel-builds) \
			$(timestamp-ui) \
			"./$(target)"

.PHONY: init
init: # Install and upgrade plugins for Packer Template(s) for a target
	@: $(if $(target),,$(call missing_target))
	@packer \
		init \
			-upgrade \
			"./$(target)"

.PHONY: lint
lint: # Formats and validates Packer Template(s) for a target
	@: $(if $(target),,$(call missing_target))
	@packer \
		fmt \
			-diff \
			"./$(target)" \
	&& \
	packer \
		validate \
			"./$(target)"
