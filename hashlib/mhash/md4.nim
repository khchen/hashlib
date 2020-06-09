#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns
export common

{.compile: "src/mhash_md4.c".}

proc MD4Init(ctx: pointer) {.importc, cdecl.}
proc MD4Update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc MD4Final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  MHASH_MD4 = HashType[16, 64, 88, MD4Init, MD4Update, MD4Final, false]
