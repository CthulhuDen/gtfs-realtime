{-# LANGUAGE BangPatterns, DeriveDataTypeable, DeriveGeneric, FlexibleInstances, MultiParamTypeClasses, OverloadedStrings #-}
{-# OPTIONS_GHC  -fno-warn-unused-imports #-}
module GTFS.RealTime.Protobuf.TimeRange (TimeRange(..)) where
import Prelude ((+), (/), (++), (.), (==), (<=), (&&))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified GHC.Generics as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'

data TimeRange = TimeRange{start :: !(P'.Maybe P'.Word64), end :: !(P'.Maybe P'.Word64), ext'field :: !(P'.ExtField)}
                 deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data, Prelude'.Generic)

instance P'.ExtendMessage TimeRange where
  getExtField = ext'field
  putExtField e'f msg = msg{ext'field = e'f}
  validExtRanges msg = P'.extRanges (P'.reflectDescriptorInfo msg)

instance P'.ToJSON TimeRange where
  toJSON msg
   = P'.objectNoEmpty
      ([("start", P'.toJSON (Prelude'.fmap P'.toJSONShowWithPayload (start msg))),
        ("end", P'.toJSON (Prelude'.fmap P'.toJSONShowWithPayload (end msg)))]
        ++ Prelude'.concat [])

instance P'.FromJSON TimeRange where
  parseJSON
   = P'.withObject "TimeRange"
      (\ o ->
        do
          start <- P'.explicitParseFieldMaybe (P'.parseJSONReadWithPayload "uint64") o "start"
          end <- P'.explicitParseFieldMaybe (P'.parseJSONReadWithPayload "uint64") o "end"
          Prelude'.return P'.defaultValue{start = start, end = end})

instance P'.Mergeable TimeRange where
  mergeAppend (TimeRange x'1 x'2 x'3) (TimeRange y'1 y'2 y'3)
   = TimeRange (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3)

instance P'.Default TimeRange where
  defaultValue = TimeRange P'.defaultValue P'.defaultValue P'.defaultValue

instance P'.Wire TimeRange where
  wireSize ft' self'@(TimeRange x'1 x'2 x'3)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeOpt 1 4 x'1 + P'.wireSizeOpt 1 4 x'2 + P'.wireSizeExtField x'3)
  wirePutWithSize ft' self'@(TimeRange x'1 x'2 x'3)
   = case ft' of
       10 -> put'Fields
       11 -> put'FieldsSized
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = P'.sequencePutWithSize [P'.wirePutOptWithSize 8 4 x'1, P'.wirePutOptWithSize 16 4 x'2, P'.wirePutExtFieldWithSize x'3]
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
             8 -> Prelude'.fmap (\ !new'Field -> old'Self{start = Prelude'.Just new'Field}) (P'.wireGet 4)
             16 -> Prelude'.fmap (\ !new'Field -> old'Self{end = Prelude'.Just new'Field}) (P'.wireGet 4)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in
                   if Prelude'.or [1000 <= field'Number && field'Number <= 1999] then
                    P'.loadExtension field'Number wire'Type old'Self else P'.unknown field'Number wire'Type old'Self

instance P'.MessageAPI msg' (msg' -> TimeRange) TimeRange where
  getVal m' f' = f' m'

instance P'.GPB TimeRange

instance P'.ReflectDescriptor TimeRange where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList []) (P'.fromDistinctAscList [8, 16])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".transit_realtime.TimeRange\", haskellPrefix = [], parentModule = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\"], baseName = MName \"TimeRange\"}, descFilePath = [\"GTFS\",\"RealTime\",\"Protobuf\",\"TimeRange.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.TimeRange.start\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"TimeRange\"], baseName' = FName \"start\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 8}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 4}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.TimeRange.end\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"TimeRange\"], baseName' = FName \"end\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 16}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 4}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], descOneofs = fromList [], keys = fromList [], extRanges = [(FieldId {getFieldId = 1000},FieldId {getFieldId = 1999})], knownKeys = fromList [], storeUnknown = False, lazyFields = False, makeLenses = False, jsonInstances = True}"

instance P'.TextType TimeRange where
  tellT = P'.tellSubMessage
  getT = P'.getSubMessage

instance P'.TextMsg TimeRange where
  textPut msg
   = do
       P'.tellT "start" (start msg)
       P'.tellT "end" (end msg)
  textGet
   = do
       mods <- P'.sepEndBy (P'.choice [parse'start, parse'end]) P'.spaces
       Prelude'.return (Prelude'.foldl (\ v f -> f v) P'.defaultValue mods)
    where
        parse'start
         = P'.try
            (do
               v <- P'.getT "start"
               Prelude'.return (\ o -> o{start = v}))
        parse'end
         = P'.try
            (do
               v <- P'.getT "end"
               Prelude'.return (\ o -> o{end = v}))