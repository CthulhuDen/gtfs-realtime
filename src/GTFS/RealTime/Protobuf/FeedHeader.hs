{-# LANGUAGE BangPatterns, DeriveDataTypeable, DeriveGeneric, FlexibleInstances, MultiParamTypeClasses #-}
{-# OPTIONS_GHC  -fno-warn-unused-imports #-}
module GTFS.RealTime.Protobuf.FeedHeader (FeedHeader(..)) where
import Prelude ((+), (/), (==), (<=), (&&))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified GHC.Generics as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified GTFS.RealTime.Protobuf.FeedHeader.Incrementality as GTFS.RealTime.Protobuf.FeedHeader (Incrementality)

data FeedHeader = FeedHeader{gtfs_realtime_version :: !(P'.Utf8),
                             incrementality :: !(P'.Maybe GTFS.RealTime.Protobuf.FeedHeader.Incrementality),
                             timestamp :: !(P'.Maybe P'.Word64), ext'field :: !(P'.ExtField)}
                  deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data, Prelude'.Generic)

instance P'.ExtendMessage FeedHeader where
  getExtField = ext'field
  putExtField e'f msg = msg{ext'field = e'f}
  validExtRanges msg = P'.extRanges (P'.reflectDescriptorInfo msg)

instance P'.Mergeable FeedHeader where
  mergeAppend (FeedHeader x'1 x'2 x'3 x'4) (FeedHeader y'1 y'2 y'3 y'4)
   = FeedHeader (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)

instance P'.Default FeedHeader where
  defaultValue = FeedHeader P'.defaultValue (Prelude'.Just (Prelude'.read "FULL_DATASET")) P'.defaultValue P'.defaultValue

instance P'.Wire FeedHeader where
  wireSize ft' self'@(FeedHeader x'1 x'2 x'3 x'4)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 9 x'1 + P'.wireSizeOpt 1 14 x'2 + P'.wireSizeOpt 1 4 x'3 + P'.wireSizeExtField x'4)
  wirePutWithSize ft' self'@(FeedHeader x'1 x'2 x'3 x'4)
   = case ft' of
       10 -> put'Fields
       11 -> put'FieldsSized
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = P'.sequencePutWithSize
            [P'.wirePutReqWithSize 10 9 x'1, P'.wirePutOptWithSize 16 14 x'2, P'.wirePutOptWithSize 24 4 x'3,
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
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{gtfs_realtime_version = new'Field}) (P'.wireGet 9)
             16 -> Prelude'.fmap (\ !new'Field -> old'Self{incrementality = Prelude'.Just new'Field}) (P'.wireGet 14)
             24 -> Prelude'.fmap (\ !new'Field -> old'Self{timestamp = Prelude'.Just new'Field}) (P'.wireGet 4)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in
                   if Prelude'.or [1000 <= field'Number && field'Number <= 1999] then
                    P'.loadExtension field'Number wire'Type old'Self else P'.unknown field'Number wire'Type old'Self

instance P'.MessageAPI msg' (msg' -> FeedHeader) FeedHeader where
  getVal m' f' = f' m'

instance P'.GPB FeedHeader

instance P'.ReflectDescriptor FeedHeader where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10]) (P'.fromDistinctAscList [10, 16, 24])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".transit_realtime.FeedHeader\", haskellPrefix = [], parentModule = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\"], baseName = MName \"FeedHeader\"}, descFilePath = [\"GTFS\",\"RealTime\",\"Protobuf\",\"FeedHeader.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.FeedHeader.gtfs_realtime_version\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"FeedHeader\"], baseName' = FName \"gtfs_realtime_version\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 9}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.FeedHeader.incrementality\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"FeedHeader\"], baseName' = FName \"incrementality\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 16}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 14}, typeName = Just (ProtoName {protobufName = FIName \".transit_realtime.FeedHeader.Incrementality\", haskellPrefix = [], parentModule = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"FeedHeader\"], baseName = MName \"Incrementality\"}), hsRawDefault = Just \"FULL_DATASET\", hsDefault = Just (HsDef'Enum \"FULL_DATASET\")},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.FeedHeader.timestamp\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"FeedHeader\"], baseName' = FName \"timestamp\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 24}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 4}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], descOneofs = fromList [], keys = fromList [], extRanges = [(FieldId {getFieldId = 1000},FieldId {getFieldId = 1999})], knownKeys = fromList [], storeUnknown = False, lazyFields = False, makeLenses = False}"

instance P'.TextType FeedHeader where
  tellT = P'.tellSubMessage
  getT = P'.getSubMessage

instance P'.TextMsg FeedHeader where
  textPut msg
   = do
       P'.tellT "gtfs_realtime_version" (gtfs_realtime_version msg)
       P'.tellT "incrementality" (incrementality msg)
       P'.tellT "timestamp" (timestamp msg)
  textGet
   = do
       mods <- P'.sepEndBy (P'.choice [parse'gtfs_realtime_version, parse'incrementality, parse'timestamp]) P'.spaces
       Prelude'.return (Prelude'.foldl (\ v f -> f v) P'.defaultValue mods)
    where
        parse'gtfs_realtime_version
         = P'.try
            (do
               v <- P'.getT "gtfs_realtime_version"
               Prelude'.return (\ o -> o{gtfs_realtime_version = v}))
        parse'incrementality
         = P'.try
            (do
               v <- P'.getT "incrementality"
               Prelude'.return (\ o -> o{incrementality = v}))
        parse'timestamp
         = P'.try
            (do
               v <- P'.getT "timestamp"
               Prelude'.return (\ o -> o{timestamp = v}))