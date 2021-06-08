


SUBDIRS:= ../add/ ../sub/ ../input/

all: clean
	@echo "TOPDIR:$(TOPDIR)"
	make -C . -f $(TOPDIR)/make/Makefile.dag

clean:
	-rm -rf $(dir_tmp)

.PHONY: clean all
