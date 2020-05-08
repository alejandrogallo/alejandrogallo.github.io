%/index.html: %/body.html
	./tools/assemble-body.raku $< > $@

index.html: body.html
	./tools/assemble-body.raku $< > $@
