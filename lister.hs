import System.Directory (getDirectoryContents, doesFileExist)
import Control.Monad (filterM)
import Text.Printf (printf)
import Data.List (intercalate, sort)
import System.Environment (getArgs, getProgName)

getFiles :: FilePath -> IO [FilePath]
getFiles path = getDirectoryContents path >>= filterM doesFileExist

fileToLink :: FilePath -> String
fileToLink path = printf "<a href=\"%s\">%s</a>" path path

main = do
  progName <- getProgName
  args <- getArgs
  if length args /= 2 
    then putStrLn $ printf "Usage: %s <directory> <outfile>" progName
    else do
      let (dirpath:outfile:_) = args
      unsorted_files <- getFiles dirpath
      let files = sort unsorted_files
      let links = map fileToLink files
      writeFile outfile $ intercalate "<br />\n" links
