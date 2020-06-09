#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns
export common

{.compile: "src/mhash_sha1.c".}

proc mhash_sha_init(ctx: pointer) {.importc, cdecl.}
proc mhash_sha_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc mhash_sha_final(ctx: pointer) {.importc, cdecl.}
proc mhash_sha_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc mhash_sha_finaldigest(ctx: pointer, dst: pointer) {.cdecl.} =
  mhash_sha_final(ctx)
  mhash_sha_digest(ctx, dst)

hashRegister:
  MHASH_SHA1 = HashType[20, 64, 96, mhash_sha_init, mhash_sha_update, mhash_sha_finaldigest, false]
