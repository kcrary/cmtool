
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

       fun mainCmd (name, args) =
          let 
             val usage = "Usage: cmyacc file.cmyacc\n" 
          in  
             case args of 
                [] => 
                (print "not enough files\n"; print usage; OS.Process.failure)
              | _ :: _ :: _ => 
                (print "too many files\n"; print usage; OS.Process.failure)
              | [ arg ] => 
                (main arg (OS.Path.joinBaseExt {base = arg, ext = SOME "sml"})
                ; OS.Process.success)
          end handle Process.Error => OS.Process.failure
                   | Parser.Error => OS.Process.failure
                   | exn =>  
                     (print ("Failed with exception: " ^ exnName exn ^ "\n")
                     ; print ("[" ^ exnMessage exn ^ "]\n")
                     ; OS.Process.failure) 

   end
