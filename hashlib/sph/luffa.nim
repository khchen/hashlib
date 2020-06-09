#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_luffa.c".}

proc sph_luffa224_init(ctx: pointer) {.importc, cdecl.}
proc sph_luffa256_init(ctx: pointer) {.importc, cdecl.}
proc sph_luffa384_init(ctx: pointer) {.importc, cdecl.}
proc sph_luffa512_init(ctx: pointer) {.importc, cdecl.}

proc sph_luffa224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_luffa256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_luffa384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_luffa512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_luffa224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_luffa256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_luffa384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_luffa512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_LUFFA224 = HashType[28, 32, 136, sph_luffa224_init, sph_luffa224, sph_luffa224_close, false]
  SPH_LUFFA256 = HashType[32, 32, 136, sph_luffa256_init, sph_luffa256, sph_luffa256_close, false]
  SPH_LUFFA384 = HashType[48, 48, 168, sph_luffa384_init, sph_luffa384, sph_luffa384_close, false]
  SPH_LUFFA512 = HashType[64, 64, 200, sph_luffa512_init, sph_luffa512, sph_luffa512_close, false]
