# Use config.mak to override any of the following variables.
# Or pass them to make, i.e.  "make prefix=/usr install"
# Do not make changes here.

prefix = /usr/local
includedir = $(prefix)/include

LEVELS = * */* */*/* */*/*/* */*/*/*/*
ALL_INCLUDES = $(sort $(wildcard $(LEVELS:%=$(ARCH)/include/%.h)))

-include config.mak

ARCH ?= $(error ARCH must be set)

install: $(ALL_INCLUDES:$(ARCH)/include/%=$(DESTDIR)$(includedir)/%)

$(DESTDIR)$(includedir)/%: $(ARCH)/include/%
	install -D -m 644 $< $@

.PHONY: install
