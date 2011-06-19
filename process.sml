
structure Process
   :> PROCESS
   =
   struct

      (* This number is hardcoded to correspond to tableSizeMinor in codegen.sml. *)
      val symbolLimitMax = 1024

      (* This number is hardcoded to correspond to tableSizeMajor in codegen.sml. *)
      val stateCountMax = 65536

      type lexer =
         string                                         (* functor name *)
         *
         int                                            (* alphabet size *)
         *
         string list                                    (* type arguments *)
         *
         (string * string) list                         (* action arguments *)
         *
         (string * (string * Automata.automaton)) list  (* lexing functions *)


      structure S = ListSet (structure Elem = StringOrdered)
      structure D = ListDict (structure Key = StringOrdered)
      structure SS = SymbolSet

      open Syntax

      exception Error

      datatype pattern =
         ReCharset of SymbolSet.set
       | RePattern of Regexp.regexp



      type context = { modulename : string option,
                       types : S.set,
                       actions : string D.dict,
                       functions : (string * (Regexp.regexp * (int * string)) list) D.dict,
                       patterns : pattern D.dict,
                       alphabet : (int * SS.set) option }

      fun modulenameUpdate { modulename, types, actions, functions, patterns, alphabet } x =
          { modulename = x,
            types = types,
            actions = actions,
            functions = functions,
            patterns = patterns,
            alphabet = alphabet }

      fun typesUpdate { modulename, types, actions, functions, patterns, alphabet } x =
          { modulename = modulename,
            types = x,
            actions = actions,
            functions = functions,
            patterns = patterns,
            alphabet = alphabet }

      fun actionsUpdate { modulename, types, actions, functions, patterns, alphabet } x =
          { modulename = modulename,
            types = types,
            actions = x,
            functions = functions,
            patterns = patterns,
            alphabet = alphabet }

      fun functionsUpdate { modulename, types, actions, functions, patterns, alphabet } x =
          { modulename = modulename,
            types = types,
            actions = actions,
            functions = x,
            patterns = patterns,
            alphabet = alphabet }

      fun patternsUpdate { modulename, types, actions, functions, patterns, alphabet } x =
          { modulename = modulename,
            types = types,
            actions = actions,
            functions = functions,
            patterns = x,
            alphabet = alphabet }

      fun alphabetUpdate { modulename, types, actions, functions, patterns, alphabet } x =
          { modulename = modulename,
            types = types,
            actions = actions,
            functions = functions,
            patterns = patterns,
            alphabet = x }



      fun processSet setname (ctx:context) set =
          (case set of
              Svar name =>
                 (case D.find (#patterns ctx) name of
                     NONE =>
                        (
                        print "Error: unbound pattern ";
                        print name;
                        print " in set ";
                        print setname;
                        print ".\n";
                        raise Error
                        )
                   | SOME (ReCharset set) =>
                        set
                   | SOME (RePattern _) =>
                        (
                        print "Error: regexp pattern ";
                        print name;
                        print " in set ";
                        print setname;
                        print ".\n";
                        raise Error
                        ))
            | Ssymbol sym =>
                 if 0 <= sym andalso sym < #1 (valOf (#alphabet ctx)) then
                    SS.insert SS.empty sym
                 else
                    (
                    print "Error: character out of alphabet range in charset ";
                    print setname;
                    print ".\n";
                    raise Error
                    )
            | Srange l =>
                 foldl
                 (fn ((bottom, top), set) =>
                        if bottom > top then
                           (
                           print "Error: ill-formed range in character set ";
                           print setname;
                           print ".\n";
                           raise Error
                           )
                        else if 0 <= bottom andalso top < #1 (valOf (#alphabet ctx)) then
                           let
                              fun loop curr acc =
                                  if curr > top then
                                     acc
                                  else
                                     loop (curr+1) (SS.insert acc curr)
                           in
                              loop bottom set
                           end
                        else
                           (
                           print "Error: character out of alphabet range in charset ";
                           print setname;
                           print ".\n";
                           raise Error
                           ))
                 SS.empty
                 l
            | Sempty =>
                 SS.empty
            | Sunion l =>
                 foldl
                 (fn (set1, set2) => SS.union (processSet setname ctx set1) set2)
                 SS.empty
                 l
            | Sintersection [] =>
                 #2 (valOf (#alphabet ctx))
            | Sintersection (set :: l) =>
                 foldl
                 (fn (set1, set2) => SS.intersection (processSet setname ctx set1) set2)
                 (processSet setname ctx set)
                 l
            | Sdifference (set, l) =>
                 foldl
                 (fn (set1, set2) => SS.difference set2 (processSet setname ctx set1))
                 (processSet setname ctx set)
                 l
            | Scomplement l =>
                 foldl
                 (fn (set1, set2) => SS.difference set2 (processSet setname ctx set1))
                 (#2 (valOf (#alphabet ctx)))
                 l
            | Sany =>
                 #2 (valOf (#alphabet ctx)))


      fun processRegexp errfn (ctx:context) re =
          (case re of
              Var name =>
                 (case D.find (#patterns ctx) name of
                     NONE =>
                        (
                        print "Error: unbound pattern ";
                        print name;
                        print " in ";
                        errfn ();
                        print ".\n";
                        raise Error
                        )
                   | SOME (ReCharset set) =>
                        Regexp.Set set
                   | SOME (RePattern re') =>
                        re')
            | Symbol sym =>
                 if 0 <= sym andalso sym < #1 (valOf (#alphabet ctx)) then
                    Regexp.String [sym]
                 else
                    (
                    print "Error: character out of alphabet range in ";
                    errfn ();
                    print ".\n";
                    raise Error
                    )
            | String l =>
                 (
                 app
                 (fn sym => 
                        if 0 <= sym andalso sym < #1 (valOf (#alphabet ctx)) then
                           ()
                        else
                           (
                           print "Error: character out of alphabet range in ";
                           errfn ();
                           print ".\n";
                           raise Error
                           ))
                 l;

                 Regexp.String l
                 )
            | Any =>
                 (case #alphabet ctx of
                     NONE =>
                        (
                        print "Error: no alphabet specified for universal set in ";
                        errfn ();
                        print ".\n";
                        raise Error
                        )
                   | SOME (_, allset) =>
                        Regexp.Set allset)
            | Epsilon =>
                 Regexp.String []
            | Empty =>
                 Regexp.Empty
            | Concat res =>
                 foldr 
                 (fn (re1, re2) => Regexp.Concat (processRegexp errfn ctx re1, re2))
                 Regexp.Epsilon res
            | Union res =>
                 foldr 
                 (fn (re1, re2) => Regexp.Union (processRegexp errfn ctx re1, re2))
                 Regexp.Empty res
            | Option re1 =>
                 Regexp.Option (processRegexp errfn ctx re1)
            | Closure re1 =>
                 Regexp.Closure (processRegexp errfn ctx re1)
            | Plus re1 =>
                 Regexp.Plus (processRegexp errfn ctx re1)
            | Eos =>
                 Regexp.String [~1])


      fun processArm fnname ctx n (re, action) =
          let
             val tp = 
                (case D.find (#actions ctx) action of
                    NONE =>
                       (
                       print "Error: unbound action ";
                       print action;
                       print " in arm ";
                       print (Int.toString n);
                       print " of function ";
                       print fnname;
                       print ".\n";
                       raise Error
                       )
                  | SOME tp =>
                       tp)

             fun errfn () =
                 (
                 print "arm ";
                 print (Int.toString n);
                 print " of function ";
                 print fnname
                 )

             val re' = processRegexp errfn ctx re
          in
             (tp, re', (n, action))
          end


      fun processFunction fnname ctx arms =
          (case arms of
              [] =>
                 (
                 print "Error: no arms in function ";
                 print fnname;
                 print ".\n";
                 raise Error
                 )
            | arm :: rest =>
                 let
                    val (tp : string, re1, action1) = processArm fnname ctx 0 arm

                    val (_, rest') =
                       foldl
                       (fn (arm, (n, acc)) =>
                              let
                                 val (tp', re, action) = processArm fnname ctx n arm

                                 val () =
                                    if tp = tp' then
                                       ()
                                    else
                                       (
                                       print "Error: inconsistent action type in arm ";
                                       print (Int.toString n);
                                       print " of function ";
                                       print fnname;
                                       print ".\n";
                                       raise Error
                                       )
                              in
                                 (n+1, (re, action) :: acc)
                              end)
                       (1, [])
                       rest
                 in
                    (tp, (re1, action1) :: rest')
                 end)


      fun processMain ctx l =
          (case l of
              [] =>
                 ctx
            | directive :: rest =>
                 let
                    val ctx' =
                       (case directive of
                           Name name =>
                              (case (#modulename ctx) of
                                  SOME _ =>
                                     (
                                     print "Error: multiple module names specified.\n";
                                     raise Error
                                     )
                                | NONE =>
                                     modulenameUpdate ctx (SOME name))

                         | Alphabet n =>
                              (case #alphabet ctx of
                                  SOME _ =>
                                     (
                                     print "Error: multiply specified alphabet.\n";
                                     raise Error
                                     )
                                | NONE =>
                                     if n < 1 then
                                        (
                                        print "Error: alphabet too small.\n";
                                        raise Error
                                        )
                                     else if n > symbolLimitMax then
                                        (
                                        print "Error: alphabet too large.\n";
                                        raise Error
                                        )
                                     else
                                        let
                                           fun loop i acc =
                                               if i >= n then
                                                  acc
                                               else
                                                  loop (i+1) (SS.insert acc i)
                                                  
                                           val set = loop 0 SS.empty
                                        in
                                           alphabetUpdate ctx (SOME (n, set))
                                        end)

                         | Type name =>
                              if S.member (#types ctx) name then
                                 (
                                 print "Error: multiply specified type ";
                                 print name;
                                 print ".\n";
                                 raise Error
                                 )
                              else
                                 typesUpdate ctx (S.insert (#types ctx) name)

                         | Action (name, tp) =>
                              if 
                                 D.member (#actions ctx) name
                                 orelse
                                 D.member (#functions ctx) name
                              then
                                 (
                                 print "Error: multiply specified action/function ";
                                 print name;
                                 print ".\n";
                                 raise Error
                                 )
                              else if S.member (#types ctx) tp then
                                 actionsUpdate ctx (D.insert (#actions ctx) name tp)
                              else
                                 (
                                 print "Error: unbound type ";
                                 print tp;
                                 print " in action ";
                                 print name;
                                 print ".\n";
                                 raise Error
                                 )

                         | Function (name, arms) =>
                              if 
                                 D.member (#functions ctx) name
                                 orelse
                                 D.member (#actions ctx) name
                              then
                                 (
                                 print "Error: multiply specified action/function ";
                                 print name;
                                 print ".\n";
                                 raise Error
                                 )
                              else if isSome (#alphabet ctx) then
                                 let
                                    val fnspec = processFunction name ctx arms
                                 in
                                    functionsUpdate ctx (D.insert (#functions ctx) name fnspec)
                                 end
                              else
                                 (
                                 print "Error: no alphabet specified for function ";
                                 print name;
                                 print ".\n";
                                 raise Error
                                 )

                         | Regexp (name, re) =>
                              if D.member (#patterns ctx) name then
                                 (
                                 print "Error: multiply specified regexp/charset ";
                                 print name;
                                 print ".\n";
                                 raise Error
                                 )
                              else if isSome (#alphabet ctx) then
                                 let
                                    fun errfn () =
                                        (
                                        print "regexp ";
                                        print name
                                        )
                                        
                                    val re' = processRegexp errfn ctx re
                                 in
                                    patternsUpdate ctx (D.insert (#patterns ctx) name (RePattern re'))
                                 end
                              else
                                 (
                                 print "Error: no alphabet specified for regexp ";
                                 print name;
                                 print ".\n";
                                 raise Error
                                 )

                         | Set (name, set) =>
                              if D.member (#patterns ctx) name then
                                 (
                                 print "Error: multiply specified regexp/charset ";
                                 print name;
                                 print ".\n";
                                 raise Error
                                 )
                              else if isSome (#alphabet ctx) then
                                 let
                                    val set' = processSet name ctx set
                                 in
                                    patternsUpdate ctx (D.insert (#patterns ctx) name (ReCharset set'))
                                 end
                              else
                                 (
                                 print "Error: no alphabet specified for charset ";
                                 print name;
                                 print ".\n";
                                 raise Error
                                 ))

                 in
                    processMain ctx' rest
                 end)


      fun process l =
          let 
             val ctx =
                { modulename = NONE,
                  types = S.empty,
                  actions = D.empty,
                  functions = D.empty,
                  patterns = D.empty,
                  alphabet = NONE }

             val { modulename, types, actions, functions, alphabet, ... } =
                processMain ctx l

             val modulename' =
                (case modulename of
                    NONE =>
                       (
                       print "Error: no functor name specified.\n";
                       raise Error
                       )
                  | SOME name => name)

             val () =
                if D.isEmpty functions then
                   (
                   print "Error: no functions specified.\n";
                   raise Error
                   )
                else
                   ()

             val types' = S.toList types
             val actions' = D.toList actions

             val symbolLimit =
                (* Since functions is non-empty, we have already checked that an alphabet is specified. *)
                #1 (valOf alphabet)

             val functions' = 
                map
                (fn (name, (tp, arms)) =>
                       let
                          val () = print name
                          val () = print ": "
                          val auto as (states, _, _, _, _, _, _) = MakeAutomaton.makeAutomaton symbolLimit arms
                          val () = print (Int.toString states)
                          val () = print " states\n"

                          val () =
                             if states > stateCountMax then
                                (
                                print "Error: function ";
                                print name;
                                print " has too many states.\n";
                                raise Error
                                )
                             else
                                ()
                       in
                          (name, (tp, auto))
                       end)
                (D.toList functions)

          in
             (modulename', symbolLimit, types', actions', functions')
          end

   end
