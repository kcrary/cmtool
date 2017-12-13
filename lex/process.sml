
structure Process
   :> PROCESS
   =
   struct

      (* This number is hardcoded to correspond to tableSizeMinor in codegen.sml. *)
      val symbolLimitMax = 1024

      (* This number is hardcoded to correspond to tableSizeMajor in codegen.sml. *)
      val stateCountMax = 65536


      structure S = StringSet
      structure D = StringDict
      structure SS = SymbolSet

      structure L = Language

      open Syntax

      exception Error

      datatype pattern =
         ReCharset of SymbolSet.set
       | RePattern of Regexp.regexp



      val theName      : string option ref               = ref NONE
      val options      : S.set ref                       = ref S.empty
      val types        : S.set ref                       = ref S.empty
      val actions      : string D.dict ref               = ref D.empty
      val functions    : (string * int * (Regexp.regexp * (int * string)) list) D.dict ref = ref D.empty
      val patterns     : pattern D.dict ref              = ref D.empty
      val alphabet     : (int * SS.set) option ref       = ref NONE


      fun processSet setname set =
          (case set of
              Svar name =>
                 (case D.find (!patterns) name of
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
                 if 0 <= sym andalso sym < #1 (valOf (!alphabet)) then
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
                        else if 0 <= bottom andalso top < #1 (valOf (!alphabet)) then
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
                 (fn (set1, set2) => SS.union (processSet setname set1) set2)
                 SS.empty
                 l
            | Sintersection [] =>
                 #2 (valOf (!alphabet))
            | Sintersection (set :: l) =>
                 foldl
                 (fn (set1, set2) => SS.intersection (processSet setname set1) set2)
                 (processSet setname set)
                 l
            | Sdifference (set, l) =>
                 foldl
                 (fn (set1, set2) => SS.difference set2 (processSet setname set1))
                 (processSet setname set)
                 l
            | Scomplement l =>
                 foldl
                 (fn (set1, set2) => SS.difference set2 (processSet setname set1))
                 (#2 (valOf (!alphabet)))
                 l
            | Sany =>
                 #2 (valOf (!alphabet)))


      fun processRegexp errfn re =
          (case re of
              Var name =>
                 (case D.find (!patterns) name of
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
                 if 0 <= sym andalso sym < #1 (valOf (!alphabet)) then
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
                        if 0 <= sym andalso sym < #1 (valOf (!alphabet)) then
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
                 (case !alphabet of
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
                 (fn (re1, re2) => Regexp.Concat (processRegexp errfn re1, re2))
                 Regexp.Epsilon res
            | Union res =>
                 foldr 
                 (fn (re1, re2) => Regexp.Union (processRegexp errfn re1, re2))
                 Regexp.Empty res
            | Optional re1 =>
                 Regexp.Option (processRegexp errfn re1)
            | Closure re1 =>
                 Regexp.Closure (processRegexp errfn re1)
            | Plus re1 =>
                 Regexp.Plus (processRegexp errfn re1)
            | Exactly (re1, n) =>
                 if n < 0 then
                    (
                    print "Error: illegal repetition specification in ";
                    errfn ();
                    print ".\n";
                    raise Error
                    )
                 else
                    let
                       val re1' = processRegexp errfn re1
   
                       fun loop m =
                          if m = 0 then
                             Regexp.Epsilon
                          else if m = 1 then
                             re1'
                          else
                             Regexp.Concat (re1', loop (m-1))
                    in
                       loop n
                    end
            | AtLeast (re1, n) =>
                 if n < 0 then
                    (
                    print "Error: illegal repetition specification in ";
                    errfn ();
                    print ".\n";
                    raise Error
                    )
                 else
                    let
                       val re1' = processRegexp errfn re1
   
                       fun loop m =
                          if m = 0 then
                             Regexp.Closure re1'
                          else if m = 1 then
                             Regexp.Plus re1'
                          else
                             Regexp.Concat (re1', loop (m-1))
                    in
                       loop n
                    end
            | Repeat (re1, first, last) =>
                 if first < 0 orelse last < first then
                    (
                    print "Error: illegal repetition specification in ";
                    errfn ();
                    print ".\n";
                    raise Error
                    )
                 else
                    let
                       val re1' = processRegexp errfn re1
                    
                       fun loopOpt m =
                          if m = 0 then
                             Regexp.Epsilon
                          else if m = 1 then
                             Regexp.Option re1'
                          else
                             Regexp.Option (Regexp.Concat (re1',
                                                           loopOpt (m-1)))

                       fun loop m =
                          if m = 0 then
                             loopOpt (last-first)
                          else
                             Regexp.Concat (re1', loop (m-1))
                    in
                       loop first
                    end
            | Eos =>
                 Regexp.String [~1])


      fun concatSeparated l separator =
         let
            fun loop l acc =
               (case l of
                   [] => rev acc
                 | h :: t => loop t (h :: "." :: acc))
         in
            (case l of
                [] => ""
              | h :: t =>
                   String.concat (loop t [h]))
         end


      fun processMain lang l =
         (case l of
             [] =>
                ()
           | directive :: rest =>
                (
                (case directive of
                    Name longid =>
                       (case !theName of
                           NONE =>
                              if Language.legalLongid lang longid then
                                 theName := SOME (concatSeparated longid ".")
                              else
                                 (
                                 print "Error: illegal ";
                                 print (L.toString lang);
                                 print " functor name.\n";
                                 raise Error
                                 )

                         | SOME _ =>
                              (
                              print "Error: multiply specified functor name.\n";
                              raise Error
                              ))

                  | Option "monadic" =>
                       (case lang of
                           L.HASKELL =>
                              options := S.insert (!options) "monadic"

                         | _ =>
                              (
                              print "Error: monadic specification only recognized for Haskell lexers.\n";
                              raise Error
                              ))

                  | Option str =>
                       (
                       print "Error: ";
                       print str;
                       print " specification not recognized.\n";
                       raise Error
                       )

                  | Alphabet n =>
                       (case !alphabet of
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
                                    alphabet := SOME (n, set)
                                 end)

                  | Function (name, tp, arms) =>
                       if Language.reserved lang name then
                          (
                          print "Error: reserved ";
                          print (L.toString lang);
                          print " identifier ";
                          print name;
                          print ".\n";
                          raise Error
                          )
                       else if Language.reserved lang tp then
                          (
                          print "Error: reserved ";
                          print (L.toString lang);
                          print " identifier ";
                          print tp;
                          print ".\n";
                          raise Error
                          )
                       else if D.member (!functions) name then
                          (
                          print "Error: multiply specified function ";
                          print name;
                          print ".\n";
                          raise Error
                          )
                       else if not (isSome (!alphabet)) then
                          (
                          print "Error: no alphabet specified for function ";
                          print name;
                          print ".\n";
                          raise Error
                          )
                       else
                          (case arms of
                              [] =>
                                 (
                                 print "Error: no arms in function ";
                                 print name;
                                 print ".\n";
                                 raise Error
                                 )
                            | _ =>
                                 let
                                    val () =
                                       if D.member (!actions) tp then
                                          (
                                          print "Error: type identifer ";
                                          print tp;
                                          print " already used for an action.\n";
                                          raise Error
                                          )
                                       else
                                          types := S.insert (!types) tp

                                    val (armcount, arms') =
                                       foldl
                                       (fn ((re, action), (n, acc)) =>
                                              let
                                                 val () =
                                                    if Language.reserved lang action then
                                                       (
                                                       print "Error: reserved ";
                                                       print (L.toString lang);
                                                       print " identifier ";
                                                       print action;
                                                       print ".\n";
                                                       raise Error
                                                       )
                                                    else
                                                       ()

                                                 val () =
                                                    (case D.find (!actions) action of
                                                        NONE =>
                                                           if S.member (!types) action then
                                                              (
                                                              print "Error: action identifier ";
                                                              print action;
                                                              print " already used for a type.\n";
                                                              raise Error
                                                              )
                                                           else
                                                              actions := D.insert (!actions) action tp
                                                      | SOME tp' =>
                                                           if tp = tp' then
                                                              ()
                                                           else
                                                              (
                                                              print "Error: inconsistent type for action ";
                                                              print action;
                                                              print " in arm ";
                                                              print (Int.toString n);
                                                              print " of function ";
                                                              print name;
                                                              print ".\n";
                                                              raise Error
                                                              ))

                                                 fun errfn () =
                                                    (
                                                    print "arm ";
                                                    print (Int.toString n);
                                                    print " of function ";
                                                    print name
                                                    )

                                                 val re' = processRegexp errfn re
                                              in
                                                 (n+1, (re', (n, action)) :: acc)
                                              end)
                                       (0, [])
                                       arms
                                    in
                                       functions := D.insert (!functions) name (tp, armcount, arms')
                                    end)

                  | Regexp (name, re) =>
                       if D.member (!patterns) name then
                          (
                          print "Error: multiply specified regexp/charset ";
                          print name;
                          print ".\n";
                          raise Error
                          )
                       else if isSome (!alphabet) then
                          let
                             fun errfn () =
                                 (
                                 print "regexp ";
                                 print name
                                 )
                                 
                             val re' = processRegexp errfn re
                          in
                             patterns := D.insert (!patterns) name (RePattern re')
                          end
                       else
                          (
                          print "Error: no alphabet specified for regexp ";
                          print name;
                          print ".\n";
                          raise Error
                          )

                  | Set (name, set) =>
                       if D.member (!patterns) name then
                          (
                          print "Error: multiply specified regexp/charset ";
                          print name;
                          print ".\n";
                          raise Error
                          )
                       else if isSome (!alphabet) then
                          let
                             val set' = processSet name set
                          in
                             patterns := D.insert (!patterns) name (ReCharset set')
                          end
                       else
                          (
                          print "Error: no alphabet specified for charset ";
                          print name;
                          print ".\n";
                          raise Error
                          ));

                processMain lang rest
                ))


      fun process l =
          let 
             val () =
                (
                theName := NONE;
                options := S.empty;
                types := S.empty;
                actions := D.empty;
                functions := D.empty;
                patterns := D.empty;
                alphabet := NONE
                )

             val (lang, l) =
                (case l of
                    Option "sml" :: l' => (L.SML, l')
                  | Option "haskell" :: l' => (L.HASKELL, l')

                  | [] =>
                       (
                       print "Error: empty specification.\n";
                       raise Error
                       )
                    
                  | _ =>
                       (
                       print "Error: language must be specified first.\n";
                       raise Error
                       ))

             val () = processMain lang l

             (* Post-processing *)

             val name =
                (case !theName of
                    SOME name => name
                  | NONE =>
                       (
                       print "Error: no functor name specified.\n";
                       raise Error
                       ))

             val () =
                if D.isEmpty (!functions) then
                   (
                   print "Error: no functions specified.\n";
                   raise Error
                   )
                else
                   ()

             val symbolLimit =
                (* Since functions is non-empty, we have already checked that an alphabet is specified. *)
                #1 (valOf (!alphabet))

             val functions' = 
                map
                (fn (name, (tp, armcount, arms)) =>
                       let
                          val () = print name
                          val () = print ": "
                          val (auto as (states, _, _, _, _, _, _), redundancies, inexhaustive) =
                             MakeAutomaton.makeAutomaton symbolLimit armcount arms

                          val () = print (Int.toString states)
                          val () = print " states\n"

                          val () =
                             app
                             (fn armnumber =>
                                 (
                                 print "Warning: arm ";
                                 print (Int.toString armnumber);
                                 print " of function ";
                                 print name;
                                 print " is redundant.\n"
                                 ))
                             redundancies

                          val () =
                             if inexhaustive then
                                (
                                print "Warning: function ";
                                print name;
                                print " is inexhaustive.\n"
                                )
                             else
                                ()

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
                          (name, tp, auto)
                       end)
                (D.toList (!functions))

             val types' =
                (* S.toList produces these in sorted order. *)
                S.toList (!types)

             val params = { name = name,
                            options = !options }
          in
             (lang, (params, symbolLimit, types', D.toList (!actions), functions'))
          end

   end
