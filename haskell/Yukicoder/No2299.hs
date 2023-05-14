module Main where

split :: String -> [String]
split = go ("", [])
  where
    go :: (String, [String]) -> String -> [String]
    go (a, acc) "" = acc <> [a]
    go (a, acc) (' ' : xs) = go ("", acc <> [a]) xs
    go (a, acc) (x : xs) = go (a <> [x], acc) xs

prompt :: IO [String]
prompt = do split <$> getLine

m = 998244353

fac :: Integer -> Integer
fac 0 = 1
fac n = (fac (n - 1) * n) `mod` m

solve :: Integer -> Integer -> Integer -> Integer
solve n a b =
  let r = (fac n + ((m - 2) * fac (n - 1)) `mod` m) `mod` m
   in if a /= b then (r + fac (n - 2)) `mod` m else r

main :: IO ()
main = do
  vs <- prompt
  let [n, a, b] = map read [head vs, vs !! 1, vs !! 2]
  print $ solve n a b
