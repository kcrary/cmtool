
all:
	@echo "Run 'make win+smlnj' or 'make win+smlnj+hs'".
	@echo Other platforms coming soon.

.PHONY : win+smlnj
win+smlnj:
	sml export-smlnj.sml
	bin/mknjexec `which sml` `pwd`/bin cmyacc.x86-win32 cmyacc

.PHONY : win+smlnj+hs
win+smlnj+hs:
	sml export-smlnj-hs.sml
	bin/mknjexec `which sml` `pwd`/bin cmyacc-hs.x86-win32 cmyacc-hs
