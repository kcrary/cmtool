
functor ParseMainFunHs
   (structure Streamable : STREAMABLE
    structure Arg :
       sig
          type string
          type int
          type symbol
          type label
          type constituent
          type constituents
          type precedence
          type production
          type productions
          type qident
          type directive
          type directives

          val cons_directives : directive * directives -> directives
          val nil_directives : unit -> directives
          val follower_directive : symbol -> directive
          val start_directive : symbol -> directive
          val nonterminal_directive : symbol * symbol * productions -> directive
          val terminal_of_directive : symbol * symbol * precedence -> directive
          val terminal_directive : symbol * precedence -> directive
          val monadic_directive : unit -> directive
          val data_directive : string -> directive
          val name_directive : qident -> directive
          val cons_qident : string * qident -> qident
          val sing_qident : string -> qident
          val cons_productions : production * productions -> productions
          val nil_productions : unit -> productions
          val sole_production : constituents * symbol * precedence -> production
          val no_precedence : unit -> precedence
          val right_precedence : int -> precedence
          val left_precedence : int -> precedence
          val empty_precedence : unit -> precedence
          val cons_constituents : constituent * constituents -> constituents
          val nil_constituents : unit -> constituents
          val paren_item : constituent -> constituent
          val labeled_item : label * symbol -> constituent
          val unlabeled_item : symbol -> constituent
          val number_label : int -> label
          val sole_number : int -> int
          val sole_uident : string -> symbol
          val sole_lident : string -> symbol

          datatype terminal =
             LIDENT of string
           | UIDENT of string
           | NUMBER of int
           | ARROW
           | COLON
           | DATA
           | DOT
           | EQUAL
           | FOLLOWER
           | MONADIC
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
   :>
   sig
      val parse : Arg.terminal Streamable.t -> Arg.directives * Arg.terminal Streamable.t
   end
=

(*

State 0:

start -> . Directives  / 0
18 : Directive -> . NAME QIdent  / 1
19 : Directive -> . DATA UIDENT  / 1
20 : Directive -> . MONADIC  / 1
21 : Directive -> . TERMINAL UIdent Precedence  / 1
22 : Directive -> . TERMINAL UIdent OF LIdent Precedence  / 1
23 : Directive -> . NONTERMINAL UIdent COLON LIdent EQUAL Productions  / 1
24 : Directive -> . START UIdent  / 1
25 : Directive -> . FOLLOWER UIdent  / 1
26 : Directives -> .  / 0
27 : Directives -> . Directive Directives  / 0

$ => reduce 26
DATA => shift 4
FOLLOWER => shift 3
MONADIC => shift 5
NAME => shift 6
NONTERMINAL => shift 2
START => shift 8
TERMINAL => shift 7
Directive => goto 1
Directives => goto 9

-----

State 1:

18 : Directive -> . NAME QIdent  / 1
19 : Directive -> . DATA UIDENT  / 1
20 : Directive -> . MONADIC  / 1
21 : Directive -> . TERMINAL UIdent Precedence  / 1
22 : Directive -> . TERMINAL UIdent OF LIdent Precedence  / 1
23 : Directive -> . NONTERMINAL UIdent COLON LIdent EQUAL Productions  / 1
24 : Directive -> . START UIdent  / 1
25 : Directive -> . FOLLOWER UIdent  / 1
26 : Directives -> .  / 0
27 : Directives -> . Directive Directives  / 0
27 : Directives -> Directive . Directives  / 0

$ => reduce 26
DATA => shift 4
FOLLOWER => shift 3
MONADIC => shift 5
NAME => shift 6
NONTERMINAL => shift 2
START => shift 8
TERMINAL => shift 7
Directive => goto 1
Directives => goto 10

-----

State 2:

1 : UIdent -> . UIDENT  / 2
23 : Directive -> NONTERMINAL . UIdent COLON LIdent EQUAL Productions  / 1

UIDENT => shift 12
UIdent => goto 11

-----

State 3:

1 : UIdent -> . UIDENT  / 1
25 : Directive -> FOLLOWER . UIdent  / 1

UIDENT => shift 12
UIdent => goto 13

-----

State 4:

19 : Directive -> DATA . UIDENT  / 1

UIDENT => shift 14

-----

State 5:

20 : Directive -> MONADIC .  / 1

$ => reduce 20
DATA => reduce 20
FOLLOWER => reduce 20
MONADIC => reduce 20
NAME => reduce 20
NONTERMINAL => reduce 20
START => reduce 20
TERMINAL => reduce 20

-----

State 6:

16 : QIdent -> . UIDENT  / 1
17 : QIdent -> . UIDENT DOT QIdent  / 1
18 : Directive -> NAME . QIdent  / 1

UIDENT => shift 16
QIdent => goto 15

-----

State 7:

1 : UIdent -> . UIDENT  / 3
21 : Directive -> TERMINAL . UIdent Precedence  / 1
22 : Directive -> TERMINAL . UIdent OF LIdent Precedence  / 1

UIDENT => shift 12
UIdent => goto 17

-----

State 8:

1 : UIdent -> . UIDENT  / 1
24 : Directive -> START . UIdent  / 1

UIDENT => shift 12
UIdent => goto 18

-----

State 9:

start -> Directives .  / 0

$ => accept

-----

State 10:

27 : Directives -> Directive Directives .  / 0

$ => reduce 27

-----

State 11:

23 : Directive -> NONTERMINAL UIdent . COLON LIdent EQUAL Productions  / 1

COLON => shift 19

-----

State 12:

1 : UIdent -> UIDENT .  / 4

$ => reduce 1
UIDENT => reduce 1
NUMBER => reduce 1
ARROW => reduce 1
COLON => reduce 1
DATA => reduce 1
FOLLOWER => reduce 1
MONADIC => reduce 1
NAME => reduce 1
NONTERMINAL => reduce 1
NOPREC => reduce 1
LPAREN => reduce 1
OF => reduce 1
PRECL => reduce 1
PRECR => reduce 1
RPAREN => reduce 1
START => reduce 1
TERMINAL => reduce 1

-----

State 13:

25 : Directive -> FOLLOWER UIdent .  / 1

$ => reduce 25
DATA => reduce 25
FOLLOWER => reduce 25
MONADIC => reduce 25
NAME => reduce 25
NONTERMINAL => reduce 25
START => reduce 25
TERMINAL => reduce 25

-----

State 14:

19 : Directive -> DATA UIDENT .  / 1

$ => reduce 19
DATA => reduce 19
FOLLOWER => reduce 19
MONADIC => reduce 19
NAME => reduce 19
NONTERMINAL => reduce 19
START => reduce 19
TERMINAL => reduce 19

-----

State 15:

18 : Directive -> NAME QIdent .  / 1

$ => reduce 18
DATA => reduce 18
FOLLOWER => reduce 18
MONADIC => reduce 18
NAME => reduce 18
NONTERMINAL => reduce 18
START => reduce 18
TERMINAL => reduce 18

-----

State 16:

16 : QIdent -> UIDENT .  / 1
17 : QIdent -> UIDENT . DOT QIdent  / 1

$ => reduce 16
DATA => reduce 16
DOT => shift 20
FOLLOWER => reduce 16
MONADIC => reduce 16
NAME => reduce 16
NONTERMINAL => reduce 16
START => reduce 16
TERMINAL => reduce 16

-----

State 17:

9 : Precedence -> .  / 1
10 : Precedence -> . PRECL Number  / 1
11 : Precedence -> . PRECR Number  / 1
12 : Precedence -> . NOPREC  / 1
21 : Directive -> TERMINAL UIdent . Precedence  / 1
22 : Directive -> TERMINAL UIdent . OF LIdent Precedence  / 1

$ => reduce 9
DATA => reduce 9
FOLLOWER => reduce 9
MONADIC => reduce 9
NAME => reduce 9
NONTERMINAL => reduce 9
NOPREC => shift 22
OF => shift 21
PRECL => shift 24
PRECR => shift 25
START => reduce 9
TERMINAL => reduce 9
Precedence => goto 23

-----

State 18:

24 : Directive -> START UIdent .  / 1

$ => reduce 24
DATA => reduce 24
FOLLOWER => reduce 24
MONADIC => reduce 24
NAME => reduce 24
NONTERMINAL => reduce 24
START => reduce 24
TERMINAL => reduce 24

-----

State 19:

0 : LIdent -> . LIDENT  / 5
23 : Directive -> NONTERMINAL UIdent COLON . LIdent EQUAL Productions  / 1

LIDENT => shift 27
LIdent => goto 26

-----

State 20:

16 : QIdent -> . UIDENT  / 1
17 : QIdent -> . UIDENT DOT QIdent  / 1
17 : QIdent -> UIDENT DOT . QIdent  / 1

UIDENT => shift 16
QIdent => goto 28

-----

State 21:

0 : LIdent -> . LIDENT  / 6
22 : Directive -> TERMINAL UIdent OF . LIdent Precedence  / 1

LIDENT => shift 27
LIdent => goto 29

-----

State 22:

12 : Precedence -> NOPREC .  / 7

$ => reduce 12
UIDENT => reduce 12
NUMBER => reduce 12
ARROW => reduce 12
DATA => reduce 12
FOLLOWER => reduce 12
MONADIC => reduce 12
NAME => reduce 12
NONTERMINAL => reduce 12
LPAREN => reduce 12
START => reduce 12
TERMINAL => reduce 12

-----

State 23:

21 : Directive -> TERMINAL UIdent Precedence .  / 1

$ => reduce 21
DATA => reduce 21
FOLLOWER => reduce 21
MONADIC => reduce 21
NAME => reduce 21
NONTERMINAL => reduce 21
START => reduce 21
TERMINAL => reduce 21

-----

State 24:

2 : Number -> . NUMBER  / 7
10 : Precedence -> PRECL . Number  / 7

NUMBER => shift 31
Number => goto 30

-----

State 25:

2 : Number -> . NUMBER  / 7
11 : Precedence -> PRECR . Number  / 7

NUMBER => shift 31
Number => goto 32

-----

State 26:

23 : Directive -> NONTERMINAL UIdent COLON LIdent . EQUAL Productions  / 1

EQUAL => shift 33

-----

State 27:

0 : LIdent -> LIDENT .  / 8

$ => reduce 0
UIDENT => reduce 0
NUMBER => reduce 0
ARROW => reduce 0
DATA => reduce 0
EQUAL => reduce 0
FOLLOWER => reduce 0
MONADIC => reduce 0
NAME => reduce 0
NONTERMINAL => reduce 0
NOPREC => reduce 0
LPAREN => reduce 0
PRECL => reduce 0
PRECR => reduce 0
START => reduce 0
TERMINAL => reduce 0

-----

State 28:

17 : QIdent -> UIDENT DOT QIdent .  / 1

$ => reduce 17
DATA => reduce 17
FOLLOWER => reduce 17
MONADIC => reduce 17
NAME => reduce 17
NONTERMINAL => reduce 17
START => reduce 17
TERMINAL => reduce 17

-----

State 29:

9 : Precedence -> .  / 1
10 : Precedence -> . PRECL Number  / 1
11 : Precedence -> . PRECR Number  / 1
12 : Precedence -> . NOPREC  / 1
22 : Directive -> TERMINAL UIdent OF LIdent . Precedence  / 1

$ => reduce 9
DATA => reduce 9
FOLLOWER => reduce 9
MONADIC => reduce 9
NAME => reduce 9
NONTERMINAL => reduce 9
NOPREC => shift 22
PRECL => shift 24
PRECR => shift 25
START => reduce 9
TERMINAL => reduce 9
Precedence => goto 34

-----

State 30:

10 : Precedence -> PRECL Number .  / 7

$ => reduce 10
UIDENT => reduce 10
NUMBER => reduce 10
ARROW => reduce 10
DATA => reduce 10
FOLLOWER => reduce 10
MONADIC => reduce 10
NAME => reduce 10
NONTERMINAL => reduce 10
LPAREN => reduce 10
START => reduce 10
TERMINAL => reduce 10

-----

State 31:

2 : Number -> NUMBER .  / 9

$ => reduce 2
UIDENT => reduce 2
NUMBER => reduce 2
ARROW => reduce 2
COLON => reduce 2
DATA => reduce 2
FOLLOWER => reduce 2
MONADIC => reduce 2
NAME => reduce 2
NONTERMINAL => reduce 2
LPAREN => reduce 2
START => reduce 2
TERMINAL => reduce 2

-----

State 32:

11 : Precedence -> PRECR Number .  / 7

$ => reduce 11
UIDENT => reduce 11
NUMBER => reduce 11
ARROW => reduce 11
DATA => reduce 11
FOLLOWER => reduce 11
MONADIC => reduce 11
NAME => reduce 11
NONTERMINAL => reduce 11
LPAREN => reduce 11
START => reduce 11
TERMINAL => reduce 11

-----

State 33:

1 : UIdent -> . UIDENT  / 10
2 : Number -> . NUMBER  / 2
3 : Label -> . Number  / 2
4 : Constituent -> . UIdent  / 10
5 : Constituent -> . Label COLON UIdent  / 10
6 : Constituent -> . LPAREN Constituent RPAREN  / 10
7 : Constituents -> .  / 11
8 : Constituents -> . Constituent Constituents  / 11
13 : Production -> . Constituents ARROW LIdent Precedence  / 7
14 : Productions -> .  / 1
15 : Productions -> . Production Productions  / 1
23 : Directive -> NONTERMINAL UIdent COLON LIdent EQUAL . Productions  / 1

$ => reduce 14
UIDENT => shift 12
NUMBER => shift 31
ARROW => reduce 7
DATA => reduce 14
FOLLOWER => reduce 14
MONADIC => reduce 14
NAME => reduce 14
NONTERMINAL => reduce 14
LPAREN => shift 40
START => reduce 14
TERMINAL => reduce 14
UIdent => goto 41
Number => goto 42
Label => goto 39
Constituent => goto 38
Constituents => goto 37
Production => goto 36
Productions => goto 35

-----

State 34:

22 : Directive -> TERMINAL UIdent OF LIdent Precedence .  / 1

$ => reduce 22
DATA => reduce 22
FOLLOWER => reduce 22
MONADIC => reduce 22
NAME => reduce 22
NONTERMINAL => reduce 22
START => reduce 22
TERMINAL => reduce 22

-----

State 35:

23 : Directive -> NONTERMINAL UIdent COLON LIdent EQUAL Productions .  / 1

$ => reduce 23
DATA => reduce 23
FOLLOWER => reduce 23
MONADIC => reduce 23
NAME => reduce 23
NONTERMINAL => reduce 23
START => reduce 23
TERMINAL => reduce 23

-----

State 36:

1 : UIdent -> . UIDENT  / 10
2 : Number -> . NUMBER  / 2
3 : Label -> . Number  / 2
4 : Constituent -> . UIdent  / 10
5 : Constituent -> . Label COLON UIdent  / 10
6 : Constituent -> . LPAREN Constituent RPAREN  / 10
7 : Constituents -> .  / 11
8 : Constituents -> . Constituent Constituents  / 11
13 : Production -> . Constituents ARROW LIdent Precedence  / 7
14 : Productions -> .  / 1
15 : Productions -> . Production Productions  / 1
15 : Productions -> Production . Productions  / 1

$ => reduce 14
UIDENT => shift 12
NUMBER => shift 31
ARROW => reduce 7
DATA => reduce 14
FOLLOWER => reduce 14
MONADIC => reduce 14
NAME => reduce 14
NONTERMINAL => reduce 14
LPAREN => shift 40
START => reduce 14
TERMINAL => reduce 14
UIdent => goto 41
Number => goto 42
Label => goto 39
Constituent => goto 38
Constituents => goto 37
Production => goto 36
Productions => goto 43

-----

State 37:

13 : Production -> Constituents . ARROW LIdent Precedence  / 7

ARROW => shift 44

-----

State 38:

1 : UIdent -> . UIDENT  / 10
2 : Number -> . NUMBER  / 2
3 : Label -> . Number  / 2
4 : Constituent -> . UIdent  / 10
5 : Constituent -> . Label COLON UIdent  / 10
6 : Constituent -> . LPAREN Constituent RPAREN  / 10
7 : Constituents -> .  / 11
8 : Constituents -> . Constituent Constituents  / 11
8 : Constituents -> Constituent . Constituents  / 11

UIDENT => shift 12
NUMBER => shift 31
ARROW => reduce 7
LPAREN => shift 40
UIdent => goto 41
Number => goto 42
Label => goto 39
Constituent => goto 38
Constituents => goto 45

-----

State 39:

5 : Constituent -> Label . COLON UIdent  / 12

COLON => shift 46

-----

State 40:

1 : UIdent -> . UIDENT  / 13
2 : Number -> . NUMBER  / 2
3 : Label -> . Number  / 2
4 : Constituent -> . UIdent  / 13
5 : Constituent -> . Label COLON UIdent  / 13
6 : Constituent -> . LPAREN Constituent RPAREN  / 13
6 : Constituent -> LPAREN . Constituent RPAREN  / 12

UIDENT => shift 12
NUMBER => shift 31
LPAREN => shift 40
UIdent => goto 41
Number => goto 42
Label => goto 39
Constituent => goto 47

-----

State 41:

4 : Constituent -> UIdent .  / 12

UIDENT => reduce 4
NUMBER => reduce 4
ARROW => reduce 4
LPAREN => reduce 4
RPAREN => reduce 4

-----

State 42:

3 : Label -> Number .  / 2

COLON => reduce 3

-----

State 43:

15 : Productions -> Production Productions .  / 1

$ => reduce 15
DATA => reduce 15
FOLLOWER => reduce 15
MONADIC => reduce 15
NAME => reduce 15
NONTERMINAL => reduce 15
START => reduce 15
TERMINAL => reduce 15

-----

State 44:

0 : LIdent -> . LIDENT  / 14
13 : Production -> Constituents ARROW . LIdent Precedence  / 7

LIDENT => shift 27
LIdent => goto 48

-----

State 45:

8 : Constituents -> Constituent Constituents .  / 11

ARROW => reduce 8

-----

State 46:

1 : UIdent -> . UIDENT  / 12
5 : Constituent -> Label COLON . UIdent  / 12

UIDENT => shift 12
UIdent => goto 49

-----

State 47:

6 : Constituent -> LPAREN Constituent . RPAREN  / 12

RPAREN => shift 50

-----

State 48:

9 : Precedence -> .  / 7
10 : Precedence -> . PRECL Number  / 7
11 : Precedence -> . PRECR Number  / 7
12 : Precedence -> . NOPREC  / 7
13 : Production -> Constituents ARROW LIdent . Precedence  / 7

$ => reduce 9
UIDENT => reduce 9
NUMBER => reduce 9
ARROW => reduce 9
DATA => reduce 9
FOLLOWER => reduce 9
MONADIC => reduce 9
NAME => reduce 9
NONTERMINAL => reduce 9
NOPREC => shift 22
LPAREN => reduce 9
PRECL => shift 24
PRECR => shift 25
START => reduce 9
TERMINAL => reduce 9
Precedence => goto 51

-----

State 49:

5 : Constituent -> Label COLON UIdent .  / 12

UIDENT => reduce 5
NUMBER => reduce 5
ARROW => reduce 5
LPAREN => reduce 5
RPAREN => reduce 5

-----

State 50:

6 : Constituent -> LPAREN Constituent RPAREN .  / 12

UIDENT => reduce 6
NUMBER => reduce 6
ARROW => reduce 6
LPAREN => reduce 6
RPAREN => reduce 6

-----

State 51:

13 : Production -> Constituents ARROW LIdent Precedence .  / 7

$ => reduce 13
UIDENT => reduce 13
NUMBER => reduce 13
ARROW => reduce 13
DATA => reduce 13
FOLLOWER => reduce 13
MONADIC => reduce 13
NAME => reduce 13
NONTERMINAL => reduce 13
LPAREN => reduce 13
START => reduce 13
TERMINAL => reduce 13

-----

lookahead 0 = $ 
lookahead 1 = $ DATA FOLLOWER MONADIC NAME NONTERMINAL START TERMINAL 
lookahead 2 = COLON 
lookahead 3 = $ DATA FOLLOWER MONADIC NAME NONTERMINAL NOPREC OF PRECL PRECR START TERMINAL 
lookahead 4 = $ UIDENT NUMBER ARROW COLON DATA FOLLOWER MONADIC NAME NONTERMINAL NOPREC LPAREN OF PRECL PRECR RPAREN START TERMINAL 
lookahead 5 = EQUAL 
lookahead 6 = $ DATA FOLLOWER MONADIC NAME NONTERMINAL NOPREC PRECL PRECR START TERMINAL 
lookahead 7 = $ UIDENT NUMBER ARROW DATA FOLLOWER MONADIC NAME NONTERMINAL LPAREN START TERMINAL 
lookahead 8 = $ UIDENT NUMBER ARROW DATA EQUAL FOLLOWER MONADIC NAME NONTERMINAL NOPREC LPAREN PRECL PRECR START TERMINAL 
lookahead 9 = $ UIDENT NUMBER ARROW COLON DATA FOLLOWER MONADIC NAME NONTERMINAL LPAREN START TERMINAL 
lookahead 10 = UIDENT NUMBER ARROW LPAREN 
lookahead 11 = ARROW 
lookahead 12 = UIDENT NUMBER ARROW LPAREN RPAREN 
lookahead 13 = RPAREN 
lookahead 14 = $ UIDENT NUMBER ARROW DATA FOLLOWER MONADIC NAME NONTERMINAL NOPREC LPAREN PRECL PRECR START TERMINAL 

*)

struct
local
structure Value = struct
datatype nonterminal =
nonterminal
| string of Arg.string
| int of Arg.int
| symbol of Arg.symbol
| label of Arg.label
| constituent of Arg.constituent
| constituents of Arg.constituents
| precedence of Arg.precedence
| production of Arg.production
| productions of Arg.productions
| qident of Arg.qident
| directive of Arg.directive
| directives of Arg.directives
end
structure ParseEngine = ParseEngineFun (structure Streamable = Streamable
type terminal = Arg.terminal
type value = Value.nonterminal
val dummy = Value.nonterminal
fun read terminal =
(case terminal of
Arg.LIDENT x => (1, Value.string x)
| Arg.UIDENT x => (2, Value.string x)
| Arg.NUMBER x => (3, Value.int x)
| Arg.ARROW => (4, Value.nonterminal)
| Arg.COLON => (5, Value.nonterminal)
| Arg.DATA => (6, Value.nonterminal)
| Arg.DOT => (7, Value.nonterminal)
| Arg.EQUAL => (8, Value.nonterminal)
| Arg.FOLLOWER => (9, Value.nonterminal)
| Arg.MONADIC => (10, Value.nonterminal)
| Arg.NAME => (11, Value.nonterminal)
| Arg.NONTERMINAL => (12, Value.nonterminal)
| Arg.NOPREC => (13, Value.nonterminal)
| Arg.LPAREN => (14, Value.nonterminal)
| Arg.OF => (15, Value.nonterminal)
| Arg.PRECL => (16, Value.nonterminal)
| Arg.PRECR => (17, Value.nonterminal)
| Arg.RPAREN => (18, Value.nonterminal)
| Arg.START => (19, Value.nonterminal)
| Arg.TERMINAL => (20, Value.nonterminal)
)
)
in
val parse = ParseEngine.parse (
ParseEngine.next5x1 "d\128\128\128\128\128\133\128\128\132\134\135\131\128\128\128\128\128\128\137\136\128\128\128\128\128\128\128\128\128\128\128d\128\128\128\128\128\133\128\128\132\134\135\131\128\128\128\128\128\128\137\136\128\128\128\128\128\128\128\128\128\128\128\128\128\141\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\141\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\143\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128j\128\128\128\128\128j\128\128jjjj\128\128\128\128\128\128jj\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\141\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\141\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\127\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128c\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\148\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128}\128}}}}}\128\128}}}}}}}}}}}}\128\128\128\128\128\128\128\128\128\128\128e\128\128\128\128\128e\128\128eeee\128\128\128\128\128\128ee\128\128\128\128\128\128\128\128\128\128\128k\128\128\128\128\128k\128\128kkkk\128\128\128\128\128\128kk\128\128\128\128\128\128\128\128\128\128\128l\128\128\128\128\128l\128\128llll\128\128\128\128\128\128ll\128\128\128\128\128\128\128\128\128\128\128n\128\128\128\128\128n\149\128nnnn\128\128\128\128\128\128nn\128\128\128\128\128\128\128\128\128\128\128u\128\128\128\128\128u\128\128uuuu\151\128\150\153\154\128uu\128\128\128\128\128\128\128\128\128\128\128f\128\128\128\128\128f\128\128ffff\128\128\128\128\128\128ff\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128r\128rrr\128r\128\128rrrr\128r\128\128\128\128rr\128\128\128\128\128\128\128\128\128\128\128i\128\128\128\128\128i\128\128iiii\128\128\128\128\128\128ii\128\128\128\128\128\128\128\128\128\128\128\128\128\128\160\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\160\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128~\128~~~\128~\128~~~~~~~\128~~\128~~\128\128\128\128\128\128\128\128\128\128\128m\128\128\128\128\128m\128\128mmmm\128\128\128\128\128\128mm\128\128\128\128\128\128\128\128\128\128\128u\128\128\128\128\128u\128\128uuuu\151\128\128\153\154\128uu\128\128\128\128\128\128\128\128\128\128\128t\128ttt\128t\128\128tttt\128t\128\128\128\128tt\128\128\128\128\128\128\128\128\128\128\128|\128|||||\128\128||||\128|\128\128\128\128||\128\128\128\128\128\128\128\128\128\128\128s\128sss\128s\128\128ssss\128s\128\128\128\128ss\128\128\128\128\128\128\128\128\128\128\128p\128\141\160w\128p\128\128pppp\128\169\128\128\128\128pp\128\128\128\128\128\128\128\128\128\128\128h\128\128\128\128\128h\128\128hhhh\128\128\128\128\128\128hh\128\128\128\128\128\128\128\128\128\128\128g\128\128\128\128\128g\128\128gggg\128\128\128\128\128\128gg\128\128\128\128\128\128\128\128\128\128\128p\128\141\160w\128p\128\128pppp\128\169\128\128\128\128pp\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\173\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\141\160w\128\128\128\128\128\128\128\128\128\169\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\175\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\141\160\128\128\128\128\128\128\128\128\128\128\169\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128zzz\128\128\128\128\128\128\128\128\128z\128\128\128z\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128{\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128o\128\128\128\128\128o\128\128oooo\128\128\128\128\128\128oo\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128v\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\141\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\179\128\128\128\128\128\128\128\128\128\128\128\128\128u\128uuu\128u\128\128uuuu\151u\128\153\154\128uu\128\128\128\128\128\128\128\128\128\128\128\128\128yyy\128\128\128\128\128\128\128\128\128y\128\128\128y\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128xxx\128\128\128\128\128\128\128\128\128x\128\128\128x\128\128\128\128\128\128\128\128\128\128\128\128\128q\128qqq\128q\128\128qqqq\128q\128\128\128\128qq\128\128\128\128\128\128\128\128\128\128\128",
ParseEngine.next5x1 "\128\128\128\128\128\128\128\128\128\128\129\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\129\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\141\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\143\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\151\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\154\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\157\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\160\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\169\170\167\166\165\128\164\163\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\169\170\167\166\165\128\164\171\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\169\170\167\166\173\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\169\170\167\175\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\176\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\177\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\179\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
Vector.fromList [(0,1,(fn Value.string(arg0)::rest => Value.symbol(Arg.sole_lident arg0)::rest|_=>raise (Fail "bad parser"))),
(1,1,(fn Value.string(arg0)::rest => Value.symbol(Arg.sole_uident arg0)::rest|_=>raise (Fail "bad parser"))),
(2,1,(fn Value.int(arg0)::rest => Value.int(Arg.sole_number arg0)::rest|_=>raise (Fail "bad parser"))),
(3,1,(fn Value.int(arg0)::rest => Value.label(Arg.number_label arg0)::rest|_=>raise (Fail "bad parser"))),
(4,1,(fn Value.symbol(arg0)::rest => Value.constituent(Arg.unlabeled_item arg0)::rest|_=>raise (Fail "bad parser"))),
(4,3,(fn Value.symbol(arg0)::_::Value.label(arg1)::rest => Value.constituent(Arg.labeled_item {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(4,3,(fn _::Value.constituent(arg0)::_::rest => Value.constituent(Arg.paren_item arg0)::rest|_=>raise (Fail "bad parser"))),
(5,0,(fn rest => Value.constituents(Arg.nil_constituents {})::rest)),
(5,2,(fn Value.constituents(arg0)::Value.constituent(arg1)::rest => Value.constituents(Arg.cons_constituents {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(6,0,(fn rest => Value.precedence(Arg.empty_precedence {})::rest)),
(6,2,(fn Value.int(arg0)::_::rest => Value.precedence(Arg.left_precedence arg0)::rest|_=>raise (Fail "bad parser"))),
(6,2,(fn Value.int(arg0)::_::rest => Value.precedence(Arg.right_precedence arg0)::rest|_=>raise (Fail "bad parser"))),
(6,1,(fn _::rest => Value.precedence(Arg.no_precedence {})::rest|_=>raise (Fail "bad parser"))),
(7,4,(fn Value.precedence(arg0)::Value.symbol(arg1)::_::Value.constituents(arg2)::rest => Value.production(Arg.sole_production {3=arg0,2=arg1,1=arg2})::rest|_=>raise (Fail "bad parser"))),
(8,0,(fn rest => Value.productions(Arg.nil_productions {})::rest)),
(8,2,(fn Value.productions(arg0)::Value.production(arg1)::rest => Value.productions(Arg.cons_productions {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(9,1,(fn Value.string(arg0)::rest => Value.qident(Arg.sing_qident arg0)::rest|_=>raise (Fail "bad parser"))),
(9,3,(fn Value.qident(arg0)::_::Value.string(arg1)::rest => Value.qident(Arg.cons_qident {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(10,2,(fn Value.qident(arg0)::_::rest => Value.directive(Arg.name_directive arg0)::rest|_=>raise (Fail "bad parser"))),
(10,2,(fn Value.string(arg0)::_::rest => Value.directive(Arg.data_directive arg0)::rest|_=>raise (Fail "bad parser"))),
(10,1,(fn _::rest => Value.directive(Arg.monadic_directive {})::rest|_=>raise (Fail "bad parser"))),
(10,3,(fn Value.precedence(arg0)::Value.symbol(arg1)::_::rest => Value.directive(Arg.terminal_directive {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(10,5,(fn Value.precedence(arg0)::Value.symbol(arg1)::_::Value.symbol(arg2)::_::rest => Value.directive(Arg.terminal_of_directive {3=arg0,2=arg1,1=arg2})::rest|_=>raise (Fail "bad parser"))),
(10,6,(fn Value.productions(arg0)::_::Value.symbol(arg1)::_::Value.symbol(arg2)::_::rest => Value.directive(Arg.nonterminal_directive {3=arg0,2=arg1,1=arg2})::rest|_=>raise (Fail "bad parser"))),
(10,2,(fn Value.symbol(arg0)::_::rest => Value.directive(Arg.start_directive arg0)::rest|_=>raise (Fail "bad parser"))),
(10,2,(fn Value.symbol(arg0)::_::rest => Value.directive(Arg.follower_directive arg0)::rest|_=>raise (Fail "bad parser"))),
(11,0,(fn rest => Value.directives(Arg.nil_directives {})::rest)),
(11,2,(fn Value.directives(arg0)::Value.directive(arg1)::rest => Value.directives(Arg.cons_directives {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser")))],
(fn Value.directives x => x | _ => raise (Fail "bad parser")), Arg.error)
end
end
