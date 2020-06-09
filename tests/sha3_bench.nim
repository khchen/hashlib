#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

import hashlib/bench
import hashlib/rhash/sha3 as rhash_sha3
import hashlib/sph/sha3 as sph_sha3
import hashlib/misc/[sha3, tinysha3, crypto]
import hashlib/gcrypt
import strutils

runBench do (name: string) -> bool:
  name.endsWith("SHA3_256") or name.endsWith("SHA3_512") or name.contains("SHAKE")
