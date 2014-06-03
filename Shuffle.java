public class Shuffle {
	
	public static int fact(int n) {
		return fact(n, 1);
	}

	private static int fact(int n, int c) {
		if (n == 0) {
			return c;
		} else {
			return fact(n-1, c*n);
		}
	}

	public static int choose(int i, int j) {
		return (fact(i)/(fact(j) * fact(i - j)));
	}

	public static Card[] omit(int n, Card[] cards) {
		Card[] omitted = new Card[cards.length - 1];
		for (int i = 0; i < cards.length - 1; ++i) {
			int j = (i < n) ? i : i + 1;
			omitted[i] = cards[j];
		}
		return omitted;
	}

	public static Card[] 

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


