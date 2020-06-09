#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

import hashlib/bench
import hashlib/mhash/sha256 as mhash_sha256
import hashlib/mhash/sha512 as mhash_sha512
import hashlib/rhash/sha256 as rhash_sha256
import hashlib/rhash/sha512 as rhash_sha512
import hashlib/sph/sha256 as sph_sha256
import hashlib/sph/sha512 as sph_sha512
import hashlib/misc/crypto
import hashlib/gcrypt
import strutils

runBench do (name: string) -> bool:
  name.endsWith("SHA256") or name.endsWith("SHA512")
