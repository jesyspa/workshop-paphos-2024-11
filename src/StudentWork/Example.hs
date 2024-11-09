module StudentWork.Example where

data Exp a where
    EConst :: Int -> Exp a
    EVar :: a -> Exp a

mapExp :: (a -> b) -> Exp a -> Exp b
mapExp _ (EConst x) = EConst x
mapExp f (EVar x)   = EVar (f x) 

foldrExp :: (Exp a -> Exp b -> Exp b) -> Exp b -> [Exp a] -> Exp b
foldrExp _ x [] = x
foldrExp f x (y:ys) = f y (foldrExp f x ys)
