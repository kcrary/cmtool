
all:
	@echo "Run 'make win+smlnj' or 'make win+smlnj+hs'".
	@echo Other platforms coming soon.

win+smlnj:
	sml export-smlnj.sml
	bin/mknjexec `which sml` `pwd`/bin cmlex.x86-win32 cmlex

win+smlnj+hs:
	sml export-smlnj-hs.sml
	bin/mknjexec `which sml` `pwd`/bin cmlex-hs.x86-win32 cmlex-hs
