#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns
export common

{.compile: "src/mhash_sha512_sha384.c".}

proc sha384_init(ctx: pointer) {.importc, cdecl.}
proc sha512_init(ctx: pointer) {.importc, cdecl.}
proc sha512_sha384_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sha512_sha384_final(ctx: pointer) {.importc, cdecl.}
proc sha384_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sha512_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}

proc sha384_finaldigest(ctx: pointer, dst: pointer) {.cdecl.} =
  sha512_sha384_final(ctx)
  sha384_digest(ctx, dst)

proc sha512_finaldigest(ctx: pointer, dst: pointer) {.cdecl.} =
  sha512_sha384_final(ctx)
  sha512_digest(ctx, dst)

hashRegister:
  MHASH_SHA384 = HashType[48, 128, 216, sha384_init, sha512_sha384_update, sha384_finaldigest, false]
  MHASH_SHA512 = HashType[64, 128, 216, sha512_init, sha512_sha384_update, sha512_finaldigest, false]
