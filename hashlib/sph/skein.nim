#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_skein.c".}

proc sph_skein224_init(ctx: pointer) {.importc, cdecl.}
proc sph_skein256_init(ctx: pointer) {.importc, cdecl.}
proc sph_skein384_init(ctx: pointer) {.importc, cdecl.}
proc sph_skein512_init(ctx: pointer) {.importc, cdecl.}

proc sph_skein224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_skein256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_skein384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_skein512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_skein224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_skein256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_skein384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_skein512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_SKEIN224 = HashType[28, 32, 144, sph_skein224_init, sph_skein224, sph_skein224_close, false]
  SPH_SKEIN256 = HashType[32, 32, 144, sph_skein256_init, sph_skein256, sph_skein256_close, false]
  SPH_SKEIN384 = HashType[48, 64, 144, sph_skein384_init, sph_skein384, sph_skein384_close, false]
  SPH_SKEIN512 = HashType[64, 64, 144, sph_skein512_init, sph_skein512, sph_skein512_close, false]
