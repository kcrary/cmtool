structure Go = struct

   val status = MainHs.mainCmd (CommandLine.name (), CommandLine.arguments ())

   val () = OS.Process.exit status

end
