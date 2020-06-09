#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_sha1.c".}

proc sph_sha1_init(ctx: pointer) {.importc, cdecl.}
proc sph_sha1(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_sha1_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_SHA1 = HashType[20, 64, 96, sph_sha1_init, sph_sha1, sph_sha1_close, false]
