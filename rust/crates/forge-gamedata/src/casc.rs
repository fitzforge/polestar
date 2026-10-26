//! Local CASC storage, read-only: `.build.info` -> build config -> encoding and root files ->
//! a fileDataID's bytes from the shared `Data/data` archives.
//!
//! Formats (wowdev.wiki CASC, TACT pages): `.build.info` is a `|`-separated table; configs live
//! under `Data/config/<k[0..2]>/<k[2..4]>/<k>`; `Data/data/<bucket><version>.idx` (v7) map the
//! first 9 bytes of an encoding key to (archive, offset, size) in `data.NNN`, where each file
//! sits behind a 30-byte header as BLTE. The encoding file maps content keys to encoding keys;
//! the root (MFST) maps fileDataIDs to content keys per locale.

use std::fs::File;
use std::io::{Read, Seek, SeekFrom};
use std::path::{Path, PathBuf};
use std::sync::Mutex;

use rustc_hash::FxHashMap;

use crate::blte::{self, Decoded};

pub type Key = [u8; 16];

/// Whether a file is in the local archives ([`Storage::presence`]).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Presence {
	/// indexed and its archive slot holds it
	Present,
	/// not in the index (not downloaded: a streaming or partial install)
	Absent,
	/// indexed, but the slot holds another file (an incomplete install: Scan and Repair)
	Stale,
}

/// Whether an archive slot's head is the file with these first 9 encoding-key bytes: its 30-byte
/// header (key byte-reversed), a zeroed header followed by BLTE, or the BLTE data itself.
fn slot_holds(head: &[u8], key9: &[u8]) -> bool {
	if head.starts_with(b"BLTE") {
		return true;
	}
	if head.len() < 34 {
		return false;
	}
	let stored: Vec<u8> = head[..16].iter().rev().copied().collect();
	stored[..9] == key9[..9] || (stored.iter().all(|&b| b == 0) && &head[30..34] == b"BLTE")
}

pub fn hex(k: &[u8]) -> String {
	k.iter().map(|b| format!("{b:02x}")).collect()
}

fn parse_key(s: &str) -> Result<Key, String> {
	let s = s.trim();
	if s.len() != 32 {
		return Err(format!("bad key {s:?}"));
	}
	let mut k = [0u8; 16];
	for (i, b) in k.iter_mut().enumerate() {
		*b = u8::from_str_radix(&s[i * 2..i * 2 + 2], 16).map_err(|_| format!("bad key {s:?}"))?;
	}
	Ok(k)
}

/// One product row of `<install>/.build.info`.
#[derive(Clone, Debug)]
pub struct BuildInfo {
	pub product: String,
	pub version: String,
	pub build_key: String,
	pub branch: String,
	pub active: bool,
}

/// Every row of `<install>/.build.info`.
pub fn read_build_info(install: &Path) -> Result<Vec<BuildInfo>, String> {
	let file = install.join(".build.info");
	let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
	let mut lines = text.lines().filter(|l| !l.trim().is_empty());
	let head: Vec<&str> = lines.next().ok_or_else(|| format!("{}: empty", file.display()))?.split('|').map(|c| c.split('!').next().unwrap_or("")).collect();
	let col = |name: &str| head.iter().position(|c| *c == name).ok_or_else(|| format!("{}: no {name} column", file.display()));
	let (product, version, key, branch, active) = (col("Product")?, col("Version")?, col("Build Key")?, col("Branch")?, col("Active")?);
	Ok(lines
		.map(|l| {
			let f: Vec<&str> = l.split('|').collect();
			let get = |i: usize| f.get(i).copied().unwrap_or("").to_string();
			BuildInfo { product: get(product), version: get(version), build_key: get(key), branch: get(branch), active: get(active) == "1" }
		})
		.collect())
}

/// `key = value` lines of a config file.
fn read_config(data: &Path, key: &str) -> Result<FxHashMap<String, String>, String> {
	if key.len() < 4 {
		return Err(format!("bad config key {key:?}"));
	}
	let file = data.join("config").join(&key[0..2]).join(&key[2..4]).join(key);
	let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
	Ok(text.lines().filter(|l| !l.starts_with('#')).filter_map(|l| l.split_once('=')).map(|(k, v)| (k.trim().to_string(), v.trim().to_string())).collect())
}

#[derive(Clone, Copy)]
struct Loc {
	archive: u16,
	offset: u32,
	size: u32,
}

/// Locale bits of the root (wowdev.wiki TACT, Root). DB2s are per locale.
pub fn locale_flag(locale: &str) -> Option<u32> {
	Some(match locale {
		"enUS" => 0x2,
		"koKR" => 0x4,
		"frFR" => 0x10,
		"deDE" => 0x20,
		"zhCN" => 0x40,
		"esES" => 0x80,
		"zhTW" => 0x100,
		"enGB" => 0x200,
		"esMX" => 0x1000,
		"ruRU" => 0x2000,
		"ptBR" => 0x4000,
		"itIT" => 0x8000,
		_ => return None,
	})
}

const CONTENT_LOW_VIOLENCE: u32 = 0x80;
const CONTENT_NO_NAME_HASH: u32 = 0x1000_0000;

/// A root block: `n` fileDataIDs (as deltas, ascending) and their content keys, for `locales`.
#[derive(Clone, Copy)]
struct RootBlock {
	n: usize,
	locales: u32,
	deltas: usize,
	ckeys: usize,
}

/// An open local storage for one product's installed build.
pub struct Storage {
	pub product: String,
	pub version: String,
	pub install: PathBuf,
	data_dir: PathBuf,
	/// Per idx bucket: entries sorted by their 9-byte key.
	index: Vec<Vec<([u8; 9], Loc)>>,
	archives: Mutex<FxHashMap<u16, File>>,
	encoding: Vec<u8>,
	ce_pages: (usize, usize, usize), // (index start, pages start, page size)
	ce_page_count: usize,
	/// The root file and its blocks (low-violence blocks left out); scanned per lookup.
	root: Vec<u8>,
	root_blocks: Vec<RootBlock>,
}

fn bucket_of(k: &[u8]) -> usize {
	let x = k[..9].iter().fold(0u8, |a, b| a ^ b);
	((x & 0xf) ^ (x >> 4)) as usize
}

/// The newest `<bucket><version>.idx` of each of the 16 buckets in `dir`.
fn read_indices(dir: &Path) -> Result<Vec<Vec<([u8; 9], Loc)>>, String> {
	let mut newest: [Option<(u32, PathBuf)>; 16] = Default::default();
	for e in std::fs::read_dir(dir).map_err(|e| format!("{}: {e}", dir.display()))? {
		let p = e.map_err(|e| e.to_string())?.path();
		let name = p.file_name().and_then(|n| n.to_str()).unwrap_or("");
		let Some(stem) = name.strip_suffix(".idx") else { continue };
		if stem.len() != 10 {
			continue;
		}
		let (Ok(b), Ok(v)) = (u8::from_str_radix(&stem[..2], 16), u32::from_str_radix(&stem[2..], 16)) else { continue };
		if (b as usize) < 16 && newest[b as usize].as_ref().is_none_or(|(old, _)| v > *old) {
			newest[b as usize] = Some((v, p));
		}
	}
	let mut out = Vec::with_capacity(16);
	for (b, f) in newest.into_iter().enumerate() {
		let (_, file) = f.ok_or_else(|| format!("{}: no .idx for bucket {b:02x}", dir.display()))?;
		let raw = std::fs::read(&file).map_err(|e| format!("{}: {e}", file.display()))?;
		let bad = |what: &str| format!("{}: {what}", file.display());
		if raw.len() < 0x28 || u16::from_le_bytes([raw[8], raw[9]]) != 7 {
			return Err(bad("not a version 7 index"));
		}
		let (size_len, offset_len, key_len, offset_bits) = (raw[12] as usize, raw[13] as usize, raw[14] as usize, raw[15] as u32);
		if (size_len, offset_len, key_len) != (4, 5, 9) {
			return Err(bad("unexpected entry layout"));
		}
		let entries_size = u32::from_le_bytes(raw[0x20..0x24].try_into().unwrap()) as usize;
		let body = raw.get(0x28..0x28 + entries_size).ok_or_else(|| bad("truncated"))?;
		let mut v: Vec<([u8; 9], Loc)> = body
			.chunks_exact(18)
			.map(|e| {
				let packed = e[9..14].iter().fold(0u64, |a, &b| (a << 8) | b as u64);
				let loc = Loc { archive: (packed >> offset_bits) as u16, offset: (packed & ((1 << offset_bits) - 1)) as u32, size: u32::from_le_bytes(e[14..18].try_into().unwrap()) };
				(e[..9].try_into().unwrap(), loc)
			})
			.collect();
		v.sort_unstable_by_key(|a| a.0);
		out.push(v);
	}
	Ok(out)
}

impl Storage {
	/// Opens `product`'s installed build (`.build.info`) in the install folder (the one holding
	/// `.build.info` and `Data/`). Read-only: nothing under `install` is written.
	pub fn open(install: &Path, product: &str) -> Result<Storage, String> {
		let infos = read_build_info(install)?;
		let info = infos.iter().find(|b| b.product == product).ok_or_else(|| {
			let have: Vec<String> = infos.iter().map(|b| format!("{} {}", b.product, b.version)).collect();
			format!("{}: product {product} is not installed (have: {})", install.display(), have.join(", "))
		})?;
		let data_dir = install.join("Data");
		let build = read_config(&data_dir, &info.build_key)?;
		let field = |k: &str| build.get(k).ok_or_else(|| format!("build config {}: no {k}", info.build_key));
		let enc_keys: Vec<&str> = field("encoding")?.split_whitespace().collect();
		let enc_ekey = parse_key(enc_keys.get(1).ok_or("build config: encoding has no encoding key")?)?;
		let root_ckey = parse_key(field("root")?.split_whitespace().next().unwrap_or(""))?;
		let index = read_indices(&data_dir.join("data"))?;
		let mut s = Storage {
			product: product.to_string(),
			version: info.version.clone(),
			install: install.to_path_buf(),
			data_dir,
			index,
			archives: Mutex::new(FxHashMap::default()),
			encoding: Vec::new(),
			ce_pages: (0, 0, 0),
			ce_page_count: 0,
			root: Vec::new(),
			root_blocks: Vec::new(),
		};
		s.encoding = s.read_ekey(&enc_ekey).map_err(|e| format!("encoding file: {e}"))?.data;
		s.parse_encoding_header()?;
		let root_ekey = s.ekey_of(&root_ckey).ok_or("root: content key not in the encoding file")?;
		s.root = s.read_ekey(&root_ekey).map_err(|e| format!("root file: {e}"))?.data;
		s.root_blocks = root_blocks(&s.root)?;
		Ok(s)
	}

	fn parse_encoding_header(&mut self) -> Result<(), String> {
		let e = &self.encoding;
		if e.len() < 22 || &e[..2] != b"EN" || e[3] != 16 || e[4] != 16 {
			return Err("encoding file: bad header".into());
		}
		let page_kb = u16::from_be_bytes([e[5], e[6]]) as usize;
		let page_count = u32::from_be_bytes(e[9..13].try_into().unwrap()) as usize;
		let espec = u32::from_be_bytes(e[18..22].try_into().unwrap()) as usize;
		let index = 22 + espec;
		let pages = index + page_count * 32;
		if pages + page_count * page_kb * 1024 > e.len() {
			return Err("encoding file: truncated".into());
		}
		self.ce_pages = (index, pages, page_kb * 1024);
		self.ce_page_count = page_count;
		Ok(())
	}

	/// The encoding key of a content key (the first one listed).
	pub fn ekey_of(&self, ckey: &Key) -> Option<Key> {
		let (index, pages, page_size) = self.ce_pages;
		let e = &self.encoding;
		let first = |i: usize| &e[index + i * 32..index + i * 32 + 16];
		// The last page whose first key is <= ckey.
		let (mut lo, mut hi) = (0usize, self.ce_page_count);
		while lo < hi {
			let mid = (lo + hi) / 2;
			if first(mid) <= &ckey[..] {
				lo = mid + 1;
			} else {
				hi = mid;
			}
		}
		let page = lo.checked_sub(1)?;
		let p = &e[pages + page * page_size..pages + (page + 1) * page_size];
		let mut o = 0;
		while o + 22 <= p.len() {
			let n = p[o] as usize;
			if n == 0 {
				break;
			}
			let ck = &p[o + 6..o + 22];
			if ck == ckey {
				return p.get(o + 22..o + 38).map(|k| k.try_into().unwrap());
			}
			o += 22 + n * 16;
		}
		None
	}

	fn locate(&self, ekey: &Key) -> Option<Loc> {
		let b = &self.index[bucket_of(ekey)];
		b.binary_search_by(|(k, _)| k[..].cmp(&ekey[..9])).ok().map(|i| b[i].1)
	}

	/// Whether the file with this content key is really in the local archives: indexed, and its
	/// archive slot holds it. A slot whose header names its encoding key is taken as read (at most
	/// 34 bytes read); one whose header names another key (some installs write such headers) is
	/// decoded and its MD5 checked against the content key.
	pub fn presence(&self, ckey: &Key) -> Presence {
		let Some(ekey) = self.ekey_of(ckey) else { return Presence::Absent };
		let Some(loc) = self.locate(&ekey) else { return Presence::Absent };
		match self.slot_head(loc) {
			Some(head) if slot_holds(&head, &ekey[..9]) => Presence::Present,
			Some(head) if head.len() >= 34 && &head[30..34] == b"BLTE" => match self.read_ckey(ckey) {
				Ok(_) => Presence::Present,
				Err(_) => Presence::Stale,
			},
			_ => Presence::Stale,
		}
	}

	/// The decoded bytes of the file with this content key, checked: when the slot's header does
	/// not name the encoding key, the decoded bytes must hash (MD5) to the content key.
	pub fn read_ckey(&self, ckey: &Key) -> Result<Decoded, String> {
		let ekey = self.ekey_of(ckey).ok_or_else(|| format!("content key {} not in the encoding file", hex(ckey)))?;
		let (d, named) = self.read_slot(&ekey)?;
		// (Zero-filled encrypted chunks cannot hash to the content key: those are taken as read.)
		if !named && d.encrypted.is_empty() {
			use md5::Digest;
			if md5::Md5::digest(&d.data)[..] != ckey[..] {
				return Err(format!("encoding key {} is not in the local storage (its archive slot holds another file)", hex(&ekey)));
			}
		}
		Ok(d)
	}

	/// The first bytes (up to 34) of an archive slot.
	fn slot_head(&self, loc: Loc) -> Option<Vec<u8>> {
		let n = (loc.size as usize).min(34);
		let mut head = vec![0u8; n];
		let mut files = self.archives.lock().ok()?;
		let f = match files.entry(loc.archive) {
			std::collections::hash_map::Entry::Occupied(o) => o.into_mut(),
			std::collections::hash_map::Entry::Vacant(v) => v.insert(File::open(self.data_dir.join("data").join(format!("data.{:03}", loc.archive))).ok()?),
		};
		f.seek(SeekFrom::Start(loc.offset as u64)).and_then(|_| f.read_exact(&mut head)).ok()?;
		Some(head)
	}

	/// Whether the file with this encoding key is in the local archives.
	pub fn has_ekey(&self, ekey: &Key) -> bool {
		self.locate(ekey).is_some()
	}

	/// The decoded bytes of the file with this encoding key. A slot whose header names another
	/// key is an error here (nothing to check it against); [`Storage::read_ckey`] checks it instead.
	pub fn read_ekey(&self, ekey: &Key) -> Result<Decoded, String> {
		match self.read_slot(ekey)? {
			(d, true) => Ok(d),
			(_, false) => Err(format!("encoding key {}: its archive slot's header names another key (read it by content key)", hex(ekey))),
		}
	}

	/// The decoded slot of an encoding key, and whether its header named that key (or was zeroed,
	/// or absent: the slot starts with the BLTE data).
	fn read_slot(&self, ekey: &Key) -> Result<(Decoded, bool), String> {
		let loc = self.locate(ekey).ok_or_else(|| format!("encoding key {} is not in the local storage (not downloaded?)", hex(ekey)))?;
		let mut raw = vec![0u8; loc.size as usize];
		{
			let mut files = self.archives.lock().map_err(|_| "archive lock poisoned")?;
			let f = match files.entry(loc.archive) {
				std::collections::hash_map::Entry::Occupied(o) => o.into_mut(),
				std::collections::hash_map::Entry::Vacant(v) => {
					let path = self.data_dir.join("data").join(format!("data.{:03}", loc.archive));
					v.insert(File::open(&path).map_err(|e| format!("{}: {e}", path.display()))?)
				}
			};
			f.seek(SeekFrom::Start(loc.offset as u64)).and_then(|_| f.read_exact(&mut raw)).map_err(|e| format!("data.{:03}@{}: {e}", loc.archive, loc.offset))?;
		}
		// Usually a 30-byte header (encoding key byte-reversed, size, flags, two checksums) then the
		// BLTE data. Newer clients also index some files twice in the same .idx: once at the header
		// (its key bytes zeroed) and once at the BLTE data itself, 30 bytes on (seen for map WDTs in
		// 1.60.1.70450); either entry may be the one found.
		if raw.starts_with(b"BLTE") {
			return blte::decode(&raw).map(|d| (d, true)).map_err(|e| format!("encoding key {}: {e}", hex(ekey)));
		}
		if raw.len() < 34 {
			return Err(format!("encoding key {}: entry too small", hex(ekey)));
		}
		let stored: Vec<u8> = raw[..16].iter().rev().copied().collect();
		let zeroed = stored.iter().all(|&b| b == 0) && &raw[30..34] == b"BLTE";
		let named = stored[..9] == ekey[..9] || zeroed;
		// A header naming another key over BLTE data: some installs write such headers for files
		// they hold (seen in 1.60.1.70450: the data hashes to the right content key); the caller
		// checks the content (read_ckey). Anything else is not this file.
		if !named && &raw[30..34] != b"BLTE" {
			return Err(format!("encoding key {} is not in the local storage (its archive slot holds {})", hex(ekey), hex(&stored)));
		}
		blte::decode(&raw[30..]).map(|d| (d, named)).map_err(|e| format!("encoding key {}: {e}", hex(ekey)))
	}

	/// Calls `f(fdid, locales, ckey)` for every root entry, block by block.
	pub fn each_root_entry(&self, mut f: impl FnMut(u32, u32, &Key)) {
		for b in &self.root_blocks {
			let mut fdid: u32 = u32::MAX;
			for i in 0..b.n {
				fdid = fdid.wrapping_add(1).wrapping_add(i32::from_le_bytes(self.root[b.deltas + i * 4..b.deltas + i * 4 + 4].try_into().unwrap()) as u32);
				f(fdid, b.locales, self.root[b.ckeys + i * 16..b.ckeys + i * 16 + 16].try_into().unwrap());
			}
		}
	}

	/// The content key of fileDataID `fdid` for `locale` (a [`locale_flag`] bit), else of its
	/// first entry.
	pub fn ckey_of(&self, fdid: u32, locale: u32) -> Option<Key> {
		let (mut first, mut hit) = (None, None);
		for b in &self.root_blocks {
			let mut cur: u32 = u32::MAX;
			for i in 0..b.n {
				cur = cur.wrapping_add(1).wrapping_add(i32::from_le_bytes(self.root[b.deltas + i * 4..b.deltas + i * 4 + 4].try_into().unwrap()) as u32);
				if cur < fdid {
					continue;
				}
				if cur == fdid {
					let k: Key = self.root[b.ckeys + i * 16..b.ckeys + i * 16 + 16].try_into().unwrap();
					first.get_or_insert(k);
					if b.locales & locale != 0 {
						hit = Some(k);
					}
				}
				break; // ascending within a block
			}
			if hit.is_some() {
				break;
			}
		}
		hit.or(first)
	}

	/// Whether the root lists `fdid`.
	pub fn has_fdid(&self, fdid: u32) -> bool {
		self.ckey_of(fdid, 0).is_some()
	}

	/// The decoded bytes of fileDataID `fdid` for `locale`.
	pub fn read_fdid(&self, fdid: u32, locale: u32) -> Result<Decoded, String> {
		let ckey = self.ckey_of(fdid, locale).ok_or_else(|| format!("fileDataID {fdid}: not in the {} {} root", self.product, self.version))?;
		self.read_ckey(&ckey).map_err(|e| format!("fileDataID {fdid}: {e}"))
	}
}

/// The blocks of an MFST root (WoW 8.2+, header versions 0-2), low-violence ones left out.
fn root_blocks(r: &[u8]) -> Result<Vec<RootBlock>, String> {
	let u32at = |o: usize| r.get(o..o + 4).map(|b| u32::from_le_bytes(b.try_into().unwrap())).ok_or("root: truncated");
	if r.len() < 12 || &r[..4] != b"TSFM" {
		return Err("root: not an MFST root (pre-8.2 roots are not supported)".into());
	}
	let (mut pos, version) = match u32at(4)? {
		h @ 0x18..=0x40 => (h as usize, u32at(8)?),
		_ => (12, 0),
	};
	let mut out = Vec::new();
	while pos < r.len() {
		let n = u32at(pos)? as usize;
		let (content, locales) = if version >= 2 {
			let locales = u32at(pos + 4)?;
			let (a, b) = (u32at(pos + 8)?, u32at(pos + 12)?);
			let c = *r.get(pos + 16).ok_or("root: truncated")? as u32;
			pos += 17;
			(a | b | (c << 17), locales)
		} else {
			let c = u32at(pos + 4)?;
			let l = u32at(pos + 8)?;
			pos += 12;
			(c, l)
		};
		let deltas = pos;
		let ckeys = deltas + n * 4;
		let end = ckeys + n * 16 + if content & CONTENT_NO_NAME_HASH != 0 { 0 } else { n * 8 };
		if end > r.len() {
			return Err("root: block overruns the file".into());
		}
		if content & CONTENT_LOW_VIOLENCE == 0 {
			out.push(RootBlock { n, locales, deltas, ckeys });
		}
		pos = end;
	}
	Ok(out)
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn bucket_matches_casclib() {
		// CascLib: x = xor of the 9 key bytes; bucket = (x & 0xf) ^ (x >> 4).
		let k = [0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xde, 0xf0, 0x11, 0, 0, 0, 0, 0, 0, 0];
		let x = k[..9].iter().fold(0u8, |a, b| a ^ b);
		assert_eq!(bucket_of(&k), ((x & 0xf) ^ (x >> 4)) as usize);
	}

	#[test]
	fn root_v1_fdid_deltas() {
		let mut r = b"TSFM".to_vec();
		for v in [0x18u32, 1, 2, 2, 0] {
			r.extend_from_slice(&v.to_le_bytes());
		}
		for v in [2u32, CONTENT_NO_NAME_HASH, 0x2] {
			r.extend_from_slice(&v.to_le_bytes());
		}
		for d in [10i32, 4] {
			r.extend_from_slice(&d.to_le_bytes());
		}
		r.extend_from_slice(&[1; 16]);
		r.extend_from_slice(&[2; 16]);
		let blocks = root_blocks(&r).unwrap();
		let mut seen = Vec::new();
		for b in &blocks {
			let mut fdid = u32::MAX;
			for i in 0..b.n {
				fdid = fdid.wrapping_add(1).wrapping_add(i32::from_le_bytes(r[b.deltas + i * 4..b.deltas + i * 4 + 4].try_into().unwrap()) as u32);
				seen.push((fdid, r[b.ckeys + i * 16]));
			}
		}
		assert_eq!(seen, vec![(10, 1), (15, 2)]);
	}
}
