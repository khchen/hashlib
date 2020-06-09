#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_shavite.c".}

proc sph_shavite224_init(ctx: pointer) {.importc, cdecl.}
proc sph_shavite256_init(ctx: pointer) {.importc, cdecl.}
proc sph_shavite384_init(ctx: pointer) {.importc, cdecl.}
proc sph_shavite512_init(ctx: pointer) {.importc, cdecl.}

proc sph_shavite224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_shavite256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_shavite384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_shavite512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_shavite224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_shavite256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_shavite384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_shavite512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_SHAVITE224 = HashType[28, 64, 112, sph_shavite224_init, sph_shavite224, sph_shavite224_close, false]
  SPH_SHAVITE256 = HashType[32, 64, 112, sph_shavite256_init, sph_shavite256, sph_shavite256_close, false]
  SPH_SHAVITE384 = HashType[48, 128, 216, sph_shavite384_init, sph_shavite384, sph_shavite384_close, false]
  SPH_SHAVITE512 = HashType[64, 128, 216, sph_shavite512_init, sph_shavite512, sph_shavite512_close, false]
