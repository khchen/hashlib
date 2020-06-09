#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_hamsi.c".}

proc sph_hamsi224_init(ctx: pointer) {.importc, cdecl.}
proc sph_hamsi256_init(ctx: pointer) {.importc, cdecl.}
proc sph_hamsi384_init(ctx: pointer) {.importc, cdecl.}
proc sph_hamsi512_init(ctx: pointer) {.importc, cdecl.}

proc sph_hamsi224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_hamsi256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_hamsi384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_hamsi512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_hamsi224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_hamsi256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_hamsi384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_hamsi512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_HAMSI224 = HashType[28, 4, 56, sph_hamsi224_init, sph_hamsi224, sph_hamsi224_close, false]
  SPH_HAMSI256 = HashType[32, 4, 56, sph_hamsi256_init, sph_hamsi256, sph_hamsi256_close, false]
  SPH_HAMSI384 = HashType[48, 8, 88, sph_hamsi384_init, sph_hamsi384, sph_hamsi384_close, false]
  SPH_HAMSI512 = HashType[64, 8, 88, sph_hamsi512_init, sph_hamsi512, sph_hamsi512_close, false]
