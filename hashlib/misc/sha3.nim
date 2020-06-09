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
  {.compile: "src/xkcp64/KeccakHash.c".}
else:
  {.compile: "src/xkcp32/KeccakHash.c".}

proc Keccak_HashInitialize(ctx: pointer, rate: cuint, capacity: cuint, hashbitlen: cuint, delimitedSuffix: byte) {.importc, cdecl.}
proc Keccak_HashUpdate(ctx: pointer, data: pointer, databitlen: csize_t) {.importc, cdecl.}
proc Keccak_HashFinal(ctx: pointer, data: pointer) {.importc, cdecl.}
proc Keccak_HashSqueeze(ctx: pointer, data: pointer, databitlen: csize_t) {.importc, cdecl.}

proc keccak224_init(ctx: pointer) {.cdecl.} = Keccak_HashInitialize(ctx, 1152, 448, 224, 1)
proc keccak256_init(ctx: pointer) {.cdecl.} = Keccak_HashInitialize(ctx, 1088, 512, 256, 1)
proc keccak384_init(ctx: pointer) {.cdecl.} = Keccak_HashInitialize(ctx, 832, 768, 384, 1)
proc keccak512_init(ctx: pointer) {.cdecl.} = Keccak_HashInitialize(ctx, 576,1024, 512, 1)
proc sha3_224_init(ctx: pointer) {.cdecl.} = Keccak_HashInitialize(ctx, 1152, 448, 224, 6)
proc sha3_256_init(ctx: pointer) {.cdecl.} = Keccak_HashInitialize(ctx, 1088, 512, 256, 6)
proc sha3_384_init(ctx: pointer) {.cdecl.} = Keccak_HashInitialize(ctx, 832, 768, 384, 6)
proc sha3_512_init(ctx: pointer) {.cdecl.} = Keccak_HashInitialize(ctx, 576, 1024, 512, 6)
proc shake128_init(ctx: pointer) {.cdecl.} = Keccak_HashInitialize(ctx, 1344, 256, 0, 0x1f)
proc shake256_init(ctx: pointer) {.cdecl.} = Keccak_HashInitialize(ctx, 1088, 512, 0, 0x1f)

proc sha3_update(ctx: pointer, data: pointer, len: csize_t) {.cdecl.} = Keccak_HashUpdate(ctx, data, len shl 3)
proc sha3_final(ctx: pointer, dst: pointer) {.importc: "Keccak_HashFinal", cdecl.}

proc shake_final(ctx: pointer, dst: pointer, len: csize_t) {.cdecl.} =
  Keccak_HashFinal(ctx, nil)
  Keccak_HashSqueeze(ctx, dst, len shl 3)

hashRegister:
  KECCAK224 = HashType[28, 144, 224, keccak224_init, sha3_update, sha3_final, false]
  KECCAK256 = HashType[32, 136, 224, keccak256_init, sha3_update, sha3_final, false]
  KECCAK384 = HashType[48, 104, 224, keccak384_init, sha3_update, sha3_final, false]
  KECCAK512 = HashType[64, 72, 224, keccak512_init, sha3_update, sha3_final, false]
  SHA3_224 = HashType[28, 144, 224, sha3_224_init, sha3_update, sha3_final, false]
  SHA3_256 = HashType[32, 136, 224, sha3_256_init, sha3_update, sha3_final, false]
  SHA3_384 = HashType[48, 104, 224, sha3_384_init, sha3_update, sha3_final, false]
  SHA3_512 = HashType[64, 72, 224, sha3_512_init, sha3_update, sha3_final, false]
  SHAKE128 = HashType[16, 168, 224, shake128_init, sha3_update, shake_final, true]
  SHAKE256 = HashType[32, 136, 224, shake256_init, sha3_update, shake_final, true]
