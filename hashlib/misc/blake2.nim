#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.passc: "-msse4.1 -mavx2".}
{.compile: "src/blake2s.c".}
{.compile: "src/blake2b.c".}

proc blake2s_init(ctx: pointer, len: csize_t) {.importc, cdecl.}
proc blake2b_init(ctx: pointer, len: csize_t) {.importc, cdecl.}
proc blake2b_final(ctx: pointer, dst: pointer, len: csize_t) {.importc, cdecl.}
proc blake2s_final(ctx: pointer, dst: pointer, len: csize_t) {.importc, cdecl.}

proc blake2_224_init(ctx: pointer) {.cdecl.} = blake2s_init(ctx, 28)
proc blake2_256_init(ctx: pointer) {.cdecl.} = blake2s_init(ctx, 32)
proc blake2_384_init(ctx: pointer) {.cdecl.} = blake2b_init(ctx, 48)
proc blake2_512_init(ctx: pointer) {.cdecl.} = blake2b_init(ctx, 64)

proc blake2_224_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "blake2s_update", cdecl.}
proc blake2_256_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "blake2s_update", cdecl.}
proc blake2_384_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "blake2b_update", cdecl.}
proc blake2_512_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "blake2b_update", cdecl.}

proc blake2_224_final(ctx: pointer, dst: pointer) {.cdecl.} = blake2s_final(ctx, dst, 28)
proc blake2_256_final(ctx: pointer, dst: pointer) {.cdecl.} = blake2s_final(ctx, dst, 32)
proc blake2_384_final(ctx: pointer, dst: pointer) {.cdecl.} = blake2b_final(ctx, dst, 48)
proc blake2_512_final(ctx: pointer, dst: pointer) {.cdecl.} = blake2b_final(ctx, dst, 64)

hashRegister:
  BLAKE2S_224 = HashType[28, 64, 136, blake2_224_init, blake2_224_update, blake2_224_final, false]
  BLAKE2S_256 = HashType[32, 64, 136, blake2_256_init, blake2_256_update, blake2_256_final, false]
  BLAKE2B_384 = HashType[48, 128, 248, blake2_384_init, blake2_384_update, blake2_384_final, false]
  BLAKE2B_512 = HashType[64, 128, 248, blake2_512_init, blake2_512_update, blake2_512_final, false]
