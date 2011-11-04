
all:
	@echo "Run 'make smlnj' or 'make mlton' on OSX/Unix."
	@echo "Run 'make win+smlnj' or 'make win+smlnj+hs' in Windows."
	@echo "Other platforms coming soon."

.PHONY : mlton
mlton: 
	mlton -output bin/cmlex cmlex.mlb

.PHONY : smlnj
smlnj:
	sml < export-smlnj.sml
	bin/mknjexec-unixey `which sml` `pwd`/bin cmlex-heapimg cmlex 

.PHONY : win+smlnj
win+smlnj:
	sml export-smlnj.sml
	bin/mknjexec `which sml` `pwd`/bin cmlex-heapimg.x86-win32 cmlex 

.PHONY : win+smlnj+hs
win+smlnj+hs:
	sml export-smlnj-hs.sml
	bin/mknjexec `which sml` `pwd`/bin cmlex-hs-heapimg.x86-win32 cmlex-hs

install:
	rm -f $(DESTDIR)/bin/cmlex.new
	cp bin/cmlex $(DESTDIR)/bin/cmlex.new
	mv $(DESTDIR)/bin/cmlex.new $(DESTDIR)/bin/cmlex