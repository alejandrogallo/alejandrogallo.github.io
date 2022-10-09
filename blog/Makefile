THEMES = themes/PaperMod

all: $(THEMES)
	hugo

themes/PaperMod:
	git clone https://github.com/adityatelange/hugo-PaperMod/ $@
	cd $@ && git checkout 3a0a4811cbc07c0bea09ef55b3c1bfb39b48cddd

serve:
	hugo server --buildDrafts --navigateToChanged --disable-Fast

.PHONY: serve
