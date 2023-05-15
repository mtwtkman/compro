module Main where

-- https://yukicoder.me/problems/111
split :: String -> [String]
split = go ("", [])
  where
    go :: (String, [String]) -> String -> [String]
    go (a, acc) "" = acc <> [a]
    go (a, acc) (' ' : xs) = go ("", acc <> [a]) xs
    go (a, acc) (x : xs) = go (a <> [x], acc) xs

prompt :: IO [String]
prompt = do split <$> getLine

solve :: Int -> Int -> Int
solve d p = d + d * p `div` 100

main :: IO ()
main = do
  v <- prompt
  let [d, p] = map read [head v, v !! 1]
  print $ solve d p
