// A zip archive (stored, no compression) of [name, string | Uint8Array] entries -> Uint8Array.

const CRC = (() => {
	const t = new Uint32Array(256);
	for (let n = 0; n < 256; n++) {
		let c = n;
		for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
		t[n] = c >>> 0;
	}
	return t;
})();

function crc32(b) {
	let c = 0xffffffff;
	for (let i = 0; i < b.length; i++) c = CRC[(c ^ b[i]) & 0xff] ^ (c >>> 8);
	return (c ^ 0xffffffff) >>> 0;
}

export function zip(entries) {
	const enc = new TextEncoder();
	const parts = [];
	const central = [];
	let offset = 0;
	for (const [name, content] of entries) {
		const nb = enc.encode(name);
		const data = typeof content === 'string' ? enc.encode(content) : content;
		const crc = crc32(data);
		const local = new DataView(new ArrayBuffer(30));
		local.setUint32(0, 0x04034b50, true);
		local.setUint16(4, 20, true);
		local.setUint16(6, 0x0800, true); // UTF-8 names
		local.setUint32(14, crc, true);
		local.setUint32(18, data.length, true);
		local.setUint32(22, data.length, true);
		local.setUint16(26, nb.length, true);
		parts.push(new Uint8Array(local.buffer), nb, data);
		const cen = new DataView(new ArrayBuffer(46));
		cen.setUint32(0, 0x02014b50, true);
		cen.setUint16(4, 20, true);
		cen.setUint16(6, 20, true);
		cen.setUint16(8, 0x0800, true);
		cen.setUint32(16, crc, true);
		cen.setUint32(20, data.length, true);
		cen.setUint32(24, data.length, true);
		cen.setUint16(28, nb.length, true);
		cen.setUint32(42, offset, true);
		central.push(new Uint8Array(cen.buffer), nb);
		offset += 30 + nb.length + data.length;
	}
	const cenSize = central.reduce((n, p) => n + p.length, 0);
	const end = new DataView(new ArrayBuffer(22));
	end.setUint32(0, 0x06054b50, true);
	end.setUint16(8, entries.length, true);
	end.setUint16(10, entries.length, true);
	end.setUint32(12, cenSize, true);
	end.setUint32(16, offset, true);
	const all = [...parts, ...central, new Uint8Array(end.buffer)];
	const out = new Uint8Array(all.reduce((n, p) => n + p.length, 0));
	let o = 0;
	for (const p of all) {
		out.set(p, o);
		o += p.length;
	}
	return out;
}
