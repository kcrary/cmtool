(*

State 0:

start -> . Directives  / 0
14 : Directive -> . NAME Ident  / 1
15 : Directive -> . TERMINAL Ident Precedence  / 1
16 : Directive -> . TERMINAL Ident OF Ident Precedence  / 1
17 : Directive -> . NONTERMINAL Ident COLON Ident EQUAL Productions  / 1
18 : Directive -> . START Ident  / 1
19 : Directives -> .  / 0
20 : Directives -> . Directive Directives  / 0

$ => reduce 19
NAME => shift 1
NONTERMINAL => shift 4
START => shift 5
TERMINAL => shift 6
Directive => goto 2
Directives => goto 3

-----

State 1:

0 : Ident -> . IDENT  / 1
14 : Directive -> NAME . Ident  / 1

IDENT => shift 7
Ident => goto 8

-----

State 2:

14 : Directive -> . NAME Ident  / 1
15 : Directive -> . TERMINAL Ident Precedence  / 1
16 : Directive -> . TERMINAL Ident OF Ident Precedence  / 1
17 : Directive -> . NONTERMINAL Ident COLON Ident EQUAL Productions  / 1
18 : Directive -> . START Ident  / 1
19 : Directives -> .  / 0
20 : Directives -> . Directive Directives  / 0
20 : Directives -> Directive . Directives  / 0

$ => reduce 19
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
17 : Directive -> NONTERMINAL . Ident COLON Ident EQUAL Productions  / 1

IDENT => shift 7
Ident => goto 10

-----

State 5:

0 : Ident -> . IDENT  / 1
18 : Directive -> START . Ident  / 1

IDENT => shift 7
Ident => goto 11

-----

State 6:

0 : Ident -> . IDENT  / 3
15 : Directive -> TERMINAL . Ident Precedence  / 1
16 : Directive -> TERMINAL . Ident OF Ident Precedence  / 1

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
PRECL => reduce 0
PRECR => reduce 0
NOPREC => reduce 0

-----

State 8:

14 : Directive -> NAME Ident .  / 1

$ => reduce 14
NAME => reduce 14
NONTERMINAL => reduce 14
START => reduce 14
TERMINAL => reduce 14

-----

State 9:

20 : Directives -> Directive Directives .  / 0

$ => reduce 20

-----

State 10:

17 : Directive -> NONTERMINAL Ident . COLON Ident EQUAL Productions  / 1

COLON => shift 13

-----

State 11:

18 : Directive -> START Ident .  / 1

$ => reduce 18
NAME => reduce 18
NONTERMINAL => reduce 18
START => reduce 18
TERMINAL => reduce 18

-----

State 12:

7 : Precedence -> .  / 1
8 : Precedence -> . PRECL Number  / 1
9 : Precedence -> . PRECR Number  / 1
10 : Precedence -> . NOPREC  / 1
15 : Directive -> TERMINAL Ident . Precedence  / 1
16 : Directive -> TERMINAL Ident . OF Ident Precedence  / 1

$ => reduce 7
NAME => reduce 7
NONTERMINAL => reduce 7
OF => shift 14
START => reduce 7
TERMINAL => reduce 7
PRECL => shift 15
PRECR => shift 16
NOPREC => shift 17
Precedence => goto 18

-----

State 13:

0 : Ident -> . IDENT  / 5
17 : Directive -> NONTERMINAL Ident COLON . Ident EQUAL Productions  / 1

IDENT => shift 7
Ident => goto 19

-----

State 14:

0 : Ident -> . IDENT  / 6
16 : Directive -> TERMINAL Ident OF . Ident Precedence  / 1

IDENT => shift 7
Ident => goto 20

-----

State 15:

1 : Number -> . NUMBER  / 7
8 : Precedence -> PRECL . Number  / 7

NUMBER => shift 21
Number => goto 22

-----

State 16:

1 : Number -> . NUMBER  / 7
9 : Precedence -> PRECR . Number  / 7

NUMBER => shift 21
Number => goto 23

-----

State 17:

10 : Precedence -> NOPREC .  / 7

$ => reduce 10
IDENT => reduce 10
ARROW => reduce 10
LPAREN => reduce 10
NAME => reduce 10
NONTERMINAL => reduce 10
START => reduce 10
TERMINAL => reduce 10

-----

State 18:

15 : Directive -> TERMINAL Ident Precedence .  / 1

$ => reduce 15
NAME => reduce 15
NONTERMINAL => reduce 15
START => reduce 15
TERMINAL => reduce 15

-----

State 19:

17 : Directive -> NONTERMINAL Ident COLON Ident . EQUAL Productions  / 1

EQUAL => shift 24

-----

State 20:

7 : Precedence -> .  / 1
8 : Precedence -> . PRECL Number  / 1
9 : Precedence -> . PRECR Number  / 1
10 : Precedence -> . NOPREC  / 1
16 : Directive -> TERMINAL Ident OF Ident . Precedence  / 1

$ => reduce 7
NAME => reduce 7
NONTERMINAL => reduce 7
START => reduce 7
TERMINAL => reduce 7
PRECL => shift 15
PRECR => shift 16
NOPREC => shift 17
Precedence => goto 25

-----

State 21:

1 : Number -> NUMBER .  / 7

$ => reduce 1
IDENT => reduce 1
ARROW => reduce 1
LPAREN => reduce 1
NAME => reduce 1
NONTERMINAL => reduce 1
START => reduce 1
TERMINAL => reduce 1

-----

State 22:

8 : Precedence -> PRECL Number .  / 7

$ => reduce 8
IDENT => reduce 8
ARROW => reduce 8
LPAREN => reduce 8
NAME => reduce 8
NONTERMINAL => reduce 8
START => reduce 8
TERMINAL => reduce 8

-----

State 23:

9 : Precedence -> PRECR Number .  / 7

$ => reduce 9
IDENT => reduce 9
ARROW => reduce 9
LPAREN => reduce 9
NAME => reduce 9
NONTERMINAL => reduce 9
START => reduce 9
TERMINAL => reduce 9

-----

State 24:

0 : Ident -> . IDENT  / 8
2 : Constituent -> . Ident  / 9
3 : Constituent -> . Ident COLON Ident  / 9
4 : Constituent -> . LPAREN Constituent RPAREN  / 9
5 : Constituents -> .  / 10
6 : Constituents -> . Constituent Constituents  / 10
11 : Production -> . Constituents ARROW Ident Precedence  / 7
12 : Productions -> .  / 1
13 : Productions -> . Production Productions  / 1
17 : Directive -> NONTERMINAL Ident COLON Ident EQUAL . Productions  / 1

$ => reduce 12
IDENT => shift 7
ARROW => reduce 5
LPAREN => shift 26
NAME => reduce 12
NONTERMINAL => reduce 12
START => reduce 12
TERMINAL => reduce 12
Ident => goto 27
Constituent => goto 28
Constituents => goto 29
Productions => goto 30
Production => goto 31

-----

State 25:

16 : Directive -> TERMINAL Ident OF Ident Precedence .  / 1

$ => reduce 16
NAME => reduce 16
NONTERMINAL => reduce 16
START => reduce 16
TERMINAL => reduce 16

-----

State 26:

0 : Ident -> . IDENT  / 11
2 : Constituent -> . Ident  / 12
3 : Constituent -> . Ident COLON Ident  / 12
4 : Constituent -> . LPAREN Constituent RPAREN  / 12
4 : Constituent -> LPAREN . Constituent RPAREN  / 13

IDENT => shift 7
LPAREN => shift 26
Ident => goto 27
Constituent => goto 32

-----

State 27:

2 : Constituent -> Ident .  / 13
3 : Constituent -> Ident . COLON Ident  / 13

IDENT => reduce 2
ARROW => reduce 2
COLON => shift 33
LPAREN => reduce 2
RPAREN => reduce 2

-----

State 28:

0 : Ident -> . IDENT  / 8
2 : Constituent -> . Ident  / 9
3 : Constituent -> . Ident COLON Ident  / 9
4 : Constituent -> . LPAREN Constituent RPAREN  / 9
5 : Constituents -> .  / 10
6 : Constituents -> . Constituent Constituents  / 10
6 : Constituents -> Constituent . Constituents  / 10

IDENT => shift 7
ARROW => reduce 5
LPAREN => shift 26
Ident => goto 27
Constituent => goto 28
Constituents => goto 34

-----

State 29:

11 : Production -> Constituents . ARROW Ident Precedence  / 7

ARROW => shift 35

-----

State 30:

17 : Directive -> NONTERMINAL Ident COLON Ident EQUAL Productions .  / 1

$ => reduce 17
NAME => reduce 17
NONTERMINAL => reduce 17
START => reduce 17
TERMINAL => reduce 17

-----

State 31:

0 : Ident -> . IDENT  / 8
2 : Constituent -> . Ident  / 9
3 : Constituent -> . Ident COLON Ident  / 9
4 : Constituent -> . LPAREN Constituent RPAREN  / 9
5 : Constituents -> .  / 10
6 : Constituents -> . Constituent Constituents  / 10
11 : Production -> . Constituents ARROW Ident Precedence  / 7
12 : Productions -> .  / 1
13 : Productions -> . Production Productions  / 1
13 : Productions -> Production . Productions  / 1

$ => reduce 12
IDENT => shift 7
ARROW => reduce 5
LPAREN => shift 26
NAME => reduce 12
NONTERMINAL => reduce 12
START => reduce 12
TERMINAL => reduce 12
Ident => goto 27
Constituent => goto 28
Constituents => goto 29
Productions => goto 36
Production => goto 31

-----

State 32:

4 : Constituent -> LPAREN Constituent . RPAREN  / 13

RPAREN => shift 37

-----

State 33:

0 : Ident -> . IDENT  / 13
3 : Constituent -> Ident COLON . Ident  / 13

IDENT => shift 7
Ident => goto 38

-----

State 34:

6 : Constituents -> Constituent Constituents .  / 10

ARROW => reduce 6

-----

State 35:

0 : Ident -> . IDENT  / 14
11 : Production -> Constituents ARROW . Ident Precedence  / 7

IDENT => shift 7
Ident => goto 39

-----

State 36:

13 : Productions -> Production Productions .  / 1

$ => reduce 13
NAME => reduce 13
NONTERMINAL => reduce 13
START => reduce 13
TERMINAL => reduce 13

-----

State 37:

4 : Constituent -> LPAREN Constituent RPAREN .  / 13

IDENT => reduce 4
ARROW => reduce 4
LPAREN => reduce 4
RPAREN => reduce 4

-----

State 38:

3 : Constituent -> Ident COLON Ident .  / 13

IDENT => reduce 3
ARROW => reduce 3
LPAREN => reduce 3
RPAREN => reduce 3

-----

State 39:

7 : Precedence -> .  / 7
8 : Precedence -> . PRECL Number  / 7
9 : Precedence -> . PRECR Number  / 7
10 : Precedence -> . NOPREC  / 7
11 : Production -> Constituents ARROW Ident . Precedence  / 7

$ => reduce 7
IDENT => reduce 7
ARROW => reduce 7
LPAREN => reduce 7
NAME => reduce 7
NONTERMINAL => reduce 7
START => reduce 7
TERMINAL => reduce 7
PRECL => shift 15
PRECR => shift 16
NOPREC => shift 17
Precedence => goto 40

-----

State 40:

11 : Production -> Constituents ARROW Ident Precedence .  / 7

$ => reduce 11
IDENT => reduce 11
ARROW => reduce 11
LPAREN => reduce 11
NAME => reduce 11
NONTERMINAL => reduce 11
START => reduce 11
TERMINAL => reduce 11

-----

lookahead 0 = $ 
lookahead 1 = $ NAME NONTERMINAL START TERMINAL 
lookahead 2 = COLON 
lookahead 3 = $ NAME NONTERMINAL OF START TERMINAL PRECL PRECR NOPREC 
lookahead 4 = $ IDENT ARROW COLON EQUAL LPAREN NAME RPAREN NONTERMINAL OF START TERMINAL PRECL PRECR NOPREC 
lookahead 5 = EQUAL 
lookahead 6 = $ NAME NONTERMINAL START TERMINAL PRECL PRECR NOPREC 
lookahead 7 = $ IDENT ARROW LPAREN NAME NONTERMINAL START TERMINAL 
lookahead 8 = IDENT ARROW COLON LPAREN 
lookahead 9 = IDENT ARROW LPAREN 
lookahead 10 = ARROW 
lookahead 11 = COLON RPAREN 
lookahead 12 = RPAREN 
lookahead 13 = IDENT ARROW LPAREN RPAREN 
lookahead 14 = $ IDENT ARROW LPAREN NAME NONTERMINAL START TERMINAL PRECL PRECR NOPREC 

*)

functor ParseMainFun (structure Streamable : STREAMABLE
structure Arg : sig
type pos_int
type pos
type directive
type directives
type pos_symbol
type constituent
type constituents
type productions
type symbol
type int
type production
type precedence
val sole_ident : {ident:pos_symbol} -> symbol
val sole_number : {num:pos_int} -> int
val unlabeled_item : {ident:symbol} -> constituent
val labeled_item : {label:symbol, ident:symbol} -> constituent
val paren_item : {constituent:constituent} -> constituent
val nil_constituents : {} -> constituents
val cons_constituents : {head:constituent, tail:constituents} -> constituents
val empty_precedence : {} -> precedence
val left_precedence : {num:int} -> precedence
val right_precedence : {num:int} -> precedence
val no_precedence : {} -> precedence
val sole_production : {constituents:constituents, action:symbol, prec:precedence} -> production
val nil_productions : {} -> productions
val cons_productions : {head:production, tail:productions} -> productions
val name_directive : {ident:symbol} -> directive
val terminal_directive : {ident:symbol, prec:precedence} -> directive
val terminal_of_directive : {ident:symbol, tp:symbol, prec:precedence} -> directive
val nonterminal_directive : {ident:symbol, tp:symbol, arms:productions} -> directive
val start_directive : {ident:symbol} -> directive
val nil_directives : {} -> directives
val cons_directives : {head:directive, tail:directives} -> directives
datatype terminal =
IDENT of pos_symbol
| NUMBER of pos_int
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
| PRECL of pos
| PRECR of pos
| NOPREC of pos
val error : terminal Streamable.t -> exn
end)
=
struct
local
structure Value = struct
datatype nonterminal =
nonterminal
| pos_int of Arg.pos_int
| pos of Arg.pos
| directive of Arg.directive
| directives of Arg.directives
| pos_symbol of Arg.pos_symbol
| constituent of Arg.constituent
| constituents of Arg.constituents
| productions of Arg.productions
| symbol of Arg.symbol
| int of Arg.int
| production of Arg.production
| precedence of Arg.precedence
end
structure ParseEngine = ParseEngineFun (structure Streamable = Streamable
type terminal = Arg.terminal
type value = Value.nonterminal
val dummy = Value.nonterminal
fun read terminal =
(case terminal of
Arg.IDENT x => (1, Value.pos_symbol x)
| Arg.NUMBER x => (2, Value.pos_int x)
| Arg.ARROW x => (3, Value.pos x)
| Arg.COLON x => (4, Value.pos x)
| Arg.EQUAL x => (5, Value.pos x)
| Arg.LPAREN x => (6, Value.pos x)
| Arg.NAME x => (7, Value.pos x)
| Arg.RPAREN x => (8, Value.pos x)
| Arg.NONTERMINAL x => (9, Value.pos x)
| Arg.OF x => (10, Value.pos x)
| Arg.START x => (11, Value.pos x)
| Arg.TERMINAL x => (12, Value.pos x)
| Arg.PRECL x => (13, Value.pos x)
| Arg.PRECR x => (14, Value.pos x)
| Arg.NOPREC x => (15, Value.pos x)
)
)
in
val parse = ParseEngine.parse (
ParseEngine.next5x1 "k\128\128\128\128\128\128\130\128\133\128\134\135\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128k\128\128\128\128\128\128\130\128\133\128\134\135\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\127\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128~~\128~~~~~~~~~~~~~\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128p\128\128\128\128\128\128p\128p\128pp\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128j\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128l\128\128\128\128\128\128l\128l\128ll\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128w\128\128\128\128\128\128w\128w\143ww\144\145\146\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\150\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\150\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128tt\128t\128\128tt\128t\128tt\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128o\128\128\128\128\128\128o\128o\128oo\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\153\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128w\128\128\128\128\128\128w\128w\128ww\144\145\146\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128}}\128}\128\128}}\128}\128}}\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128vv\128v\128\128vv\128v\128vv\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128uu\128u\128\128uu\128u\128uu\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128r\136\128y\128\128\155r\128r\128rr\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128n\128\128\128\128\128\128n\128n\128nn\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\155\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128|\128|\162\128|\128|\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128y\128\128\155\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128m\128\128\128\128\128\128m\128m\128mm\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128r\136\128y\128\128\155r\128r\128rr\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\166\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128x\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128q\128\128\128\128\128\128q\128q\128qq\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128z\128z\128\128z\128z\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128{\128{\128\128{\128{\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128ww\128w\128\128ww\128w\128ww\144\145\146\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128ss\128s\128\128ss\128s\128ss\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
ParseEngine.next5x1 "\128\130\131\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\130\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\148\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\150\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\151\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\153\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\128\128\128\156\157\158\159\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\128\128\128\160\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\128\128\128\156\162\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\128\128\128\156\157\164\159\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\166\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\167\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\168\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
Vector.fromList [(0,1,(fn Value.pos_symbol(arg0)::rest => Value.symbol(Arg.sole_ident {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(3,1,(fn Value.pos_int(arg0)::rest => Value.int(Arg.sole_number {num=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,1,(fn Value.symbol(arg0)::rest => Value.constituent(Arg.unlabeled_item {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,3,(fn Value.symbol(arg0)::_::Value.symbol(arg1)::rest => Value.constituent(Arg.labeled_item {ident=arg0,label=arg1})::rest|_=>raise (Fail "bad parser"))),
(4,3,(fn _::Value.constituent(arg0)::_::rest => Value.constituent(Arg.paren_item {constituent=arg0})::rest|_=>raise (Fail "bad parser"))),
(5,0,(fn rest => Value.constituents(Arg.nil_constituents {})::rest)),
(5,2,(fn Value.constituents(arg0)::Value.constituent(arg1)::rest => Value.constituents(Arg.cons_constituents {tail=arg0,head=arg1})::rest|_=>raise (Fail "bad parser"))),
(8,0,(fn rest => Value.precedence(Arg.empty_precedence {})::rest)),
(8,2,(fn Value.int(arg0)::_::rest => Value.precedence(Arg.left_precedence {num=arg0})::rest|_=>raise (Fail "bad parser"))),
(8,2,(fn Value.int(arg0)::_::rest => Value.precedence(Arg.right_precedence {num=arg0})::rest|_=>raise (Fail "bad parser"))),
(8,1,(fn _::rest => Value.precedence(Arg.no_precedence {})::rest|_=>raise (Fail "bad parser"))),
(7,4,(fn Value.precedence(arg0)::Value.symbol(arg1)::_::Value.constituents(arg2)::rest => Value.production(Arg.sole_production {prec=arg0,action=arg1,constituents=arg2})::rest|_=>raise (Fail "bad parser"))),
(6,0,(fn rest => Value.productions(Arg.nil_productions {})::rest)),
(6,2,(fn Value.productions(arg0)::Value.production(arg1)::rest => Value.productions(Arg.cons_productions {tail=arg0,head=arg1})::rest|_=>raise (Fail "bad parser"))),
(1,2,(fn Value.symbol(arg0)::_::rest => Value.directive(Arg.name_directive {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(1,3,(fn Value.precedence(arg0)::Value.symbol(arg1)::_::rest => Value.directive(Arg.terminal_directive {prec=arg0,ident=arg1})::rest|_=>raise (Fail "bad parser"))),
(1,5,(fn Value.precedence(arg0)::Value.symbol(arg1)::_::Value.symbol(arg2)::_::rest => Value.directive(Arg.terminal_of_directive {prec=arg0,tp=arg1,ident=arg2})::rest|_=>raise (Fail "bad parser"))),
(1,6,(fn Value.productions(arg0)::_::Value.symbol(arg1)::_::Value.symbol(arg2)::_::rest => Value.directive(Arg.nonterminal_directive {arms=arg0,tp=arg1,ident=arg2})::rest|_=>raise (Fail "bad parser"))),
(1,2,(fn Value.symbol(arg0)::_::rest => Value.directive(Arg.start_directive {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(2,0,(fn rest => Value.directives(Arg.nil_directives {})::rest)),
(2,2,(fn Value.directives(arg0)::Value.directive(arg1)::rest => Value.directives(Arg.cons_directives {tail=arg0,head=arg1})::rest|_=>raise (Fail "bad parser")))],
(fn Value.directives x => x | _ => raise (Fail "bad parser")), Arg.error)
end
end
