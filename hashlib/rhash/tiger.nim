#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/rhash_tiger.c".}
{.compile: "src/rhash_tiger_sbox.c".}

proc rhash_tiger_init(ctx: pointer) {.importc, cdecl.}
proc rhash_tiger_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc rhash_tiger_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_TIGER = HashType[24, 64, 104, rhash_tiger_init, rhash_tiger_update, rhash_tiger_final, false]
