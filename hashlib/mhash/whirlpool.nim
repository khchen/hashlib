#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns
export common

{.compile: "src/mhash_whirlpool.c".}

proc whirlpool_init(ctx: pointer) {.importc, cdecl.}
proc whirlpool_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc whirlpool_final(ctx: pointer) {.importc, cdecl.}
proc whirlpool_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc whirlpool_finaldigest(ctx: pointer, dst: pointer) {.cdecl.} =
  whirlpool_final(ctx)
  whirlpool_digest(ctx, dst)

hashRegister:
  MHASH_WHIRLPOOL = HashType[64, 64, 168, whirlpool_init, whirlpool_update, whirlpool_finaldigest, false]
