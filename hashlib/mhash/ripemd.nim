#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns
export common

{.compile: "src/mhash_ripemd.c".}

proc ripemd128_init(ctx: pointer) {.importc, cdecl.}
proc ripemd160_init(ctx: pointer) {.importc, cdecl.}
proc ripemd256_init(ctx: pointer) {.importc, cdecl.}
proc ripemd320_init(ctx: pointer) {.importc, cdecl.}
proc ripemd_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc ripemd_final(ctx: pointer) {.importc, cdecl.}
proc ripemd_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc ripemd_finaldigest(ctx: pointer, dst: pointer) {.cdecl.} =
  ripemd_final(ctx)
  ripemd_digest(ctx, dst)

hashRegister:
  MHASH_RIPEMD128 = HashType[16, 64, 120, ripemd128_init, ripemd_update, ripemd_finaldigest, false]
  MHASH_RIPEMD160 = HashType[20, 64, 120, ripemd160_init, ripemd_update, ripemd_finaldigest, false]
  MHASH_RIPEMD256 = HashType[32, 64, 120, ripemd256_init, ripemd_update, ripemd_finaldigest, false]
  MHASH_RIPEMD320 = HashType[40, 64, 120, ripemd320_init, ripemd_update, ripemd_finaldigest, false]
