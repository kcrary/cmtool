{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances #-}

module Util.Stream
   (
   Stream,
   Front(..),
   lazy, eager,
   fromProcess, fromList, fromHandle, fromLoop,
   Streamable(..), shead, stail, stake, sdrop
   ) where

import Control.Monad
import System.IO
import Util.Memo


data Front a b =
   Nil 
 | Cons a b

instance Show a => Show (Front a b) where
   show Nil = "Nil"
   show (Cons x s) = "Cons " ++ show x ++ " -"



newtype Stream m a =
   Stream (m (Front a (Stream m a)))


eager :: Monad m => Front a (Stream m a) -> Stream m a
eager fr = Stream (return fr)


lazy :: MonadMemo m => m (Front a (Stream m a)) -> m (Stream m a)
lazy m = liftM Stream (memo m)


fromProcess :: MonadMemo m => m (Maybe a) -> m (Stream m a)
fromProcess m =
   lazy
   (do {
       x <- m;
       case x of
          {
          Nothing -> 
             return Nil ;

          Just y -> 
             do {
                s <- fromProcess m;
                return (Cons y s)
                }
          }
       })


fromList :: Monad m => [a] -> Stream m a
fromList l =
   case l of
      {
      [] ->
         eager Nil ;

      h : t ->
         eager (Cons h (fromList t))
      }


fromHandle :: Handle -> IO (Stream IO Char)
fromHandle h =
   fromProcess
   (do {
       b <- hIsEOF h;
       if b then
          return Nothing
       else
          liftM Just (hGetChar h)
       })


fromLoop :: MonadMemo m => (a -> m (Maybe (a, b))) -> a -> m (Stream m b)
fromLoop f seed =
   lazy
   (do {
       opt <- f seed;
       (case opt of
           {
           Nothing ->
              return Nil ;

           Just (seed', x) ->
              do {
                 s <- fromLoop f seed';
                 return (Cons x s)
                 }
           })
       })


instance Monad m => Functor (Stream m) where
   fmap f (Stream m) =
      Stream (liftM 
                 (\ fr -> case fr of
                             {
                             Nil -> Nil ;
   
                             Cons h t -> Cons (f h) (fmap f t)
                             })
                 m)


{---- Streamables  ----}

class Monad m => Streamable s m where
   front :: s a -> m (Front a (s a))

instance Monad m => Streamable (Stream m) m where
   front (Stream m) = m

instance Monad m => Streamable [] m where
   front l =
      case l of
         {
         [] -> return Nil ;
         h : t -> return (Cons h t)
         }


shead :: Streamable s m => s a -> m a
shead s =
   do {
      fr <- front s;
      case fr of
         {
         Nil -> error "Stream.shead: empty stream" ;
         Cons h _ -> return h
         }
      }


stail :: Streamable s m => s a -> m (s a)
stail s =
   do {
      fr <- front s ;
      case fr of
         {
         Nil -> error "Stream.stail: empty stream" ;
         
         Cons _ t -> return t
         }
      }


stake :: Streamable s m => Int -> s a -> m [a]
stake n s =
   if n == 0 then
      return []
   else
      do {
         fr <- front s;
         case fr of
            {
            Nil -> error "Stream.stake: empty stream" ;

            Cons h t ->
               do {
                  l <- stake (n-1) t;
                  return (h : l)
                  }
            }
         }


sdrop :: Streamable s m => Int -> s a -> m (s a)
sdrop n s =
   if n == 0 then
      return s
   else
      do {
         fr <- front s;
         case fr of
            {
            Nil -> error "Stream.sdrop: empty stream" ;

            Cons _ t -> sdrop (n-1) t
            }
         }
