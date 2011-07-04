(*

State 0:

start -> . DIRECTIVES  / 0
7 : DIRECTIVE -> . Name Ident  / 1
8 : DIRECTIVE -> . Terminal Ident  / 1
9 : DIRECTIVE -> . Terminal Ident Of Ident  / 1
10 : DIRECTIVE -> . Nonterminal Ident Colon Ident Equal PRODUCTIONS  / 1
11 : DIRECTIVE -> . Start Ident  / 1
12 : DIRECTIVES -> .  / 0
13 : DIRECTIVES -> . DIRECTIVE DIRECTIVES  / 0

$ => reduce 12
Name => shift 1
Nonterminal => shift 2
Start => shift 3
Terminal => shift 4
DIRECTIVE => goto 5
DIRECTIVES => goto 6

-----

State 1:

7 : DIRECTIVE -> Name . Ident  / 1

Ident => shift 7

-----

State 2:

10 : DIRECTIVE -> Nonterminal . Ident Colon Ident Equal PRODUCTIONS  / 1

Ident => shift 8

-----

State 3:

11 : DIRECTIVE -> Start . Ident  / 1

Ident => shift 9

-----

State 4:

8 : DIRECTIVE -> Terminal . Ident  / 1
9 : DIRECTIVE -> Terminal . Ident Of Ident  / 1

Ident => shift 10

-----

State 5:

7 : DIRECTIVE -> . Name Ident  / 1
8 : DIRECTIVE -> . Terminal Ident  / 1
9 : DIRECTIVE -> . Terminal Ident Of Ident  / 1
10 : DIRECTIVE -> . Nonterminal Ident Colon Ident Equal PRODUCTIONS  / 1
11 : DIRECTIVE -> . Start Ident  / 1
12 : DIRECTIVES -> .  / 0
13 : DIRECTIVES -> . DIRECTIVE DIRECTIVES  / 0
13 : DIRECTIVES -> DIRECTIVE . DIRECTIVES  / 0

$ => reduce 12
Name => shift 1
Nonterminal => shift 2
Start => shift 3
Terminal => shift 4
DIRECTIVE => goto 5
DIRECTIVES => goto 11

-----

State 6:

start -> DIRECTIVES .  / 0

$ => accept

-----

State 7:

7 : DIRECTIVE -> Name Ident .  / 1

$ => reduce 7
Name => reduce 7
Nonterminal => reduce 7
Start => reduce 7
Terminal => reduce 7

-----

State 8:

10 : DIRECTIVE -> Nonterminal Ident . Colon Ident Equal PRODUCTIONS  / 1

Colon => shift 12

-----

State 9:

11 : DIRECTIVE -> Start Ident .  / 1

$ => reduce 11
Name => reduce 11
Nonterminal => reduce 11
Start => reduce 11
Terminal => reduce 11

-----

State 10:

8 : DIRECTIVE -> Terminal Ident .  / 1
9 : DIRECTIVE -> Terminal Ident . Of Ident  / 1

$ => reduce 8
Name => reduce 8
Nonterminal => reduce 8
Of => shift 13
Start => reduce 8
Terminal => reduce 8

-----

State 11:

13 : DIRECTIVES -> DIRECTIVE DIRECTIVES .  / 0

$ => reduce 13

-----

State 12:

10 : DIRECTIVE -> Nonterminal Ident Colon . Ident Equal PRODUCTIONS  / 1

Ident => shift 14

-----

State 13:

9 : DIRECTIVE -> Terminal Ident Of . Ident  / 1

Ident => shift 15

-----

State 14:

10 : DIRECTIVE -> Nonterminal Ident Colon Ident . Equal PRODUCTIONS  / 1

Equal => shift 16

-----

State 15:

9 : DIRECTIVE -> Terminal Ident Of Ident .  / 1

$ => reduce 9
Name => reduce 9
Nonterminal => reduce 9
Start => reduce 9
Terminal => reduce 9

-----

State 16:

0 : CONSTITUENT -> . Ident  / 2
1 : CONSTITUENT -> . Ident Colon Ident  / 2
2 : CONSTITUENT -> . LParen CONSTITUENT RParen  / 2
3 : CONSTITUENTS -> .  / 3
4 : CONSTITUENTS -> . CONSTITUENT CONSTITUENTS  / 3
5 : PRODUCTIONS -> .  / 1
6 : PRODUCTIONS -> . CONSTITUENTS Arrow Ident PRODUCTIONS  / 1
10 : DIRECTIVE -> Nonterminal Ident Colon Ident Equal . PRODUCTIONS  / 1

$ => reduce 5
Ident => shift 17
Arrow => reduce 3
Name => reduce 5
Nonterminal => reduce 5
LParen => shift 18
Start => reduce 5
Terminal => reduce 5
CONSTITUENT => goto 19
CONSTITUENTS => goto 20
PRODUCTIONS => goto 21

-----

State 17:

0 : CONSTITUENT -> Ident .  / 4
1 : CONSTITUENT -> Ident . Colon Ident  / 4

Ident => reduce 0
Arrow => reduce 0
Colon => shift 22
LParen => reduce 0
RParen => reduce 0

-----

State 18:

0 : CONSTITUENT -> . Ident  / 5
1 : CONSTITUENT -> . Ident Colon Ident  / 5
2 : CONSTITUENT -> . LParen CONSTITUENT RParen  / 5
2 : CONSTITUENT -> LParen . CONSTITUENT RParen  / 4

Ident => shift 17
LParen => shift 18
CONSTITUENT => goto 23

-----

State 19:

0 : CONSTITUENT -> . Ident  / 2
1 : CONSTITUENT -> . Ident Colon Ident  / 2
2 : CONSTITUENT -> . LParen CONSTITUENT RParen  / 2
3 : CONSTITUENTS -> .  / 3
4 : CONSTITUENTS -> . CONSTITUENT CONSTITUENTS  / 3
4 : CONSTITUENTS -> CONSTITUENT . CONSTITUENTS  / 3

Ident => shift 17
Arrow => reduce 3
LParen => shift 18
CONSTITUENT => goto 19
CONSTITUENTS => goto 24

-----

State 20:

6 : PRODUCTIONS -> CONSTITUENTS . Arrow Iituent constituents  / 3
4 : productions -> .  / 1
5 : productions -> . constituents Arrow Ident productions  / 1
5 : productions -> constituents Arrow Ident . productions  / 1

$ => reduce 4
Ident => shift 14
Arrow => reduce 2
Name => reduce 4
Nonterminal => reduce 4
Terminal => reduce 4
Type => reduce 4
constituent => goto 15
constituents => goto 16
productions => goto 24

-----

State 24:

5 : productions -> constituents Arrow Ident productions .  / 1

$ => reduce 5
Name => reduce 5
Nonterminal => reduce 5
Terminal => reduce 5
Type => reduce 5

-----

lookahead 0 = $ 
lookahead 1 = $ Name Nonterminal Terminal Type 
lookahead 2 = Ident Arrow 
lookahead 3 = Arrow 

*)

functor ParseMainFun (structure Streamable : STREAMABLE
type string
type int
type constituent
type constituents
type productions
type directive
type directives
val unlabeled_item : {ident:string} -> constituent
val labeled_item : {label:string, ident:string} -> constituent
val nil_constituents : {} -> constituents
val cons_constituents : {head:constituent, tail:constituents} -> constituents
val nil_productions : {} -> productions
val cons_productions : {constituents:constituents, action:string, tail:productions} -> productions
val name_directive : {ident:string} -> directive
val type_directive : {ident:string} -> directive
val terminal_directive : {ident:string} -> directive
val terminalOf_directive : {ident:string, tp:string} -> directive
val nonterminal_directive : {ident:string, arms:productions} -> directive
val nil_directives : {} -> directives
val cons_directives : {head:directive, tail:directives} -> directives
datatype terminal =
Ident of string
| Number of int
| Arrow
| Colon
| Eos
| Equal
| Name
| Nonterminal
| LParen
| Of
| RParen
| Terminal
| Type
val error : terminal Streamable.t -> exn
)
=
struct
local
structure Value = struct
datatype nonterminal =
DUMMY
| string of string
| int of int
| constituent of constituent
| constituents of constituents
| productions of productions
| directive of directive
| directives of directives
end
structure ParseEngine = ParseEngineFun (structure Streamable = Streamable
type terminal = terminal
type value = Value.nonterminal
val dummy = Value.DUMMY
fun read terminal =
(case terminal of
Ident terminal => (1, Value.string terminal)
| Number terminal => (2, Value.int terminal)
| Arrow => (3, Value.DUMMY)
| Colon => (4, Value.DUMMY)
| Eos => (5, Value.DUMMY)
| Equal => (6, Value.DUMMY)
| Name => (7, Value.DUMMY)
| Nonterminal => (8, Value.DUMMY)
| LParen => (9, Value.DUMMY)
| Of => (10, Value.DUMMY)
| RParen => (11, Value.DUMMY)
| Terminal => (12, Value.DUMMY)
| Type => (13, Value.DUMMY)
)
)
in
val parse = ParseEngine.parse (ParseEngine.next5x1 "ective : {ident:symbol} -> directive
val nil_directives : {} -> directives
val cons_directives : {head:directive, tail:directives} -> directives
datatype terminal =
Ident of symbol
| Arrow
| Colon
| Equal
| Name
| Nonterminal
| LParen
| Of
| RParen
| Start
| Terminal
val error : terminal Streamable.t -> exn
)
=
struct
local
structure Value = struct
datatype nonterminal =
DUMMY
| symbol of symbol
| constituent of constituent
| constituents of constituents
| productions of productions
| directive of directive
| directives of directives
end
structure ParseEngine = ParseEngineFun (structure Streamable = Streamable
type terminal = terminal
type value = Value.nonterminal
val dummy = Value.DUMMY
fun read terminal =
(case terminal of
Ident terminal => (1, Value.symbol terminal)
| Arrow => (2, Value.DUMMY)
| Colon => (3, Value.DUMMY)
| Equal => (4, Value.DUMMY)
| Name => (5, Value.DUMMY)
| Nonterminal => (6, Value.DUMMY)
| LParen => (7, Value.DUMMY)
| Of => (8, Value.DUMMY)
| RParen => (9, Value.DUMMY)
| Start => (10, Value.DUMMY)
| Terminal => (11, Value.DUMMY)
)
)
in
val parse = ParseEngine.parse (
ParseEngine.next5x1 "r\128\128\128\128\130\131\128\128\128\132\133\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128r\128\128\128\128\130\131\128\128\128\132\133\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\127\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128w\128\128\128\128ww\128\128\128ww\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\141\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128s\128\128\128\128ss\128\128\128ss\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128v\128\128\128\128vv\128\142\128vv\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128q\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\143\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\144\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128u\128\128\128\128uu\128\128\128uu\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128y\146{\128\128yy\147\128\128yy\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128~~\151\128\128\128~\128~\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\128\128\128\128\128\147\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146{\128\128\128\128\147\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\154\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128t\128\128\128\128tt\128\128\128tt\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128z\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\157\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128}}\128\128\128\128}\128}\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128||\128\128\128\128|\128|\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128y\146{\128\128yy\147\128\128yy\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128x\128\128\128\128xx\128\128\128xx\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
ParseEngine.next5x1 "\128\128\128\133\134\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\133\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\148\149\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\151\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\152\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\148\157\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
Vector.fromList [(0,1,(fn Value.symbol(ident)::start => Value.constituent(unlabeled_item {ident=ident})::start|_=>raise (Fail "bad parser"))),
(0,3,(fn Value.symbol(ident)::_::Value.symbol(label)::start => Value.constituent(labeled_item {label=label,ident=ident})::start|_=>raise (Fail "bad parser"))),
(0,3,(fn _::Value.constituent(constituent)::_::start => Value.constituent(paren_item {constituent=constituent})::start|_=>raise (Fail "bad parser"))),
(1,0,(fn start => Value.constituents(nil_constituents {})::start)),
(1,2,(fn Value.constituents(tail)::Value.constituent(head)::start => Value.constituents(cons_constituents {head=head,tail=tail})::start|_=>raise (Fail "bad parser"))),
(2,0,(fn start => Value.productions(nil_productions {})::start)),
(2,4,(fn Value.productions(tail)::Value.symbol(action)::_::Value.constituents(constituents)::start => Value.productions(cons_productions {constituents=constituents,action=action,tail=tail})::start|_=>raise (Fail "bad parser"))),
(3,2,(fn Value.symbol(ident)::_::start => Value.directive(name_directive {ident=ident})::start|_=>raise (Fail "bad parser"))),
(3,2,(fn Value.symbol(ident)::_::start => Value.directive(terminal_directive {ident=ident})::start|_=>raise (Fail "bad parser"))),
(3,4,(fn Value.symbol(tp)::_::Value.symbol(ident)::_::start => Value.directive(terminalOf_directive {ident=ident,tp=tp})::start|_=>raise (Fail "bad parser"))),
(3,6,(fn Value.productions(arms)::_::Value.symbol(tp)::_::Value.symbol(ident)::_::start => Value.directive(nonterminal_directive {ident=ident,tp=tp,arms=arms})::start|_=>raise (Fail "bad parser"))),
(3,2,(fn Value.symbol(ident)::_::start => Value.directive(start_directive {ident=ident})::start|_=>raise (Fail "bad parser"))),
(4,0,(fn start => Value.directives(nil_directives {})::start)),
(4,2,(fn Value.directives(tail)::Value.directive(head)::start => Value.directives(cons_directives {head=head,tail=tail})::start|_=>raise (Fail "bad parser")))],
(fn Value.directives start => start | _ => raise (Fail "bad parser")), error)
end
end
