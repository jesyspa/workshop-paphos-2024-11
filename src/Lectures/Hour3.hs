module Lectures.Hour3 where

------------------------ Folding ---------------------------

-- Let us take another look at lists and folds.

data IntList where

deriving instance Show IntList

foldIntList :: (Int -> r -> r) -> r -> IntList -> r
foldIntList = undefined

-- Let's look at a single step.
data IntListF r where

-- So a step is given by IntListF r -> r

foldIntList1 :: (IntListF r -> r) -> IntList -> r
foldIntList1 = undefined

instance Functor IntListF where
    fmap = undefined


unpackIntList :: IntList -> IntListF (IntList)
unpackIntList = undefined

foldIntList2 :: (IntListF r -> r) -> IntList -> r
foldIntList2 = undefined


---------------------- Fixpoints ---------------------------

-- What did we need for foldIntList2? (4 things)

data Fix (f :: * -> *) where

unpack :: Fix f -> f (Fix f)
unpack = undefined

fold :: Functor f => (f r -> r) -> Fix f -> r
fold = undefined


data ListF a r where
    NilF :: ListF a r
    ConsF :: a -> r -> ListF a r

unpackList :: [a] -> ListF a [a]
unpackList = undefined

packList :: ListF a [a] -> [a]
packList = undefined

instance Functor (ListF a) where
    fmap = undefined

type List a = Fix (ListF a)

listToFix :: [a] -> List a
listToFix = undefined

listFromFix :: List a -> [a]
listFromFix = undefined

asListFun :: (List a -> List b) -> [a] -> [b]
asListFun = undefined

------------------------ Unfolds ---------------------------

unfold :: Functor f => (s -> f s) -> s -> Fix f
unfold = undefined

-- Okay, but let's be more concrete.
-- What is unfold for lists?

unfoldList :: (s -> Maybe (a, s)) -> s -> [a]
unfoldList = undefined

-- Compare this to foldList:
foldList :: (a -> r -> r) -> r -> [a] -> r
foldList = undefined

-- Is this ever useful?

-- Given a and b, generate a list of all numbers a ... b-1.
range :: Int -> Int -> [Int]
range = undefined

-- Generate an infinite list of Fibonacci numbers.
fibonacci :: [Int]
fibonacci = undefined

---------------------- Data and Codata ---------------------

-- Notice: Data can be broken down, codata can be built up.
-- In Haskell, recursive types are data *and* codata.
-- 


