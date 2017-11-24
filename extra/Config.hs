{-# LANGUAGE CPP #-}
module Config where

import GhcPrelude

#include "ghc_boot_platform.h"

data IntegerLibrary = IntegerGMP
                    | IntegerSimple
                    deriving Eq

cBuildPlatformString :: String
cBuildPlatformString = BuildPlatform_NAME
cHostPlatformString :: String
cHostPlatformString = HostPlatform_NAME
cTargetPlatformString :: String
cTargetPlatformString = TargetPlatform_NAME

cProjectName          :: String
cProjectName          = "The Glorious Glasgow Haskell Compilation System"
cProjectGitCommitId   :: String
cProjectGitCommitId   = "95dfdceb8b4dcc54a366949577d9ee389bad5bc3"
cProjectVersion       :: String
cProjectVersion       = "8.1.20160524"
cProjectVersionInt    :: String
cProjectVersionInt    = "801"
cProjectPatchLevel    :: String
cProjectPatchLevel    = "20160524"
cProjectPatchLevel1   :: String
cProjectPatchLevel1   = "20160524"
cProjectPatchLevel2   :: String
cProjectPatchLevel2   = ""
cBooterVersion        :: String
cBooterVersion        = "7.10.2"
cStage                :: String
cStage                = show (STAGE :: Int)
cIntegerLibrary       :: String
cIntegerLibrary       = "integer-gmp"
cIntegerLibraryType   :: IntegerLibrary
cIntegerLibraryType   = IntegerGMP
cSupportsSplitObjs    :: String
cSupportsSplitObjs    = "YES"
cGhcWithInterpreter   :: String
cGhcWithInterpreter   = "YES"
cGhcWithNativeCodeGen :: String
cGhcWithNativeCodeGen = "YES"
cGhcWithSMP           :: String
cGhcWithSMP           = "YES"
cGhcRTSWays           :: String
cGhcRTSWays           = "l debug thr thr_debug thr_l"
cGhcEnableTablesNextToCode :: String
cGhcEnableTablesNextToCode = "YES"
cLeadingUnderscore    :: String
cLeadingUnderscore    = "YES"
cGHC_UNLIT_PGM        :: String
cGHC_UNLIT_PGM        = "unlit.exe"
cGHC_SPLIT_PGM        :: String
cGHC_SPLIT_PGM        = "ghc-split"
cLibFFI               :: Bool
cLibFFI               = False
cGhcThreaded :: Bool
cGhcThreaded = True
cGhcDebugged :: Bool
cGhcDebugged = False
cGhcRtsWithLibdw :: Bool
cGhcRtsWithLibdw = False
