import SetCards

type Pile = [Card]

-- Brutally Inefficient

triples :: Pile -> [[Card]]
triples p = [ [p !! i , p !! j , p !! k] | i <- [0..m], j <- [i+1..m], k <- [j+1..m] ]
    where
	m = (length p) - 1

sets :: Pile -> [[Card]]
sets p = filter (\[a,b,c] -> isSet a b c) (triples p)

-- Less Inefficient : Find singleton sets first

group :: Prop p => (Card -> p) -> (p,p,p) -> [Card] -> [[Card]]
group f (a,b,c) xs = group' xs (a,b,c) [[],[],[]]
    where
	group' [] _ cs = cs
	group' (x:xs) (a,b,c) [as,bs,cs] | f x == a = (\[l,m,n] -> [x:l,m,n]) (group' xs (a,b,c) [as,bs,cs])
					 | f x == b = (\[l,m,n] -> [l,x:m,n]) (group' xs (a,b,c) [as,bs,cs])
					 | f x == c = (\[l,m,n] -> [l,m,x:n]) (group' xs (a,b,c) [as,bs,cs])

groupColor = group (\x -> color x) (Red,Green,Purple)
groupCount = group (\x -> count x) (One,Two,Three)
groupShape = group (\x -> shape x) (Oval,Diamond,Wave)
groupFill = group (\x -> fill x) (Empty,Shaded,Filled)

preset :: [String] -> Pile -> [[Card]]
preset xs p | null p = []
	    | length p < 3 = []
            | not (elem "color" xs) && isolated (groupColor p) = unicolor
            | not (elem "count" xs) && isolated (groupCount p) = unicount
            | not (elem "shape" xs) && isolated (groupShape p) = unishape
            | not (elem "fill"  xs) && isolated (groupFill  p) = unifill
	    | otherwise = reset p
	    where
		unicolor = concat (map (preset ("color":xs)) (groupColor p))
		unicount = concat (map (preset ("count":xs)) (groupCount p))
		unishape = concat (map (preset ("shape":xs)) (groupShape p))
		unifill  = concat (map (preset  ("fill":xs)) (groupFill  p))
		isolated = any null

reset :: Pile -> [[Card]]
reset p | null p = []
        | length p < 3 = []
        | otherwise = sets p
