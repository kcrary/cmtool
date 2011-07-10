(*

State 0:

start -> . Directives  / 0
33 : Directive -> . NAME Ident  / 1
34 : Directive -> . ENABLE Ident  / 1
35 : Directive -> . ALPHABET Number  / 1
36 : Directive -> . REGEXP Ident EQUAL Regexp  / 1
37 : Directive -> . SET Ident EQUAL Charset  / 1
38 : Directive -> . FUNCTION Ident COLON Ident EQUAL Arms  / 1
39 : Directives -> .  / 0
40 : Directives -> . Directive Directives  / 0

$ => reduce 39
ALPHABET => shift 1
ENABLE => shift 2
FUNCTION => shift 3
NAME => shift 4
REGEXP => shift 5
SET => shift 6
Directive => goto 7
Directives => goto 8

-----

State 1:

1 : Number -> . NUMBER  / 1
35 : Directive -> ALPHABET . Number  / 1

NUMBER => shift 9
Number => goto 10

-----

State 2:

0 : Ident -> . IDENT  / 1
34 : Directive -> ENABLE . Ident  / 1

IDENT => shift 11
Ident => goto 12

-----

State 3:

0 : Ident -> . IDENT  / 2
38 : Directive -> FUNCTION . Ident COLON Ident EQUAL Arms  / 1

IDENT => shift 11
Ident => goto 13

-----

State 4:

0 : Ident -> . IDENT  / 1
33 : Directive -> NAME . Ident  / 1

IDENT => shift 11
Ident => goto 14

-----

State 5:

0 : Ident -> . IDENT  / 3
36 : Directive -> REGEXP . Ident EQUAL Regexp  / 1

IDENT => shift 11
Ident => goto 15

-----

State 6:

0 : Ident -> . IDENT  / 3
37 : Directive -> SET . Ident EQUAL Charset  / 1

IDENT => shift 11
Ident => goto 16

-----

State 7:

33 : Directive -> . NAME Ident  / 1
34 : Directive -> . ENABLE Ident  / 1
35 : Directive -> . ALPHABET Number  / 1
36 : Directive -> . REGEXP Ident EQUAL Regexp  / 1
37 : Directive -> . SET Ident EQUAL Charset  / 1
38 : Directive -> . FUNCTION Ident COLON Ident EQUAL Arms  / 1
39 : Directives -> .  / 0
40 : Directives -> . Directive Directives  / 0
40 : Directives -> Directive . Directives  / 0

$ => reduce 39
ALPHABET => shift 1
ENABLE => shift 2
FUNCTION => shift 3
NAME => shift 4
REGEXP => shift 5
SET => shift 6
Directive => goto 7
Directives => goto 17

-----

State 8:

start -> Directives .  / 0

$ => accept

-----

State 9:

1 : Number -> NUMBER .  / 4

$ => reduce 1
IDENT => reduce 1
NUMBER => reduce 1
STRING => reduce 1
ALPHABET => reduce 1
ANY => reduce 1
ARROW => reduce 1
EOS => reduce 1
EMPT => reduce 1
ENABLE => reduce 1
EPSILON => reduce 1
FUNCTION => reduce 1
LPAREN => reduce 1
NAME => reduce 1
REGEXP => reduce 1
RPAREN => reduce 1
SET => reduce 1

-----

State 10:

35 : Directive -> ALPHABET Number .  / 1

$ => reduce 35
ALPHABET => reduce 35
ENABLE => reduce 35
FUNCTION => reduce 35
NAME => reduce 35
REGEXP => reduce 35
SET => reduce 35

-----

State 11:

0 : Ident -> IDENT .  / 5

$ => reduce 0
IDENT => reduce 0
NUMBER => reduce 0
STRING => reduce 0
ALPHABET => reduce 0
ANY => reduce 0
ARROW => reduce 0
COLON => reduce 0
EOS => reduce 0
EMPT => reduce 0
ENABLE => reduce 0
EPSILON => reduce 0
EQUAL => reduce 0
FUNCTION => reduce 0
LPAREN => reduce 0
NAME => reduce 0
REGEXP => reduce 0
RPAREN => reduce 0
SET => reduce 0

-----

State 12:

34 : Directive -> ENABLE Ident .  / 1

$ => reduce 34
ALPHABET => reduce 34
ENABLE => reduce 34
FUNCTION => reduce 34
NAME => reduce 34
REGEXP => reduce 34
SET => reduce 34

-----

State 13:

38 : Directive -> FUNCTION Ident . COLON Ident EQUAL Arms  / 1

COLON => shift 18

-----

State 14:

33 : Directive -> NAME Ident .  / 1

$ => reduce 33
ALPHABET => reduce 33
ENABLE => reduce 33
FUNCTION => reduce 33
NAME => reduce 33
REGEXP => reduce 33
SET => reduce 33

-----

State 15:

36 : Directive -> REGEXP Ident . EQUAL Regexp  / 1

EQUAL => shift 19

-----

State 16:

37 : Directive -> SET Ident . EQUAL Charset  / 1

EQUAL => shift 20

-----

State 17:

40 : Directives -> Directive Directives .  / 0

$ => reduce 40

-----

State 18:

0 : Ident -> . IDENT  / 3
38 : Directive -> FUNCTION Ident COLON . Ident EQUAL Arms  / 1

IDENT => shift 11
Ident => goto 21

-----

State 19:

0 : Ident -> . IDENT  / 1
1 : Number -> . NUMBER  / 1
15 : Regexp -> . Ident  / 1
16 : Regexp -> . Number  / 1
17 : Regexp -> . STRING  / 1
18 : Regexp -> . ANY  / 1
19 : Regexp -> . EPSILON  / 1
20 : Regexp -> . EMPT  / 1
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 1
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 1
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 1
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 1
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 1
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 1
27 : Regexp -> . EOS  / 1
36 : Directive -> REGEXP Ident EQUAL . Regexp  / 1

IDENT => shift 11
NUMBER => shift 9
STRING => shift 22
ANY => shift 23
EOS => shift 24
EMPT => shift 25
EPSILON => shift 26
LPAREN => shift 27
Ident => goto 28
Regexp => goto 29
Number => goto 30

-----

State 20:

0 : Ident -> . IDENT  / 1
1 : Number -> . NUMBER  / 1
4 : Charset -> . Ident  / 1
5 : Charset -> . Number  / 1
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 1
7 : Charset -> . EMPT  / 1
8 : Charset -> . LPAREN OR Charsets RPAREN  / 1
9 : Charset -> . LPAREN AND Charsets RPAREN  / 1
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 1
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 1
12 : Charset -> . ANY  / 1
37 : Directive -> SET Ident EQUAL . Charset  / 1

IDENT => shift 11
NUMBER => shift 9
ANY => shift 31
EMPT => shift 32
LPAREN => shift 33
Ident => goto 34
Charset => goto 35
Number => goto 36

-----

State 21:

38 : Directive -> FUNCTION Ident COLON Ident . EQUAL Arms  / 1

EQUAL => shift 37

-----

State 22:

17 : Regexp -> STRING .  / 4

$ => reduce 17
IDENT => reduce 17
NUMBER => reduce 17
STRING => reduce 17
ALPHABET => reduce 17
ANY => reduce 17
ARROW => reduce 17
EOS => reduce 17
EMPT => reduce 17
ENABLE => reduce 17
EPSILON => reduce 17
FUNCTION => reduce 17
LPAREN => reduce 17
NAME => reduce 17
REGEXP => reduce 17
RPAREN => reduce 17
SET => reduce 17

-----

State 23:

18 : Regexp -> ANY .  / 4

$ => reduce 18
IDENT => reduce 18
NUMBER => reduce 18
STRING => reduce 18
ALPHABET => reduce 18
ANY => reduce 18
ARROW => reduce 18
EOS => reduce 18
EMPT => reduce 18
ENABLE => reduce 18
EPSILON => reduce 18
FUNCTION => reduce 18
LPAREN => reduce 18
NAME => reduce 18
REGEXP => reduce 18
RPAREN => reduce 18
SET => reduce 18

-----

State 24:

27 : Regexp -> EOS .  / 4

$ => reduce 27
IDENT => reduce 27
NUMBER => reduce 27
STRING => reduce 27
ALPHABET => reduce 27
ANY => reduce 27
ARROW => reduce 27
EOS => reduce 27
EMPT => reduce 27
ENABLE => reduce 27
EPSILON => reduce 27
FUNCTION => reduce 27
LPAREN => reduce 27
NAME => reduce 27
REGEXP => reduce 27
RPAREN => reduce 27
SET => reduce 27

-----

State 25:

20 : Regexp -> EMPT .  / 4

$ => reduce 20
IDENT => reduce 20
NUMBER => reduce 20
STRING => reduce 20
ALPHABET => reduce 20
ANY => reduce 20
ARROW => reduce 20
EOS => reduce 20
EMPT => reduce 20
ENABLE => reduce 20
EPSILON => reduce 20
FUNCTION => reduce 20
LPAREN => reduce 20
NAME => reduce 20
REGEXP => reduce 20
RPAREN => reduce 20
SET => reduce 20

-----

State 26:

19 : Regexp -> EPSILON .  / 4

$ => reduce 19
IDENT => reduce 19
NUMBER => reduce 19
STRING => reduce 19
ALPHABET => reduce 19
ANY => reduce 19
ARROW => reduce 19
EOS => reduce 19
EMPT => reduce 19
ENABLE => reduce 19
EPSILON => reduce 19
FUNCTION => reduce 19
LPAREN => reduce 19
NAME => reduce 19
REGEXP => reduce 19
RPAREN => reduce 19
SET => reduce 19

-----

State 27:

21 : Regexp -> LPAREN . COLON Regexps RPAREN  / 4
22 : Regexp -> LPAREN . SEQ Regexps RPAREN  / 4
23 : Regexp -> LPAREN . OR Regexps RPAREN  / 4
24 : Regexp -> LPAREN . QUESTION Regexp RPAREN  / 4
25 : Regexp -> LPAREN . STAR Regexp RPAREN  / 4
26 : Regexp -> LPAREN . PLUS Regexp RPAREN  / 4

COLON => shift 38
OR => shift 39
PLUS => shift 40
QUESTION => shift 41
SEQ => shift 42
STAR => shift 43

-----

State 28:

15 : Regexp -> Ident .  / 4

$ => reduce 15
IDENT => reduce 15
NUMBER => reduce 15
STRING => reduce 15
ALPHABET => reduce 15
ANY => reduce 15
ARROW => reduce 15
EOS => reduce 15
EMPT => reduce 15
ENABLE => reduce 15
EPSILON => reduce 15
FUNCTION => reduce 15
LPAREN => reduce 15
NAME => reduce 15
REGEXP => reduce 15
RPAREN => reduce 15
SET => reduce 15

-----

State 29:

36 : Directive -> REGEXP Ident EQUAL Regexp .  / 1

$ => reduce 36
ALPHABET => reduce 36
ENABLE => reduce 36
FUNCTION => reduce 36
NAME => reduce 36
REGEXP => reduce 36
SET => reduce 36

-----

State 30:

16 : Regexp -> Number .  / 4

$ => reduce 16
IDENT => reduce 16
NUMBER => reduce 16
STRING => reduce 16
ALPHABET => reduce 16
ANY => reduce 16
ARROW => reduce 16
EOS => reduce 16
EMPT => reduce 16
ENABLE => reduce 16
EPSILON => reduce 16
FUNCTION => reduce 16
LPAREN => reduce 16
NAME => reduce 16
REGEXP => reduce 16
RPAREN => reduce 16
SET => reduce 16

-----

State 31:

12 : Charset -> ANY .  / 6

$ => reduce 12
IDENT => reduce 12
NUMBER => reduce 12
ALPHABET => reduce 12
ANY => reduce 12
EMPT => reduce 12
ENABLE => reduce 12
FUNCTION => reduce 12
LPAREN => reduce 12
NAME => reduce 12
REGEXP => reduce 12
RPAREN => reduce 12
SET => reduce 12

-----

State 32:

7 : Charset -> EMPT .  / 6

$ => reduce 7
IDENT => reduce 7
NUMBER => reduce 7
ALPHABET => reduce 7
ANY => reduce 7
EMPT => reduce 7
ENABLE => reduce 7
FUNCTION => reduce 7
LPAREN => reduce 7
NAME => reduce 7
REGEXP => reduce 7
RPAREN => reduce 7
SET => reduce 7

-----

State 33:

6 : Charset -> LPAREN . RANGE NumPairs RPAREN  / 6
8 : Charset -> LPAREN . OR Charsets RPAREN  / 6
9 : Charset -> LPAREN . AND Charsets RPAREN  / 6
10 : Charset -> LPAREN . MINUS Charset Charsets RPAREN  / 6
11 : Charset -> LPAREN . TILDE Charsets RPAREN  / 6

AND => shift 44
MINUS => shift 45
OR => shift 46
RANGE => shift 47
TILDE => shift 48

-----

State 34:

4 : Charset -> Ident .  / 6

$ => reduce 4
IDENT => reduce 4
NUMBER => reduce 4
ALPHABET => reduce 4
ANY => reduce 4
EMPT => reduce 4
ENABLE => reduce 4
FUNCTION => reduce 4
LPAREN => reduce 4
NAME => reduce 4
REGEXP => reduce 4
RPAREN => reduce 4
SET => reduce 4

-----

State 35:

37 : Directive -> SET Ident EQUAL Charset .  / 1

$ => reduce 37
ALPHABET => reduce 37
ENABLE => reduce 37
FUNCTION => reduce 37
NAME => reduce 37
REGEXP => reduce 37
SET => reduce 37

-----

State 36:

5 : Charset -> Number .  / 6

$ => reduce 5
IDENT => reduce 5
NUMBER => reduce 5
ALPHABET => reduce 5
ANY => reduce 5
EMPT => reduce 5
ENABLE => reduce 5
FUNCTION => reduce 5
LPAREN => reduce 5
NAME => reduce 5
REGEXP => reduce 5
RPAREN => reduce 5
SET => reduce 5

-----

State 37:

0 : Ident -> . IDENT  / 7
1 : Number -> . NUMBER  / 7
15 : Regexp -> . Ident  / 7
16 : Regexp -> . Number  / 7
17 : Regexp -> . STRING  / 7
18 : Regexp -> . ANY  / 7
19 : Regexp -> . EPSILON  / 7
20 : Regexp -> . EMPT  / 7
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 7
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 7
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 7
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 7
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 7
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 7
27 : Regexp -> . EOS  / 7
30 : Arm -> . Regexp ARROW Ident  / 8
31 : Arms -> . Arm  / 1
32 : Arms -> . Arm Arms  / 1
38 : Directive -> FUNCTION Ident COLON Ident EQUAL . Arms  / 1

IDENT => shift 11
NUMBER => shift 9
STRING => shift 22
ANY => shift 23
EOS => shift 24
EMPT => shift 25
EPSILON => shift 26
LPAREN => shift 27
Ident => goto 28
Regexp => goto 49
Arm => goto 50
Arms => goto 51
Number => goto 30

-----

State 38:

0 : Ident -> . IDENT  / 9
1 : Number -> . NUMBER  / 9
15 : Regexp -> . Ident  / 9
16 : Regexp -> . Number  / 9
17 : Regexp -> . STRING  / 9
18 : Regexp -> . ANY  / 9
19 : Regexp -> . EPSILON  / 9
20 : Regexp -> . EMPT  / 9
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 9
21 : Regexp -> LPAREN COLON . Regexps RPAREN  / 4
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 9
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 9
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 9
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 9
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 9
27 : Regexp -> . EOS  / 9
28 : Regexps -> .  / 10
29 : Regexps -> . Regexp Regexps  / 10

IDENT => shift 11
NUMBER => shift 9
STRING => shift 22
ANY => shift 23
EOS => shift 24
EMPT => shift 25
EPSILON => shift 26
LPAREN => shift 27
RPAREN => reduce 28
Ident => goto 28
Regexp => goto 52
Regexps => goto 53
Number => goto 30

-----

State 39:

0 : Ident -> . IDENT  / 9
1 : Number -> . NUMBER  / 9
15 : Regexp -> . Ident  / 9
16 : Regexp -> . Number  / 9
17 : Regexp -> . STRING  / 9
18 : Regexp -> . ANY  / 9
19 : Regexp -> . EPSILON  / 9
20 : Regexp -> . EMPT  / 9
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 9
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 9
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 9
23 : Regexp -> LPAREN OR . Regexps RPAREN  / 4
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 9
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 9
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 9
27 : Regexp -> . EOS  / 9
28 : Regexps -> .  / 10
29 : Regexps -> . Regexp Regexps  / 10

IDENT => shift 11
NUMBER => shift 9
STRING => shift 22
ANY => shift 23
EOS => shift 24
EMPT => shift 25
EPSILON => shift 26
LPAREN => shift 27
RPAREN => reduce 28
Ident => goto 28
Regexp => goto 52
Regexps => goto 54
Number => goto 30

-----

State 40:

0 : Ident -> . IDENT  / 10
1 : Number -> . NUMBER  / 10
15 : Regexp -> . Ident  / 10
16 : Regexp -> . Number  / 10
17 : Regexp -> . STRING  / 10
18 : Regexp -> . ANY  / 10
19 : Regexp -> . EPSILON  / 10
20 : Regexp -> . EMPT  / 10
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 10
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 10
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 10
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 10
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 10
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 10
26 : Regexp -> LPAREN PLUS . Regexp RPAREN  / 4
27 : Regexp -> . EOS  / 10

IDENT => shift 11
NUMBER => shift 9
STRING => shift 22
ANY => shift 23
EOS => shift 24
EMPT => shift 25
EPSILON => shift 26
LPAREN => shift 27
Ident => goto 28
Regexp => goto 55
Number => goto 30

-----

State 41:

0 : Ident -> . IDENT  / 10
1 : Number -> . NUMBER  / 10
15 : Regexp -> . Ident  / 10
16 : Regexp -> . Number  / 10
17 : Regexp -> . STRING  / 10
18 : Regexp -> . ANY  / 10
19 : Regexp -> . EPSILON  / 10
20 : Regexp -> . EMPT  / 10
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 10
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 10
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 10
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 10
24 : Regexp -> LPAREN QUESTION . Regexp RPAREN  / 4
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 10
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 10
27 : Regexp -> . EOS  / 10

IDENT => shift 11
NUMBER => shift 9
STRING => shift 22
ANY => shift 23
EOS => shift 24
EMPT => shift 25
EPSILON => shift 26
LPAREN => shift 27
Ident => goto 28
Regexp => goto 56
Number => goto 30

-----

State 42:

0 : Ident -> . IDENT  / 9
1 : Number -> . NUMBER  / 9
15 : Regexp -> . Ident  / 9
16 : Regexp -> . Number  / 9
17 : Regexp -> . STRING  / 9
18 : Regexp -> . ANY  / 9
19 : Regexp -> . EPSILON  / 9
20 : Regexp -> . EMPT  / 9
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 9
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 9
22 : Regexp -> LPAREN SEQ . Regexps RPAREN  / 4
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 9
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 9
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 9
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 9
27 : Regexp -> . EOS  / 9
28 : Regexps -> .  / 10
29 : Regexps -> . Regexp Regexps  / 10

IDENT => shift 11
NUMBER => shift 9
STRING => shift 22
ANY => shift 23
EOS => shift 24
EMPT => shift 25
EPSILON => shift 26
LPAREN => shift 27
RPAREN => reduce 28
Ident => goto 28
Regexp => goto 52
Regexps => goto 57
Number => goto 30

-----

State 43:

0 : Ident -> . IDENT  / 10
1 : Number -> . NUMBER  / 10
15 : Regexp -> . Ident  / 10
16 : Regexp -> . Number  / 10
17 : Regexp -> . STRING  / 10
18 : Regexp -> . ANY  / 10
19 : Regexp -> . EPSILON  / 10
20 : Regexp -> . EMPT  / 10
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 10
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 10
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 10
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 10
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 10
25 : Regexp -> LPAREN STAR . Regexp RPAREN  / 4
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 10
27 : Regexp -> . EOS  / 10

IDENT => shift 11
NUMBER => shift 9
STRING => shift 22
ANY => shift 23
EOS => shift 24
EMPT => shift 25
EPSILON => shift 26
LPAREN => shift 27
Ident => goto 28
Regexp => goto 58
Number => goto 30

-----

State 44:

0 : Ident -> . IDENT  / 11
1 : Number -> . NUMBER  / 11
4 : Charset -> . Ident  / 11
5 : Charset -> . Number  / 11
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 11
7 : Charset -> . EMPT  / 11
8 : Charset -> . LPAREN OR Charsets RPAREN  / 11
9 : Charset -> . LPAREN AND Charsets RPAREN  / 11
9 : Charset -> LPAREN AND . Charsets RPAREN  / 6
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 11
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 11
12 : Charset -> . ANY  / 11
13 : Charsets -> .  / 10
14 : Charsets -> . Charset Charsets  / 10

IDENT => shift 11
NUMBER => shift 9
ANY => shift 31
EMPT => shift 32
LPAREN => shift 33
RPAREN => reduce 13
Ident => goto 34
Charset => goto 59
Charsets => goto 60
Number => goto 36

-----

State 45:

0 : Ident -> . IDENT  / 11
1 : Number -> . NUMBER  / 11
4 : Charset -> . Ident  / 11
5 : Charset -> . Number  / 11
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 11
7 : Charset -> . EMPT  / 11
8 : Charset -> . LPAREN OR Charsets RPAREN  / 11
9 : Charset -> . LPAREN AND Charsets RPAREN  / 11
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 11
10 : Charset -> LPAREN MINUS . Charset Charsets RPAREN  / 6
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 11
12 : Charset -> . ANY  / 11

IDENT => shift 11
NUMBER => shift 9
ANY => shift 31
EMPT => shift 32
LPAREN => shift 33
Ident => goto 34
Charset => goto 61
Number => goto 36

-----

State 46:

0 : Ident -> . IDENT  / 11
1 : Number -> . NUMBER  / 11
4 : Charset -> . Ident  / 11
5 : Charset -> . Number  / 11
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 11
7 : Charset -> . EMPT  / 11
8 : Charset -> . LPAREN OR Charsets RPAREN  / 11
8 : Charset -> LPAREN OR . Charsets RPAREN  / 6
9 : Charset -> . LPAREN AND Charsets RPAREN  / 11
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 11
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 11
12 : Charset -> . ANY  / 11
13 : Charsets -> .  / 10
14 : Charsets -> . Charset Charsets  / 10

IDENT => shift 11
NUMBER => shift 9
ANY => shift 31
EMPT => shift 32
LPAREN => shift 33
RPAREN => reduce 13
Ident => goto 34
Charset => goto 59
Charsets => goto 62
Number => goto 36

-----

State 47:

1 : Number -> . NUMBER  / 12
2 : NumPairs -> .  / 10
3 : NumPairs -> . Number Number NumPairs  / 10
6 : Charset -> LPAREN RANGE . NumPairs RPAREN  / 6

NUMBER => shift 9
RPAREN => reduce 2
NumPairs => goto 63
Number => goto 64

-----

State 48:

0 : Ident -> . IDENT  / 11
1 : Number -> . NUMBER  / 11
4 : Charset -> . Ident  / 11
5 : Charset -> . Number  / 11
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 11
7 : Charset -> . EMPT  / 11
8 : Charset -> . LPAREN OR Charsets RPAREN  / 11
9 : Charset -> . LPAREN AND Charsets RPAREN  / 11
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 11
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 11
11 : Charset -> LPAREN TILDE . Charsets RPAREN  / 6
12 : Charset -> . ANY  / 11
13 : Charsets -> .  / 10
14 : Charsets -> . Charset Charsets  / 10

IDENT => shift 11
NUMBER => shift 9
ANY => shift 31
EMPT => shift 32
LPAREN => shift 33
RPAREN => reduce 13
Ident => goto 34
Charset => goto 59
Charsets => goto 65
Number => goto 36

-----

State 49:

30 : Arm -> Regexp . ARROW Ident  / 8

ARROW => shift 66

-----

State 50:

0 : Ident -> . IDENT  / 7
1 : Number -> . NUMBER  / 7
15 : Regexp -> . Ident  / 7
16 : Regexp -> . Number  / 7
17 : Regexp -> . STRING  / 7
18 : Regexp -> . ANY  / 7
19 : Regexp -> . EPSILON  / 7
20 : Regexp -> . EMPT  / 7
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 7
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 7
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 7
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 7
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 7
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 7
27 : Regexp -> . EOS  / 7
30 : Arm -> . Regexp ARROW Ident  / 8
31 : Arms -> . Arm  / 1
31 : Arms -> Arm .  / 1
32 : Arms -> . Arm Arms  / 1
32 : Arms -> Arm . Arms  / 1

$ => reduce 31
IDENT => shift 11
NUMBER => shift 9
STRING => shift 22
ALPHABET => reduce 31
ANY => shift 23
EOS => shift 24
EMPT => shift 25
ENABLE => reduce 31
EPSILON => shift 26
FUNCTION => reduce 31
LPAREN => shift 27
NAME => reduce 31
REGEXP => reduce 31
SET => reduce 31
Ident => goto 28
Regexp => goto 49
Arm => goto 50
Arms => goto 67
Number => goto 30

-----

State 51:

38 : Directive -> FUNCTION Ident COLON Ident EQUAL Arms .  / 1

$ => reduce 38
ALPHABET => reduce 38
ENABLE => reduce 38
FUNCTION => reduce 38
NAME => reduce 38
REGEXP => reduce 38
SET => reduce 38

-----

State 52:

0 : Ident -> . IDENT  / 9
1 : Number -> . NUMBER  / 9
15 : Regexp -> . Ident  / 9
16 : Regexp -> . Number  / 9
17 : Regexp -> . STRING  / 9
18 : Regexp -> . ANY  / 9
19 : Regexp -> . EPSILON  / 9
20 : Regexp -> . EMPT  / 9
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 9
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 9
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 9
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 9
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 9
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 9
27 : Regexp -> . EOS  / 9
28 : Regexps -> .  / 10
29 : Regexps -> . Regexp Regexps  / 10
29 : Regexps -> Regexp . Regexps  / 10

IDENT => shift 11
NUMBER => shift 9
STRING => shift 22
ANY => shift 23
EOS => shift 24
EMPT => shift 25
EPSILON => shift 26
LPAREN => shift 27
RPAREN => reduce 28
Ident => goto 28
Regexp => goto 52
Regexps => goto 68
Number => goto 30

-----

State 53:

21 : Regexp -> LPAREN COLON Regexps . RPAREN  / 4

RPAREN => shift 69

-----

State 54:

23 : Regexp -> LPAREN OR Regexps . RPAREN  / 4

RPAREN => shift 70

-----

State 55:

26 : Regexp -> LPAREN PLUS Regexp . RPAREN  / 4

RPAREN => shift 71

-----

State 56:

24 : Regexp -> LPAREN QUESTION Regexp . RPAREN  / 4

RPAREN => shift 72

-----

State 57:

22 : Regexp -> LPAREN SEQ Regexps . RPAREN  / 4

RPAREN => shift 73

-----

State 58:

25 : Regexp -> LPAREN STAR Regexp . RPAREN  / 4

RPAREN => shift 74

-----

State 59:

0 : Ident -> . IDENT  / 11
1 : Number -> . NUMBER  / 11
4 : Charset -> . Ident  / 11
5 : Charset -> . Number  / 11
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 11
7 : Charset -> . EMPT  / 11
8 : Charset -> . LPAREN OR Charsets RPAREN  / 11
9 : Charset -> . LPAREN AND Charsets RPAREN  / 11
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 11
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 11
12 : Charset -> . ANY  / 11
13 : Charsets -> .  / 10
14 : Charsets -> . Charset Charsets  / 10
14 : Charsets -> Charset . Charsets  / 10

IDENT => shift 11
NUMBER => shift 9
ANY => shift 31
EMPT => shift 32
LPAREN => shift 33
RPAREN => reduce 13
Ident => goto 34
Charset => goto 59
Charsets => goto 75
Number => goto 36

-----

State 60:

9 : Charset -> LPAREN AND Charsets . RPAREN  / 6

RPAREN => shift 76

-----

State 61:

0 : Ident -> . IDENT  / 11
1 : Number -> . NUMBER  / 11
4 : Charset -> . Ident  / 11
5 : Charset -> . Number  / 11
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 11
7 : Charset -> . EMPT  / 11
8 : Charset -> . LPAREN OR Charsets RPAREN  / 11
9 : Charset -> . LPAREN AND Charsets RPAREN  / 11
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 11
10 : Charset -> LPAREN MINUS Charset . Charsets RPAREN  / 6
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 11
12 : Charset -> . ANY  / 11
13 : Charsets -> .  / 10
14 : Charsets -> . Charset Charsets  / 10

IDENT => shift 11
NUMBER => shift 9
ANY => shift 31
EMPT => shift 32
LPAREN => shift 33
RPAREN => reduce 13
Ident => goto 34
Charset => goto 59
Charsets => goto 77
Number => goto 36

-----

State 62:

8 : Charset -> LPAREN OR Charsets . RPAREN  / 6

RPAREN => shift 78

-----

State 63:

6 : Charset -> LPAREN RANGE NumPairs . RPAREN  / 6

RPAREN => shift 79

-----

State 64:

1 : Number -> . NUMBER  / 13
3 : NumPairs -> Number . Number NumPairs  / 10

NUMBER => shift 9
Number => goto 80

-----

State 65:

11 : Charset -> LPAREN TILDE Charsets . RPAREN  / 6

RPAREN => shift 81

-----

State 66:

0 : Ident -> . IDENT  / 8
30 : Arm -> Regexp ARROW . Ident  / 8

IDENT => shift 11
Ident => goto 82

-----

State 67:

32 : Arms -> Arm Arms .  / 1

$ => reduce 32
ALPHABET => reduce 32
ENABLE => reduce 32
FUNCTION => reduce 32
NAME => reduce 32
REGEXP => reduce 32
SET => reduce 32

-----

State 68:

29 : Regexps -> Regexp Regexps .  / 10

RPAREN => reduce 29

-----

State 69:

21 : Regexp -> LPAREN COLON Regexps RPAREN .  / 4

$ => reduce 21
IDENT => reduce 21
NUMBER => reduce 21
STRING => reduce 21
ALPHABET => reduce 21
ANY => reduce 21
ARROW => reduce 21
EOS => reduce 21
EMPT => reduce 21
ENABLE => reduce 21
EPSILON => reduce 21
FUNCTION => reduce 21
LPAREN => reduce 21
NAME => reduce 21
REGEXP => reduce 21
RPAREN => reduce 21
SET => reduce 21

-----

State 70:

23 : Regexp -> LPAREN OR Regexps RPAREN .  / 4

$ => reduce 23
IDENT => reduce 23
NUMBER => reduce 23
STRING => reduce 23
ALPHABET => reduce 23
ANY => reduce 23
ARROW => reduce 23
EOS => reduce 23
EMPT => reduce 23
ENABLE => reduce 23
EPSILON => reduce 23
FUNCTION => reduce 23
LPAREN => reduce 23
NAME => reduce 23
REGEXP => reduce 23
RPAREN => reduce 23
SET => reduce 23

-----

State 71:

26 : Regexp -> LPAREN PLUS Regexp RPAREN .  / 4

$ => reduce 26
IDENT => reduce 26
NUMBER => reduce 26
STRING => reduce 26
ALPHABET => reduce 26
ANY => reduce 26
ARROW => reduce 26
EOS => reduce 26
EMPT => reduce 26
ENABLE => reduce 26
EPSILON => reduce 26
FUNCTION => reduce 26
LPAREN => reduce 26
NAME => reduce 26
REGEXP => reduce 26
RPAREN => reduce 26
SET => reduce 26

-----

State 72:

24 : Regexp -> LPAREN QUESTION Regexp RPAREN .  / 4

$ => reduce 24
IDENT => reduce 24
NUMBER => reduce 24
STRING => reduce 24
ALPHABET => reduce 24
ANY => reduce 24
ARROW => reduce 24
EOS => reduce 24
EMPT => reduce 24
ENABLE => reduce 24
EPSILON => reduce 24
FUNCTION => reduce 24
LPAREN => reduce 24
NAME => reduce 24
REGEXP => reduce 24
RPAREN => reduce 24
SET => reduce 24

-----

State 73:

22 : Regexp -> LPAREN SEQ Regexps RPAREN .  / 4

$ => reduce 22
IDENT => reduce 22
NUMBER => reduce 22
STRING => reduce 22
ALPHABET => reduce 22
ANY => reduce 22
ARROW => reduce 22
EOS => reduce 22
EMPT => reduce 22
ENABLE => reduce 22
EPSILON => reduce 22
FUNCTION => reduce 22
LPAREN => reduce 22
NAME => reduce 22
REGEXP => reduce 22
RPAREN => reduce 22
SET => reduce 22

-----

State 74:

25 : Regexp -> LPAREN STAR Regexp RPAREN .  / 4

$ => reduce 25
IDENT => reduce 25
NUMBER => reduce 25
STRING => reduce 25
ALPHABET => reduce 25
ANY => reduce 25
ARROW => reduce 25
EOS => reduce 25
EMPT => reduce 25
ENABLE => reduce 25
EPSILON => reduce 25
FUNCTION => reduce 25
LPAREN => reduce 25
NAME => reduce 25
REGEXP => reduce 25
RPAREN => reduce 25
SET => reduce 25

-----

State 75:

14 : Charsets -> Charset Charsets .  / 10

RPAREN => reduce 14

-----

State 76:

9 : Charset -> LPAREN AND Charsets RPAREN .  / 6

$ => reduce 9
IDENT => reduce 9
NUMBER => reduce 9
ALPHABET => reduce 9
ANY => reduce 9
EMPT => reduce 9
ENABLE => reduce 9
FUNCTION => reduce 9
LPAREN => reduce 9
NAME => reduce 9
REGEXP => reduce 9
RPAREN => reduce 9
SET => reduce 9

-----

State 77:

10 : Charset -> LPAREN MINUS Charset Charsets . RPAREN  / 6

RPAREN => shift 83

-----

State 78:

8 : Charset -> LPAREN OR Charsets RPAREN .  / 6

$ => reduce 8
IDENT => reduce 8
NUMBER => reduce 8
ALPHABET => reduce 8
ANY => reduce 8
EMPT => reduce 8
ENABLE => reduce 8
FUNCTION => reduce 8
LPAREN => reduce 8
NAME => reduce 8
REGEXP => reduce 8
RPAREN => reduce 8
SET => reduce 8

-----

State 79:

6 : Charset -> LPAREN RANGE NumPairs RPAREN .  / 6

$ => reduce 6
IDENT => reduce 6
NUMBER => reduce 6
ALPHABET => reduce 6
ANY => reduce 6
EMPT => reduce 6
ENABLE => reduce 6
FUNCTION => reduce 6
LPAREN => reduce 6
NAME => reduce 6
REGEXP => reduce 6
RPAREN => reduce 6
SET => reduce 6

-----

State 80:

1 : Number -> . NUMBER  / 12
2 : NumPairs -> .  / 10
3 : NumPairs -> . Number Number NumPairs  / 10
3 : NumPairs -> Number Number . NumPairs  / 10

NUMBER => shift 9
RPAREN => reduce 2
NumPairs => goto 84
Number => goto 64

-----

State 81:

11 : Charset -> LPAREN TILDE Charsets RPAREN .  / 6

$ => reduce 11
IDENT => reduce 11
NUMBER => reduce 11
ALPHABET => reduce 11
ANY => reduce 11
EMPT => reduce 11
ENABLE => reduce 11
FUNCTION => reduce 11
LPAREN => reduce 11
NAME => reduce 11
REGEXP => reduce 11
RPAREN => reduce 11
SET => reduce 11

-----

State 82:

30 : Arm -> Regexp ARROW Ident .  / 8

$ => reduce 30
IDENT => reduce 30
NUMBER => reduce 30
STRING => reduce 30
ALPHABET => reduce 30
ANY => reduce 30
EOS => reduce 30
EMPT => reduce 30
ENABLE => reduce 30
EPSILON => reduce 30
FUNCTION => reduce 30
LPAREN => reduce 30
NAME => reduce 30
REGEXP => reduce 30
SET => reduce 30

-----

State 83:

10 : Charset -> LPAREN MINUS Charset Charsets RPAREN .  / 6

$ => reduce 10
IDENT => reduce 10
NUMBER => reduce 10
ALPHABET => reduce 10
ANY => reduce 10
EMPT => reduce 10
ENABLE => reduce 10
FUNCTION => reduce 10
LPAREN => reduce 10
NAME => reduce 10
REGEXP => reduce 10
RPAREN => reduce 10
SET => reduce 10

-----

State 84:

3 : NumPairs -> Number Number NumPairs .  / 10

RPAREN => reduce 3

-----

lookahead 0 = $ 
lookahead 1 = $ ALPHABET ENABLE FUNCTION NAME REGEXP SET 
lookahead 2 = COLON 
lookahead 3 = EQUAL 
lookahead 4 = $ IDENT NUMBER STRING ALPHABET ANY ARROW EOS EMPT ENABLE EPSILON FUNCTION LPAREN NAME REGEXP RPAREN SET 
lookahead 5 = $ IDENT NUMBER STRING ALPHABET ANY ARROW COLON EOS EMPT ENABLE EPSILON EQUAL FUNCTION LPAREN NAME REGEXP RPAREN SET 
lookahead 6 = $ IDENT NUMBER ALPHABET ANY EMPT ENABLE FUNCTION LPAREN NAME REGEXP RPAREN SET 
lookahead 7 = ARROW 
lookahead 8 = $ IDENT NUMBER STRING ALPHABET ANY EOS EMPT ENABLE EPSILON FUNCTION LPAREN NAME REGEXP SET 
lookahead 9 = IDENT NUMBER STRING ANY EOS EMPT EPSILON LPAREN RPAREN 
lookahead 10 = RPAREN 
lookahead 11 = IDENT NUMBER ANY EMPT LPAREN RPAREN 
lookahead 12 = NUMBER 
lookahead 13 = NUMBER RPAREN 

*)

functor ParseMainFun (structure Streamable : STREAMABLE
structure Arg : sig
type pos_string
type pos_int
type pos_intlist
type pos
type ident
type numpairs
type charset
type charsets
type regexp
type regexps
type arm
type arms
type directive
type directives
type number
val ident : {ident:pos_string} -> ident
val number : {num:pos_int} -> number
val nil_numpairs : {} -> numpairs
val cons_numpairs : {first:number, last:number, tail:numpairs} -> numpairs
val ident_charset : {ident:ident} -> charset
val number_charset : {num:number} -> charset
val range_charset : {l:numpairs} -> charset
val empty_charset : {} -> charset
val union_charset : {l:charsets} -> charset
val intersect_charset : {l:charsets} -> charset
val diff_charset : {head:charset, l:charsets} -> charset
val comp_charset : {l:charsets} -> charset
val any_charset : {} -> charset
val nil_charsets : {} -> charsets
val cons_charsets : {head:charset, tail:charsets} -> charsets
val ident_regexp : {ident:ident} -> regexp
val number_regexp : {num:number} -> regexp
val string_regexp : {str:pos_intlist} -> regexp
val any_regexp : {} -> regexp
val epsilon_regexp : {} -> regexp
val empty_regexp : {} -> regexp
val concat_regexp : {l:regexps} -> regexp
val seq_regexp : {l:regexps} -> regexp
val union_regexp : {l:regexps} -> regexp
val option_regexp : {r:regexp} -> regexp
val closure_regexp : {r:regexp} -> regexp
val plus_regexp : {r:regexp} -> regexp
val eos_regexp : {} -> regexp
val nil_regexps : {} -> regexps
val cons_regexps : {head:regexp, tail:regexps} -> regexps
val arm : {r:regexp, action:ident} -> arm
val sing_arms : {arm:arm} -> arms
val cons_arms : {head:arm, tail:arms} -> arms
val name_directive : {ident:ident} -> directive
val enable_directive : {ident:ident} -> directive
val alphabet_directive : {num:number} -> directive
val regexp_directive : {ident:ident, r:regexp} -> directive
val set_directive : {ident:ident, s:charset} -> directive
val function_directive : {ident:ident, tp:ident, arms:arms} -> directive
val nil_directives : {} -> directives
val cons_directives : {head:directive, tail:directives} -> directives
datatype terminal =
IDENT of pos_string
| NUMBER of pos_int
| STRING of pos_intlist
| ALPHABET of pos
| AND of pos
| ANY of pos
| ARROW of pos
| COLON of pos
| EOS of pos
| EMPT of pos
| ENABLE of pos
| EPSILON of pos
| EQUAL of pos
| FUNCTION of pos
| LPAREN of pos
| MINUS of pos
| NAME of pos
| OR of pos
| PLUS of pos
| QUESTION of pos
| RANGE of pos
| REGEXP of pos
| RPAREN of pos
| SEQ of pos
| SET of pos
| STAR of pos
| TILDE of pos
val error : terminal Streamable.t -> exn
end)
=
struct
local
structure Value = struct
datatype nonterminal =
nonterminal
| pos_string of Arg.pos_string
| pos_int of Arg.pos_int
| pos_intlist of Arg.pos_intlist
| pos of Arg.pos
| ident of Arg.ident
| numpairs of Arg.numpairs
| charset of Arg.charset
| charsets of Arg.charsets
| regexp of Arg.regexp
| regexps of Arg.regexps
| arm of Arg.arm
| arms of Arg.arms
| directive of Arg.directive
| directives of Arg.directives
| number of Arg.number
end
structure ParseEngine = ParseEngineFun (structure Streamable = Streamable
type terminal = Arg.terminal
type value = Value.nonterminal
val dummy = Value.nonterminal
fun read terminal =
(case terminal of
Arg.IDENT x => (1, Value.pos_string x)
| Arg.NUMBER x => (2, Value.pos_int x)
| Arg.STRING x => (3, Value.pos_intlist x)
| Arg.ALPHABET x => (4, Value.pos x)
| Arg.AND x => (5, Value.pos x)
| Arg.ANY x => (6, Value.pos x)
| Arg.ARROW x => (7, Value.pos x)
| Arg.COLON x => (8, Value.pos x)
| Arg.EOS x => (9, Value.pos x)
| Arg.EMPT x => (10, Value.pos x)
| Arg.ENABLE x => (11, Value.pos x)
| Arg.EPSILON x => (12, Value.pos x)
| Arg.EQUAL x => (13, Value.pos x)
| Arg.FUNCTION x => (14, Value.pos x)
| Arg.LPAREN x => (15, Value.pos x)
| Arg.MINUS x => (16, Value.pos x)
| Arg.NAME x => (17, Value.pos x)
| Arg.OR x => (18, Value.pos x)
| Arg.PLUS x => (19, Value.pos x)
| Arg.QUESTION x => (20, Value.pos x)
| Arg.RANGE x => (21, Value.pos x)
| Arg.REGEXP x => (22, Value.pos x)
| Arg.RPAREN x => (23, Value.pos x)
| Arg.SEQ x => (24, Value.pos x)
| Arg.SET x => (25, Value.pos x)
| Arg.STAR x => (26, Value.pos x)
| Arg.TILDE x => (27, Value.pos x)
)
)
in
val parse = ParseEngine.parse (
ParseEngine.next5x1 "W\128\128\128\130\128\128\128\128\128\128\131\128\128\132\128\128\133\128\128\128\128\134\128\128\135\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128W\128\128\128\130\128\128\128\128\128\128\131\128\128\132\128\128\133\128\128\128\128\134\128\128\135\128\128\128\128\128\128\127\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128}}}}}\128}}\128}}}}\128}}\128}\128\128\128\128}}\128}\128\128\128\128\128\128[\128\128\128[\128\128\128\128\128\128[\128\128[\128\128[\128\128\128\128[\128\128[\128\128\128\128\128\128~~~~~\128~~~~~~~~~~\128~\128\128\128\128~~\128~\128\128\128\128\128\128\\\128\128\128\\\128\128\128\128\128\128\\\128\128\\\128\128\\\128\128\128\128\\\128\128\\\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128]\128\128\128]\128\128\128\128\128\128]\128\128]\128\128]\128\128\128\128]\128\128]\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\148\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\149\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128V\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\138\151\128\128\152\128\128\153\154\128\155\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\138\128\128\128\160\128\128\128\161\128\128\128\128\162\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\166\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128mmmmm\128mm\128mmmm\128mm\128m\128\128\128\128mm\128m\128\128\128\128\128\128lllll\128ll\128llll\128ll\128l\128\128\128\128ll\128l\128\128\128\128\128\128ccccc\128cc\128cccc\128cc\128c\128\128\128\128cc\128c\128\128\128\128\128\128jjjjj\128jj\128jjjj\128jj\128j\128\128\128\128jj\128j\128\128\128\128\128\128kkkkk\128kk\128kkkk\128kk\128k\128\128\128\128kk\128k\128\128\128\128\128\128\128\128\128\128\128\128\128\128\167\128\128\128\128\128\128\128\128\128\168\169\170\128\128\128\171\128\172\128\128\128\128\128ooooo\128oo\128oooo\128oo\128o\128\128\128\128oo\128o\128\128\128\128\128\128Z\128\128\128Z\128\128\128\128\128\128Z\128\128Z\128\128Z\128\128\128\128Z\128\128Z\128\128\128\128\128\128nnnnn\128nn\128nnnn\128nn\128n\128\128\128\128nn\128n\128\128\128\128\128\128rrr\128r\128r\128\128\128rr\128\128rr\128r\128\128\128\128rr\128r\128\128\128\128\128\128www\128w\128w\128\128\128ww\128\128ww\128w\128\128\128\128ww\128w\128\128\128\128\128\128\128\128\128\128\128\173\128\128\128\128\128\128\128\128\128\128\174\128\175\128\128\176\128\128\128\128\128\177\128\128\128\128zzz\128z\128z\128\128\128zz\128\128zz\128z\128\128\128\128zz\128z\128\128\128\128\128\128Y\128\128\128Y\128\128\128\128\128\128Y\128\128Y\128\128Y\128\128\128\128Y\128\128Y\128\128\128\128\128\128yyy\128y\128y\128\128\128yy\128\128yy\128y\128\128\128\128yy\128y\128\128\128\128\128\128\128\140\138\151\128\128\152\128\128\153\154\128\155\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\138\151\128\128\152\128\128\153\154\128\155\128\128\156\128\128\128\128\128\128\128b\128\128\128\128\128\128\128\128\128\140\138\151\128\128\152\128\128\153\154\128\155\128\128\156\128\128\128\128\128\128\128b\128\128\128\128\128\128\128\128\128\140\138\151\128\128\152\128\128\153\154\128\155\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\138\151\128\128\152\128\128\153\154\128\155\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\138\151\128\128\152\128\128\153\154\128\155\128\128\156\128\128\128\128\128\128\128b\128\128\128\128\128\128\128\128\128\140\138\151\128\128\152\128\128\153\154\128\155\128\128\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\138\128\128\128\160\128\128\128\161\128\128\128\128\162\128\128\128\128\128\128\128q\128\128\128\128\128\128\128\128\128\140\138\128\128\128\160\128\128\128\161\128\128\128\128\162\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\138\128\128\128\160\128\128\128\161\128\128\128\128\162\128\128\128\128\128\128\128q\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128|\128\128\128\128\128\128\128\128\128\140\138\128\128\128\160\128\128\128\161\128\128\128\128\162\128\128\128\128\128\128\128q\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\195\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128_\140\138\151_\128\152\128\128\153\154_\155\128_\156\128_\128\128\128\128_\128\128_\128\128\128\128\128\128X\128\128\128X\128\128\128\128\128\128X\128\128X\128\128X\128\128\128\128X\128\128X\128\128\128\128\128\128\128\140\138\151\128\128\152\128\128\153\154\128\155\128\128\156\128\128\128\128\128\128\128b\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\198\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\199\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\200\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\201\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\202\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\203\128\128\128\128\128\128\128\128\128\140\138\128\128\128\160\128\128\128\161\128\128\128\128\162\128\128\128\128\128\128\128q\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\205\128\128\128\128\128\128\128\128\128\140\138\128\128\128\160\128\128\128\161\128\128\128\128\162\128\128\128\128\128\128\128q\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\207\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\208\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\210\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128^\128\128\128^\128\128\128\128\128\128^\128\128^\128\128^\128\128\128\128^\128\128^\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128a\128\128\128\128\128\128\128\128iiiii\128ii\128iiii\128ii\128i\128\128\128\128ii\128i\128\128\128\128\128\128ggggg\128gg\128gggg\128gg\128g\128\128\128\128gg\128g\128\128\128\128\128\128ddddd\128dd\128dddd\128dd\128d\128\128\128\128dd\128d\128\128\128\128\128\128fffff\128ff\128ffff\128ff\128f\128\128\128\128ff\128f\128\128\128\128\128\128hhhhh\128hh\128hhhh\128hh\128h\128\128\128\128hh\128h\128\128\128\128\128\128eeeee\128ee\128eeee\128ee\128e\128\128\128\128ee\128e\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128p\128\128\128\128\128\128\128\128uuu\128u\128u\128\128\128uu\128\128uu\128u\128\128\128\128uu\128u\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\212\128\128\128\128\128\128\128\128vvv\128v\128v\128\128\128vv\128\128vv\128v\128\128\128\128vv\128v\128\128\128\128\128\128xxx\128x\128x\128\128\128xx\128\128xx\128x\128\128\128\128xx\128x\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128|\128\128\128\128\128\128\128\128sss\128s\128s\128\128\128ss\128\128ss\128s\128\128\128\128ss\128s\128\128\128\128\128\128`````\128`\128\128````\128``\128`\128\128\128\128`\128\128`\128\128\128\128\128\128ttt\128t\128t\128\128\128tt\128\128tt\128t\128\128\128\128tt\128t\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128{\128\128\128\128\128\128\128\128",
ParseEngine.next5x1 "\128\128\128\128\128\128\128\128\135\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\141\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\143\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\144\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\135\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\149\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\157\128\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\128\163\128\128\128\128\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\177\128\178\179\128\128\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\180\181\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\180\182\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\183\128\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\184\128\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\180\185\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\186\128\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\128\187\188\128\128\128\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\128\189\128\128\128\128\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\128\187\190\128\128\128\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\191\128\128\128\128\128\128\128\128\192\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\128\187\193\128\128\128\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\177\128\178\195\128\128\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\156\128\128\128\180\196\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\128\187\203\128\128\128\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\128\187\205\128\128\128\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\208\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\210\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\212\128\128\128\128\128\128\128\128\192\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
Vector.fromList [(0,1,(fn Value.pos_string(arg0)::rest => Value.ident(Arg.ident {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(10,1,(fn Value.pos_int(arg0)::rest => Value.number(Arg.number {num=arg0})::rest|_=>raise (Fail "bad parser"))),
(1,0,(fn rest => Value.numpairs(Arg.nil_numpairs {})::rest)),
(1,3,(fn Value.numpairs(arg0)::Value.number(arg1)::Value.number(arg2)::rest => Value.numpairs(Arg.cons_numpairs {tail=arg0,last=arg1,first=arg2})::rest|_=>raise (Fail "bad parser"))),
(2,1,(fn Value.ident(arg0)::rest => Value.charset(Arg.ident_charset {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(2,1,(fn Value.number(arg0)::rest => Value.charset(Arg.number_charset {num=arg0})::rest|_=>raise (Fail "bad parser"))),
(2,4,(fn _::Value.numpairs(arg0)::_::_::rest => Value.charset(Arg.range_charset {l=arg0})::rest|_=>raise (Fail "bad parser"))),
(2,1,(fn _::rest => Value.charset(Arg.empty_charset {})::rest|_=>raise (Fail "bad parser"))),
(2,4,(fn _::Value.charsets(arg0)::_::_::rest => Value.charset(Arg.union_charset {l=arg0})::rest|_=>raise (Fail "bad parser"))),
(2,4,(fn _::Value.charsets(arg0)::_::_::rest => Value.charset(Arg.intersect_charset {l=arg0})::rest|_=>raise (Fail "bad parser"))),
(2,5,(fn _::Value.charsets(arg0)::Value.charset(arg1)::_::_::rest => Value.charset(Arg.diff_charset {l=arg0,head=arg1})::rest|_=>raise (Fail "bad parser"))),
(2,4,(fn _::Value.charsets(arg0)::_::_::rest => Value.charset(Arg.comp_charset {l=arg0})::rest|_=>raise (Fail "bad parser"))),
(2,1,(fn _::rest => Value.charset(Arg.any_charset {})::rest|_=>raise (Fail "bad parser"))),
(3,0,(fn rest => Value.charsets(Arg.nil_charsets {})::rest)),
(3,2,(fn Value.charsets(arg0)::Value.charset(arg1)::rest => Value.charsets(Arg.cons_charsets {tail=arg0,head=arg1})::rest|_=>raise (Fail "bad parser"))),
(4,1,(fn Value.ident(arg0)::rest => Value.regexp(Arg.ident_regexp {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,1,(fn Value.number(arg0)::rest => Value.regexp(Arg.number_regexp {num=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,1,(fn Value.pos_intlist(arg0)::rest => Value.regexp(Arg.string_regexp {str=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,1,(fn _::rest => Value.regexp(Arg.any_regexp {})::rest|_=>raise (Fail "bad parser"))),
(4,1,(fn _::rest => Value.regexp(Arg.epsilon_regexp {})::rest|_=>raise (Fail "bad parser"))),
(4,1,(fn _::rest => Value.regexp(Arg.empty_regexp {})::rest|_=>raise (Fail "bad parser"))),
(4,4,(fn _::Value.regexps(arg0)::_::_::rest => Value.regexp(Arg.concat_regexp {l=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,4,(fn _::Value.regexps(arg0)::_::_::rest => Value.regexp(Arg.seq_regexp {l=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,4,(fn _::Value.regexps(arg0)::_::_::rest => Value.regexp(Arg.union_regexp {l=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,4,(fn _::Value.regexp(arg0)::_::_::rest => Value.regexp(Arg.option_regexp {r=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,4,(fn _::Value.regexp(arg0)::_::_::rest => Value.regexp(Arg.closure_regexp {r=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,4,(fn _::Value.regexp(arg0)::_::_::rest => Value.regexp(Arg.plus_regexp {r=arg0})::rest|_=>raise (Fail "bad parser"))),
(4,1,(fn _::rest => Value.regexp(Arg.eos_regexp {})::rest|_=>raise (Fail "bad parser"))),
(5,0,(fn rest => Value.regexps(Arg.nil_regexps {})::rest)),
(5,2,(fn Value.regexps(arg0)::Value.regexp(arg1)::rest => Value.regexps(Arg.cons_regexps {tail=arg0,head=arg1})::rest|_=>raise (Fail "bad parser"))),
(6,3,(fn Value.ident(arg0)::_::Value.regexp(arg1)::rest => Value.arm(Arg.arm {action=arg0,r=arg1})::rest|_=>raise (Fail "bad parser"))),
(7,1,(fn Value.arm(arg0)::rest => Value.arms(Arg.sing_arms {arm=arg0})::rest|_=>raise (Fail "bad parser"))),
(7,2,(fn Value.arms(arg0)::Value.arm(arg1)::rest => Value.arms(Arg.cons_arms {tail=arg0,head=arg1})::rest|_=>raise (Fail "bad parser"))),
(8,2,(fn Value.ident(arg0)::_::rest => Value.directive(Arg.name_directive {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(8,2,(fn Value.ident(arg0)::_::rest => Value.directive(Arg.enable_directive {ident=arg0})::rest|_=>raise (Fail "bad parser"))),
(8,2,(fn Value.number(arg0)::_::rest => Value.directive(Arg.alphabet_directive {num=arg0})::rest|_=>raise (Fail "bad parser"))),
(8,4,(fn Value.regexp(arg0)::_::Value.ident(arg1)::_::rest => Value.directive(Arg.regexp_directive {r=arg0,ident=arg1})::rest|_=>raise (Fail "bad parser"))),
(8,4,(fn Value.charset(arg0)::_::Value.ident(arg1)::_::rest => Value.directive(Arg.set_directive {s=arg0,ident=arg1})::rest|_=>raise (Fail "bad parser"))),
(8,6,(fn Value.arms(arg0)::_::Value.ident(arg1)::_::Value.ident(arg2)::_::rest => Value.directive(Arg.function_directive {arms=arg0,tp=arg1,ident=arg2})::rest|_=>raise (Fail "bad parser"))),
(9,0,(fn rest => Value.directives(Arg.nil_directives {})::rest)),
(9,2,(fn Value.directives(arg0)::Value.directive(arg1)::rest => Value.directives(Arg.cons_directives {tail=arg0,head=arg1})::rest|_=>raise (Fail "bad parser")))],
(fn Value.directives x => x | _ => raise (Fail "bad parser")), Arg.error)
end
end
