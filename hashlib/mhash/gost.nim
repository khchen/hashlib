#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns
export common

{.compile: "src/mhash_gost.c".}

proc gosthash_reset(ctx: pointer) {.importc, cdecl.}
proc gosthash_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc gosthash_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  MHASH_GOST = HashType[32, 32, 132, gosthash_reset, gosthash_update, gosthash_final, false]
