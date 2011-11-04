
all:
	@echo "Run 'make win+smlnj' or 'make win+smlnj+hs'".
	@echo Other platforms coming soon.

.PHONY : mlton
mlton: 
	mlton -output bin/cmlex cmlex.mlb

.PHONY : smlnj
smlnj:
	sml < export-smlnj.sml
	bin/mknjexec-unixey `which sml` `pwd` cmlex cmlex

.PHONY : win+smlnj
win+smlnj:
	sml export-smlnj.sml
	bin/mknjexec `which sml` `pwd`/bin cmlex.x86-win32 cmlex

.PHONY : win+smlnj+hs
win+smlnj+hs:
	sml export-smlnj-hs.sml
	bin/mknjexec `which sml` `pwd`/bin cmlex-hs.x86-win32 cmlex-hs

install:
	rm -f $(DESTDIR)/bin/cmlex.new
	cp bin/cmlex $(DESTDIR)/bin/cmlex.new
	mv $(DESTDIR)/bin/cmlex.new $(DESTDIR)/bin/cmlex