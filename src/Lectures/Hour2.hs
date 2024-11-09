module Lectures.Hour2 where
import Lectures.Hour1 (mapList)

------------------ Algebraic Data Types --------------------


data MyBool where
    MyFalse :: MyBool
    MyTrue :: MyBool

data MyPair a b where
    MyPair :: a -> b -> MyPair a b

data MyEither a b where
    MyLeft :: a -> MyEither a b
    MyRight :: b -> MyEither a b

data MyList a where
    MyNil :: MyList a
    MyCons :: a -> MyList a -> MyList a

-- New example: Maybe a is either an a or nothing.
-- Haskell doesn't have null, Maybe is usually used instead.
data MyMaybe a where
    MyNothing :: MyMaybe a
    MyJust :: a -> MyMaybe a

-- To make sure we can show these things:
deriving instance Show MyBool
deriving instance (Show a, Show b) => Show (MyPair a b)
deriving instance (Show a, Show b) => Show (MyEither a b)
deriving instance Show a => Show (MyList a)
deriving instance Show a => Show (MyMaybe a)

mySafeHead :: MyList a -> MyMaybe a
mySafeHead MyNil = MyNothing
mySafeHead (MyCons x xs) = MyJust x

mapMaybe :: (a -> b) -> MyMaybe a -> MyMaybe b
-- mapMaybe f (MyJust x) = MyJust (f x)
-- mapMaybe f MyNothing = MyNothing
mapMaybe f = go
    where go MyNothing = MyNothing
          go (MyJust x) = MyJust (f x) 

-- New example: binary trees
data BinTree a where
    Node :: BinTree a -> a -> BinTree a -> BinTree a
    Leaf :: a -> BinTree a

deriving instance Show a => Show (BinTree a)

mapTree :: (a -> b) -> BinTree a -> BinTree b
mapTree f = go
    where go (Node left v right) = Node (go left) (f v) (go right)
          go (Leaf x) = Leaf (f x)

foldTree :: (a -> r) -> (r -> a -> r -> r) ->     BinTree a -> r
foldTree g f = go
    where go (Leaf x) = g x
          go (Node left v right) = f (go left) v (go right)

flatMapTree :: BinTree a -> (a -> BinTree b) -> BinTree b
flatMapTree = undefined


-------------------- Typeclasses: Monoid -------------------

class MyMonoid a where
    mzero :: a
    (<+>) :: a -> a -> a

-- What are some monoids?

-- Let's look at the monoid for Int with (+) operation (Add, getAdd)

data Add where
    Add :: Int -> Add

getAdd :: Add -> Int
getAdd (Add x) = x

instance MyMonoid Add where
    mzero = Add 0
    Add x <+> Add y = Add (x + y)


------------------- Typeclasses: Functor -------------------

class MyFunctor (f :: * -> *) where
    myFmap :: (a -> b) -> f a -> f b

instance MyFunctor MyMaybe where
    myFmap f = go
        where go MyNothing = MyNothing
              go (MyJust x) = MyJust (f x)

instance MyFunctor [] where
    myFmap f = go
        where go [] = []
              go (x:xs) = f x : go xs

instance MyFunctor BinTree where
    myFmap = mapTree

-- What else that we've seen so far is a functor?
-- What *isn't* a functor?




------------------- Typeclasses: Foldable ------------------

class MyFoldable (t :: * -> *) where
    myFoldMap :: MyMonoid r => (a -> r) -> t a -> r

instance MyFoldable [] where
    myFoldMap f = go
        where go [] = mzero
              go (x:xs) = f x <+> go xs

instance MyFoldable BinTree where
    myFoldMap f = go
        where go (Node left v right) = go left <+> f v <+> go right
              go (Leaf x) = f x

-- What else is foldable?
-- What isn't foldable?

myLength :: MyFoldable t => t a -> Int
myLength ts = getAdd (myFoldMap (const (Add 1)) ts)

-- >>> myLength [1, 2, 3]
-- 3

-- What is myLength (MyJust 5)?

-- >>> length (Const 5)
-- Data constructor not in scope:
--   Const :: t0_a3hwZ[tau:1] -> t1_a3hwR[tau:1] a0_a3hwT[tau:1]

--- >>> :k (,,)
-- (,) :: * -> * -> *

