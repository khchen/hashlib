#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_radiogatun.c".}

proc sph_radiogatun32_init(ctx: pointer) {.importc, cdecl.}
proc sph_radiogatun64_init(ctx: pointer) {.importc, cdecl.}

proc sph_radiogatun32(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_radiogatun64(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_radiogatun32_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_radiogatun64_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_RADIOGATUN32 = HashType[32, 32, 392, sph_radiogatun32_init, sph_radiogatun32, sph_radiogatun32_close, false]
  SPH_RADIOGATUN64 = HashType[32, 32, 784, sph_radiogatun64_init, sph_radiogatun64, sph_radiogatun64_close, false]
