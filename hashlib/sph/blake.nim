#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_blake.c".}

proc sph_blake224_init(ctx: pointer) {.importc, cdecl.}
proc sph_blake256_init(ctx: pointer) {.importc, cdecl.}
proc sph_blake384_init(ctx: pointer) {.importc, cdecl.}
proc sph_blake512_init(ctx: pointer) {.importc, cdecl.}

proc sph_blake224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_blake256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_blake384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_blake512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_blake224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_blake256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_blake384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_blake512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_BLAKE224 = HashType[28, 64, 128, sph_blake224_init, sph_blake224, sph_blake224_close, false]
  SPH_BLAKE256 = HashType[32, 64, 128, sph_blake256_init, sph_blake256, sph_blake256_close, false]
  SPH_BLAKE384 = HashType[48, 128, 248, sph_blake384_init, sph_blake384, sph_blake384_close, false]
  SPH_BLAKE512 = HashType[64, 128, 248, sph_blake512_init, sph_blake512, sph_blake512_close, false]
