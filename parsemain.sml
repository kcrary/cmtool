(*

State 0:

start -> . Directives  / 0
16 : Directive -> . NAME Ident  / 1
17 : Directive -> . TERMINAL Ident Precedence  / 1
18 : Directive -> . TERMINAL Ident OF Ident Precedence  / 1
19 : Directive -> . NONTERMINAL Ident COLON Ident EQUAL Productions  / 1
20 : Directive -> . START Ident  / 1
21 : Directive -> . FOLLOWER Ident  / 1
22 : Directives -> .  / 0
23 : Directives -> . Directive Directives  / 0

$ => reduce 22
FOLLOWER => shift 2
NAME => shift 4
NONTERMINAL => shift 3
START => shift 6
TERMINAL => shift 5
Directive => goto 1
Directives => goto 7

-----

State 1:

16 : Directive -> . NAME Ident  / 1
17 : Directive -> . TERMINAL Ident Precedence  / 1
18 : Directive -> . TERMINAL Ident OF Ident Precedence  / 1
19 : Directive -> . NONTERMINAL Ident COLON Ident EQUAL Productions  / 1
20 : Directive -> . START Ident  / 1
21 : Directive -> . FOLLOWER Ident  / 1
22 : Directives -> .  / 0
23 : Directives -> . Directive Directives  / 0
23 : Directives -> Directive . Directives  / 0

$ => reduce 22
FOLLOWER => shift 2
NAME => shift 4
NONTERMINAL => shift 3
START => shift 6
TERMINAL => shift 5
Directive => goto 1
Directives => goto 8

-----

State 2:

0 : Ident -> . IDENT  / 1
21 : Directive -> FOLLOWER . Ident  / 1

IDENT => shift 10
Ident => goto 9

-----

State 3:

0 : Ident -> . IDENT  / 2
19 : Directive -> NONTERMINAL . Ident COLON Ident EQUAL Productions  / 1

IDENT => shift 10
Ident => goto 11

-----

State 4:

0 : Ident -> . IDENT  / 1
16 : Directive -> NAME . Ident  / 1

IDENT => shift 10
Ident => goto 12

-----

State 5:

0 : Ident -> . IDENT  / 3
17 : Directive -> TERMINAL . Ident Precedence  / 1
18 : Directive -> TERMINAL . Ident OF Ident Precedence  / 1

IDENT => shift 10
Ident => goto 13

-----

State 6:

0 : Ident -> . IDENT  / 1
20 : Directive -> START . Ident  / 1

IDENT => shift 10
Ident => goto 14

-----

State 7:

start -> Directives .  / 0

$ => accept

-----

State 8:

23 : Directives -> Directive Directives .  / 0

$ => reduce 23

-----

State 9:

21 : Directive -> FOLLOWER Ident .  / 1

$ => reduce 21
FOLLOWER => reduce 21
NAME => reduce 21
NONTERMINAL => reduce 21
START => reduce 21
TERMINAL => reduce 21

-----

State 10:

0 : Ident -> IDENT .  / 4

$ => reduce 0
IDENT => reduce 0
NUMBER => reduce 0
ARROW => reduce 0
COLON => reduce 0
EQUAL => reduce 0
FOLLOWER => reduce 0
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

State 11:

19 : Directive -> NONTERMINAL Ident . COLON Ident EQUAL Productions  / 1

COLON => shift 15

-----

State 12:

16 : Directive -> NAME Ident .  / 1

$ => reduce 16
FOLLOWER => reduce 16
NAME => reduce 16
NONTERMINAL => reduce 16
START => reduce 16
TERMINAL => reduce 16

-----

State 13:

9 : Precedence -> .  / 1
10 : Precedence -> . PRECL Number  / 1
11 : Precedence -> . PRECR Number  / 1
12 : Precedence -> . NOPREC  / 1
17 : Directive -> TERMINAL Ident . Precedence  / 1
18 : Directive -> TERMINAL Ident . OF Ident Precedence  / 1

$ => reduce 9
FOLLOWER => reduce 9
NAME => reduce 9
NONTERMINAL => reduce 9
NOPREC => shift 17
OF => shift 16
PRECL => shift 19
PRECR => shift 20
START => reduce 9
TERMINAL => reduce 9
Precedence => goto 18

-----

State 14:

20 : Directive -> START Ident .  / 1

$ => reduce 20
FOLLOWER => reduce 20
NAME => reduce 20
NONTERMINAL => reduce 20
START => reduce 20
TERMINAL => reduce 20

-----

State 15:

0 : Ident -> . IDENT  / 5
19 : Directive -> NONTERMINAL Ident COLON . Ident EQUAL Productions  / 1

IDENT => shift 10
Ident => goto 21

-----

State 16:

0 : Ident -> . IDENT  / 6
18 : Directive -> TERMINAL Ident OF . Ident Precedence  / 1

IDENT => shift 10
Ident => goto 22

-----

State 17:

12 : Precedence -> NOPREC .  / 7

$ => reduce 12
IDENT => reduce 12
NUMBER => reduce 12
ARROW => reduce 12
FOLLOWER => reduce 12
NAME => reduce 12
NONTERMINAL => reduce 12
LPAREN => reduce 12
START => reduce 12
TERMINAL => reduce 12

-----

State 18:

17 : Directive -> TERMINAL Ident Precedence .  / 1

$ => reduce 17
FOLLOWER => reduce 17
NAME => reduce 17
NONTERMINAL => reduce 17
START => reduce 17
TERMINAL => reduce 17

-----

State 19:

1 : Number -> . NUMBER  / 7
10 : Precedence -> PRECL . Number  / 7

NUMBER => shift 24
Number => goto 23

-----

State 20:

1 : Number -> . NUMBER  / 7
11 : Precedence -> PRECR . Number  / 7

NUMBER => shift 24
Number => goto 25

-----

State 21:

19 : Directive -> NONTERMINAL Ident COLON Ident . EQUAL Productions  / 1

EQUAL => shift 26

-----

State 22:

9 : Precedence -> .  / 1
10 : Precedence -> . PRECL Number  / 1
11 : Precedence -> . PRECR Number  / 1
12 : Precedence -> . NOPREC  / 1
18 : Directive -> TERMINAL Ident OF Ident . Precedence  / 1

$ => reduce 9
FOLLOWER => reduce 9
NAME => reduce 9
NONTERMINAL => reduce 9
NOPREC => shift 17
PRECL => shift 19
PRECR => shift 20
START => reduce 9
TERMINAL => reduce 9
Precedence => goto 27

-----

State 23:

10 : Precedence -> PRECL Number .  / 7

$ => reduce 10
IDENT => reduce 10
NUMBER => reduce 10
ARROW => reduce 10
FOLLOWER => reduce 10
NAME => reduce 10
NONTERMINAL => reduce 10
LPAREN => reduce 10
START => reduce 10
TERMINAL => reduce 10

-----

State 24:

1 : Number -> NUMBER .  / 8

$ => reduce 1
IDENT => reduce 1
NUMBER => reduce 1
ARROW => reduce 1
COLON => reduce 1
FOLLOWER => reduce 1
NAME => reduce 1
NONTERMINAL => reduce 1
LPAREN => reduce 1
START => reduce 1
TERMINAL => reduce 1

-----

State 25:

11 : Precedence -> PRECR Number .  / 7

$ => reduce 11
IDENT => reduce 11
NUMBER => reduce 11
ARROW => reduce 11
FOLLOWER => reduce 11
NAME => reduce 11
NONTERMINAL => reduce 11
LPAREN => reduce 11
START => reduce 11
TERMINAL => reduce 11

-----

State 26:

0 : Ident -> . IDENT  / 9
1 : Number -> . NUMBER  / 2
2 : Label -> . Ident  / 2
3 : Label -> . Number  / 2
4 : Constituent -> . Ident  / 10
5 : Constituent -> . Label COLON Ident  / 10
6 : Constituent -> . LPAREN Constituent RPAREN  / 10
7 : Constituents -> .  / 11
8 : Constituents -> . Constituent Constituents  / 11
13 : Production -> . Constituents ARROW Ident Precedence  / 7
14 : Productions -> .  / 1
15 : Productions -> . Production Productions  / 1
19 : Directive -> NONTERMINAL Ident COLON Ident EQUAL . Productions  / 1

$ => reduce 14
IDENT => shift 10
NUMBER => shift 24
ARROW => reduce 7
FOLLOWER => reduce 14
NAME => reduce 14
NONTERMINAL => reduce 14
LPAREN => shift 33
START => reduce 14
TERMINAL => reduce 14
Ident => goto 34
Number => goto 35
Label => goto 32
Constituent => goto 31
Constituents => goto 30
Production => goto 29
Productions => goto 28

-----

State 27:

18 : Directive -> TERMINAL Ident OF Ident Precedence .  / 1

$ => reduce 18
FOLLOWER => reduce 18
NAME => reduce 18
NONTERMINAL => reduce 18
START => reduce 18
TERMINAL => reduce 18

-----

State 28:

19 : Directive -> NONTERMINAL Ident COLON Ident EQUAL Productions .  / 1

$ => reduce 19
FOLLOWER => reduce 19
NAME => reduce 19
NONTERMINAL => reduce 19
START => reduce 19
TERMINAL => reduce 19

-----

State 29:

0 : Ident -> . IDENT  / 9
1 : Number -> . NUMBER  / 2
2 : Label -> . Ident  / 2
3 : Label -> . Number  / 2
4 : Constituent -> . Ident  / 10
5 : Constituent -> . Label COLON Ident  / 10
6 : Constituent -> . LPAREN Constituent RPAREN  / 10
7 : Constituents -> .  / 11
8 : Constituents -> . Constituent Constituents  / 11
13 : Production -> . Constituents ARROW Ident Precedence  / 7
14 : Productions -> .  / 1
15 : Productions -> . Production Productions  / 1
15 : Productions -> Production . Productions  / 1

$ => reduce 14
IDENT => shift 10
NUMBER => shift 24
ARROW => reduce 7
FOLLOWER => reduce 14
NAME => reduce 14
NONTERMINAL => reduce 14
LPAREN => shift 33
START => reduce 14
TERMINAL => reduce 14
Ident => goto 34
Number => goto 35
Label => goto 32
Constituent => goto 31
Constituents => goto 30
Production => goto 29
Productions => goto 36

-----

State 30:

13 : Production -> Constituents . ARROW Ident Precedence  / 7

ARROW => shift 37

-----

State 31:

0 : Ident -> . IDENT  / 9
1 : Number -> . NUMBER  / 2
2 : Label -> . Ident  / 2
3 : Label -> . Number  / 2
4 : Constituent -> . Ident  / 10
5 : Constituent -> . Label COLON Ident  / 10
6 : Constituent -> . LPAREN Constituent RPAREN  / 10
7 : Constituents -> .  / 11
8 : Constituents -> . Constituent Constituents  / 11
8 : Constituents -> Constituent . Constituents  / 11

IDENT => shift 10
NUMBER => shift 24
ARROW => reduce 7
LPAREN => shift 33
Ident => goto 34
Number => goto 35
Label => goto 32
Constituent => goto 31
Constituents => goto 38

-----

State 32:

5 : Constituent -> Label . COLON Ident  / 12

COLON => shift 39

-----

State 33:

0 : Ident -> . IDENT  / 13
1 : Number -> . NUMBER  / 2
2 : Label -> . Ident  / 2
3 : Label -> . Number  / 2
4 : Constituent -> . Ident  / 14
5 : Constituent -> . Label COLON Ident  / 14
6 : Constituent -> . LPAREN Constituent RPAREN  / 14
6 : Constituent -> LPAREN . Constituent RPAREN  / 12

IDENT => shift 10
NUMBER => shift 24
LPAREN => shift 33
Ident => goto 34
Number => goto 35
Label => goto 32
Constituent => goto 40

-----

State 34:

2 : Label -> Ident .  / 2
4 : Constituent -> Ident .  / 12

IDENT => reduce 4
NUMBER => reduce 4
ARROW => reduce 4
COLON => reduce 2
LPAREN => reduce 4
RPAREN => reduce 4

-----

State 35:

3 : Label -> Number .  / 2

COLON => reduce 3

-----

State 36:

15 : Productions -> Production Productions .  / 1

$ => reduce 15
FOLLOWER => reduce 15
NAME => reduce 15
NONTERMINAL => reduce 15
START => reduce 15
TERMINAL => reduce 15

-----

State 37:

0 : Ident -> . IDENT  / 15
13 : Production -> Constituents ARROW . Ident Precedence  / 7

IDENT => shift 10
Ident => goto 41

-----

State 38:

8 : Constituents -> Constituent Constituents .  / 11

ARROW => reduce 8

-----

State 39:

0 : Ident -> . IDENT  / 12
5 : Constituent -> Label COLON . Ident  / 12

IDENT => shift 10
Ident => goto 42

-----

State 40:

6 : Constituent -> LPAREN Constituent . RPAREN  / 12

RPAREN => shift 43

-----

State 41:

9 : Precedence -> .  / 7
10 : Precedence -> . PRECL Number  / 7
11 : Precedence -> . PRECR Number  / 7
12 : Precedence -> . NOPREC  / 7
13 : Production -> Constituents ARROW Ident . Precedence  / 7

$ => reduce 9
IDENT => reduce 9
NUMBER => reduce 9
ARROW => reduce 9
FOLLOWER => reduce 9
NAME => reduce 9
NONTERMINAL => reduce 9
NOPREC => shift 17
LPAREN => reduce 9
PRECL => shift 19
PRECR => shift 20
START => reduce 9
TERMINAL => reduce 9
Precedence => goto 44

-----

State 42:

5 : Constituent -> Label COLON Ident .  / 12

IDENT => reduce 5
NUMBER => reduce 5
ARROW => reduce 5
LPAREN => reduce 5
RPAREN => reduce 5

-----

State 43:

6 : Constituent -> LPAREN Constituent RPAREN .  / 12

IDENT => reduce 6
NUMBER => reduce 6
ARROW => reduce 6
LPAREN => reduce 6
RPAREN => reduce 6

-----

State 44:

13 : Production -> Constituents ARROW Ident Precedence .  / 7

$ => reduce 13
IDENT => reduce 13
NUMBER => reduce 13
ARROW => reduce 13
FOLLOWER => reduce 13
NAME => reduce 13
NONTERMINAL => reduce 13
LPAREN => reduce 13
START => reduce 13
TERMINAL => reduce 13

-----

lookahead 0 = $ 
lookahead 1 = $ FOLLOWER NAME NONTERMINAL START TERMINAL 
lookahead 2 = COLON 
lookahead 3 = $ FOLLOWER NAME NONTERMINAL NOPREC OF PRECL PRECR START TERMINAL 
lookahead 4 = $ IDENT NUMBER ARROW COLON EQUAL FOLLOWER NAME NONTERMINAL NOPREC LPAREN OF PRECL PRECR RPAREN START TERMINAL 
lookahead 5 = EQUAL 
lookahead 6 = $ FOLLOWER NAME NONTERMINAL NOPREC PRECL PRECR START TERMINAL 
lookahead 7 = $ IDENT NUMBER ARROW FOLLOWER NAME NONTERMINAL LPAREN START TERMINAL 
lookahead 8 = $ IDENT NUMBER ARROW COLON FOLLOWER NAME NONTERMINAL LPAREN START TERMINAL 
lookahead 9 = IDENT NUMBER ARROW COLON LPAREN 
lookahead 10 = IDENT NUMBER ARROW LPAREN 
lookahead 11 = ARROW 
lookahead 12 = IDENT NUMBER ARROW LPAREN RPAREN 
lookahead 13 = COLON RPAREN 
lookahead 14 = RPAREN 
lookahead 15 = $ IDENT NUMBER ARROW FOLLOWER NAME NONTERMINAL NOPREC LPAREN PRECL PRECR START TERMINAL 

*)

functor ParseMainFun (structure Streamable : STREAMABLE
structure Arg : sig
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
val cons_directives : {1:directive, 2:directives} -> directives
val nil_directives : {} -> directives
val follower_directive : symbol -> directive
val start_directive : symbol -> directive
val nonterminal_directive : {1:symbol, 2:symbol, 3:productions} -> directive
val terminal_of_directive : {1:symbol, 2:symbol, 3:precedence} -> directive
val terminal_directive : {1:symbol, 2:precedence} -> directive
val name_directive : symbol -> directive
val cons_productions : {1:production, 2:productions} -> productions
val nil_productions : {} -> productions
val sole_production : {1:constituents, 2:symbol, 3:precedence} -> production
val no_precedence : {} -> precedence
val right_precedence : int -> precedence
val left_precedence : int -> precedence
val empty_precedence : {} -> precedence
val cons_constituents : {1:constituent, 2:constituents} -> constituents
val nil_constituents : {} -> constituents
val paren_item : constituent -> constituent
val labeled_item : {1:label, 2:symbol} -> constituent
val unlabeled_item : symbol -> constituent
val number_label : int -> label
val ident_label : symbol -> label
val sole_number : int -> int
val sole_ident : symbol -> symbol
datatype terminal =
IDENT of symbol
| NUMBER of int
| ARROW
| COLON
| EQUAL
| FOLLOWER
| NAME
| NONTERMINAL
| NOPREC
| LPAREN
| OF
| PRECL
| PRECR
| RPAREN
| START
| TERMINAL
val error : terminal Streamable.t -> exn
end)
=
struct
local
structure Value = struct
datatype nonterminal =
nonterminal
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
Arg.IDENT x => (1, Value.symbol x)
| Arg.NUMBER x => (2, Value.int x)
| Arg.ARROW => (3, Value.nonterminal)
| Arg.COLON => (4, Value.nonterminal)
| Arg.EQUAL => (5, Value.nonterminal)
| Arg.FOLLOWER => (6, Value.nonterminal)
| Arg.NAME => (7, Value.nonterminal)
| Arg.NONTERMINAL => (8, Value.nonterminal)
| Arg.NOPREC => (9, Value.nonterminal)
| Arg.LPAREN => (10, Value.nonterminal)
| Arg.OF => (11, Value.nonterminal)
| Arg.PRECL => (12, Value.nonterminal)
| Arg.PRECR => (13, Value.nonterminal)
| Arg.RPAREN => (14, Value.nonterminal)
| Arg.START => (15, Value.nonterminal)
| Arg.TERMINAL => (16, Value.nonterminal)
)
)
in
val parse = ParseEngine.parse (
ParseEngine.next5x1 "h\128\128\128\128\128\131\133\132\128\128\128\128\128\128\135\134\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128h\128\128\128\128\128\131\133\132\128\128\128\128\128\128\135\134\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\127\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128g\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128i\128\128\128\128\128iii\128\128\128\128\128\128ii\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128~~~~~~~~~~~~~~~~~\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\144\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128n\128\128\128\128\128nnn\128\128\128\128\128\128nn\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128u\128\128\128\128\128uuu\146\128\145\148\149\128uu\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128j\128\128\128\128\128jjj\128\128\128\128\128\128jj\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128rrrr\128\128rrr\128r\128\128\128\128rr\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128m\128\128\128\128\128mmm\128\128\128\128\128\128mm\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\153\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\153\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128u\128\128\128\128\128uuu\146\128\128\148\149\128uu\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128tttt\128\128ttt\128t\128\128\128\128tt\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128}}}}}\128}}}\128}\128\128\128\128}}\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128ssss\128\128sss\128s\128\128\128\128ss\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128p\139\153w\128\128ppp\128\162\128\128\128\128pp\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128l\128\128\128\128\128lll\128\128\128\128\128\128ll\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128k\128\128\128\128\128kkk\128\128\128\128\128\128kk\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128p\139\153w\128\128ppp\128\162\128\128\128\128pp\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\166\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\153w\128\128\128\128\128\128\162\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\168\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\153\128\128\128\128\128\128\128\162\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128zzz|\128\128\128\128\128z\128\128\128z\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128{\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128o\128\128\128\128\128ooo\128\128\128\128\128\128oo\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128v\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\172\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128uuuu\128\128uuu\146u\128\148\149\128uu\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128yyy\128\128\128\128\128\128y\128\128\128y\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128xxx\128\128\128\128\128\128x\128\128\128x\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128qqqq\128\128qqq\128q\128\128\128\128qq\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
ParseEngine.next5x1 "\128\128\128\128\128\128\128\128\129\135\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\129\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\141\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\149\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\150\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\151\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\153\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\163\160\159\158\128\157\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\163\160\159\158\128\157\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\163\160\159\166\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\163\160\168\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\169\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\170\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\172\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
Vector.fromList [(0,1,(fn Value.symbol(arg0)::rest => Value.symbol(Arg.sole_ident arg0)::rest|_=>raise (Fail "bad parser"))),
(1,1,(fn Value.int(arg0)::rest => Value.int(Arg.sole_number arg0)::rest|_=>raise (Fail "bad parser"))),
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
(8,2,(fn Value.symbol(arg0)::_::rest => Value.directive(Arg.follower_directive arg0)::rest|_=>raise (Fail "bad parser"))),
(9,0,(fn rest => Value.directives(Arg.nil_directives {})::rest)),
(9,2,(fn Value.directives(arg0)::Value.directive(arg1)::rest => Value.directives(Arg.cons_directives {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser")))],
(fn Value.directives x => x | _ => raise (Fail "bad parser")), Arg.error)
end
end
