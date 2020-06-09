#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/byte_order
export common

{.compile: "src/rhash_sha1.c".}

proc rhash_sha1_init(ctx: pointer) {.importc, cdecl.}
proc rhash_sha1_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc rhash_sha1_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_SHA1 = HashType[20, 64, 96, rhash_sha1_init, rhash_sha1_update, rhash_sha1_final, false]
