#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns
export common

{.compile: "src/mhash_sha256_sha224.c".}

proc sha224_init(ctx: pointer) {.importc, cdecl.}
proc sha256_init(ctx: pointer) {.importc, cdecl.}
proc sha256_sha224_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sha256_sha224_final(ctx: pointer) {.importc, cdecl.}
proc sha224_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sha256_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}

proc sha256_finaldigest(ctx: pointer, dst: pointer) {.cdecl.} =
  sha256_sha224_final(ctx)
  sha256_digest(ctx, dst)

proc sha224_finaldigest(ctx: pointer, dst: pointer) {.cdecl.} =
  sha256_sha224_final(ctx)
  sha224_digest(ctx, dst)

hashRegister:
  MHASH_SHA224 = HashType[28, 64, 112, sha224_init, sha256_sha224_update, sha224_finaldigest, false]
  MHASH_SHA256 = HashType[32, 64, 112, sha256_init, sha256_sha224_update, sha256_finaldigest, false]
