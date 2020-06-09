#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, endians
export common

{.passc: "-msse4.1 -mavx2".}
{.compile: "src/xxhash.c".}

type uint128 = (uint64, uint64)
const XXH3_ALIGN = 64

proc XXH32_reset(ctx: pointer, seed: uint32) {.importc, cdecl.}
proc XXH32_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc XXH32_digest(ctx: pointer): uint32 {.importc, cdecl.}

proc XXH64_reset(ctx: pointer, seed: uint64) {.importc, cdecl.}
proc XXH64_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc XXH64_digest(ctx: pointer): uint64 {.importc, cdecl.}

proc XXH3_64bits_reset(ctx: pointer) {.importc, cdecl.}
proc XXH3_64bits_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc XXH3_64bits_digest(ctx: pointer): uint64 {.importc, cdecl.}

proc XXH3_128bits_reset(ctx: pointer) {.importc, cdecl.}
proc XXH3_128bits_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc XXH3_128bits_digest(ctx: pointer): uint128 {.importc, cdecl.}

proc xxhash32_init(ctx: pointer) {.cdecl.} = XXH32_reset(ctx, 0)
proc xxhash32_final(ctx: pointer, dst: pointer) {.cdecl.} =
  cast[ptr uint32](dst)[] = XXH32_digest(ctx)
  swapEndian32(dst, dst)

proc xxhash64_init(ctx: pointer) {.cdecl.} = XXH64_reset(ctx, 0)
proc xxhash64_final(ctx: pointer, dst: pointer) {.cdecl.} =
  cast[ptr uint64](dst)[] = XXH64_digest(ctx)
  swapEndian64(dst, dst)

template alignedCtx(ctx: pointer): pointer =
  let offset = XXH3_ALIGN - (cast[uint](ctx) and (XXH3_ALIGN - 1))
  cast[pointer](cast[uint](ctx) + offset)

proc xxHash3_64_init(ctx: pointer) {.cdecl.} =
  XXH3_64bits_reset(alignedCtx(ctx))

proc xxHash3_64_update(ctx: pointer, data: pointer, len: csize_t) {.cdecl.} =
  XXH3_64bits_update(alignedCtx(ctx), data, len)

proc xxhash3_64_final(ctx: pointer, dst: pointer) {.cdecl.} =
  cast[ptr uint64](dst)[] = XXH3_64bits_digest(alignedCtx(ctx))
  swapEndian64(dst, dst)

proc xxHash3_128_init(ctx: pointer) {.cdecl.} =
  XXH3_128bits_reset(alignedCtx(ctx))

proc xxHash3_128_update(ctx: pointer, data: pointer, len: csize_t) {.cdecl.} =
  XXH3_128bits_update(alignedCtx(ctx), data, len)

proc xxhash3_128_final(ctx: pointer, dst: pointer) {.cdecl.} =
  let p128 = cast[ptr uint128](dst)
  p128[] = XXH3_128bits_digest(alignedCtx(ctx))
  var tmp = p128[][0]
  swapEndian64(addr p128[][0], addr p128[][1])
  swapEndian64(addr p128[][1], addr tmp)

hashRegister:
  XXHASH32 = HashType[4, 4, 48, xxhash32_init, XXH32_update, xxhash32_final, false]
  XXHASH64 = HashType[8, 8, 88, xxhash64_init, XXH64_update, xxhash64_final, false]
  XXHASH3_64 = HashType[8, 8, 576 + XXH3_ALIGN, xxHash3_64_init, xxHash3_64_update, xxhash3_64_final, false]
  XXHASH3_128 = HashType[16, 16, 576 + XXH3_ALIGN, xxHash3_128_init, xxHash3_128_update, xxhash3_128_final, false]
