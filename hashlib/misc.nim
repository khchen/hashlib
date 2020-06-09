#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import misc/blake2 as misc_blake2
import misc/blake3 as misc_blake3
import misc/crypto as misc_crypto
import misc/kangarootwelve as misc_kangarootwelve
import misc/nimhash as misc_nimhash
import misc/sha3 as misc_sha3
import misc/tinysha3 as misc_tinysha3
import misc/tinyshabal as misc_tinyshabal
import misc/xxhash as misc_xxhash

export misc_blake2
export misc_blake3
export misc_crypto
export misc_kangarootwelve
export misc_nimhash
export misc_sha3
export misc_tinysha3
export misc_tinyshabal
export misc_xxhash

when isMainModule:
  template test(HashType: typedesc, data: string, result: string) =
    doAssert $count[HashType](data) == result
    echo $HashType, " ok"

  test(BLAKE2S_224, "", "1fa1291e65248b37b3433475b2a0dd63d54a11ecc4e3e034e7bc1ef4")
  test(BLAKE2S_256, "", "69217a3079908094e11121d042354a7c1f55b6482ca1a51e1b250dfd1ed0eef9")
  test(BLAKE2B_384, "", "b32811423377f52d7862286ee1a72ee540524380fda1724a6f25d7978c6fd3244a6caf0498812673c5e05ef583825100")
  test(BLAKE2B_512, "", "786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce")
  test(BLAKE3, "", "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262")
  test(BLAKE3_128, "", "af1349b9f5f9a1a6a0404dea36dcc949")
  test(BLAKE3_160, "", "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9")
  test(BLAKE3_192, "", "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7")
  test(BLAKE3_224, "", "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93ca")
  test(BLAKE3_256, "", "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262")
  test(BLAKE3_384, "", "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262e00f03e7b69af26b7faaf09fcd333050")
  test(BLAKE3_512, "", "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262e00f03e7b69af26b7faaf09fcd333050338ddfe085b8cc869ca98b206c08243a")
  test(NIM_MD5, "", "d41d8cd98f00b204e9800998ecf8427e")
  test(NIM_SHA1, "", "da39a3ee5e6b4b0d3255bfef95601890afd80709")
  test(NIMCRYPTO_BLAKE2B_384, "", "b32811423377f52d7862286ee1a72ee540524380fda1724a6f25d7978c6fd3244a6caf0498812673c5e05ef583825100")
  test(NIMCRYPTO_BLAKE2B_512, "", "786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce")
  test(NIMCRYPTO_BLAKE2S_224, "", "1fa1291e65248b37b3433475b2a0dd63d54a11ecc4e3e034e7bc1ef4")
  test(NIMCRYPTO_BLAKE2S_256, "", "69217a3079908094e11121d042354a7c1f55b6482ca1a51e1b250dfd1ed0eef9")
  test(NIMCRYPTO_KECCAK224, "", "f71837502ba8e10837bdd8d365adb85591895602fc552b48b7390abd")
  test(NIMCRYPTO_KECCAK256, "", "c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470")
  test(NIMCRYPTO_KECCAK384, "", "2c23146a63a29acf99e73b88f8c24eaa7dc60aa771780ccc006afbfa8fe2479b2dd2b21362337441ac12b515911957ff")
  test(NIMCRYPTO_KECCAK512, "", "0eab42de4c3ceb9235fc91acffe746b29c29a8c366b7c60e4e67c466f36a4304c00fa9caf9d87976ba469bcbe06713b435f091ef2769fb160cdab33d3670680e")
  test(NIMCRYPTO_RIPEMD128, "", "cdf26213a150dc3ecb610f18f6b38b46")
  test(NIMCRYPTO_RIPEMD160, "", "9c1185a5c5e9fc54612808977ee8f548b2258d31")
  test(NIMCRYPTO_RIPEMD256, "", "02ba4c4e5f8ecd1877fc52d64d30e37a2d9774fb1e5d026380ae0168e3c5522d")
  test(NIMCRYPTO_RIPEMD320, "", "22d65d5661536cdc75c1fdf5c6de7b41b9f27325ebc61e8557177d705a0ec880151c3a32a00899b8")
  test(NIMCRYPTO_SHA1, "", "da39a3ee5e6b4b0d3255bfef95601890afd80709")
  test(NIMCRYPTO_SHA224, "", "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f")
  test(NIMCRYPTO_SHA256, "", "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
  test(NIMCRYPTO_SHA384, "", "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b")
  test(NIMCRYPTO_SHA3_224, "", "6b4e03423667dbb73b6e15454f0eb1abd4597f9a1b078e3f5b5a6bc7")
  test(NIMCRYPTO_SHA3_256, "", "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a")
  test(NIMCRYPTO_SHA3_384, "", "0c63a75b845e4f7d01107d852e4c2485c51a50aaaa94fc61995e71bbee983a2ac3713831264adb47fb6bd1e058d5f004")
  test(NIMCRYPTO_SHA3_512, "", "a69f73cca23a9ac5c8b567dc185a756e97c982164fe25859e0d1dcc1475c80a615b2123af1f5f94c11e3e9402c3ac558f500199d95b6d3e301758586281dcd26")
  test(NIMCRYPTO_SHA512, "", "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e")
  test(NIMCRYPTO_SHA512_224, "", "6ed0dd02806fa89e25de060c19d3ac86cabb87d6a0ddd05c333b84f4")
  test(NIMCRYPTO_SHA512_256, "", "c672b8d1ef56ed28ab87c3622c5114069bdd3ad7b8f9737498d0c01ecef0967a")
  test(NIMCRYPTO_SHAKE128, "", "7f9c2ba4e88f827d616045507605853e")
  test(NIMCRYPTO_SHAKE256, "", "46b9dd2b0ba88d13233b3feb743eeb243fcd52ea62b81b82b50c27646ed5762f")
  test(SHA3_224, "", "6b4e03423667dbb73b6e15454f0eb1abd4597f9a1b078e3f5b5a6bc7")
  test(SHA3_256, "", "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a")
  test(SHA3_384, "", "0c63a75b845e4f7d01107d852e4c2485c51a50aaaa94fc61995e71bbee983a2ac3713831264adb47fb6bd1e058d5f004")
  test(SHA3_512, "", "a69f73cca23a9ac5c8b567dc185a756e97c982164fe25859e0d1dcc1475c80a615b2123af1f5f94c11e3e9402c3ac558f500199d95b6d3e301758586281dcd26")
  test(SHAKE128, "", "7f9c2ba4e88f827d616045507605853e")
  test(SHAKE256, "", "46b9dd2b0ba88d13233b3feb743eeb243fcd52ea62b81b82b50c27646ed5762f")
  test(KECCAK224, "", "f71837502ba8e10837bdd8d365adb85591895602fc552b48b7390abd")
  test(KECCAK256, "", "c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470")
  test(KECCAK384, "", "2c23146a63a29acf99e73b88f8c24eaa7dc60aa771780ccc006afbfa8fe2479b2dd2b21362337441ac12b515911957ff")
  test(KECCAK512, "", "0eab42de4c3ceb9235fc91acffe746b29c29a8c366b7c60e4e67c466f36a4304c00fa9caf9d87976ba469bcbe06713b435f091ef2769fb160cdab33d3670680e")
  test(KANGAROO_TWELVE, "", "1ac2d450fc3b4205d19da7bfca1b37513c0803577ac7167f06fe2ce1f0ef39e5")
  test(TINY_SHA3_224, "", "6b4e03423667dbb73b6e15454f0eb1abd4597f9a1b078e3f5b5a6bc7")
  test(TINY_SHA3_256, "", "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a")
  test(TINY_SHA3_384, "", "0c63a75b845e4f7d01107d852e4c2485c51a50aaaa94fc61995e71bbee983a2ac3713831264adb47fb6bd1e058d5f004")
  test(TINY_SHA3_512, "", "a69f73cca23a9ac5c8b567dc185a756e97c982164fe25859e0d1dcc1475c80a615b2123af1f5f94c11e3e9402c3ac558f500199d95b6d3e301758586281dcd26")
  test(TINY_SHAKE128, "", "7f9c2ba4e88f827d616045507605853e")
  test(TINY_SHAKE256, "", "46b9dd2b0ba88d13233b3feb743eeb243fcd52ea62b81b82b50c27646ed5762f")
  test(TINY_SHABAL192, "", "e10dc32232f98b039dbbcfa41269b9cdf67a73c841214c81")
  test(TINY_SHABAL224, "", "562b4fdbe1706247552927f814b66a3d74b465a090af23e277bf8029")
  test(TINY_SHABAL256, "", "aec750d11feee9f16271922fbaf5a9be142f62019ef8d720f858940070889014")
  test(TINY_SHABAL384, "", "ff093d67d22b06a674b5f384719150d617e0ff9c8923569a2ab60cda886df63c91a25f33cd71cc22c9eebc5cd6aee52a")
  test(TINY_SHABAL512, "", "fc2d5dff5d70b7f6b1f8c2fcc8c1f9fe9934e54257eded0cf2b539a2ef0a19ccffa84f8d9fa135e4bd3c09f590f3a927ebd603ac29eb729e6f2a9af031ad8dc6")
  test(XXHASH32, "", "02cc5d05")
  test(XXHASH3_128, "", "07fd4e968e916ae11f17545bce1061f1")
  test(XXHASH3_64, "", "776eddfb6bfd9195")
  test(XXHASH64, "", "ef46db3751d8e999")
