#include <stddef.h>
#include "ustd.h"
#include "crc32.h"

/**
 * Initialize crc32 hash.
 *
 * @param crc32 pointer to the hash to initialize
 */
void rhash_crc32_init(uint32_t* crc32)
{
  *crc32 = 0; /* note: context size is sizeof(uint32_t) */
}

/**
 * Calculate message CRC32 hash.
 * Can be called repeatedly with chunks of the message to be hashed.
 *
 * @param crc32 pointer to the hash
 * @param msg message chunk
 * @param size length of the message chunk
 */
void rhash_crc32_update(uint32_t* crc32, const unsigned char* msg, size_t size)
{
  *crc32 = rhash_get_crc32(*crc32, msg, size);
}

/**
 * Store calculated hash into the given array.
 *
 * @param crc32 pointer to the current hash value
 * @param result calculated hash in binary form
 */
void rhash_crc32_final(uint32_t* crc32, unsigned char* result)
{
#if defined(CPU_IA32) || defined(CPU_X64)
  /* intel CPUs support assigment with non 32-bit aligned pointers */
  *(unsigned*)result = be2me_32(*crc32);
#else
  /* correct saving BigEndian integer on all archs */
  result[0] = (unsigned char)(*crc32 >> 24), result[1] = (unsigned char)(*crc32 >> 16);
  result[2] = (unsigned char)(*crc32 >> 8), result[3] = (unsigned char)(*crc32);
#endif
}

/**
 * Initialize crc32c hash.
 *
 * @param crc32c pointer to the hash to initialize
 */
void rhash_crc32c_init(uint32_t* crc32c)
{
  *crc32c = 0; /* note: context size is sizeof(uint32_t) */
}

/**
 * Calculate message CRC32C hash.
 * Can be called repeatedly with chunks of the message to be hashed.
 *
 * @param crc32c pointer to the hash
 * @param msg message chunk
 * @param size length of the message chunk
 */
void rhash_crc32c_update(uint32_t* crc32c, const unsigned char* msg, size_t size)
{
  *crc32c = rhash_get_crc32c(*crc32c, msg, size);
}

/**
 * Store calculated hash into the given array.
 *
 * @param crc32c pointer to the current hash value
 * @param result calculated hash in binary form
 */
void rhash_crc32c_final(uint32_t* crc32c, unsigned char* result)
{
#if defined(CPU_IA32) || defined(CPU_X64)
  /* intel CPUs support assigment with non 32-bit aligned pointers */
  *(unsigned*)result = be2me_32(*crc32c);
#else
  /* correct saving BigEndian integer on all archs */
  result[0] = (unsigned char)(*crc32c >> 24), result[1] = (unsigned char)(*crc32c >> 16);
  result[2] = (unsigned char)(*crc32c >> 8), result[3] = (unsigned char)(*crc32c);
#endif
}
