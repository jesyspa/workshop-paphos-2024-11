module Exercises.Hour2 where
import Lectures.Hour2

--- Expressions ---

data Op where
    PlusOp :: Op
    MulOp :: Op

-- Let's look at mathematical expressions again.
-- We will make the variable types a type variable.
data Exp a where
    EConst :: Int -> Exp a
    EVar :: a -> Exp a
    EOp :: Op -> Exp a -> Exp a -> Exp a
    -- ECall :: Exp a -> Exp a -> Exp a
    -- ELam :: a -> Exp a -> Exp a

-- The next line will let you show expressions.  You may need to remove it if you
-- modify the definition of expression in a way that makes showing one impossible.
deriving instance Show Op
deriving instance Show a => Show (Exp a)

-- Add more cases to the Exp class to support common operations.
-- What typeclasses can you implement for Exp?

-- Define functions for evaluating an expression and for taking the derivative of an expression.

-- So implement:
-- 1. Functor instance
-- 2. Foldable instance
-- 3. Fold function
-- 4. Evaluation function
-- 5. Derivative function

--- Your Own Datatype ---

{-
Come up with your own data type with one type parameter and write it in Haskell.
Write a functor and foldable instance for it.
Write a fold function for it.

You can start with the Exp class above, but you can also do your own thing.
-}


--- Monoids ---

-- Define a type MulInt that behaves like AddInt, but for multiplication.
data MulInt where
    {- Fill this in yourself. -}

getMul :: MulInt -> Int
getMul = undefined

instance MyMonoid MulInt where
    mzero = undefined
    (<+>) = undefined

-- Use MulInt and foldMap to implement the factorial function.
factorial :: Int -> Int
factorial = undefined

-- Define types BoolAnd and BoolOr, and define MyMonoid structures on them.

-- Define a monoid structure for lists.
instance MyMonoid [a] where
    mzero = undefined
    (<+>) = undefined

-- Bonus: A monoid should satisfy the following laws:
-- munit <+> x = x
-- x <+> munit = x
-- x <+> (y <+> z) = (x <+> y) <+> z
-- Use equational reasoning to prove the monoid laws.


--- Functions  ---

-- Use AddInt and MulInt to define sum and product functions on arbitrary foldables:
mySum :: MyFoldable t => t Int -> Int
mySum = undefined

myProduct :: MyFoldable t => t Int -> Int
myProduct = undefined

-- Define an is-element function for foldables: myElem a x precisely when a is one of
-- the elements of x.
-- Eq a is a constraint that lets you use == for values of type a.
myElem :: (Eq a, MyFoldable t) => a -> t a -> Bool
myElem = undefined

-- Bonus: define a find function, that returns an element satisfying a predicate,
-- if such an element exists:
myFind :: MyFoldable t => (a -> Bool) -> t a -> Maybe a
myFind = undefined


--- Homework ---

{-
Take the datatype you defined for Your Own Datatype and share it with the rest.

Make a .hs file in src/StudentWork with all of this and send a PR with your changes.
You will need to start your file with:
    module StudentWork.MyFile where
and will need to add StudentWork.MyFile to the workshop-recursion-schemes.cabal file.

See the example, or reach out if you get stuck!
-} 
