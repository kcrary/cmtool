
all:
	@echo "CM-Lex:"
	@echo "Run 'make smlnj' or 'make mlton' on Linux/Unix/OSX."
	@echo "Run 'make win+smlnj' or 'make mlton' on Windows."

# MLton
.PHONY : mlton
mlton: 
	mlton -output bin/cmlex cmlex.mlb

# SML/NJ
.PHONY : smlnj
smlnj:
	sml export-smlnj.sml
	bin/mknjexec-unixey `which sml` `pwd`/bin cmlex-heapimg cmlex 

# Windows + SML/NJ 
.PHONY : win+smlnj
win+smlnj:
	sml export-smlnj.sml
	bin/mknjexec-win `which sml` `pwd`/bin cmlex-heapimg.x86-win32 cmlex 
