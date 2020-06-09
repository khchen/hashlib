#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns, endians
export common

{.compile: "src/mhash_crc32.c".}

proc mhash_clear_crc32(ctx: pointer) {.importc, cdecl.}
proc mhash_crc32(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc mhash_crc32b(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc mhash_get_crc32(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc mhash_get_crc32_swap(ctx: pointer, dst: pointer) {.cdecl.} =
  mhash_get_crc32(ctx, dst)
  swapEndian32(dst, dst)

hashRegister:
  MHASH_CRC32 = HashType[4, 4, 4, mhash_clear_crc32, mhash_crc32, mhash_get_crc32_swap, false]
  MHASH_CRC32B = HashType[4, 4, 4, mhash_clear_crc32, mhash_crc32b, mhash_get_crc32_swap, false]
