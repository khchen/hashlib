#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_keccak.c".}

proc sph_keccak224_init(ctx: pointer) {.importc, cdecl.}
proc sph_keccak256_init(ctx: pointer) {.importc, cdecl.}
proc sph_keccak384_init(ctx: pointer) {.importc, cdecl.}
proc sph_keccak512_init(ctx: pointer) {.importc, cdecl.}
proc sph_sha3_224_init(ctx: pointer) {.importc: "sph_keccak224_init", cdecl.}
proc sph_sha3_256_init(ctx: pointer) {.importc: "sph_keccak256_init", cdecl.}
proc sph_sha3_384_init(ctx: pointer) {.importc: "sph_keccak384_init", cdecl.}
proc sph_sha3_512_init(ctx: pointer) {.importc: "sph_keccak512_init", cdecl.}

proc sph_keccak224(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_keccak256(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_keccak384(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_keccak512(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_sha3_224(ctx: pointer, data: pointer, len: csize_t) {.importc: "sph_keccak224", cdecl.}
proc sph_sha3_256(ctx: pointer, data: pointer, len: csize_t) {.importc: "sph_keccak256", cdecl.}
proc sph_sha3_384(ctx: pointer, data: pointer, len: csize_t) {.importc: "sph_keccak384", cdecl.}
proc sph_sha3_512(ctx: pointer, data: pointer, len: csize_t) {.importc: "sph_keccak512", cdecl.}

proc sph_keccak224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_keccak256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_keccak384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_keccak512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_sha3_224_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_sha3_256_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_sha3_384_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_sha3_512_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_KECCAK224 = HashType[28, 144, 360, sph_keccak224_init, sph_keccak224, sph_keccak224_close, false]
  SPH_KECCAK256 = HashType[32, 136, 360, sph_keccak256_init, sph_keccak256, sph_keccak256_close, false]
  SPH_KECCAK384 = HashType[48, 104, 360, sph_keccak384_init, sph_keccak384, sph_keccak384_close, false]
  SPH_KECCAK512 = HashType[64, 72, 360, sph_keccak512_init, sph_keccak512, sph_keccak512_close, false]
  SPH_SHA3_224 = HashType[28, 144, 360, sph_sha3_224_init, sph_sha3_224, sph_sha3_224_close, false]
  SPH_SHA3_256 = HashType[32, 136, 360, sph_sha3_256_init, sph_sha3_256, sph_sha3_256_close, false]
  SPH_SHA3_384 = HashType[48, 104, 360, sph_sha3_384_init, sph_sha3_384, sph_sha3_384_close, false]
  SPH_SHA3_512 = HashType[64, 72, 360, sph_sha3_512_init, sph_sha3_512, sph_sha3_512_close, false]
