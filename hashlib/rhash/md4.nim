#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/rhash_md4.c".}

proc rhash_md4_init(ctx: pointer) {.importc, cdecl.}
proc rhash_md4_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc rhash_md4_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_MD4 = HashType[16, 64, 88, rhash_md4_init, rhash_md4_update, rhash_md4_final, false]
