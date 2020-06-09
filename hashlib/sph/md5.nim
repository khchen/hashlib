#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_md5.c".}

proc sph_md5_init(ctx: pointer) {.importc, cdecl.}
proc sph_md5(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_md5_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_MD5 = HashType[16, 64, 88, sph_md5_init, sph_md5, sph_md5_close, false]
