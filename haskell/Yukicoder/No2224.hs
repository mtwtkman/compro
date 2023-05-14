module Main where

-- https://yukicoder.me/problems/no/2224

solve :: String -> Int
solve ('x':xs) = 2 ^ 32 - read xs :: Int
solve xs = read xs

main :: IO ()
main = do
  s <- getLine
  print $ solve s
