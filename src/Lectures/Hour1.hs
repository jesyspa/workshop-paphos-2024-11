module Lectures.Hour1 where

{- Before we begin, some questions:

Q: What can types offer us?
Q: How is Haskell different from Java?


Let's also look at an example: expressions.
-}


------------------------- Functions ------------------------

myId :: a -> a
myId x = x

myConst :: a -> b -> a
myConst x _ = x


--------------------------- Bools --------------------------

-- A Boolean is either True or False.

myOr :: Bool -> Bool -> Bool
myOr True _ = True
myOr _ x    = x


------------------------- Integers -------------------------

-- An Int is a value between -2^31 and 2^31-1.

myMin :: Int -> Int -> Int
myMin a b | a > b  = a
myMin a b | a <= b = b


-------------------------- Pairs ---------------------------

-- A pair (A, B) is an A together with a B.

myFst :: (a, b) -> a
myFst (x, y) = x

swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)

mapPair :: (a -> b) -> (a, a) -> (b, b)
mapPair f (x, y) = (f x, f y)

diagonal :: a -> (a, a)
diagonal x = (x, x)


------------------------- Either ---------------------------

-- An Either A B is either a Left A or a Right B.

leftOr :: Either a b -> a -> a
leftOr (Left x) y = x
leftOr _        y = y

codiagonal :: Either a a -> a
codiagonal (Left x) = x
codiagonal (Right x) = x

mapEither :: (a -> b) -> Either a a -> Either b b
mapEither f (Left x) = Left (f x)
mapEither f (Right x) = Right (f x)


----------------- Lists and Pattern Matching ---------------

-- [A] is the type of lists with elements of type A.
-- a list is either:
-- * the empty list [], or
-- * a "cons" cell of the form x:xs

headOr :: [a] -> a -> a
headOr [] x = x
headOr (y:_) _ = y

myLength :: [a] -> Int
myLength = undefined

mySum :: [Int] -> Int
mySum = undefined

mapList :: (a -> b) -> [a] -> [b]
mapList = undefined