module Main where

-- https://yukicoder.me/problems/no/2297

solve :: Int -> Int
solve x = case x `mod` 3 of
  0 -> 0
  1 -> 2
  2 -> 1

main :: IO ()
main = do
  v <- getLine
  let n = read v :: Int
  print $ solve n
