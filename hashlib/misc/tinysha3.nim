#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/tiny_sha3.c".}

proc sha3_init(ctx: pointer, len: cint) {.importc, cdecl.}
proc sha3_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sha3_final(dst: pointer, ctx: pointer) {.importc, cdecl.}
proc shake_xof(ctx: pointer) {.importc, cdecl.}
proc shake_out(ctx: pointer, dst: pointer, len: csize_t) {.importc, cdecl.}

proc tiny_sha3_224_init(ctx: pointer) {.cdecl.} = sha3_init(ctx, 28)
proc tiny_sha3_256_init(ctx: pointer) {.cdecl.} = sha3_init(ctx, 32)
proc tiny_sha3_384_init(ctx: pointer) {.cdecl.} = sha3_init(ctx, 48)
proc tiny_sha3_512_init(ctx: pointer) {.cdecl.} = sha3_init(ctx, 64)
proc tiny_shake128_init(ctx: pointer) {.cdecl.} = sha3_init(ctx, 16)
proc tiny_shake256_init(ctx: pointer) {.cdecl.} = sha3_init(ctx, 32)

proc tiny_sha3_final(ctx: pointer, dst: pointer) {.cdecl.} = sha3_final(dst, ctx)
proc tiny_shake_final(ctx: pointer, dst: pointer, len: csize_t) {.cdecl.} =
  shake_xof(ctx)
  shake_out(ctx, dst, len)

hashRegister:
  TINY_SHA3_224 = HashType[28, 144, 216, tiny_sha3_224_init, sha3_update, tiny_sha3_final, false]
  TINY_SHA3_256 = HashType[32, 136, 216, tiny_sha3_256_init, sha3_update, tiny_sha3_final, false]
  TINY_SHA3_384 = HashType[48, 104, 216, tiny_sha3_384_init, sha3_update, tiny_sha3_final, false]
  TINY_SHA3_512 = HashType[64, 72, 216, tiny_sha3_512_init, sha3_update, tiny_sha3_final, false]
  TINY_SHAKE128 = HashType[16, 168, 216, tiny_shake128_init, sha3_update, tiny_shake_final, true]
  TINY_SHAKE256 = HashType[32, 136, 216, tiny_shake256_init, sha3_update, tiny_shake_final, true]
