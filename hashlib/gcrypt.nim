#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import common
export common

when defined(windows):
  import os
  when defined(cpu64):
    {.passL: currentSourcePath().parentDir() / "gcrypt" / "libgcrypt64.a".}
    {.passL: currentSourcePath().parentDir() / "gcrypt" / "libgpg-error64.a".}
  else:
    {.passL: currentSourcePath().parentDir() / "gcrypt" / "libgcrypt32.a".}
    {.passL: currentSourcePath().parentDir() / "gcrypt" / "libgpg-error32.a".}
  {.passL: "-lws2_32".}
else:
  {.passL: "-lgcrypt".}

type
  gcry_md_hd_t = ptr object

const
  GCRY_MD_MD5 = 1
  GCRY_MD_SHA1 = 2
  GCRY_MD_RMD160 = 3
  # GCRY_MD_MD2 = 5
  GCRY_MD_TIGER = 6
  # GCRY_MD_HAVAL = 7
  GCRY_MD_SHA256 = 8
  GCRY_MD_SHA384 = 9
  GCRY_MD_SHA512 = 10
  GCRY_MD_SHA224 = 11
  GCRY_MD_MD4 = 301
  GCRY_MD_CRC32 = 302
  GCRY_MD_CRC32_RFC1510 = 303
  GCRY_MD_CRC24_RFC2440 = 304
  GCRY_MD_WHIRLPOOL = 305
  GCRY_MD_TIGER1 = 306
  GCRY_MD_TIGER2 = 307
  GCRY_MD_GOSTR3411_94 = 308
  GCRY_MD_STRIBOG256 = 309
  GCRY_MD_STRIBOG512 = 310
  GCRY_MD_GOSTR3411_CP = 311
  GCRY_MD_SHA3_224 = 312
  GCRY_MD_SHA3_256 = 313
  GCRY_MD_SHA3_384 = 314
  GCRY_MD_SHA3_512 = 315
  GCRY_MD_SHAKE128 = 316
  GCRY_MD_SHAKE256 = 317
  GCRY_MD_BLAKE2B_512 = 318
  GCRY_MD_BLAKE2B_384 = 319
  GCRY_MD_BLAKE2B_256 = 320
  GCRY_MD_BLAKE2B_160 = 321
  GCRY_MD_BLAKE2S_256 = 322
  GCRY_MD_BLAKE2S_224 = 323
  GCRY_MD_BLAKE2S_160 = 324
  GCRY_MD_BLAKE2S_128 = 325

proc gcry_md_open(h: ptr gcry_md_hd_t, algo: int, flags: int): int {.importc, cdecl.}
proc gcry_md_close(h: gcry_md_hd_t) {.importc, cdecl.}
proc gcry_md_write(h: gcry_md_hd_t, buffer: pointer, L: csize_t) {.importc, cdecl.}
proc gcry_md_read(h: gcry_md_hd_t, algo: int): ptr UncheckedArray[byte] {.importc, cdecl.}
proc gcry_md_extract(h: gcry_md_hd_t, algo: int, buffer: pointer, L: csize_t): int {.importc, cdecl.}

template defineHash(name: untyped, algo: untyped, digestSize: int, blockSize: int) =
  proc `name init`(ctx: pointer) {.cdecl.} =
    let p = cast[ptr gcry_md_hd_t](ctx)
    discard gcry_md_open(p, algo, 0)

  proc `name update`(ctx: pointer, data: pointer, len: csize_t) {.cdecl.} =
    let p = cast[ptr gcry_md_hd_t](ctx)
    gcry_md_write(p[], data, len)

  proc `name final`(ctx: pointer, dst: pointer) {.cdecl.} =
    let p = cast[ptr gcry_md_hd_t](ctx)
    copyMem(dst, gcry_md_read(p[], algo), digestSize)
    gcry_md_close(p[])

  hashRegister:
    name = HashType[digestSize, blockSize, sizeof(pointer), `name init`, `name update`, `name final`, false]

template defineXofHash(name: untyped, algo: untyped, digestSize: int, blockSize: int) =
  proc `name init`(ctx: pointer) {.cdecl.} =
    let p = cast[ptr gcry_md_hd_t](ctx)
    discard gcry_md_open(p, algo, 0)

  proc `name update`(ctx: pointer, data: pointer, len: csize_t) {.cdecl.} =
    let p = cast[ptr gcry_md_hd_t](ctx)
    gcry_md_write(p[], data, len)

  proc `name final`(ctx: pointer, dst: pointer, len: csize_t) {.cdecl.} =
    let p = cast[ptr gcry_md_hd_t](ctx)
    discard gcry_md_extract(p[], algo, dst, len)
    gcry_md_close(p[])

  hashRegister:
    name = HashType[digestSize, blockSize, sizeof(pointer), `name init`, `name update`, `name final`, true]

defineHash(GCRYPT_BLAKE2S_128, GCRY_MD_BLAKE2S_128, 16, 64)
defineHash(GCRYPT_BLAKE2S_160, GCRY_MD_BLAKE2S_160, 20, 64)
defineHash(GCRYPT_BLAKE2S_224, GCRY_MD_BLAKE2S_224, 28, 64)
defineHash(GCRYPT_BLAKE2S_256, GCRY_MD_BLAKE2S_256, 32, 64)
defineHash(GCRYPT_BLAKE2B_160, GCRY_MD_BLAKE2B_160, 20, 128)
defineHash(GCRYPT_BLAKE2B_256, GCRY_MD_BLAKE2B_256, 32, 128)
defineHash(GCRYPT_BLAKE2B_384, GCRY_MD_BLAKE2B_384, 48, 128)
defineHash(GCRYPT_BLAKE2B_512, GCRY_MD_BLAKE2B_512, 64, 128)
defineHash(GCRYPT_CRC32, GCRY_MD_CRC32, 4, 4)
defineHash(GCRYPT_CRC32_RFC1510, GCRY_MD_CRC32_RFC1510, 4, 4)
defineHash(GCRYPT_CRC24_RFC2440, GCRY_MD_CRC24_RFC2440, 3, 3)
defineHash(GCRYPT_GOST, GCRY_MD_GOSTR3411_94, 32, 32)
defineHash(GCRYPT_GOSTPRO, GCRY_MD_GOSTR3411_CP, 32, 32)
defineHash(GCRYPT_MD4, GCRY_MD_MD4, 16, 64)
defineHash(GCRYPT_MD5, GCRY_MD_MD5, 16, 64)
defineHash(GCRYPT_RIPEMD160, GCRY_MD_RMD160, 20, 64)
defineHash(GCRYPT_SHA1, GCRY_MD_SHA1, 20, 64)
defineHash(GCRYPT_SHA512, GCRY_MD_SHA512, 64, 128)
defineHash(GCRYPT_SHA224, GCRY_MD_SHA224, 28, 64)
defineHash(GCRYPT_SHA256, GCRY_MD_SHA256, 32, 64)
defineHash(GCRYPT_SHA384, GCRY_MD_SHA384, 48, 128)
defineHash(GCRYPT_SHA3_224, GCRY_MD_SHA3_224, 28, 144)
defineHash(GCRYPT_SHA3_256, GCRY_MD_SHA3_256, 32, 136)
defineHash(GCRYPT_SHA3_384, GCRY_MD_SHA3_384, 48, 104)
defineHash(GCRYPT_SHA3_512, GCRY_MD_SHA3_512, 64, 72)
defineHash(GCRYPT_STREEBOG256, GCRY_MD_STRIBOG256, 32, 64)
defineHash(GCRYPT_STREEBOG512, GCRY_MD_STRIBOG512, 64, 64)
defineHash(GCRYPT_GOST2012_256, GCRY_MD_STRIBOG256, 32, 64)
defineHash(GCRYPT_GOST2012_512, GCRY_MD_STRIBOG512, 64, 64)
defineHash(GCRYPT_TIGER, GCRY_MD_TIGER, 24, 64)
defineHash(GCRYPT_TIGER1, GCRY_MD_TIGER1, 24, 64)
defineHash(GCRYPT_TIGER2, GCRY_MD_TIGER2, 24, 64)
defineHash(GCRYPT_WHIRLPOOL, GCRY_MD_WHIRLPOOL, 64, 64)
defineXofHash(GCRYPT_SHAKE128, GCRY_MD_SHAKE128, 16, 168)
defineXofHash(GCRYPT_SHAKE256, GCRY_MD_SHAKE256, 32, 136)

when isMainModule:
  template test(HashType: typedesc, data: string, result: string) =
    doAssert $count[HashType](data) == result
    echo $HashType, " ok"

  test(GCRYPT_BLAKE2S_128, "", "64550d6ffe2c0a01a14aba1eade0200c")
  test(GCRYPT_BLAKE2S_160, "", "354c9c33f735962418bdacb9479873429c34916f")
  test(GCRYPT_BLAKE2S_224, "", "1fa1291e65248b37b3433475b2a0dd63d54a11ecc4e3e034e7bc1ef4")
  test(GCRYPT_BLAKE2S_256, "", "69217a3079908094e11121d042354a7c1f55b6482ca1a51e1b250dfd1ed0eef9")
  test(GCRYPT_BLAKE2B_160, "", "3345524abf6bbe1809449224b5972c41790b6cf2")
  test(GCRYPT_BLAKE2B_256, "", "0e5751c026e543b2e8ab2eb06099daa1d1e5df47778f7787faab45cdf12fe3a8")
  test(GCRYPT_BLAKE2B_384, "", "b32811423377f52d7862286ee1a72ee540524380fda1724a6f25d7978c6fd3244a6caf0498812673c5e05ef583825100")
  test(GCRYPT_BLAKE2B_512, "", "786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce")
  test(GCRYPT_CRC32, "", "00000000")
  test(GCRYPT_CRC32_RFC1510, "", "00000000")
  test(GCRYPT_CRC24_RFC2440, "", "b704ce")
  test(GCRYPT_GOST, "", "ce85b99cc46752fffee35cab9a7b0278abb4c2d2055cff685af4912c49490f8d")
  test(GCRYPT_GOSTPRO, "", "981e5f3ca30c841487830f84fb433e13ac1101569b9c13584ac483234cd656c0")
  test(GCRYPT_MD4, "", "31d6cfe0d16ae931b73c59d7e0c089c0")
  test(GCRYPT_MD5, "", "d41d8cd98f00b204e9800998ecf8427e")
  test(GCRYPT_RIPEMD160, "", "9c1185a5c5e9fc54612808977ee8f548b2258d31")
  test(GCRYPT_SHA1, "", "da39a3ee5e6b4b0d3255bfef95601890afd80709")
  test(GCRYPT_SHA512, "", "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e")
  test(GCRYPT_SHA224, "", "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f")
  test(GCRYPT_SHA256, "", "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
  test(GCRYPT_SHA384, "", "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b")
  test(GCRYPT_SHA3_224, "", "6b4e03423667dbb73b6e15454f0eb1abd4597f9a1b078e3f5b5a6bc7")
  test(GCRYPT_SHA3_256, "", "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a")
  test(GCRYPT_SHA3_384, "", "0c63a75b845e4f7d01107d852e4c2485c51a50aaaa94fc61995e71bbee983a2ac3713831264adb47fb6bd1e058d5f004")
  test(GCRYPT_SHA3_512, "", "a69f73cca23a9ac5c8b567dc185a756e97c982164fe25859e0d1dcc1475c80a615b2123af1f5f94c11e3e9402c3ac558f500199d95b6d3e301758586281dcd26")
  test(GCRYPT_STREEBOG256, "", "3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb")
  test(GCRYPT_STREEBOG512, "", "8e945da209aa869f0455928529bcae4679e9873ab707b55315f56ceb98bef0a7362f715528356ee83cda5f2aac4c6ad2ba3a715c1bcd81cb8e9f90bf4c1c1a8a")
  test(GCRYPT_GOST2012_256, "", "3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb")
  test(GCRYPT_GOST2012_512, "", "8e945da209aa869f0455928529bcae4679e9873ab707b55315f56ceb98bef0a7362f715528356ee83cda5f2aac4c6ad2ba3a715c1bcd81cb8e9f90bf4c1c1a8a")
  test(GCRYPT_TIGER, "", "24f0130c63ac933216166e76b1bb925ff373de2d49584e7a")
  test(GCRYPT_TIGER1, "", "3293ac630c13f0245f92bbb1766e16167a4e58492dde73f3")
  test(GCRYPT_TIGER2, "", "4441be75f6018773c206c22745374b924aa8313fef919f41")
  test(GCRYPT_WHIRLPOOL, "", "19fa61d75522a4669b44e39c1d2e1726c530232130d407f89afee0964997f7a73e83be698b288febcf88e3e03c4f0757ea8964e59b63d93708b138cc42a66eb3")
  test(GCRYPT_SHAKE128, "", "7f9c2ba4e88f827d616045507605853e")
  test(GCRYPT_SHAKE256, "", "46b9dd2b0ba88d13233b3feb743eeb243fcd52ea62b81b82b50c27646ed5762f")
