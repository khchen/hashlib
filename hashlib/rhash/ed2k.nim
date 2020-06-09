#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, md4
export common

{.compile: "src/rhash_ed2k.c".}

proc rhash_ed2k_init(ctx: pointer) {.importc, cdecl.}
proc rhash_ed2k_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc rhash_ed2k_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_ED2K = HashType[16, 64, 184, rhash_ed2k_init, rhash_ed2k_update, rhash_ed2k_final, false]
