#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_md2.c".}

proc sph_md2_init(ctx: pointer) {.importc, cdecl.}
proc sph_md2(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_md2_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_MD2 = HashType[16, 16, 88, sph_md2_init, sph_md2, sph_md2_close, false]
