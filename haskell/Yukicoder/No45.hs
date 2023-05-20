module Main where

-- https://yukicoder.me/problems/no/45
split :: String -> [String]
split = go ("", [])
  where
    go :: (String, [String]) -> String -> [String]
    go (a, acc) "" = acc <> [a]
    go (a, acc) (' ' : xs) = go ("", acc <> [a]) xs
    go (a, acc) (x : xs) = go (a <> [x], acc) xs

prompt :: IO [String]
prompt = do split <$> getLine

solve :: Int -> [Int] -> Int
solve n (v : vs) = go 1 (0, v) vs
  where
    go :: Int -> (Int, Int) -> [Int] -> Int
    go _ (_, r) [] = r
    go i (a, b) (x : xs)
      | i == n = b
      | otherwise = go (i + 1) (b, max (a + x) b) xs

main :: IO ()
main = do
  n :: Int <- read . head <$> prompt
  vs :: [Int] <- map read <$> prompt
  print $ solve n vs
