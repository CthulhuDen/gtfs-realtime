# GTFS RealTime

Haskell protobuf definitions for
[GTFS RealTime](https://developers.google.com/transit/gtfs-realtime/reference/)
feed data. Autogenerated by and supposed to be used with
[protocol-buffers](http://hackage.haskell.org/package/protocol-buffers).

### Usage example

```haskell
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import qualified Data.ByteString.Lazy as LBS
import           Data.Function
import           GTFS.RealTime.Protobuf.FeedMessage
import           Network.HTTP.Simple (Request, setRequestQueryString, httpLBS, getResponseBody)
import qualified Text.ProtocolBuffers as Protobuf

main :: IO ()
main = do
  resp <- httpLBS $ "http://transport.orgp.spb.ru/Portal/transport/internalapi/gtfs/realtime/vehicle"
                      & setRequestQueryString [("routeIDs", Just "1843")]

  msg <- case Protobuf.messageGet $ getResponseBody resp of
    Left err                       -> fail err
    Right (msg :: FeedMessage, "") -> pure msg
    _                              -> fail "parse incomplete"

  -- | You now have FeedMessage parsed
  print msg

```

### Source proto file

The .proto files used to generate the modules:
https://github.com/CthulhuDen/gtfs-realtime/blob/master/transport.proto,
which the same as provided here:
https://developers.google.com/transit/gtfs-realtime/gtfs-realtime-proto,
only with modified package name.
