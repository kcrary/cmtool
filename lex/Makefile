
all:
	@echo "CM-Lex for Standard ML (cmlex):"
	@echo "Run 'make smlnj' or 'make mlton' on Linux/Unix/OSX."
	@echo "Run 'make win+smlnj' or 'make mlton' on Windows."
	@echo ""
	@echo "CM-Lex for Haskell (cmlex-hs):"
	@echo "Run 'make smlnj+hs' or 'make mlton+hs' on Linux/Unix/OSX."
	@echo "Run 'make win+smlnj+hs' or 'make mlton+hs' on Windows."

# MLton
.PHONY : mlton
mlton: 
	mlton -output bin/cmlex cmlex.mlb

.PHONY : mlton+hs
mlton+hs: 
	mlton -output bin/cmlex-hs cmlex-hs.mlb

# SML/NJ
.PHONY : smlnj
smlnj:
	sml export-smlnj.sml
	bin/mknjexec-unixey `which sml` `pwd`/bin cmlex-heapimg cmlex 

.PHONY : smlnj+hs
smlnj+hs:
	sml export-smlnj-hs.sml
	bin/mknjexec-unixey `which sml` `pwd`/bin cmlex-hs-heapimg cmlex-hs

# Windows + SML/NJ 
.PHONY : win+smlnj
win+smlnj:
	sml export-smlnj.sml
	bin/mknjexec-win `which sml` `pwd`/bin cmlex-heapimg.x86-win32 cmlex 

.PHONY : win+smlnj+hs
win+smlnj+hs:
	sml export-smlnj-hs.sml
	bin/mknjexec-win `which sml` `pwd`/bin cmlex-hs-heapimg.x86-win32 cmlex-hs
