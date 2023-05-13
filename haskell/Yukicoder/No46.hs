module Main where

-- https://yukicoder.me/problems/43

split :: String -> [String]
split = go ("", [])
  where
    go :: (String, [String]) -> String -> [String]
    go (a, acc) "" = acc <> [a]
    go (a, acc) (' ' : xs) = go ("", acc <> [a]) xs
    go (a, acc) (x : xs) = go (a <> [x], acc) xs

prompt :: IO [String]
prompt = do split <$> getLine

tupleInput :: [String] -> (Int, Int)
tupleInput xs = (read $ head xs, read $ last xs)

main :: IO ()
main = do
  vs <- prompt
  let (a,b) = tupleInput vs
      (n,r) = b `quotRem` a
  print $ n + max (min r 1) 0
