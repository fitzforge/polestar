//! BLTE, the container every file in CASC storage is wrapped in: a chunk table, then chunks
//! that are raw (`N`), zlib (`Z`), nested BLTE (`F`) or encrypted (`E`).
//!
//! Encrypted chunks need a TACT key this crate does not have: their bytes come back as zeros
//! (the DB2 reader then skips the section they hold) and the key names are reported in
//! [`Decoded::encrypted`]. LZ4 chunks (`4`) are not used by WoW's DB2s and fail with an error.

use std::io::Read;

/// A decoded file and the TACT key names (hex) of the chunks that stayed encrypted (zero-filled).
#[derive(Debug, Default)]
pub struct Decoded {
	pub data: Vec<u8>,
	pub encrypted: Vec<String>,
}

fn be32(b: &[u8], o: usize) -> u32 {
	u32::from_be_bytes([b[o], b[o + 1], b[o + 2], b[o + 3]])
}

/// Decodes a BLTE blob (starting at its `BLTE` magic).
pub fn decode(blte: &[u8]) -> Result<Decoded, String> {
	let mut out = Decoded::default();
	decode_into(blte, &mut out)?;
	Ok(out)
}

fn decode_into(blte: &[u8], out: &mut Decoded) -> Result<(), String> {
	if blte.len() < 8 || &blte[..4] != b"BLTE" {
		return Err("BLTE: bad magic".into());
	}
	let header_size = be32(blte, 4) as usize;
	if header_size == 0 {
		return chunk(&blte[8..], None, out);
	}
	if blte.len() < 12 || header_size > blte.len() {
		return Err("BLTE: truncated header".into());
	}
	let format = blte[8];
	let count = (be32(blte, 8) & 0x00ff_ffff) as usize;
	let entry = match format {
		0x0f => 24,
		0x10 => 40,
		f => return Err(format!("BLTE: unknown chunk table format {f:#x}")),
	};
	if 12 + count * entry > header_size {
		return Err("BLTE: chunk table overruns its header".into());
	}
	let mut pos = header_size;
	for i in 0..count {
		let e = 12 + i * entry;
		let comp = be32(blte, e) as usize;
		let decomp = be32(blte, e + 4) as usize;
		let end = pos.checked_add(comp).filter(|&x| x <= blte.len()).ok_or("BLTE: chunk overruns the file")?;
		let before = out.data.len();
		chunk(&blte[pos..end], Some(decomp), out)?;
		if out.data.len() - before != decomp {
			return Err(format!("BLTE: chunk {i} decoded to {} bytes, table says {decomp}", out.data.len() - before));
		}
		pos = end;
	}
	Ok(())
}

fn chunk(c: &[u8], decomp: Option<usize>, out: &mut Decoded) -> Result<(), String> {
	let (&mode, body) = c.split_first().ok_or("BLTE: empty chunk")?;
	match mode {
		b'N' => out.data.extend_from_slice(body),
		b'Z' => {
			let mut z = flate2::read::ZlibDecoder::new(body);
			if let Some(n) = decomp {
				out.data.reserve(n);
			}
			z.read_to_end(&mut out.data).map_err(|e| format!("BLTE: zlib: {e}"))?;
		}
		b'F' => decode_into(body, out)?,
		b'E' => {
			// key_name_size, key_name (little-endian u64), iv_size, iv, type, encrypted chunk
			let n = *body.first().ok_or("BLTE: truncated encrypted chunk")? as usize;
			let key = body.get(1..1 + n).ok_or("BLTE: truncated encrypted chunk")?;
			let name: String = key.iter().rev().map(|b| format!("{b:02X}")).collect();
			let size = decomp.ok_or_else(|| format!("BLTE: whole file encrypted with TACT key {name}; no key to read it"))?;
			out.data.resize(out.data.len() + size, 0);
			if !out.encrypted.contains(&name) {
				out.encrypted.push(name);
			}
		}
		b'4' => return Err("BLTE: LZ4 chunk (not supported; DB2s do not use it)".into()),
		m => return Err(format!("BLTE: unknown chunk mode {:?}", m as char)),
	}
	Ok(())
}

#[cfg(test)]
mod tests {
	use super::*;

	fn table(chunks: &[(&[u8], usize)]) -> Vec<u8> {
		let header = 12 + 24 * chunks.len();
		let mut b = b"BLTE".to_vec();
		b.extend_from_slice(&(header as u32).to_be_bytes());
		b.push(0x0f);
		b.extend_from_slice(&(chunks.len() as u32).to_be_bytes()[1..]);
		for (c, d) in chunks {
			b.extend_from_slice(&(c.len() as u32).to_be_bytes());
			b.extend_from_slice(&(*d as u32).to_be_bytes());
			b.extend_from_slice(&[0; 16]);
		}
		for (c, _) in chunks {
			b.extend_from_slice(c);
		}
		b
	}

	#[test]
	fn raw_zlib_and_encrypted_chunks() {
		use std::io::Write;
		let mut z = flate2::write::ZlibEncoder::new(Vec::new(), flate2::Compression::default());
		z.write_all(b"hello world").unwrap();
		let mut zc = vec![b'Z'];
		zc.extend(z.finish().unwrap());
		let enc = [b'E', 8, 1, 2, 3, 4, 5, 6, 7, 8, 4, 0, 0, 0, 0, b'S', 9, 9];
		let d = decode(&table(&[(b"Nab", 2), (&zc, 11), (&enc, 3)])).unwrap();
		assert_eq!(d.data, b"abhello world\0\0\0");
		assert_eq!(d.encrypted, vec!["0807060504030201".to_string()]);
	}

	#[test]
	fn single_chunk_without_table() {
		let mut b = b"BLTE\0\0\0\0N".to_vec();
		b.extend_from_slice(b"xyz");
		assert_eq!(decode(&b).unwrap().data, b"xyz");
	}
}
