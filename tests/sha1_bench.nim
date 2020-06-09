#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

import hashlib/bench
import hashlib/mhash/sha1 as mhash_sha1
import hashlib/rhash/sha1 as rhash_sha1
import hashlib/sph/sha1 as sph_sha1
import hashlib/misc/[nimhash, crypto]
import hashlib/gcrypt

runBench("SHA1")
