#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_fugue.c".}

proc sph_fugue224_init(ctx: pointer) {.importc, cdecl.}
proc sph_fugue256_init(ctx: pointer) {.importc, cdecl.}
proc sph_fugue384_init(ctx: pointer) {.importc, cdecl.}
proc sph_fugue512_init(ctx: pointer) {.importc, cdecl.}

proc sph_fugue224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_fugue256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_fugue384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_fugue512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_fugue224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_fugue256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_fugue384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_fugue512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_FUGUE224 = HashType[28, 30, 168, sph_fugue224_init, sph_fugue224, sph_fugue224_close, false]
  SPH_FUGUE256 = HashType[32, 30, 168, sph_fugue256_init, sph_fugue256, sph_fugue256_close, false]
  SPH_FUGUE384 = HashType[48, 36, 168, sph_fugue384_init, sph_fugue384, sph_fugue384_close, false]
  SPH_FUGUE512 = HashType[64, 36, 168, sph_fugue512_init, sph_fugue512, sph_fugue512_close, false]
