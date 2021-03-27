color_off      = $(shell tput sgr0)
color_bright   = $(shell tput bold)

debug            ?=
packer_except    ?= -except=$(except)

ifdef except
packer_except = -except=$(except)
endif

only             ?=
force            ?=
machine-readable ?=
on-error         ?=
parallel-builds  ?=
timestamp-ui     ?=
