#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_cubehash.c".}

proc sph_cubehash224_init(ctx: pointer) {.importc, cdecl.}
proc sph_cubehash256_init(ctx: pointer) {.importc, cdecl.}
proc sph_cubehash384_init(ctx: pointer) {.importc, cdecl.}
proc sph_cubehash512_init(ctx: pointer) {.importc, cdecl.}

proc sph_cubehash224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_cubehash256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_cubehash384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_cubehash512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_cubehash224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_cubehash256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_cubehash384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_cubehash512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_CUBEHASH224 = HashType[28, 32, 168, sph_cubehash224_init, sph_cubehash224, sph_cubehash224_close, false]
  SPH_CUBEHASH256 = HashType[32, 32, 168, sph_cubehash256_init, sph_cubehash256, sph_cubehash256_close, false]
  SPH_CUBEHASH384 = HashType[48, 32, 168, sph_cubehash384_init, sph_cubehash384, sph_cubehash384_close, false]
  SPH_CUBEHASH512 = HashType[64, 32, 168, sph_cubehash512_init, sph_cubehash512, sph_cubehash512_close, false]
