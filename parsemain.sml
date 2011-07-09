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
START => shift 2
TERMINAL => shift 3
NONTERMINAL => shift 6
Directive => goto 4
Directives => goto 5

-----

State 1:

0 : Ident -> . IDENT  / 1
8 : Directive -> NAME . Ident  / 1

IDENT => shift 8
Ident => goto 7

-----

State 2:

0 : Ident -> . IDENT  / 1
12 : Directive -> START . Ident  / 1

IDENT => shift 8
Ident => goto 9

-----

State 3:

0 : Ident -> . IDENT  / 2
9 : Directive -> TERMINAL . Ident  / 1
10 : Directive -> TERMINAL . Ident OF Ident  / 1

IDENT => shift 8
Ident => goto 10

-----

State 4:

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
START => shift 2
TERMINAL => shift 3
NONTERMINAL => shift 6
Directive => goto 4
Directives => goto 11

-----

State 5:

start -> Directives .  / 0

$ => accept

-----

State 6:

0 : Ident -> . IDENT  / 3
11 : Directive -> NONTERMINAL . Ident COLON Ident EQUAL Productions  / 1

IDENT => shift 8
Ident => goto 12

-----

State 7:

8 : Directive -> NAME Ident .  / 1

$ => reduce 8
NAME => reduce 8
START => reduce 8
TERMINAL => reduce 8
NONTERMINAL => reduce 8

-----

State 8:

0 : Ident -> IDENT .  / 4

$ => reduce 0
IDENT => reduce 0
ARROW => reduce 0
COLON => reduce 0
EQUAL => reduce 0
NAME => reduce 0
LPAREN => reduce 0
OF => reduce 0
RPAREN => reduce 0
START => reduce 0
TERMINAL => reduce 0
NONTERMINAL => reduce 0

-----

State 9:

12 : Directive -> START Ident .  / 1

$ => reduce 12
NAME => reduce 12
START => reduce 12
TERMINAL => reduce 12
NONTERMINAL => reduce 12

-----

State 10:

9 : Directive -> TERMINAL Ident .  / 1
10 : Directive -> TERMINAL Ident . OF Ident  / 1

$ => reduce 9
NAME => reduce 9
OF => shift 13
START => reduce 9
TERMINAL => reduce 9
NONTERMINAL => reduce 9

-----

State 11:

14 : Directives -> Directive Directives .  / 0

$ => reduce 14

-----

State 12:

11 : Directive -> NONTERMINAL Ident . COLON Ident EQUAL Productions  / 1

COLON => shift 14

-----

State 13:

0 : Ident -> . IDENT  / 1
10 : Directive -> TERMINAL Ident OF . Ident  / 1

IDENT => shift 8
Ident => goto 15

-----

State 14:

0 : Ident -> . IDENT  / 5
11 : Directive -> NONTERMINAL Ident COLON . Ident EQUAL Productions  / 1

IDENT => shift 8
Ident => goto 16

-----

State 15:

10 : Directive -> TERMINAL Ident OF Ident .  / 1

$ => reduce 10
NAME => reduce 10
START => reduce 10
TERMINAL => reduce 10
NONTERMINAL => reduce 10

-----

State 16:

11 : Directive -> NONTERMINAL Ident COLON Ident . EQUAL Productions  / 1

EQUAL => shift 17

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
IDENT => shift 8
ARROW => reduce 4
NAME => reduce 6
LPAREN => shift 19
START => reduce 6
TERMINAL => reduce 6
NONTERMINAL => reduce 6
Ident => goto 18
Constituent => goto 20
Constituents => goto 21
Productions => goto 22

-----

State 18:

1 : Constituent -> Ident .  / 9
2 : Constituent -> Ident . COLON Ident  / 9

IDENT => reduce 1
ARROW => reduce 1
COLON => shift 23
LPAREN => reduce 1
RPAREN => reduce 1

-----

State 19:

0 : Ident -> . IDENT  / 10
1 : Constituent -> . Ident  / 11
2 : Constituent -> . Ident COLON Ident  / 11
3 : Constituent -> . LPAREN Constituent RPAREN  / 11
3 : Constituent -> LPAREN . Constituent RPAREN  / 9

IDENT => shift 8
LPAREN => shift 19
Ident => goto 18
Constituent => goto 24

-----

State 20:

0 : Ident -> . IDENT  / 6
1 : Constituent -> . Ident  / 7
2 : Constituent -> . Ident COLON Ident  / 7
3 : Constituent -> . LPAREN Constituent RPAREN  / 7
4 : Constituents -> .  / 8
5 : Constituents -> . Constituent Constituents  / 8
5 : Constituents -> Constituent . Constituents  / 8

IDENT => shift 8
ARROW => reduce 4
LPAREN => shift 19
Ident => goto 18
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
START => reduce 11
TERMINAL => reduce 11
NONTERMINAL => reduce 11

-----

State 23:

0 : Ident -> . IDENT  / 9
2 : Constituent -> Ident COLON . Ident  / 9

IDENT => shift 8
Ident => goto 27

-----

State 24:

3 : Constituent -> LPAREN Constituent . RPAREN  / 9

RPAREN => shift 28

-----

State 25:

5 : Constituents -> Constituent Constituents .  / 8

ARROW => reduce 5

-----

State 26:

0 : Ident -> . IDENT  / 12
7 : Productions -> Constituents ARROW . Ident Productions  / 1

IDENT => shift 8
Ident => goto 29

-----

State 27:

2 : Constituent -> Ident COLON Ident .  / 9

IDENT => reduce 2
ARROW => reduce 2
LPAREN => reduce 2
RPAREN => reduce 2

-----

State 28:

3 : Constituent -> LPAREN Constituent RPAREN .  / 9

IDENT => reduce 3
ARROW => reduce 3
LPAREN => reduce 3
RPAREN => reduce 3

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
IDENT => shift 8
ARROW => reduce 4
NAME => reduce 6
LPAREN => shift 19
START => reduce 6
TERMINAL => reduce 6
NONTERMINAL => reduce 6
Ident => goto 18
Constituent => goto 20
Constituents => goto 21
Productions => goto 30

-----

State 30:

7 : Productions -> Constituents ARROW Ident Productions .  / 1

$ => reduce 7
NAME => reduce 7
START => reduce 7
TERMINAL => reduce 7
NONTERMINAL => reduce 7

-----

lookahead 0 = $ 
lookahead 1 = $ NAME START TERMINAL NONTERMINAL 
lookahead 2 = $ NAME OF START TERMINAL NONTERMINAL 
lookahead 3 = COLON 
lookahead 4 = $ IDENT ARROW COLON EQUAL NAME LPAREN OF RPAREN START TERMINAL NONTERMINAL 
lookahead 5 = EQUAL 
lookahead 6 = IDENT ARROW COLON LPAREN 
lookahead 7 = IDENT ARROW LPAREN 
lookahead 8 = ARROW 
lookahead 9 = IDENT ARROW LPAREN RPAREN 
lookahead 10 = COLON RPAREN 
lookahead 11 = RPAREN 
lookahead 12 = $ IDENT ARROW NAME LPAREN START TERMINAL NONTERMINAL 

*)

functor ParseMainFun (structure Streamable : STREAMABLE
structure Arg : sig
type constituent
type ident
type constituents
type productions
type directive
type directives
type pos_symbol
type pos
val ident : {ident:pos_symbol} -> ident
val unlabeled_item : {ident:ident} -> constituent
val labeled_item : {label:ident, ident:ident} -> constituent
val paren_item : {constituent:constituent} -> constituent
val nil_constituents : {} -> constituents
val cons_constituents : {head:constituent, tail:constituents} -> constituents
val nil_productions : {} -> productions
val cons_productions : {constituents:constituents, action:ident, tail:productions} -> productions
val name_directive : {ident:ident} -> directive
val terminal_directive : {ident:ident} -> directive
val terminalOf_directive : {ident:ident, tp:ident} -> directive
val nonterminal_directive : {ident:ident, tp:ident, arms:productions} -> directive
val start_directive : {ident:ident} -> directive
val nil_directives : {} -> directives
val cons_directives : {head:directive, tail:directives} -> directives
datatype terminal =
IDENT of pos_symbol
| ARROW of pos
| COLON of pos
| EQUAL of pos
| NAME of pos
| LPAREN of pos
| OF of pos
| RPAREN of pos
| START of pos
| TERMINAL of pos
| NONTERMINAL of pos
val error : terminal Streamable.t -> exn
end)
=
struct
local
structure Value = struct
datatype nonterminal =
nonterminal
| constituent of Arg.constituent
| ident of Arg.ident
| constituents of Arg.constituents
| productions of Arg.productions
| directive of Arg.directive
| directives of Arg.directives
| pos_symbol of Arg.pos_symbol
| pos of Arg.pos
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
| Arg.NAME x => (5, Value.pos x)
| Arg.LPAREN x => (6, Value.pos x)
| Arg.OF x => (7, Value.pos x)
| Arg.RPAREN x => (8, Value.pos x)
| Arg.START x => (9, Value.pos x)
| Arg.TERMINAL x => (10, Value.pos x)
| Arg.NONTERMINAL x => (11, Value.pos x)
)
)
in
val parse = ParseEngine.parse (
ParseEngine.next5x1 "q\128\128\128\128\130\128\128\128\131\132\135\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128q\128\128\128\128\130\128\128\128\131\132\135\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\127\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128v\128\128\128\128v\128\128\128vvv\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128~~~~~~~~~~~~\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128r\128\128\128\128r\128\128\128rrr\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128u\128\128\128\128u\128\142\128uuu\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128p\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\143\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128t\128\128\128\128t\128\128\128ttt\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128x\137z\128\128x\148\128\128xxx\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128}}\152\128\128}\128}\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\148\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137z\128\128\128\148\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128s\128\128\128\128s\128\128\128sss\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\157\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128y\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128||\128\128\128|\128|\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128{{\128\128\128{\128{\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128x\137z\128\128x\148\128\128xxx\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128w\128\128\128\128w\128\128\128www\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
ParseEngine.next5x1 "\128\128\128\128\132\133\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\135\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\132\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\143\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\144\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\148\149\150\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\152\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\148\153\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\157\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\148\149\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
Vector.fromList [(0,1,(fn Value.pos_symbol(arg0)::rest => Value.ident(Arg.ident {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(1,1,(fn Value.ident(arg0)::rest => Value.constituent(Arg.unlabeled_item {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(1,3,(fn Value.ident(arg0)::_::Value.ident(arg1)::rest => Value.constituent(Arg.labeled_item {ident=arg0,label=arg1})::rest|_=>raise (Fail "bad parser"))),
(1,3,(fn _::Value.constituent(arg0)::_::rest => Value.constituent(Arg.paren_item {constituent=arg0})::rest|_=>raise (Fail "bad parser"))),
(2,0,(fn rest => Value.constituents(Arg.nil_constituents {})::rest)),
(2,2,(fn Value.constituents(arg0)::Value.constituent(arg1)::rest => Value.constituents(Arg.cons_constituents {tail=arg0,head=arg1})::rest|_=>raise (Fail "bad parser"))),
(3,0,(fn rest => Value.productions(Arg.nil_productions {})::rest)),
(3,4,(fn Value.productions(arg0)::Value.ident(arg1)::_::Value.constituents(arg2)::rest => Value.productions(Arg.cons_productions {tail=arg0,action=arg1,constituents=arg2})::rest|_=>raise (Fail "bad parser"))),
(4,2,(fn Value.ident(arg0)::_::rest => Value.directive(Arg.name_directive {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,2,(fn Value.ident(arg0)::_::rest => Value.directive(Arg.terminal_directive {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,4,(fn Value.ident(arg0)::_::Value.ident(arg1)::_::rest => Value.directive(Arg.terminalOf_directive {tp=arg0,ident=arg1})::rest|_=>raise (Fail "bad parser"))),
(4,6,(fn Value.productions(arg0)::_::Value.ident(arg1)::_::Value.ident(arg2)::_::rest => Value.directive(Arg.nonterminal_directive {arms=arg0,tp=arg1,ident=arg2})::rest|_=>raise (Fail "bad parser"))),
(4,2,(fn Value.ident(arg0)::_::rest => Value.directive(Arg.start_directive {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(5,0,(fn rest => Value.directives(Arg.nil_directives {})::rest)),
(5,2,(fn Value.directives(arg0)::Value.directive(arg1)::rest => Value.directives(Arg.cons_directives {tail=arg0,head=arg1})::rest|_=>raise (Fail "bad parser")))],
(fn Value.directives x => x | _ => raise (Fail "bad parser")), Arg.error)
end
end
