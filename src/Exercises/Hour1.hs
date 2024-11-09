module Exercises.Hour1 where
import Lectures.Hour1
import Prelude hiding (flip)

--- Functions ---

-- In Haskell, it is common to define functions very generically.
-- Because of this, often there is very little choice in how a function
-- can be implemented.  Use the types below to guide you.

apply :: (a -> b) -> a -> b
apply f x = f x 

compose :: (b -> c) -> (a -> b) -> a -> c
compose f g x = f (g x)

flip :: (a -> b -> c) -> b -> a -> c
flip f x y = f y x

joinParam :: (a -> a -> b) -> a -> b
joinParam f x = f x x

composeWithParam :: (a -> b) -> (b -> a -> c) -> a -> c
composeWithParam f g x = g (f x) x


--- Booleans ---

myNot :: Bool -> Bool
myNot True = False
myNot False = True

myAnd :: Bool -> Bool -> Bool
myAnd True x = x
myAnd False _ = False

-- a implies b if whenever a is true, so is b.
myImplies :: Bool -> Bool -> Bool
myImplies True False = False
myImplies _ _ = True



--- Integers ---

myMax :: Int -> Int -> Int
myMax x y = if x > y then x else y

myAbs :: Int -> Int
myAbs x = myMax x (-x)

-- The factorial of n is the product of all numbers 1 through n (inclusive).
-- For this exercise, it is okay if factorial n does not terminate if n < 0.
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)


--- Pairs ---

-- If we want to pass two parameters to a function, we have two options:
-- 1. Pass one, return a function that takes the second: a -> b -> c
-- 2. Pass both as a pair: (a, b) -> c
-- Form 1 is called the "curried" form, named after the mathematician Haskell Curry.
-- (Haskell itself is also named after him.)
-- The two functions below implement the equivalence.
myCurry :: ((a, b) -> c) -> a -> b -> c
myCurry f x y = f (x, y)

myUncurry :: (a -> b -> c) -> ((a, b) -> c)
myUncurry f (x, y) = f x y

-- map is a generic term used to refer to applying a function to
-- the parts of a data structure that it can work on.  In other words,
-- if you have a function that works on some part of a type, you can
-- map it to turn it into a function that applies to the type as a whole.
-- Here is an example for pairs.
mapSnd :: (a -> b) -> (c, a) -> (c, b)
mapSnd f (x, y) = (x, f y)

mapFst :: (a -> b) -> (a, c) -> (b, c)
mapFst f (x, y) = (f x, y)

-- Suppose p :: (Int, a) and  f :: a -> (Int, b)
-- Then mapSnd f p :: (Int, (Int, b))
-- Can you turn that into (Int, b) by adding the two Ints?
composeAndAdd :: (Int, a) -> (a -> (Int, b)) -> (Int, b)
composeAndAdd (x, y) f = mapFst (+x) (f y)

--- Either ---

-- We can see Either e a as a computation that can either succeed (by evaluating
-- to Right x) or fail (by evaluating to Left y).

isRight :: Either e a -> Bool
isRight (Right _) = True
isRight _         = False

mapRight :: (a -> b) -> Either e a -> Either e b
mapRight f (Right x) = Right (f x)
mapRight _ (Left x)  = Left x

composeIfRight :: Either e a -> (a -> Either e b) -> Either e b
composeIfRight (Right x) f = f x
composeIfRight (Left x) _  = Left x


--- Stateful computation ---

-- Suppose we want to write a program with some state that we want to
-- read and update.  We can do this by passing our functions an extra
-- parameter s, and returning a tuple that contains s.  However, we
-- need some helper functions to make this convenient.

mapWithState :: (a -> b) -> (s -> (s, a)) -> s -> (s, b)
mapWithState f g = mapSnd f . g

composeWithState :: (s -> (s, a)) -> (a -> s -> (s, b)) -> s -> (s, b)
composeWithState f g = myUncurry (flip g) . f

-- Let's write f(a) for s -> (s, a).
-- Then this function has type f(f(a)) -> f(a).
-- Such functions are generally called join.
joinWithState :: (s -> (s, s -> (s, a))) -> s -> (s, a)
joinWithState f x = g st
    where (st, g) = f x


--- Lists ---

myProduct :: [Int] -> Int
myProduct = myFoldr (*) 1

-- This is another example of a join function.
myConcat :: [[a]] -> [a]
myConcat = myFoldr (++) []

-- Try implementing this in two ways:
-- 1. Using `mapList` and `myConcat`.
-- 2. By recursion.
myConcatMap :: (a -> [b]) -> [a] -> [b]
myConcatMap f = myFoldr (++) [] . map f

-- The first parameter is a predicate p.  Return a list of only those
-- elements for which p returns True.
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f [] = []
myFilter f (x:xs) = if f x then [x] else [] ++ myFilter f xs

filterRight :: [Either e a] -> [a]
filterRight []             = []
filterRight ((Left x):xs)  = filterRight xs
filterRight ((Right x):xs) = x : filterRight xs


myZip :: [a] -> [b] -> [(a, b)]
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (y:ys) = (x, y) : myZip xs ys


-- Compose all the functions in the list: composeMany [f, g, h] = compose f (compose g h)
composeMany :: [(a -> a)] -> a -> a
composeMany [] = id
composeMany (f:fs) = compose f (composeMany fs)

-- This is a right fold over the list: foldr f e [a, b, c] is f a (f b (f c e)).
-- With a binary operator it is a little easier to see what's going on:
-- foldr (+) 0 [1, 2, 3] = 1 + (2 + (3 + 0))
myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f x [] = x
myFoldr f x (y:ys) = f y (myFoldr f x ys)

-- Try rewriting the list functions you've seen so far using myFoldr.
