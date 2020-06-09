#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import rhash/aich as rhash_aich
import rhash/crc32 as rhash_crc32
import rhash/ed2k as rhash_ed2k
import rhash/edonr as rhash_edonr
import rhash/gost as rhash_gost
import rhash/has160 as rhash_has160
import rhash/md4 as rhash_md4
import rhash/md5 as rhash_md5
import rhash/ripemd as rhash_ripemd
import rhash/sha1 as rhash_sha1
import rhash/sha256 as rhash_sha256
import rhash/sha3 as rhash_sha3
import rhash/sha512 as rhash_sha512
import rhash/snefru as rhash_snefru
import rhash/streebog as rhash_streebog
import rhash/tiger as rhash_tiger
import rhash/tth as rhash_tth

export rhash_aich
export rhash_crc32
export rhash_ed2k
export rhash_edonr
export rhash_gost
export rhash_has160
export rhash_md4
export rhash_md5
export rhash_ripemd
export rhash_sha1
export rhash_sha256
export rhash_sha3
export rhash_sha512
export rhash_snefru
export rhash_streebog
export rhash_tiger
export rhash_tth

when isMainModule:
  template test(HashType: typedesc, data: string, result: string) =
    doAssert $count[HashType](data) == result
    echo $HashType, " ok"

  test(RHASH_AICH, "", "da39a3ee5e6b4b0d3255bfef95601890afd80709")
  test(RHASH_CRC32, "", "00000000")
  test(RHASH_CRC32C, "", "00000000")
  test(RHASH_ED2K, "", "31d6cfe0d16ae931b73c59d7e0c089c0")
  test(RHASH_EDONR224, "", "f8874b4b00f69697f74a4222764579c9d9391ca5f0e244753ecd7801")
  test(RHASH_EDONR256, "", "86e7c84024c55dbdc9339b395c95e88db8f781719851ad1d237c6e6a8e370b80")
  test(RHASH_EDONR384, "", "69081c1f10b001481d9fdc1b17f04f5ba7b0f5df41473d99bc52d7110000000000000000000000000000000000000000")
  test(RHASH_EDONR512, "", "c7afbdf3e5b4590eb0b25000bf83fb16d4f9b722ee7f9a2dc2bd382035e8ee38d6f6f15c7b8eec85355ac59af989799950c64557eab0e687d0fcbdba90ae9704")
  test(RHASH_GOST2012_256, "", "3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb")
  test(RHASH_GOST2012_512, "", "8e945da209aa869f0455928529bcae4679e9873ab707b55315f56ceb98bef0a7362f715528356ee83cda5f2aac4c6ad2ba3a715c1bcd81cb8e9f90bf4c1c1a8a")
  test(RHASH_GOST94, "", "ce85b99cc46752fffee35cab9a7b0278abb4c2d2055cff685af4912c49490f8d")
  test(RHASH_GOST94PRO, "", "981e5f3ca30c841487830f84fb433e13ac1101569b9c13584ac483234cd656c0")
  test(RHASH_HAS160, "", "307964ef34151d37c8047adec7ab50f4ff89762d")
  test(RHASH_KECCAK224, "", "f71837502ba8e10837bdd8d365adb85591895602fc552b48b7390abd")
  test(RHASH_KECCAK256, "", "c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470")
  test(RHASH_KECCAK384, "", "2c23146a63a29acf99e73b88f8c24eaa7dc60aa771780ccc006afbfa8fe2479b2dd2b21362337441ac12b515911957ff")
  test(RHASH_KECCAK512, "", "0eab42de4c3ceb9235fc91acffe746b29c29a8c366b7c60e4e67c466f36a4304c00fa9caf9d87976ba469bcbe06713b435f091ef2769fb160cdab33d3670680e")
  test(RHASH_MD4, "", "31d6cfe0d16ae931b73c59d7e0c089c0")
  test(RHASH_MD5, "", "d41d8cd98f00b204e9800998ecf8427e")
  test(RHASH_RIPEMD160, "", "9c1185a5c5e9fc54612808977ee8f548b2258d31")
  test(RHASH_SHA1, "", "da39a3ee5e6b4b0d3255bfef95601890afd80709")
  test(RHASH_SHA224, "", "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f")
  test(RHASH_SHA256, "", "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
  test(RHASH_SHA384, "", "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b")
  test(RHASH_SHA512, "", "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e")
  test(RHASH_SHA3_224, "", "6b4e03423667dbb73b6e15454f0eb1abd4597f9a1b078e3f5b5a6bc7")
  test(RHASH_SHA3_256, "", "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a")
  test(RHASH_SHA3_384, "", "0c63a75b845e4f7d01107d852e4c2485c51a50aaaa94fc61995e71bbee983a2ac3713831264adb47fb6bd1e058d5f004")
  test(RHASH_SHA3_512, "", "a69f73cca23a9ac5c8b567dc185a756e97c982164fe25859e0d1dcc1475c80a615b2123af1f5f94c11e3e9402c3ac558f500199d95b6d3e301758586281dcd26")
  test(RHASH_SNEFRU128, "", "8617f366566a011837f4fb4ba5bedea2")
  test(RHASH_SNEFRU256, "", "8617f366566a011837f4fb4ba5bedea2b892f3ed8b894023d16ae344b2be5881")
  test(RHASH_STREEBOG256, "", "3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb")
  test(RHASH_STREEBOG512, "", "8e945da209aa869f0455928529bcae4679e9873ab707b55315f56ceb98bef0a7362f715528356ee83cda5f2aac4c6ad2ba3a715c1bcd81cb8e9f90bf4c1c1a8a")
  test(RHASH_TIGER, "", "3293ac630c13f0245f92bbb1766e16167a4e58492dde73f3")
  test(RHASH_TTH, "", "5d9ed00a030e638bdb753a6a24fb900e5a63b8e73e6c25b6")
