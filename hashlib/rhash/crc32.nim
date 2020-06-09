#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, src/byte_order
export common

{.compile: "src/rhash_crc32.c".}
{.compile: "src/rhash_crc32_helper.c".}

proc rhash_crc32_init(ctx: pointer) {.importc, cdecl.}
proc rhash_crc32c_init(ctx: pointer) {.importc, cdecl.}

proc rhash_crc32_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}
proc rhash_crc32c_update(ctx: pointer, data: pointer, len: csize_t) {.importc, cdecl.}

proc rhash_crc32_final(ctx: pointer, dst: pointer) {.importc, cdecl.}
proc rhash_crc32c_final(ctx: pointer, dst: pointer) {.importc, cdecl.}

hashRegister:
  RHASH_CRC32 = HashType[4, 4, 4, rhash_crc32_init, rhash_crc32_update, rhash_crc32_final, false]
  RHASH_CRC32C = HashType[4, 4, 4, rhash_crc32c_init, rhash_crc32c_update, rhash_crc32c_final, false]
