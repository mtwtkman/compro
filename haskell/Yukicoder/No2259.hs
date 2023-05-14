module Main where

-- https://yukicoder.me/problems/no/2259
split :: String -> [String]
split = go ("", [])
  where
    go :: (String, [String]) -> String -> [String]
    go (a, acc) "" = acc <> [a]
    go (a, acc) (' ' : xs) = go ("", acc <> [a]) xs
    go (a, acc) (x : xs) = go (a <> [x], acc) xs

solve :: Int -> Int -> Int -> Int
solve l r c = go 1000 l
  where
    go :: Int -> Int -> Int
    go acc i
      | i > r = acc
      | otherwise =
          let v = (i * c) `mod` 1000
           in if v == 0
                then 0
                else go (min acc (1000 - v)) (i + 1)

prompt :: IO [String]
prompt = do split <$> getLine

main :: IO ()
main = do
  vs <- prompt
  let [l, r, c] = map read [head vs, vs !! 1, vs !! 2]
  print $ solve l r c
