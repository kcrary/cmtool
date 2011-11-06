
functor MainFun (structure Parser : PARSER
                 structure Codegen : CODEGEN
                 val extension : string) =
   struct

      exception Error = Process.Error

      fun main infile outfile =
          let 
             val ins = TextIO.openIn infile

             val program =
                Parser.parse (Stream.fromTextInstream ins)
                handle exn =>
                          (
                          TextIO.closeIn ins;
                          raise exn
                          )

             val () = TextIO.closeIn ins
          in
             Codegen.writeProgram outfile (Process.process program)
          end

      exception Quit of string
      fun mainCmd name (_, args) =
          let 
             (* Parse arguments *)
             val infile: string option ref = ref NONE
             val outfile: string option ref = ref NONE
             fun loop [] = ()
               | loop ("-o" :: file :: args) =
                 if isSome (!outfile) then raise Quit "too many output files"
                 else (outfile := SOME file; loop args)
               | loop (file :: args) = 
                 if isSome (!infile) then raise Quit "too many input files"
                 else (infile := SOME file; loop args)
             val () = loop args             

             (* Validate arguments *)
             val infile = 
                case (!infile) of 
                   NONE => raise Quit "not enough input files"
                 | SOME file => file
             val outfile = 
                case (!outfile) of
                   NONE => OS.Path.joinBaseExt {base = infile, ext = SOME extension}
                 | SOME file => file
          in   
             main infile outfile; OS.Process.success
          end handle Process.Error => OS.Process.failure
                   | Parser.Error => OS.Process.failure
                   | Codegen.Error => OS.Process.failure
                   | Quit msg => 
                     (print ("Error: " ^ msg ^ "\n\
                             \Usage: " ^ name ^ " file.cmlex [-o file." ^ extension ^ "]\n\
                             \(Default output file is file.cmlex." ^ extension ^ ")\n")
                     ; OS.Process.failure) 
                   | exn =>  
                     (print ("Failed with exception: " ^ exnName exn ^ "\n")
                     ; print ("[" ^ exnMessage exn ^ "]\n")
                     ; OS.Process.failure) 
   end
