
structure MakeNFA 
   :> MAKE_NFA
   =
   struct

      datatype seq = datatype TreeSequence.treeview

      structure D = SymbolDict

      (* make1RevNfa R n

         if    n >= 0
         then  (Q, q_init, q_final, delta) is an nfa for rev(R)
               Q = { n .. q_final }
               q_init in Q
               q_final in Q
               trans = [ delta(n) .. delta(q_final-1) ]  (NB: missing q_final)
               delta(q_final) is empty
               and
               return (q_init, q_final, trans)
      *)
      fun make1RevNfa re n =
          (case re of
              Regexp.Set set =>
                 let
                    val initial = n
                    val final = initial+1

                    val d =
                       SymbolSet.foldl
                       (fn (sym, d) => D.insert d sym [final])                              
                       D.empty
                       set
                 in
                    (initial, final, ELT (d, []))
                 end
            | Regexp.String l =>
                 let
                    val initial = n

                    val (final, trans) =
                       foldr
                       (fn (sym, (i, acc)) =>
                              (i+1,
                               NODE (acc,
                                     ELT (D.insert D.empty sym [i+1], []))))
                       (n, EMPTY)
                       l
                 in
                    (initial, final, trans)
                 end
            | Regexp.Epsilon =>
                 (n, n, EMPTY)
            | Regexp.Empty =>
                 let 
                    val initial = n
                    val final = initial+1
                 in
                    (initial, final, ELT (D.empty, []))
                 end
            | Regexp.Concat (re1, re2) =>
                 let
                    val (initial1, final1, trans1) = make1RevNfa re2 n
                    val (initial2, final2, trans2) = make1RevNfa re1 (final1+1)

                    val trans = NODE (NODE (trans1, ELT (D.empty, [initial2])), trans2)
                 in
                    (initial1, final2, trans)
                 end
            | Regexp.Union (re1, re2) =>
                 let
                    val (initial1, final1, trans1) = make1RevNfa re1 n
                    val (initial2, final2, trans2) = make1RevNfa re2 (final1+1)

                    val initial = final2+1
                    val final = initial+1

                    val transInitial = ([], [initial1, initial2])

                    val trans = 
                       NODE (NODE (NODE (trans1, ELT (D.empty, [final])),
                                   NODE (trans2, ELT (D.empty, [final]))),
                             ELT (D.empty, [initial1, initial2]))
                 in
                    (initial, final, trans)
                 end
            | Regexp.Option re =>
                 let
                    val (initial, final, trans) = make1RevNfa re n
                       
                    val initial' = final+1
                    val final' = initial'+1

                    val trans' =
                       NODE (NODE (trans, ELT (D.empty, [final'])),
                             ELT (D.empty, [initial, final']))
                 in
                    (initial', final', trans')
                 end
            | Regexp.Closure re =>
                 let
                    val (initial, final, trans) = make1RevNfa re n

                    val initial' = final+1
                    val final' = initial'+1

                    val trans' =
                       NODE (NODE (trans, ELT (D.empty, [initial'])),
                             ELT (D.empty, [initial, final']))
                 in
                    (initial', final', trans')
                 end
            | Regexp.Plus re =>
                 let
                    val (initial, final, trans) = make1RevNfa re n

                    val final' = final+1

                    val trans' =
                       NODE (trans, ELT (D.empty, [initial, final']))
                 in
                    (initial, final', trans')
                 end)


      (* makeRevNfaMain Rs n initialAcc transAcc
       
         if    n >= 0
         then  (Q, Q_init, q_final, delta) is an nfa for rev(Rs)
               Q = { 0, n .. count-1 }
               Q_init subset Q
               q_final = 0
               trans = [ delta(n) .. delta(count-1) ]
               and
               return (count, Q_init @ initialAcc, transAcc @ trans)
      *)
      fun makeRevNfaMain res n initialAcc transAcc =
          (case res of
              nil =>
                 (n, initialAcc, transAcc)
            | (re, action) :: rest =>
                 let
                    val (initial, final, trans) = make1RevNfa re n
                    val trans' = NODE (trans, ELT (D.empty, [0]))  (* add omitted final state *)
                 in
                    makeRevNfaMain rest (final+1) ((initial, action) :: initialAcc) (NODE (transAcc, trans'))
                 end)


      fun makeRevNfa res =
          let
             (* Put the master final state at 0. *)
             val (count, initial, trans) = makeRevNfaMain res 1 [] EMPTY
             val trans' = NODE (ELT (D.empty, []), trans)  (* add omitted final state *)

             val transvec = Array.fromList (TreeSequence.toList trans')
          in
             (initial, [(0, ())], transvec)
          end

   end
