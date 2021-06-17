import os, strformat, strutils, times

type Snowflake = object
  content: int64
  epoch: int64

method getContent(this: Snowflake): int64 = this.content
method getEpoch(this: Snowflake): int64 = this.epoch
method getTimestamp(this: Snowflake): DateTime = fromUnix(((this.content shr 22) + this.epoch) div 1000).utc
method getWorkerId(this: Snowflake): int64 = (this.content and 0x3e0000) shr 17
method getProcessId(this: Snowflake): int64 = (this.content and 0x1f000) shr 12

method prettyPrint(this: Snowflake) =
  echo(&"Binary representation: {this.getContent().toBin(64)}")
  echo(&"Timestamp: {this.getTimestamp()}")

  if this.getWorkerId() != 0:
    echo(&"Worker ID: {this.getWorkerId()}")

  if this.getProcessId() != 0:
    echo(&"Process ID: {this.getProcessId()}")

when isMainModule:
  let input: seq[TaintedString] = commandLineParams()

  try: 
    Snowflake(content: input[0].parseInt(), epoch: 1420070400000).prettyPrint()
  except:
    echo("usage: snowflake_parse [snowflake]")
    quit(QuitFailure)
