#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns
export common

{.compile: "src/mhash_haval.c".}

proc havalInit(ctx: pointer, passes: int32, length: int32) {.importc, cdecl.}
proc havalUpdate(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc havalFinal(ctx: pointer, dst: pointer) {.importc, cdecl.}

proc havalInit128_3(ctx: pointer) {.cdecl.} = havalInit(ctx, 3, 128)
proc havalInit128_4(ctx: pointer) {.cdecl.} = havalInit(ctx, 4, 128)
proc havalInit128_5(ctx: pointer) {.cdecl.} = havalInit(ctx, 5, 128)
proc havalInit160_3(ctx: pointer) {.cdecl.} = havalInit(ctx, 3, 160)
proc havalInit160_4(ctx: pointer) {.cdecl.} = havalInit(ctx, 4, 160)
proc havalInit160_5(ctx: pointer) {.cdecl.} = havalInit(ctx, 5, 160)
proc havalInit192_3(ctx: pointer) {.cdecl.} = havalInit(ctx, 3, 192)
proc havalInit192_4(ctx: pointer) {.cdecl.} = havalInit(ctx, 4, 192)
proc havalInit192_5(ctx: pointer) {.cdecl.} = havalInit(ctx, 5, 192)
proc havalInit224_3(ctx: pointer) {.cdecl.} = havalInit(ctx, 3, 224)
proc havalInit224_4(ctx: pointer) {.cdecl.} = havalInit(ctx, 4, 224)
proc havalInit224_5(ctx: pointer) {.cdecl.} = havalInit(ctx, 5, 224)
proc havalInit256_3(ctx: pointer) {.cdecl.} = havalInit(ctx, 3, 256)
proc havalInit256_4(ctx: pointer) {.cdecl.} = havalInit(ctx, 4, 256)
proc havalInit256_5(ctx: pointer) {.cdecl.} = havalInit(ctx, 5, 256)

hashRegister:
  MHASH_HAVAL128_3 = HashType[16, 128, 208, havalInit128_3, havalUpdate, havalFinal, false]
  MHASH_HAVAL128_4 = HashType[16, 128, 208, havalInit128_4, havalUpdate, havalFinal, false]
  MHASH_HAVAL128_5 = HashType[16, 128, 208, havalInit128_5, havalUpdate, havalFinal, false]
  MHASH_HAVAL160_3 = HashType[20, 128, 208, havalInit160_3, havalUpdate, havalFinal, false]
  MHASH_HAVAL160_4 = HashType[20, 128, 208, havalInit160_4, havalUpdate, havalFinal, false]
  MHASH_HAVAL160_5 = HashType[20, 128, 208, havalInit160_5, havalUpdate, havalFinal, false]
  MHASH_HAVAL192_3 = HashType[24, 128, 208, havalInit192_3, havalUpdate, havalFinal, false]
  MHASH_HAVAL192_4 = HashType[24, 128, 208, havalInit192_4, havalUpdate, havalFinal, false]
  MHASH_HAVAL192_5 = HashType[24, 128, 208, havalInit192_5, havalUpdate, havalFinal, false]
  MHASH_HAVAL224_3 = HashType[28, 128, 208, havalInit224_3, havalUpdate, havalFinal, false]
  MHASH_HAVAL224_4 = HashType[28, 128, 208, havalInit224_4, havalUpdate, havalFinal, false]
  MHASH_HAVAL224_5 = HashType[28, 128, 208, havalInit224_5, havalUpdate, havalFinal, false]
  MHASH_HAVAL256_3 = HashType[32, 128, 208, havalInit256_3, havalUpdate, havalFinal, false]
  MHASH_HAVAL256_4 = HashType[32, 128, 208, havalInit256_4, havalUpdate, havalFinal, false]
  MHASH_HAVAL256_5 = HashType[32, 128, 208, havalInit256_5, havalUpdate, havalFinal, false]
