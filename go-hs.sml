structure Go = struct

   val status = 
      MainHs.mainCmd "cmlex-hs" (CommandLine.name (), CommandLine.arguments ())

   val () = OS.Process.exit status

end
