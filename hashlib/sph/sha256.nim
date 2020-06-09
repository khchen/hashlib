#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_sha2.c".}

proc sph_sha224_init(ctx: pointer) {.importc, cdecl.}
proc sph_sha256_init(ctx: pointer) {.importc, cdecl.}

proc sph_sha224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_sha256(ctx: pointer, data: pointer, len: csize_t) {.importc: "sph_sha224", cdecl.}

proc sph_sha224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_sha256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_SHA224 = HashType[28, 64, 104, sph_sha224_init, sph_sha224, sph_sha224_close, false]
  SPH_SHA256 = HashType[32, 64, 104, sph_sha256_init, sph_sha256, sph_sha256_close, false]
