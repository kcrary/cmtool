
module Util.Memo
   (
   MonadMemo(..),
   memoIO
   ) where

import Control.Monad
import Control.Monad.Cont
import Control.Monad.Fix
import Control.Monad.ST
import Data.Functor.Identity
import Data.IORef
import Data.STRef
import IO

class Monad m => MonadMemo m where
   memo :: m a -> m (m a)

memoIO :: MonadIO m => m a -> m (m a)
memoIO m =
   do {
      r <- liftIO $ newIORef undefined;
      liftIO
         (writeIORef r
             (do {
                 x <- m;
                 liftIO $ writeIORef r (return x);
                 return x
                 }));
      return (join (liftIO (readIORef r)))
      }

instance MonadMemo IO where
   memo = memoIO

instance MonadIO m => MonadMemo (ContT r m) where
   memo = memoIO

instance MonadMemo (ST s) where
   memo m =
      do {
         r <- mfix
              (\ r -> 
                 newSTRef (do {
                              x <- m;
                              writeSTRef r (return x);
                              return x
                              }));
         return (join (readSTRef r))
         }

instance MonadMemo Identity where
   memo m = Identity m
