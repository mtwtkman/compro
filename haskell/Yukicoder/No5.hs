module Main where

-- https://yukicoder.me/problems/no/5

import Data.List (sort)

split :: String -> [String]
split = go ("", [])
  where
    go :: (String, [String]) -> String -> [String]
    go (a, acc) "" = acc <> [a]
    go (a, acc) (' ' : xs) = go ("", acc <> [a]) xs
    go (a, acc) (x : xs) = go (a <> [x], acc) xs

prompt :: IO [String]
prompt = do split <$> getLine

solve :: Int -> Int -> [Int] -> Int
solve l n ws = go 0 l (sort ws)
  where
    go :: Int -> Int -> [Int] -> Int
    go c acc [] = c
    go c 0 _ = c
    go c acc (x : xs) = if acc < x then c else go (c + 1) (acc - x) xs

main :: IO ()
main = do
  l :: Int <- read . head <$> prompt
  n :: Int <- read . head <$> prompt
  ws :: [Int] <- map read <$> prompt
  print $ solve l n ws
