#====================================================================
#
#                hashlib - Hash Library for Nim
#                   (c) Copyright 2020 Ward
#
#====================================================================

when defined(nimHasUsed): {.used.}

import sph/blake as sph_blake
import sph/bmw as sph_bmw
import sph/cubehash as sph_cubehash
import sph/echohash as sph_echohash
import sph/fugue as sph_fugue
import sph/groestl as sph_groestl
import sph/hamsi as sph_hamsi
import sph/haval as sph_haval
import sph/jh as sph_jh
import sph/keccak as sph_keccak
import sph/luffa as sph_luffa
import sph/md2 as sph_md2
import sph/md4 as sph_md4
import sph/md5 as sph_md5
import sph/panama as sph_panama
import sph/radiogatun as sph_radiogatun
import sph/ripemd as sph_ripemd
import sph/sha0 as sph_sha0
import sph/sha1 as sph_sha1
import sph/sha256 as sph_sha256
import sph/sha512 as sph_sha512
import sph/shabal as sph_shabal
import sph/shavite as sph_shavite
import sph/simd as sph_simd
import sph/skein as sph_skein
import sph/tiger as sph_tiger
import sph/whirlpool as sph_whirlpool

export sph_blake
export sph_bmw
export sph_cubehash
export sph_echohash
export sph_fugue
export sph_groestl
export sph_hamsi
export sph_haval
export sph_jh
export sph_keccak
export sph_luffa
export sph_md2
export sph_md4
export sph_md5
export sph_panama
export sph_radiogatun
export sph_ripemd
export sph_sha0
export sph_sha1
export sph_sha256
export sph_sha512
export sph_shabal
export sph_shavite
export sph_simd
export sph_skein
export sph_tiger
export sph_whirlpool

when isMainModule:
  template test(HashType: typedesc, data: string, result: string) =
    doAssert $count[HashType](data) == result
    echo $HashType, " ok"

  test(SPH_BLAKE224, "", "7dc5313b1c04512a174bd6503b89607aecbee0903d40a8a569c94eed")
  test(SPH_BLAKE256, "", "716f6e863f744b9ac22c97ec7b76ea5f5908bc5b2f67c61510bfc4751384ea7a")
  test(SPH_BLAKE384, "", "c6cbd89c926ab525c242e6621f2f5fa73aa4afe3d9e24aed727faaadd6af38b620bdb623dd2b4788b1c8086984af8706")
  test(SPH_BLAKE512, "", "a8cfbbd73726062df0c6864dda65defe58ef0cc52a5625090fa17601e1eecd1b628e94f396ae402a00acc9eab77b4d4c2e852aaaa25a636d80af3fc7913ef5b8")
  test(SPH_BMW224, "", "e57c183da7e2cd3e90258ca04499b222420f9b6797bbab131b4d286e")
  test(SPH_BMW256, "", "82cac4bf6f4c2b41fbcc0e0984e9d8b76d7662f8e1789cdfbd85682acc55577a")
  test(SPH_BMW384, "", "1db2643911391720e712a8c24457ee456fabfd555f479156e4b24278d6f6bcfb03fab1ec2a2626b79f2880216bc29b29")
  test(SPH_BMW512, "", "6a725655c42bc8a2a20549dd5a233a6a2beb01616975851fd122504e604b46af7d96697d0b6333db1d1709d6df328d2a6c786551b0cce2255e8c7332b4819c0e")
  test(SPH_CUBEHASH224, "", "f9802aa6955f4b7cf3b0f5a378fa0c9f138e0809d250966879c873ab")
  test(SPH_CUBEHASH256, "", "44c6de3ac6c73c391bf0906cb7482600ec06b216c7c54a2a8688a6a42676577d")
  test(SPH_CUBEHASH384, "", "98ae93ebf4e58958497f610a22c8cf60f2292319283ca6459daed1707be06e7591c5f2d84bd3339e66c770e485bfa1fb")
  test(SPH_CUBEHASH512, "", "4a1d00bbcfcb5a9562fb981e7f7db3350fe2658639d948b9d57452c22328bb32f468b072208450bad5ee178271408be0b16e5633ac8a1e3cf9864cfbfc8e043a")
  test(SPH_ECHO224, "", "17da087595166f733fff7cdb0bca6438f303d0e00c48b5e7a3075905")
  test(SPH_ECHO256, "", "4496cd09d425999aefa75189ee7fd3c97362aa9e4ca898328002d20a4b519788")
  test(SPH_ECHO384, "", "134040763f840559b84b7a1ae5d6d64fc3659821a789cc64a7f1444c09ee7f81a54d72beee8273bae5ef18ec43aa5f34")
  test(SPH_ECHO512, "", "158f58cc79d300a9aa292515049275d051a28ab931726d0ec44bdd9faef4a702c36db9e7922fff077402236465833c5cc76af4efc352b4b44c7fa15aa0ef234e")
  test(SPH_FUGUE224, "", "e2cd30d51a913c4ed2388a141f90caa4914de43010849e7b8a7a9ccd")
  test(SPH_FUGUE256, "", "d6ec528980c130aad1d1acd28b9dd8dbdeae0d79eded1fca72c2af9f37c2246f")
  test(SPH_FUGUE384, "", "466d05f6812b58b8628e53816b2a99d173b804a964de971829159c3791ac8b524eebbf5fc73ba40ea8eea446d5424a30")
  test(SPH_FUGUE512, "", "3124f0cbb5a1c2fb3ce747ada63ed2ab3bcd74795cef2b0e805d5319fcc360b4617b6a7eb631d66f6d106ed0724b56fa8c1110f9b8df1c6898e7ca3c2dfccf79")
  test(SPH_GROESTL224, "", "f2e180fb5947be964cd584e22e496242c6a329c577fc4ce8c36d34c3")
  test(SPH_GROESTL256, "", "1a52d11d550039be16107f9c58db9ebcc417f16f736adb2502567119f0083467")
  test(SPH_GROESTL384, "", "ac353c1095ace21439251007862d6c62f829ddbe6de4f78e68d310a9205a736d8b11d99bffe448f57a1cfa2934f044a5")
  test(SPH_GROESTL512, "", "6d3ad29d279110eef3adbd66de2a0345a77baede1557f5d099fce0c03d6dc2ba8e6d4a6633dfbd66053c20faa87d1a11f39a7fbe4a6c2f009801370308fc4ad8")
  test(SPH_HAMSI224, "", "b9f6eb1a9b990373f9d2cb125584333c69a3d41ae291845f05da221f")
  test(SPH_HAMSI256, "", "750e9ec469f4db626bee7e0c10ddaa1bd01fe194b94efbabebd24764dc2b13e9")
  test(SPH_HAMSI384, "", "3943cd34e3b96b197a8bf4bac7aa982d18530dd12f41136b26d7e88759255f21153f4a4bd02e523612b8427f9dd96c8d")
  test(SPH_HAMSI512, "", "5cd7436a91e27fc809d7015c3407540633dab391127113ce6ba360f0c1e35f404510834a551610d6e871e75651ea381a8ba628af1dcf2b2be13af2eb6247290f")
  test(SPH_HAVAL128_3, "", "c68f39913f901f3ddf44c707357a7d70")
  test(SPH_HAVAL128_4, "", "ee6bbf4d6a46a679b3a856c88538bb98")
  test(SPH_HAVAL128_5, "", "184b8482a0c050dca54b59c7f05bf5dd")
  test(SPH_HAVAL160_3, "", "d353c3ae22a25401d257643836d7231a9a95f953")
  test(SPH_HAVAL160_4, "", "1d33aae1be4146dbaaca0b6e70d7a11f10801525")
  test(SPH_HAVAL160_5, "", "255158cfc1eed1a7be7c55ddd64d9790415b933b")
  test(SPH_HAVAL192_3, "", "e9c48d7903eaf2a91c5b350151efcb175c0fc82de2289a4e")
  test(SPH_HAVAL192_4, "", "4a8372945afa55c7dead800311272523ca19d42ea47b72da")
  test(SPH_HAVAL192_5, "", "4839d0626f95935e17ee2fc4509387bbe2cc46cb382ffe85")
  test(SPH_HAVAL224_3, "", "c5aae9d47bffcaaf84a8c6e7ccacd60a0dd1932be7b1a192b9214b6d")
  test(SPH_HAVAL224_4, "", "3e56243275b3b81561750550e36fcd676ad2f5dd9e15f2e89e6ed78e")
  test(SPH_HAVAL224_5, "", "4a0513c032754f5582a758d35917ac9adf3854219b39e3ac77d1837e")
  test(SPH_HAVAL256_3, "", "4f6938531f0bc8991f62da7bbd6f7de3fad44562b8c6f4ebf146d5b4e46f7c17")
  test(SPH_HAVAL256_4, "", "c92b2e23091e80e375dadce26982482d197b1a2521be82da819f8ca2c579b99b")
  test(SPH_HAVAL256_5, "", "be417bb4dd5cfb76c7126f4f8eeb1553a449039307b1a3cd451dbfdc0fbbe330")
  test(SPH_JH224, "", "2c99df889b019309051c60fecc2bd285a774940e43175b76b2626630")
  test(SPH_JH256, "", "46e64619c18bb0a92a5e87185a47eef83ca747b8fcc8e1412921357e326df434")
  test(SPH_JH384, "", "2fe5f71b1b3290d3c017fb3c1a4d02a5cbeb03a0476481e25082434a881994b0ff99e078d2c16b105ad069b569315328")
  test(SPH_JH512, "", "90ecf2f76f9d2c8017d979ad5ab96b87d58fc8fc4b83060f3f900774faa2c8fabe69c5f4ff1ec2b61d6b316941cedee117fb04b1f4c5bc1b919ae841c50eec4f")
  test(SPH_KECCAK224, "", "f71837502ba8e10837bdd8d365adb85591895602fc552b48b7390abd")
  test(SPH_KECCAK256, "", "c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470")
  test(SPH_KECCAK384, "", "2c23146a63a29acf99e73b88f8c24eaa7dc60aa771780ccc006afbfa8fe2479b2dd2b21362337441ac12b515911957ff")
  test(SPH_KECCAK512, "", "0eab42de4c3ceb9235fc91acffe746b29c29a8c366b7c60e4e67c466f36a4304c00fa9caf9d87976ba469bcbe06713b435f091ef2769fb160cdab33d3670680e")
  test(SPH_LUFFA224, "", "dbb8665871f4154d3e4396aefbba417cb7837dd683c332ba6be87e02")
  test(SPH_LUFFA256, "", "dbb8665871f4154d3e4396aefbba417cb7837dd683c332ba6be87e02a2712d6f")
  test(SPH_LUFFA384, "", "117d3ad49024dfe2994f4e335c9b330b48c537a13a9b7fa465938e1a02ff862bcdf33838bc0f371b045d26952d3ea0c5")
  test(SPH_LUFFA512, "", "6e7de4501189b3ca58f3ac114916654bbcd4922024b4cc1cd764acfe8ab4b7805df133eab345ffdb1c414564c924f48e0a301824e2ac4c34bd4efde2e43da90e")
  test(SPH_MD2, "", "8350e5a3e24c153df2275c9f80692773")
  test(SPH_MD4, "", "31d6cfe0d16ae931b73c59d7e0c089c0")
  test(SPH_MD5, "", "d41d8cd98f00b204e9800998ecf8427e")
  test(SPH_PANAMA, "", "aa0cc954d757d7ac7779ca3342334ca471abd47d5952ac91ed837ecd5b16922b")
  test(SPH_RADIOGATUN32, "", "f30028b54afab6b3e55355d277711109a19beda7091067e9a492fb5ed9f20117")
  test(SPH_RADIOGATUN64, "", "64a9a7fa139905b57bdab35d33aa216370d5eae13e77bfcdd85513408311a584")
  test(SPH_RIPEMD, "", "9f73aa9b372a9dacfb86a6108852e2d9")
  test(SPH_RIPEMD128, "", "cdf26213a150dc3ecb610f18f6b38b46")
  test(SPH_RIPEMD160, "", "9c1185a5c5e9fc54612808977ee8f548b2258d31")
  test(SPH_SHA0, "", "f96cea198ad1dd5617ac084a3d92c6107708c0ef")
  test(SPH_SHA1, "", "da39a3ee5e6b4b0d3255bfef95601890afd80709")
  test(SPH_SHA224, "", "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f")
  test(SPH_SHA256, "", "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
  test(SPH_SHA384, "", "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b")
  test(SPH_SHA512, "", "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e")
  test(SPH_SHA3_224, "", "6b4e03423667dbb73b6e15454f0eb1abd4597f9a1b078e3f5b5a6bc7")
  test(SPH_SHA3_256, "", "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a")
  test(SPH_SHA3_384, "", "0c63a75b845e4f7d01107d852e4c2485c51a50aaaa94fc61995e71bbee983a2ac3713831264adb47fb6bd1e058d5f004")
  test(SPH_SHA3_512, "", "a69f73cca23a9ac5c8b567dc185a756e97c982164fe25859e0d1dcc1475c80a615b2123af1f5f94c11e3e9402c3ac558f500199d95b6d3e301758586281dcd26")
  test(SPH_SHABAL192, "", "e10dc32232f98b039dbbcfa41269b9cdf67a73c841214c81")
  test(SPH_SHABAL224, "", "562b4fdbe1706247552927f814b66a3d74b465a090af23e277bf8029")
  test(SPH_SHABAL256, "", "aec750d11feee9f16271922fbaf5a9be142f62019ef8d720f858940070889014")
  test(SPH_SHABAL384, "", "ff093d67d22b06a674b5f384719150d617e0ff9c8923569a2ab60cda886df63c91a25f33cd71cc22c9eebc5cd6aee52a")
  test(SPH_SHABAL512, "", "fc2d5dff5d70b7f6b1f8c2fcc8c1f9fe9934e54257eded0cf2b539a2ef0a19ccffa84f8d9fa135e4bd3c09f590f3a927ebd603ac29eb729e6f2a9af031ad8dc6")
  test(SPH_SHAVITE224, "", "b33f761f0d3a86bb1051905aec7a691bd0b5a24c3721f67d8e48d839")
  test(SPH_SHAVITE256, "", "08c5825af2e9e5947286a8fe208bd5f8c6a7c8e4da598947d7ff8eda0fcd2bd7")
  test(SPH_SHAVITE384, "", "814b55553ce7c0841f8ff0321e6287f9f50a8e0cae811932385ecc1b7c386b4eb14edb79c8381babf09276b69d1bb3ee")
  test(SPH_SHAVITE512, "", "a485c1b2578459d1efc5dddd840bb0b4a650ac82fe68f58c4442ccda747da006b2d1dc6b4a4eb7d84ff91e1f466fef429d259acd995dddcad16fa545c7a6e5ba")
  test(SPH_SIMD224, "", "43e1d53656d7b85d10d5499e28afdef90bb497730d2853c8609b534b")
  test(SPH_SIMD256, "", "8029e81e7320e13ed9001dc3d8021fec695b7a25cd43ad805260181c35fcaea8")
  test(SPH_SIMD384, "", "5fdd62778fc213221890ad3bac742a4af107ce2692d6112e795b54b25dcd5e0f4bf3ef1b770ab34b38f074a5e0ecfcb5")
  test(SPH_SIMD512, "", "51a5af7e243cd9a5989f7792c880c4c3168c3d60c4518725fe5757d1f7a69c6366977eaba7905ce2da5d7cfd07773725f0935b55f3efb954996689a49b6d29e0")
  test(SPH_SKEIN224, "", "1541ae9fc3ebe24eb758ccb1fd60c2c31a9ebfe65b220086e7819e25")
  test(SPH_SKEIN256, "", "39ccc4554a8b31853b9de7a1fe638a24cce6b35a55f2431009e18780335d2621")
  test(SPH_SKEIN384, "", "dd5aaf4589dc227bd1eb7bc68771f5baeaa3586ef6c7680167a023ec8ce26980f06c4082c488b4ac9ef313f8cbe70808")
  test(SPH_SKEIN512, "", "bc5b4c50925519c290cc634277ae3d6257212395cba733bbad37a4af0fa06af41fca7903d06564fea7a2d3730dbdb80c1f85562dfcc070334ea4d1d9e72cba7a")
  test(SPH_TIGER, "", "3293ac630c13f0245f92bbb1766e16167a4e58492dde73f3")
  test(SPH_TIGER2, "", "4441be75f6018773c206c22745374b924aa8313fef919f41")
  test(SPH_WHIRLPOOL, "", "19fa61d75522a4669b44e39c1d2e1726c530232130d407f89afee0964997f7a73e83be698b288febcf88e3e03c4f0757ea8964e59b63d93708b138cc42a66eb3")
  test(SPH_WHIRLPOOL0, "", "b3e1ab6eaf640a34f784593f2074416accd3b8e62c620175fca0997b1ba2347339aa0d79e754c308209ea36811dfa40c1c32f1a2b9004725d987d3635165d3c8")
  test(SPH_WHIRLPOOL1, "", "470f0409abaa446e49667d4ebe12a14387cedbd10dd17b8243cad550a089dc0feea7aa40f6c2aaab71c6ebd076e43c7cfca0ad32567897dcb5969861049a0f5a")
