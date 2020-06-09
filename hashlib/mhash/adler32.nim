#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns, endians
export common

{.compile: "src/mhash_adler32.c".}

proc mhash_clear_adler32(ctx: pointer) {.importc, cdecl.}
proc mhash_adler32(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc mhash_get_adler32(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc mhash_get_adler32_swap(ctx: pointer, dst: pointer) {.cdecl.} =
  mhash_get_adler32(ctx, dst)
  swapEndian32(dst, dst)

hashRegister:
  MHASH_ADLER32 = HashType[4, 4, 4, mhash_clear_adler32, mhash_adler32, mhash_get_adler32_swap, false]
