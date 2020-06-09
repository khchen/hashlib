#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, nimcrypto/[sha, sha2, ripemd, keccak, blake2]
export common

template defineHash(name: untyped, T: untyped, blockSize: int) =
  proc `name init`(ctx: pointer) {.cdecl.} =
    cast[var T](ctx).init()

  proc `name update`(ctx: pointer, data: pointer, len: csize_t) {.cdecl.} =
    cast[var T](ctx).update(toOpenArray(cast[cstring](data), 0, int len - 1))

  proc `name final`(ctx: pointer, digest: pointer) {.cdecl.} =
    var p = cast[ptr UncheckedArray[byte]](digest)
    discard cast[var T](ctx).finish(toOpenArray(p, 0, sizeDigest(T) - 1))

  hashRegister:
    name = HashType[sizeDigest(T), blockSize, sizeof(T), `name init`, `name update`, `name final`, false]

template defineXofHash(name: untyped, T: untyped, blockSize: int) =
  proc `name init`(ctx: pointer) {.cdecl.} =
    cast[var T](ctx).init()

  proc `name update`(ctx: pointer, data: pointer, len: csize_t) {.cdecl.} =
    cast[var T](ctx).update(toOpenArray(cast[cstring](data), 0, int len - 1))

  proc `name final`(ctx: pointer, digest: pointer, len: csize_t) {.cdecl.} =
    cast[var T](ctx).xof()
    var p = cast[ptr UncheckedArray[byte]](digest)
    discard cast[var T](ctx).output(toOpenArray(p, 0, sizeDigest(T) - 1))

  hashRegister:
    name = HashType[sizeDigest(T), blockSize, sizeof(T), `name init`, `name update`, `name final`, true]

defineHash(NIMCRYPTO_SHA1, sha1, 64)
defineHash(NIMCRYPTO_SHA224, sha224, 64)
defineHash(NIMCRYPTO_SHA256, sha256, 64)
defineHash(NIMCRYPTO_SHA384, sha384, 128)
defineHash(NIMCRYPTO_SHA512, sha512, 128)
defineHash(NIMCRYPTO_SHA512_224, sha512_224, 128)
defineHash(NIMCRYPTO_SHA512_256, sha512_256, 128)
defineHash(NIMCRYPTO_RIPEMD128, ripemd128, 64)
defineHash(NIMCRYPTO_RIPEMD160, ripemd160, 64)
defineHash(NIMCRYPTO_RIPEMD256, ripemd256, 64)
defineHash(NIMCRYPTO_RIPEMD320, ripemd320, 64)
defineHash(NIMCRYPTO_BLAKE2S_224, blake2_224, 64)
defineHash(NIMCRYPTO_BLAKE2S_256, blake2_256, 64)
defineHash(NIMCRYPTO_BLAKE2B_384, blake2_384, 128)
defineHash(NIMCRYPTO_BLAKE2B_512, blake2_512, 128)
defineHash(NIMCRYPTO_KECCAK224, keccak224, 144)
defineHash(NIMCRYPTO_KECCAK256, keccak256, 136)
defineHash(NIMCRYPTO_KECCAK384, keccak384, 104)
defineHash(NIMCRYPTO_KECCAK512, keccak512, 72)
defineHash(NIMCRYPTO_SHA3_224, sha3_224, 144)
defineHash(NIMCRYPTO_SHA3_256, sha3_256, 136)
defineHash(NIMCRYPTO_SHA3_384, sha3_384, 104)
defineHash(NIMCRYPTO_SHA3_512, sha3_512, 72)
defineXofHash(NIMCRYPTO_SHAKE128, shake128, 168)
defineXofHash(NIMCRYPTO_SHAKE256, shake256, 136)
