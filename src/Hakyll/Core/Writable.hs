-- | Describes writable items; items that can be saved to the disk
--
{-# LANGUAGE FlexibleInstances, TypeSynonymInstances #-}
module Hakyll.Core.Writable
    ( Writable (..)
    ) where

import Data.Word (Word8)

import qualified Data.ByteString as SB
import Text.Blaze (Html)
import Text.Blaze.Renderer.String (renderHtml)

-- | Describes an item that can be saved to the disk
--
class Writable a where
    -- | Save an item to the given filepath
    write :: FilePath -> a -> IO ()

instance Writable [Char] where
    write = writeFile

instance Writable SB.ByteString where
    write p = SB.writeFile p

instance Writable [Word8] where
    write p = write p . SB.pack

instance Writable Html where
    write p html = write p $ renderHtml html
