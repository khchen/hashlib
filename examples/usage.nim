#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

const TRY_MD5 = true

when TRY_MD5:
  import hashlib/rhash/md5
  type HASH = RHASH_MD5
  const data = "The quick brown fox jumps over the lazy dog"
  const output = "9e107d9d372bb6826bd81d3542a419d6"

  const key = "key"
  const hmac = "80070713463e7749b90c2dc24911e275"

else:
  import hashlib/sph/sha1
  type HASH = SPH_SHA1
  const data = "The quick brown fox jumps over the lazy dog"
  const output = "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12"

  const key = "key"
  const hmac = "de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9"

# Simple API:
#
#   count[HashType](DataTypes): HashType
#   count[HashType](DataTypes, DigestTypes)
#
#   DataTypes = string | openarray[byte] | openarray[char] | Stream | MemoryBlock
#   DigestTypes = HashType | Digest | openarray[byte] | openarray[char]

block:
  # input: string, return: HashType
  doAssert(count[HASH](data) is HashType)
  doAssert($count[HASH](data) == output)

  # input: string, output: HashType
  var hash: HASH
  count(data, hash)
  doAssert($hash == output)

  # input: MemoryBlock, output: Digest
  var input: MemoryBlock = (pointer cstring data, data.len)
  var digest: Digest
  count[HASH](input, digest)
  doAssert($digest == output)

  # input: openarray[char], output: openarray[byte]
  var buffer = newSeq[byte](sizeof(HASH))
  count[HASH](toOpenArray(data, 0, data.len - 1), buffer)
  doAssert(buffer == digest.data)

# Stream API:
#
#   init[HashType](): Context[HashType]
#   init(var Context[HashType])
#
#   update(var Context[HashType], DataTypes)
#
#   final(var Context[HashType]): HashType
#   final(var Context[HashType], var DigestTypes)
#
#   DataTypes = string | openarray[byte] | openarray[char] | Stream | MemoryBlock
#   DigestTypes = HashType | Digest | openarray[byte] | openarray[char]

block:
  # input: string, return: HashType
  var ctx = init[HASH]()
  ctx.update(data)
  doAssert($ctx.final() == output)

block:
  # input: string, output: HashType
  var ctx: Context[HASH]
  var hash: HASH
  ctx.init()
  ctx.update(data)
  ctx.final(hash)
  doAssert($hash == output)

block:
  # input: MemoryBlock, output: Digest
  var input: MemoryBlock = (pointer cstring data, data.len)
  var digest: Digest
  var ctx = init[HASH]()
  ctx.update(input)
  ctx.final(digest)
  doAssert($digest == output)

block:
  # input: openarray[char], output: openarray[byte]
  var buffer = newSeq[byte](sizeof(HASH))
  var ctx = init[HASH]()
  ctx.update(toOpenArray(data, 0, data.len - 1))
  ctx.final(buffer)
  doAssert(buffer == count[HASH](data).data)

# Simple HMAC API:
#
#   count[Hmac[HashType]](KeyTypes, DataTypes): HashType
#   count[Hmac[HashType]](KeyTypes, DataTypes, var DigestTypes)
#
#   KeyTypes = string | openarray[byte] | openarray[char] | MemoryBlock
#   DataTypes = string | openarray[byte] | openarray[char] | Stream | MemoryBlock
#   DigestTypes = HashType | Digest | openarray[byte] | openarray[char]

block:
  doAssert($count[Hmac[HASH]](key, data) == hmac)

# Stream HMAC API:
#
#   init[Hmac[HashType]](KeyTypes): Hmac[HashType]
#   init(var Hmac[HashType], KeyTypes)
#
#   update(var Hmac[HashType], DataTypes)
#
#   final(var Hmac[HashType]): HashType
#   final(var Hmac[HashType], var DigestTypes)
#
#   KeyTypes = string | openarray[byte] | openarray[char] | MemoryBlock
#   DataTypes = string | openarray[byte] | openarray[char] | Stream | MemoryBlock
#   DigestTypes = HashType | Digest | openarray[byte] | openarray[char]

block:
  var ctx = init[Hmac[HASH]](key)
  ctx.update(data)
  doAssert($ctx.final() == hmac)

block:
  var ctx: Hmac[HASH]
  var hash: HASH
  ctx.init(key)
  ctx.update(data)
  ctx.final(hash)
  doAssert($hash == hmac)

# HashObject and HmacObject API (non-generics types):
#
#   toObject(HashType): HashObject
#   toHmacObject(HashType): HmacObject
#   toHmacObject(HashObject): HmacObject
#
#   count(var HashObject, DataTypes): Digest
#   count(var HashObject, DataTypes, var DigestTypes)
#   count(var HmacObject, KeyTypes, DigestTypes): Digest
#   count(var HmacObject, KeyTypes, DigestTypes, var DigestTypes)
#
#   init(var HashObject)
#   init(var HmacObject, KeyTypes)
#
#   update(var HashObject, DataTypes)
#   update(var HmacObject, DataTypes)
#
#   final(var HashObject): Digest
#   final(var HashObject, var DigestTypes)
#   final(var HmacObject): Digest
#   final(var HmacObject, DigestTypes)
#
#   KeyTypes = string | openarray[byte] | openarray[char] | MemoryBlock
#   DataTypes = string | openarray[byte] | openarray[char] | Stream | MemoryBlock
#   DigestTypes = Digest | openarray[byte] | openarray[char]

var ho = toObject(HASH)
var hmo = toHmacObject(HASH)

block:
  doAssert($ho.count(data) == output)
  doAssert($hmo.count(key, data) == hmac)

block:
  ho.init()
  ho.update(data)
  doAssert($ho.final() == output)

  hmo.init(key)
  hmo.update(data)
  doAssert($hmo.final() == hmac)

block:
  var digest: Digest
  ho.init()
  ho.update(data)
  ho.final(digest)
  doAssert($digest == output)

  hmo.init(key)
  hmo.update(data)
  hmo.final(digest)
  doAssert($digest == hmac)
