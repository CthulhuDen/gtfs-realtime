{-# LANGUAGE BangPatterns, DeriveDataTypeable, DeriveGeneric, FlexibleInstances, MultiParamTypeClasses #-}
{-# OPTIONS_GHC  -fno-warn-unused-imports #-}
module GTFS.RealTime.Protobuf.TripUpdate (TripUpdate(..)) where
import Prelude ((+), (/), (==), (<=), (&&))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified GHC.Generics as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified GTFS.RealTime.Protobuf.TripDescriptor as GTFS.RealTime.Protobuf (TripDescriptor)
import qualified GTFS.RealTime.Protobuf.TripUpdate.StopTimeUpdate as GTFS.RealTime.Protobuf.TripUpdate (StopTimeUpdate)
import qualified GTFS.RealTime.Protobuf.VehicleDescriptor as GTFS.RealTime.Protobuf (VehicleDescriptor)

data TripUpdate = TripUpdate{trip :: !(GTFS.RealTime.Protobuf.TripDescriptor),
                             vehicle :: !(P'.Maybe GTFS.RealTime.Protobuf.VehicleDescriptor),
                             stop_time_update :: !(P'.Seq GTFS.RealTime.Protobuf.TripUpdate.StopTimeUpdate),
                             timestamp :: !(P'.Maybe P'.Word64), delay :: !(P'.Maybe P'.Int32), ext'field :: !(P'.ExtField)}
                  deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data, Prelude'.Generic)

instance P'.ExtendMessage TripUpdate where
  getExtField = ext'field
  putExtField e'f msg = msg{ext'field = e'f}
  validExtRanges msg = P'.extRanges (P'.reflectDescriptorInfo msg)

instance P'.Mergeable TripUpdate where
  mergeAppend (TripUpdate x'1 x'2 x'3 x'4 x'5 x'6) (TripUpdate y'1 y'2 y'3 y'4 y'5 y'6)
   = TripUpdate (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)
      (P'.mergeAppend x'5 y'5)
      (P'.mergeAppend x'6 y'6)

instance P'.Default TripUpdate where
  defaultValue = TripUpdate P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue

instance P'.Wire TripUpdate where
  wireSize ft' self'@(TripUpdate x'1 x'2 x'3 x'4 x'5 x'6)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size
         = (P'.wireSizeReq 1 11 x'1 + P'.wireSizeOpt 1 11 x'2 + P'.wireSizeRep 1 11 x'3 + P'.wireSizeOpt 1 4 x'4 +
             P'.wireSizeOpt 1 5 x'5
             + P'.wireSizeExtField x'6)
  wirePutWithSize ft' self'@(TripUpdate x'1 x'2 x'3 x'4 x'5 x'6)
   = case ft' of
       10 -> put'Fields
       11 -> put'FieldsSized
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = P'.sequencePutWithSize
            [P'.wirePutReqWithSize 10 11 x'1, P'.wirePutRepWithSize 18 11 x'3, P'.wirePutOptWithSize 26 11 x'2,
             P'.wirePutOptWithSize 32 4 x'4, P'.wirePutOptWithSize 40 5 x'5, P'.wirePutExtFieldWithSize x'6]
        put'FieldsSized
         = let size' = Prelude'.fst (P'.runPutM put'Fields)
               put'Size
                = do
                    P'.putSize size'
                    Prelude'.return (P'.size'WireSize size')
            in P'.sequencePutWithSize [put'Size, put'Fields]
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{trip = P'.mergeAppend (trip old'Self) (new'Field)}) (P'.wireGet 11)
             26 -> Prelude'.fmap (\ !new'Field -> old'Self{vehicle = P'.mergeAppend (vehicle old'Self) (Prelude'.Just new'Field)})
                    (P'.wireGet 11)
             18 -> Prelude'.fmap (\ !new'Field -> old'Self{stop_time_update = P'.append (stop_time_update old'Self) new'Field})
                    (P'.wireGet 11)
             32 -> Prelude'.fmap (\ !new'Field -> old'Self{timestamp = Prelude'.Just new'Field}) (P'.wireGet 4)
             40 -> Prelude'.fmap (\ !new'Field -> old'Self{delay = Prelude'.Just new'Field}) (P'.wireGet 5)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in
                   if Prelude'.or [1000 <= field'Number && field'Number <= 1999] then
                    P'.loadExtension field'Number wire'Type old'Self else P'.unknown field'Number wire'Type old'Self

instance P'.MessageAPI msg' (msg' -> TripUpdate) TripUpdate where
  getVal m' f' = f' m'

instance P'.GPB TripUpdate

instance P'.ReflectDescriptor TripUpdate where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10]) (P'.fromDistinctAscList [10, 18, 26, 32, 40])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".transit_realtime.TripUpdate\", haskellPrefix = [], parentModule = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\"], baseName = MName \"TripUpdate\"}, descFilePath = [\"GTFS\",\"RealTime\",\"Protobuf\",\"TripUpdate.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.TripUpdate.trip\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"TripUpdate\"], baseName' = FName \"trip\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".transit_realtime.TripDescriptor\", haskellPrefix = [], parentModule = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\"], baseName = MName \"TripDescriptor\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.TripUpdate.vehicle\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"TripUpdate\"], baseName' = FName \"vehicle\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 26}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".transit_realtime.VehicleDescriptor\", haskellPrefix = [], parentModule = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\"], baseName = MName \"VehicleDescriptor\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.TripUpdate.stop_time_update\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"TripUpdate\"], baseName' = FName \"stop_time_update\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 18}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = True, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".transit_realtime.TripUpdate.StopTimeUpdate\", haskellPrefix = [], parentModule = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"TripUpdate\"], baseName = MName \"StopTimeUpdate\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.TripUpdate.timestamp\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"TripUpdate\"], baseName' = FName \"timestamp\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 4}, wireTag = WireTag {getWireTag = 32}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 4}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.TripUpdate.delay\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"TripUpdate\"], baseName' = FName \"delay\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 5}, wireTag = WireTag {getWireTag = 40}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], descOneofs = fromList [], keys = fromList [], extRanges = [(FieldId {getFieldId = 1000},FieldId {getFieldId = 1999})], knownKeys = fromList [], storeUnknown = False, lazyFields = False, makeLenses = False}"

instance P'.TextType TripUpdate where
  tellT = P'.tellSubMessage
  getT = P'.getSubMessage

instance P'.TextMsg TripUpdate where
  textPut msg
   = do
       P'.tellT "trip" (trip msg)
       P'.tellT "vehicle" (vehicle msg)
       P'.tellT "stop_time_update" (stop_time_update msg)
       P'.tellT "timestamp" (timestamp msg)
       P'.tellT "delay" (delay msg)
  textGet
   = do
       mods <- P'.sepEndBy (P'.choice [parse'trip, parse'vehicle, parse'stop_time_update, parse'timestamp, parse'delay]) P'.spaces
       Prelude'.return (Prelude'.foldl (\ v f -> f v) P'.defaultValue mods)
    where
        parse'trip
         = P'.try
            (do
               v <- P'.getT "trip"
               Prelude'.return (\ o -> o{trip = v}))
        parse'vehicle
         = P'.try
            (do
               v <- P'.getT "vehicle"
               Prelude'.return (\ o -> o{vehicle = v}))
        parse'stop_time_update
         = P'.try
            (do
               v <- P'.getT "stop_time_update"
               Prelude'.return (\ o -> o{stop_time_update = P'.append (stop_time_update o) v}))
        parse'timestamp
         = P'.try
            (do
               v <- P'.getT "timestamp"
               Prelude'.return (\ o -> o{timestamp = v}))
        parse'delay
         = P'.try
            (do
               v <- P'.getT "delay"
               Prelude'.return (\ o -> o{delay = v}))