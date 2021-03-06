import Data.Bits(xor)
import Data.Char(chr)
import System.Environment(getArgs)
import Text.Printf(printf)

-- | Convert two hex chars into an int
intOfHexChars :: Char -> Char -> Int
intOfHexChars c1 c2 = read $ printf "0x%c%c" c1 c2

-- | Get the mask value for the next two characters of the key
getMask :: [Char] -> Int -> Int
getMask key idx = intOfHexChars c1 c2
  where
    c1 = key !! mod idx (length key)
    c2 = key !! mod (idx + 1) (length key)

-- | Convert the ciphertext to int values representing the plaintext
decrypt :: [Char] -> [Char] -> Int -> [Int]
decrypt ciphertext key idx = case ciphertext of
  []       -> []
  _:[]     -> error "Invalid ciphertext"
  c1:c2:cs -> xor (intOfHexChars c1 c2) (getMask key idx) : decrypt cs key (idx + 2)

main :: IO ()
main = do
  plaintext <- getLine
  args <- getArgs
  putStr $ map chr $ decrypt plaintext (head args) 0
