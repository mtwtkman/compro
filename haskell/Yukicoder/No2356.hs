module Main where

-- https://yukicoder.me/problems/no/2356
split :: String -> [String]
split = go ("", [])
  where
    go :: (String, [String]) -> String -> [String]
    go (a, acc) "" = acc <> [a]
    go (a, acc) (' ' : xs) = go ("", acc <> [a]) xs
    go (a, acc) (x : xs) = go (a <> [x], acc) xs

prompt :: IO [String]
prompt = do split <$> getLine

promptN :: Int -> IO [[String]]
promptN n = go n []
  where
    go :: Int -> [[String]] -> IO [[String]]
    go 0 acc = return acc
    go n acc = do
      vs <- prompt
      go (n - 1) (acc <> [vs])

fixMod :: Int
fixMod = 998244353

pow :: Int -> Int -> Int -> Int
pow _ 0 _ = 1
pow x n m =
  let x' = x * x `mod` m
      n' = n `div` 2
      r = pow x' n' m
   in if odd n
        then (x * r) `mod` m
        else r

inv :: Int -> Int -> Int
inv x m = pow x (m - 2) m

extract :: [[String]] -> ([Char], [Int], Int)
extract = foldr f ([], [], 0)
  where
    f :: [String] -> ([Char], [Int], Int) -> ([Char], [Int], Int)
    f vs (ss, as, doorCount) =
      let s = head (head vs)
          a = read (last vs) :: Int
       in (s : ss, a : as, doorCount + a)

calcSeason :: Int -> [Char] -> [Int] -> (Int, Int, Int, Int)
calcSeason n ss as = go n ss as (0, 0, 0, 0)
  where
    go :: Int -> [Char] -> [Int] -> (Int, Int, Int, Int) -> (Int, Int, Int, Int)
    go 0 _ _ acc = acc
    go m (s : restS) (a : restA) (summer, fall, winter, spring) =
      let prd = pow (n - 1) a fixMod
          prd' = (prd + fixMod - pow (n - 2) a fixMod) `mod` fixMod
          prd'' = (prd' * inv (pow (n - 1) a fixMod) fixMod) `mod` fixMod
       in go
            (m - 1)
            restS
            restA
            ( case s of
                'U' -> ((summer + prd'') `mod` fixMod, fall, winter, spring)
                'F' -> (summer, (fall + prd'') `mod` fixMod, winter, spring)
                'W' -> (summer, fall, (winter + prd'') `mod` fixMod, spring)
                'P' -> (summer, fall, winter, spring + 1)
            )

solve :: Int -> Int -> Int -> Int -> Int -> Int -> Int
solve n doors summer fall winter spring =
  let a' = (1 * summer) `mod` fixMod
      a'' = (a' * fall) `mod` fixMod
      a''' = (a'' * winter) `mod` fixMod
      answer = (a''' * spring) `mod` fixMod
   in (answer * pow (n - 1) doors fixMod) `mod` fixMod

main :: IO ()
main = do
  inputN <- prompt
  let n = read (head inputN) :: Int
  vs <- promptN n
  let (ss, as, doorCount) = extract vs
      (summer, fall, winter, spring) = calcSeason n ss as
  print $ solve n doorCount summer fall winter spring
