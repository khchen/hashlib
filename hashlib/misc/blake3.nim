#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.passc: "-DBLAKE3_NO_AVX512".}
{.compile: "src/blake3.c".}
{.compile: "src/blake3_dispatch.c".}
{.compile: "src/blake3_portable.c".}
{.compile: "src/blake3_sse41.c".}
{.compile: "src/blake3_avx2.c".}

proc blake3_hasher_init(ctx: pointer) {.importc, cdecl.}
proc blake3_hasher_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc blake3_hasher_finalize(ctx: pointer, dst: pointer, len: csize_t) {.importc, cdecl.}

proc blake3_hasher_final128(ctx: pointer, dst: pointer) {.cdecl.} = blake3_hasher_finalize(ctx, dst, 16)
proc blake3_hasher_final160(ctx: pointer, dst: pointer) {.cdecl.} = blake3_hasher_finalize(ctx, dst, 20)
proc blake3_hasher_final192(ctx: pointer, dst: pointer) {.cdecl.} = blake3_hasher_finalize(ctx, dst, 24)
proc blake3_hasher_final224(ctx: pointer, dst: pointer) {.cdecl.} = blake3_hasher_finalize(ctx, dst, 28)
proc blake3_hasher_final256(ctx: pointer, dst: pointer) {.cdecl.} = blake3_hasher_finalize(ctx, dst, 32)
proc blake3_hasher_final384(ctx: pointer, dst: pointer) {.cdecl.} = blake3_hasher_finalize(ctx, dst, 48)
proc blake3_hasher_final512(ctx: pointer, dst: pointer) {.cdecl.} = blake3_hasher_finalize(ctx, dst, 64)

hashRegister:
  BLAKE3 = HashType[32, 64, 1912, blake3_hasher_init, blake3_hasher_update, blake3_hasher_finalize, true]
  BLAKE3_128 = HashType[16, 64, 1912, blake3_hasher_init, blake3_hasher_update, blake3_hasher_final128, false]
  BLAKE3_160 = HashType[20, 64, 1912, blake3_hasher_init, blake3_hasher_update, blake3_hasher_final160, false]
  BLAKE3_192 = HashType[24, 64, 1912, blake3_hasher_init, blake3_hasher_update, blake3_hasher_final192, false]
  BLAKE3_224 = HashType[28, 64, 1912, blake3_hasher_init, blake3_hasher_update, blake3_hasher_final224, false]
  BLAKE3_256 = HashType[32, 64, 1912, blake3_hasher_init, blake3_hasher_update, blake3_hasher_final256, false]
  BLAKE3_384 = HashType[48, 64, 1912, blake3_hasher_init, blake3_hasher_update, blake3_hasher_final384, false]
  BLAKE3_512 = HashType[64, 64, 1912, blake3_hasher_init, blake3_hasher_update, blake3_hasher_final512, false]
