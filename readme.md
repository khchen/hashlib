# Hashlib

Hashlib contains almost all the hash functions for Nim and provides uniform interface, hmac, and benchmark for all hashes. The C source codes are collected from [RHash], [MHash], [Sphlib], [Team Keccak], [BLAKE2], [BLAKE3], [tiny_sha3], [xxHash] etc. This module also provides the same interface for [libgcrypt], [nimcrypto], and Nim builtin [MD5]/[SHA1].

[RHash]: <https://github.com/rhash/RHash>
[MHash]: <http://mhash.sourceforge.net>
[Sphlib]: <https://github.com/aidansteele/sphlib>
[Team Keccak]: <https://keccak.team/keccak.html>
[BLAKE2]: <https://blake2.net>
[BLAKE3]: <https://github.com/BLAKE3-team/BLAKE3>
[tiny_sha3]: <https://github.com/mjosaarinen/tiny_sha3>
[xxHash]: <https://github.com/Cyan4973/xxHash>
[libgcrypt]: <https://gnupg.org/software/libgcrypt/index.html>
[nimcrypto]: <https://github.com/cheatfate/nimcrypto>
[MD5]: <https://nim-lang.org/docs/md5.html>
[SHA1]: <https://nim-lang.org/docs/sha1.html>

## Install

    nimble install hashlib

For Linux user:

    sudo apt install libgcrypt20 libgcrypt20-dev

This module already includes libgcrypt for Windows (mingw32/64 only).

## Usage

### How to Import

Hash functions can be imported all-in-one or one-by-one.

```nim
import hashlib # import all available hashes
import hashlib/rhash # import all hashes from RHash
import hashlib/mhash # import all hashes from MHash
import hashlib/sph # import all hashes from Sphlib
import hashlib/gcrypt # import all hashes from libgcrypt
import hashlib/misc # import other hashes
import hashlib/lean # import commonly used hashes
import hashlib/bench # import runBench() template
```

```nim
import hashlib/rhash/[aich, crc32, ed2k, edonr, gost, has160, md4, md5, ripemd160, sha1, sha256, sha3, sha512, snefru, streebog, tiger, tth]
import hashlib/mhash/[adler32, crc32, gost, haval, md2, md4, md5, ripemd, sha1, sha256, sha512, snefru, tiger, whirlpool]
import hashlib/sph/[blake, bmw, cubehash, echohash, fugue, groestl, hamsi, haval, jh, keccak, luffa, md2, md4, md5, panama, radiogatun, ripemd, sha0, sha1, sha256, sha512, shabal, shavite, simd, skein, tiger, whirlpool]
import hashlib/misc/[blake2, blake3, crypto, kangarootwelve, nimhash, sha3, tinysha3, tinyshabal, xxhash]
```

Use import ... as ... to avoid name conflict. For example:

```nim
import hashlib/rhash/md5 as rhash_md5
import hashlib/mhash/md5 as mhash_md5
import hashlib/bench

runBench()
```

### Simple API

```
count[HashType](DataTypes): HashType
count[HashType](DataTypes, DigestTypes)

DataTypes = string | openarray[byte] | openarray[char] | Stream | MemoryBlock
DigestTypes = HashType | Digest | openarray[byte] | openarray[char]
```

### Stream API

```
init[HashType](): Context[HashType]
init(var Context[HashType])

update(var Context[HashType], DataTypes)

final(var Context[HashType]): HashType
final(var Context[HashType], var DigestTypes)

DataTypes = string | openarray[byte] | openarray[char] | Stream | MemoryBlock
DigestTypes = HashType | Digest | openarray[byte] | openarray[char]
```

### Simple HMAC API

```
count[Hmac[HashType]](KeyTypes, DataTypes): HashType
count[Hmac[HashType]](KeyTypes, DataTypes, var DigestTypes)

KeyTypes = string | openarray[byte] | openarray[char] | MemoryBlock
DataTypes = string | openarray[byte] | openarray[char] | Stream | MemoryBlock
DigestTypes = HashType | Digest | openarray[byte] | openarray[char]
```

### Stream HMAC API
```
init[Hmac[HashType]](KeyTypes): Hmac[HashType]
init(var Hmac[HashType], KeyTypes)

update(var Hmac[HashType], DataTypes)

final(var Hmac[HashType]): HashType
final(var Hmac[HashType], var DigestTypes)

KeyTypes = string | openarray[byte] | openarray[char] | MemoryBlock
DataTypes = string | openarray[byte] | openarray[char] | Stream | MemoryBlock
DigestTypes = HashType | Digest | openarray[byte] | openarray[char]
```

### Example

```nim
import hashlib/rhash/md5

# Now we have RHASH_MD5
doAssert(declared(RHASH_MD5))
doAssert(RHASH_MD5 is HashType)

# Gets information from HashType
doAssert(RHASH_MD5.digestSize == 16)
doAssert(RHASH_MD5.blockSize == 64)

# Counts the hash for empty string, returns a RHASH_MD5 object
var hash = count[RHASH_MD5]("")
doAssert(hash.type is RHASH_MD5)

# hash.data should be array[16, byte]
doAssert(hash.data == [byte 212, 29, 140, 217, 143, 0, 178, 4, 233, 128, 9, 152, 236, 248, 66, 126])

# `$` convert HashType to string
doAssert($hash == "d41d8cd98f00b204e9800998ecf8427e")

# Result can store in Digest object.
var digest: Digest
count[RHASH_MD5]("", digest)

# digest.data should be seq[byte] in length of RHASH_MD5.digestSize
doAssert(digest.data == @[byte 212, 29, 140, 217, 143, 0, 178, 4, 233, 128, 9, 152, 236, 248, 66, 126])

# `$` convert Digest object to string
doAssert($hash == "d41d8cd98f00b204e9800998ecf8427e")

# Try another input data type: openarray[char]
doAssert($count[RHASH_MD5](toOpenArray("abc", 0, 2)) == "900150983cd24fb0d6963f7d28e17f72")

# Try another ouptut data type: openarray[byte]
var digestSeq = newSeq[byte](16)
count[RHASH_MD5]("abc", digestSeq)
doAssert(digestSeq == @[byte 144, 1, 80, 152, 60, 210, 79, 176, 214, 150, 63, 125, 40, 225, 127, 114])

import strutils
import hashlib/misc/sha3

# Now we have SHAKE128, it support extendable-output functions (XOFs)
doAssert(declared(SHAKE128))
doAssert(SHAKE128.xof == true)

# Gets 1024 bytes output, use initDigest()
digest = initDigest(1024)
count[SHAKE128]("", digest)
doAssert(($digest).startsWith("7f9c2ba4e88f827d616045507605853e"))

# Gets 2048 bytes output, use setLen()
digest.setLen(2048)
count[SHAKE128]("", digest)
doAssert(($digest).endsWith("10e7e33816e581d85fc48a77254c23bb"))

# Try stream API
var ctx = init[RHASH_MD5]()
ctx.update("")
doAssert($ctx.final() == "d41d8cd98f00b204e9800998ecf8427e")

# Reuses the ctx and stores result in digest object
doAssert(ctx.type is Context[RHASH_MD5])
ctx.init()
ctx.update("")
ctx.final(digest)
doAssert($digest == "d41d8cd98f00b204e9800998ecf8427e")

# Try simple HMAC API
doAssert($count[Hmac[RHASH_MD5]]("key", "data") == "9d5c73ef85594d34ec4438b7c97e51d8")

# Try stream HMAC API
var hmac = init[Hmac[RHASH_MD5]]("key")
hmac.update("data")
doAssert($hmac.final() == "9d5c73ef85594d34ec4438b7c97e51d8")

# Reuses the HMAC ctx and stores result in digest object
doAssert(hmac.type is Hmac[RHASH_MD5])
hmac.init("key")
hmac.update("data")
hmac.final(digest)
doAssert($digest == "9d5c73ef85594d34ec4438b7c97e51d8")

import hashlib/bench

# Now we have runBench template
doAssert(declared(runBench))

# Runs benchmark for all available hashes: RHASH_MD5, KECCAKnnn, SHA3_nnn, SHAKEnnn, etc
runBench()

# Runs benchmark for MD5 only
runBench("MD5")

# Runs benchmark for SHA3 and SHAKE
runBench do (name: string) -> bool:
  name.startsWith("SHA3") or name.startsWith("SHAKE")

```

## Available Hashes

<details>

  <summary>Details</summary>

  | Module | Submodule | Hashes |
  | ------ | ------ | ------ |
  | rhash | aich | RHASH_AICH |
  | rhash | crc32 | RHASH_CRC32, RHASH_CRC32C |
  | rhash | ed2k | RHASH_ED2K |
  | rhash | edonr | RHASH_EDONR224, RHASH_EDONR256, RHASH_EDONR384, RHASH_EDONR512 |
  | rhash | gost | RHASH_GOST94, RHASH_GOST94PRO |
  | rhash | has160 | RHASH_HAS160 |
  | rhash | md4 | RHASH_MD4 |
  | rhash | md5 | RHASH_MD5 |
  | rhash | ripemd | RHASH_RIPEMD160 |
  | rhash | sha1 | RHASH_SHA1 |
  | rhash | sha256 | RHASH_SHA224, RHASH_SHA256 |
  | rhash | sha512 | RHASH_SHA384, RHASH_SHA512 |
  | rhash | sha3 or keccak | RHASH_KECCAK224, RHASH_KECCAK256, RHASH_KECCAK384, RHASH_KECCAK512, RHASH_SHA3_224, RHASH_SHA3_256, RHASH_SHA3_384, RHASH_SHA3_512 |
  | rhash | snefru | RHASH_SNEFRU128, RHASH_SNEFRU256 |
  | rhash | streebog | RHASH_GOST2012_256, RHASH_GOST2012_512, RHASH_STREEBOG256, RHASH_STREEBOG512 |
  | rhash | tiger | RHASH_TIGER |
  | rhash | tth | RHASH_TTH |
  | mhash | adler32 | MHASH_ADLER32 |
  | mhash | crc32 | MHASH_CRC32, MHASH_CRC32B |
  | mhash | gost | MHASH_GOST |
  | mhash | haval | MHASH_HAVAL128_3, MHASH_HAVAL128_4, MHASH_HAVAL128_5, MHASH_HAVAL160_3, MHASH_HAVAL160_4, MHASH_HAVAL160_5, MHASH_HAVAL192_3, MHASH_HAVAL192_4, MHASH_HAVAL192_5, MHASH_HAVAL224_3, MHASH_HAVAL224_4, MHASH_HAVAL224_5, MHASH_HAVAL256_3, MHASH_HAVAL256_4, MHASH_HAVAL256_5 |
  | mhash | md2 | MHASH_MD2 |
  | mhash | md4 | MHASH_MD4 |
  | mhash | md5 | MHASH_MD5 |
  | mhash | ripemd | MHASH_RIPEMD128, MHASH_RIPEMD160, MHASH_RIPEMD256, MHASH_RIPEMD320 |
  | mhash | sha1 | MHASH_SHA1 |
  | mhash | sha256 | MHASH_SHA224, MHASH_SHA256 |
  | mhash | sha512 | MHASH_SHA384, MHASH_SHA512 |
  | mhash | snefru | MHASH_SNEFRU128, MHASH_SNEFRU256 |
  | mhash | tiger | MHASH_TIGER, MHASH_TIGER128, MHASH_TIGER160 |
  | mhash | whirlpool | MHASH_WHIRLPOOL |
  | sph | blake | SPH_BLAKE224, SPH_BLAKE256, SPH_BLAKE384, SPH_BLAKE512 |
  | sph | bmw | SPH_BMW224, SPH_BMW256, SPH_BMW384, SPH_BMW512 |
  | sph | cubehash | SPH_CUBEHASH224, SPH_CUBEHASH256, SPH_CUBEHASH384, SPH_CUBEHASH512 |
  | sph | echohash | SPH_ECHO224, SPH_ECHO256, SPH_ECHO384, SPH_ECHO512 |
  | sph | fugue | SPH_FUGUE224, SPH_FUGUE256, SPH_FUGUE384, SPH_FUGUE512 |
  | sph | groestl | SPH_GROESTL224, SPH_GROESTL256, SPH_GROESTL384, SPH_GROESTL512 |
  | sph | hamsi | SPH_HAMSI224, SPH_HAMSI256, SPH_HAMSI384, SPH_HAMSI512 |
  | sph | haval | SPH_HAVAL128_3, SPH_HAVAL128_4, SPH_HAVAL128_5, SPH_HAVAL160_3, SPH_HAVAL160_4, SPH_HAVAL160_5, SPH_HAVAL192_3, SPH_HAVAL192_4, SPH_HAVAL192_5, SPH_HAVAL224_3, SPH_HAVAL224_4, SPH_HAVAL224_5, SPH_HAVAL256_3, SPH_HAVAL256_4, SPH_HAVAL256_5 |
  | sph | jh | SPH_JH224, SPH_JH256, SPH_JH384, SPH_JH512 |
  | sph | luffa | SPH_LUFFA224, SPH_LUFFA256, SPH_LUFFA384, SPH_LUFFA512 |
  | sph | md2 | SPH_MD2 |
  | sph | md4 | SPH_MD4 |
  | sph | md5 | SPH_MD5 |
  | sph | panama | SPH_PANAMA |
  | sph | radiogatun | SPH_RADIOGATUN32, SPH_RADIOGATUN64 |
  | sph | ripemd | SPH_RIPEMD, SPH_RIPEMD128, SPH_RIPEMD160 |
  | sph | sha0 | SPH_SHA0 |
  | sph | sha1 | SPH_SHA1 |
  | sph | sha256 | SPH_SHA224, SPH_SHA256 |
  | sph | sha512 | SPH_SHA384, SPH_SHA512 |
  | sph | sha3 or keccak | SPH_KECCAK224, SPH_KECCAK256, SPH_KECCAK384, SPH_KECCAK512, SPH_SHA3_224, SPH_SHA3_256, SPH_SHA3_384, SPH_SHA3_512 |
  | sph | shabal | SPH_SHABAL192, SPH_SHABAL224, SPH_SHABAL256, SPH_SHABAL384, SPH_SHABAL512 |
  | sph | shavite | SPH_SHAVITE224, SPH_SHAVITE256, SPH_SHAVITE384, SPH_SHAVITE512 |
  | sph | simd | SPH_SIMD224, SPH_SIMD256, SPH_SIMD384, SPH_SIMD512 |
  | sph | skein | SPH_SKEIN224, SPH_SKEIN256, SPH_SKEIN384, SPH_SKEIN512 |
  | sph | tiger | SPH_TIGER, SPH_TIGER2 |
  | sph | whirlpool | SPH_WHIRLPOOL, SPH_WHIRLPOOL0, SPH_WHIRLPOOL1 |
  | misc | blake2 | BLAKE2S_224, BLAKE2S_256, BLAKE2B_384, BLAKE2B_512 |
  | misc | blake3 | BLAKE3, BLAKE3_128, BLAKE3_160, BLAKE3_192, BLAKE3_224, BLAKE3_256, BLAKE3_384, BLAKE3_512 |
  | misc | crypto | NIMCRYPTO_SHA1, NIMCRYPTO_SHA224, NIMCRYPTO_SHA256, NIMCRYPTO_SHA384, NIMCRYPTO_SHA512, NIMCRYPTO_SHA512_224, NIMCRYPTO_SHA512_256, NIMCRYPTO_RIPEMD128, NIMCRYPTO_RIPEMD160, NIMCRYPTO_RIPEMD256, NIMCRYPTO_RIPEMD320, NIMCRYPTO_BLAKE2S_224, NIMCRYPTO_BLAKE2S_256, NIMCRYPTO_BLAKE2B_384, NIMCRYPTO_BLAKE2B_512, NIMCRYPTO_KECCAK224, NIMCRYPTO_KECCAK256, NIMCRYPTO_KECCAK384, NIMCRYPTO_KECCAK512, NIMCRYPTO_SHA3_224, NIMCRYPTO_SHA3_256, NIMCRYPTO_SHA3_384, NIMCRYPTO_SHA3_512, NIMCRYPTO_SHAKE128, NIMCRYPTO_SHAKE256 |
  | misc | kangarootwelve | KANGAROO_TWELVE |
  | misc | nimhash | NIM_MD5, NIM_SHA1 |
  | misc | sha3 | KECCAK224, KECCAK256, KECCAK384, KECCAK512, SHA3_224, SHA3_256, SHA3_384, SHA3_512, SHAKE128, SHAKE256 |
  | misc | tinysha3 | TINY_SHA3_224, TINY_SHA3_256, TINY_SHA3_384, TINY_SHA3_512, TINY_SHAKE128, TINY_SHAKE256 |
  | misc | tinyshabal | TINY_SHABAL192, TINY_SHABAL224, TINY_SHABAL256, TINY_SHABAL384, TINY_SHABAL512 |
  | misc | xxhash | XXHASH32, XXHASH64, XXHASH3_64, XXHASH3_128 |

  | Module | Hashes |
  | ------ | ------ |
  | gcrypt | GCRYPT_BLAKE2S_128, GCRYPT_BLAKE2S_160, GCRYPT_BLAKE2S_224, GCRYPT_BLAKE2S_256, GCRYPT_BLAKE2B_160, GCRYPT_BLAKE2B_256, GCRYPT_BLAKE2B_384, GCRYPT_BLAKE2B_512, GCRYPT_CRC32, GCRYPT_CRC32_RFC1510, GCRYPT_CRC24_RFC2440, GCRYPT_GOST, GCRYPT_GOSTPRO, GCRYPT_MD4, GCRYPT_MD5, GCRYPT_RIPEMD160, GCRYPT_SHA1, GCRYPT_SHA512, GCRYPT_SHA224, GCRYPT_SHA256, GCRYPT_SHA384, GCRYPT_SHA3_224, GCRYPT_SHA3_256, GCRYPT_SHA3_384, GCRYPT_SHA3_512, GCRYPT_STREEBOG256, GCRYPT_STREEBOG512, GCRYPT_GOST2012_256, GCRYPT_GOST2012_512, GCRYPT_TIGER, GCRYPT_TIGER1, GCRYPT_TIGER2, GCRYPT_WHIRLPOOL, GCRYPT_SHAKE128, GCRYPT_SHAKE256 |
  | lean | RHASH_CRC32, RHASH_CRC32C, RHASH_MD5, RHASH_SHA1, RHASH_SHA224, RHASH_SHA256, KECCAK224, KECCAK256, KECCAK384, KECCAK512, SHA3_224, SHA3_256, SHA3_384, SHA3_512, SHAKE128, SHAKE256, XXHASH32, XXHASH64, XXHASH3_64, XXHASH3_128 |

</details>

## Benchmark

```
Intel Core i7-8700, 16G DDR4 SDRAM
Nim Compiler Version 1.2.0 [Windows: amd64]
gcc version 10.1.0 (Rev2, Built by MSYS2 project)
```

`nimble all_bench`

<details>

  <summary>Details</summary>

  | Name | Speed |
  | :----| ----: |
  | MEMORY_COPY | 12832.029 MB/s |
  | GCRYPT_BLAKE2S_128 | 622.712 MB/s |
  | GCRYPT_BLAKE2S_160 | 628.243 MB/s |
  | GCRYPT_BLAKE2S_224 | 628.358 MB/s |
  | GCRYPT_BLAKE2S_256 | 628.334 MB/s |
  | GCRYPT_BLAKE2B_160 | 1020.794 MB/s |
  | GCRYPT_BLAKE2B_256 | 1019.898 MB/s |
  | GCRYPT_BLAKE2B_384 | 1020.346 MB/s |
  | GCRYPT_BLAKE2B_512 | 1020.616 MB/s |
  | GCRYPT_CRC32 | 16846.361 MB/s |
  | GCRYPT_CRC32_RFC1510 | 17717.931 MB/s |
  | GCRYPT_CRC24_RFC2440 | 16412.276 MB/s |
  | GCRYPT_GOST | 57.804 MB/s |
  | GCRYPT_GOSTPRO | 57.153 MB/s |
  | GCRYPT_MD4 | 1379.786 MB/s |
  | GCRYPT_MD5 | 780.110 MB/s |
  | GCRYPT_RIPEMD160 | 494.910 MB/s |
  | GCRYPT_SHA1 | 1104.924 MB/s |
  | GCRYPT_SHA512 | 695.154 MB/s |
  | GCRYPT_SHA224 | 481.515 MB/s |
  | GCRYPT_SHA256 | 481.793 MB/s |
  | GCRYPT_SHA384 | 695.957 MB/s |
  | GCRYPT_SHA3_224 | 501.060 MB/s |
  | GCRYPT_SHA3_256 | 471.950 MB/s |
  | GCRYPT_SHA3_384 | 361.849 MB/s |
  | GCRYPT_SHA3_512 | 252.960 MB/s |
  | GCRYPT_STREEBOG256 | 142.061 MB/s |
  | GCRYPT_STREEBOG512 | 142.253 MB/s |
  | GCRYPT_GOST2012_256 | 142.001 MB/s |
  | GCRYPT_GOST2012_512 | 141.977 MB/s |
  | GCRYPT_TIGER | 740.735 MB/s |
  | GCRYPT_TIGER1 | 740.593 MB/s |
  | GCRYPT_TIGER2 | 741.207 MB/s |
  | GCRYPT_WHIRLPOOL | 292.381 MB/s |
  | GCRYPT_SHAKE128 | 581.304 MB/s |
  | GCRYPT_SHAKE256 | 472.293 MB/s |
  | MHASH_ADLER32 | 744.585 MB/s |
  | MHASH_CRC32 | 448.916 MB/s |
  | MHASH_CRC32B | 501.668 MB/s |
  | MHASH_GOST | 76.759 MB/s |
  | MHASH_HAVAL128_3 | 900.552 MB/s |
  | MHASH_HAVAL128_4 | 606.619 MB/s |
  | MHASH_HAVAL128_5 | 505.628 MB/s |
  | MHASH_HAVAL160_3 | 888.439 MB/s |
  | MHASH_HAVAL160_4 | 607.024 MB/s |
  | MHASH_HAVAL160_5 | 507.189 MB/s |
  | MHASH_HAVAL192_3 | 898.771 MB/s |
  | MHASH_HAVAL192_4 | 607.135 MB/s |
  | MHASH_HAVAL192_5 | 507.097 MB/s |
  | MHASH_HAVAL224_3 | 901.965 MB/s |
  | MHASH_HAVAL224_4 | 606.208 MB/s |
  | MHASH_HAVAL224_5 | 504.195 MB/s |
  | MHASH_HAVAL256_3 | 901.136 MB/s |
  | MHASH_HAVAL256_4 | 607.437 MB/s |
  | MHASH_HAVAL256_5 | 507.259 MB/s |
  | MHASH_MD2 | 12.578 MB/s |
  | MHASH_MD4 | 1213.312 MB/s |
  | MHASH_MD5 | 742.038 MB/s |
  | MHASH_RIPEMD128 | 675.256 MB/s |
  | MHASH_RIPEMD160 | 409.326 MB/s |
  | MHASH_RIPEMD256 | 579.539 MB/s |
  | MHASH_RIPEMD320 | 379.713 MB/s |
  | MHASH_SHA1 | 693.308 MB/s |
  | MHASH_SHA224 | 212.474 MB/s |
  | MHASH_SHA256 | 213.506 MB/s |
  | MHASH_SHA384 | 338.561 MB/s |
  | MHASH_SHA512 | 338.696 MB/s |
  | MHASH_SNEFRU128 | 47.306 MB/s |
  | MHASH_SNEFRU256 | 31.432 MB/s |
  | MHASH_TIGER | 726.406 MB/s |
  | MHASH_TIGER128 | 728.247 MB/s |
  | MHASH_TIGER160 | 728.513 MB/s |
  | MHASH_WHIRLPOOL | 179.830 MB/s |
  | RHASH_SHA1 | 207.189 MB/s |
  | RHASH_AICH | 206.913 MB/s |
  | RHASH_CRC32 | 2171.034 MB/s |
  | RHASH_CRC32C | 10251.153 MB/s |
  | RHASH_MD4 | 1321.196 MB/s |
  | RHASH_ED2K | 1321.737 MB/s |
  | RHASH_EDONR224 | 995.827 MB/s |
  | RHASH_EDONR256 | 996.393 MB/s |
  | RHASH_EDONR384 | 2076.196 MB/s |
  | RHASH_EDONR512 | 2077.447 MB/s |
  | RHASH_GOST94 | 76.811 MB/s |
  | RHASH_GOST94PRO | 76.974 MB/s |
  | RHASH_HAS160 | 995.907 MB/s |
  | RHASH_MD5 | 775.116 MB/s |
  | RHASH_RIPEMD160 | 329.032 MB/s |
  | RHASH_SHA224 | 272.976 MB/s |
  | RHASH_SHA256 | 273.380 MB/s |
  | RHASH_KECCAK224 | 335.654 MB/s |
  | RHASH_KECCAK256 | 317.188 MB/s |
  | RHASH_KECCAK384 | 242.849 MB/s |
  | RHASH_KECCAK512 | 168.696 MB/s |
  | RHASH_SHA3_224 | 335.662 MB/s |
  | RHASH_SHA3_256 | 317.003 MB/s |
  | RHASH_SHA3_384 | 242.940 MB/s |
  | RHASH_SHA3_512 | 168.896 MB/s |
  | RHASH_SHA384 | 471.274 MB/s |
  | RHASH_SHA512 | 471.251 MB/s |
  | RHASH_SNEFRU128 | 55.563 MB/s |
  | RHASH_SNEFRU256 | 36.936 MB/s |
  | RHASH_GOST2012_256 | 141.778 MB/s |
  | RHASH_GOST2012_512 | 141.898 MB/s |
  | RHASH_STREEBOG256 | 141.774 MB/s |
  | RHASH_STREEBOG512 | 141.613 MB/s |
  | RHASH_TIGER | 770.185 MB/s |
  | RHASH_TTH | 645.682 MB/s |
  | SPH_BLAKE224 | 395.869 MB/s |
  | SPH_BLAKE256 | 394.580 MB/s |
  | SPH_BLAKE384 | 663.768 MB/s |
  | SPH_BLAKE512 | 666.236 MB/s |
  | SPH_BMW224 | 526.252 MB/s |
  | SPH_BMW256 | 522.171 MB/s |
  | SPH_BMW384 | 1136.260 MB/s |
  | SPH_BMW512 | 1138.667 MB/s |
  | SPH_CUBEHASH224 | 170.440 MB/s |
  | SPH_CUBEHASH256 | 170.267 MB/s |
  | SPH_CUBEHASH384 | 170.451 MB/s |
  | SPH_CUBEHASH512 | 170.312 MB/s |
  | SPH_ECHO224 | 170.155 MB/s |
  | SPH_ECHO256 | 170.220 MB/s |
  | SPH_ECHO384 | 86.824 MB/s |
  | SPH_ECHO512 | 87.691 MB/s |
  | SPH_FUGUE224 | 171.141 MB/s |
  | SPH_FUGUE256 | 170.973 MB/s |
  | SPH_FUGUE384 | 113.776 MB/s |
  | SPH_FUGUE512 | 86.328 MB/s |
  | SPH_GROESTL224 | 166.418 MB/s |
  | SPH_GROESTL256 | 165.883 MB/s |
  | SPH_GROESTL384 | 108.884 MB/s |
  | SPH_GROESTL512 | 108.750 MB/s |
  | SPH_HAMSI224 | 89.133 MB/s |
  | SPH_HAMSI256 | 89.579 MB/s |
  | SPH_HAMSI384 | 29.249 MB/s |
  | SPH_HAMSI512 | 29.390 MB/s |
  | SPH_HAVAL128_3 | 877.055 MB/s |
  | SPH_HAVAL128_4 | 587.741 MB/s |
  | SPH_HAVAL128_5 | 498.497 MB/s |
  | SPH_HAVAL160_3 | 887.406 MB/s |
  | SPH_HAVAL160_4 | 591.072 MB/s |
  | SPH_HAVAL160_5 | 499.323 MB/s |
  | SPH_HAVAL192_3 | 893.527 MB/s |
  | SPH_HAVAL192_4 | 592.814 MB/s |
  | SPH_HAVAL192_5 | 501.283 MB/s |
  | SPH_HAVAL224_3 | 893.655 MB/s |
  | SPH_HAVAL224_4 | 593.197 MB/s |
  | SPH_HAVAL224_5 | 501.276 MB/s |
  | SPH_HAVAL256_3 | 893.687 MB/s |
  | SPH_HAVAL256_4 | 593.268 MB/s |
  | SPH_HAVAL256_5 | 501.143 MB/s |
  | SPH_JH224 | 92.835 MB/s |
  | SPH_JH256 | 93.233 MB/s |
  | SPH_JH384 | 93.239 MB/s |
  | SPH_JH512 | 92.855 MB/s |
  | SPH_KECCAK224 | 341.654 MB/s |
  | SPH_KECCAK256 | 322.773 MB/s |
  | SPH_KECCAK384 | 247.248 MB/s |
  | SPH_KECCAK512 | 173.630 MB/s |
  | SPH_SHA3_224 | 340.566 MB/s |
  | SPH_SHA3_256 | 321.794 MB/s |
  | SPH_SHA3_384 | 246.112 MB/s |
  | SPH_SHA3_512 | 173.703 MB/s |
  | SPH_LUFFA224 | 222.853 MB/s |
  | SPH_LUFFA256 | 223.132 MB/s |
  | SPH_LUFFA384 | 167.544 MB/s |
  | SPH_LUFFA512 | 124.650 MB/s |
  | SPH_MD2 | 8.493 MB/s |
  | SPH_MD4 | 1321.737 MB/s |
  | SPH_MD5 | 771.772 MB/s |
  | SPH_PANAMA | 1858.874 MB/s |
  | SPH_RADIOGATUN32 | 689.394 MB/s |
  | SPH_RADIOGATUN64 | 1367.035 MB/s |
  | SPH_RIPEMD | 651.954 MB/s |
  | SPH_RIPEMD128 | 497.574 MB/s |
  | SPH_RIPEMD160 | 326.583 MB/s |
  | SPH_SHA0 | 761.076 MB/s |
  | SPH_SHA1 | 687.782 MB/s |
  | SPH_SHA224 | 262.055 MB/s |
  | SPH_SHA256 | 261.094 MB/s |
  | SPH_SHA384 | 500.553 MB/s |
  | SPH_SHA512 | 500.616 MB/s |
  | SPH_SHABAL192 | 718.716 MB/s |
  | SPH_SHABAL224 | 720.440 MB/s |
  | SPH_SHABAL256 | 716.055 MB/s |
  | SPH_SHABAL384 | 716.779 MB/s |
  | SPH_SHABAL512 | 720.918 MB/s |
  | SPH_SHAVITE224 | 286.701 MB/s |
  | SPH_SHAVITE256 | 287.189 MB/s |
  | SPH_SHAVITE384 | 178.625 MB/s |
  | SPH_SHAVITE512 | 179.425 MB/s |
  | SPH_SIMD224 | 154.389 MB/s |
  | SPH_SIMD256 | 154.313 MB/s |
  | SPH_SIMD384 | 135.536 MB/s |
  | SPH_SIMD512 | 135.496 MB/s |
  | SPH_SKEIN224 | 731.481 MB/s |
  | SPH_SKEIN256 | 731.791 MB/s |
  | SPH_SKEIN384 | 731.984 MB/s |
  | SPH_SKEIN512 | 732.011 MB/s |
  | SPH_TIGER | 723.458 MB/s |
  | SPH_TIGER2 | 719.730 MB/s |
  | SPH_WHIRLPOOL | 191.595 MB/s |
  | SPH_WHIRLPOOL0 | 190.070 MB/s |
  | SPH_WHIRLPOOL1 | 191.610 MB/s |
  | BLAKE2S_224 | 784.142 MB/s |
  | BLAKE2S_256 | 783.496 MB/s |
  | BLAKE2B_384 | 1030.577 MB/s |
  | BLAKE2B_512 | 1045.555 MB/s |
  | BLAKE3 | 3161.655 MB/s |
  | BLAKE3_128 | 3205.950 MB/s |
  | BLAKE3_160 | 3221.442 MB/s |
  | BLAKE3_192 | 3257.223 MB/s |
  | BLAKE3_224 | 3230.287 MB/s |
  | BLAKE3_256 | 3249.074 MB/s |
  | BLAKE3_384 | 3234.153 MB/s |
  | BLAKE3_512 | 3243.173 MB/s |
  | NIMCRYPTO_SHA1 | 642.170 MB/s |
  | NIMCRYPTO_SHA224 | 268.603 MB/s |
  | NIMCRYPTO_SHA256 | 268.705 MB/s |
  | NIMCRYPTO_SHA384 | 417.258 MB/s |
  | NIMCRYPTO_SHA512 | 419.078 MB/s |
  | NIMCRYPTO_SHA512_224 | 418.683 MB/s |
  | NIMCRYPTO_SHA512_256 | 417.519 MB/s |
  | NIMCRYPTO_RIPEMD128 | 483.505 MB/s |
  | NIMCRYPTO_RIPEMD160 | 318.973 MB/s |
  | NIMCRYPTO_RIPEMD256 | 561.877 MB/s |
  | NIMCRYPTO_RIPEMD320 | 372.492 MB/s |
  | NIMCRYPTO_BLAKE2S_224 | 208.432 MB/s |
  | NIMCRYPTO_BLAKE2S_256 | 208.728 MB/s |
  | NIMCRYPTO_BLAKE2B_384 | 291.281 MB/s |
  | NIMCRYPTO_BLAKE2B_512 | 292.888 MB/s |
  | NIMCRYPTO_KECCAK224 | 154.401 MB/s |
  | NIMCRYPTO_KECCAK256 | 146.087 MB/s |
  | NIMCRYPTO_KECCAK384 | 115.611 MB/s |
  | NIMCRYPTO_KECCAK512 | 81.163 MB/s |
  | NIMCRYPTO_SHA3_224 | 149.955 MB/s |
  | NIMCRYPTO_SHA3_256 | 146.956 MB/s |
  | NIMCRYPTO_SHA3_384 | 113.737 MB/s |
  | NIMCRYPTO_SHA3_512 | 82.342 MB/s |
  | NIMCRYPTO_SHAKE128 | 175.793 MB/s |
  | NIMCRYPTO_SHAKE256 | 146.929 MB/s |
  | KANGAROO_TWELVE | 786.040 MB/s |
  | NIM_MD5 | 578.182 MB/s |
  | NIM_SHA1 | 547.798 MB/s |
  | KECCAK224 | 358.977 MB/s |
  | KECCAK256 | 339.643 MB/s |
  | KECCAK384 | 260.442 MB/s |
  | KECCAK512 | 180.880 MB/s |
  | SHA3_224 | 359.340 MB/s |
  | SHA3_256 | 339.156 MB/s |
  | SHA3_384 | 260.399 MB/s |
  | SHA3_512 | 181.007 MB/s |
  | SHAKE128 | 419.043 MB/s |
  | SHAKE256 | 338.786 MB/s |
  | TINY_SHA3_224 | 155.440 MB/s |
  | TINY_SHA3_256 | 147.113 MB/s |
  | TINY_SHA3_384 | 106.315 MB/s |
  | TINY_SHA3_512 | 82.133 MB/s |
  | TINY_SHAKE128 | 179.626 MB/s |
  | TINY_SHAKE256 | 148.236 MB/s |
  | TINY_SHABAL192 | 493.854 MB/s |
  | TINY_SHABAL224 | 495.005 MB/s |
  | TINY_SHABAL256 | 494.428 MB/s |
  | TINY_SHABAL384 | 495.282 MB/s |
  | TINY_SHABAL512 | 495.133 MB/s |
  | XXHASH32 | 7688.759 MB/s |
  | XXHASH64 | 13670.540 MB/s |
  | XXHASH3_64 | 20712.510 MB/s |
  | XXHASH3_128 | 21376.657 MB/s |

</details>

## License

### Library and Source Codes

| Project | License |
| ------ | ------ |
| RHash | [BSD Zero Clause License](https://github.com/rhash/RHash/blob/master/COPYING) |
| MHash | GNU Lesser GPL |
| Sphlib | [MIT-like, BSD-like](https://github.com/aidansteele/sphlib/blob/master/LICENSE.txt) |
| XKCP | [Team Keccak XKCP License](https://github.com/XKCP/XKCP#under-which-license-is-the-xkcp-distributed) |
| BLAKE2 | CC0 |
| BLAKE3 | [CC0 1.0](https://github.com/BLAKE3-team/BLAKE3/blob/master/LICENSE) |
| tiny_sha3 | [MIT License](https://github.com/mjosaarinen/tiny_sha3/blob/master/LICENSE) |
| xxHash | [BSD 2-Clause](https://github.com/Cyan4973/xxHash/blob/dev/LICENSE) |
| libgcrypt | LGPLv2.1+ |

### Hashlib

Read license.txt for more details.
Copyright (c) 2020 Kai-Hung Chen, Ward. All rights reserved.
