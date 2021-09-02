
all:
	@echo "CM-Yacc for Standard ML (cmyacc):"
	@echo "Run 'make smlnj' or 'make mlton' on Linux/Unix/OSX."
	@echo "Run 'make win+smlnj' or 'make mlton' on Windows."

# MLton
.PHONY : mlton
mlton: 
	mlton -output bin/cmyacc cmyacc.mlb

SMLNJ=`which sml`

# SML/NJ
.PHONY : smlnj
smlnj:
	sml export-smlnj.sml
	bin/mknjexec-unixey $(SMLNJ) `pwd`/bin cmyacc-heapimg cmyacc 

# Windows + SML/NJ 
.PHONY : win+smlnj
win+smlnj:
	sml export-smlnj.sml
	bin/mknjexec-win $(SMLNJ) `pwd`/bin cmyacc-heapimg.x86-win32 cmyacc
