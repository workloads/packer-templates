.SILENT .PHONY: clear
clear:
	clear

.SILENT .PHONY: help
help: # display a list of Make Targets                         Usage: `make` or `make help`
	$(info )
	$(info $(shell tput bold)MAINTENANCE$(shell tput sgr0))
	$(info )

	grep \
		--context=0 \
		--devices=skip \
		--extended-regexp \
		--no-filename \
			"(^[a-z-]+):{1} ?(?:[a-z-])* #" $(MAKEFILE_LIST) | \
	\
	awk 'BEGIN {FS = ":.*?# "}; {printf "\033[1m%s\033[0m;%s\n", $$1, $$2}' | \
	\
	column \
		-c2 \
		-s ";" \
		-t

.SILENT .PHONY: selfcheck
selfcheck: # Lints Makefile
	checkmake \
	--config="./assets/scripts/.checkmake.ini" \
	Makefile
