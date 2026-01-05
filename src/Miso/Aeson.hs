-----------------------------------------------------------------------------
{-# LANGUAGE CPP               #-}
{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE OverloadedStrings #-}
-----------------------------------------------------------------------------
module Miso.Aeson (aesonToJSON, jsonToAeson) where
-----------------------------------------------------------------------------
import           Miso.String (toMisoString, fromMisoString)
import qualified Miso.JSON as JSON
-----------------------------------------------------------------------------
import qualified Data.Aeson as Aeson
import qualified Data.Vector as V
import           Data.Scientific
import qualified Data.Aeson.KeyMap as KM
import           Data.Aeson.Key (toText, fromText)
import qualified Data.Map.Strict as M
-----------------------------------------------------------------------------
aesonToJSON :: Aeson.Value -> JSON.Value
aesonToJSON = \case
  Aeson.Null ->
    JSON.Null
  Aeson.Bool b ->
    JSON.Bool b
  Aeson.Number n ->
    JSON.Number (toRealFloat n)
  Aeson.String n ->
    JSON.String (toMisoString n)
  Aeson.Array arr ->
    JSON.Array [ aesonToJSON v | v <- V.toList arr ]
  Aeson.Object o ->
    JSON.Object $
      M.fromList [ (toMisoString (toText k), aesonToJSON v)
                 | (k,v) <- KM.toList o
                 ]
-----------------------------------------------------------------------------
jsonToAeson :: JSON.Value -> Aeson.Value
jsonToAeson = \case
  JSON.Null ->
    Aeson.Null
  JSON.Bool b ->
    Aeson.Bool b
  JSON.Number n ->
    Aeson.Number (fromFloatDigits n)
  JSON.String n ->
    Aeson.String (fromMisoString n)
  JSON.Array arr ->
    Aeson.Array $ V.fromList (jsonToAeson <$> arr)
  JSON.Object o ->
    Aeson.Object $
      KM.fromList [ (fromText (fromMisoString k), jsonToAeson v)
                  | (k,v) <- M.toList o
                  ]
-----------------------------------------------------------------------------
