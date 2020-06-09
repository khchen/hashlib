#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/byte_order
export common

{.compile: "src/rhash_snefru.c".}

proc rhash_snefru128_init(ctx: pointer) {.importc, cdecl.}
proc rhash_snefru256_init(ctx: pointer) {.importc, cdecl.}

proc rhash_snefru128_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_snefru_update", cdecl.}
proc rhash_snefru256_update(ctx: pointer, data: pointer, len: csize_t) {.importc: "rhash_snefru_update", cdecl.}

proc rhash_snefru128_final(ctx: pointer, dst: pointer) {.importc: "rhash_snefru_final", cdecl.}
proc rhash_snefru256_final(ctx: pointer, dst: pointer) {.importc: "rhash_snefru_final", cdecl.}

hashRegister:
  RHASH_SNEFRU128 = HashType[16, 48, 96, rhash_snefru128_init, rhash_snefru128_update, rhash_snefru128_final, false]
  RHASH_SNEFRU256 = HashType[32, 48, 96, rhash_snefru256_init, rhash_snefru256_update, rhash_snefru256_final, false]
