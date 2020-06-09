#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

import unittest, streams
import hashlib/rhash/md5

suite "Test Suites for HashType":
  echo "  DataTypes = string | openarray[byte] | openarray[char] | Stream | MemoryBlock"
  echo "  DigestTypes = HashType | Digest | openarray[byte] | openarray[char]"
  echo ""

  setup:
    type TestHash = RHASH_MD5
    const data {.used.} = "The quick brown fox jumps over the lazy dog"
    var dataBytes {.used.} = newSeq[byte](data.len)
    copyMem(addr dataBytes[0], cstring data, data.len)
    var dataChars {.used.} = newSeq[char](data.len)
    copyMem(addr dataChars[0], cstring data, data.len)
    template dataStream: Stream {.used.} = newStringStream(data)
    var dataMemory {.used.} = (pointer cstring data, data.len)
    const output {.used.} = "9e107d9d372bb6826bd81d3542a419d6"
    const outputBytes {.used.} = [byte 158, 16, 125, 157, 55, 43, 182, 130, 107, 216, 29, 53, 66, 164, 25, 214]
    const outputChars {.used.} = [chr 158, chr 16, chr 125, chr 157, chr 55, chr 43, chr 182, chr 130, chr 107, chr 216, chr 29, chr 53, chr 66, chr 164, chr 25, chr 214]

  test "init[HashType](): Context[HashType]":
    var ctx = init[TestHash]()
    check(ctx is Context)

  test "init(var Context[HashType])":
    var ctx: Context[TestHash]
    ctx.init()

  test "update(var Context[HashType], DataTypes)":
    var ctx: Context[TestHash]
    ctx.init()
    ctx.update(data)
    check($ctx.final() == output)

    ctx.init()
    ctx.update(dataBytes)
    check($ctx.final() == output)

    ctx.init()
    ctx.update(dataChars)
    check($ctx.final() == output)

    ctx.init()
    ctx.update(dataStream)
    check($ctx.final() == output)

    ctx.init()
    ctx.update(dataMemory)
    check($ctx.final() == output)

  test "final(var Context[HashType]): HashType":
    var ctx = init[TestHash]()
    ctx.update(data)
    var digest = ctx.final()
    check($digest == output)
    check(digest is TestHash)

  test "final(var Context[HashType], var DigestTypes)":
    block:
      var digest: TestHash
      var ctx = init[TestHash]()
      ctx.update(data)
      ctx.final(digest)
      check($digest == output)

    block:
      var digest: Digest
      var ctx = init[TestHash]()
      ctx.update(data)
      ctx.final(digest)
      check($digest == output)

    block:
      var digest = newSeq[byte](sizeof(TestHash))
      var ctx = init[TestHash]()
      ctx.update(data)
      ctx.final(digest)
      check(digest == outputBytes)

    block:
      var digest = newSeq[char](sizeof(TestHash))
      var ctx = init[TestHash]()
      ctx.update(data)
      ctx.final(digest)
      check(digest == outputChars)

  test "count[HashType](DataTypes): HashType":
    check($count[TestHash](data) == output)
    check($count[TestHash](dataBytes) == output)
    check($count[TestHash](dataChars) == output)
    check($count[TestHash](dataStream) == output)
    check($count[TestHash](dataMemory) == output)

    check(count[TestHash](data) is TestHash)
    check(count[TestHash](dataBytes) is TestHash)
    check(count[TestHash](dataChars) is TestHash)
    check(count[TestHash](dataStream) is TestHash)
    check(count[TestHash](dataMemory) is TestHash)

  test "count[HashType](DataTypes, var DigestTypes)":
    block:
      var digest: TestHash
      count[TestHash](data, digest); check($digest == output)
      count[TestHash](dataBytes, digest); check($digest == output)
      count[TestHash](dataChars, digest); check($digest == output)
      count[TestHash](dataStream, digest); check($digest == output)
      count[TestHash](dataMemory, digest); check($digest == output)

    block:
      var digest: Digest
      count[TestHash](data, digest); check($digest == output)
      count[TestHash](dataBytes, digest); check($digest == output)
      count[TestHash](dataChars, digest); check($digest == output)
      count[TestHash](dataStream, digest); check($digest == output)
      count[TestHash](dataMemory, digest); check($digest == output)

    block:
      var digest = newSeq[byte](sizeof(TestHash))
      count[TestHash](data, digest); check(digest == outputBytes)
      count[TestHash](dataBytes, digest); check(digest == outputBytes)
      count[TestHash](dataChars, digest); check(digest == outputBytes)
      count[TestHash](dataStream, digest); check(digest == outputBytes)
      count[TestHash](dataMemory, digest); check(digest == outputBytes)

    block:
      var digest = newSeq[char](sizeof(TestHash))
      count[TestHash](data, digest); check(digest == outputChars)
      count[TestHash](dataBytes, digest); check(digest == outputChars)
      count[TestHash](dataChars, digest); check(digest == outputChars)
      count[TestHash](dataStream, digest); check(digest == outputChars)
      count[TestHash](dataMemory, digest); check(digest == outputChars)

suite "Test Suites for Hmac[HashType]":
  echo "  KeyTypes = string | openarray[byte] | openarray[char] | MemoryBlock"
  echo "  DataTypes = string | openarray[byte] | openarray[char] | Stream | MemoryBlock"
  echo "  DigestTypes = HashType | Digest | openarray[byte] | openarray[char]"
  echo ""

  setup:
    type TestHash = RHASH_MD5
    const key {.used.} = "key"
    var keyBytes {.used.} = newSeq[byte](key.len)
    copyMem(addr keyBytes[0], cstring key, key.len)
    var keyChars {.used.} = newSeq[char](key.len)
    copyMem(addr keyChars[0], cstring key, key.len)
    var keyMemory {.used.} = (pointer cstring key, key.len)
    const data {.used.} = "The quick brown fox jumps over the lazy dog"
    var dataBytes {.used.} = newSeq[byte](data.len)
    copyMem(addr dataBytes[0], cstring data, data.len)
    var dataChars {.used.} = newSeq[char](data.len)
    copyMem(addr dataChars[0], cstring data, data.len)
    template dataStream: Stream {.used.} = newStringStream(data)
    var dataMemory {.used.} = (pointer cstring data, data.len)
    const output {.used.} = "80070713463e7749b90c2dc24911e275"
    const outputBytes {.used.} = [byte 128, 7, 7, 19, 70, 62, 119, 73, 185, 12, 45, 194, 73, 17, 226, 117]
    const outputChars {.used.} = [chr 128, chr 7, chr 7, chr 19, chr 70, chr 62, chr 119, chr 73, chr 185, chr 12, chr 45, chr 194, chr 73, chr 17, chr 226, chr 117]

  test "init[Hmac[HashType]](KeyTypes): Hmac[HashType]":
    check(init[Hmac[TestHash]](key) is Hmac)
    check(init[Hmac[TestHash]](keyBytes) is Hmac)
    check(init[Hmac[TestHash]](keyChars) is Hmac)
    check(init[Hmac[TestHash]](keyMemory) is Hmac)

  test "init(var Hmac[HashType], KeyTypes)":
    var ctx: Hmac[TestHash]
    ctx.init(key)
    ctx.init(keyBytes)
    ctx.init(keyChars)
    ctx.init(keyMemory)

  test "update(var Hmac[HashType], DataTypes)":
    var ctx: Hmac[TestHash]
    ctx.init(key)
    ctx.update(data)
    check($ctx.final() == output)

    ctx.init(key)
    ctx.update(dataBytes)
    check($ctx.final() == output)

    ctx.init(key)
    ctx.update(dataChars)
    check($ctx.final() == output)

    ctx.init(key)
    ctx.update(dataStream)
    check($ctx.final() == output)

    ctx.init(key)
    ctx.update(dataMemory)
    check($ctx.final() == output)

  test "final(var Hmac[HashType]): HashType":
    var ctx: Hmac[TestHash]
    ctx.init(key)
    ctx.update(data)
    var digest = ctx.final()
    check($digest == output)
    check(digest is TestHash)

  test "final(var Hmac[HashType], var DigestTypes)":
    block:
      var digest: TestHash
      var ctx = init[Hmac[TestHash]](key)
      ctx.update(data)
      ctx.final(digest)
      check($digest == output)

    block:
      var digest: Digest
      var ctx = init[Hmac[TestHash]](key)
      ctx.update(data)
      ctx.final(digest)
      check($digest == output)

    block:
      var digest = newSeq[byte](sizeof(TestHash))
      var ctx = init[Hmac[TestHash]](key)
      ctx.update(data)
      ctx.final(digest)
      check(digest == outputBytes)

    block:
      var digest = newSeq[char](sizeof(TestHash))
      var ctx = init[Hmac[TestHash]](key)
      ctx.update(data)
      ctx.final(digest)
      check(digest == outputChars)

  test "count[Hmac[HashType]](KeyTypes, DataTypes): HashType":
    check($count[Hmac[TestHash]](key, data) == output)
    check($count[Hmac[TestHash]](keyBytes, data) == output)
    check($count[Hmac[TestHash]](keyChars, data) == output)
    check($count[Hmac[TestHash]](keyMemory, data) == output)
    check($count[Hmac[TestHash]](key, dataBytes) == output)
    check($count[Hmac[TestHash]](keyBytes, dataBytes) == output)
    check($count[Hmac[TestHash]](keyChars, dataBytes) == output)
    check($count[Hmac[TestHash]](keyMemory, dataBytes) == output)
    check($count[Hmac[TestHash]](key, dataChars) == output)
    check($count[Hmac[TestHash]](keyBytes, dataChars) == output)
    check($count[Hmac[TestHash]](keyChars, dataChars) == output)
    check($count[Hmac[TestHash]](keyMemory, dataChars) == output)
    check($count[Hmac[TestHash]](key, dataStream) == output)
    check($count[Hmac[TestHash]](keyBytes, dataStream) == output)
    check($count[Hmac[TestHash]](keyChars, dataStream) == output)
    check($count[Hmac[TestHash]](keyMemory, dataStream) == output)
    check($count[Hmac[TestHash]](key, dataMemory) == output)
    check($count[Hmac[TestHash]](keyBytes, dataMemory) == output)
    check($count[Hmac[TestHash]](keyChars, dataMemory) == output)
    check($count[Hmac[TestHash]](keyMemory, dataMemory) == output)

  test "count[Hmac[HashType]](KeyTypes, DataTypes, var DigestTypes)":
    template checkDataType(data: untyped, exp: untyped) =
      count[Hmac[TestHash]](key, data, digest); check(exp)
      count[Hmac[TestHash]](keyBytes, data, digest); check(exp)
      count[Hmac[TestHash]](keyChars, data, digest); check(exp)
      count[Hmac[TestHash]](keyMemory, data, digest); check(exp)

    block:
      var digest: TestHash
      checkDataType(data, $digest == output)
      checkDataType(dataBytes, $digest == output)
      checkDataType(dataChars, $digest == output)
      checkDataType(dataStream, $digest == output)
      checkDataType(dataMemory, $digest == output)

    block:
      var digest: Digest
      checkDataType(data, $digest == output)
      checkDataType(dataBytes, $digest == output)
      checkDataType(dataChars, $digest == output)
      checkDataType(dataStream, $digest == output)
      checkDataType(dataMemory, $digest == output)

    block:
      var digest = newSeq[byte](sizeof(TestHash))
      checkDataType(data, digest == outputBytes)
      checkDataType(dataBytes, digest == outputBytes)
      checkDataType(dataChars, digest == outputBytes)
      checkDataType(dataStream, digest == outputBytes)
      checkDataType(dataMemory, digest == outputBytes)

    block:
      var digest = newSeq[char](sizeof(TestHash))
      checkDataType(data, digest == outputChars)
      checkDataType(dataBytes, digest == outputChars)
      checkDataType(dataChars, digest == outputChars)
      checkDataType(dataStream, digest == outputChars)
      checkDataType(dataMemory, digest == outputChars)

suite "Test Suites for HashObject":
  echo "  DataTypes = string | openarray[byte] | openarray[char] | Stream"
  echo "  DigestTypes = Digest | openarray[byte] | openarray[char]"
  echo ""

  setup:
    type TestHash = RHASH_MD5
    const data {.used.} = "The quick brown fox jumps over the lazy dog"
    var dataBytes {.used.} = newSeq[byte](data.len)
    copyMem(addr dataBytes[0], cstring data, data.len)
    var dataChars {.used.} = newSeq[char](data.len)
    copyMem(addr dataChars[0], cstring data, data.len)
    template dataStream: Stream {.used.} = newStringStream(data)
    var dataMemory {.used.} = (pointer cstring data, data.len)
    const output {.used.} = "9e107d9d372bb6826bd81d3542a419d6"
    const outputBytes {.used.} = [byte 158, 16, 125, 157, 55, 43, 182, 130, 107, 216, 29, 53, 66, 164, 25, 214]
    const outputChars {.used.} = [chr 158, chr 16, chr 125, chr 157, chr 55, chr 43, chr 182, chr 130, chr 107, chr 216, chr 29, chr 53, chr 66, chr 164, chr 25, chr 214]
    var ho {.used.} = toObject(TestHash)

  test "toObject(HashType): HashObject":
    check(toObject(TestHash) is HashObject)

  test "init(var HashObject)":
    ho.init()

  test "update(var HashObject, DataTypes)":
    ho.init()
    ho.update(data)
    check($ho.final() == output)

    ho.init()
    ho.update(dataBytes)
    check($ho.final() == output)

    ho.init()
    ho.update(dataChars)
    check($ho.final() == output)

    ho.init()
    ho.update(dataStream)
    check($ho.final() == output)

    ho.init()
    ho.update(dataMemory)
    check($ho.final() == output)

  test "final(var HashObject): Digest":
    ho.init()
    ho.update(data)
    check($ho.final() == output)
    check(ho.final() is Digest)

  test "final(var HashObject, var DigestTypes)":
    block:
      var digest: Digest
      ho.init()
      ho.update(data)
      ho.final(digest)
      check($digest == output)

    block:
      var digest = newSeq[byte](sizeof(TestHash))
      ho.init()
      ho.update(data)
      ho.final(digest)
      check(digest == outputBytes)

    block:
      var digest = newSeq[char](sizeof(TestHash))
      ho.init()
      ho.update(data)
      ho.final(digest)
      check(digest == outputChars)

  test "count(var HashObject, DataTypes): Digest":
    check($ho.count(data) == output)
    check($ho.count(dataBytes) == output)
    check($ho.count(dataChars) == output)
    check($ho.count(dataStream) == output)
    check($ho.count(dataMemory) == output)

    check(ho.count(data) is Digest)
    check(ho.count(dataBytes) is Digest)
    check(ho.count(dataChars) is Digest)
    check(ho.count(dataStream) is Digest)
    check(ho.count(dataMemory) is Digest)

  test "count(var HashObject, DataTypes, var DigestTypes)":
    block:
      var digest: Digest
      ho.count(data, digest); check($digest == output)
      ho.count(dataBytes, digest); check($digest == output)
      ho.count(dataChars, digest); check($digest == output)
      ho.count(dataStream, digest); check($digest == output)
      ho.count(dataMemory, digest); check($digest == output)

    block:
      var digest = newSeq[byte](sizeof(TestHash))
      ho.count(data, digest); check(digest == outputBytes)
      ho.count(dataBytes, digest); check(digest == outputBytes)
      ho.count(dataChars, digest); check(digest == outputBytes)
      ho.count(dataStream, digest); check(digest == outputBytes)
      ho.count(dataMemory, digest); check(digest == outputBytes)

    block:
      var digest = newSeq[char](sizeof(TestHash))
      ho.count(data, digest); check(digest == outputChars)
      ho.count(dataBytes, digest); check(digest == outputChars)
      ho.count(dataChars, digest); check(digest == outputChars)
      ho.count(dataStream, digest); check(digest == outputChars)
      ho.count(dataMemory, digest); check(digest == outputChars)

suite "Test Suites for HmacObject":
  echo "  KeyTypes = string | openarray[byte] | openarray[char] | MemoryBlock"
  echo "  DataTypes = string | openarray[byte] | openarray[char] | Stream | MemoryBlock"
  echo "  DigestTypes = Digest | openarray[byte] | openarray[char]"
  echo ""

  setup:
    type TestHash = RHASH_MD5
    const key {.used.} = "key"
    var keyBytes {.used.} = newSeq[byte](key.len)
    copyMem(addr keyBytes[0], cstring key, key.len)
    var keyChars {.used.} = newSeq[char](key.len)
    copyMem(addr keyChars[0], cstring key, key.len)
    var keyMemory {.used.} = (pointer cstring key, key.len)
    const data {.used.} = "The quick brown fox jumps over the lazy dog"
    var dataBytes {.used.} = newSeq[byte](data.len)
    copyMem(addr dataBytes[0], cstring data, data.len)
    var dataChars {.used.} = newSeq[char](data.len)
    copyMem(addr dataChars[0], cstring data, data.len)
    template dataStream: Stream {.used.} = newStringStream(data)
    var dataMemory {.used.} = (pointer cstring data, data.len)
    const output {.used.} = "80070713463e7749b90c2dc24911e275"
    const outputBytes {.used.} = [byte 128, 7, 7, 19, 70, 62, 119, 73, 185, 12, 45, 194, 73, 17, 226, 117]
    const outputChars {.used.} = [chr 128, chr 7, chr 7, chr 19, chr 70, chr 62, chr 119, chr 73, chr 185, chr 12, chr 45, chr 194, chr 73, chr 17, chr 226, chr 117]
    var ho {.used.} = toHmacObject(TestHash)

  test "toHmacObject(HashType | HashObject): HmacObject":
    check(toHmacObject(TestHash) is HmacObject)
    check(toHmacObject(toObject(TestHash)) is HmacObject)

  test "init(var HmacObject, KeyTypes)":
    ho.init(key)
    ho.init(keyBytes)
    ho.init(keyChars)
    ho.init(keyMemory)

  test "update(var HmacObject, DataTypes)":
    ho.init(key)
    ho.update(data)
    check($ho.final() == output)

    ho.init(key)
    ho.update(dataBytes)
    check($ho.final() == output)

    ho.init(key)
    ho.update(dataChars)
    check($ho.final() == output)

    ho.init(key)
    ho.update(dataStream)
    check($ho.final() == output)

    ho.init(key)
    ho.update(dataMemory)
    check($ho.final() == output)

  test "final(var HmacObject): Digest":
    ho.init(key)
    ho.update(data)
    check($ho.final() == output)
    check(ho.final() is Digest)

  test "final(var HmacObject, DigestTypes)":
    block:
      var digest: Digest
      ho.init(key)
      ho.update(data)
      ho.final(digest)
      check($digest == output)

    block:
      var digest = newSeq[byte](sizeof(TestHash))
      ho.init(key)
      ho.update(data)
      ho.final(digest)
      check(digest == outputBytes)

    block:
      var digest = newSeq[char](sizeof(TestHash))
      ho.init(key)
      ho.update(data)
      ho.final(digest)
      check(digest == outputChars)

  test "count(var HmacObject, KeyTypes, DigestTypes): Digest":
    template checkDataType(data: untyped) =
      check($ho.count(key, data) == output)
      check($ho.count(keyBytes, data) == output)
      check($ho.count(keyChars, data) == output)
      check($ho.count(keyMemory, data) == output)

    checkDataType(data)
    checkDataType(dataBytes)
    checkDataType(dataChars)
    checkDataType(dataStream)
    checkDataType(dataMemory)

  test "count(var HmacObject, KeyTypes, DigestTypes, var DigestTypes)":
    template checkDataType(data: untyped, exp: untyped) =
      ho.count(key, data, digest); check(exp)
      ho.count(keyBytes, data, digest); check(exp)
      ho.count(keyChars, data, digest); check(exp)
      ho.count(keyMemory, data, digest); check(exp)

    block:
      var digest: Digest
      checkDataType(data, $digest == output)
      checkDataType(dataBytes, $digest == output)
      checkDataType(dataChars, $digest == output)
      checkDataType(dataStream, $digest == output)
      checkDataType(dataMemory, $digest == output)

    block:
      var digest = newSeq[byte](sizeof(TestHash))
      checkDataType(data, digest == outputBytes)
      checkDataType(dataBytes, digest == outputBytes)
      checkDataType(dataChars, digest == outputBytes)
      checkDataType(dataStream, digest == outputBytes)
      checkDataType(dataMemory, digest == outputBytes)

    block:
      var digest = newSeq[char](sizeof(TestHash))
      checkDataType(data, digest == outputChars)
      checkDataType(dataBytes, digest == outputChars)
      checkDataType(dataChars, digest == outputChars)
      checkDataType(dataStream, digest == outputChars)
      checkDataType(dataMemory, digest == outputChars)
