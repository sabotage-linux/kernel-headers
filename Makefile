# Use config.mak to override any of the following variables.
# Or pass them to make, i.e.  "make prefix=/usr install"
# Do not make changes here.

prefix = /usr/local
includedir = $(prefix)/include

LEVELS = * */* */*/* */*/*/* */*/*/*/*
ALL_INCLUDES = $(sort $(wildcard $(LEVELS:%=$(ARCH)/include/%.h)))
INSTALL_HDR_PATH = $(DESTDIR)$(prefix)
INSTALL_CMD=tools/install.sh

-include config.mak

ARCH ?= $(error ARCH must be set)

all:
defconfig:
mmu_config:
g5_defconfig:

headers_install: install

install: $(ALL_INCLUDES:$(ARCH)/include/%=$(INSTALL_HDR_PATH)/include/%)

$(INSTALL_HDR_PATH)/include/%: $(ARCH)/include/%
	$(INSTALL_CMD) -D -m 644 $< $@

.PHONY: install headers_install all defconfig mmu_config g5_defconfig
