# Package

version       = "1.0.1"
author        = "Ward"
description   = "Hash Library for Nim"
license       = "MIT"
skipDirs      = @["examples", "tests"]

# Dependencies

requires "nim >= 1.2.0", "nimcrypto >= 0.4.11"

# Tests

task test, "Runs the test suite":
  exec "nim c -r tests/api_test"

task md5_bench, "Runs the md5 benchmark":
  exec "nim c -r -d:release --opt:speed tests/md5_bench"

task sha1_bench, "Runs the sha1 benchmark":
  exec "nim c -r -d:release --opt:speed tests/sha1_bench"

task sha2_bench, "Runs the sha2 benchmark":
  exec "nim c -r -d:release --opt:speed tests/sha2_bench"

task sha3_bench, "Runs the sha3 benchmark":
  exec "nim c -r -d:release --opt:speed tests/sha3_bench"

task all_bench, "Runs the all benchmark":
  exec "nim c -r -d:release --opt:speed tests/all_bench"

# Clean

task clean, "Delete all the executable files":
  exec "cmd /c IF EXIST tests\\*.exe del tests\\*.exe"
  exec "cmd /c IF EXIST examples\\*.exe del examples\\*.exe"
