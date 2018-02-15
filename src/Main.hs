module Main (main) where

colors = renderSet (1920, 1080) (12000, 12000) (0.15, 0.8) 256

main = writeFile "set.pgm" (make_pgm 1920 1080 colors)

------------------------------------------------------------------------------------------------------------------

type Color = (Float, Float, Float)
type Complex = (Float, Float)

mul :: Complex -> Complex -> Complex
mul (x, y) (a, b) = (x * a - y * b, x * b + y * a)

scMul :: Complex -> Float -> Complex
scMul c@(x, y) m = mul c (m, 0)

add :: Complex -> Complex -> Complex
add (x, y) (a, b) = (x + a, y + b)

scAdd :: Complex -> Float -> Complex
scAdd (x, y) a = (x + a, y)

square :: Complex -> Complex
square (x, y) = (x * x - y * y, 2 * x * y)

sqLen :: Complex -> Float
sqLen (x, y) = x * x + y * y

------------------------------------------------------------------------------------------------------------------

make_pgm :: Int -> Int -> [ Color ] -> String
make_pgm width height xs = "P3\n" ++ show width ++ " " ++ show height ++ "\n255\n" ++ stringify(xs)
                  where stringify [] = ""
                        stringify ((r,g,b):xs) = show (round (r*255)) ++ " "
                                                 ++ show (round (g*255)) ++ " "
                                                 ++ show (round (b*255)) ++ " "
                                                 ++ stringify xs


color :: Complex -> Int -> Color
color k@(a, b) max = (dist, 0, 0)
            where
                xNext x = (square x) `add` k
                outSet x = sqLen x > 4.0
                distM :: Complex -> Int -> Int
                distM x lvl
                    | lvl > max = max
                    | outSet xn = lvl
                    | otherwise = distM xn (lvl+1)
                        where xn = xNext x
                dist = fromIntegral (distM (0, 0) 0) / fromIntegral max



renderSet :: (Int, Int) -> (Int, Int) -> (Float, Float) -> Int -> [Color]
renderSet (width, height) (stepX, stepY) (shiftX, shiftY) max =
             map col ([(cent a stepX shiftX, cent b stepY shiftY) | b <- [1..height], a <- [1..width]] :: [Complex])
             where
                 col c = color c max
                 cent :: Int -> Int -> Float -> Float
                 cent x mid shift = (fromIntegral (x - mid ) / fromIntegral mid) + shift
