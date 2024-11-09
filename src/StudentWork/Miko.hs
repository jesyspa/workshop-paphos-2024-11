module StudentWork.Miko where

data Exp a where
    EConst :: Int -> Exp a
    EVar :: a -> Exp a
    ESum :: Exp a -> Exp a -> Exp a
    EProd :: Exp a -> Exp a -> Exp a


mapExp :: (a -> b) -> Exp a -> Exp b
mapExp _ (EConst x) = EConst x
mapExp f (EVar x)   = EVar (f x) 
mapExp f (ESum x y) = ESum (mapExp f x) (mapExp f y)
mapExp f (EProd x y) = EProd (mapExp f x) (mapExp f y)

foldExp :: Num a => (a -> Int) -> Exp a -> Int
foldExp _ (EConst x) = x
foldExp f (EVar x) = f x
foldExp f (ESum x y) = foldExp f x + foldExp f y
foldExp f (EProd x y) = foldExp f x * foldrExp f y

