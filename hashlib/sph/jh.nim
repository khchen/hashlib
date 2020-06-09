#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_jh.c".}

proc sph_jh224_init(ctx: pointer) {.importc, cdecl.}
proc sph_jh256_init(ctx: pointer) {.importc, cdecl.}
proc sph_jh384_init(ctx: pointer) {.importc, cdecl.}
proc sph_jh512_init(ctx: pointer) {.importc, cdecl.}

proc sph_jh224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_jh256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_jh384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_jh512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_jh224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_jh256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_jh384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_jh512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_JH224 = HashType[28, 64, 208, sph_jh224_init, sph_jh224, sph_jh224_close, false]
  SPH_JH256 = HashType[32, 64, 208, sph_jh256_init, sph_jh256, sph_jh256_close, false]
  SPH_JH384 = HashType[48, 64, 208, sph_jh384_init, sph_jh384, sph_jh384_close, false]
  SPH_JH512 = HashType[64, 64, 208, sph_jh512_init, sph_jh512, sph_jh512_close, false]
