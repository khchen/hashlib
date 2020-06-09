when defined(nimHasUsed): {.used.}

when defined(cpu64):
  {.compile: "xkcp64/KeccakSponge.c".}
  {.compile: "xkcp64/KeccakP-1600-opt64.c".}
else:
  {.compile: "xkcp32/KeccakSponge.c".}
  {.compile: "xkcp32/KeccakP-1600-inplace32BI.c".}
