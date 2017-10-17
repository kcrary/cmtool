
all:
	@echo "CM-Yacc for Standard ML (cmyacc):"
	@echo "Run 'make smlnj' or 'make mlton' on Linux/Unix/OSX."
	@echo "Run 'make win+smlnj' in Windows."
	@echo "In Smackage, then run 'make install' to install."
	@echo ""
	@echo "CM-Yacc for Haskell (cmyacc-hs):"
	@echo "Run 'make smlnj+hs' or 'make mlton+hs' on Linux/Unix/OSX."
	@echo "Run 'make win+smlnj+hs' in Windows."
	@echo "In Smackage, then run 'make install+hs' to install."

# MLton
.PHONY : mlton
mlton: 
	mlton -output bin/cmyacc cmyacc.mlb

.PHONY : mlton+hs
mlton+hs: 
	mlton -output bin/cmyacc-hs cmyacc-hs.mlb

# SML/NJ
.PHONY : smlnj
smlnj:
	sml export-smlnj.sml
	bin/mknjexec-unixey `which sml` `pwd`/bin cmyacc-heapimg cmyacc 

.PHONY : smlnj+hs
smlnj+hs:
	sml export-smlnj-hs.sml
	bin/mknjexec-unixey `which sml` `pwd`/bin cmyacc-hs-heapimg cmyacc-hs

# Windows + SML/NJ 
.PHONY : win+smlnj
win+smlnj:
	sml export-smlnj.sml
	bin/mknjexec-win `which sml` `pwd`/bin cmyacc-heapimg.x86-win32 cmyacc

.PHONY : win+smlnj+hs
win+smlnj+hs:
	sml export-smlnj-hs.sml
	bin/mknjexec-win `which sml` `pwd`/bin cmyacc-hs-heapimg.x86-win32 cmyacc-hs

install:
	rm -f $(DESTDIR)/bin/cmyacc.new
	cp bin/cmyacc $(DESTDIR)/bin/cmyacc.new
	mv $(DESTDIR)/bin/cmyacc.new $(DESTDIR)/bin/cmyacc

install+hs:
	rm -f $(DESTDIR)/bin/cmyacc-hs.new
	cp bin/cmyacc $(DESTDIR)/bin/cmyacc-hs.new
	mv $(DESTDIR)/bin/cmyacc-hs.new $(DESTDIR)/bin/cmyacc-hs

