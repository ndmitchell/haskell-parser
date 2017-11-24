{-# LANGUAGE OverloadedStrings #-}

import Control.Monad.Extra
import Data.List
import System.Directory.Extra
import System.FilePath
import System.IO
import System.Process.Extra
import qualified Data.ByteString.Char8 as BS
import System.Time.Extra


phase name act = do
    putStr $ name ++ " ... "
    (t, _) <- duration act
    putStrLn $ "took " ++ showDuration t

main = do
    hSetBuffering stdout NoBuffering
    phase "Cloning" $
        unlessM (doesDirectoryExist "ghc") $
            system_ "git clone --depth=1 https://github.com/ghc/ghc.git"

    phase "Copying source" $ do
        files <- concatMapM listFilesRecursive ["ghc/compiler","ghc/includes","ghc/libraries/ghc-boot","ghc/libraries/ghc-boot-th"]
        forM_ files $ \file -> do
            let out = "out" </> file
            createDirectoryIfMissing True $ takeDirectory out
            let noImplicitPrelude = "compiler" `elem` splitDirectories file && takeExtension file == ".hs"
            src <- (if not noImplicitPrelude then id
                    else BS.append "{-# LANGUAGE NoImplicitPrelude #-}\n") <$>
                 BS.readFile file
            b <- doesFileExist out
            if not b then BS.writeFile out src else do
                dest <- BS.readFile out
                when (dest /= src) $
                    -- avoid needless dirtying of the timestamp
                    BS.writeFile out src

    phase "Copying extra" $ do
        files <- listFiles "extra"
        forM_ files $ \file ->
            copyFile file $ "out/ghc/compiler" </> takeFileName file

    phase "Preprocessing" $ do
        withCurrentDirectory "out/ghc/compiler/parser" $ do
            system_ "happy -agc --strict Parser.y"
            system_ "alex Lexer.x"
        withCurrentDirectory "out/ghc/compiler/utils" $ do
            system_ "hsc2hs Fingerprint.hsc"
    
    phase "Compiling" $
        withCurrentDirectory "out/ghc/compiler" $ do
            dirs <- filterM doesDirectoryExist =<< listContents ""
            let flags = "-DSTAGE=0 -i../libraries/ghc-boot;../libraries/ghc-boot-th;" ++ intercalate ";" dirs ++ " -I."
            system_ $ "ghc Parser " ++ flags
            writeFile ".ghci" $ ":set -fobject-code " ++ flags ++ "\n:load Parser"
