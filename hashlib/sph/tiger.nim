#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_tiger.c".}

proc sph_tiger_init(ctx: pointer) {.importc, cdecl.}
proc sph_tiger2_init(ctx: pointer) {.importc: "sph_tiger_init", cdecl.}

proc sph_tiger(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_tiger2(ctx: pointer, data: pointer, len: csize_t) {.importc: "sph_tiger", cdecl.}

proc sph_tiger_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_tiger2_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_TIGER = HashType[24, 64, 96, sph_tiger_init, sph_tiger, sph_tiger_close, false]
  SPH_TIGER2 = HashType[24, 64, 96, sph_tiger2_init, sph_tiger2, sph_tiger2_close, false]
