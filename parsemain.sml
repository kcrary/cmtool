(*

State 0:

start -> . Directives  / 0
8 : Directive -> . NAME Ident  / 1
9 : Directive -> . TERMINAL Ident  / 1
10 : Directive -> . TERMINAL Ident OF Ident  / 1
11 : Directive -> . NONTERMINAL Ident COLON Ident EQUAL Productions  / 1
12 : Directive -> . START Ident  / 1
13 : Directives -> .  / 0
14 : Directives -> . Directive Directives  / 0

$ => reduce 13
NAME => shift 1
NONTERMINAL => shift 4
START => shift 5
TERMINAL => shift 6
Directive => goto 2
Directives => goto 3

-----

State 1:

0 : Ident -> . IDENT  / 1
8 : Directive -> NAME . Ident  / 1

IDENT => shift 7
Ident => goto 8

-----

State 2:

8 : Directive -> . NAME Ident  / 1
9 : Directive -> . TERMINAL Ident  / 1
10 : Directive -> . TERMINAL Ident OF Ident  / 1
11 : Directive -> . NONTERMINAL Ident COLON Ident EQUAL Productions  / 1
12 : Directive -> . START Ident  / 1
13 : Directives -> .  / 0
14 : Directives -> . Directive Directives  / 0
14 : Directives -> Directive . Directives  / 0

$ => reduce 13
NAME => shift 1
NONTERMINAL => shift 4
START => shift 5
TERMINAL => shift 6
Directive => goto 2
Directives => goto 9

-----

State 3:

start -> Directives .  / 0

$ => accept

-----

State 4:

0 : Ident -> . IDENT  / 2
11 : Directive -> NONTERMINAL . Ident COLON Ident EQUAL Productions  / 1

IDENT => shift 7
Ident => goto 10

-----

State 5:

0 : Ident -> . IDENT  / 1
12 : Directive -> START . Ident  / 1

IDENT => shift 7
Ident => goto 11

-----

State 6:

0 : Ident -> . IDENT  / 3
9 : Directive -> TERMINAL . Ident  / 1
10 : Directive -> TERMINAL . Ident OF Ident  / 1

IDENT => shift 7
Ident => goto 12

-----

State 7:

0 : Ident -> IDENT .  / 4

$ => reduce 0
IDENT => reduce 0
ARROW => reduce 0
COLON => reduce 0
EQUAL => reduce 0
LPAREN => reduce 0
NAME => reduce 0
RPAREN => reduce 0
NONTERMINAL => reduce 0
OF => reduce 0
START => reduce 0
TERMINAL => reduce 0

-----

State 8:

8 : Directive -> NAME Ident .  / 1

$ => reduce 8
NAME => reduce 8
NONTERMINAL => reduce 8
START => reduce 8
TERMINAL => reduce 8

-----

State 9:

14 : Directives -> Directive Directives .  / 0

$ => reduce 14

-----

State 10:

11 : Directive -> NONTERMINAL Ident . COLON Ident EQUAL Productions  / 1

COLON => shift 13

-----

State 11:

12 : Directive -> START Ident .  / 1

$ => reduce 12
NAME => reduce 12
NONTERMINAL => reduce 12
START => reduce 12
TERMINAL => reduce 12

-----

State 12:

9 : Directive -> TERMINAL Ident .  / 1
10 : Directive -> TERMINAL Ident . OF Ident  / 1

$ => reduce 9
NAME => reduce 9
NONTERMINAL => reduce 9
OF => shift 14
START => reduce 9
TERMINAL => reduce 9

-----

State 13:

0 : Ident -> . IDENT  / 5
11 : Directive -> NONTERMINAL Ident COLON . Ident EQUAL Productions  / 1

IDENT => shift 7
Ident => goto 15

-----

State 14:

0 : Ident -> . IDENT  / 1
10 : Directive -> TERMINAL Ident OF . Ident  / 1

IDENT => shift 7
Ident => goto 16

-----

State 15:

11 : Directive -> NONTERMINAL Ident COLON Ident . EQUAL Productions  / 1

EQUAL => shift 17

-----

State 16:

10 : Directive -> TERMINAL Ident OF Ident .  / 1

$ => reduce 10
NAME => reduce 10
NONTERMINAL => reduce 10
START => reduce 10
TERMINAL => reduce 10

-----

State 17:

0 : Ident -> . IDENT  / 6
1 : Constituent -> . Ident  / 7
2 : Constituent -> . Ident COLON Ident  / 7
3 : Constituent -> . LPAREN Constituent RPAREN  / 7
4 : Constituents -> .  / 8
5 : Constituents -> . Constituent Constituents  / 8
6 : Productions -> .  / 1
7 : Productions -> . Constituents ARROW Ident Productions  / 1
11 : Directive -> NONTERMINAL Ident COLON Ident EQUAL . Productions  / 1

$ => reduce 6
IDENT => shift 7
ARROW => reduce 4
LPAREN => shift 18
NAME => reduce 6
NONTERMINAL => reduce 6
START => reduce 6
TERMINAL => reduce 6
Ident => goto 19
Constituent => goto 20
Constituents => goto 21
Productions => goto 22

-----

State 18:

0 : Ident -> . IDENT  / 9
1 : Constituent -> . Ident  / 10
2 : Constituent -> . Ident COLON Ident  / 10
3 : Constituent -> . LPAREN Constituent RPAREN  / 10
3 : Constituent -> LPAREN . Constituent RPAREN  / 11

IDENT => shift 7
LPAREN => shift 18
Ident => goto 19
Constituent => goto 23

-----

State 19:

1 : Constituent -> Ident .  / 11
2 : Constituent -> Ident . COLON Ident  / 11

IDENT => reduce 1
ARROW => reduce 1
COLON => shift 24
LPAREN => reduce 1
RPAREN => reduce 1

-----

State 20:

0 : Ident -> . IDENT  / 6
1 : Constituent -> . Ident  / 7
2 : Constituent -> . Ident COLON Ident  / 7
3 : Constituent -> . LPAREN Constituent RPAREN  / 7
4 : Constituents -> .  / 8
5 : Constituents -> . Constituent Constituents  / 8
5 : Constituents -> Constituent . Constituents  / 8

IDENT => shift 7
ARROW => reduce 4
LPAREN => shift 18
Ident => goto 19
Constituent => goto 20
Constituents => goto 25

-----

State 21:

7 : Productions -> Constituents . ARROW Ident Productions  / 1

ARROW => shift 26

-----

State 22:

11 : Directive -> NONTERMINAL Ident COLON Ident EQUAL Productions .  / 1

$ => reduce 11
NAME => reduce 11
NONTERMINAL => reduce 11
START => reduce 11
TERMINAL => reduce 11

-----

State 23:

3 : Constituent -> LPAREN Constituent . RPAREN  / 11

RPAREN => shift 27

-----

State 24:

0 : Ident -> . IDENT  / 11
2 : Constituent -> Ident COLON . Ident  / 11

IDENT => shift 7
Ident => goto 28

-----

State 25:

5 : Constituents -> Constituent Constituents .  / 8

ARROW => reduce 5

-----

State 26:

0 : Ident -> . IDENT  / 12
7 : Productions -> Constituents ARROW . Ident Productions  / 1

IDENT => shift 7
Ident => goto 29

-----

State 27:

3 : Constituent -> LPAREN Constituent RPAREN .  / 11

IDENT => reduce 3
ARROW => reduce 3
LPAREN => reduce 3
RPAREN => reduce 3

-----

State 28:

2 : Constituent -> Ident COLON Ident .  / 11

IDENT => reduce 2
ARROW => reduce 2
LPAREN => reduce 2
RPAREN => reduce 2

-----

State 29:

0 : Ident -> . IDENT  / 6
1 : Constituent -> . Ident  / 7
2 : Constituent -> . Ident COLON Ident  / 7
3 : Constituent -> . LPAREN Constituent RPAREN  / 7
4 : Constituents -> .  / 8
5 : Constituents -> . Constituent Constituents  / 8
6 : Productions -> .  / 1
7 : Productions -> . Constituents ARROW Ident Productions  / 1
7 : Productions -> Constituents ARROW Ident . Productions  / 1

$ => reduce 6
IDENT => shift 7
ARROW => reduce 4
LPAREN => shift 18
NAME => reduce 6
NONTERMINAL => reduce 6
START => reduce 6
TERMINAL => reduce 6
Ident => goto 19
Constituent => goto 20
Constituents => goto 21
Productions => goto 30

-----

State 30:

7 : Productions -> Constituents ARROW Ident Productions .  / 1

$ => reduce 7
NAME => reduce 7
NONTERMINAL => reduce 7
START => reduce 7
TERMINAL => reduce 7

-----

lookahead 0 = $ 
lookahead 1 = $ NAME NONTERMINAL START TERMINAL 
lookahead 2 = COLON 
lookahead 3 = $ NAME NONTERMINAL OF START TERMINAL 
lookahead 4 = $ IDENT ARROW COLON EQUAL LPAREN NAME RPAREN NONTERMINAL OF START TERMINAL 
lookahead 5 = EQUAL 
lookahead 6 = IDENT ARROW COLON LPAREN 
lookahead 7 = IDENT ARROW LPAREN 
lookahead 8 = ARROW 
lookahead 9 = COLON RPAREN 
lookahead 10 = RPAREN 
lookahead 11 = IDENT ARROW LPAREN RPAREN 
lookahead 12 = $ IDENT ARROW LPAREN NAME NONTERMINAL START TERMINAL 

*)

functor ParseMainFun (structure Streamable : STREAMABLE
structure Arg : sig
type pos
type directive
type directives
type pos_symbol
type constituent
type constituents
type productions
type symbol
val ident : {ident:pos_symbol} -> symbol
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
IDENT of pos_symbol
| ARROW of pos
| COLON of pos
| EQUAL of pos
| LPAREN of pos
| NAME of pos
| RPAREN of pos
| NONTERMINAL of pos
| OF of pos
| START of pos
| TERMINAL of pos
val error : terminal Streamable.t -> exn
end)
=
struct
local
structure Value = struct
datatype nonterminal =
nonterminal
| pos of Arg.pos
| directive of Arg.directive
| directives of Arg.directives
| pos_symbol of Arg.pos_symbol
| constituent of Arg.constituent
| constituents of Arg.constituents
| productions of Arg.productions
| symbol of Arg.symbol
end
structure ParseEngine = ParseEngineFun (structure Streamable = Streamable
type terminal = Arg.terminal
type value = Value.nonterminal
val dummy = Value.nonterminal
fun read terminal =
(case terminal of
Arg.IDENT x => (1, Value.pos_symbol x)
| Arg.ARROW x => (2, Value.pos x)
| Arg.COLON x => (3, Value.pos x)
| Arg.EQUAL x => (4, Value.pos x)
| Arg.LPAREN x => (5, Value.pos x)
| Arg.NAME x => (6, Value.pos x)
| Arg.RPAREN x => (7, Value.pos x)
| Arg.NONTERMINAL x => (8, Value.pos x)
| Arg.OF x => (9, Value.pos x)
| Arg.START x => (10, Value.pos x)
| Arg.TERMINAL x => (11, Value.pos x)
)
)
in
val parse = ParseEngine.parse (
ParseEngine.next5x1 "q\128\128\128\128\128\130\128\133\128\134\135\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128q\128\128\128\128\128\130\128\133\128\134\135\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\127\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128~~~~~~~~~~~~\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128v\128\128\128\128\128v\128v\128vv\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128p\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128r\128\128\128\128\128r\128r\128rr\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128u\128\128\128\128\128u\128u\143uu\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128t\128\128\128\128\128t\128t\128tt\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128x\136z\128\128\147x\128x\128xx\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\147\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128}}\153\128}\128}\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136z\128\128\147\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128s\128\128\128\128\128s\128s\128ss\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128y\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128{{\128\128{\128{\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128||\128\128|\128|\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128x\136z\128\128\147x\128x\128xx\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128w\128\128\128\128\128w\128w\128ww\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
ParseEngine.next5x1 "\128\130\131\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\130\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\143\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\144\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\128\128\148\149\150\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\128\128\151\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\128\128\148\153\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\157\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\128\128\148\149\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
Vector.fromList [(0,1,(fn Value.pos_symbol(arg0)::rest => Value.symbol(Arg.ident {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(3,1,(fn Value.symbol(arg0)::rest => Value.constituent(Arg.unlabeled_item {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(3,3,(fn Value.symbol(arg0)::_::Value.symbol(arg1)::rest => Value.constituent(Arg.labeled_item {ident=arg0,label=arg1})::rest|_=>raise (Fail "bad parser"))),
(3,3,(fn _::Value.constituent(arg0)::_::rest => Value.constituent(Arg.paren_item {constituent=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,0,(fn rest => Value.constituents(Arg.nil_constituents {})::rest)),
(4,2,(fn Value.constituents(arg0)::Value.constituent(arg1)::rest => Value.constituents(Arg.cons_constituents {tail=arg0,head=arg1})::rest|_=>raise (Fail "bad parser"))),
(5,0,(fn rest => Value.productions(Arg.nil_productions {})::rest)),
(5,4,(fn Value.productions(arg0)::Value.symbol(arg1)::_::Value.constituents(arg2)::rest => Value.productions(Arg.cons_productions {tail=arg0,action=arg1,constituents=arg2})::rest|_=>raise (Fail "bad parser"))),
(1,2,(fn Value.symbol(arg0)::_::rest => Value.directive(Arg.name_directive {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(1,2,(fn Value.symbol(arg0)::_::rest => Value.directive(Arg.terminal_directive {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(1,4,(fn Value.symbol(arg0)::_::Value.symbol(arg1)::_::rest => Value.directive(Arg.terminalOf_directive {tp=arg0,ident=arg1})::rest|_=>raise (Fail "bad parser"))),
(1,6,(fn Value.productions(arg0)::_::Value.symbol(arg1)::_::Value.symbol(arg2)::_::rest => Value.directive(Arg.nonterminal_directive {arms=arg0,tp=arg1,ident=arg2})::rest|_=>raise (Fail "bad parser"))),
(1,2,(fn Value.symbol(arg0)::_::rest => Value.directive(Arg.start_directive {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(2,0,(fn rest => Value.directives(Arg.nil_directives {})::rest)),
(2,2,(fn Value.directives(arg0)::Value.directive(arg1)::rest => Value.directives(Arg.cons_directives {tail=arg0,head=arg1})::rest|_=>raise (Fail "bad parser")))],
(fn Value.directives x => x | _ => raise (Fail "bad parser")), Arg.error)
end
end
