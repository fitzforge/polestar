//! The roads layer: per grid column, how much of the ground the client paints with a road texture,
//! from the terrain's own texture layers (tex0 ADTs) and the reviewed allowlist of road textures
//! (data/road-textures.json, names from the wowdev community listfile). A port of
//! tools/lib/nav/layers/{roads,tex0,listfile}.js with byte-identical files.
//!
//! One file per ADT tile, `<dir>/<c>/<col>_<row>.bin`: 65536 bytes, the weight 0-255 of column (i, j)
//! at j * 256 + i (the grid's column order); a column is road from 128 (half the ground). index.json
//! there: { continents: { c: ["col_row"] }, build } of the tiles with any road.
//!
//! Blending: a layer above the base weighs its alpha; the base what they leave (255 minus their sum, at
//! least 0); weights are normalised by their sum, as the client's terrain shader blends (height bias left
//! out). A column's weight is the mean of its 4 x 4 alpha texels (a chunk is 16 x 16 columns and 64 x 64
//! texels).
//!
//! A tex0 ADT (the split ADT's texture file, MAID index 3): MVER MAMP MDID MHID MCNK x256, each MCNK
//! holding MCLY and MCAL. MDID: the diffuse textures' FileDataIDs, indexed by MCLY.textureId. MCLY: 16
//! bytes per layer (textureId, flags, offsetInMCAL, effectId); layer 0 is the base, without alpha; a
//! layer with flag 0x100 has an alpha map at offsetInMCAL: with 0x200 RLE-compressed to 4096 bytes, else
//! 4096 bytes when the WDT's MPHD has flag 0x4 or 0x80 ('big alpha'), else 2048 bytes of 4-bit values
//! (low nibble first, x 17; 63 x 63 with the last row and column repeated when the root MCNK lacks flag
//! 0x8000).

use crate::geom::parse::{chunk, chunks};
use crate::geom::{continent_flags, continent_tiles, Source, Tables, TileRef};
use rayon::prelude::*;
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::{json, Map, Value};
use std::io::BufRead;
use std::path::Path;

const SIZE: usize = 64;
const ALPHA: usize = SIZE * SIZE;
const FLAG_ALPHA: u32 = 0x100;
const FLAG_COMPRESSED: u32 = 0x200;
pub const MPHD_BIG_ALPHA: u32 = 0x4 | 0x80;
const COLUMNS: usize = 65536;
/// A column is road from this weight.
pub const ROAD: u8 = 128;
pub const NAMED: &str = "road|path|cobble|street|trail";
pub const GROUND: &str = "dirt|footprint|brick|gravel";
/// Road by shape: a component is a strip when at least LONG_YD long (bounding box diagonal), at most
/// NARROW columns of mean width and at least ELONGATED long (diagonal² / area); a texture's shape is a
/// road's when ROAD_SHARE of its weight lies in strips.
pub const LONG_YD: f64 = 60.0;
pub const NARROW: f64 = 6.0;
pub const ELONGATED: f64 = 10.0;
pub const ROAD_SHARE: f64 = 0.5;
const CELL: f64 = 1600.0 / 3.0 / 256.0;

fn matches_any(s: &str, alts: &str) -> bool {
	alts.split('|').any(|a| s.contains(a))
}

/// One texture layer of a chunk.
pub struct Layer {
	pub tex: u32,
	pub flags: u32,
	pub alpha: Option<Vec<u8>>,
}

/// A parsed tex0: the MDID textures and per chunk its layers.
pub struct Tex0 {
	pub textures: Vec<u32>,
	pub chunks: Vec<Vec<Layer>>,
}

fn u32le(b: &[u8], o: usize) -> u32 {
	u32::from_le_bytes(b[o..o + 4].try_into().unwrap())
}

fn inflate(data: &[u8], mut o: usize) -> Result<Vec<u8>, String> {
	let mut out = vec![0u8; ALPHA];
	let mut n = 0;
	while n < ALPHA {
		if o >= data.len() {
			return Err(format!("tex0: compressed alpha map ends after {n} of {ALPHA} values"));
		}
		let b = data[o];
		o += 1;
		let count = ((b & 0x7f) as usize).min(ALPHA - n);
		if b & 0x80 != 0 {
			let v = data.get(o).copied().unwrap_or(0);
			o += 1;
			out[n..n + count].fill(v);
		} else {
			if o + count > data.len() {
				return Err("tex0: compressed alpha map copies past the end of MCAL".into());
			}
			out[n..n + count].copy_from_slice(&data[o..o + count]);
			o += count;
		}
		n += count;
	}
	Ok(out)
}

fn four_bit(data: &[u8], o: usize, fix: bool) -> Result<Vec<u8>, String> {
	if o + ALPHA / 2 > data.len() {
		return Err("tex0: 4-bit alpha map past the end of MCAL".into());
	}
	let mut out = vec![0u8; ALPHA];
	for k in 0..ALPHA / 2 {
		let b = data[o + k];
		out[2 * k] = (b & 0x0f) * 17;
		out[2 * k + 1] = (b >> 4) * 17;
	}
	if fix {
		for y in 0..SIZE {
			out[y * SIZE + SIZE - 1] = out[y * SIZE + SIZE - 2];
		}
		out.copy_within((SIZE - 2) * SIZE..(SIZE - 1) * SIZE, (SIZE - 1) * SIZE);
	}
	Ok(out)
}

/// tex0.js parseTex0: `fix(n)` the 4-bit fix of chunk n.
pub fn parse_tex0(buf: &[u8], big_alpha: bool, fix: &dyn Fn(usize) -> bool) -> Result<Tex0, String> {
	let top = chunks(buf, 0)?;
	let textures = chunk(&top, b"MDID").map(|m| (0..m.len() / 4).map(|i| u32le(m, i * 4)).collect()).unwrap_or_default();
	let mut out = Vec::new();
	for c in top.iter().filter(|c| &c.tag == b"MCNK") {
		let n = out.len();
		let subs = chunks(c.data, 0)?;
		let mcal = chunk(&subs, b"MCAL");
		let mut layers = Vec::new();
		if let Some(mcly) = chunk(&subs, b"MCLY") {
			let mut o = 0;
			while o + 16 <= mcly.len() {
				let flags = u32le(mcly, o + 4);
				let alpha = match (o, mcal) {
					(0, _) | (_, None) => None,
					(_, Some(mcal)) if flags & FLAG_ALPHA != 0 => {
						let off = u32le(mcly, o + 8) as usize;
						Some(if flags & FLAG_COMPRESSED != 0 {
							inflate(mcal, off)?
						} else if big_alpha {
							if off + ALPHA > mcal.len() {
								return Err("tex0: alpha map past the end of MCAL".into());
							}
							mcal[off..off + ALPHA].to_vec()
						} else {
							four_bit(mcal, off, fix(n))?
						})
					}
					_ => None,
				};
				layers.push(Layer { tex: u32le(mcly, o), flags, alpha });
				o += 16;
			}
		}
		out.push(layers);
	}
	if out.len() != 256 {
		return Err(format!("tex0: {} MCNK chunks, not 256", out.len()));
	}
	Ok(Tex0 { textures, chunks: out })
}

/// Parsed tex0 and the road textures' fdids -> per column weights.
pub fn tile_road_weights(t: &Tex0, road: &FxHashSet<u32>) -> Vec<u8> {
	let mut out = vec![0u8; COLUMNS];
	let mut sum = [0f64; 256];
	let mut rw = vec![0f64; ALPHA];
	for (n, layers) in t.chunks.iter().enumerate() {
		let is_road: Vec<bool> = layers.iter().map(|l| t.textures.get(l.tex as usize).is_some_and(|f| road.contains(f))).collect();
		if !is_road.iter().any(|&b| b) {
			continue;
		}
		for (ti, r) in rw.iter_mut().enumerate() {
			let (mut above, mut road_above) = (0f64, 0f64);
			for k in 1..layers.len() {
				let a = layers[k].alpha.as_ref().map_or(0.0, |al| al[ti] as f64);
				above += a;
				if is_road[k] {
					road_above += a;
				}
			}
			let base = (255.0 - above).max(0.0);
			let total = base + above;
			*r = if total != 0.0 { (255.0 * (road_above + if is_road[0] { base } else { 0.0 })) / total } else { 0.0 };
		}
		sum.fill(0.0);
		for y in 0..64 {
			for x in 0..64 {
				sum[(y >> 2) * 16 + (x >> 2)] += rw[y * 64 + x];
			}
		}
		let x0 = (n % 16) * 16;
		let y0 = (n / 16) * 16;
		for j in 0..16 {
			for i in 0..16 {
				out[(y0 + j) * 256 + x0 + i] = forge_core::jsnum::js_round(sum[j * 16 + i] / 16.0) as u8;
			}
		}
	}
	out
}

/// One component of a texture's weights (8-connected columns of at least ROAD).
#[derive(Clone, Debug, PartialEq)]
pub struct Shape {
	pub area: u32,
	pub weight: f64,
	pub perimeter: u32,
	pub width: f64,
	pub length: f64,
	pub elongation: f64,
}

/// roads.js shapeOf.
pub fn shape_of(w: &[u8]) -> Vec<Shape> {
	let mut label = vec![-1i32; COLUMNS];
	let mut stack: Vec<usize> = Vec::new();
	let mut out = Vec::new();
	for s in 0..COLUMNS {
		if w[s] < ROAD || label[s] >= 0 {
			continue;
		}
		let id = out.len() as i32;
		stack.push(s);
		label[s] = id;
		let (mut area, mut weight, mut perimeter) = (0u32, 0f64, 0u32);
		let (mut i0, mut i1, mut j0, mut j1) = (255usize, 0usize, 255usize, 0usize);
		while let Some(k) = stack.pop() {
			let (i, j) = (k & 255, k >> 8);
			area += 1;
			weight += w[k] as f64;
			i0 = i0.min(i);
			i1 = i1.max(i);
			j0 = j0.min(j);
			j1 = j1.max(j);
			for (ok, n) in [(i > 0, k.wrapping_sub(1)), (i < 255, k + 1), (j > 0, k.wrapping_sub(256)), (j < 255, k + 256)] {
				if !ok || w[n] < ROAD {
					perimeter += 1;
				} else if label[n] < 0 {
					label[n] = id;
					stack.push(n);
				}
			}
			for (ok, n) in [(i > 0 && j > 0, k.wrapping_sub(257)), (i < 255 && j > 0, k.wrapping_sub(255)), (i > 0 && j < 255, k + 255), (i < 255 && j < 255, k + 257)] {
				if ok && w[n] >= ROAD && label[n] < 0 {
					label[n] = id;
					stack.push(n);
				}
			}
		}
		let diagonal = forge_core::jsnum::js_hypot((i1 - i0 + 1) as f64, (j1 - j0 + 1) as f64);
		out.push(Shape { area, weight, perimeter, width: area as f64 / (perimeter as f64 / 2.0), length: diagonal * CELL, elongation: (diagonal * diagonal) / area as f64 });
	}
	out
}

/// A texture's verdict by shape.
#[derive(Clone, Debug, PartialEq)]
pub struct Verdict {
	pub road: bool,
	pub share: f64,
	pub columns: u64,
	pub components: usize,
	pub median_width: Option<f64>,
}

/// roads.js roadByShape.
pub fn road_by_shape(components: &[Shape]) -> Verdict {
	let (mut total, mut thin, mut columns) = (0f64, 0f64, 0u64);
	for s in components {
		total += s.weight;
		columns += s.area as u64;
		if s.length >= LONG_YD && s.width <= NARROW && s.elongation >= ELONGATED {
			thin += s.weight;
		}
	}
	let mut by_width: Vec<&Shape> = components.iter().collect();
	by_width.sort_by(|a, b| a.width.partial_cmp(&b.width).unwrap());
	let mut median_width = None;
	let mut sum = 0.0;
	for s in by_width {
		sum += s.weight;
		if sum >= total / 2.0 {
			median_width = Some(s.width);
			break;
		}
	}
	let share = if total != 0.0 { thin / total } else { 0.0 };
	Verdict { road: share >= ROAD_SHARE, share, columns, components: components.len(), median_width }
}

/// A texture path as the allowlist names it: lowercase, forward slashes, the `_s` and `_h` variants as
/// their base.
pub fn texture_key(p: &str) -> String {
	let k = p.to_lowercase().replace('\\', "/");
	for suf in ["_s.blp", "_h.blp"] {
		if let Some(b) = k.strip_suffix(suf) {
			return format!("{b}.blp");
		}
	}
	k
}

fn tileset_path(k: &str) -> bool {
	k.starts_with("tileset/") && k.ends_with(".blp") && !k.ends_with("_s.blp") && !k.ends_with("_h.blp")
}

/// fn(fdid, path) for every line of the listfile (`fdid;path`, the path trimmed and lowercased).
pub fn scan_listfile(file: &Path, mut f: impl FnMut(u32, &str)) -> Result<(), String> {
	let r = std::io::BufReader::new(std::fs::File::open(file).map_err(|e| format!("{}: {e}", file.display()))?);
	for line in r.lines() {
		let line = line.map_err(|e| format!("{}: {e}", file.display()))?;
		let Some(k) = line.find(';').filter(|&k| k > 0) else { continue };
		let Ok(fdid) = line[..k].trim().parse::<u32>() else { continue };
		f(fdid, &line[k + 1..].trim().to_lowercase());
	}
	Ok(())
}

/// The 4-bit fix per chunk (root MCNK without 0x8000), only read without big alpha.
fn fix_of(src: &dyn Source, t: &TileRef, big_alpha: bool) -> Result<Vec<bool>, String> {
	if big_alpha {
		return Ok(Vec::new());
	}
	let root = src.get(t.root)?.ok_or_else(|| format!("fileDataID {}: HTTP 404", t.root))?;
	Ok(chunks(&root, 0)?.iter().filter(|c| &c.tag == b"MCNK").map(|c| u32le(c.data, 0) & 0x8000 == 0).collect())
}

fn read_tex0(src: &dyn Source, t: &TileRef, big_alpha: bool) -> Result<Tex0, String> {
	let fix = fix_of(src, t, big_alpha)?;
	let buf = src.get(t.tex0)?.ok_or_else(|| format!("fileDataID {}: HTTP 404", t.tex0))?;
	parse_tex0(&buf, big_alpha, &|n| fix.get(n).copied().unwrap_or(true))
}

/// One continent's build: tiles, tiles with road, road columns, big alpha, and the road textures used
/// (fdid, path, tiles).
pub struct RoadStats {
	pub c: u32,
	pub tiles: usize,
	pub road_tiles: usize,
	pub road_columns: usize,
	pub big_alpha: bool,
	pub textures: Vec<(u32, String, usize)>,
	pub seconds: f64,
}

/// roads.js buildRoads: every tile with a tex0 of `continents` into `dir`, and index.json.
/// `allow`: the allowlist's textures (texture keys).
pub fn build_roads(
	src: &dyn Source,
	tables: &Tables,
	build: &str,
	continents: &[u32],
	dir: &Path,
	listfile: &Path,
	allow: &FxHashSet<String>,
	log: &(dyn Fn(&str) + Sync),
) -> Result<Vec<RoadStats>, String> {
	let mut road: FxHashSet<u32> = FxHashSet::default();
	let mut names: FxHashMap<u32, String> = FxHashMap::default();
	scan_listfile(listfile, |fdid, p| {
		if allow.contains(&texture_key(p)) {
			road.insert(fdid);
			names.insert(fdid, p.to_string());
		}
	})?;
	let index_file = dir.join("index.json");
	let mut index: Value = match std::fs::read(&index_file) {
		Ok(b) => serde_json::from_slice(&b).map_err(|e| format!("{}: {e}", index_file.display()))?,
		Err(_) => json!({ "continents": {} }),
	};
	let mut stats = Vec::new();
	for &c in continents {
		let t0 = std::time::Instant::now();
		let tiles: Vec<TileRef> = continent_tiles(src, tables, c)?.into_iter().filter(|t| t.tex0 != 0).collect();
		let big_alpha = continent_flags(src, tables, c)? & MPHD_BIG_ALPHA != 0;
		let cdir = dir.join(c.to_string());
		std::fs::create_dir_all(&cdir).map_err(|e| format!("{}: {e}", cdir.display()))?;
		let done = std::sync::atomic::AtomicUsize::new(0);
		let outs: Vec<(String, bool, usize, Vec<u32>)> = tiles
			.par_iter()
			.map(|t| -> Result<_, String> {
				let parsed = read_tex0(src, t, big_alpha)?;
				let w = tile_road_weights(&parsed, &road);
				let used: FxHashSet<u32> = parsed.textures.iter().copied().filter(|f| road.contains(f)).collect();
				let n = w.iter().filter(|&&v| v >= ROAD).count();
				let file = cdir.join(format!("{}_{}.bin", t.col, t.row));
				let tmp = cdir.join(format!("{}_{}.bin.tmp", t.col, t.row));
				std::fs::write(&tmp, &w).map_err(|e| format!("{}: {e}", tmp.display()))?;
				std::fs::rename(&tmp, &file).map_err(|e| format!("{}: {e}", file.display()))?;
				let d = done.fetch_add(1, std::sync::atomic::Ordering::Relaxed) + 1;
				if d.is_multiple_of(200) {
					log(&format!("roads {c}: {d}/{} tiles", tiles.len()));
				}
				Ok((format!("{}_{}", t.col, t.row), w.iter().any(|&v| v != 0), n, used.into_iter().collect()))
			})
			.collect::<Result<_, _>>()?;
		let mut with_road: Vec<(i64, i64, String)> = outs
			.iter()
			.filter(|o| o.1)
			.map(|o| {
				let (a, b) = o.0.split_once('_').unwrap();
				(a.parse().unwrap(), b.parse().unwrap(), o.0.clone())
			})
			.collect();
		with_road.sort();
		let mut used: Vec<(u32, usize)> = Vec::new();
		for o in &outs {
			for &f in &o.3 {
				match used.iter_mut().find(|u| u.0 == f) {
					Some(u) => u.1 += 1,
					None => used.push((f, 1)),
				}
			}
		}
		used.sort_by(|a, b| b.1.cmp(&a.1).then(a.0.cmp(&b.0)));
		index["build"] = json!(build);
		if !index["continents"].is_object() {
			index["continents"] = json!({});
		}
		index["continents"][c.to_string()] = json!(with_road.iter().map(|w| w.2.clone()).collect::<Vec<_>>());
		std::fs::write(&index_file, format!("{}\n", crate::build::js_json(&index, None))).map_err(|e| format!("{}: {e}", index_file.display()))?;
		stats.push(RoadStats {
			c,
			tiles: tiles.len(),
			road_tiles: with_road.len(),
			road_columns: outs.iter().map(|o| o.2).sum(),
			big_alpha,
			textures: used.into_iter().map(|(f, n)| (f, names.get(&f).cloned().unwrap_or_default(), n)).collect(),
			seconds: t0.elapsed().as_secs_f64(),
		});
	}
	Ok(stats)
}

/// The allowlist's sort: String.prototype.localeCompare (ICU root collation) on lowercase ASCII paths,
/// where spaces and punctuation come before digits and letters.
pub fn locale_cmp(a: &str, b: &str) -> std::cmp::Ordering {
	const ORDER: &str = " _-,;:!?.'\"()[]{}@*/\\&#%`^+<=>|~$0123456789abcdefghijklmnopqrstuvwxyz";
	let w = |c: char| ORDER.find(c).unwrap_or(ORDER.len() + c as usize);
	a.chars().map(w).cmp(b.chars().map(w))
}

/// A texture's row in the allowlist's shapes.
pub struct ShapeRow {
	pub texture: String,
	pub tiles: u64,
	pub kind: &'static str,
	pub verdict: Verdict,
	pub road: bool,
}

/// What road_allowlist found.
pub struct Allowlist {
	pub textures: Vec<String>,
	pub shapes: Vec<ShapeRow>,
	pub used: usize,
	pub unnamed: usize,
}

/// roads.js roadAllowlist: every diffuse texture the continents' tex0 files use (named by the listfile),
/// each measured by shape; `reviewed` the allowlist's reviewed textures.
pub fn road_allowlist(src: &dyn Source, tables: &Tables, continents: &[u32], listfile: &Path, reviewed: &[String], log: &(dyn Fn(&str) + Sync)) -> Result<Allowlist, String> {
	let mut counts: FxHashMap<u32, u64> = FxHashMap::default();
	let mut lists = Vec::new();
	for &c in continents {
		let tiles: Vec<TileRef> = continent_tiles(src, tables, c)?.into_iter().filter(|t| t.tex0 != 0).collect();
		let big_alpha = continent_flags(src, tables, c)? & MPHD_BIG_ALPHA != 0;
		let seen: Vec<FxHashSet<u32>> = tiles
			.par_iter()
			.map(|t| -> Result<_, String> {
				let buf = src.get(t.tex0)?.ok_or_else(|| format!("fileDataID {}: HTTP 404", t.tex0))?;
				let top = chunks(&buf, 0)?;
				Ok(chunk(&top, b"MDID").map(|m| (0..m.len() / 4).map(|i| u32le(m, i * 4)).collect()).unwrap_or_default())
			})
			.collect::<Result<_, _>>()?;
		for s in seen {
			for f in s {
				*counts.entry(f).or_default() += 1;
			}
		}
		log(&format!("allowlist: {c} read ({} tiles)", tiles.len()));
		lists.push((tiles, big_alpha));
	}
	let mut used: FxHashMap<String, u64> = FxHashMap::default();
	let mut fdids_of: Vec<(String, FxHashSet<u32>)> = Vec::new();
	let mut named: FxHashSet<u32> = FxHashSet::default();
	scan_listfile(listfile, |fdid, p| {
		let Some(&n) = counts.get(&fdid) else { return };
		named.insert(fdid);
		let key = texture_key(p);
		*used.entry(key.clone()).or_default() += n;
		if tileset_path(&key) {
			match fdids_of.iter_mut().find(|x| x.0 == key) {
				Some(x) => {
					x.1.insert(fdid);
				}
				None => fdids_of.push((key, [fdid].into_iter().collect())),
			}
		}
	})?;
	let mut path_of: FxHashMap<u32, usize> = FxHashMap::default();
	for (i, (_, set)) in fdids_of.iter().enumerate() {
		for &f in set {
			path_of.insert(f, i);
		}
	}
	let mut parts: Vec<Vec<Shape>> = vec![Vec::new(); fdids_of.len()];
	for (c, (tiles, big_alpha)) in continents.iter().zip(&lists) {
		let found: Vec<Vec<(usize, Vec<Shape>)>> = tiles
			.par_iter()
			.map(|t| -> Result<_, String> {
				let parsed = read_tex0(src, t, *big_alpha)?;
				let mut here: Vec<usize> = parsed.textures.iter().filter_map(|f| path_of.get(f).copied()).collect();
				here.sort_unstable();
				here.dedup();
				Ok(here.into_iter().map(|p| (p, shape_of(&tile_road_weights(&parsed, &fdids_of[p].1)))).collect())
			})
			.collect::<Result<_, _>>()?;
		for list in found {
			for (p, s) in list {
				parts[p].extend(s);
			}
		}
		log(&format!("allowlist: {c} measured"));
	}
	let review: FxHashSet<String> = reviewed.iter().map(|r| texture_key(r)).collect();
	let mut shapes: Vec<ShapeRow> = fdids_of
		.iter()
		.zip(&parts)
		.map(|((texture, _), comps)| {
			let v = road_by_shape(comps);
			let name = &texture["tileset/".len()..];
			let kind = if matches_any(name, NAMED) {
				"name"
			} else if matches_any(name, GROUND) {
				"ground"
			} else if review.contains(texture) {
				"review"
			} else {
				"other"
			};
			let road = kind == "name" || ((kind == "ground" || kind == "review") && v.road);
			ShapeRow { texture: texture.clone(), tiles: used.get(texture).copied().unwrap_or(0), kind, verdict: v, road }
		})
		.collect();
	shapes.sort_by(|a, b| locale_cmp(&a.texture, &b.texture));
	let textures = shapes.iter().filter(|s| s.road).map(|s| s.texture.clone()).collect();
	Ok(Allowlist { textures, shapes, used: used.len(), unnamed: counts.keys().filter(|f| !named.contains(f)).count() })
}

/// The allowlist document (data/road-textures.json): the rules, the reviewed entries kept as they
/// are, the road textures and the measures of every named, ground and reviewed texture and of every
/// other road-shaped one.
pub fn allowlist_doc(a: &Allowlist, build: &str, maps: &[u32], reviewed: &Value, command: &str) -> Value {
	let about = format!(
		"Road textures (tileset paths, the _s and _h variants as their base) for the roads layer, of the diffuse textures the tex0 ADTs of the listed maps use (names from the wowdev community listfile): every one whose path matches named; one whose path matches ground when its shape is a road's; one in reviewed (checked by a person to lie on known roads) when its shape is a road's. A shape is a road's when at least roadShare of the texture's weight lies in strips: 8-connected components of columns where it weighs >= 128 (per tile) at least longYd long (bounding box diagonal), at most narrow columns of mean width (area over half the perimeter) and at least elongated long (diagonal^2 / area, in columns). shapes: the measures of every named, ground and reviewed texture and of every other road-shaped one (kind other: candidates for review; medianWidth: the width half the weight lies under). Regenerate with {command}."
	);
	let fixed = |v: f64, d: usize| -> Value { json!(forge_core::jsnum::js_to_fixed(v, d).parse::<f64>().unwrap()) };
	let shapes: Vec<Value> = a
		.shapes
		.iter()
		.filter(|s| s.kind != "other" || s.verdict.road)
		.map(|s| {
			let mut m = Map::new();
			m.insert("texture".into(), json!(s.texture));
			m.insert("kind".into(), json!(s.kind));
			m.insert("tiles".into(), json!(s.tiles));
			m.insert("columns".into(), json!(s.verdict.columns));
			m.insert("components".into(), json!(s.verdict.components));
			m.insert("medianWidth".into(), s.verdict.median_width.map_or(Value::Null, |w| fixed(w, 2)));
			m.insert("share".into(), fixed(s.verdict.share, 3));
			m.insert("road".into(), json!(s.road));
			Value::Object(m)
		})
		.collect();
	let mut doc = Map::new();
	doc.insert("about".into(), json!(about));
	doc.insert("build".into(), json!(build));
	doc.insert("maps".into(), json!(maps));
	doc.insert("named".into(), json!(NAMED));
	doc.insert("ground".into(), json!(GROUND));
	doc.insert("longYd".into(), json!(LONG_YD as u64));
	doc.insert("narrow".into(), json!(NARROW as u64));
	doc.insert("elongated".into(), json!(ELONGATED as u64));
	doc.insert("roadShare".into(), json!(ROAD_SHARE));
	doc.insert("reviewed".into(), reviewed.clone());
	doc.insert("textures".into(), json!(a.textures));
	doc.insert("shapes".into(), Value::Array(shapes));
	Value::Object(doc)
}
