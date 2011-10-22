
structure Process
   :> PROCESS
   =
   struct

      structure S = SymbolSet
      structure D = SymbolDict

      open Syntax
      open Symbol
      open Automaton

      fun labelToString l =
         (case l of
             IdentLabel s =>
                Symbol.toValue s
           | NumericLabel n =>
                Int.toString n)

      structure IntSet = ListSet (structure Elem = IntOrdered)

      datatype labelset =
         Empty
       | Numbers of IntSet.set * int  (* maximum *)
       | Idents of S.set

      exception Error

      val modulename   : string option ref                          = ref NONE
      val types        : S.set ref                                  = ref S.empty
      val terminals    : (symbol option * Automaton.precedence * bool ref) D.dict ref = ref D.empty
      val nonterminals : (int list * symbol * bool ref) D.dict ref  = ref D.empty
      val actions      : int D.dict ref                             = ref D.empty
      val rules        : rule list ref                              = ref []
      val start        : symbol option ref                          = ref NONE
      val ruleCount    : int ref                                    = ref 0
      val followers    : S.set ref                                  = ref S.empty

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
                              modulename := SOME (Symbol.toValue name))
                       
                  | Start name =>
                       (case !start of
                           SOME _ =>
                              (
                              print "Error: multiple start symbol specified.\n";
                              raise Error
                              )
                         | NONE =>
                              start := SOME name)

                  | Follower name =>
                       if D.member (!terminals) name then
                          followers := S.insert (!followers) name
                       else
                          (
                          print "Error: parse follower symbol ";
                          print (toValue name);
                          print " is not declared as a terminal.\n";
                          raise Error
                          )

                  | Terminal (name, tpo, prec) =>
                       if
                          D.member (!terminals) name
                          orelse
                          D.member (!nonterminals) name
                       then
                          (
                          print "Error: multiply specified symbol ";
                          print (toValue name);
                          print ".\n";
                          raise Error
                          )
                       else
                          let
                             val () =
                                (case tpo of
                                    NONE => ()
                                  | SOME tp =>
                                       if D.member (!actions) tp then
                                          (
                                          print "Error: type identifier ";
                                          print (Symbol.toValue tp);
                                          print " already used for an action.\n";
                                          raise Error
                                          )
                                       else
                                          types := S.insert (!types) tp)

                             val prec' =
                                (case prec of
                                    EmptyPrec => NONE
                                  | PrecNone => NONE
                                  | PrecLeft n =>
                                       if n < 0 orelse n > 100 then
                                          (
                                          print "Error: precedence of terminal ";
                                          print (Symbol.toValue name);
                                          print " is out of range.\n";
                                          raise Error
                                          )
                                       else
                                          SOME (2*n)
                                  | PrecRight n =>
                                       if n < 0 orelse n > 100 then
                                          (
                                          print "Error: precedence of terminal ";
                                          print (Symbol.toValue name);
                                          print " is out of range.\n";
                                          raise Error
                                          )
                                       else
                                          SOME (2*n+1))  (* boost shift precedence for right associative operator *)
                          in
                             terminals := (D.insert (!terminals) name (tpo, prec', ref false))
                          end

                  | Nonterminal (name, tp, productions) =>
                       if
                          D.member (!terminals) name
                          orelse
                          D.member (!nonterminals) name
                       then
                          (
                          print "Error: multiply specified symbol ";
                          print (toValue name);
                          print ".\n";
                          raise Error
                          )
                       else
                          (case productions of
                              [] =>
                                 (
                                 print "Error: no productions for nonterminal ";
                                 print (toValue name);
                                 print ".\n";
                                 raise Error
                                 )
                            | _ =>
                                 let
                                    val () =
                                       if D.member (!actions) tp then
                                          (
                                          print "Error: type identifier ";
                                          print (Symbol.toValue tp);
                                          print " already used for an action.\n";
                                          raise Error
                                          )
                                       else
                                          types := S.insert (!types) tp

                                    val (rules', actions', next, _) =
                                       foldl
                                       (fn ((constituents, action, prec), (acc, actions', next, localnumber)) =>
                                           let
                                              val globalnumber = !ruleCount
                                              val () = ruleCount := globalnumber + 1

                                              val (rhsrev, argsrev, labelset) =
                                                 foldl
                                                 (fn (constituent, (rhsrev, argsrev, labelset)) =>
                                                     (case constituent of
                                                         Unlabeled symbol =>
                                                            (symbol :: rhsrev,
                                                             NONE :: argsrev,
                                                             labelset)
                                                       | Labeled (label, symbol) =>
                                                            let
                                                               val labelset' =
                                                                  (case (label, labelset) of
                                                                      (IdentLabel ident, Empty) =>
                                                                         Idents (S.singleton ident)
                                                                    | (IdentLabel ident, Idents set) =>
                                                                         if S.member set ident then
                                                                            (
                                                                            print "Error: argument ";
                                                                            print (Symbol.toValue ident);
                                                                            print " is used multiple times in rule ";
                                                                            print (Int.toString localnumber);
                                                                            print " of nonterminal ";
                                                                            print (toValue name);
                                                                            print ".\n";
                                                                            raise Error
                                                                            )
                                                                         else
                                                                            Idents (S.insert set ident)
                                                                    | (IdentLabel ident, Numbers _) =>
                                                                         (
                                                                         print "Error: identifer and numeric arguments are mixed in rule ";
                                                                         print (Int.toString localnumber);
                                                                         print " of nonterminal ";
                                                                         print (toValue name);
                                                                         print ".\n";
                                                                         raise Error
                                                                         )
                                                                    | (NumericLabel 0, _) =>
                                                                         (
                                                                         print "Error: illegal label 0 in rule ";
                                                                         print (Int.toString localnumber);
                                                                         print " of nonterminal ";
                                                                         print (toValue name);
                                                                         print ".\n";
                                                                         raise Error
                                                                         )
                                                                    | (NumericLabel n, Empty) =>
                                                                         Numbers (IntSet.singleton n, n)
                                                                    | (NumericLabel n, Numbers (set, max)) =>
                                                                         if IntSet.member set n then
                                                                            (
                                                                            print "Error: argument ";
                                                                            print (Int.toString n);
                                                                            print " is used multiple times in rule ";
                                                                            print (Int.toString localnumber);
                                                                            print " of nonterminal ";
                                                                            print (toValue name);
                                                                            print ".\n";
                                                                            raise Error
                                                                            )
                                                                         else
                                                                            Numbers (IntSet.insert set n, Int.max (max, n))
                                                                    | (NumericLabel n, Idents _) =>
                                                                         (
                                                                         print "Error: identifer and numeric arguments are mixed in rule ";
                                                                         print (Int.toString localnumber);
                                                                         print " of nonterminal ";
                                                                         print (toValue name);
                                                                         print ".\n";
                                                                         raise Error
                                                                         ))
                                                            in
                                                               (symbol :: rhsrev,
                                                                SOME label :: argsrev,
                                                                labelset')
                                                            end))
                                                 ([], [], Empty)
                                                 constituents

                                              val solearg =
                                                 (case labelset of
                                                     Numbers (_, 1) =>
                                                        (* Every number in set is positive.
                                                           Therefore, set = {1} iff max(set) = 1.
                                                        *)
                                                        true
                                                   | Numbers (set, n) =>
                                                        (* Every number in set is positive.
                                                           Therefore, set = {1 .. n} (for some n) 
                                                           iff |set| = max(set).
                                                        *)
                                                        if IntSet.size set = n then
                                                           false
                                                        else
                                                           (
                                                           print "Error: numeric arguments do not complete a tuple in rule ";
                                                           print (Int.toString localnumber);
                                                           print " of nonterminal ";
                                                           print (toValue name);
                                                           print ".\n";
                                                           raise Error
                                                           )
                                                   | _ =>
                                                        false)

                                              val actions'' =
                                                 if D.member actions' action then
                                                    (
                                                    print "Error: multiply specified action ";
                                                    print (toValue action);
                                                    print " in rule ";
                                                    print (Int.toString localnumber);
                                                    print " of nonterminal ";
                                                    print (toValue name);
                                                    print ".\n";
                                                    raise Error
                                                    )
                                                 else if S.member (!types) action then
                                                    (
                                                    print "Error: action identifier ";
                                                    print (Symbol.toValue action);
                                                    print " already used for a type.\n";
                                                    raise Error
                                                    )
                                                 else
                                                    D.insert actions' action globalnumber

                                              val prec' =
                                                 (case prec of
                                                     PrecNone => NONE
                                                   | PrecLeft n =>
                                                        if n < 0 orelse n > 100 then
                                                           (
                                                           print "Error: precedence of rule ";
                                                           print (Int.toString localnumber);
                                                           print " of nonterminal ";
                                                           print (Symbol.toValue name);
                                                           print " is out of range.\n";
                                                           raise Error
                                                           )
                                                        else
                                                           SOME (2*n+1)  (* boost reduce precedence for left associative operator *)
                                                   | PrecRight n =>
                                                        if n < 0 orelse n > 100 then
                                                           (
                                                           print "Error: precedence of rule ";
                                                           print (Int.toString localnumber);
                                                           print " of nonterminal ";
                                                           print (Symbol.toValue name);
                                                           print " is out of range.\n";
                                                           raise Error
                                                           )
                                                        else
                                                           SOME (2*n)
                                                   | EmptyPrec =>
                                                        (* No precedence give, try to infer one from the rhs. *)
                                                        let
                                                           fun findLastTerminal l =
                                                              (case l of
                                                                  symbol :: rest =>
                                                                     (case D.find (!terminals) symbol of
                                                                         NONE =>
                                                                            (* nonterminal *)
                                                                            findLastTerminal rest
                                                                       | SOME (_, prec, _) =>
                                                                            prec)
                                                                | [] =>
                                                                     NONE)
                                                        in
                                                           (case findLastTerminal rhsrev of
                                                               NONE =>
                                                                  (* Last terminal has no precedence, or rule has no terminals at all. *)
                                                                  NONE
                                                             | SOME n =>
                                                                  (* Last terminal has shift precedence n; flip the parity to get reduce precedence. *)
                                                                  SOME (if n mod 2 = 0 then
                                                                           n+1
                                                                        else
                                                                           n-1))
                                                        end)
                                                              
                                           in
                                              ((globalnumber, localnumber, name, rev rhsrev, rev argsrev, solearg, action, prec', ref false) :: acc,
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
               ruleCount := 0;
               followers := S.empty
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
                         print (toValue symbol);
                         print " is a terminal.\n";
                         raise Error
                         )
                      else
                         (
                         print "Error: start symbol ";
                         print (toValue symbol);
                         print " is never specified.\n";
                         raise Error
                         ))

            val rules' = rev (!rules)
            val () =
               app
               (fn (globalnumber, localnumber, nonterminalName, rhs, args, _, _, _, _) =>
                   ListPair.appEq
                   (fn (symbol, argo) =>
                          (case D.find nonterminals' symbol of
                              SOME _ => ()
                            | NONE =>
                                 (case D.find terminals' symbol of
                                     SOME (NONE, _, used) =>
                                        (case argo of
                                            NONE =>
                                               used := true
                                          | SOME label =>
                                               (
                                               print "Error: argument ";
                                               print (labelToString label);
                                               print " in rule ";
                                               print (Int.toString localnumber);
                                               print " of nonterminal ";
                                               print (toValue nonterminalName);
                                               print " carries no data.\n";
                                               raise Error
                                               ))
                                   | SOME (SOME _, _, used) =>
                                        used := true
                                   | NONE =>
                                        (
                                        print "Error: symbol ";
                                        print (toValue symbol);
                                        print " in rule ";
                                        print (Int.toString localnumber);
                                        print " of nonterminal ";
                                        print (toValue nonterminalName);
                                        print " is never specified.\n";
                                        raise Error
                                        ))))
                      (rhs, args))
               rules'

            val () =
               D.app
               (fn (terminal, (_, _, used)) =>
                   if !used then
                      ()
                   else
                      (
                      print "Warning: terminal ";
                      print (Symbol.toValue terminal);
                      print " is unused.\n"
                      ))
               terminals'

         in
            (modulename', !types, terminals', nonterminals',
             MakeAutomaton.makeAutomaton start' terminals' nonterminals' (!followers) (Vector.fromList rules'))
         end

   end
