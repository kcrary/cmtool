
structure Main =
   struct

      fun main infile outfile =
          let 
             val ins = TextIO.openIn infile

             val program =
                SOME (Parser.parse (Lexer.lex (Stream.fromInstream ins)))
                handle Lexer.LexicalError pos =>
                          (
                          print "Lexical error at ";
                          print (Int.toString pos);
                          print ".\n";
                          NONE
                          )
                     | Lexer.IllegalIdentifier pos =>
                          (
                          print "Illegal identifier at ";
                          print (Int.toString pos);
                          print ".\n";
                          NONE
                          )
                     | Lexer.IllegalConstant pos =>
                          (
                          print "Illegal constant at ";
                          print (Int.toString pos);
                          print ".\n";
                          NONE
                          )
                     | Parser.SyntaxError =>
                          (
                          print "Syntax error.\n";
                          NONE
                          )
                     | exn =>
                          (
                          TextIO.closeIn ins;
                          raise exn
                          )

             val () = TextIO.closeIn ins
          in
             (case program of
                 NONE =>
                    ()
               | SOME directives =>
                    CodeGen.writeProgram outfile (Process.process directives))
          end

   end
