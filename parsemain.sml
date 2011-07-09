(*

State 0:

start -> . Directives  / 0
7 : Directive -> . NAME IDENT  / 1
8 : Directive -> . TERMINAL IDENT  / 1
9 : Directive -> . TERMINAL IDENT OF IDENT  / 1
10 : Directive -> . NONTERMINAL IDENT COLON IDENT EQUAL Productions  / 1
11 : Directive -> . START IDENT  / 1
12 : Directives -> .  / 0
13 : Directives -> . Directive Directives  / 0

$ => reduce 12
NAME => shift 1
START => shift 2
TERMINAL => shift 3
NONTERMINAL => shift 6
Directive => goto 4
Directives => goto 5

-----

State 1:

7 : Directive -> NAME . IDENT  / 1

IDENT => shift 7

-----

State 2:

11 : Directive -> START . IDENT  / 1

IDENT => shift 8

-----

State 3:

8 : Directive -> TERMINAL . IDENT  / 1
9 : Directive -> TERMINAL . IDENT OF IDENT  / 1

IDENT => shift 9

-----

State 4:

7 : Directive -> . NAME IDENT  / 1
8 : Directive -> . TERMINAL IDENT  / 1
9 : Directive -> . TERMINAL IDENT OF IDENT  / 1
10 : Directive -> . NONTERMINAL IDENT COLON IDENT EQUAL Productions  / 1
11 : Directive -> . START IDENT  / 1
12 : Directives -> .  / 0
13 : Directives -> . Directive Directives  / 0
13 : Directives -> Directive . Directives  / 0

$ => reduce 12
NAME => shift 1
START => shift 2
TERMINAL => shift 3
NONTERMINAL => shift 6
Directive => goto 4
Directives => goto 10

-----

State 5:

start -> Directives .  / 0

$ => accept

-----

State 6:

10 : Directive -> NONTERMINAL . IDENT COLON IDENT EQUAL Productions  / 1

IDENT => shift 11

-----

State 7:

7 : Directive -> NAME IDENT .  / 1

$ => reduce 7
NAME => reduce 7
START => reduce 7
TERMINAL => reduce 7
NONTERMINAL => reduce 7

-----

State 8:

11 : Directive -> START IDENT .  / 1

$ => reduce 11
NAME => reduce 11
START => reduce 11
TERMINAL => reduce 11
NONTERMINAL => reduce 11

-----

State 9:

8 : Directive -> TERMINAL IDENT .  / 1
9 : Directive -> TERMINAL IDENT . OF IDENT  / 1

$ => reduce 8
NAME => reduce 8
OF => shift 12
START => reduce 8
TERMINAL => reduce 8
NONTERMINAL => reduce 8

-----

State 10:

13 : Directives -> Directive Directives .  / 0

$ => reduce 13

-----

State 11:

10 : Directive -> NONTERMINAL IDENT . COLON IDENT EQUAL Productions  / 1

COLON => shift 13

-----

State 12:

9 : Directive -> TERMINAL IDENT OF . IDENT  / 1

IDENT => shift 14

-----

State 13:

10 : Directive -> NONTERMINAL IDENT COLON . IDENT EQUAL Productions  / 1

IDENT => shift 15

-----

State 14:

9 : Directive -> TERMINAL IDENT OF IDENT .  / 1

$ => reduce 9
NAME => reduce 9
START => reduce 9
TERMINAL => reduce 9
NONTERMINAL => reduce 9

-----

State 15:

10 : Directive -> NONTERMINAL IDENT COLON IDENT . EQUAL Productions  / 1

EQUAL => shift 16

-----

State 16:

0 : Constituent -> . IDENT  / 2
1 : Constituent -> . IDENT COLON IDENT  / 2
2 : Constituent -> . LPAREN Constituent RPAREN  / 2
3 : Constituents -> .  / 3
4 : Constituents -> . Constituent Constituents  / 3
5 : Productions -> .  / 1
6 : Productions -> . Constituents ARROW IDENT Productions  / 1
10 : Directive -> NONTERMINAL IDENT COLON IDENT EQUAL . Productions  / 1

$ => reduce 5
IDENT => shift 17
ARROW => reduce 3
NAME => reduce 5
LPAREN => shift 18
START => reduce 5
TERMINAL => reduce 5
NONTERMINAL => reduce 5
Constituent => goto 19
Constituents => goto 20
Productions => goto 21

-----

State 17:

0 : Constituent -> IDENT .  / 4
1 : Constituent -> IDENT . COLON IDENT  / 4

IDENT => reduce 0
ARROW => reduce 0
COLON => shift 22
LPAREN => reduce 0
RPAREN => reduce 0

-----

State 18:

0 : Constituent -> . IDENT  / 5
1 : Constituent -> . IDENT COLON IDENT  / 5
2 : Constituent -> . LPAREN Constituent RPAREN  / 5
2 : Constituent -> LPAREN . Constituent RPAREN  / 4

IDENT => shift 17
LPAREN => shift 18
Constituent => goto 23

-----

State 19:

0 : Constituent -> . IDENT  / 2
1 : Constituent -> . IDENT COLON IDENT  / 2
2 : Constituent -> . LPAREN Constituent RPAREN  / 2
3 : Constituents -> .  / 3
4 : Constituents -> . Constituent Constituents  / 3
4 : Constituents -> Constituent . Constituents  / 3

IDENT => shift 17
ARROW => reduce 3
LPAREN => shift 18
Constituent => goto 19
Constituents => goto 24

-----

State 20:

6 : Productions -> Constituents . ARROW IDENT Productions  / 1

ARROW => shift 25

-----

State 21:

10 : Directive -> NONTERMINAL IDENT COLON IDENT EQUAL Productions .  / 1

$ => reduce 10
NAME => reduce 10
START => reduce 10
TERMINAL => reduce 10
NONTERMINAL => reduce 10

-----

State 22:

1 : Constituent -> IDENT COLON . IDENT  / 4

IDENT => shift 26

-----

State 23:

2 : Constituent -> LPAREN Constituent . RPAREN  / 4

RPAREN => shift 27

-----

State 24:

4 : Constituents -> Constituent Constituents .  / 3

ARROW => reduce 4

-----

State 25:

6 : Productions -> Constituents ARROW . IDENT Productions  / 1

IDENT => shift 28

-----

State 26:

1 : Constituent -> IDENT COLON IDENT .  / 4

IDENT => reduce 1
ARROW => reduce 1
LPAREN => reduce 1
RPAREN => reduce 1

-----

State 27:

2 : Constituent -> LPAREN Constituent RPAREN .  / 4

IDENT => reduce 2
ARROW => reduce 2
LPAREN => reduce 2
RPAREN => reduce 2

-----

State 28:

0 : Constituent -> . IDENT  / 2
1 : Constituent -> . IDENT COLON IDENT  / 2
2 : Constituent -> . LPAREN Constituent RPAREN  / 2
3 : Constituents -> .  / 3
4 : Constituents -> . Constituent Constituents  / 3
5 : Productions -> .  / 1
6 : Productions -> . Constituents ARROW IDENT Productions  / 1
6 : Productions -> Constituents ARROW IDENT . Productions  / 1

$ => reduce 5
IDENT => shift 17
ARROW => reduce 3
NAME => reduce 5
LPAREN => shift 18
START => reduce 5
TERMINAL => reduce 5
NONTERMINAL => reduce 5
Constituent => goto 19
Constituents => goto 20
Productions => goto 29

-----

State 29:

6 : Productions -> Constituents ARROW IDENT Productions .  / 1

$ => reduce 6
NAME => reduce 6
START => reduce 6
TERMINAL => reduce 6
NONTERMINAL => reduce 6

-----

lookahead 0 = $ 
lookahead 1 = $ NAME START TERMINAL NONTERMINAL 
lookahead 2 = IDENT ARROW LPAREN 
lookahead 3 = ARROW 
lookahead 4 = IDENT ARROW LPAREN RPAREN 
lookahead 5 = RPAREN 

*)

functor ParseMainFun (structure Streamable : STREAMABLE
type symbol
type constituent
type constituents
type productions
type directive
type directives
val unlabeled_item : {ident:symbol} -> constituent
val labeled_item : {label:symbol, ident:symbol} -> constituent
val paren_item : {constituent:constituent} -> constituent
val nil_constituents : {} -> constituents
val cons_constituents : {head:constituent, tail:constituents} -> constituents
val nil_productions : {} -> productions
val cons_productions : {constituents:constituents, action:symbol, tail:productions} -> productions
val name_directive : {ident:symbol} -> directive
val terminal_directive : {ident:symbol} -> directive
val terminalOf_directive : {ident:symbol, tp:symbol} -> directive
val nonterminal_directive : {ident:symbol, tp:symbol, arms:productions} -> directive
val start_directive : {ident:symbol} -> directive
val nil_directives : {} -> directives
val cons_directives : {head:directive, tail:directives} -> directives
datatype terminal =
IDENT of symbol
| ARROW
| COLON
| EQUAL
| NAME
| LPAREN
| OF
| RPAREN
| START
| TERMINAL
| NONTERMINAL
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
IDENT terminal => (1, Value.symbol terminal)
| ARROW => (2, Value.DUMMY)
| COLON => (3, Value.DUMMY)
| EQUAL => (4, Value.DUMMY)
| NAME => (5, Value.DUMMY)
| LPAREN => (6, Value.DUMMY)
| OF => (7, Value.DUMMY)
| RPAREN => (8, Value.DUMMY)
| START => (9, Value.DUMMY)
| TERMINAL => (10, Value.DUMMY)
| NONTERMINAL => (11, Value.DUMMY)
)
)
in
val parse = ParseEngine.parse (
ParseEngine.next5x1 "r\128\128\128\128\130\128\128\128\131\132\135\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128r\128\128\128\128\130\128\128\128\131\132\135\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\127\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128w\128\128\128\128w\128\128\128www\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128s\128\128\128\128s\128\128\128sss\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128v\128\128\128\128v\128\141\128vvv\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128q\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\143\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\144\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128u\128\128\128\128u\128\128\128uuu\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128y\146{\128\128y\147\128\128yyy\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128~~\151\128\128~\128~\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\128\128\128\128\147\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146{\128\128\128\147\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\154\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128t\128\128\128\128t\128\128\128ttt\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128z\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\157\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128}}\128\128\128}\128}\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128||\128\128\128|\128|\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128y\146{\128\128y\147\128\128yyy\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128x\128\128\128\128x\128\128\128xxx\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
ParseEngine.next5x1 "\128\128\128\132\133\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\132\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\148\149\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\151\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\152\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\148\157\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
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
