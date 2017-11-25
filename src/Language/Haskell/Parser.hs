
module Language.Haskell.Parser(parseMod) where

import Parser as X
import Language.Haskell.Syntax
import SrcLoc
import HsSyn
import HsExtension
import StringBuffer
import Lexer
import FastString
import Outputable
import Module
import EnumSet as ES

parseMod :: String -> ParseResult (Located (HsModule GhcPs))
parseMod s = unP parseModule $ mkPStatePure flags (stringToStringBuffer s) srcLoc

instance Show a => Show (ParseResult a) where
    show (POk a b) = show "POk " ++ show a ++ " " ++ show b
    show (PFailed _ a b) = show "PFailed " ++ show a ++ " " ++ show b

instance (Show l, Show e) => Show (GenLocated l e) where
    show _ = "L"

instance Show (HsModule a) where
    show _ = ""

instance Show SDoc where
    show _ = "SDoc"

instance Show PState where
    show _ = "SDoc"

flags :: ParserFlags
flags = ParserFlags ES.empty ES.empty mainUnitId 0

srcLoc :: RealSrcLoc
srcLoc = mkRealSrcLoc (mkFastString "") 0 0
