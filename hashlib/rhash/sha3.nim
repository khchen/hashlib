#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.passc: "-DUSE_KECCAK".}
{.compile: "src/rhash_sha3.c".}

proc rhash_keccak224_init(ctx: pointer) {.importc: "rhash_sha3_224_init", cdecl.}
proc rhash_keccak256_init(ctx: pointer) {.importc: "rhash_sha3_256_init", cdecl.}
proc rhash_keccak384_init(ctx: pointer) {.importc: "rhash_sha3_384_init", cdecl.}
proc rhash_keccak512_init(ctx: pointer) {.importc: "rhash_sha3_512_init", cdecl.}
proc rhash_sha3_224_init(ctx: pointer) {.importc, cdecl.}
proc rhash_sha3_256_init(ctx: pointer) {.importc, cdecl.}
proc rhash_sha3_384_init(ctx: pointer) {.importc, cdecl.}
proc rhash_sha3_512_init(ctx: pointer) {.importc, cdecl.}

proc rhash_keccak224_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_sha3_update", cdecl.}
proc rhash_keccak256_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_sha3_update", cdecl.}
proc rhash_keccak384_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_sha3_update", cdecl.}
proc rhash_keccak512_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_sha3_update", cdecl.}
proc rhash_sha3_224_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_sha3_update", cdecl.}
proc rhash_sha3_256_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_sha3_update", cdecl.}
proc rhash_sha3_384_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_sha3_update", cdecl.}
proc rhash_sha3_512_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_sha3_update", cdecl.}

proc rhash_keccak224_final(ctx: pointer, dst: pointer) {.importc: "rhash_keccak_final", cdecl.}
proc rhash_keccak256_final(ctx: pointer, dst: pointer) {.importc: "rhash_keccak_final", cdecl.}
proc rhash_keccak384_final(ctx: pointer, dst: pointer) {.importc: "rhash_keccak_final", cdecl.}
proc rhash_keccak512_final(ctx: pointer, dst: pointer) {.importc: "rhash_keccak_final", cdecl.}
proc rhash_sha3_224_final(ctx: pointer, dst: pointer) {.importc: "rhash_sha3_final", cdecl.}
proc rhash_sha3_256_final(ctx: pointer, dst: pointer) {.importc: "rhash_sha3_final", cdecl.}
proc rhash_sha3_384_final(ctx: pointer, dst: pointer) {.importc: "rhash_sha3_final", cdecl.}
proc rhash_sha3_512_final(ctx: pointer, dst: pointer) {.importc: "rhash_sha3_final", cdecl.}

hashRegister:
  RHASH_KECCAK224 = HashType[28, 144, 400, rhash_keccak224_init, rhash_keccak224_update, rhash_keccak224_final, false]
  RHASH_KECCAK256 = HashType[32, 136, 400, rhash_keccak256_init, rhash_keccak256_update, rhash_keccak256_final, false]
  RHASH_KECCAK384 = HashType[48, 104, 400, rhash_keccak384_init, rhash_keccak384_update, rhash_keccak384_final, false]
  RHASH_KECCAK512 = HashType[64, 72, 400, rhash_keccak512_init, rhash_keccak512_update, rhash_keccak512_final, false]
  RHASH_SHA3_224 = HashType[28, 144, 400, rhash_sha3_224_init, rhash_sha3_224_update, rhash_sha3_224_final, false]
  RHASH_SHA3_256 = HashType[32, 136, 400, rhash_sha3_256_init, rhash_sha3_256_update, rhash_sha3_256_final, false]
  RHASH_SHA3_384 = HashType[48, 104, 400, rhash_sha3_384_init, rhash_sha3_384_update, rhash_sha3_384_final, false]
  RHASH_SHA3_512 = HashType[64, 72, 400, rhash_sha3_512_init, rhash_sha3_512_update, rhash_sha3_512_final, false]
