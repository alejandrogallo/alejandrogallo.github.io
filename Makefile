ORG_FILES = $(shell find . -name '*.org')
HTML_FILES = $(patsubst %.org,%.html,$(ORG_FILES))
TEMPLATE_LNKS \
= $(patsubst %,%/templates,\
       $(shell find . -name '*.org' -not -regex '.*templates.*' |\
               xargs -n1 dirname | xargs -n1 readlink -f | sort -u))
EMACS = emacs
BATCH_EMACS = $(EMACS) -q --batch \
              -l ./site.el index.org
publish: $(TEMPLATE_LNKS)
	$(BATCH_EMACS) --eval '(publish-site)'

$(info $(TEMPLATE_LNKS))

%/templates: _templates
	ln -vfrs ./_templates $@

.PHONY: publish entr

watch:
	qutebrowser index.html
	( \
		python3 -m http.server 8888 &  \
		ls -1 $(ORG_FILES) | entr make \
	)

clean:
	find . -name '*.html~' | xargs -n1 rm -v
