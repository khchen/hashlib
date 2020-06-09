#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_ripemd.c".}

proc sph_ripemd_init(ctx: pointer) {.importc, cdecl.}
proc sph_ripemd128_init(ctx: pointer) {.importc, cdecl.}
proc sph_ripemd160_init(ctx: pointer) {.importc, cdecl.}

proc sph_ripemd(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_ripemd128(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_ripemd160(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_ripemd_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_ripemd128_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_ripemd160_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_RIPEMD = HashType[16, 64, 88, sph_ripemd_init, sph_ripemd, sph_ripemd_close, false]
  SPH_RIPEMD128 = HashType[16, 64, 88, sph_ripemd128_init, sph_ripemd128, sph_ripemd128_close, false]
  SPH_RIPEMD160 = HashType[20, 64, 96, sph_ripemd160_init, sph_ripemd160, sph_ripemd160_close, false]
