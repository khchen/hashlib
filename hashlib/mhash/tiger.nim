#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/stdfns
export common

{.passc: "-DTIGER_64BIT".}
{.compile: "src/tiger_sboxes.c".}
{.compile: "src/mhash_tiger.c".}

proc tiger_init(ctx: pointer) {.importc, cdecl.}
proc tiger_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc tiger_final(ctx: pointer) {.importc, cdecl.}
proc tiger_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc tiger128_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc tiger160_digest(ctx: pointer, dst: pointer) {.importc, cdecl.}

proc tiger_finaldigest(ctx: pointer, dst: pointer) {.cdecl.} =
  tiger_final(ctx)
  tiger_digest(ctx, dst)

proc tiger128_finaldigest(ctx: pointer, dst: pointer) {.cdecl.} =
  tiger_final(ctx)
  tiger128_digest(ctx, dst)

proc tiger160_finaldigest(ctx: pointer, dst: pointer) {.cdecl.} =
  tiger_final(ctx)
  tiger160_digest(ctx, dst)

hashRegister:
  MHASH_TIGER = HashType[24, 64, 104, tiger_init, tiger_update, tiger_finaldigest, false]
  MHASH_TIGER128 = HashType[16, 64, 104, tiger_init, tiger_update, tiger128_finaldigest, false]
  MHASH_TIGER160 = HashType[20, 64, 104, tiger_init, tiger_update, tiger160_finaldigest, false]
