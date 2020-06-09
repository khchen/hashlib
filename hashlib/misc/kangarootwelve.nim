#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/xkcp
export common

when defined(cpu64):
  {.compile: "src/xkcp64/KangarooTwelve.c".}
else:
  {.compile: "src/xkcp32/KangarooTwelve.c".}

proc KangarooTwelve_Initialize(ctx: pointer, len: csize_t) {.importc, cdecl.}
proc KangarooTwelve_Final(ctx: pointer, dst: pointer, customization: cstring, len: csize_t) {.importc, cdecl.}
proc KangarooTwelve_Squeeze(ctx: pointer, dst: pointer, len: csize_t) {.importc, cdecl.}

proc kt_init(ctx: pointer) {.cdecl.} = KangarooTwelve_Initialize(ctx, 0)
proc kt_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "KangarooTwelve_Update", cdecl.}
proc kt_final(ctx: pointer, dst: pointer, len: csize_t) {.cdecl.} =
  KangarooTwelve_Final(ctx, nil, "", 0)
  KangarooTwelve_Squeeze(ctx, dst, len)

hashRegister:
  KANGAROO_TWELVE = HashType[32, 136, 456, kt_init, kt_update, kt_final, true]
