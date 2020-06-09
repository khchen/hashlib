#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

import hashlib/bench
import hashlib/mhash/md5 as mhash_md5
import hashlib/rhash/md5 as rhash_md5
import hashlib/sph/md5 as sph_md5
import hashlib/misc/nimhash
import hashlib/gcrypt

runBench("MD5")
