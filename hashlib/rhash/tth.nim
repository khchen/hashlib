#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, tiger
export common

{.compile: "src/rhash_tth.c".}

proc rhash_tth_init(ctx: pointer) {.importc, cdecl.}
proc rhash_tth_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc rhash_tth_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_TTH = HashType[24, 64, 1648, rhash_tth_init, rhash_tth_update, rhash_tth_final, false]
