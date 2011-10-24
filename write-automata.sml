
structure WriteAutomata
   :> WRITE_AUTOMATA
   =
   struct

      fun appSeparated f g l =
          (case l of
              [] =>
                 ()
            | h :: t =>
                 (
                 f h;
                 app (fn x => (g (); f x)) t
                 ))

      fun writeAutomaton outs name (count, initial, lastFinalSink, lastFinal, actions, trans, transEos) =
         let
            fun write str = TextIO.output (outs, str)

            fun stateName state =
               let
                  val str = Array.sub (actions, state-1)
               in
                  if str = "" then
                     "<error>"
                  else
                     str
               end

            fun writeSort sep state =
               let
                  val l =
                     if state <= lastFinalSink then
                        ["sink:", stateName state]
                     else if state <= lastFinal then
                        ["final:", stateName state]
                     else
                        []

                  val l =
                     if state = initial then
                        if null l then
                           ["initial"]
                        else
                           "initial, " :: l
                     else
                        l
               in
                  (case l of
                      [] => ()
                    | _ =>
                         (
                         write sep;
                         write "(";
                         app write l;
                         write ")"
                         ))
               end

            fun writeTransEntry rangestart rangeend res =
               if res = 0 then
                  ()
               else
                  (
                  write (Int.toString rangestart);
                  if rangeend > rangestart then
                     (
                     write "-";
                     write (Int.toString rangeend)
                     )
                  else
                     ();
                  write " => state ";
                  write (Int.toString res);
                  writeSort "   " res;
                  write "\n"
                  )

            fun writeTrans arr sz rangestart res i =
               if i >= sz then
                  writeTransEntry rangestart (sz-1) res
               else
                  let
                     val res' = Array.sub (arr, i)
                  in
                     if res = res' then
                        writeTrans arr sz rangestart res (i+1)
                     else
                        (
                        writeTransEntry rangestart (i-1) res;
                        writeTrans arr sz i res' (i+1)
                        )
                  end

            fun loop last state =
               if state > last then
                  ()
               else
                  (
                  write "\n-----\n\n";
                  write name;
                  write "\nstate ";
                  write (Int.toString state);
                  writeSort " " state;
                  write ":\n\n";

                  let
                     val arr = Array.sub (trans, state)
                  in
                     writeTrans arr (Array.length arr) 0 (Array.sub (arr, 0)) 1
                  end;

                  (case Array.sub (transEos, state) of
                      0 => ()
                    | state' =>
                         (
                         write "EOS => state ";
                         write (Int.toString state');
                         writeSort "   " state';
                         write "\n"
                         ));

                  loop last (state+1)
                  )
         in
            write name;
            write "\ninitial state = ";
            write (Int.toString initial);
            write "\ntotal states = ";
            write (Int.toString count);
            write "\n";

            loop lastFinal (lastFinalSink+1);
            loop (count-1) (lastFinal+1)
         end

      fun writeAutomata outs l =
         appSeparated
         (fn (name, _, automaton) => writeAutomaton outs name automaton)
         (fn () => TextIO.output (outs, "\n=====\n\n"))
         l

   end
