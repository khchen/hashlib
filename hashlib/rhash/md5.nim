#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/rhash_md5.c".}

proc rhash_md5_init(ctx: pointer) {.importc, cdecl.}
proc rhash_md5_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc rhash_md5_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_MD5 = HashType[16, 64, 88, rhash_md5_init, rhash_md5_update, rhash_md5_final, false]
