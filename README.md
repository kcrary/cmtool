CM-Lex and CM-Yacc: A lexer and parser generator for Standard ML, OCaml, and Haskell
====================================================================================

Existing lexer and parser generators such as Lex and Yacc suffer from
practical inconveniences because they use disembodied code to
implement actions.  To prevent this problem, CM-Lex and CM-Yacc
generate closed functors that are then instantiated by the programmer
with appropriate action code.  This results in all code being type
checked in its appropriate context, and it assists the type checker in
localizing errors correctly.

CM-Lex and CM-Yacc are implemented for Standard ML, OCaml, and Haskell.
However, all three versions are implemented *in* Standard ML.  Installation
instructions for Unix and Windows appear in the INSTALL file.  You
will need either MLton or Standard ML of New Jersey.

The user's manual is included here as manual.pdf.

The project uses a submodule (github.com/standardml/cmlib), so it
should be cloned using the `--recursive` option.

You can read more about hygienic source code generation using functors at
www.cs.cmu.edu/~crary/papers/2018/cmtool.pdf.
