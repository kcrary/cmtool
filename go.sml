structure Go = struct

   val status = 
      Main.mainCmd "cmyacc" (CommandLine.name (), CommandLine.arguments ())

   val () = OS.Process.exit status

end
