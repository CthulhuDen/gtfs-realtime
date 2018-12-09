{-# LANGUAGE BangPatterns, DeriveDataTypeable, DeriveGeneric, FlexibleInstances, MultiParamTypeClasses, OverloadedStrings #-}
{-# OPTIONS_GHC  -fno-warn-unused-imports #-}
module GTFS.RealTime.Protobuf.TripUpdate.StopTimeEvent (StopTimeEvent(..)) where
import Prelude ((+), (/), (++), (.), (==), (<=), (&&))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified GHC.Generics as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'

data StopTimeEvent = StopTimeEvent{delay :: !(P'.Maybe P'.Int32), time :: !(P'.Maybe P'.Int64), uncertainty :: !(P'.Maybe P'.Int32),
                                   ext'field :: !(P'.ExtField)}
                     deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data, Prelude'.Generic)

instance P'.ExtendMessage StopTimeEvent where
  getExtField = ext'field
  putExtField e'f msg = msg{ext'field = e'f}
  validExtRanges msg = P'.extRanges (P'.reflectDescriptorInfo msg)

instance P'.ToJSON StopTimeEvent where
  toJSON msg
   = P'.objectNoEmpty
      ([("delay", P'.toJSON (Prelude'.fmap P'.toJSON (delay msg))),
        ("time", P'.toJSON (Prelude'.fmap P'.toJSONShowWithPayload (time msg))),
        ("uncertainty", P'.toJSON (Prelude'.fmap P'.toJSON (uncertainty msg)))]
        ++ Prelude'.concat [])

instance P'.FromJSON StopTimeEvent where
  parseJSON
   = P'.withObject "StopTimeEvent"
      (\ o ->
        do
          delay <- P'.explicitParseFieldMaybe P'.parseJSON o "delay"
          time <- P'.explicitParseFieldMaybe (P'.parseJSONReadWithPayload "int64") o "time"
          uncertainty <- P'.explicitParseFieldMaybe P'.parseJSON o "uncertainty"
          Prelude'.return P'.defaultValue{delay = delay, time = time, uncertainty = uncertainty})

instance P'.Mergeable StopTimeEvent where
  mergeAppend (StopTimeEvent x'1 x'2 x'3 x'4) (StopTimeEvent y'1 y'2 y'3 y'4)
   = StopTimeEvent (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)

instance P'.Default StopTimeEvent where
  defaultValue = StopTimeEvent P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue

instance P'.Wire StopTimeEvent where
  wireSize ft' self'@(StopTimeEvent x'1 x'2 x'3 x'4)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeOpt 1 5 x'1 + P'.wireSizeOpt 1 3 x'2 + P'.wireSizeOpt 1 5 x'3 + P'.wireSizeExtField x'4)
  wirePutWithSize ft' self'@(StopTimeEvent x'1 x'2 x'3 x'4)
   = case ft' of
       10 -> put'Fields
       11 -> put'FieldsSized
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = P'.sequencePutWithSize
            [P'.wirePutOptWithSize 8 5 x'1, P'.wirePutOptWithSize 16 3 x'2, P'.wirePutOptWithSize 24 5 x'3,
             P'.wirePutExtFieldWithSize x'4]
        put'FieldsSized
         = let size' = Prelude'.fst (P'.runPutM put'Fields)
               put'Size
                = do
                    P'.putSize size'
                    Prelude'.return (P'.size'WireSize size')
            in P'.sequencePutWithSize [put'Size, put'Fields]
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith (P'.catch'Unknown' P'.discardUnknown update'Self)
       11 -> P'.getMessageWith (P'.catch'Unknown' P'.discardUnknown update'Self)
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             8 -> Prelude'.fmap (\ !new'Field -> old'Self{delay = Prelude'.Just new'Field}) (P'.wireGet 5)
             16 -> Prelude'.fmap (\ !new'Field -> old'Self{time = Prelude'.Just new'Field}) (P'.wireGet 3)
             24 -> Prelude'.fmap (\ !new'Field -> old'Self{uncertainty = Prelude'.Just new'Field}) (P'.wireGet 5)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in
                   if Prelude'.or [1000 <= field'Number && field'Number <= 1999] then
                    P'.loadExtension field'Number wire'Type old'Self else P'.unknown field'Number wire'Type old'Self

instance P'.MessageAPI msg' (msg' -> StopTimeEvent) StopTimeEvent where
  getVal m' f' = f' m'

instance P'.GPB StopTimeEvent

instance P'.ReflectDescriptor StopTimeEvent where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList []) (P'.fromDistinctAscList [8, 16, 24])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".transit_realtime.TripUpdate.StopTimeEvent\", haskellPrefix = [], parentModule = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"TripUpdate\"], baseName = MName \"StopTimeEvent\"}, descFilePath = [\"GTFS\",\"RealTime\",\"Protobuf\",\"TripUpdate\",\"StopTimeEvent.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.TripUpdate.StopTimeEvent.delay\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"TripUpdate\",MName \"StopTimeEvent\"], baseName' = FName \"delay\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 8}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.TripUpdate.StopTimeEvent.time\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"TripUpdate\",MName \"StopTimeEvent\"], baseName' = FName \"time\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 16}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 3}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.TripUpdate.StopTimeEvent.uncertainty\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"TripUpdate\",MName \"StopTimeEvent\"], baseName' = FName \"uncertainty\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 24}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], descOneofs = fromList [], keys = fromList [], extRanges = [(FieldId {getFieldId = 1000},FieldId {getFieldId = 1999})], knownKeys = fromList [], storeUnknown = False, lazyFields = False, makeLenses = False, jsonInstances = True}"

instance P'.TextType StopTimeEvent where
  tellT = P'.tellSubMessage
  getT = P'.getSubMessage

instance P'.TextMsg StopTimeEvent where
  textPut msg
   = do
       P'.tellT "delay" (delay msg)
       P'.tellT "time" (time msg)
       P'.tellT "uncertainty" (uncertainty msg)
  textGet
   = do
       mods <- P'.sepEndBy (P'.choice [parse'delay, parse'time, parse'uncertainty]) P'.spaces
       Prelude'.return (Prelude'.foldl (\ v f -> f v) P'.defaultValue mods)
    where
        parse'delay
         = P'.try
            (do
               v <- P'.getT "delay"
               Prelude'.return (\ o -> o{delay = v}))
        parse'time
         = P'.try
            (do
               v <- P'.getT "time"
               Prelude'.return (\ o -> o{time = v}))
        parse'uncertainty
         = P'.try
            (do
               v <- P'.getT "uncertainty"
               Prelude'.return (\ o -> o{uncertainty = v}))