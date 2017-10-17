structure Go = struct

   val status = 
      MainHs.mainCmd "cmyacc-hs"
         (CommandLine.name (), CommandLine.arguments ())

   val () = OS.Process.exit status

end
