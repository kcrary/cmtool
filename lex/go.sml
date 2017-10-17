structure Go = struct

   val status = 
      Main.mainCmd "cmlex" (CommandLine.name (), CommandLine.arguments ())

   val () = OS.Process.exit status

end
