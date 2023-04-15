ORG_FILES = $(shell find . -name '*.org')
HTML_FILES = $(patsubst %.org,%.html,$(ORG_FILES))
TEMPLATE_LNKS \
= $(patsubst %,%/templates,\
       $(shell find . -name '*.org' -not -regex '.*templates.*' |\
               xargs -n1 dirname | xargs -n1 readlink -f | sort -u))
EMACS = emacs
BATCH_EMACS = $(EMACS) -q --batch \
              -l ./site.el index.org
publish: deps $(TEMPLATE_LNKS)
	$(BATCH_EMACS) --eval '(publish-site)'

$(info $(TEMPLATE_LNKS))

%/templates: _templates
	ln -vfrs ./_templates $@

.PHONY: publish entr dev watch serve deps blog

dev: watch serve

./env/bin/livereload:
	virtualenv env
	./env/bin/pip install livereload

watch:
	@ls -1 $(ORG_FILES) | entr make publish

serve: ./env/bin/livereload
	#@python3 -m http.server 8888
	@$< -p 8888 .

clean:
	find . -name '*.html~' | xargs -n1 rm -v
	find . -name '*.html' | xargs -n1 rm -v

DEPS = lisp/external/htmlize
deps: $(DEPS)

lisp/external/htmlize:
	mkdir -p ${@D}
	git clone https://github.com/hniksic/emacs-htmlize $@

publications.bib:
	papis bibtex add --all --query gallo:true save publications.bib

publications.org: publication.template
	papis list \
		--sort year \
		--reverse \
		--template publication.template \
		--all gallo:true > $@
	sed -i "s/Gallo, Alejandro/*Gallo, Alejandro*/" publications.org
	sed -i "s/Alejandro Gallo/*Alejandro Gallo*/" publications.org


blog:
	$(MAKE) -C blog
