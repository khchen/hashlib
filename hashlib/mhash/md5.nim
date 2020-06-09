#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns
export common

{.compile: "src/mhash_md5.c".}

proc MD5Init(ctx: pointer) {.importc, cdecl.}
proc MD5Update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc MD5Final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  MHASH_MD5 = HashType[16, 64, 88, MD5Init, MD5Update, MD5Final, false]
