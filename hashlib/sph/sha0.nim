#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_sha0.c".}

proc sph_sha0_init(ctx: pointer) {.importc, cdecl.}
proc sph_sha0(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_sha0_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_SHA0 = HashType[20, 64, 96, sph_sha0_init, sph_sha0, sph_sha0_close, false]
