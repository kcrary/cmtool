(*

lexmain
initial state = 16
total states = 24

-----

lexmain
state 16 (initial, final:error):

9-10 => state 21   (final:skip)
13 => state 21   (final:skip)
32 => state 21   (final:skip)
34 => state 22
38 => state 1   (sink:ampersand)
39 => state 23
40 => state 14   (sink:lparen)
41 => state 5   (sink:rparen)
42 => state 7   (sink:star)
43 => state 2   (sink:plus)
45 => state 9   (sink:minus)
47 => state 20   (final:slash)
48-57 => state 18   (final:number)
58 => state 12   (sink:colon)
61 => state 17   (final:equal)
63 => state 11   (sink:question)
65-90 => state 19   (final:ident)
97-122 => state 19   (final:ident)
124 => state 4   (sink:bar)
126 => state 3   (sink:tilde)
EOS => state 15   (sink:eof)

-----

lexmain
state 17 (final:equal):

62 => state 10   (sink:arrow)

-----

lexmain
state 18 (final:number):

48-57 => state 18   (final:number)

-----

lexmain
state 19 (final:ident):

39 => state 19   (final:ident)
48-57 => state 19   (final:ident)
65-90 => state 19   (final:ident)
95 => state 19   (final:ident)
97-122 => state 19   (final:ident)

-----

lexmain
state 20 (final:slash):

42 => state 13   (sink:lcomment)

-----

lexmain
state 21 (final:skip):

9-10 => state 21   (final:skip)
13 => state 21   (final:skip)
32 => state 21   (final:skip)

-----

lexmain
state 22:

0-33 => state 22
34 => state 8   (sink:string)
35-127 => state 22

-----

lexmain
state 23:

33-126 => state 6   (sink:char)

=====

skipcomment
initial state = 5
total states = 7

-----

skipcomment
state 4 (final:comment_skip):

42 => state 3   (sink:comment_open)

-----

skipcomment
state 5 (initial, final:comment_error):

0-41 => state 1   (sink:comment_skip)
42 => state 6   (final:comment_skip)
43-46 => state 1   (sink:comment_skip)
47 => state 4   (final:comment_skip)
48-127 => state 1   (sink:comment_skip)

-----

skipcomment
state 6 (final:comment_skip):

47 => state 2   (sink:comment_close)

*)

functor LexMainFun (structure Streamable : STREAMABLE
structure Arg : sig
type symbol
val ord : symbol -> int
type t
type u
val ampersand : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val arrow : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val bar : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val char : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val colon : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val comment_close : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> u
val comment_error : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> u
val comment_open : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> u
val comment_skip : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> u
val eof : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val equal : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val error : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val ident : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val lcomment : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val lparen : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val minus : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val number : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val plus : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val question : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val rparen : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val skip : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val slash : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val star : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val string : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
val tilde : { str : symbol list, len : int, start : symbol Streamable.t, follow : symbol Streamable.t, self : {lexmain : symbol Streamable.t -> t, skipcomment : symbol Streamable.t -> u} } -> t
end)
=
struct
local
structure LexEngine = LexEngineFun (structure Streamable = Streamable
type symbol = Arg.symbol
val ord = Arg.ord)
structure Tables = struct
fun error _ = raise (Fail "Illegal lexeme")
val lexmain = (16, 15, 21, Vector.fromList [Arg.ampersand,Arg.plus,Arg.tilde,Arg.bar,Arg.rparen,Arg.char,Arg.star,Arg.string,Arg.minus,Arg.arrow,Arg.question,Arg.colon,Arg.lcomment,Arg.lparen,Arg.eof,Arg.error,Arg.equal,Arg.number,Arg.ident,Arg.slash,Arg.skip], LexEngine.next7x1 128 "\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^U\^U\^@\^@\^U\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^U\^@\^V\^@\^@\^@\^A\^W\^N\^E\a\^B\^@\t\^@\^T\^R\^R\^R\^R\^R\^R\^R\^R\^R\^R\f\^@\^@\^Q\^@\v\^@\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^@\^@\^@\^@\^@\^@\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^@\^D\^@\^C\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\n\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^R\^R\^R\^R\^R\^R\^R\^R\^R\^R\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^S\^@\^@\^@\^@\^@\^@\^@\^@\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^@\^@\^@\^@\^@\^@\^@\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^@\^@\^@\^@\^S\^@\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^S\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\r\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^U\^U\^@\^@\^U\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^U\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\b\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^V\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^F\^@", LexEngine.next0x1 "\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^O\^@\^@\^@\^@\^@\^@\^@")
val skipcomment = (5, 3, 6, Vector.fromList [Arg.comment_skip,Arg.comment_close,Arg.comment_open,Arg.comment_skip,Arg.comment_error,Arg.comment_skip], LexEngine.next7x1 128 "\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^C\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^F\^A\^A\^A\^A\^D\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^A\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^B\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@\^@", LexEngine.next0x1 "\^@\^@\^@\^@\^@\^@\^@")
end
in
fun lexmain s = LexEngine.lex {lexmain=lexmain, skipcomment=skipcomment} Tables.lexmain s
and skipcomment s = LexEngine.lex {lexmain=lexmain, skipcomment=skipcomment} Tables.skipcomment s
end
end
