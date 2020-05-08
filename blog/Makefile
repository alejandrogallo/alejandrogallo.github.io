include ../rules.mk
include rules.mk
include config.mk

all: index.html $(POSTS)
index.html: $(POSTS)
index.html: body.html

print-the-posts:
	@echo $(POSTS)

.PHONY: print-the-posts
