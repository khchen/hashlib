#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_bmw.c".}

proc sph_bmw224_init(ctx: pointer) {.importc, cdecl.}
proc sph_bmw256_init(ctx: pointer) {.importc, cdecl.}
proc sph_bmw384_init(ctx: pointer) {.importc, cdecl.}
proc sph_bmw512_init(ctx: pointer) {.importc, cdecl.}

proc sph_bmw224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_bmw256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_bmw384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_bmw512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_bmw224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_bmw256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_bmw384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_bmw512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_BMW224 = HashType[28, 64, 144, sph_bmw224_init, sph_bmw224, sph_bmw224_close, false]
  SPH_BMW256 = HashType[32, 64, 144, sph_bmw256_init, sph_bmw256, sph_bmw256_close, false]
  SPH_BMW384 = HashType[48, 128, 272, sph_bmw384_init, sph_bmw384, sph_bmw384_close, false]
  SPH_BMW512 = HashType[64, 128, 272, sph_bmw512_init, sph_bmw512, sph_bmw512_close, false]
