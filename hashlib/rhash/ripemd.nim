#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/rhash_ripemd-160.c".}

proc rhash_ripemd160_init(ctx: pointer) {.importc, cdecl.}
proc rhash_ripemd160_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc rhash_ripemd160_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_RIPEMD160 = HashType[20, 64, 96, rhash_ripemd160_init, rhash_ripemd160_update, rhash_ripemd160_final, false]
