#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns
export common

{.compile: "src/mhash_snefru.c".}

proc snefru_init(ctx: pointer) {.importc, cdecl.}
proc snefru128_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc snefru256_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc snefru128_final(ctx: pointer) {.importc, cdecl.}
proc snefru256_final(ctx: pointer) {.importc, cdecl.}
proc snefru128_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc snefru256_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}

proc snefru128_finaldigest(ctx: pointer, dst: pointer) {.cdecl.} =
  snefru128_final(ctx)
  snefru128_digest(ctx, dst)

proc snefru256_finaldigest(ctx: pointer, dst: pointer) {.cdecl.} =
  snefru256_final(ctx)
  snefru256_digest(ctx, dst)

hashRegister:
  MHASH_SNEFRU128 = HashType[16, 48, 128, snefru_init, snefru128_update, snefru128_finaldigest, false]
  MHASH_SNEFRU256 = HashType[32, 48, 128, snefru_init, snefru256_update, snefru256_finaldigest, false]
