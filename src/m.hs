module Main (main) where

--import Data.Complex


main = putStrLn "lol"
    --putStrLn "lol"

{-
type Color = (Float, Float, Float)


make_pgm :: Int -> Int -> [ Color ] -> String
make_pgm width height xs = "P3\n" ++ show width ++ " " ++ show height ++ "\n255\n" ++ stringify(xs)
                  where stringify [] = ""
                        stringify ((r,g,b):xs) = show (round (r*255)) ++ " "
                                                 ++ show (round (g*255)) ++ " "
                                                 ++ show (round (b*255)) ++ " "
                                                 ++ stringify xs


distance :: Float -> Int -> Int
distance point max
    | max == 0  = 0
    | otherwise = 1
-}