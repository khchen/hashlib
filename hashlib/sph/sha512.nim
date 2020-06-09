#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_sha2big.c".}

proc sph_sha384_init(ctx: pointer) {.importc, cdecl.}
proc sph_sha512_init(ctx: pointer) {.importc, cdecl.}

proc sph_sha384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_sha512(ctx: pointer, data: pointer, len: csize_t) {.importc: "sph_sha384", cdecl.}

proc sph_sha384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_sha512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_SHA384 = HashType[48, 128, 200, sph_sha384_init, sph_sha384, sph_sha384_close, false]
  SPH_SHA512 = HashType[64, 128, 200, sph_sha512_init, sph_sha512, sph_sha512_close, false]
