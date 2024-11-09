module StudentWork.Example where

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

foldrExp :: (Exp a -> Exp b -> Exp b) -> Exp b -> [Exp a] -> Exp b
foldrExp _ x [] = x
foldrExp f x (y:ys) = f y (foldrExp f x ys)
