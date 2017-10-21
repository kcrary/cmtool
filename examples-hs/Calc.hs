module Calc where

import Data.Proxy
import Data.Char as Char
import Control.Exception
import Util.Stream
import Util.LexEngine
import CalcLexFun as Lex
import CalcParseFun as Parse

type Term = Terminal Int


{- The lexer -}

simple :: Term -> LexInfo (Stream IO) Char -> IO (Front Term (Stream IO Term))
simple terminal info =
   do {
      t <- lazy (Calc.lex (follow info));
      return (Cons terminal t)
      }


lexarg =
   Lex.Arg
      {
      Lex.ord = Char.ord,

      Lex.monad = Proxy :: Proxy IO,
      Lex.t = Proxy :: Proxy (Front Term (Stream IO Term)),

      Lex.number =
         (\ info ->
             do {
                t <- lazy (Calc.lex (follow info));
                return (Cons (NUMBER (read (match info))) t)
                }),

      Lex.lparen = simple LPAREN,
      Lex.rparen = simple RPAREN,
      Lex.plus = simple PLUS,
      Lex.times = simple TIMES,

      Lex.whitespace =
         (\ info -> Calc.lex (follow info)),

      Lex.eof =
         (\ info -> return Nil )
      }


lex :: Stream IO Char -> IO (Front Term (Stream IO Term))
lex s = Lex.lex lexarg s


{- The parser -}

newtype SyntaxError = SyntaxError (Stream IO Term)
instance Show SyntaxError where
   show _ = "syntax error"
instance Exception SyntaxError


parsearg =
   Parse.Arg
      {
      Parse.error =
         (\ s -> return (toException (SyntaxError s))),

      Parse.monad = Proxy :: Proxy IO,
      Parse.t = Proxy :: Proxy Int,

      Parse.plus_term = (+),
      Parse.times_factor = (*),

      Parse.number_atom = id,
      Parse.paren_atom = id,
      Parse.atom_factor = id,
      Parse.factor_term = id
      }


calc :: Stream IO Char -> IO Int
calc s =
   do {
      s <- lazy (Calc.lex s);
      (x, _) <- Parse.parse parsearg s;
      return x
      }
