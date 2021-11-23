SUBDIRS := $(wildcard src/*/.)

.PHONY: update-makefiles clean all run $(SUBDIRS)

all: $(SUBDIRS) | update-makefiles

clean:
	@for i in $(SUBDIRS); do cd $$i && $(MAKE) clean && cd ../..; done

#update-makefiles:
#	@for i in $(SUBDIRS); do cp makefile.template $$i/makefile; done

run: all
	@for d in $(SUBDIRS); do echo "== Running $$d ==" && $$d/build/program; done

$(SUBDIRS):
	cd $@ && $(MAKE)
