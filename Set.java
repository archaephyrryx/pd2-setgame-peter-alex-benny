import SetCards

type Pile = [Card]

-- Brutally Inefficient

triples :: Pile -> [[Card]]
triples p = [ [p !! i , p !! j] | i <- [0..m], j <- [i+1..m]]
    where
	m = (length p) - 1

sets :: Pile -> ([Card] -> Bool) -> [[Card]]
sets p f = map (\[a,b] -> [a,b,third a b]) $ filter (\[a,b] -> f [a,b] && elem (third a b) p) (triples p)

-- Less Inefficient : Find singleton sets first

present :: Prop p => (Card -> p) -> (p,p,p) -> [Card] -> [Bool]
present f (a,b,c) xs = present' xs (a,b,c) [False,False,False]
    where
        present' [] _ cs = cs
        present' (x:xs) (a,b,c) [hasA,hasB,hasC] | f x == a = (\[l,m,n] -> [True,m,n]) (present' xs (a,b,c) [hasA,hasB,hasC])
                            | f x == b = (\[l,m,n] -> [l,True,n]) (present' xs (a,b,c) [hasA,hasB,hasC])
                            | f x == c = (\[l,m,n] -> [l,m,True]) (present' xs (a,b,c) [hasA,hasB,hasC])

hasColor = present (\x -> color x) (Red,Green,Purple)
hasCount = present (\x -> count x) (One,Two,Three)
hasShape = present (\x -> shape x) (Oval,Diamond,Wave)
hasFill  = present (\x ->  fill x) (Empty,Shaded,Filled)

freq _ [] = 0
freq x (y:ys) | x == y = 1 + freq x ys
              | otherwise = freq x ys

hasProps :: [Card] -> [Bool]
hasProps = (map and).(apply [hasColor, hasCount, hasShape, hasFill])
    where      
        apply :: [(a -> b)] -> a -> [b]
        apply [] _ = []
        apply (f:fs) x = f x : apply fs x

enjoin :: (a -> Bool) -> (a -> Bool) -> (a -> Bool)
enjoin f g = (\x -> f x && g x)

join :: [Bool] -> [([Card] -> Bool)] -> ([Card] -> Bool)
join _ [] = (\_ -> True)
join (b:bs) (f:fs) | b = enjoin f (join bs fs)
                   | otherwise = join bs fs


same :: Prop p => (Card -> p) -> ([Card] -> Bool)
same f [a,b] = f a == f b

reset :: Pile -> [[Card]]
reset p | null p = []
        | length p < 3 = []
        | otherwise = let has = hasProps p in sets p (join (map not has) ([same color, same count, same shape, same fill]))