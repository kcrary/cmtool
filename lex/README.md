CM-Lex: A lexer generator for Standard ML and Haskell
=====================================================

Installing
----------
CM-Lex should be installed through Smackage, an ML package manager
(see http://github.com/standardml/smackage). 

    $ smackage 
    $ smackage get cmlex
    $ smackage make cmlex (this will just display the various options)

To install CM-Lex (for Standard ML)

    $ smackage make cmlex mlton (or smlnj or win+smlnj)
    $ smackage make cmlex install
    $ cmlex
    Error: not enough input files
    Usage: cmlex file.cmlex [-o file.sml]
    (Default output file is file.cmlex.sml)

To install CM-Lex-HS (for Haskell)

    $ smackage make cmlex mlton+hs (or smlnj+hs or win+smlnj+hs)
    $ smackage make cmlex install+hs
    $ cmlex
    Error: not enough input files
    Usage: cmlex-hs file.cmlex [-o file.hs]
    (Default output file is file.cmlex.hs)

It is possible to install CMlex without Smackage: just make sure that CMlib v1
(see http://github.com/standardml/cmlib) is installed somewhere on your system,
and change the reference to `$SMACKAGE/cmlib/v1` in `sources-generic.cm` and/or
the reference to `$(SMACKAGE)/cmlib/v1` in `sources-generic.mlb` to point to 
the directory where CMlib lives.
