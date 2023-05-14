module Main where

-- https://yukicoder.me/problems/no/2298

solve :: String -> Int
solve = fst . go (0, 0)
  where
    go :: (Int, Int) -> String -> (Int, Int)
    go (n, acc) "" = (max acc n, 0)
    go (n, acc) ('y' : 'u' : 'k' : 'i' : 'c' : 'o' : 'd' : 'e' : 'r' : xs) = go (n, acc + 1) xs
    go (n, acc) (_ : xs) = go (max acc n, 0) xs

main :: IO ()
main = do
  s <- getLine
  print $ solve s
