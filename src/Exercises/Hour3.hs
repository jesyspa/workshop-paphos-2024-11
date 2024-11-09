module Exercises.Hour3 where
import Lectures.Hour3

--- Your own datatype ---

-- Yesterday, you defined a recursive datatype with one parameter.
-- Exercise: Define a base functor for it and make a Functor instance for it.
-- Check that the fold function you get behaves the same way as the fold function
-- you wrote by hand.

-- Exercise: write a specialised unfold function for your type.
-- Check that it behaves the same way as the unfold function you get by taking
-- the fixpoint of your base functor.


--- Calculator ---

data Exp where
    Number :: Int -> Exp
    X :: Exp
    Plus :: Exp -> Exp -> Exp
    Times :: Exp -> Exp -> Exp

deriving instance Show Exp

-- Define a base functor ExpF for Exp.
data ExpF r where
    -- Fill this in

-- Exercise: define a Functor instance for ExpF
instance Functor ExpF where
    fmap = undefined

-- Exercise: Define pack and unpack functions
packExp :: ExpF Exp -> Exp
packExp = undefined
unpackExp :: Exp -> ExpF Exp
unpackExp = undefined

fixToExp :: Fix ExpF -> Exp
fixToExp = fold packExp

expToFix :: Exp -> Fix ExpF
expToFix = unfold unpackExp

-- Exercise: Given a number n, generate the expression for x^n
xToThePower :: Int -> Fix ExpF
xToThePower = unfold undefined

-- Exercise: Given a value for X, compute the result of the expression.
evaluateExpF :: Int -> Fix ExpF -> Int
evaluateExpF x = fold undefined

-- Exercise: Given an expression, try to compute its derivative.
-- What problem do you run into?
derivative :: Fix ExpF -> Fix ExpF
derivative = undefined


--- Sorting with folds and unfolds ---

-- Many sorting algorithms can be seen as combinations of folds and unfolds.
-- We'll look at a few examples here.

-- Insertion sort acts by keeping a sorted list and inserting elements
-- into it.
-- Exercise: implement insert
insertionSort1 :: [Int] -> [Int]
insertionSort1 = foldList insert []
    where insert :: Int -> [Int] -> [Int]
          insert x ys = undefined

-- Selection sort works dually: it starts with a list and takes its least element.
-- Exercise: implement select.
selectionSort1 :: [Int] -> [Int]
selectionSort1 = unfoldList select
    where --- select [2, 6, 4, 3] = Just (2, [6, 4, 3])
          select :: [Int] -> Maybe (Int, [Int])
          select xs = undefined

-- Bubble sort is a variation on this: it finds the least element, but it does so
-- by calling the function recursively.  This means that it may change the order
-- in the remainder of the list, unlike selection sort.
bubbleSort1 :: [Int] -> [Int]
bubbleSort1 = unfoldList bubble
    where -- bubble [2, 6, 4, 3] = Just (2, [3, 6, 4])
          bubble :: [Int] -> Maybe (Int, [Int])
          bubble = undefined
                                    

-- Exercise: Rewrite insertionSort using fold instead of foldList.
insertionSort2 :: List Int -> List Int
insertionSort2 = fold insert
    where insert :: ListF Int (List Int) -> List Int
          insert = undefined

-- Because their types are so different, we can't easily compose foldList and unfoldList.
-- But fold and unfold are actually quite similar: both take a function and return a function.
-- Exercise:
-- 1. Suppose unfold (fold g) :: Fix f -> Fix f.  What is the type of g?
-- 2. What is the type of h in fold (unfold h) :: Fix f -> Fix f?

-- Exercise: Rewrite insertion sort to use a composition of fold and unfold.
-- In other words: rewrite your insert function from insertionSort2 as an unfold.
-- This is actually not so strange: notice that every branch involves a Pack.
insertionSort3 :: List Int -> List Int
insertionSort3 = fold (unfold insert1)
    where insert1 :: a -- replace this with actual type
          insert1 = undefined

-- Let's try the same with bubble sort.
-- Exercise: Rewrite bubbleSort using unfold instead of unfoldList
bubbleSort2 :: List Int -> List Int
bubbleSort2 = unfold bubble
    where bubble :: List Int -> ListF Int (List Int)
          bubble = undefined

-- Exercise: Express bubble sort as an unfold of a fold.
bubbleSort3 :: List Int -> List Int
bubbleSort3 = unfold (fold bubble1)
    where bubble1 :: a -- replace this with the actual type
          bubble1 = undefined

-- Notice that there is a similarity between insert1 and bubble1.
-- Let's implement both of them the same way.

-- Exercise: write a swap function that captures the main logic of insert1 and bubble1.
swap :: ListF Int (ListF Int (List Int)) -> ListF Int (ListF Int (List Int))
swap = undefined

-- Exercise: Use swap to implement these.
-- Hint: Look at the types!  Do the simplest thing to make those work, and you'll
--       get the right answer.
insertionSort4, bubbleSort4 :: List Int -> List Int
insertionSort4 = fold (unfold undefined)
bubbleSort4 = unfold (fold undefined)


--- More folds and unfolds ---

-- We have been looking at the following square a lot:
--
--              fmap (fold phi)
--   f (Fix f) ----------------> f r
--       ^                        |
--       |                        |
--       | unpack                 | phi
--       |                        |
--       |         fold phi       v
--     Fix f  ----------------->  r 
--
-- Following the arrows, by the time we get to f r, we've lost a lot
-- of information about Fix f.  What if we maintain it?
--
-- Exercise: define a function split that takes two functions and pairs up
-- their product.
split :: (s -> a) -> (s -> b) -> s -> (a, b)
split = undefined

-- Now we will used this to get the following picture:
--
--                  fmap (par (nabla phi) id)
--   f (Fix f) --------------------------------> f (Fix f, r)
--         ^                                         |
--         |                                         |
--         | unpack                                  | phi
--         |                                         |
--         |               para phi                  v
--       Fix f  ---------------------------------->  r 
--
-- Now phi can use not only the result r, but also the original value
-- that got computed into that r.  This is knows as a paramorphism,
-- so we call it para for short.

-- Exercise: define para
-- Can you express it as a normal fold?
para :: Functor f => (f (Fix f, r) -> r) -> Fix f -> r
para = undefined

-- Exercise: go back to the exercise about the derivative, and solve it using para.

-- Bonus: A similar situation happens with unfolds, where it is called an apomorphism.
-- Exercise: draw the diagram.  Hint: a product won't work here, try something else.

-- Other sorts have also been formulated as folds and unfolds.
-- Further reading: http://www.cs.ox.ac.uk/ralf.hinze/publications/Sorting.pdf


--- Foldable instance for Fix f ---

-- We cannot make a Foldable instance for Fix f, because Foldable needs
-- a parametrised type, and Fix f doesn't take a parameter.
-- Formally speaking: Foldable has kind (* -> *) -> Constraint, but
--   Fix f :: *, so Foldable (Fix f) is ill-formed.
-- To simulate this, we can introduce Fix1.

data Fix1 f a where
    Pack1 :: f a (Fix1 f a) -> Fix1 f a

unpack1 :: Fix1 f a -> f a (Fix1 f a)
unpack1 (Pack1 x) = x

class Functor1 f where
    fmap1 :: (a -> b) -> f c a -> f c b

-- Exercise: define the Functor1 instance for ListF.
instance Functor1 ListF where
    fmap1 = undefined

-- Exercise: define fold1 and unfold1.
fold1 :: Functor1 f => (f a r -> r) -> Fix1 f a -> r
fold1 phi = undefined
unfold1 :: Functor1 f => (s -> f a s) -> s -> Fix1 f a
unfold1 psi = undefined

-- We can now define a one-level analog of Foldable, which lets
-- us define how to fold the base functor f.
class FoldableF f where
    foldMapT :: Monoid m => (a -> m) -> (r -> m) -> f a r -> m

-- Exercise: define a foldable instance for Fix1 f.
instance (FoldableF f, Functor1 f) => Foldable (Fix1 f) where
    foldMap = undefined
