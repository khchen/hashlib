#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/rhash_gost12.c".}

proc rhash_gost12_256_init(ctx: pointer) {.importc, cdecl.}
proc rhash_gost12_512_init(ctx: pointer) {.importc, cdecl.}

proc rhash_gost12_256_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_gost12_update", cdecl.}
proc rhash_gost12_512_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_gost12_update", cdecl.}

proc rhash_gost12_256_final(ctx: pointer, dst: pointer) {.importc: "rhash_gost12_final", cdecl.}
proc rhash_gost12_512_final(ctx: pointer, dst: pointer) {.importc: "rhash_gost12_final", cdecl.}

hashRegister:
  RHASH_GOST2012_256 = HashType[32, 64, 264, rhash_gost12_256_init, rhash_gost12_256_update, rhash_gost12_256_final, false]
  RHASH_GOST2012_512 = HashType[64, 64, 264, rhash_gost12_512_init, rhash_gost12_512_update, rhash_gost12_512_final, false]
  RHASH_STREEBOG256 = HashType[32, 64, 264, rhash_gost12_256_init, rhash_gost12_256_update, rhash_gost12_256_final, false]
  RHASH_STREEBOG512 = HashType[64, 64, 264, rhash_gost12_512_init, rhash_gost12_512_update, rhash_gost12_512_final, false]
