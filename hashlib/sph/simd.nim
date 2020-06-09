#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_simd.c".}

proc sph_simd224_init(ctx: pointer) {.importc, cdecl.}
proc sph_simd256_init(ctx: pointer) {.importc, cdecl.}
proc sph_simd384_init(ctx: pointer) {.importc, cdecl.}
proc sph_simd512_init(ctx: pointer) {.importc, cdecl.}

proc sph_simd224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_simd256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_simd384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_simd512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_simd224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_simd256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_simd384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_simd512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_SIMD224 = HashType[28, 64, 144, sph_simd224_init, sph_simd224, sph_simd224_close, false]
  SPH_SIMD256 = HashType[32, 64, 144, sph_simd256_init, sph_simd256, sph_simd256_close, false]
  SPH_SIMD384 = HashType[48, 128, 272, sph_simd384_init, sph_simd384, sph_simd384_close, false]
  SPH_SIMD512 = HashType[64, 128, 272, sph_simd512_init, sph_simd512, sph_simd512_close, false]
