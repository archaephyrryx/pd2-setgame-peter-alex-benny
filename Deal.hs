module Deal where

import SetCards
import Shuffle
import System.Random

main = do
    g <- newStdGen
    let x = fst $ randomR (0, (choose 81 12) - 1) g
    let n = deal 12 81 x [0..80]
    print ((map toEnum n) :: [Card])
