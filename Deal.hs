module Deal where

import SetCards
import Shuffle
import System.Random



deal :: Int -> (Int -> [Card])
deal n = \x -> map toEnum (take n (shuffle 81 x [0..80]))

main = do
    g <- newStdGen
    let x = (fst (randomR (1, (!) 81) g )) - 1
    let n = deal 12 x
    print n

