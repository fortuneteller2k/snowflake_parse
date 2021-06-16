import os, strformat, strutils, times

proc snowflake_parse(s: string, epoch: int64) =
  let
    snowflake: int64 = s.parseInt()
    timestamp: DateTime = fromUnix(((snowflake shr 22) + epoch) div 1000).utc
    worker_id: int64 = (snowflake and 0x3e0000) shr 17
    process_id: int64 = (snowflake and 0x1f000) shr 12
    
  echo(&"Binary representation: {snowflake.toBin(64)}")
  echo(&"Timestamp: {timestamp}")

  if worker_id != 0:
    echo(&"Worker ID: {worker_id}")

  if process_id != 0:
    echo(&"Process ID: {process_id}")

when isMainModule:
  var input: seq[TaintedString] = commandLineParams()

  try: 
    snowflake_parse(input[0], 1420070400000)
  except:
    echo("usage: snowflake_parse [snowflake]")
    quit(QuitFailure)
