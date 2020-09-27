ORG_FILES = $(wildcard *.org **/*.org)
HTML_FILES = $(patsubst %.org,%.html,$(ORG_FILES))
EMACS = emacs
BATCH_EMACS = $(EMACS) -q --batch \
              -l ./blog.el index.org

html: $(HTML_FILES)
.PHONY: publish

publish:
	$(BATCH_EMACS) --eval '(publish-blog)'


