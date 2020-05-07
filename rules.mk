%.html: %.md
	pandoc -f markdown -t html5 $< -o $@

%.html: %.raku
	raku $< > $@

%.html: %/Makefile
	$(MAKE) -C $<

%/index.html: %/Makefile
	$(MAKE) -C $*
