#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/byte_order
export common

{.compile: "src/rhash_sha256.c".}

proc rhash_sha224_init(ctx: pointer) {.importc, cdecl.}
proc rhash_sha256_init(ctx: pointer) {.importc, cdecl.}

proc rhash_sha224_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_sha256_update", cdecl.}
proc rhash_sha256_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc rhash_sha224_final(ctx: pointer, dst: pointer) {.importc: "rhash_sha256_final", cdecl.}
proc rhash_sha256_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_SHA224 = HashType[28, 64, 112, rhash_sha224_init, rhash_sha224_update, rhash_sha224_final, false]
  RHASH_SHA256 = HashType[32, 64, 112, rhash_sha256_init, rhash_sha256_update, rhash_sha256_final, false]
