
structure Main =
   struct

      fun main infile outfile =
          let 
             val ins = TextIO.openIn infile

             val program =
                Parser.parse (Stream.fromInstream ins)
                handle exn =>
                          (
                          TextIO.closeIn ins;
                          raise exn
                          )

             val () = TextIO.closeIn ins

             val parser = Process.process program
          in
             Codegen.writeProgram outfile parser
          end

   end
