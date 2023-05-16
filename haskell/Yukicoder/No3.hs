module Main where

-- https://yukicoder.me/problems/11
split :: String -> [String]
split = go ("", [])
  where
    go :: (String, [String]) -> String -> [String]
    go (a, acc) "" = acc <> [a]
    go (a, acc) (' ' : xs) = go ("", acc <> [a]) xs
    go (a, acc) (x : xs) = go (a <> [x], acc) xs

prompt :: IO [String]
prompt = do split <$> getLine

bin :: Int -> [Int]
bin x
  | x <= 1 = [x]
  | otherwise =
      let (n, r) = x `quotRem` 2
       in bin n <> [r]

step :: Int -> Int
step = sum . bin

solve :: Int -> Int
solve n = go [(1, 1)] []
  where
    go :: [(Int, Int)] -> [Int] -> Int
    go [] _ = -1
    go ((p, c) : qs) visited =
      if p == n
        then c
        else
          let prev = p - step p
              next = p + step p
              canPrev = prev > 0 && notElem prev visited
              canNext = next <= n && notElem next visited
              q = [(prev, c + 1) | canPrev] <> [(next, c + 1) | canNext]
              v' = [prev | canPrev] <> [next | canNext]
           in go (qs <> q) (v' <> visited)

main :: IO ()
main = do
  n :: Int <- read . head <$> prompt
  print $ solve n
