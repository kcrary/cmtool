(*

State 0:

start -> . Directives  / 0
16 : Directive -> . NAME Ident  / 1
17 : Directive -> . TERMINAL Ident Precedence  / 1
18 : Directive -> . TERMINAL Ident OF Ident Precedence  / 1
19 : Directive -> . NONTERMINAL Ident COLON Ident EQUAL Productions  / 1
20 : Directive -> . START Ident  / 1
21 : Directives -> .  / 0
22 : Directives -> . Directive Directives  / 0

$ => reduce 21
NAME => shift 5
NONTERMINAL => shift 4
START => shift 3
TERMINAL => shift 2
Directive => goto 1
Directives => goto 6

-----

State 1:

16 : Directive -> . NAME Ident  / 1
17 : Directive -> . TERMINAL Ident Precedence  / 1
18 : Directive -> . TERMINAL Ident OF Ident Precedence  / 1
19 : Directive -> . NONTERMINAL Ident COLON Ident EQUAL Productions  / 1
20 : Directive -> . START Ident  / 1
21 : Directives -> .  / 0
22 : Directives -> . Directive Directives  / 0
22 : Directives -> Directive . Directives  / 0

$ => reduce 21
NAME => shift 5
NONTERMINAL => shift 4
START => shift 3
TERMINAL => shift 2
Directive => goto 1
Directives => goto 7

-----

State 2:

0 : Ident -> . IDENT  / 2
17 : Directive -> TERMINAL . Ident Precedence  / 1
18 : Directive -> TERMINAL . Ident OF Ident Precedence  / 1

IDENT => shift 9
Ident => goto 8

-----

State 3:

0 : Ident -> . IDENT  / 1
20 : Directive -> START . Ident  / 1

IDENT => shift 9
Ident => goto 10

-----

State 4:

0 : Ident -> . IDENT  / 3
19 : Directive -> NONTERMINAL . Ident COLON Ident EQUAL Productions  / 1

IDENT => shift 9
Ident => goto 11

-----

State 5:

0 : Ident -> . IDENT  / 1
16 : Directive -> NAME . Ident  / 1

IDENT => shift 9
Ident => goto 12

-----

State 6:

start -> Directives .  / 0

$ => accept

-----

State 7:

22 : Directives -> Directive Directives .  / 0

$ => reduce 22

-----

State 8:

9 : Precedence -> .  / 1
10 : Precedence -> . PRECL Number  / 1
11 : Precedence -> . PRECR Number  / 1
12 : Precedence -> . NOPREC  / 1
17 : Directive -> TERMINAL Ident . Precedence  / 1
18 : Directive -> TERMINAL Ident . OF Ident Precedence  / 1

$ => reduce 9
NAME => reduce 9
NONTERMINAL => reduce 9
NOPREC => shift 14
OF => shift 13
PRECL => shift 16
PRECR => shift 17
START => reduce 9
TERMINAL => reduce 9
Precedence => goto 15

-----

State 9:

0 : Ident -> IDENT .  / 4

$ => reduce 0
IDENT => reduce 0
NUMBER => reduce 0
ARROW => reduce 0
COLON => reduce 0
EQUAL => reduce 0
NAME => reduce 0
NONTERMINAL => reduce 0
NOPREC => reduce 0
LPAREN => reduce 0
OF => reduce 0
PRECL => reduce 0
PRECR => reduce 0
RPAREN => reduce 0
START => reduce 0
TERMINAL => reduce 0

-----

State 10:

20 : Directive -> START Ident .  / 1

$ => reduce 20
NAME => reduce 20
NONTERMINAL => reduce 20
START => reduce 20
TERMINAL => reduce 20

-----

State 11:

19 : Directive -> NONTERMINAL Ident . COLON Ident EQUAL Productions  / 1

COLON => shift 18

-----

State 12:

16 : Directive -> NAME Ident .  / 1

$ => reduce 16
NAME => reduce 16
NONTERMINAL => reduce 16
START => reduce 16
TERMINAL => reduce 16

-----

State 13:

0 : Ident -> . IDENT  / 5
18 : Directive -> TERMINAL Ident OF . Ident Precedence  / 1

IDENT => shift 9
Ident => goto 19

-----

State 14:

12 : Precedence -> NOPREC .  / 6

$ => reduce 12
IDENT => reduce 12
NUMBER => reduce 12
ARROW => reduce 12
NAME => reduce 12
NONTERMINAL => reduce 12
LPAREN => reduce 12
START => reduce 12
TERMINAL => reduce 12

-----

State 15:

17 : Directive -> TERMINAL Ident Precedence .  / 1

$ => reduce 17
NAME => reduce 17
NONTERMINAL => reduce 17
START => reduce 17
TERMINAL => reduce 17

-----

State 16:

1 : Number -> . NUMBER  / 6
10 : Precedence -> PRECL . Number  / 6

NUMBER => shift 21
Number => goto 20

-----

State 17:

1 : Number -> . NUMBER  / 6
11 : Precedence -> PRECR . Number  / 6

NUMBER => shift 21
Number => goto 22

-----

State 18:

0 : Ident -> . IDENT  / 7
19 : Directive -> NONTERMINAL Ident COLON . Ident EQUAL Productions  / 1

IDENT => shift 9
Ident => goto 23

-----

State 19:

9 : Precedence -> .  / 1
10 : Precedence -> . PRECL Number  / 1
11 : Precedence -> . PRECR Number  / 1
12 : Precedence -> . NOPREC  / 1
18 : Directive -> TERMINAL Ident OF Ident . Precedence  / 1

$ => reduce 9
NAME => reduce 9
NONTERMINAL => reduce 9
NOPREC => shift 14
PRECL => shift 16
PRECR => shift 17
START => reduce 9
TERMINAL => reduce 9
Precedence => goto 24

-----

State 20:

10 : Precedence -> PRECL Number .  / 6

$ => reduce 10
IDENT => reduce 10
NUMBER => reduce 10
ARROW => reduce 10
NAME => reduce 10
NONTERMINAL => reduce 10
LPAREN => reduce 10
START => reduce 10
TERMINAL => reduce 10

-----

State 21:

1 : Number -> NUMBER .  / 8

$ => reduce 1
IDENT => reduce 1
NUMBER => reduce 1
ARROW => reduce 1
COLON => reduce 1
NAME => reduce 1
NONTERMINAL => reduce 1
LPAREN => reduce 1
START => reduce 1
TERMINAL => reduce 1

-----

State 22:

11 : Precedence -> PRECR Number .  / 6

$ => reduce 11
IDENT => reduce 11
NUMBER => reduce 11
ARROW => reduce 11
NAME => reduce 11
NONTERMINAL => reduce 11
LPAREN => reduce 11
START => reduce 11
TERMINAL => reduce 11

-----

State 23:

19 : Directive -> NONTERMINAL Ident COLON Ident . EQUAL Productions  / 1

EQUAL => shift 25

-----

State 24:

18 : Directive -> TERMINAL Ident OF Ident Precedence .  / 1

$ => reduce 18
NAME => reduce 18
NONTERMINAL => reduce 18
START => reduce 18
TERMINAL => reduce 18

-----

State 25:

0 : Ident -> . IDENT  / 9
1 : Number -> . NUMBER  / 3
2 : Label -> . Ident  / 3
3 : Label -> . Number  / 3
4 : Constituent -> . Ident  / 10
5 : Constituent -> . Label COLON Ident  / 10
6 : Constituent -> . LPAREN Constituent RPAREN  / 10
7 : Constituents -> .  / 11
8 : Constituents -> . Constituent Constituents  / 11
13 : Production -> . Constituents ARROW Ident Precedence  / 6
14 : Productions -> .  / 1
15 : Productions -> . Production Productions  / 1
19 : Directive -> NONTERMINAL Ident COLON Ident EQUAL . Productions  / 1

$ => reduce 14
IDENT => shift 9
NUMBER => shift 21
ARROW => reduce 7
NAME => reduce 14
NONTERMINAL => reduce 14
LPAREN => shift 31
START => reduce 14
TERMINAL => reduce 14
Ident => goto 32
Number => goto 33
Label => goto 30
Constituent => goto 29
Constituents => goto 28
Production => goto 27
Productions => goto 26

-----

State 26:

19 : Directive -> NONTERMINAL Ident COLON Ident EQUAL Productions .  / 1

$ => reduce 19
NAME => reduce 19
NONTERMINAL => reduce 19
START => reduce 19
TERMINAL => reduce 19

-----

State 27:

0 : Ident -> . IDENT  / 9
1 : Number -> . NUMBER  / 3
2 : Label -> . Ident  / 3
3 : Label -> . Number  / 3
4 : Constituent -> . Ident  / 10
5 : Constituent -> . Label COLON Ident  / 10
6 : Constituent -> . LPAREN Constituent RPAREN  / 10
7 : Constituents -> .  / 11
8 : Constituents -> . Constituent Constituents  / 11
13 : Production -> . Constituents ARROW Ident Precedence  / 6
14 : Productions -> .  / 1
15 : Productions -> . Production Productions  / 1
15 : Productions -> Production . Productions  / 1

$ => reduce 14
IDENT => shift 9
NUMBER => shift 21
ARROW => reduce 7
NAME => reduce 14
NONTERMINAL => reduce 14
LPAREN => shift 31
START => reduce 14
TERMINAL => reduce 14
Ident => goto 32
Number => goto 33
Label => goto 30
Constituent => goto 29
Constituents => goto 28
Production => goto 27
Productions => goto 34

-----

State 28:

13 : Production -> Constituents . ARROW Ident Precedence  / 6

ARROW => shift 35

-----

State 29:

0 : Ident -> . IDENT  / 9
1 : Number -> . NUMBER  / 3
2 : Label -> . Ident  / 3
3 : Label -> . Number  / 3
4 : Constituent -> . Ident  / 10
5 : Constituent -> . Label COLON Ident  / 10
6 : Constituent -> . LPAREN Constituent RPAREN  / 10
7 : Constituents -> .  / 11
8 : Constituents -> . Constituent Constituents  / 11
8 : Constituents -> Constituent . Constituents  / 11

IDENT => shift 9
NUMBER => shift 21
ARROW => reduce 7
LPAREN => shift 31
Ident => goto 32
Number => goto 33
Label => goto 30
Constituent => goto 29
Constituents => goto 36

-----

State 30:

5 : Constituent -> Label . COLON Ident  / 12

COLON => shift 37

-----

State 31:

0 : Ident -> . IDENT  / 13
1 : Number -> . NUMBER  / 3
2 : Label -> . Ident  / 3
3 : Label -> . Number  / 3
4 : Constituent -> . Ident  / 14
5 : Constituent -> . Label COLON Ident  / 14
6 : Constituent -> . LPAREN Constituent RPAREN  / 14
6 : Constituent -> LPAREN . Constituent RPAREN  / 12

IDENT => shift 9
NUMBER => shift 21
LPAREN => shift 31
Ident => goto 32
Number => goto 33
Label => goto 30
Constituent => goto 38

-----

State 32:

2 : Label -> Ident .  / 3
4 : Constituent -> Ident .  / 12

IDENT => reduce 4
NUMBER => reduce 4
ARROW => reduce 4
COLON => reduce 2
LPAREN => reduce 4
RPAREN => reduce 4

-----

State 33:

3 : Label -> Number .  / 3

COLON => reduce 3

-----

State 34:

15 : Productions -> Production Productions .  / 1

$ => reduce 15
NAME => reduce 15
NONTERMINAL => reduce 15
START => reduce 15
TERMINAL => reduce 15

-----

State 35:

0 : Ident -> . IDENT  / 15
13 : Production -> Constituents ARROW . Ident Precedence  / 6

IDENT => shift 9
Ident => goto 39

-----

State 36:

8 : Constituents -> Constituent Constituents .  / 11

ARROW => reduce 8

-----

State 37:

0 : Ident -> . IDENT  / 12
5 : Constituent -> Label COLON . Ident  / 12

IDENT => shift 9
Ident => goto 40

-----

State 38:

6 : Constituent -> LPAREN Constituent . RPAREN  / 12

RPAREN => shift 41

-----

State 39:

9 : Precedence -> .  / 6
10 : Precedence -> . PRECL Number  / 6
11 : Precedence -> . PRECR Number  / 6
12 : Precedence -> . NOPREC  / 6
13 : Production -> Constituents ARROW Ident . Precedence  / 6

$ => reduce 9
IDENT => reduce 9
NUMBER => reduce 9
ARROW => reduce 9
NAME => reduce 9
NONTERMINAL => reduce 9
NOPREC => shift 14
LPAREN => reduce 9
PRECL => shift 16
PRECR => shift 17
START => reduce 9
TERMINAL => reduce 9
Precedence => goto 42

-----

State 40:

5 : Constituent -> Label COLON Ident .  / 12

IDENT => reduce 5
NUMBER => reduce 5
ARROW => reduce 5
LPAREN => reduce 5
RPAREN => reduce 5

-----

State 41:

6 : Constituent -> LPAREN Constituent RPAREN .  / 12

IDENT => reduce 6
NUMBER => reduce 6
ARROW => reduce 6
LPAREN => reduce 6
RPAREN => reduce 6

-----

State 42:

13 : Production -> Constituents ARROW Ident Precedence .  / 6

$ => reduce 13
IDENT => reduce 13
NUMBER => reduce 13
ARROW => reduce 13
NAME => reduce 13
NONTERMINAL => reduce 13
LPAREN => reduce 13
START => reduce 13
TERMINAL => reduce 13

-----

lookahead 0 = $ 
lookahead 1 = $ NAME NONTERMINAL START TERMINAL 
lookahead 2 = $ NAME NONTERMINAL NOPREC OF PRECL PRECR START TERMINAL 
lookahead 3 = COLON 
lookahead 4 = $ IDENT NUMBER ARROW COLON EQUAL NAME NONTERMINAL NOPREC LPAREN OF PRECL PRECR RPAREN START TERMINAL 
lookahead 5 = $ NAME NONTERMINAL NOPREC PRECL PRECR START TERMINAL 
lookahead 6 = $ IDENT NUMBER ARROW NAME NONTERMINAL LPAREN START TERMINAL 
lookahead 7 = EQUAL 
lookahead 8 = $ IDENT NUMBER ARROW COLON NAME NONTERMINAL LPAREN START TERMINAL 
lookahead 9 = IDENT NUMBER ARROW COLON LPAREN 
lookahead 10 = IDENT NUMBER ARROW LPAREN 
lookahead 11 = ARROW 
lookahead 12 = IDENT NUMBER ARROW LPAREN RPAREN 
lookahead 13 = COLON RPAREN 
lookahead 14 = RPAREN 
lookahead 15 = $ IDENT NUMBER ARROW NAME NONTERMINAL NOPREC LPAREN PRECL PRECR START TERMINAL 

*)

functor ParseMainFun (structure Streamable : STREAMABLE
structure Arg : sig
type pos_symbol
type pos_int
type pos
type symbol
type int
type label
type constituent
type constituents
type precedence
type production
type productions
type directive
type directives
val sole_ident : pos_symbol -> symbol
val sole_number : pos_int -> int
val ident_label : symbol -> label
val number_label : int -> label
val unlabeled_item : symbol -> constituent
val labeled_item : {1:label, 2:symbol} -> constituent
val paren_item : constituent -> constituent
val nil_constituents : {} -> constituents
val cons_constituents : {1:constituent, 2:constituents} -> constituents
val empty_precedence : {} -> precedence
val left_precedence : int -> precedence
val right_precedence : int -> precedence
val no_precedence : {} -> precedence
val sole_production : {1:constituents, 2:symbol, 3:precedence} -> production
val nil_productions : {} -> productions
val cons_productions : {1:production, 2:productions} -> productions
val name_directive : symbol -> directive
val terminal_directive : {1:symbol, 2:precedence} -> directive
val terminal_of_directive : {1:symbol, 2:symbol, 3:precedence} -> directive
val nonterminal_directive : {1:symbol, 2:symbol, 3:productions} -> directive
val start_directive : symbol -> directive
val nil_directives : {} -> directives
val cons_directives : {1:directive, 2:directives} -> directives
datatype terminal =
IDENT of pos_symbol
| NUMBER of pos_int
| ARROW of pos
| COLON of pos
| EQUAL of pos
| NAME of pos
| NONTERMINAL of pos
| NOPREC of pos
| LPAREN of pos
| OF of pos
| PRECL of pos
| PRECR of pos
| RPAREN of pos
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
| pos_symbol of Arg.pos_symbol
| pos_int of Arg.pos_int
| pos of Arg.pos
| symbol of Arg.symbol
| int of Arg.int
| label of Arg.label
| constituent of Arg.constituent
| constituents of Arg.constituents
| precedence of Arg.precedence
| production of Arg.production
| productions of Arg.productions
| directive of Arg.directive
| directives of Arg.directives
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
| Arg.NAME x => (6, Value.pos x)
| Arg.NONTERMINAL x => (7, Value.pos x)
| Arg.NOPREC x => (8, Value.pos x)
| Arg.LPAREN x => (9, Value.pos x)
| Arg.OF x => (10, Value.pos x)
| Arg.PRECL x => (11, Value.pos x)
| Arg.PRECR x => (12, Value.pos x)
| Arg.RPAREN x => (13, Value.pos x)
| Arg.START x => (14, Value.pos x)
| Arg.TERMINAL x => (15, Value.pos x)
)
)
in
val parse = ParseEngine.parse (
ParseEngine.next5x1 "i\128\128\128\128\128\134\133\128\128\128\128\128\128\132\131\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128i\128\128\128\128\128\134\133\128\128\128\128\128\128\132\131\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\127\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128h\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128u\128\128\128\128\128uu\143\128\142\145\146\128uu\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128~~~~~~~~~~~~~~~~\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128j\128\128\128\128\128jj\128\128\128\128\128\128jj\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128n\128\128\128\128\128nn\128\128\128\128\128\128nn\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128rrrr\128\128rr\128r\128\128\128\128rr\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128m\128\128\128\128\128mm\128\128\128\128\128\128mm\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\150\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\150\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128u\128\128\128\128\128uu\143\128\128\145\146\128uu\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128tttt\128\128tt\128t\128\128\128\128tt\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128}}}}}\128}}\128}\128\128\128\128}}\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128ssss\128\128ss\128s\128\128\128\128ss\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\154\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128l\128\128\128\128\128ll\128\128\128\128\128\128ll\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128p\138\150w\128\128pp\128\160\128\128\128\128pp\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128k\128\128\128\128\128kk\128\128\128\128\128\128kk\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128p\138\150w\128\128pp\128\160\128\128\128\128pp\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\150w\128\128\128\128\128\160\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\166\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\150\128\128\128\128\128\128\160\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128zzz|\128\128\128\128z\128\128\128z\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128{\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128o\128\128\128\128\128oo\128\128\128\128\128\128oo\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128v\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\170\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128uuuu\128\128uu\143u\128\145\146\128uu\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128yyy\128\128\128\128\128y\128\128\128y\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128xxx\128\128\128\128\128x\128\128\128x\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128qqqq\128\128qq\128q\128\128\128\128qq\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
ParseEngine.next5x1 "\128\128\128\128\128\128\128\128\129\134\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\129\135\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\143\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\148\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\150\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\151\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\152\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\160\161\158\157\156\128\155\154\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\160\161\158\157\156\128\155\162\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\160\161\158\157\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\160\161\158\166\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\167\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\168\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\170\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
Vector.fromList [(0,1,(fn Value.pos_symbol(arg0)::rest => Value.symbol(Arg.sole_ident arg0)::rest|_=>raise (Fail "bad parser"))),
(1,1,(fn Value.pos_int(arg0)::rest => Value.int(Arg.sole_number arg0)::rest|_=>raise (Fail "bad parser"))),
(2,1,(fn Value.symbol(arg0)::rest => Value.label(Arg.ident_label arg0)::rest|_=>raise (Fail "bad parser"))),
(2,1,(fn Value.int(arg0)::rest => Value.label(Arg.number_label arg0)::rest|_=>raise (Fail "bad parser"))),
(3,1,(fn Value.symbol(arg0)::rest => Value.constituent(Arg.unlabeled_item arg0)::rest|_=>raise (Fail "bad parser"))),
(3,3,(fn Value.symbol(arg0)::_::Value.label(arg1)::rest => Value.constituent(Arg.labeled_item {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(3,3,(fn _::Value.constituent(arg0)::_::rest => Value.constituent(Arg.paren_item arg0)::rest|_=>raise (Fail "bad parser"))),
(4,0,(fn rest => Value.constituents(Arg.nil_constituents {})::rest)),
(4,2,(fn Value.constituents(arg0)::Value.constituent(arg1)::rest => Value.constituents(Arg.cons_constituents {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(5,0,(fn rest => Value.precedence(Arg.empty_precedence {})::rest)),
(5,2,(fn Value.int(arg0)::_::rest => Value.precedence(Arg.left_precedence arg0)::rest|_=>raise (Fail "bad parser"))),
(5,2,(fn Value.int(arg0)::_::rest => Value.precedence(Arg.right_precedence arg0)::rest|_=>raise (Fail "bad parser"))),
(5,1,(fn _::rest => Value.precedence(Arg.no_precedence {})::rest|_=>raise (Fail "bad parser"))),
(6,4,(fn Value.precedence(arg0)::Value.symbol(arg1)::_::Value.constituents(arg2)::rest => Value.production(Arg.sole_production {3=arg0,2=arg1,1=arg2})::rest|_=>raise (Fail "bad parser"))),
(7,0,(fn rest => Value.productions(Arg.nil_productions {})::rest)),
(7,2,(fn Value.productions(arg0)::Value.production(arg1)::rest => Value.productions(Arg.cons_productions {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(8,2,(fn Value.symbol(arg0)::_::rest => Value.directive(Arg.name_directive arg0)::rest|_=>raise (Fail "bad parser"))),
(8,3,(fn Value.precedence(arg0)::Value.symbol(arg1)::_::rest => Value.directive(Arg.terminal_directive {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(8,5,(fn Value.precedence(arg0)::Value.symbol(arg1)::_::Value.symbol(arg2)::_::rest => Value.directive(Arg.terminal_of_directive {3=arg0,2=arg1,1=arg2})::rest|_=>raise (Fail "bad parser"))),
(8,6,(fn Value.productions(arg0)::_::Value.symbol(arg1)::_::Value.symbol(arg2)::_::rest => Value.directive(Arg.nonterminal_directive {3=arg0,2=arg1,1=arg2})::rest|_=>raise (Fail "bad parser"))),
(8,2,(fn Value.symbol(arg0)::_::rest => Value.directive(Arg.start_directive arg0)::rest|_=>raise (Fail "bad parser"))),
(9,0,(fn rest => Value.directives(Arg.nil_directives {})::rest)),
(9,2,(fn Value.directives(arg0)::Value.directive(arg1)::rest => Value.directives(Arg.cons_directives {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser")))],
(fn Value.directives x => x | _ => raise (Fail "bad parser")), Arg.error)
end
end
