structure Go = struct

   val status = Main.mainCmd (CommandLine.name (), CommandLine.arguments ())

   val () = OS.Process.exit status

end
