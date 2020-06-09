#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/byte_order
export common

{.compile: "src/rhash_sha512.c".}

proc rhash_sha384_init(ctx: pointer) {.importc, cdecl.}
proc rhash_sha512_init(ctx: pointer) {.importc, cdecl.}

proc rhash_sha384_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_sha512_update", cdecl.}
proc rhash_sha512_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc rhash_sha384_final(ctx: pointer, dst: pointer) {.importc: "rhash_sha512_final", cdecl.}
proc rhash_sha512_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_SHA384 = HashType[48, 128, 208, rhash_sha384_init, rhash_sha384_update, rhash_sha384_final, false]
  RHASH_SHA512 = HashType[64, 128, 208, rhash_sha512_init, rhash_sha512_update, rhash_sha512_final, false]
