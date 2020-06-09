#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

import streams, macros, strutils

type
  InitProc[H] = proc (ctx: var Context[H]) {.cdecl.}
  UpdateProc[H] = proc (ctx: var Context[H], data: pointer, len: csize_t) {.cdecl.}
  FinalProc[H] = proc (ctx: var Context[H], dst: var H) {.cdecl.}
  FinalXofProc[H] = proc (ctx: var Context[H], dst: var H, len: csize_t) {.cdecl.}

  ObjInitProc = proc (ctx: pointer) {.cdecl.}
  ObjUpdateProc = proc (ctx: pointer, data: pointer, len: csize_t) {.cdecl.}
  ObjFinalProc = proc (ctx: pointer, dst: pointer) {.cdecl.}
  ObjFinalXofProc = proc (ctx: pointer, dst: pointer, len: csize_t) {.cdecl.}

  HashType*[
    digestSize: static[int],
    blockSize: static[int],
    contextSize: static[int],
    init: static[pointer],
    update: static[pointer],
    final: static[pointer],
    xof: static[bool]
  ] = object
    data*: array[digestSize, byte]

  Context*[H: HashType] = object
    buffer: array[H.contextSize, byte]

  Digest* = object
    data*: seq[byte]

  Hmac*[H: HashType] = object
    ictx: Context[H]
    octx: Context[H]

  HashObject* = object
    name*: string
    digestSize*: int
    blockSize*: int
    init: pointer
    update: pointer
    final: pointer
    xof: bool
    ctx: seq[byte]

  HmacObject* = object
    ictx: HashObject
    octx: HashObject

  MemoryBlock* = tuple
    address: pointer
    size: int

proc `$`*(ho: HashObject): string =
  result.add "name: " & ho.name
  result.add ", digestSize: " & $ho.digestSize
  result.add ", blockSizeSize: " & $ho.blockSize
  result.add ", xof: " & $ho.xof
  return '(' & result & ')'

proc `$$`*[H: HashType](h: H): string =
  const digits = "0123456789abcdef"
  result = ""

  for i in 0..<h.data.len:
    add(result, digits[(h.data[i].int shr 4) and 0xF])
    add(result, digits[h.data[i].int and 0xF])

proc `$`*(digest: Digest): string =
  const digits = "0123456789abcdef"
  result = ""

  for i in 0..<digest.data.len:
    add(result, digits[(digest.data[i].int shr 4) and 0xF])
    add(result, digits[digest.data[i].int and 0xF])

proc len*(digest: Digest): int =
  result = digest.data.len

template toObject*(H: typedesc[HashType]): HashObject =
  HashObject(
    name: $(H.type),
    digestSize: H.digestSize,
    blockSize: H.blockSize,
    init: H.init,
    update: H.update,
    final: H.final,
    xof: H.xof,
    ctx: newSeq[byte](H.contextSize))

template toHmacObject*(H: typedesc[HashType]): HmacObject =
  HmacObject(ictx: toObject(H), octx: toObject(H))

proc toHmacObject*(ho: HashObject): HmacObject =
  result.ictx = ho
  result.octx = ho

proc initDigest*(L: Natural = 0): Digest {.inline.} =
  Digest(data: newSeq[byte](L))

proc setLen*(d: var Digest, L: Natural) {.inline.} =
  d.data.setLen(L)

proc init*[C: Context](ctx: var C) {.inline.} =
  cast[InitProc[ctx.H]](ctx.H.init)(ctx)

proc init*[H: HashType](): Context[H] {.inline.} =
  cast[InitProc[result.H]](result.H.init)(result)

proc update*[C: Context](ctx: var C, data: openarray[byte|char]) {.inline.} =
  cast[UpdateProc[ctx.H]](ctx.H.update)(ctx, unsafeaddr data, csize_t data.len)

proc update*[C: Context](ctx: var C, data: string) {.inline.} =
  cast[UpdateProc[ctx.H]](ctx.H.update)(ctx, cstring data, csize_t data.len)

proc update*[C: Context](ctx: var C, data: MemoryBlock) {.inline.} =
  cast[UpdateProc[ctx.H]](ctx.H.update)(ctx, data.address, csize_t data.size)

proc update*[C: Context](ctx: var C, data: Stream) =
  var buffer: array[65536, byte]
  while not data.atEnd():
    let L = data.readData(addr buffer, buffer.len)
    cast[UpdateProc[ctx.H]](ctx.H.update)(ctx, addr buffer, csize_t L)

proc final*[C: Context](ctx: var C, digest: var ctx.H) {.inline.} =
  when ctx.H.xof:
    cast[FinalXofProc[ctx.H]](ctx.H.final)(ctx, digest, ctx.H.digestSize)
  else:
    cast[FinalProc[ctx.H]](ctx.H.final)(ctx, digest)

proc final*[C: Context](ctx: var C, digest: var openarray[byte|char]) {.inline.} =
  when ctx.H.xof:
    cast[FinalXofProc[ctx.H]](ctx.H.final)(ctx, cast[var ctx.H](addr digest[0]), csize_t digest.len)
  else:
    doAssert digest.len >= sizeof(ctx.H)
    cast[FinalProc[ctx.H]](ctx.H.final)(ctx, cast[var ctx.H](addr digest[0]))

proc final*[C: Context](ctx: var C, digest: var Digest) {.inline.} =
  when ctx.H.xof:
    if digest.data.len == 0:
      digest.data.setLen(sizeof(ctx.H))
    cast[FinalXofProc[ctx.H]](ctx.H.final)(ctx, cast[var ctx.H](addr digest.data[0]), csize_t digest.data.len)
  else:
    digest.data.setLen(sizeof(ctx.H))
    cast[FinalProc[ctx.H]](ctx.H.final)(ctx, cast[var ctx.H](addr digest.data[0]))

proc final*[C: Context](ctx: var C): ctx.H {.inline.} =
  ctx.final(result)

proc init*(ho: var HashObject) {.inline.} =
  cast[ObjInitProc](ho.init)(addr ho.ctx[0])

proc update*(ho: var HashObject, data: openarray[byte|char]) {.inline.} =
  cast[ObjUpdateProc](ho.update)(addr ho.ctx[0], unsafeaddr data, csize_t data.len)

proc update*(ho: var HashObject, data: string) {.inline.} =
  cast[ObjUpdateProc](ho.update)(addr ho.ctx[0], cstring data, csize_t data.len)

proc update*(ho: var HashObject, data: MemoryBlock) {.inline.} =
  cast[ObjUpdateProc](ho.update)(addr ho.ctx[0], data.address, csize_t data.size)

proc update*(ho: var HashObject, data: Stream) =
  var buffer: array[65536, byte]
  while not data.atEnd():
    let L = data.readData(addr buffer, buffer.len)
    cast[ObjUpdateProc](ho.update)(addr ho.ctx[0], addr buffer, csize_t L)

proc final*(ho: var HashObject, digest: var openarray[byte|char]) {.inline.} =
  if ho.xof:
    cast[ObjFinalXofProc](ho.final)(addr ho.ctx[0], addr digest[0], csize_t digest.len)
  else:
    doAssert digest.len >= ho.digestSize
    cast[ObjFinalProc](ho.final)(addr ho.ctx[0], addr digest[0])

proc final*(ho: var HashObject, digest: var Digest) {.inline.} =
  if ho.xof:
    if digest.data.len == 0:
      digest.data.setLen(ho.digestSize)
    cast[ObjFinalXofProc](ho.final)(addr ho.ctx[0], addr digest.data[0], csize_t digest.data.len)
  else:
    digest.data.setLen(ho.digestSize)
    cast[ObjFinalProc](ho.final)(addr ho.ctx[0], addr digest.data[0])

proc final*(ho: var HashObject): Digest {.inline.} =
  result.data.setLen(ho.digestSize)
  if ho.xof:
    cast[ObjFinalXofProc](ho.final)(addr ho.ctx[0], addr result.data[0], csize_t ho.digestSize)
  else:
    cast[ObjFinalProc](ho.final)(addr ho.ctx[0], addr result.data[0])

template defineCount(dataType: typedesc) =
  proc count*[H: HashType](data: dataType): H =
    var ctx: Context[H]
    ctx.init()
    ctx.update(data)
    ctx.final(result)

  proc count*[H: HashType](data: dataType, digest: var H) =
    var ctx: Context[H]
    ctx.init()
    ctx.update(data)
    ctx.final(digest)

  proc count*[H: HashType](data: dataType, digest: var Digest) =
    var ctx: Context[H]
    ctx.init()
    ctx.update(data)
    ctx.final(digest)

  proc count*[H: HashType](data: dataType, digest: var openarray[byte]) =
    var ctx: Context[H]
    ctx.init()
    ctx.update(data)
    ctx.final(digest)

  proc count*[H: HashType](data: dataType, digest: var openarray[char]) =
    var ctx: Context[H]
    ctx.init()
    ctx.update(data)
    ctx.final(digest)

  proc count*(ho: var HashObject, data: dataType): Digest =
    init(ho)
    update(ho, data)
    final(ho, result)

  proc count*(ho: var HashObject, data: dataType, digest: var Digest) =
    init(ho)
    update(ho, data)
    final(ho, digest)

  proc count*(ho: var HashObject, data: dataType, digest: var openarray[byte|char]) =
    init(ho)
    update(ho, data)
    final(ho, digest)

defineCount(string)
defineCount(openarray[char])
defineCount(openarray[byte])
defineCount(MemoryBlock)
defineCount(Stream)

proc init*[M: Hmac](ctx: var M, key: openarray[byte]) =
  var ipad: array[M.H.blockSize, byte]
  var opad: array[M.H.blockSize, byte]

  if key.len > M.H.blockSize:
    count[M.H](key, ipad)

  else:
    copyMem(addr ipad[0], unsafeaddr key[0], key.len)

  for i in 0 ..< M.H.blockSize:
    opad[i] = 0x5C'u8 xor ipad[i]
    ipad[i] = 0x36'u8 xor ipad[i]

  ctx.ictx.init()
  ctx.ictx.update(ipad)
  ctx.octx.init()
  ctx.octx.update(opad)

proc init*[M: Hmac](ctx: var M, key: openarray[char]) {.inline.} =
  init(ctx, toOpenArrayByte(key, 0, key.len - 1))

proc init*[M: Hmac](ctx: var M, key: string) {.inline.} =
  init(ctx, toOpenArray(key, 0, key.len - 1))

proc init*[M: Hmac](ctx: var M, key: MemoryBlock) {.inline.} =
  init(ctx, toOpenArray(cast[cstring](key.address), 0, key.size - 1))

proc init*[M: Hmac](key: openarray[byte]): M {.inline.} =
  result.init(key)

proc init*[M: Hmac](key: openarray[char]): M {.inline.} =
  result.init(key)

proc init*[M: Hmac](key: MemoryBlock): M {.inline.} =
  result.init(toOpenArray(cast[cstring](key.address), 0, key.size - 1))

proc init*[M: Hmac](key: string): M {.inline.} =
  result.init(key)

proc update*[M: Hmac](ctx: var M, data: openarray[byte|char]) {.inline.} =
  ctx.ictx.update(data)

proc update*[M: Hmac](ctx: var M, data: string|Stream|MemoryBlock) {.inline.} =
  ctx.ictx.update(data)

proc update[M: Hmac](ctx: var M) {.inline.} =
  var buffer: array[M.H.digestSize, byte]
  ctx.ictx.final(buffer)
  ctx.octx.update(buffer)

proc final*[M: Hmac](ctx: var M, digest: var M.H) {.inline.} =
  ctx.update()
  ctx.octx.final(digest)

proc final*[M: Hmac](ctx: var M, digest: var Digest) {.inline.} =
  ctx.update()
  ctx.octx.final(digest)

proc final*[M: Hmac](ctx: var M, digest: var openarray[byte|char]) {.inline.} =
  ctx.update()
  ctx.octx.final(digest)

proc final*[M: Hmac](ctx: var M): ctx.H {.inline.} =
  ctx.update()
  ctx.octx.final(result)

proc init*(ho: var HmacObject, key: openarray[byte]) =
  var ipad = newSeq[byte](ho.ictx.blockSize)
  var opad = newSeq[byte](ho.ictx.blockSize)

  if key.len > ho.ictx.blockSize:
    ho.ictx.count(key, ipad)

  else:
    copyMem(addr ipad[0], unsafeaddr key[0], key.len)

  for i in 0 ..< ho.ictx.blockSize:
    opad[i] = 0x5C'u8 xor ipad[i]
    ipad[i] = 0x36'u8 xor ipad[i]

  init(ho.ictx)
  update(ho.ictx, ipad)
  init(ho.octx)
  update(ho.octx, opad)

proc init*(ho: var HmacObject, key: openarray[char]) {.inline.} =
  init(ho, toOpenArrayByte(key, 0, key.len - 1))

proc init*(ho: var HmacObject, key: string) {.inline.} =
  init(ho, toOpenArray(key, 0, key.len - 1))

proc init*(ho: var HmacObject, key: MemoryBlock) {.inline.} =
  init(ho, toOpenArray(cast[cstring](key.address), 0, key.size - 1))

proc update*(ho: var HmacObject, data: string|Stream|MemoryBlock) {.inline.} =
  update(ho.ictx, data)

proc update*(ho: var HmacObject, data: openarray[byte|char]) {.inline.} =
  update(ho.ictx, data)

proc update(ho: var HmacObject) {.inline.} =
  var buffer = newSeq[byte](ho.ictx.digestSize)
  final(ho.ictx, buffer)
  update(ho.octx, buffer)

proc final*(ho: var HmacObject, digest: var Digest) {.inline.} =
  ho.update()
  final(ho.octx, digest)

proc final*(ho: var HmacObject, digest: var openarray[byte|char]) {.inline.} =
  ho.update()
  final(ho.octx, digest)

proc final*(ho: var HmacObject): Digest {.inline.} =
  ho.update()
  final(ho.octx, result)

template defineCount(keyType: typedesc, dataType: typedesc) =
  proc count*[M: Hmac](key: keyType, data: dataType): M.H =
    var ctx: M
    ctx.init(key)
    ctx.update(data)
    ctx.final(result)

  proc count*[M: Hmac](key: keyType, data: dataType, digest: var M.H) =
    var ctx: M
    ctx.init(key)
    ctx.update(data)
    ctx.final(digest)

  proc count*[M: Hmac](key: keyType, data: dataType, digest: var Digest) =
    var ctx: M
    ctx.init(key)
    ctx.update(data)
    ctx.final(digest)

  proc count*[M: Hmac](key: keyType, data: dataType, digest: var openarray[byte|char]) =
    var ctx: M
    ctx.init(key)
    ctx.update(data)
    ctx.final(digest)

  proc count*(ho: var HmacObject, key: keyType, data: dataType): Digest =
    ho.init(key)
    ho.update(data)
    ho.final(result)

  proc count*(ho: var HmacObject, key: keyType, data: dataType, digest: var Digest) =
    ho.init(key)
    ho.update(data)
    ho.final(digest)

  proc count*(ho: var HmacObject, key: keyType, data: dataType, digest: var openarray[byte|char]) =
    ho.init(key)
    ho.update(data)
    ho.final(digest)

defineCount(string, string)
defineCount(string, openarray[byte])
defineCount(string, openarray[char])
defineCount(string, Stream)
defineCount(string, MemoryBlock)
defineCount(openarray[byte], string)
defineCount(openarray[byte], openarray[byte])
defineCount(openarray[byte], openarray[char])
defineCount(openarray[byte], Stream)
defineCount(openarray[byte], MemoryBlock)
defineCount(openarray[char], string)
defineCount(openarray[char], openarray[byte])
defineCount(openarray[char], openarray[char])
defineCount(openarray[char], Stream)
defineCount(openarray[char], MemoryBlock)
defineCount(MemoryBlock, string)
defineCount(MemoryBlock, openarray[byte])
defineCount(MemoryBlock, openarray[char])
defineCount(MemoryBlock, Stream)
defineCount(MemoryBlock, MemoryBlock)

proc hashStorage(x: NimNode = nil): seq[NimNode] =
  var storage {.global.}: seq[NimNode]
  if x != nil:
    storage.add x
  return storage

macro hashRegister*(x: untyped): untyped =
  # Generate following code (MD5 for example):
  #   type
  #     MD5* = HashType[16, 64, 88, md5_init, md5_update, md5_final, false]

  #   template `$`*(t: MD5): string = $$t

  proc newTypeDef(x, y: NimNode): NimNode =
    result = newTree(nnkTypeSection, newTree(nnkTypeDef,
      postfix(x, "*"),
      newEmptyNode(),
      y
    ))

  proc newTemplate(x: NimNode): NimNode =
    result = newProc(
      name = postfix(newTree(nnkAccQuoted, ident("$")), "*"),
      params = [ident("string"), newIdentDefs(ident("t"), x)],
      body = newStmtList(prefix(ident("t"), "$$")),
      procType = nnkTemplateDef
    )

  result = newStmtList()
  for i in x:
    # a magic to deal with "hashRegister" in template defineHash()
    var i = parseExpr(i.repr)

    i.expectKind(nnkAsgn)
    i.expectLen(2)
    i[0].expectKind(nnkIdent)
    i[1].expectKind(nnkBracketExpr)
    i[1].expectLen(8)

    discard hashStorage(i[0])
    result.add newTypeDef(i[0], i[1])
    result.add newTemplate(i[0])

macro availableHashes*(): untyped =
  let hashes = hashStorage()
  if hashes.len == 0:
    raise newException(IndexError, "no hash function imported")

  result = newNimNode(nnkBracket)
  for x in hashes:
    result.add newCall("toObject", x)
