
structure Process
   :> PROCESS
   =
   struct

      structure S = SymbolSet
      structure D = SymbolDict

      open Syntax
      open Symbol
      open Automaton

      exception Error

      val modulename   : string option ref                          = ref NONE
      val types        : S.set ref                                  = ref S.empty
      val terminals    : (symbol option * bool ref) D.dict ref      = ref D.empty
      val nonterminals : (int list * symbol * bool ref) D.dict ref  = ref D.empty
      val actions      : int D.dict ref                             = ref D.empty
      val rules        : rule list ref                              = ref []
      val start        : symbol option ref                          = ref NONE
      val ruleCount    : int ref                                    = ref 0

      fun processMain l =
         (case l of
             [] =>
                ()
           | directive :: rest =>
                (
                (case directive of
                    Name name =>
                       (case !modulename of
                           SOME _ =>
                              (
                              print "Error: multiple functor names specified.\n";
                              raise Error
                              )
                         | NONE =>
                              modulename := SOME (Symbol.toString name))
                       
                  | Start name =>
                       (case !start of
                           SOME _ =>
                              (
                              print "Error: multiple start symbol specified.\n";
                              raise Error
                              )
                         | NONE =>
                              start := SOME name)

                  | Terminal (name, tpo) =>
                       if
                          D.member (!terminals) name
                          orelse
                          D.member (!nonterminals) name
                       then
                          (
                          print "Error: multiply specified symbol ";
                          print (toString name);
                          print ".\n";
                          raise Error
                          )
                       else
                          (
                          (case tpo of
                              NONE => ()
                            | SOME tp =>
                                 if D.member (!actions) tp then
                                    (
                                    print "Error: type identifier ";
                                    print (Symbol.toString tp);
                                    print " already used for an action.\n";
                                    raise Error
                                    )
                                 else
                                    types := S.insert (!types) tp);

                          terminals := (D.insert (!terminals) name (tpo, ref false))
                          )

                  | Nonterminal (name, tp, productions) =>
                       if
                          D.member (!terminals) name
                          orelse
                          D.member (!nonterminals) name
                       then
                          (
                          print "Error: multiply specified symbol ";
                          print (toString name);
                          print ".\n";
                          raise Error
                          )
                       else
                          (case productions of
                              [] =>
                                 (
                                 print "Error: no productions for nonterminal ";
                                 print (toString name);
                                 print ".\n";
                                 raise Error
                                 )
                            | _ =>
                                 let
                                    val () =
                                       if D.member (!actions) tp then
                                          (
                                          print "Error: type identifier ";
                                          print (Symbol.toString tp);
                                          print " already used for an action.\n";
                                          raise Error
                                          )
                                       else
                                          types := S.insert (!types) tp

                                    val (rules', actions', next, _) =
                                       foldl
                                       (fn ((constituents, action), (acc, actions', next, localnumber)) =>
                                           let
                                              val globalnumber = !ruleCount
                                              val () = ruleCount := globalnumber + 1

                                              val (rhsrev, argsrev, _) =
                                                 foldl
                                                 (fn (constituent, (rhsrev, argsrev, labels)) =>
                                                     (case constituent of
                                                         Unlabeled symbol =>
                                                            (symbol :: rhsrev,
                                                             NONE :: argsrev,
                                                             labels)
                                                       | Labeled (label, symbol) =>
                                                            if S.member labels label then
                                                               (
                                                               print "Error: argument ";
                                                               print (toString label);
                                                               print " is used multiple times in rule ";
                                                               print (Int.toString localnumber);
                                                               print " of nonterminal ";
                                                               print (toString name);
                                                               print ".\n";
                                                               raise Error
                                                               )
                                                            else
                                                               (symbol :: rhsrev,
                                                                SOME label :: argsrev,
                                                                S.insert labels label)))
                                                 ([], [], S.empty)
                                                 constituents

                                              val actions'' =
                                                 if D.member actions' action then
                                                    (
                                                    print "Error: multiply specified action ";
                                                    print (toString action);
                                                    print " in rule ";
                                                    print (Int.toString localnumber);
                                                    print " of nonterminal ";
                                                    print (toString name);
                                                    print ".\n";
                                                    raise Error
                                                    )
                                                 else if S.member (!types) action then
                                                    (
                                                    print "Error: action identifier ";
                                                    print (Symbol.toString action);
                                                    print " already used for a type.\n";
                                                    raise Error
                                                    )
                                                 else
                                                    D.insert actions' action globalnumber
                                           in
                                              ((globalnumber, localnumber, name, rev rhsrev, rev argsrev, action, ref false) :: acc,
                                               actions'',
                                               globalnumber :: next,
                                               localnumber + 1)
                                           end)
                                       (!rules, !actions, [], 0)
                                       productions
                                 in
                                    actions := actions';
                                    rules := rules';
                                    nonterminals := D.insert (!nonterminals) name (rev next, tp, ref false)
                                 end));

                processMain rest
                ))


      fun process l =
         let
            val () =
               (
               modulename := NONE;
               types := S.empty;
               terminals := D.empty;
               nonterminals := D.empty;
               actions := D.empty;
               rules := [];
               start := NONE;
               ruleCount := 0
               )

            val () = processMain l

            val modulename' =
               (case !modulename of
                   NONE =>
                      (
                      print "Error: no functor name specified.\n";
                      raise Error
                      )
                 | SOME name => name)

            val nonterminals' = !nonterminals
            val terminals' = !terminals

            val () =
               if D.isEmpty terminals' then
                  (
                  print "Error: no terminals specified.\n";
                  raise Error
                  )
               else
                  ()

            val start' =
               (case !start of
                   NONE =>
                      (
                      print "Error: no start symbol specified.\n";
                      raise Error
                      )
                 | SOME symbol =>
                      if D.member nonterminals' symbol then
                         symbol
                      else if D.member terminals' symbol then
                         (
                         print "Error: start symbol ";
                         print (toString symbol);
                         print " is a terminal.\n";
                         raise Error
                         )
                      else
                         (
                         print "Error: start symbol ";
                         print (toString symbol);
                         print " is never specified.\n";
                         raise Error
                         ))

            val rules' = rev (!rules)
            val () =
               app
               (fn (globalnumber, localnumber, nonterminalName, rhs, args, _, _) =>
                   ListPair.appEq
                   (fn (symbol, argo) =>
                          (case D.find nonterminals' symbol of
                              SOME _ => ()
                            | NONE =>
                                 (case D.find terminals' symbol of
                                     SOME (NONE, used) =>
                                        (case argo of
                                            NONE =>
                                               used := true
                                          | SOME label =>
                                               (
                                               print "Error: argument ";
                                               print (toString label);
                                               print " in rule ";
                                               print (Int.toString localnumber);
                                               print " of nonterminal ";
                                               print (toString nonterminalName);
                                               print " carries no data.\n";
                                               raise Error
                                               ))
                                   | SOME (SOME _, used) =>
                                        used := true
                                   | NONE =>
                                        (
                                        print "Error: symbol ";
                                        print (toString symbol);
                                        print " in rule ";
                                        print (Int.toString localnumber);
                                        print " of nonterminal ";
                                        print (toString nonterminalName);
                                        print " is never specified.\n";
                                        raise Error
                                        ))))
                      (rhs, args))
               rules'

            val () =
               D.app
               (fn (terminal, (_, used)) =>
                   if !used then
                      ()
                   else
                      (
                      print "Warning: terminal ";
                      print (Symbol.toString terminal);
                      print " is unused.\n"
                      ))
               terminals'

         in
            (modulename', !types, terminals', nonterminals',
             MakeAutomaton.makeAutomaton start' nonterminals' (Vector.fromList rules'))
         end

   end
