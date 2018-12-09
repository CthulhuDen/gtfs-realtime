{-# LANGUAGE BangPatterns, DeriveDataTypeable, DeriveGeneric, FlexibleInstances, MultiParamTypeClasses, OverloadedStrings #-}
{-# OPTIONS_GHC  -fno-warn-unused-imports #-}
module GTFS.RealTime.Protobuf.FeedMessage (FeedMessage(..)) where
import Prelude ((+), (/), (++), (.), (==), (<=), (&&))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified GHC.Generics as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified GTFS.RealTime.Protobuf.FeedEntity as GTFS.RealTime.Protobuf (FeedEntity)
import qualified GTFS.RealTime.Protobuf.FeedHeader as GTFS.RealTime.Protobuf (FeedHeader)

data FeedMessage = FeedMessage{header :: !(GTFS.RealTime.Protobuf.FeedHeader),
                               entity :: !(P'.Seq GTFS.RealTime.Protobuf.FeedEntity), ext'field :: !(P'.ExtField)}
                   deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data, Prelude'.Generic)

instance P'.ExtendMessage FeedMessage where
  getExtField = ext'field
  putExtField e'f msg = msg{ext'field = e'f}
  validExtRanges msg = P'.extRanges (P'.reflectDescriptorInfo msg)

instance P'.ToJSON FeedMessage where
  toJSON msg
   = P'.objectNoEmpty
      ([("header", P'.toJSON (header msg)), ("entity", P'.toJSON (Prelude'.fmap P'.toJSON (entity msg)))] ++ Prelude'.concat [])

instance P'.FromJSON FeedMessage where
  parseJSON
   = P'.withObject "FeedMessage"
      (\ o ->
        do
          header <- P'.explicitParseField P'.parseJSON o "header"
          entity <- Prelude'.fmap (Prelude'.maybe Prelude'.mempty Prelude'.id)
                     (P'.explicitParseFieldMaybe (Prelude'.mapM P'.parseJSON P'.<=< P'.parseJSON) o "entity")
          Prelude'.return P'.defaultValue{header = header, entity = entity})

instance P'.Mergeable FeedMessage where
  mergeAppend (FeedMessage x'1 x'2 x'3) (FeedMessage y'1 y'2 y'3)
   = FeedMessage (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3)

instance P'.Default FeedMessage where
  defaultValue = FeedMessage P'.defaultValue P'.defaultValue P'.defaultValue

instance P'.Wire FeedMessage where
  wireSize ft' self'@(FeedMessage x'1 x'2 x'3)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 11 x'1 + P'.wireSizeRep 1 11 x'2 + P'.wireSizeExtField x'3)
  wirePutWithSize ft' self'@(FeedMessage x'1 x'2 x'3)
   = case ft' of
       10 -> put'Fields
       11 -> put'FieldsSized
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = P'.sequencePutWithSize [P'.wirePutReqWithSize 10 11 x'1, P'.wirePutRepWithSize 18 11 x'2, P'.wirePutExtFieldWithSize x'3]
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
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{header = P'.mergeAppend (header old'Self) (new'Field)}) (P'.wireGet 11)
             18 -> Prelude'.fmap (\ !new'Field -> old'Self{entity = P'.append (entity old'Self) new'Field}) (P'.wireGet 11)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in
                   if Prelude'.or [1000 <= field'Number && field'Number <= 1999] then
                    P'.loadExtension field'Number wire'Type old'Self else P'.unknown field'Number wire'Type old'Self

instance P'.MessageAPI msg' (msg' -> FeedMessage) FeedMessage where
  getVal m' f' = f' m'

instance P'.GPB FeedMessage

instance P'.ReflectDescriptor FeedMessage where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10]) (P'.fromDistinctAscList [10, 18])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".transit_realtime.FeedMessage\", haskellPrefix = [], parentModule = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\"], baseName = MName \"FeedMessage\"}, descFilePath = [\"GTFS\",\"RealTime\",\"Protobuf\",\"FeedMessage.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.FeedMessage.header\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"FeedMessage\"], baseName' = FName \"header\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".transit_realtime.FeedHeader\", haskellPrefix = [], parentModule = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\"], baseName = MName \"FeedHeader\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".transit_realtime.FeedMessage.entity\", haskellPrefix' = [], parentModule' = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\",MName \"FeedMessage\"], baseName' = FName \"entity\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 18}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = True, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".transit_realtime.FeedEntity\", haskellPrefix = [], parentModule = [MName \"GTFS\",MName \"RealTime\",MName \"Protobuf\"], baseName = MName \"FeedEntity\"}), hsRawDefault = Nothing, hsDefault = Nothing}], descOneofs = fromList [], keys = fromList [], extRanges = [(FieldId {getFieldId = 1000},FieldId {getFieldId = 1999})], knownKeys = fromList [], storeUnknown = False, lazyFields = False, makeLenses = False, jsonInstances = True}"

instance P'.TextType FeedMessage where
  tellT = P'.tellSubMessage
  getT = P'.getSubMessage

instance P'.TextMsg FeedMessage where
  textPut msg
   = do
       P'.tellT "header" (header msg)
       P'.tellT "entity" (entity msg)
  textGet
   = do
       mods <- P'.sepEndBy (P'.choice [parse'header, parse'entity]) P'.spaces
       Prelude'.return (Prelude'.foldl (\ v f -> f v) P'.defaultValue mods)
    where
        parse'header
         = P'.try
            (do
               v <- P'.getT "header"
               Prelude'.return (\ o -> o{header = v}))
        parse'entity
         = P'.try
            (do
               v <- P'.getT "entity"
               Prelude'.return (\ o -> o{entity = P'.append (entity o) v}))