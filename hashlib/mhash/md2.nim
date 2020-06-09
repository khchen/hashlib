#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns
export common

{.compile: "src/mhash_md2.c".}

proc md2_init(ctx: pointer) {.importc, cdecl.}
proc md2_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc md2_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  MHASH_MD2 = HashType[16, 16, 88, md2_init, md2_update, md2_digest, false]
