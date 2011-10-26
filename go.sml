structure Go = struct

   val status = Main.mainCmd "sml" (CommandLine.name (), CommandLine.arguments ())

   val () = OS.Process.exit status

end
