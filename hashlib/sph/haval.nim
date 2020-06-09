#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common
export common

{.compile: "src/sph_haval.c".}

proc sph_haval128_3_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval128_4_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval128_5_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval160_3_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval160_4_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval160_5_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval192_3_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval192_4_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval192_5_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval224_3_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval224_4_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval224_5_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval256_3_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval256_4_init(ctx: pointer) {.importc, cdecl.}
proc sph_haval256_5_init(ctx: pointer) {.importc, cdecl.}

proc sph_haval128_3(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval128_4(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval128_5(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval160_3(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval160_4(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval160_5(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval192_3(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval192_4(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval192_5(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval224_3(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval224_4(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval224_5(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval256_3(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval256_4(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc sph_haval256_5(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc sph_haval128_3_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval128_4_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval128_5_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval160_3_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval160_4_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval160_5_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval192_3_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval192_4_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval192_5_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval224_3_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval224_4_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval224_5_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval256_3_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval256_4_close(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc sph_haval256_5_close(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  SPH_HAVAL128_3 = HashType[16, 128, 176, sph_haval128_3_init, sph_haval128_3, sph_haval128_3_close, false]
  SPH_HAVAL128_4 = HashType[16, 128, 176, sph_haval128_4_init, sph_haval128_4, sph_haval128_4_close, false]
  SPH_HAVAL128_5 = HashType[16, 128, 176, sph_haval128_5_init, sph_haval128_5, sph_haval128_5_close, false]
  SPH_HAVAL160_3 = HashType[20, 128, 176, sph_haval160_3_init, sph_haval160_3, sph_haval160_3_close, false]
  SPH_HAVAL160_4 = HashType[20, 128, 176, sph_haval160_4_init, sph_haval160_4, sph_haval160_4_close, false]
  SPH_HAVAL160_5 = HashType[20, 128, 176, sph_haval160_5_init, sph_haval160_5, sph_haval160_5_close, false]
  SPH_HAVAL192_3 = HashType[24, 128, 176, sph_haval192_3_init, sph_haval192_3, sph_haval192_3_close, false]
  SPH_HAVAL192_4 = HashType[24, 128, 176, sph_haval192_4_init, sph_haval192_4, sph_haval192_4_close, false]
  SPH_HAVAL192_5 = HashType[24, 128, 176, sph_haval192_5_init, sph_haval192_5, sph_haval192_5_close, false]
  SPH_HAVAL224_3 = HashType[28, 128, 176, sph_haval224_3_init, sph_haval224_3, sph_haval224_3_close, false]
  SPH_HAVAL224_4 = HashType[28, 128, 176, sph_haval224_4_init, sph_haval224_4, sph_haval224_4_close, false]
  SPH_HAVAL224_5 = HashType[28, 128, 176, sph_haval224_5_init, sph_haval224_5, sph_haval224_5_close, false]
  SPH_HAVAL256_3 = HashType[32, 128, 176, sph_haval256_3_init, sph_haval256_3, sph_haval256_3_close, false]
  SPH_HAVAL256_4 = HashType[32, 128, 176, sph_haval256_4_init, sph_haval256_4, sph_haval256_4_close, false]
  SPH_HAVAL256_5 = HashType[32, 128, 176, sph_haval256_5_init, sph_haval256_5, sph_haval256_5_close, false]
