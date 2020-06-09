#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

import rhash/crc32 as rhash_crc32
import rhash/md5 as rhash_md5
import rhash/sha1 as rhash_sha1
import rhash/sha256 as rhash_sha256
import misc/sha3 as misc_sha3
import misc/xxhash as misc_xxhash

export rhash_crc32
export rhash_md5
export rhash_sha1
export rhash_sha256
export misc_sha3
export misc_xxhash

when isMainModule:
  template test(HashType: typedesc, data: string, result: string) =
    doAssert $count[HashType](data) == result
    echo $HashType, " ok"

  test(RHASH_CRC32, "", "00000000")
  test(RHASH_CRC32C, "", "00000000")
  test(RHASH_MD5, "", "d41d8cd98f00b204e9800998ecf8427e")
  test(RHASH_SHA1, "", "da39a3ee5e6b4b0d3255bfef95601890afd80709")
  test(RHASH_SHA224, "", "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f")
  test(RHASH_SHA256, "", "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
  test(KECCAK224, "", "f71837502ba8e10837bdd8d365adb85591895602fc552b48b7390abd")
  test(KECCAK256, "", "c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470")
  test(KECCAK384, "", "2c23146a63a29acf99e73b88f8c24eaa7dc60aa771780ccc006afbfa8fe2479b2dd2b21362337441ac12b515911957ff")
  test(KECCAK512, "", "0eab42de4c3ceb9235fc91acffe746b29c29a8c366b7c60e4e67c466f36a4304c00fa9caf9d87976ba469bcbe06713b435f091ef2769fb160cdab33d3670680e")
  test(SHA3_224, "", "6b4e03423667dbb73b6e15454f0eb1abd4597f9a1b078e3f5b5a6bc7")
  test(SHA3_256, "", "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a")
  test(SHA3_384, "", "0c63a75b845e4f7d01107d852e4c2485c51a50aaaa94fc61995e71bbee983a2ac3713831264adb47fb6bd1e058d5f004")
  test(SHA3_512, "", "a69f73cca23a9ac5c8b567dc185a756e97c982164fe25859e0d1dcc1475c80a615b2123af1f5f94c11e3e9402c3ac558f500199d95b6d3e301758586281dcd26")
  test(SHAKE128, "", "7f9c2ba4e88f827d616045507605853e")
  test(SHAKE256, "", "46b9dd2b0ba88d13233b3feb743eeb243fcd52ea62b81b82b50c27646ed5762f")
  test(XXHASH32, "", "02cc5d05")
  test(XXHASH64, "", "ef46db3751d8e999")
  test(XXHASH3_64, "", "776eddfb6bfd9195")
  test(XXHASH3_128, "", "07fd4e968e916ae11f17545bce1061f1")
