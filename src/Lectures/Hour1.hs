module Lectures.Hour1 where

{- Before we begin, some questions:

Q: How is Haskell different from Java?
- Syntax
- Immutability
- Purity
- No JetBrains IDE
- Reference transparency
- Lots of complicated type stuff
- Type inference
- Lazy vs eager evaluation f(g(x))

Q: What can types offer us?
- Correctness, embedded logic
- Documentation
- Tooling
- Genericity -> compiler does work for you
- Optimisation

Q: What do types cost us?
- Verbosity
- Slower compilation
- Complicated error messages
- Abstract thinking
- Incompleteness
- Room for mistakes in type choice
- Rigidity, large scale changes

Let's also look at an example: expressions.
-}


------------------------- Functions ------------------------


myId :: a -> a
myId x = x

myConst :: a -> b -> a
myConst x y = x


--------------------------- Bools --------------------------

-- A Boolean is either True or False.

myOr :: Bool -> (Bool -> Bool)
-- myOr x y = if x then True else y
-- myOr x y = case x of
--             True -> True
--             False -> y
-- myOr True y = True
-- myOr False y = y

myOr True = myConst True
myOr False = myId


------------------------- Integers -------------------------

-- An Int is a value between -2^31 and 2^31-1.

myMin :: Int -> Int -> Int
-- myMin a b = if a > b then b else a
myMin a b | a > b = b
          | otherwise = a


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
leftOr (Left y) x = y
leftOr (Right z) x = x

codiagonal :: Either a a -> a
codiagonal = undefined

mapEither :: (a -> b) -> Either a a -> Either b b
mapEither f e = case e of
                  Left x -> Left (f x)
                  Right y -> Right (f y)


----------------- Lists and Pattern Matching ---------------

-- [A] is the type of lists with elements of type A.
-- a list is either:
-- * the empty list [], or
-- * a "cons" cell of the form x:xs

headOr :: [a] -> a -> a
headOr [] y = y
headOr (x:xs) y = x

myLength :: [a] -> Int
myLength = undefined

mySum :: [Int] -> Int
mySum = undefined

mapList :: (a -> b) -> [a] -> [b]
mapList = undefined