#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/shabal_tiny.c".}

proc shabal_init(ctx: pointer, bits: cint) {.importc, cdecl.}
proc shabal(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc shabal_close(ctx: pointer, bits: cint, n: cint, dst: pointer) {.importc, cdecl.}

proc tiny_shabal_192_init(ctx: pointer) {.cdecl.} = shabal_init(ctx, 192)
proc tiny_shabal_224_init(ctx: pointer) {.cdecl.} = shabal_init(ctx, 224)
proc tiny_shabal_256_init(ctx: pointer) {.cdecl.} = shabal_init(ctx, 256)
proc tiny_shabal_384_init(ctx: pointer) {.cdecl.} = shabal_init(ctx, 384)
proc tiny_shabal_512_init(ctx: pointer) {.cdecl.} = shabal_init(ctx, 512)

proc tiny_shabal_192_final(ctx: pointer, dst: pointer) {.cdecl.} = shabal_close(ctx, 192, 0, dst)
proc tiny_shabal_224_final(ctx: pointer, dst: pointer) {.cdecl.} = shabal_close(ctx, 224, 0, dst)
proc tiny_shabal_256_final(ctx: pointer, dst: pointer) {.cdecl.} = shabal_close(ctx, 256, 0, dst)
proc tiny_shabal_384_final(ctx: pointer, dst: pointer) {.cdecl.} = shabal_close(ctx, 384, 0, dst)
proc tiny_shabal_512_final(ctx: pointer, dst: pointer) {.cdecl.} = shabal_close(ctx, 512, 0, dst)

hashRegister:
  TINY_SHABAL192 = HashType[24, 64, 264, tiny_shabal_192_init, shabal, tiny_shabal_192_final, false]
  TINY_SHABAL224 = HashType[28, 64, 264, tiny_shabal_224_init, shabal, tiny_shabal_224_final, false]
  TINY_SHABAL256 = HashType[32, 64, 264, tiny_shabal_256_init, shabal, tiny_shabal_256_final, false]
  TINY_SHABAL384 = HashType[48, 64, 264, tiny_shabal_384_init, shabal, tiny_shabal_384_final, false]
  TINY_SHABAL512 = HashType[64, 64, 264, tiny_shabal_512_init, shabal, tiny_shabal_512_final, false]
