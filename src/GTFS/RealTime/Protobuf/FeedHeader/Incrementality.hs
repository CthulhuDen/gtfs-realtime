{-# LANGUAGE BangPatterns, DeriveDataTypeable, DeriveGeneric, FlexibleInstances, MultiParamTypeClasses, OverloadedStrings #-}
{-# OPTIONS_GHC  -fno-warn-unused-imports #-}
module GTFS.RealTime.Protobuf.FeedHeader.Incrementality (Incrementality(..)) where
import Prelude ((+), (/), (.))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified GHC.Generics as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'

data Incrementality = FULL_DATASET
                    | DIFFERENTIAL
                      deriving (Prelude'.Read, Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data,
                                Prelude'.Generic)

instance P'.Mergeable Incrementality

instance Prelude'.Bounded Incrementality where
  minBound = FULL_DATASET
  maxBound = DIFFERENTIAL

instance P'.Default Incrementality where
  defaultValue = FULL_DATASET

toMaybe'Enum :: Prelude'.Int -> P'.Maybe Incrementality
toMaybe'Enum 0 = Prelude'.Just FULL_DATASET
toMaybe'Enum 1 = Prelude'.Just DIFFERENTIAL
toMaybe'Enum _ = Prelude'.Nothing

instance Prelude'.Enum Incrementality where
  fromEnum FULL_DATASET = 0
  fromEnum DIFFERENTIAL = 1
  toEnum
   = P'.fromMaybe
      (Prelude'.error "hprotoc generated code: toEnum failure for type GTFS.RealTime.Protobuf.FeedHeader.Incrementality")
      . toMaybe'Enum
  succ FULL_DATASET = DIFFERENTIAL
  succ _ = Prelude'.error "hprotoc generated code: succ failure for type GTFS.RealTime.Protobuf.FeedHeader.Incrementality"
  pred DIFFERENTIAL = FULL_DATASET
  pred _ = Prelude'.error "hprotoc generated code: pred failure for type GTFS.RealTime.Protobuf.FeedHeader.Incrementality"

instance P'.Wire Incrementality where
  wireSize ft' enum = P'.wireSize ft' (Prelude'.fromEnum enum)
  wirePut ft' enum = P'.wirePut ft' (Prelude'.fromEnum enum)
  wireGet 14 = P'.wireGetEnum toMaybe'Enum
  wireGet ft' = P'.wireGetErr ft'
  wireGetPacked 14 = P'.wireGetPackedEnum toMaybe'Enum
  wireGetPacked ft' = P'.wireGetErr ft'

instance P'.GPB Incrementality

instance P'.MessageAPI msg' (msg' -> Incrementality) Incrementality where
  getVal m' f' = f' m'

instance P'.ReflectEnum Incrementality where
  reflectEnum = [(0, "FULL_DATASET", FULL_DATASET), (1, "DIFFERENTIAL", DIFFERENTIAL)]
  reflectEnumInfo _
   = P'.EnumInfo
      (P'.makePNF (P'.pack ".transit_realtime.FeedHeader.Incrementality") [] ["GTFS", "RealTime", "Protobuf", "FeedHeader"]
        "Incrementality")
      ["GTFS", "RealTime", "Protobuf", "FeedHeader", "Incrementality.hs"]
      [(0, "FULL_DATASET"), (1, "DIFFERENTIAL")]
      Prelude'.True

instance P'.TextType Incrementality where
  tellT = P'.tellShow
  getT = P'.getRead

instance P'.ToJSON Incrementality where
  toJSON msg'
   = P'.String
      (case msg' of
         FULL_DATASET -> "FULL_DATASET"
         DIFFERENTIAL -> "DIFFERENTIAL")

instance P'.FromJSON Incrementality where
  parseJSON
   = P'.withText "GTFS.RealTime.Protobuf.FeedHeader.Incrementality.Incrementality"
      (\ msg' ->
        case msg' of
          "FULL_DATASET" -> Prelude'.return FULL_DATASET
          "DIFFERENTIAL" -> Prelude'.return DIFFERENTIAL
          _ -> Prelude'.fail
                ("Invalid value " Prelude'.++ Prelude'.show msg' Prelude'.++
                  " for enum GTFS.RealTime.Protobuf.FeedHeader.Incrementality.Incrementality"))