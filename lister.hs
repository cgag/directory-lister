import System.Directory (getDirectoryContents, doesFileExist)
import Control.Monad (filterM)
import Text.Printf (printf)
import Data.List (intercalate)
import System.Environment (getArgs, getProgName)

getFiles :: FilePath -> IO [FilePath]
getFiles path = getDirectoryContents path >>= filterM doesFileExist

fileToLink :: FilePath -> String
fileToLink path = printf "<a href=\"%s\">%s</a>" path path

main = do
  progName <- getProgName
  args <- getArgs
  if length args /= 1 
    then putStrLn $ printf "Usage: %s <directory>" progName
    else do
      let path = head args
      files <- getFiles path
      putStrLn $ intercalate "<br />\n" $ map fileToLink files
