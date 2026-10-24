// node:crypto for the browser planner's worker: createHash('sha1') (synchronous, as the planner hashes
// guide texts), the only hash its code asks for.

function sha1Bytes(bytes) {
	const ml = bytes.length;
	const withPad = ((ml + 9 + 63) >> 6) << 6;
	const m = new Uint8Array(withPad);
	m.set(bytes);
	m[ml] = 0x80;
	const dv = new DataView(m.buffer);
	dv.setUint32(withPad - 4, (ml * 8) >>> 0);
	dv.setUint32(withPad - 8, Math.floor((ml * 8) / 2 ** 32));
	let h0 = 0x67452301, h1 = 0xefcdab89, h2 = 0x98badcfe, h3 = 0x10325476, h4 = 0xc3d2e1f0;
	const w = new Uint32Array(80);
	for (let o = 0; o < withPad; o += 64) {
		for (let i = 0; i < 16; i++) w[i] = dv.getUint32(o + i * 4);
		for (let i = 16; i < 80; i++) {
			const x = w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16];
			w[i] = (x << 1) | (x >>> 31);
		}
		let a = h0, b = h1, c = h2, d = h3, e = h4;
		for (let i = 0; i < 80; i++) {
			const f = i < 20 ? (b & c) | (~b & d) : i < 40 ? b ^ c ^ d : i < 60 ? (b & c) | (b & d) | (c & d) : b ^ c ^ d;
			const k = i < 20 ? 0x5a827999 : i < 40 ? 0x6ed9eba1 : i < 60 ? 0x8f1bbcdc : 0xca62c1d6;
			const t = (((a << 5) | (a >>> 27)) + f + e + k + w[i]) >>> 0;
			e = d;
			d = c;
			c = (b << 30) | (b >>> 2);
			b = a;
			a = t;
		}
		h0 = (h0 + a) >>> 0;
		h1 = (h1 + b) >>> 0;
		h2 = (h2 + c) >>> 0;
		h3 = (h3 + d) >>> 0;
		h4 = (h4 + e) >>> 0;
	}
	return [h0, h1, h2, h3, h4].map((h) => h.toString(16).padStart(8, '0')).join('');
}

export function createHash(alg) {
	if (alg !== 'sha1') throw new Error(`crypto.createHash('${alg}') is not in the browser planner`);
	const parts = [];
	const h = {
		update(x) {
			parts.push(typeof x === 'string' ? new TextEncoder().encode(x) : x);
			return h;
		},
		digest(enc) {
			let n = 0;
			for (const p of parts) n += p.length;
			const all = new Uint8Array(n);
			let o = 0;
			for (const p of parts) {
				all.set(p, o);
				o += p.length;
			}
			const hex = sha1Bytes(all);
			if (enc !== 'hex') throw new Error('digest: hex only');
			return hex;
		},
	};
	return h;
}

export function randomUUID() {
	return globalThis.crypto.randomUUID();
}

export default { createHash, randomUUID };
