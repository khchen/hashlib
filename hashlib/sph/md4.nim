#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_md4.c".}

proc sph_md4_init(ctx: pointer) {.importc, cdecl.}
proc sph_md4(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_md4_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_MD4 = HashType[16, 64, 88, sph_md4_init, sph_md4, sph_md4_close, false]
