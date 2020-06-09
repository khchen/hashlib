#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import ../common, md5, std/sha1
export common

proc nim_md5_init(ctx: pointer) {.cdecl.} =
  md5Init(cast[var MD5Context](ctx))

proc nim_md5_update(ctx: pointer, data: pointer, len: csize_t) {.cdecl.} =
  md5Update(cast[var MD5Context](ctx), cast[cstring](data), int len)

proc nim_md5_final(ctx: pointer, digest: pointer) {.cdecl.} =
  md5Final(cast[var MD5Context](ctx), cast[var MD5Digest](digest))

proc nim_sha1_init(ctx: pointer) {.cdecl, inline.} =
  var r = newSha1State()
  copyMem(ctx, addr r, sizeof(r))

proc nim_sha1_update(ctx: pointer, data: pointer, len: csize_t) {.cdecl, inline.} =
  update(cast[var Sha1State](ctx), toOpenArray(cast[cstring](data), 0, int len - 1))

proc nim_sha1_final(ctx: pointer, digest: pointer) {.cdecl, inline.} =
  var d = finalize(cast[var Sha1State](ctx))
  copyMem(digest, addr d, sizeof(d))

hashRegister:
  NIM_MD5 = HashType[16, 64, sizeof(MD5Context), nim_md5_init, nim_md5_update, nim_md5_final, false]
  NIM_SHA1 = HashType[20, 64, sizeof(Sha1State), nim_sha1_init, nim_sha1_update, nim_sha1_final, false]
