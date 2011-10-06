
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

      fun mainCmd (name, args) =
          let val usage = "Usage: cmlex file.cmlex" in  
             case args of 
                [] => 
                (print "not enough files\n"; print usage; OS.Process.failure)
              | _ :: _ :: _ => 
                (print "too many files\n"; print usage; OS.Process.failure)
              | [ arg ] => 
                (main arg (OS.Path.joinBaseExt {base = arg, ext = SOME "sml"})
                ; OS.Process.success)
          end handle exn => 
             (print ("Exception: " ^ exnName exn ^ "\n" ^ exnMessage exn ^ "\n")
             ; OS.Process.failure) 
   end
