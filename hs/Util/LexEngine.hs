
module Util.LexEngine
   (
   next7x1,
   next8x1,
   next9x1,
   next10x1,
   next7x2,
   next8x2,
   next9x2,
   next10x2,
   next0x1,
   next0x2,
   LexInfo(..), Action, Table,
   Util.LexEngine.lex,
   module Stream
   ) where

import qualified Data.ByteString as B
import Data.Array as Array
import Util.Stream as Stream

next7x1 :: Int -> B.ByteString -> Int -> Int -> Int
next7x1 symbolLimit table state symbol =
   if symbol >= symbolLimit then
      0
   else
      let i = 128 * state + symbol
      in
         fromIntegral (B.index table i)

next8x1 :: Int -> B.ByteString -> Int -> Int -> Int
next8x1 symbolLimit table state symbol =
   if symbol >= symbolLimit then
      0
   else
      let i = 256 * state + symbol
      in
         fromIntegral (B.index table i)

next9x1 :: Int -> B.ByteString -> Int -> Int -> Int
next9x1 symbolLimit table state symbol =
   if symbol >= symbolLimit then
      0
   else
      let i = 512 * state + symbol
      in
         fromIntegral (B.index table i)

next10x1 :: Int -> B.ByteString -> Int -> Int -> Int
next10x1 symbolLimit table state symbol =
   if symbol >= symbolLimit then
      0
   else
      let i = 1024 * state + symbol
      in
         fromIntegral (B.index table i)

next7x2 :: Int -> B.ByteString -> Int -> Int -> Int
next7x2 symbolLimit table state symbol =
   if symbol >= symbolLimit then
      0
   else
      let i = 256 * state + 2 * symbol
      in
         fromIntegral (B.index table i) * 256 +
         fromIntegral (B.index table (i+1))

next8x2 :: Int -> B.ByteString -> Int -> Int -> Int
next8x2 symbolLimit table state symbol =
   if symbol >= symbolLimit then
      0
   else
      let i = 512 * state + 2 * symbol
      in
         fromIntegral (B.index table i) * 256 +
         fromIntegral (B.index table (i+1))

next9x2 :: Int -> B.ByteString -> Int -> Int -> Int
next9x2 symbolLimit table state symbol =
   if symbol >= symbolLimit then
      0
   else
      let i = 1024 * state + 2 * symbol
      in
         fromIntegral (B.index table i) * 256 +
         fromIntegral (B.index table (i+1))

next10x2 :: Int -> B.ByteString -> Int -> Int -> Int
next10x2 symbolLimit table state symbol =
   if symbol >= symbolLimit then
      0
   else
      let i = 2048 * state + 2 * symbol
      in
         fromIntegral (B.index table i) * 256 +
         fromIntegral (B.index table (i+1))


next0x1 :: B.ByteString -> Int -> Int
next0x1 table state =
   fromIntegral (B.index table state)

next0x2 :: B.ByteString -> Int -> Int
next0x2 table state =
   let i = 2 * state
   in
      fromIntegral (B.index table i) * 256 +
      fromIntegral (B.index table (i+1))

data LexInfo s symbol =
   LexInfo
   { match :: [symbol],
     len :: Int,
     start :: s symbol,
     follow :: s symbol }

type Action s m symbol a = LexInfo s symbol -> m a

type Table s m symbol a = 
   (symbol -> Int, 
    Int, 
    Int,
    Int, 
    Array Int (Action s m symbol a), 
    Int -> Int -> Int, 
    Int -> Int)

lex :: Streamable s m => Table s m symbol a -> s symbol -> m a
lex (ord, initial, lastAcceptSink, lastAccept, acceptTable, next, nextEos) s =
   let
      {
      loop candidate candLen candChars candStream state len chars s =
         if state == 0 then
            return (candidate, candLen, candChars, candStream)
         else if state <= lastAccept then
            if state <= lastAcceptSink then
               return (state, len, chars, s)
            else
               do {
                  fr <- front s;
                  case fr of
                     {
                     Nil ->
                        loop state len chars s (nextEos state) len chars s  ;
   
                     Cons ch s' ->
                        loop state len chars s (next state (ord ch)) (len+1) (ch : chars) s'
                     }
                  }
         else
            do {
               fr <- front s;
               case fr of
                  {
                  Nil ->
                     loop candidate candLen candChars candStream (nextEos state) len chars s ;

                  Cons ch s' ->
                     loop candidate candLen candChars candStream (next state (ord ch)) (len+1) (ch : chars) s'
                  }
               } ;

      }
   in do 
      {
      {- By construction, initial is an accepting state. -}
      (acceptingState, len, chars, s') <- loop initial 0 [] s initial 0 [] s ;

      let { f = (Array.!) acceptTable (acceptingState-1) } ;

      f (LexInfo { match = reverse chars,
                   len = len,
                   start = s,
                   follow = s' })
      }
