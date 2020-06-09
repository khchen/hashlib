#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import mhash/adler32 as mhash_adler32
import mhash/crc32 as mhash_crc32
import mhash/gost as mhash_gost
import mhash/haval as mhash_haval
import mhash/md2 as mhash_md2
import mhash/md4 as mhash_md4
import mhash/md5 as mhash_md5
import mhash/ripemd as mhash_ripemd
import mhash/sha1 as mhash_sha1
import mhash/sha256 as mhash_sha256
import mhash/sha512 as mhash_sha512
import mhash/snefru as mhash_snefru
import mhash/tiger as mhash_tiger
import mhash/whirlpool as mhash_whirlpool

export mhash_adler32
export mhash_crc32
export mhash_gost
export mhash_haval
export mhash_md2
export mhash_md4
export mhash_md5
export mhash_ripemd
export mhash_sha1
export mhash_sha256
export mhash_sha512
export mhash_snefru
export mhash_tiger
export mhash_whirlpool

when isMainModule:
  template test(HashType: typedesc, data: string, result: string) =
    doAssert $count[HashType](data) == result
    echo $HashType, " ok"

  test(MHASH_ADLER32, "", "00000001")
  test(MHASH_CRC32, "", "00000000")
  test(MHASH_CRC32B, "", "00000000")
  test(MHASH_GOST, "", "ce85b99cc46752fffee35cab9a7b0278abb4c2d2055cff685af4912c49490f8d")
  test(MHASH_HAVAL128_3, "", "c68f39913f901f3ddf44c707357a7d70")
  test(MHASH_HAVAL128_4, "", "ee6bbf4d6a46a679b3a856c88538bb98")
  test(MHASH_HAVAL128_5, "", "184b8482a0c050dca54b59c7f05bf5dd")
  test(MHASH_HAVAL160_3, "", "d353c3ae22a25401d257643836d7231a9a95f953")
  test(MHASH_HAVAL160_4, "", "1d33aae1be4146dbaaca0b6e70d7a11f10801525")
  test(MHASH_HAVAL160_5, "", "255158cfc1eed1a7be7c55ddd64d9790415b933b")
  test(MHASH_HAVAL192_3, "", "e9c48d7903eaf2a91c5b350151efcb175c0fc82de2289a4e")
  test(MHASH_HAVAL192_4, "", "4a8372945afa55c7dead800311272523ca19d42ea47b72da")
  test(MHASH_HAVAL192_5, "", "4839d0626f95935e17ee2fc4509387bbe2cc46cb382ffe85")
  test(MHASH_HAVAL224_3, "", "c5aae9d47bffcaaf84a8c6e7ccacd60a0dd1932be7b1a192b9214b6d")
  test(MHASH_HAVAL224_4, "", "3e56243275b3b81561750550e36fcd676ad2f5dd9e15f2e89e6ed78e")
  test(MHASH_HAVAL224_5, "", "4a0513c032754f5582a758d35917ac9adf3854219b39e3ac77d1837e")
  test(MHASH_HAVAL256_3, "", "4f6938531f0bc8991f62da7bbd6f7de3fad44562b8c6f4ebf146d5b4e46f7c17")
  test(MHASH_HAVAL256_4, "", "c92b2e23091e80e375dadce26982482d197b1a2521be82da819f8ca2c579b99b")
  test(MHASH_HAVAL256_5, "", "be417bb4dd5cfb76c7126f4f8eeb1553a449039307b1a3cd451dbfdc0fbbe330")
  test(MHASH_MD2, "", "8350e5a3e24c153df2275c9f80692773")
  test(MHASH_MD4, "", "31d6cfe0d16ae931b73c59d7e0c089c0")
  test(MHASH_MD5, "", "d41d8cd98f00b204e9800998ecf8427e")
  test(MHASH_RIPEMD128, "", "cdf26213a150dc3ecb610f18f6b38b46")
  test(MHASH_RIPEMD160, "", "9c1185a5c5e9fc54612808977ee8f548b2258d31")
  test(MHASH_RIPEMD256, "", "02ba4c4e5f8ecd1877fc52d64d30e37a2d9774fb1e5d026380ae0168e3c5522d")
  test(MHASH_RIPEMD320, "", "22d65d5661536cdc75c1fdf5c6de7b41b9f27325ebc61e8557177d705a0ec880151c3a32a00899b8")
  test(MHASH_SHA1, "", "da39a3ee5e6b4b0d3255bfef95601890afd80709")
  test(MHASH_SHA224, "", "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f")
  test(MHASH_SHA256, "", "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
  test(MHASH_SHA384, "", "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b")
  test(MHASH_SHA512, "", "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e")
  test(MHASH_SNEFRU128, "", "8617f366566a011837f4fb4ba5bedea2")
  test(MHASH_SNEFRU256, "", "8617f366566a011837f4fb4ba5bedea2b892f3ed8b894023d16ae344b2be5881")
  test(MHASH_TIGER, "", "24f0130c63ac933216166e76b1bb925ff373de2d49584e7a")
  test(MHASH_TIGER128, "", "24f0130c63ac933216166e76b1bb925f")
  test(MHASH_TIGER160, "", "24f0130c63ac933216166e76b1bb925ff373de2d")
  test(MHASH_WHIRLPOOL, "", "19fa61d75522a4669b44e39c1d2e1726c530232130d407f89afee0964997f7a73e83be698b288febcf88e3e03c4f0757ea8964e59b63d93708b138cc42a66eb3")
