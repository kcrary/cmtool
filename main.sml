
functor MainFun (structure Parser : PARSER
                 structure CodeGen : CODEGEN) =
   struct

      exception Error = Process.Error

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
          in
             CodeGen.writeProgram outfile (Process.process program)
          end

   end
