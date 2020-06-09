/*
 * Implementation of Shabal: portable code.
 *
 * -----------------------------------------------------------------------
 * (c) 2010 SAPHIR project. This software is provided 'as-is', without
 * any epxress or implied warranty. In no event will the authors be held
 * liable for any damages arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to no restriction.
 *
 * Technical remarks and questions can be addressed to:
 * <thomas.pornin@cryptolog.com>
 * -----------------------------------------------------------------------
 */

#include <stddef.h>
#include <string.h>

#include "shabal_tiny.h"

#if CHAR_BIT != 8
#error This code requires 8-bit bytes
#endif

typedef shabal_u32 u32;

#define C32(x)         ((u32)x ## UL)
#define T32(x)         ((x) & C32(0xFFFFFFFF))
#define ROTL32(x, n)   T32(((x) << (n)) | ((x) >> (32 - (n))))

#if defined __i386__ || defined _M_IX86 || defined __x86_64 || defined _M_X64 \
	|| MIPSEL || _MIPSEL || __MIPSEL || __MIPSEL__ \
	|| (defined __arm__ && __ARMEL__) \
	|| defined __LITTLE_ENDIAN__ || defined _LITTLE_ENDIAN
#define SHABAL_LITTLE_ENDIAN   1
#endif

#define A(x)   (sc->state[x])
#define B(x)   (sc->state[(x) + 12])
#define C(x)   (sc->state[(x) + 28])

static void
shabal_inner(shabal_context *sc)
{
	size_t u, v;
	u32 ap;
	u32 Bx[64];

#if SHABAL_LITTLE_ENDIAN
	/*
	 * Since 'buf' is the first field in shabal_context, and that
	 * structure contains 32-bit words, we know that the buffer is
	 * properly aligned for direct 32-bit access.
	 */
#define M(x)   (*((u32 *)sc->buf + (x)))
#else
	/*
	 * On non-little-endian platforms, we decode once, and use a
	 * temporary array to store the decoded words.
	 */
	u32 Mbuf[16];

	for (u = 0; u < 16; u ++) {
		Mbuf[u] = (u32)(sc->buf[(u << 2) + 0])
			| ((u32)sc->buf[(u << 2) + 1] << 8)
			| ((u32)sc->buf[(u << 2) + 2] << 16)
			| ((u32)sc->buf[(u << 2) + 3] << 24);
	}
#define M(x)   (Mbuf[x])
#endif

	for (u = 0; u < 16; u ++) {
		u32 z = T32(B(u) + M(u));
		Bx[u] = ROTL32(z, 17);
	}
	A(0) ^= sc->Wlow;
	A(1) ^= sc->Whigh;
	ap = A(11);
	for (u = 0, v = 0; u < 48; u ++) {
		u32 an;

		an = A(v);
		an = T32((an ^ (ROTL32(ap, 15) * 5U)
			^ C((56 - u) & 15)) * 3U)
			^ Bx[u + 13] ^ (Bx[u + 9] & ~Bx[u + 6])
			^ M(u & 15);
		Bx[u + 16] = ~ROTL32(Bx[u], 1) ^ an;
		A(v) = an;
		ap = an;
		if (++ v == 12)
			v = 0;
	}
	for (u = 0, v = 11; u < 36; u ++) {
		A(v) = T32(A(v) + C((38 - u) & 15));
		if (v -- == 0)
			v = 11;
	}
	for (u = 0; u < 16; u ++)
		B(u) = T32(C(u) - M(u));
	memcpy(&C(0), &Bx[48], 16 * sizeof(u32));

#undef M
}

/* see shabal_tiny.h */
void
shabal_init(shabal_context *sc, unsigned out_size)
{
	unsigned u;

	for (u = 0; u < 44; u ++)
		sc->state[u] = 0;
	memset(sc->buf, 0, sizeof sc->buf);
	for (u = 0; u < 16; u ++) {
		sc->buf[4 * u + 0] = (out_size + u);
		sc->buf[4 * u + 1] = (out_size + u) >> 8;
	}
	sc->Whigh = sc->Wlow = C32(0xFFFFFFFF);
	shabal_inner(sc);
	for (u = 0; u < 16; u ++) {
		sc->buf[4 * u + 0] = (out_size + u + 16);
		sc->buf[4 * u + 1] = (out_size + u + 16) >> 8;
	}
	sc->Whigh = sc->Wlow = 0;
	shabal_inner(sc);
	sc->Wlow = 1;
	sc->ptr = 0;
	sc->out_size = out_size;
}

/* see shabal_tiny.h */
void
shabal(shabal_context *sc, const void *data, size_t len)
{
	size_t ptr;

	ptr = sc->ptr;
	while (len > 0) {
		size_t clen;

		clen = (sizeof sc->buf) - ptr;
		if (clen > len)
			clen = len;
		memcpy(sc->buf + ptr, data, clen);
		ptr += clen;
		data = (const unsigned char *)data + clen;
		len -= clen;
		if (ptr == sizeof sc->buf) {
			shabal_inner(sc);
			if ((sc->Wlow = T32(sc->Wlow + 1)) == 0)
				sc->Whigh = T32(sc->Whigh + 1);
			ptr = 0;
		}
	}
	sc->ptr = ptr;
}

/* see shabal_tiny.h */
void
shabal_close(shabal_context *sc, unsigned ub, unsigned n, void *dst)
{
	size_t ptr;
	unsigned z, out_size_w32;
	unsigned char *out;

	z = 0x80 >> n;
	ptr = sc->ptr;
	sc->buf[ptr ++] = (ub & -z) | z;
	memset(sc->buf + ptr, 0, (sizeof sc->buf) - ptr);
	for (z = 0; z < 4; z ++)
		shabal_inner(sc);
	out = dst;
	out_size_w32 = sc->out_size >> 5;
	for (z = 0; z < out_size_w32; z ++) {
		u32 w = C(z + (16 - out_size_w32));

		out[4 * z + 0] = w;
		out[4 * z + 1] = (w >> 8);
		out[4 * z + 2] = (w >> 16);
		out[4 * z + 3] = (w >> 24);
	}
}

#undef A
#undef B
#undef C
