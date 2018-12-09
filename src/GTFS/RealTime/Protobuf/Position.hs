{-# LANGUAGE BangPatterns, DeriveDataTypeable, DeriveGeneric, FlexibleInstances, MultiParamTypeClasses, OverloadedStrings #-}
{-# OPTIONS_GHC  -fno-warn-unused-imports #-}
module GTFS.RealTime.Protobuf.Position (Position(..)) where
import Prelude ((+), (/), (++), (.), (==), (<=), (&&))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified GHC.Generics as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'

data Position = Position{latitude :: !(P'.Float), longitude :: !(P'.Float), bearing :: !(P'.Maybe P'.Float),
                         odometer :: !(P'.Maybe P'.Double), speed :: !(P'.Maybe P'.Float), ext'field :: !(P'.ExtField)}
                deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data, Prelude'.Generic)

instance P'.ExtendMessage Position where
  getExtField = ext'field
  putExtField e'f msg = msg{ext'field = e'f}
  validExtRanges msg = P'.extRanges (P'.reflectDescriptorInfo msg)

instance P'.ToJSON Position where
  toJSON msg
   = P'.objectNoEmpty
      ([("latitude", P'.toJSON (latitude msg)), ("longitude", P'.toJSON (longitude msg)),
        ("bearing", P'.toJSON (Prelude'.fmap P'.toJSON (bearing msg))),
        ("odometer", P'.toJSON (Prelude'.fmap P'.toJSON (odometer msg))),
        ("speed", P'.toJSON (Prelude'.fmap P'.toJSON (speed msg)))]
        ++ Prelude'.concat [])

instance P'.FromJSON Position where
  parseJSON
   = P'.withObject "Position"
      (\ o ->
        do
          latitude <- P'.explicitParseField P'.parseJSON o "latitude"
          longitude <- P'.explicitParseField P'.parseJSON o "longitude"
          bearing <- P'.explicitParseFieldMaybe P'.parseJSON o "bearing"
          odometer <- P'.explicitParseFieldMaybe P'.parseJSON o "odometer"
          speed <- P'.explicitParseFieldMaybe P'.parseJSON o "speed"
          Prelude'.return
           P'.defaultValue{latitude = latitude, longitude = longitude, bearing = bearing, odometer = odometer, speed = speed})

instance P'.Mergeable Position where
  mergeAppend (Position x'1 x'2 x'3 x'4 x'5 x'6) (Position y'1 y'2 y'3 y'4 y'5 y'6)
   = Position (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)
      (P'.mergeAppend x'5 y'5)
      (P'.mergeAppend x'6 y'6)

instance P'.Default Position where
  defaultValue = Position P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue

instance P'.Wire Position where
  wireSize ft' self'@(Position x'1 x'2 x'3 x'4 x'5 x'6)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size
         = (P'.wireSizeReq 1 2 x'1 + P'.wireSizeReq 1 2 x'2 + P'.wireSizeOpt 1 2 x'3 + P'.wireSizeOpt 1 1 x'4 +
             P'.wireSizeOpt 1 2 x'5
             + P'.wireSizeExtField x'6)
  wirePutWithSize ft' self'@(Position x'1 x'2 x'3 x'4 x'5 x'6)
   = case ft' of
       10 -> put'Fields
       11 -> put'FieldsSized
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = P'.sequencePutWithSize
            [P'.wirePutReqWithSize 13 2 x'1, P'.wirePutReqWithSize 21 2 x'2, P'.wirePutOptWithSize 29 2 x'3,
             P'.wirePutOptWithSize 33 1 x'4, P'.wirePutOptWithSize 45 2 x'5, P'.wirePutExtFieldWithSize x'6]
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
             13 -> Prelude'.fmap (\ !new'Field -> old'Self{latitude = new'Field}) (P'.wireGet 2)
             21 -> Prelude'.fmap (\ !new'Field -> old'Self{longitude = new'Field}) (P'.wireGet 2)
             29 -> Prelude'.fmap (\ !new'Field -> old'Self{bearing = Prelude'.Just new'Field}) (P'.wireGet 2)
             33 -> Prelude'.fmap (\ !new'Field -> old'Self{odometer = Prelude'.Just new'Field}) (P'.wireGet 1)
             45 -> Prelude'.fmap (\ !new'Field -> old'Self{speed = Prelude'.Just new'Field}) (P'.wireGet 2)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in
                   if Prelude'.or [1000 <= field'Number && field'Number <= 1999] then
                    P'.loadExtension field'Number wire'Type old'Self else P'.unknown field'Number wire'Type old'Self

instance P'.MessageAPI msg' (msg' -> Position) Position where
  getVal m' f' = f' m'

instance P'.GPB Position

instance P'.ReflectDescriptor Position where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [13, 21]) (P'.fromDistinctAscList [13, 21, 29, 33, 45])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".transit_realtime.Position\", haskellPrefix = [], parentModule = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\"], baseName = MName \"Position\"}, descFilePath = [\"GTFS\",\"RealTime\",\"Protobuf\",\"Position.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.Position.latitude\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"Position\"], baseName' = FName \"latitude\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 13}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 2}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.Position.longitude\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"Position\"], baseName' = FName \"longitude\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 21}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 2}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.Position.bearing\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"Position\"], baseName' = FName \"bearing\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 29}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 2}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.Position.odometer\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"Position\"], baseName' = FName \"odometer\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 4}, wireTag = WireTag {getWireTag = 33}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 1}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.Position.speed\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"Position\"], baseName' = FName \"speed\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 5}, wireTag = WireTag {getWireTag = 45}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 2}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], descOneofs = fromList [], keys = fromList [], extRanges = [(FieldId {getFieldId = 1000},FieldId {getFieldId = 1999})], knownKeys = fromList [], storeUnknown = False, lazyFields = False, makeLenses = False, jsonInstances = True}"

instance P'.TextType Position where
  tellT = P'.tellSubMessage
  getT = P'.getSubMessage

instance P'.TextMsg Position where
  textPut msg
   = do
       P'.tellT "latitude" (latitude msg)
       P'.tellT "longitude" (longitude msg)
       P'.tellT "bearing" (bearing msg)
       P'.tellT "odometer" (odometer msg)
       P'.tellT "speed" (speed msg)
  textGet
   = do
       mods <- P'.sepEndBy (P'.choice [parse'latitude, parse'longitude, parse'bearing, parse'odometer, parse'speed]) P'.spaces
       Prelude'.return (Prelude'.foldl (\ v f -> f v) P'.defaultValue mods)
    where
        parse'latitude
         = P'.try
            (do
               v <- P'.getT "latitude"
               Prelude'.return (\ o -> o{latitude = v}))
        parse'longitude
         = P'.try
            (do
               v <- P'.getT "longitude"
               Prelude'.return (\ o -> o{longitude = v}))
        parse'bearing
         = P'.try
            (do
               v <- P'.getT "bearing"
               Prelude'.return (\ o -> o{bearing = v}))
        parse'odometer
         = P'.try
            (do
               v <- P'.getT "odometer"
               Prelude'.return (\ o -> o{odometer = v}))
        parse'speed
         = P'.try
            (do
               v <- P'.getT "speed"
               Prelude'.return (\ o -> o{speed = v}))