module Paths_directory_lister (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/cgag/.cabal/bin"
libdir     = "/home/cgag/.cabal/lib/directory-lister-0.1.0.0/ghc-7.6.3"
datadir    = "/home/cgag/.cabal/share/directory-lister-0.1.0.0"
libexecdir = "/home/cgag/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catchIO (getEnv "directory_lister_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "directory_lister_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "directory_lister_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "directory_lister_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
