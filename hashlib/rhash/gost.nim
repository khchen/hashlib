#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/rhash_gost94.c".}

proc rhash_gost94_init(ctx: pointer) {.importc, cdecl.}
proc rhash_gost94pro_init(ctx: pointer) {.importc: "rhash_gost94_cryptopro_init", cdecl.}

proc rhash_gost94_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc rhash_gost94pro_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_gost94_update", cdecl.}

proc rhash_gost94_final(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc rhash_gost94pro_final(ctx: pointer, dst: pointer) {.importc: "rhash_gost94_final", cdecl.}

hashRegister:
  RHASH_GOST94 = HashType[32, 32, 112, rhash_gost94_init, rhash_gost94_update, rhash_gost94_final, false]
  RHASH_GOST94PRO = HashType[32, 32, 112, rhash_gost94pro_init, rhash_gost94pro_update, rhash_gost94pro_final, false]
