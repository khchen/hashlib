#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/rhash_has160.c".}

proc rhash_has160_init(ctx: pointer) {.importc, cdecl.}
proc rhash_has160_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc rhash_has160_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_HAS160 = HashType[20, 64, 96, rhash_has160_init, rhash_has160_update, rhash_has160_final, false]
