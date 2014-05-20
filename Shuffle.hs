module Shuffle where

(!) :: Int -> Int
(!) n = product [1..n]

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
