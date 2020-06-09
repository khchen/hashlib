#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_whirlpool.c".}

proc sph_whirlpool_init(ctx: pointer) {.importc, cdecl.}
proc sph_whirlpool0_init(ctx: pointer) {.importc: "sph_whirlpool_init", cdecl.}
proc sph_whirlpool1_init(ctx: pointer) {.importc: "sph_whirlpool_init", cdecl.}

proc sph_whirlpool(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_whirlpool0(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_whirlpool1(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_whirlpool_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_whirlpool0_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_whirlpool1_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_WHIRLPOOL = HashType[64, 64, 136, sph_whirlpool_init, sph_whirlpool, sph_whirlpool_close, false]
  SPH_WHIRLPOOL0 = HashType[64, 64, 136, sph_whirlpool0_init, sph_whirlpool0, sph_whirlpool0_close, false]
  SPH_WHIRLPOOL1 = HashType[64, 64, 136, sph_whirlpool1_init, sph_whirlpool1, sph_whirlpool1_close, false]
