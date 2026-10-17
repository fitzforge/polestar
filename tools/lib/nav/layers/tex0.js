'use strict';
// A tex0 ADT (the split ADT's texture file, MAID index 3): the tile's
// diffuse textures by FileDataID and, per MCNK, its texture layers and their
// alpha maps (wowdev.wiki ADT/v18). Checked on Forever 1.60.1.70425 (Azeroth
// 31_49, tex0 777835; Kalimdor 36_32, tex0 785778): MVER MAMP MDID MHID
// MCNK x256, each MCNK holding only MCLY and MCAL (no header, no MCSH); the
// MCNKs come in the root's order, n = y * 16 + x (x eastward, y southward).
//
// MDID: u32 FileDataIDs of the diffuse textures (the `_s.blp` files),
// indexed by MCLY.textureId. MCLY: 16 bytes per layer (at most 4): textureId,
// flags, offsetInMCAL, effectId. Layer 0 is the base, without alpha; a layer
// with flag 0x100 has an alpha map at offsetInMCAL: with 0x200 RLE-compressed
// to 4096 bytes (a byte: bit 7 fill, else copy; low 7 bits the count; a fill
// repeats the next byte, a copy takes the next count bytes), else 4096 bytes
// when the WDT's MPHD has flag 0x4 or 0x80 ('big alpha'), else 2048 bytes of
// 4-bit values (low nibble first, scaled by 17). A 4-bit map whose root MCNK
// lacks flag 0x8000 (do_not_fix_alpha_map) is 63 x 63: its last row and
// column repeat the ones before. Forever's continents: MPHD flags 0x3ca (big
// alpha), every layer compressed or 8-bit, every root MCNK with 0x8000.
// An alpha map is 64 x 64, row-major, rows southward, x eastward.

const { chunks, chunk } = require('../geom/adt');

const SIZE = 64;
const ALPHA = SIZE * SIZE;
const FLAG_ALPHA = 0x100;
const FLAG_COMPRESSED = 0x200;
const MPHD_BIG_ALPHA = 0x4 | 0x80;

// RLE alpha at data[o..] -> Uint8Array(4096).
function inflate(data, o) {
	const out = new Uint8Array(ALPHA);
	let n = 0;
	while (n < ALPHA) {
		if (o >= data.length) throw new Error(`tex0: compressed alpha map ends after ${n} of ${ALPHA} values`);
		const b = data[o++];
		const count = Math.min(b & 0x7f, ALPHA - n);
		if (b & 0x80) {
			out.fill(data[o++], n, n + count);
		} else {
			if (o + count > data.length) throw new Error('tex0: compressed alpha map copies past the end of MCAL');
			out.set(data.subarray(o, o + count), n);
			o += count;
		}
		n += count;
	}
	return out;
}

function fourBit(data, o, fix) {
	if (o + ALPHA / 2 > data.length) throw new Error('tex0: 4-bit alpha map past the end of MCAL');
	const out = new Uint8Array(ALPHA);
	for (let k = 0; k < ALPHA / 2; k++) {
		const b = data[o + k];
		out[2 * k] = (b & 0x0f) * 17;
		out[2 * k + 1] = (b >> 4) * 17;
	}
	if (fix) {
		for (let y = 0; y < SIZE; y++) out[y * SIZE + SIZE - 1] = out[y * SIZE + SIZE - 2];
		out.copyWithin((SIZE - 1) * SIZE, (SIZE - 2) * SIZE, (SIZE - 1) * SIZE);
	}
	return out;
}

// One layer's alpha map, or null when it has none.
function alphaOf(mcal, flags, offset, { bigAlpha, fix }) {
	if (!(flags & FLAG_ALPHA) || !mcal) return null;
	if (flags & FLAG_COMPRESSED) return inflate(mcal, offset);
	if (bigAlpha) {
		if (offset + ALPHA > mcal.length) throw new Error('tex0: alpha map past the end of MCAL');
		return Uint8Array.from(mcal.subarray(offset, offset + ALPHA));
	}
	return fourBit(mcal, offset, fix);
}

// tex0 buffer -> { textures: [fdid] (MDID), chunks: [256 x { layers: [{ tex, flags, alpha: Uint8Array(4096) | null }] }] }
// opts.bigAlpha: the WDT's MPHD flags & (0x4 | 0x80) (default true); opts.fix:
// the 4-bit fix, true for every chunk, or a function n -> bool (the root
// MCNK n lacks 0x8000).
function parseTex0(buf, { bigAlpha = true, fix = false } = {}) {
	const top = chunks(buf);
	const mdid = chunk(top, 'MDID');
	const textures = [];
	if (mdid) for (let o = 0; o + 4 <= mdid.length; o += 4) textures.push(mdid.readUInt32LE(o));
	const out = [];
	for (const c of top) {
		if (c.tag !== 'MCNK') continue;
		const n = out.length;
		const subs = chunks(c.data);
		const mcly = chunk(subs, 'MCLY');
		const mcal = chunk(subs, 'MCAL');
		const opts = { bigAlpha, fix: typeof fix === 'function' ? fix(n) : !!fix };
		const layers = [];
		if (mcly) {
			for (let o = 0; o + 16 <= mcly.length; o += 16) {
				const flags = mcly.readUInt32LE(o + 4);
				layers.push({ tex: mcly.readUInt32LE(o), flags, alpha: o ? alphaOf(mcal, flags, mcly.readUInt32LE(o + 8), opts) : null });
			}
		}
		out.push({ layers });
	}
	if (out.length !== 256) throw new Error(`tex0: ${out.length} MCNK chunks, not 256`);
	return { textures, chunks: out };
}

module.exports = { parseTex0, inflate, MPHD_BIG_ALPHA, FLAG_ALPHA, FLAG_COMPRESSED };
