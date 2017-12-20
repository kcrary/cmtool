
structure Main =
   struct

      exception Error = Process.Error

      fun main infile outfileopt =
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

             val (lang, auto) = Process.process program

             val outfile =
                (case outfileopt of
                    SOME file => file
                  | NONE =>
                       OS.Path.joinBaseExt {base = infile, ext = SOME (Language.extension lang)})
          in
             (case lang of
                 Language.SML =>
                    CodegenSml.writeProgram outfile auto
               | Language.HASKELL =>
                    CodegenHs.writeProgram outfile auto
               | Language.OCAML =>
                    CodegenOcaml.writeProgram outfile auto);
             print outfile;
             print " written\n"
          end

      exception Quit of string
      fun mainCmd name (_, args) =
          let
             val () = print "CM-Lex version "
             val () = print Version.version
             val () = print "\n"

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
             val outfileopt = !outfile
          in   
             main infile outfileopt; OS.Process.success
          end handle Process.Error => OS.Process.failure
                   | Parser.Error => OS.Process.failure
                   | CodegenUtil.Error => OS.Process.failure
                   | Quit msg => 
                     (print ("Error: " ^ msg ^ "\n\
                             \Usage: " ^ name ^ " <input-file> [-o <output-file>]\n\
                             \(Default output file is <input-file>.[sml/hs])")
                     ; OS.Process.failure) 
                   | exn =>  
                     (print ("Failed with exception: " ^ exnName exn ^ "\n")
                     ; print ("[" ^ exnMessage exn ^ "]\n")
                     ; OS.Process.failure) 
   end
