module Lectures.Hour1 where

{- Before we begin, some questions:

Q: What can types offer us?
Q: How is Haskell different from Java?


Let's also look at an example: expressions.
-}


------------------------- Functions ------------------------

myId = undefined

myConst = undefined


--------------------------- Bools --------------------------

-- A Boolean is either True or False.

myOr :: Bool -> Bool -> Bool
myOr = undefined


------------------------- Integers -------------------------

-- An Int is a value between -2^31 and 2^31-1.

ex1 :: Int
ex1 = undefined

myMin :: Int -> Int -> Int
myMin = undefined


-------------------------- Pairs ---------------------------

-- A pair (A, B) is an A together with a B.

myFst :: (a, b) -> a
myFst = undefined

swap :: (a, b) -> (b, a)
swap = undefined

mapPair :: (a -> b) -> (a, a) -> (b, b)
mapPair = undefined

diagonal :: a -> (a, a)
diagonal = undefined


------------------------- Either ---------------------------

-- An Either A B is either a Left A or a Right B.

leftOr :: Either a b -> a -> a
leftOr = undefined

codiagonal :: Either a a -> a
codiagonal = undefined

mapEither :: (a -> b) -> Either a a -> Either b b
mapEither = undefined


----------------- Lists and Pattern Matching ---------------

-- [A] is the type of lists with elements of type A.
-- a list is either:
-- * the empty list [], or
-- * a "cons" cell of the form x:xs

headOr :: [a] -> a -> a
headOr = undefined

myLength :: [a] -> Int
myLength = undefined

mySum :: [Int] -> Int
mySum = undefined

mapList :: (a -> b) -> [a] -> [b]
mapList = undefined