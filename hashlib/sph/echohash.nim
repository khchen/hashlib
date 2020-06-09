#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_echo.c".}

proc sph_echo224_init(ctx: pointer) {.importc, cdecl.}
proc sph_echo256_init(ctx: pointer) {.importc, cdecl.}
proc sph_echo384_init(ctx: pointer) {.importc, cdecl.}
proc sph_echo512_init(ctx: pointer) {.importc, cdecl.}

proc sph_echo224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_echo256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_echo384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_echo512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_echo224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_echo256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_echo384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_echo512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_ECHO224 = HashType[28, 192, 280, sph_echo224_init, sph_echo224, sph_echo224_close, false]
  SPH_ECHO256 = HashType[32, 192, 280, sph_echo256_init, sph_echo256, sph_echo256_close, false]
  SPH_ECHO384 = HashType[48, 128, 280, sph_echo384_init, sph_echo384, sph_echo384_close, false]
  SPH_ECHO512 = HashType[64, 128, 280, sph_echo512_init, sph_echo512, sph_echo512_close, false]
