#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_groestl.c".}

proc sph_groestl224_init(ctx: pointer) {.importc, cdecl.}
proc sph_groestl256_init(ctx: pointer) {.importc, cdecl.}
proc sph_groestl384_init(ctx: pointer) {.importc, cdecl.}
proc sph_groestl512_init(ctx: pointer) {.importc, cdecl.}

proc sph_groestl224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_groestl256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_groestl384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_groestl512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_groestl224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_groestl256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_groestl384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_groestl512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_GROESTL224 = HashType[28, 64, 144, sph_groestl224_init, sph_groestl224, sph_groestl224_close, false]
  SPH_GROESTL256 = HashType[32, 64, 144, sph_groestl256_init, sph_groestl256, sph_groestl256_close, false]
  SPH_GROESTL384 = HashType[48, 128, 272, sph_groestl384_init, sph_groestl384, sph_groestl384_close, false]
  SPH_GROESTL512 = HashType[64, 128, 272, sph_groestl512_init, sph_groestl512, sph_groestl512_close, false]
