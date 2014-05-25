module Shuffle where

(!) :: Int -> Int
(!) n = product [1..n]

choose :: Int -> Int -> Int
choose a b = (product [a-b+1..a])`div`(product [1..b])

omit :: Int -> ([a] -> [a])
omit 0 = tail
omit n = (\(x:xs) -> x:(omit (n-1) xs))

shuffle :: Int -> Int -> ([a] -> [a])
shuffle 0 _ = id
shuffle n i | q == 0  = (\(x:xs) -> x:(shuffle (n-1) r xs))
	    | otherwise = (\xs -> (xs !! q):(shuffle (n-1) r (omit q xs)))
	    where
		 q = i `div` ((!) (n-1)) 
		 r = i `rem` ((!) (n-1)) 


deal :: Int -> Int -> Int -> ([a] -> [a])
deal m n i | m > n = (\_ -> [])
           | m == 0 = (\_ -> [])
	   | m == n = shuffle n i
	   | i < q = (\(x:xs) -> x:(deal (m-1) (n-1) i xs))
	   | otherwise = (\(_:xs) -> (deal m (n-1) r xs))
	   where
                q = (choose (n-1) (m-1))
		r = i - q


