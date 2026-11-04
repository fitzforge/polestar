//! A minimal ZIP (PKWARE APPNOTE 6.3) writer and reader: raw deflate at level 9 (zlib-rs, whose output
//! is zlib-ng's byte for byte), CRC-32, UTF-8 names, no ZIP64, no encryption. The output is
//! deterministic: a fixed timestamp (2026-01-01 00:00) and the entry order given, so the same
//! sources give the same archive on every machine.

use std::path::Path;

/// One archive entry: a name ending in `/` is a folder (its data is ignored).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Entry {
	pub name: String,
	pub data: Vec<u8>,
}

impl Entry {
	pub fn dir(name: impl Into<String>) -> Entry {
		Entry { name: name.into(), data: Vec::new() }
	}

	pub fn file(name: impl Into<String>, data: impl Into<Vec<u8>>) -> Entry {
		Entry { name: name.into(), data: data.into() }
	}

	pub fn is_dir(&self) -> bool {
		self.name.ends_with('/')
	}
}

/// 2026-01-01 00:00:00 in MS-DOS format.
const DOS_TIME: u16 = 0;
const DOS_DATE: u16 = ((2026 - 1980) << 9) | (1 << 5) | 1;
const FLAG_UTF8: u16 = 0x0800;
/// Unix, spec 2.0.
const MADE_BY: u16 = (3 << 8) | 20;
const LIMIT: u64 = 0xffff_ffff;

/// CRC-32 (IEEE) of `data`.
pub fn crc32(data: &[u8]) -> u32 {
	zlib_rs::crc32::crc32(0, data)
}

/// Raw deflate (no zlib header) at level 9, window 15, memory level 8: what `zlib.deflateRawSync(data,
/// { level: 9 })` gives on zlib-ng.
pub fn deflate(data: &[u8]) -> Vec<u8> {
	let mut out = vec![0u8; zlib_rs::compress_bound(data.len())];
	let config = zlib_rs::DeflateConfig { level: 9, method: zlib_rs::Method::Deflated, window_bits: -15, mem_level: 8, strategy: zlib_rs::Strategy::Default };
	let (got, rc) = zlib_rs::compress_slice(&mut out, data, config);
	assert_eq!(rc, zlib_rs::ReturnCode::Ok, "deflate into a compress_bound buffer cannot fail");
	let n = got.len();
	out.truncate(n);
	out
}

fn u16le(out: &mut Vec<u8>, v: u16) {
	out.extend_from_slice(&v.to_le_bytes());
}

fn u32le(out: &mut Vec<u8>, v: u32) {
	out.extend_from_slice(&v.to_le_bytes());
}

/// The archive of `entries`, in their order. A file is deflated when that makes it smaller, else
/// stored.
pub fn build_zip(entries: &[Entry]) -> Result<Vec<u8>, String> {
	if entries.len() > 0xffff {
		return Err("zip: too many entries".into());
	}
	let mut locals: Vec<u8> = Vec::new();
	let mut central: Vec<u8> = Vec::new();
	for e in entries {
		let dir = e.is_dir();
		let name = e.name.as_bytes();
		let raw: &[u8] = if dir { &[] } else { &e.data };
		let crc = crc32(raw);
		let deflated = if raw.is_empty() { None } else { Some(deflate(raw)).filter(|d| d.len() < raw.len()) };
		let (method, body): (u16, &[u8]) = match &deflated {
			Some(d) => (8, d),
			None => (0, raw),
		};
		let offset = locals.len() as u64;
		if raw.len() as u64 >= LIMIT || offset >= LIMIT {
			return Err("zip: archives over 4 GiB are not supported".into());
		}
		u32le(&mut locals, 0x0403_4b50);
		u16le(&mut locals, 20);
		u16le(&mut locals, FLAG_UTF8);
		u16le(&mut locals, method);
		u16le(&mut locals, DOS_TIME);
		u16le(&mut locals, DOS_DATE);
		u32le(&mut locals, crc);
		u32le(&mut locals, body.len() as u32);
		u32le(&mut locals, raw.len() as u32);
		u16le(&mut locals, name.len() as u16);
		u16le(&mut locals, 0);
		locals.extend_from_slice(name);
		locals.extend_from_slice(body);

		let mode: u32 = if dir { 0o40755 } else { 0o100644 };
		u32le(&mut central, 0x0201_4b50);
		u16le(&mut central, MADE_BY);
		u16le(&mut central, 20);
		u16le(&mut central, FLAG_UTF8);
		u16le(&mut central, method);
		u16le(&mut central, DOS_TIME);
		u16le(&mut central, DOS_DATE);
		u32le(&mut central, crc);
		u32le(&mut central, body.len() as u32);
		u32le(&mut central, raw.len() as u32);
		u16le(&mut central, name.len() as u16);
		for _ in 0..4 {
			u16le(&mut central, 0); // extra, comment, disk, internal attributes
		}
		u32le(&mut central, ((mode & 0xffff) << 16) | if dir { 0x10 } else { 0 });
		u32le(&mut central, offset as u32);
		central.extend_from_slice(name);
	}
	let (cd_offset, cd_len) = (locals.len() as u32, central.len() as u32);
	let mut out = locals;
	out.extend_from_slice(&central);
	u32le(&mut out, 0x0605_4b50);
	u16le(&mut out, 0);
	u16le(&mut out, 0);
	u16le(&mut out, entries.len() as u16);
	u16le(&mut out, entries.len() as u16);
	u32le(&mut out, cd_len);
	u32le(&mut out, cd_offset);
	u16le(&mut out, 0);
	Ok(out)
}

/// Writes the archive of `entries` to `file` (its folder made first), through a temporary file so a
/// failed write never leaves half an archive.
pub fn write_zip(file: &Path, entries: &[Entry]) -> Result<(), String> {
	let bytes = build_zip(entries)?;
	if let Some(dir) = file.parent() {
		std::fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
	}
	let tmp = file.with_file_name(format!("{}.tmp-{}", file.file_name().map(|n| n.to_string_lossy().into_owned()).unwrap_or_default(), std::process::id()));
	std::fs::write(&tmp, bytes).map_err(|e| format!("{}: {e}", tmp.display()))?;
	std::fs::rename(&tmp, file).map_err(|e| format!("{}: {e}", file.display()))
}

/// Entries for whole folder trees, each stored under its own name: `Polestar/`, `Polestar/Polestar.toc`,
/// ... Hidden files and folders (a leading `.`) are skipped; names sort by UTF-16 code units (as JS
/// compares strings).
pub fn directory_entries(dirs: &[&Path]) -> Result<Vec<Entry>, String> {
	fn walk(abs: &Path, rel: &str, out: &mut Vec<Entry>) -> Result<(), String> {
		out.push(Entry::dir(format!("{rel}/")));
		let io = |e: std::io::Error| format!("{}: {e}", abs.display());
		let mut names: Vec<String> = std::fs::read_dir(abs).map_err(io)?.map(|d| d.map(|d| d.file_name().to_string_lossy().into_owned()).map_err(io)).collect::<Result<_, _>>()?;
		names.retain(|n| !n.starts_with('.'));
		names.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
		for n in names {
			let p = abs.join(&n);
			// Followed through symlinks, as the release folders are read.
			let Ok(meta) = std::fs::metadata(&p) else { continue };
			if meta.is_dir() {
				walk(&p, &format!("{rel}/{n}"), out)?;
			} else if meta.is_file() {
				out.push(Entry::file(format!("{rel}/{n}"), std::fs::read(&p).map_err(|e| format!("{}: {e}", p.display()))?));
			}
		}
		Ok(())
	}
	let mut out = Vec::new();
	for d in dirs {
		let base = d.file_name().map(|n| n.to_string_lossy().into_owned()).unwrap_or_default();
		walk(d, &base, &mut out)?;
	}
	Ok(out)
}

/// Reads an archive. Sizes are capped so a corrupt archive cannot exhaust memory: an entry inflates to at
/// most its declared size, and all entries together to at most `max_total` bytes.
pub fn read_zip(buf: &[u8], max_total: u64) -> Result<Vec<Entry>, String> {
	let u16at = |p: usize| -> Result<u16, String> { buf.get(p..p + 2).map(|b| u16::from_le_bytes([b[0], b[1]])).ok_or_else(|| "zip: truncated archive".to_string()) };
	let u32at = |p: usize| -> Result<u32, String> { buf.get(p..p + 4).map(|b| u32::from_le_bytes([b[0], b[1], b[2], b[3]])).ok_or_else(|| "zip: truncated archive".to_string()) };
	let eocd = (buf.len() >= 22)
		.then(|| (buf.len().saturating_sub(22 + 0xffff)..=buf.len() - 22).rev().find(|&i| buf[i..i + 4] == [0x50, 0x4b, 0x05, 0x06]))
		.flatten()
		.ok_or("zip: end of central directory not found (not a zip file?)")?;
	let count = u16at(eocd + 10)?;
	let mut p = u32at(eocd + 16)? as usize;
	let mut out = Vec::new();
	let mut total: u64 = 0;
	for _ in 0..count {
		if u32at(p)? != 0x0201_4b50 {
			return Err("zip: bad central directory entry".into());
		}
		let flags = u16at(p + 8)?;
		let method = u16at(p + 10)?;
		let crc = u32at(p + 16)?;
		let csize = u32at(p + 20)?;
		let usize_ = u32at(p + 24)?;
		let (nlen, xlen, clen) = (u16at(p + 28)? as usize, u16at(p + 30)? as usize, u16at(p + 32)? as usize);
		let lho = u32at(p + 42)?;
		if [csize, usize_, lho].contains(&(LIMIT as u32)) {
			return Err("zip: ZIP64 archives are not supported".into());
		}
		if flags & 1 != 0 {
			return Err("zip: encrypted entries are not supported".into());
		}
		let raw_name = buf.get(p + 46..p + 46 + nlen).ok_or("zip: truncated archive")?;
		let name = if flags & FLAG_UTF8 != 0 { String::from_utf8_lossy(raw_name).into_owned() } else { raw_name.iter().map(|&b| b as char).collect() };
		p += 46 + nlen + xlen + clen;
		let lho = lho as usize;
		if u32at(lho)? != 0x0403_4b50 {
			return Err(format!("zip: bad local header for {name}"));
		}
		let start = lho + 30 + u16at(lho + 26)? as usize + u16at(lho + 28)? as usize;
		let body = buf.get(start..start + csize as usize).ok_or_else(|| format!("zip: corrupt entry {name}"))?;
		if usize_ as u64 > max_total - total {
			return Err(format!("zip: {name} would exceed the {max_total}-byte limit"));
		}
		let data = match method {
			0 => body.to_vec(),
			8 => {
				// One byte of slack so an entry larger than declared is caught below.
				let mut data = vec![0u8; usize_ as usize + 1];
				let (got, rc) = zlib_rs::decompress_slice(&mut data, body, zlib_rs::InflateConfig { window_bits: -15 });
				if rc != zlib_rs::ReturnCode::Ok {
					return Err(format!("zip: corrupt entry {name}"));
				}
				let n = got.len();
				data.truncate(n);
				data
			}
			m => return Err(format!("zip: unsupported compression method {m} for {name}")),
		};
		if data.len() as u64 != usize_ as u64 || crc32(&data) != crc {
			return Err(format!("zip: corrupt entry {name}"));
		}
		total += data.len() as u64;
		out.push(Entry { name, data });
	}
	Ok(out)
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn crc32_check_value() {
		assert_eq!(crc32(b"123456789"), 0xcbf4_3926);
	}

	#[test]
	fn round_trip_names_empty_binary_stored_and_deflated() {
		let bin: Vec<u8> = (0..4096u64).map(|i| ((i * 2_654_435_761) >> 24) as u8).collect();
		let entries = vec![
			Entry::dir("Dir/"),
			Entry::file("Dir/empty.txt", ""),
			Entry::file("Dir/Ünïcödé ✓.lua", "print(\"hi\")\n".repeat(50)),
			Entry::file("Dir/random.bin", bin.clone()),
			Entry::file("Dir/one.txt", "x"),
		];
		let zip = build_zip(&entries).unwrap();
		assert_eq!(zip, build_zip(&entries).unwrap(), "deterministic");
		assert_eq!(read_zip(&zip, u64::MAX).unwrap(), entries);
	}

	#[test]
	fn an_entry_inflating_past_its_size_or_an_archive_past_the_cap_is_refused() {
		let mut bomb = build_zip(&[Entry::file("Polestar_Guides/Guides/a.lua", vec![45u8; 4 * 1024 * 1024])]).unwrap();
		let cd = bomb.windows(4).position(|w| w == [0x50, 0x4b, 0x01, 0x02]).unwrap();
		bomb[cd + 24..cd + 28].copy_from_slice(&16u32.to_le_bytes());
		assert!(read_zip(&bomb, u64::MAX).unwrap_err().contains("corrupt entry"));
		let big = build_zip(&[Entry::file("a", vec![0u8; 4096])]).unwrap();
		assert!(read_zip(&big, 1024).unwrap_err().contains("exceed the 1024-byte limit"));
	}
}
