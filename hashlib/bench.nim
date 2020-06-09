#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

import common, std/monotimes, times, random, strutils
export strutils

template runBench*(filter: untyped) =
  when (filter is proc):
    # runBench do (name: string) -> bool: "MD5" in name
    block:
      proc randomData(size: int): seq[byte] =
        result.setLen(size)
        for i in 0..<result.len: result[i] = rand(byte)

      proc display(name: string, speed: float, digest: string) =
        echo name.alignLeft(24), formatFloat(speed, ffDecimal, 3).align(9), " MB/s  ", digest

      randomize()
      var data = randomData(10 * 1024 * 1024)
      var buffer = newSeq[byte](10 * 1024 * 1024)
      let timer = getMonoTime()

      copyMem(addr buffer[0], addr data[0], data.len)
      let secs = inNanoseconds(getMonoTime() - timer).float / 1_000_000_000
      display("MEMORY_COPY", data.len.float / secs / 1024 / 1024, "")

      var hashes = availableHashes()
      for ho in hashes.mitems:
        if filter(ho.name):
          let timer = getMonoTime()
          var digest = substr($ho.count(data), 0, 31)
          if ho.digestSize > 16: digest.add "..."
          let secs = inNanoseconds(getMonoTime() - timer).float / 1_000_000_000
          display(ho.name, data.len.float / secs / 1024 / 1024, digest)

  elif (filter is string):
    # runBench("MD5")
    runBench do (name: string) -> bool: filter in name

template runBench*() =
  runBench do (name: string) -> bool: true

when isMainModule:
  import all
  runBench()
