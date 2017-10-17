CM-Yacc: A parser generator for Standard ML and Haskell
=======================================================

Installing
----------
CM-Yacc should be installed through Smackage, an ML package manager
(see http://github.com/standardml/smackage). 

    $ smackage 
    $ smackage get cmyacc
    $ smackage make cmyacc (this will just display the various options)

To install CM-Yacc (for Standard ML)

    $ smackage make cmyacc mlton (or smlnj or win+smlnj)
    $ smackage make cmyacc install
    $ cmyacc
    Error: not enough input files
    Usage: cmyacc file.cmyacc [-o file.sml]
    (Default output file is file.cmyacc.sml)

To install CM-Yacc-HS (for Haskell)

    $ smackage make cmyacc mlton+hs (or smlnj+hs or win+smlnj+hs)
    $ smackage make cmyacc install+hs
    $ cmyacc
    Error: not enough input files
    Usage: cmyacc-hs file.cmyacc [-o file.hs]
    (Default output file is file.cmyacc.hs)

It is possible to install CM-Yacc without Smackage: just make sure that CM-Lib 
v1 (see http://github.com/standardml/cmlib) is installed somewhere on your 
system, and change the reference to `$SMACKAGE/cmlib/v1` in 
`sources-generic.cm` and/or the reference to `$(SMACKAGE)/cmlib/v1` in 
`sources-generic.mlb` to point to the directory where CMlib lives.
