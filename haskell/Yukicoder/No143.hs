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


solve :: Int -> Int -> Int -> [Int] -> Int
solve k n f vs = let totalAge = sum vs
                     totalBeans = k * n
                  in if totalBeans < totalAge then -1 else totalBeans - totalAge

main :: IO ()
main = do
  input1 <- prompt
  input2 <- prompt
  let [k, n, f] = map read [head input1, input1 !! 1, input1 !! 2]
      vs = map read input2
  print $ solve k n f vs
