'use strict';
// Binary data files: a JSON header and typed-array sections, read without parsing the arrays
// (sim walks' documents and caches, walks.js).
//
//   writeBin(file, header, sections) -> contentId: sections { name: TypedArray }; written
//     atomically (a .tmp renamed); the header gains `contentId` (sha1 hex of the sections'
//     bytes and the header without it) and `sections` ({ name: [type, offset, length] })
//   readBin(file) -> { header, sections: { name: TypedArray } } (views on the file's bytes)
//   readBinHeader(file) -> the header alone (the file's first bytes), or null when there is none
//
// Layout: 'PSBN', u32 version, u32 header bytes, the header JSON (UTF-8), zero padding to 8,
// then each section's bytes at its offset (from the file's start, 8-aligned).

const fs = require('node:fs');
const crypto = require('node:crypto');

const MAGIC = 0x4e425350; // 'PSBN' little-endian
const VERSION = 1;
const TYPES = { Int8Array, Uint8Array, Int16Array, Uint16Array, Int32Array, Uint32Array, Float32Array, Float64Array };

const align8 = (n) => Math.ceil(n / 8) * 8;

function writeBin(file, header, sections) {
	const names = Object.keys(sections);
	const h = crypto.createHash('sha1');
	for (const n of names) {
		const a = sections[n];
		h.update(`${n}:${a.constructor.name}:${a.length}\n`).update(Buffer.from(a.buffer, a.byteOffset, a.byteLength));
	}
	const { contentId: _, sections: __, ...rest } = header;
	h.update(JSON.stringify(rest));
	const contentId = h.digest('hex');
	// Offsets depend on the header's length, which depends on the offsets: lay out twice.
	let layout = {};
	let head = null;
	for (let pass = 0; pass < 3; pass++) {
		head = Buffer.from(JSON.stringify({ contentId, ...rest, sections: layout }), 'utf8');
		let at = align8(12 + head.length);
		const next = {};
		for (const n of names) {
			next[n] = [sections[n].constructor.name, at, sections[n].length];
			at = align8(at + sections[n].byteLength);
		}
		if (JSON.stringify(next) === JSON.stringify(layout)) break;
		layout = next;
	}
	head = Buffer.from(JSON.stringify({ contentId, ...rest, sections: layout }), 'utf8');
	const fd = fs.openSync(`${file}.tmp`, 'w');
	try {
		const pre = Buffer.alloc(12);
		pre.writeUInt32LE(MAGIC, 0);
		pre.writeUInt32LE(VERSION, 4);
		pre.writeUInt32LE(head.length, 8);
		fs.writeSync(fd, pre);
		fs.writeSync(fd, head);
		let pos = 12 + head.length;
		for (const n of names) {
			const [, at] = layout[n];
			if (at > pos) fs.writeSync(fd, Buffer.alloc(at - pos));
			const a = sections[n];
			fs.writeSync(fd, Buffer.from(a.buffer, a.byteOffset, a.byteLength));
			pos = at + a.byteLength;
		}
	} finally {
		fs.closeSync(fd);
	}
	fs.renameSync(`${file}.tmp`, file);
	return contentId;
}

function readBinHeader(file) {
	if (!fs.existsSync(file)) return null;
	const fd = fs.openSync(file, 'r');
	try {
		const pre = Buffer.alloc(12);
		if (fs.readSync(fd, pre, 0, 12, 0) < 12 || pre.readUInt32LE(0) !== MAGIC || pre.readUInt32LE(4) !== VERSION) return null;
		const head = Buffer.alloc(pre.readUInt32LE(8));
		fs.readSync(fd, head, 0, head.length, 12);
		return JSON.parse(head.toString('utf8'));
	} finally {
		fs.closeSync(fd);
	}
}

function readBin(file) {
	// A sim server's worker threads share the file's bytes (memo.js fileBytes); elsewhere it is read.
	const buf = require('./memo').fileBytes(file);
	if (buf.length < 12 || buf.readUInt32LE(0) !== MAGIC || buf.readUInt32LE(4) !== VERSION) throw new Error(`${file}: not a binary data file of version ${VERSION}`);
	const n = buf.readUInt32LE(8);
	const header = JSON.parse(buf.toString('utf8', 12, 12 + n));
	// A Buffer may sit at any offset of its pool: the sections need their own aligned copy then.
	const bytes = buf.byteOffset % 8 ? new Uint8Array(buf) : buf;
	const sections = {};
	for (const [name, [type, at, length]] of Object.entries(header.sections || {})) {
		const T = TYPES[type];
		if (!T) throw new Error(`${file}: section ${name} has unknown type ${type}`);
		sections[name] = new T(bytes.buffer, bytes.byteOffset + at, length);
	}
	return { header, sections };
}

module.exports = { writeBin, readBin, readBinHeader };
