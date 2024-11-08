module Lectures.Hour2 where
import Lectures.Hour1 (mapList)

------------------ Algebraic Data Types --------------------


data MyBool where

data MyPair a b where

data MyEither a b where

data MyList a where

-- New example: Maybe a is either an a or nothing.
-- Haskell doesn't have null, Maybe is usually used instead.
data MyMaybe a where

-- To make sure we can show these things:
deriving instance Show MyBool
deriving instance (Show a, Show b) => Show (MyPair a b)
deriving instance (Show a, Show b) => Show (MyEither a b)
deriving instance Show a => Show (MyList a)
deriving instance Show a => Show (MyMaybe a)

mySafeHead :: MyList a -> MyMaybe a
mySafeHead = undefined

mapMaybe :: (a -> b) -> MyMaybe a -> MyMaybe b
mapMaybe = undefined

-- New example: binary trees
data BinTree a where

deriving instance Show a => Show (BinTree a)

mapTree :: (a -> b) -> BinTree a -> BinTree b
mapTree = undefined

foldTree :: (a -> r) -> (r -> r -> r) -> BinTree a -> r
foldTree = undefined

flatMapTree :: BinTree a -> (a -> BinTree b) -> BinTree b
flatMapTree = undefined


-------------------- Typeclasses: Monoid -------------------

class MyMonoid a where
    mzero :: a
    (<+>) :: a -> a -> a

-- What are some monoids?

-- Let's look at the monoid for Int with (+) operation (Add, getAdd)


------------------- Typeclasses: Functor -------------------

class MyFunctor (f :: * -> *) where
    myFmap :: (a -> b) -> f a -> f b

instance MyFunctor MyMaybe where
    myFmap = undefined

instance MyFunctor [] where
    myFmap = undefined

instance MyFunctor BinTree where
    myFmap = undefined

-- What else that we've seen so far is a functor?
-- What *isn't* a functor?


------------------- Typeclasses: Foldable ------------------

class MyFoldable (t :: * -> *) where
    myFoldMap :: MyMonoid r => (a -> r) -> t a -> r

instance MyFoldable [] where
    myFoldMap = undefined

instance MyFoldable BinTree where
    myFoldMap = undefined

-- What else is foldable?
-- What isn't foldable?

myLength :: MyFoldable t => t a -> Int
myLength = undefined

-- What is myLength (MyJust 5)?


