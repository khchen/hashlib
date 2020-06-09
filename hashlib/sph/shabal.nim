#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_shabal.c".}

proc sph_shabal192_init(ctx: pointer) {.importc, cdecl.}
proc sph_shabal224_init(ctx: pointer) {.importc, cdecl.}
proc sph_shabal256_init(ctx: pointer) {.importc, cdecl.}
proc sph_shabal384_init(ctx: pointer) {.importc, cdecl.}
proc sph_shabal512_init(ctx: pointer) {.importc, cdecl.}

proc sph_shabal192(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_shabal224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_shabal256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_shabal384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_shabal512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_shabal192_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_shabal224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_shabal256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_shabal384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_shabal512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_SHABAL192 = HashType[24, 64, 256, sph_shabal192_init, sph_shabal192, sph_shabal192_close, false]
  SPH_SHABAL224 = HashType[28, 64, 256, sph_shabal224_init, sph_shabal224, sph_shabal224_close, false]
  SPH_SHABAL256 = HashType[32, 64, 256, sph_shabal256_init, sph_shabal256, sph_shabal256_close, false]
  SPH_SHABAL384 = HashType[48, 64, 256, sph_shabal384_init, sph_shabal384, sph_shabal384_close, false]
  SPH_SHABAL512 = HashType[64, 64, 256, sph_shabal512_init, sph_shabal512, sph_shabal512_close, false]
