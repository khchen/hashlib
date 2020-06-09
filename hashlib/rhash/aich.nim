#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, sha1, src/byte_order
export common

{.compile: "src/rhash_aich.c".}

proc rhash_aich_init(ctx: pointer) {.importc, cdecl.}
proc rhash_aich_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc rhash_aich_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_AICH = HashType[20, 64, 144, rhash_aich_init, rhash_aich_update, rhash_aich_final, false]
