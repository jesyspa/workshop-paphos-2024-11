module Exercises.Hour1 where
import Lectures.Hour1

-- >>> 2 + 2
-- 4

--- Functions ---

-- In Haskell, it is common to define functions very generically.
-- Because of this, often there is very little choice in how a function
-- can be implemented.  Use the types below to guide you.

apply :: (a -> b) -> a -> b
apply = undefined

compose :: (b -> c) -> (a -> b) -> a -> c
compose = undefined

flip :: (a -> b -> c) -> b -> a -> c
flip = undefined

joinParam :: (a -> a -> b) -> a -> b
joinParam = undefined

composeWithParam :: (a -> b) -> (b -> a -> c) -> a -> c
composeWithParam = undefined


--- Booleans ---

myNot :: Bool -> Bool
myNot = undefined

myAnd :: Bool -> Bool -> Bool
myAnd = undefined

-- a implies b if whenever a is true, so is b.
myImplies :: Bool -> Bool -> Bool
myImplies = undefined


--- Integers ---

myMax :: Int -> Int -> Int
myMax = undefined

myAbs :: Int -> Int
myAbs = undefined

-- The factorial of n is the product of all numbers 1 through n (inclusive).
-- For this exercise, it is okay if factorial n does not terminate if n < 0.
factorial :: Int -> Int
factorial = undefined


--- Pairs ---

-- If we want to pass two parameters to a function, we have two options:
-- 1. Pass one, return a function that takes the second: a -> b -> c
-- 2. Pass both as a pair: (a, b) -> c
-- Form 1 is called the "curried" form, named after the mathematician Haskell Curry.
-- (Haskell itself is also named after him.)
-- The two functions below implement the equivalence.
myCurry :: ((a, b) -> c) -> a -> b -> c
myCurry = undefined

myUncurry :: (a -> b -> c) -> ((a, b) -> c)
myUncurry = undefined

-- map is a generic term used to refer to applying a function to
-- the parts of a data structure that it can work on.  In other words,
-- if you have a function that works on some part of a type, you can
-- map it to turn it into a function that applies to the type as a whole.
-- Here is an example for pairs.
mapSnd :: (a -> b) -> (c, a) -> (c, b)
mapSnd = undefined

-- Suppose p :: (Int, a) and  f :: a -> (Int, b)
-- Then mapSnd f p :: (Int, (Int, b))
-- Can you turn that into (Int, b) by adding the two Ints?
composeAndAdd :: (Int, a) -> (a -> (Int, b)) -> (Int, b)
composeAndAdd = undefined


--- Either ---

-- We can see Either e a as a computation that can either succeed (by evaluating
-- to Right x) or fail (by evaluating to Left y).

isRight :: Either e a -> Bool
isRight = undefined

mapRight :: (a -> b) -> Either e a -> Either e b
mapRight = undefined

composeIfRight :: Either e a -> (a -> Either e b) -> Either e b
composeIfRight = undefined


--- Stateful computation ---

-- Suppose we want to write a program with some state that we want to
-- read and update.  We can do this by passing our functions an extra
-- parameter s, and returning a tuple that contains s.  However, we
-- need some helper functions to make this convenient.

mapWithState :: (a -> b) -> (s -> (s, a)) -> s -> (s, b)
mapWithState = undefined

composeWithState :: (s -> (s, a)) -> (a -> s -> (s, b)) -> s -> (s, b)
composeWithState = undefined

-- Let's write f(a) for s -> (s, a).
-- Then this function has type f(f(a)) -> f(a).
-- Such functions are generally called join.
joinWithState :: (s -> (s, s -> (s, a))) -> s -> (s, a)
joinWithState = undefined


--- Lists ---

myProduct :: [Int] -> Int
myProduct = undefined

-- This is another example of a join function.
myConcat :: [[a]] -> [a]
myConcat = undefined

-- Try implementing this in two ways:
-- 1. Using `mapList` and `myConcat`.
-- 2. By recursion.
myConcatMap :: (a -> [b]) -> [a] -> [b]
myConcatMap = undefined

-- The first parameter is a predicate p.  Return a list of only those
-- elements for which p returns True.
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter = undefined

filterRight :: [Either e a] -> [a]
filterRight = undefined

myZip :: [a] -> [b] -> [(a, b)]
myZip = undefined

-- Compose all the functions in the list: composeMany [f, g, h] = compose f (compose g h)
composeMany :: [(a -> a)] -> a -> a
composeMany = undefined

-- This is a right fold over the list: foldr f e [a, b, c] is f a (f b (f c e)).
-- With a binary operator it is a little easier to see what's going on:
-- foldr (+) 0 [1, 2, 3] = 1 + (2 + (3 + 0))
myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr = undefined

-- Try rewriting the list functions you've seen so far using myFoldr.
