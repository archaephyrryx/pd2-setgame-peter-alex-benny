module SetCards where

import Data.List
   
 
class (Eq a) => Prop a where
	complement :: a -> a -> a

data Count = One | Two | Three
    deriving (Show, Read, Eq, Ord, Enum)

instance Prop Count where
    complement x y = toEnum ((6 - fromEnum x - fromEnum y) `mod` 3)

data Fill = Empty | Shaded | Filled
    deriving (Show, Read, Eq, Ord, Enum)

instance Prop Fill where
    complement x y = toEnum ((6 - fromEnum x - fromEnum y) `mod` 3)

data Color = Red | Green | Purple
    deriving (Show, Read, Eq, Ord, Enum)

instance Prop Color where
    complement x y = toEnum ((6 - fromEnum x - fromEnum y) `mod` 3)

data Shape = Oval | Diamond | Wave
    deriving (Show, Read, Eq, Ord, Enum)

instance Prop Shape where
    complement x y = toEnum ((6 - fromEnum x - fromEnum y) `mod` 3)

type Props = (Count, Fill, Color, Shape)



data Card = Card { count :: Count, fill :: Fill, color :: Color, shape :: Shape }
	deriving (Read, Eq)

instance Show Card where
	show c =  unwords [show (count c), show (fill c), show (color c), show (shape c)]
	
instance Enum Card where
	toEnum n = let [i,f,c,s] = redux 4 3 n in Card (toEnum i) (toEnum f) (toEnum c) (toEnum s)
		where
			redux :: Int -> Int -> Int -> [Int]
			redux 0 _ _ = []
			redux n m x = let (q,r) = x `divMod` m in r : redux (n-1) m q
	fromEnum c = foldr (\x -> \y -> x + 3*y) 0 (propNums c)

keycard :: [Char] -> Card
keycard [n,f,c,s] = Card (nChar n) (fChar f) (cChar c) (sChar s)
    where
	nChar '1' = One 
	nChar '2' = Two
	nChar '3' = Three 
	fChar 'E' = Empty
	fChar 'S' = Shaded
	fChar 'F' = Filled
	cChar 'R' = Red
	cChar 'G' = Green
	cChar 'P' = Purple
	sChar 'O' = Oval
	sChar 'D' = Diamond
	sChar 'W' = Wave


propNums :: Card -> [Int]
propNums c = [fromEnum (count c), fromEnum (fill c), fromEnum(color c), fromEnum(shape c)]


instance Ord Card where
	compare c c' = compare (properties c) (properties c')

properties :: Card -> Props
properties c = (count c, fill c, color c, shape c)

complete :: Props -> Props -> Props
complete (a,i,m,x) (b,j,n,y) = (complement a b, complement i j, complement m n, complement x y)

isSet :: Card -> Card -> Card -> Bool
isSet x y z = completes (properties x) (properties y) (properties z)
    where
	completes :: Props -> Props -> Props -> Bool
	completes a b c = c == (complete a b)
