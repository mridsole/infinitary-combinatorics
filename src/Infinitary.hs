module Infinitary (concat, concatMap, cartesianProduct, (×)) where

import Control.Applicative (Applicative(..))
import Control.Monad (liftM, ap)
import Prelude hiding (splitAt, concat, concatMap)

concat :: [[a]] -> [a]
concat = concat' 1
  where concat' :: Integer -> [[a]] -> [a]
        concat' n xs      = let (as, bs) = splitAt n xs
                                (hs, ts) = foldr ((\(a, as) (hs, ts) -> (a ++ hs, as : ts)) . splitAt 1)  ([],[]) as
                            in if null hs then [] else hs ++ concat' (n+1) (ts ++ bs)

splitAt :: Integer -> [a] -> ([a],[a])
splitAt n ls
  | n <= 0 = ([], ls)
  | otherwise          = splitAt' n ls
    where
        splitAt' :: Integer -> [a] -> ([a], [a])
        splitAt' _  []     = ([], [])
        splitAt' 1  (x:xs) = ([x], xs)
        splitAt' m  (x:xs) = (x:xs', xs'')
          where
            (xs', xs'') = splitAt' (m - 1) xs

concatMap :: (a -> [b]) -> [a] -> [b]
concatMap f xs = concat (map f xs)

newtype List a = List { toList :: [a] }

fromList :: [a] -> List a
fromList xs = List { toList = xs }

instance Functor List where
  fmap = liftM

instance Applicative List where
  pure  = fromList . (:[]) 
  (<*>) = ap

instance Monad List where 
  return   = pure
  xs >>= f = fromList $ concatMap (toList . f) $ toList xs


cartesianProduct = (×)
(×) :: [a] -> [b] -> [(a, b)]
xs × ys = toList $ do
  x <- fromList xs
  y <- fromList ys
  return (x,y)

pick :: [a] -> Int -> [[a]]
pick xs 0 = [[]]
pick xs n = toList $ do
  x <- fromList xs
  ys <- fromList (pick xs (n-1))
  return (x:ys)

