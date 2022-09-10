.SILENT .PHONY: clear
clear:
	clear

.SILENT .PHONY: help
help: # Displays this help text
	$(info )
	$(info $(color_bright)PACKER TEMPLATES$(color_off))
	grep \
		--context=0 \
		--devices=skip \
		--extended-regexp \
		--no-filename \
			"(^[a-z-]+):{1} ?(?:[a-z-])* #" $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?# "}; {printf "\033[1m%s\033[0m;%s\n", $$1, $$2}' | \
	column \
		-c2 \
		-s ";" \
		-t
	$(info )
