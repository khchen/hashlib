#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_panama.c".}

proc sph_panama_init(ctx: pointer) {.importc, cdecl.}
proc sph_panama(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_panama_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_PANAMA = HashType[32, 32, 1132, sph_panama_init, sph_panama, sph_panama_close, false]
