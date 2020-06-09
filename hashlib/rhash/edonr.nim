#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/rhash_edonr.c".}

proc rhash_edonr224_init(ctx: pointer) {.importc, cdecl.}
proc rhash_edonr256_init(ctx: pointer) {.importc, cdecl.}
proc rhash_edonr384_init(ctx: pointer) {.importc, cdecl.}
proc rhash_edonr512_init(ctx: pointer) {.importc, cdecl.}

proc rhash_edonr224_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_edonr256_update", cdecl.}
proc rhash_edonr256_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc rhash_edonr384_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_edonr512_update", cdecl.}
proc rhash_edonr512_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc rhash_edonr224_final(ctx: pointer, dst: pointer) {.importc: "rhash_edonr256_final", cdecl.}
proc rhash_edonr256_final(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc rhash_edonr384_final(ctx: pointer, dst: pointer) {.importc: "rhash_edonr512_final", cdecl.}
proc rhash_edonr512_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_EDONR224 = HashType[28, 64, 272, rhash_edonr224_init, rhash_edonr224_update, rhash_edonr224_final, false]
  RHASH_EDONR256 = HashType[32, 64, 272, rhash_edonr256_init, rhash_edonr256_update, rhash_edonr256_final, false]
  RHASH_EDONR384 = HashType[48, 128, 272, rhash_edonr384_init, rhash_edonr384_update, rhash_edonr384_final, false]
  RHASH_EDONR512 = HashType[64, 128, 272, rhash_edonr512_init, rhash_edonr512_update, rhash_edonr512_final, false]
