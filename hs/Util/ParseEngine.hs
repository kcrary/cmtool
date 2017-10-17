
module Util.ParseEngine
   (
   next5x1,
   next6x1,
   next7x1,
   next8x1,
   next9x1,
   next5x2,
   next6x2,
   next7x2,
   next8x2,
   next9x2,
   Rule, Table,
   parse,
   module Stream
   ) where

import qualified Data.ByteString as B
import Data.List
import Control.Exception
import Control.Monad
import Array
import Util.Stream as Stream

next5x1 :: B.ByteString -> Int -> Int -> Int
next5x1 table state symbol =
   let i = 32 * state + symbol
   in
      fromIntegral (B.index table i) - 128

next6x1 :: B.ByteString -> Int -> Int -> Int
next6x1 table state symbol =
   let i = 64 * state + symbol
   in
      fromIntegral (B.index table i) - 128

next7x1 :: B.ByteString -> Int -> Int -> Int
next7x1 table state symbol =
   let i = 128 * state + symbol
   in
      fromIntegral (B.index table i) - 128

next8x1 :: B.ByteString -> Int -> Int -> Int
next8x1 table state symbol =
   let i = 256 * state + symbol
   in
      fromIntegral (B.index table i) - 128

next9x1 :: B.ByteString -> Int -> Int -> Int
next9x1 table state symbol =
   let i = 512 * state + symbol
   in
      fromIntegral (B.index table i) - 128

next5x2 :: B.ByteString -> Int -> Int -> Int
next5x2 table state symbol =
   let i = 64 * state + 2 * symbol
   in
      fromIntegral (B.index table i) * 256 +
      fromIntegral (B.index table (i+1))
      - 32768

next6x2 :: B.ByteString -> Int -> Int -> Int
next6x2 table state symbol =
   let i = 128 * state + 2 * symbol
   in
      fromIntegral (B.index table i) * 256 +
      fromIntegral (B.index table (i+1))
      - 32768

next7x2 :: B.ByteString -> Int -> Int -> Int
next7x2 table state symbol =
   let i = 256 * state + 2 * symbol
   in
      fromIntegral (B.index table i) * 256 +
      fromIntegral (B.index table (i+1))
      - 32768

next8x2 :: B.ByteString -> Int -> Int -> Int
next8x2 table state symbol =
   let i = 512 * state + 2 * symbol
   in
      fromIntegral (B.index table i) * 256 +
      fromIntegral (B.index table (i+1))
      - 32768

next9x2 :: B.ByteString -> Int -> Int -> Int
next9x2 table state symbol =
   let i = 1024 * state + 2 * symbol
   in
      fromIntegral (B.index table i) * 256 +
      fromIntegral (B.index table (i+1))
      - 32768

type Rule value = (Int, Int, [value] -> [value])  {- lhs, size of rhs, function to call -}

type Table s m terminal value a =
   (terminal -> (Int, value),       {- reader -}
    Int -> Int -> Int,              {- action table -}
    Int -> Int -> Int,              {- goto table -}
    Array Int (Rule value),         {- reduction information -}
    value -> a,                     {- result destructor -}
    s terminal -> m SomeException)  {- error function -}

parse :: Streamable s m => Table s m terminal value a -> s terminal -> m (a, s terminal)
parse (read, action, goto, reduceTable, destruct, error) s =
   let
      {
      loop ststack valstack s =
         do {
            fr <- front s;
            case fr of
               {
               Nil ->
                  loopRead ststack valstack 0 undefined s s ;

               Cons term s' ->
                  let { (ordinal, value) = read term }
                  in
                     loopRead ststack valstack ordinal value s s'
               }
            } ;

      loopRead ststack valstack ordinal value s s' =
         case ststack of
            {
            [] ->
               fail "bad parsing table" ;

            state : rest ->
               let { n = action state ordinal }
               in
                  if n == 0 then
                     error s >>= throw
                  else if n > 0 then
                     {- shift -}
                     loop (n-1 : ststack) (value : valstack) s'
                  else if n == -1 then
                     {- accept -}
                     return (valstack, s)
                  else
                     {- reduce -}
                     let
                        {
                        (lhs, rhssize, f) = (Array.!) reduceTable (-n - 2) ;
                        ststack' = drop rhssize ststack
                        }
                     in
                        loopRead (goto (head ststack') lhs : ststack') (f valstack) ordinal value s s'
            }
      }
   in do
      {
      (valstack, s') <- loop [0] [] s;
      case valstack of
         {
         [value] ->
            return (destruct value, s') ;

         _ ->
            fail "bad parsing table"
         }
      }
