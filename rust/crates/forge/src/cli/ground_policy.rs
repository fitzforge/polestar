//! Import a reviewed local semantic export, not executable Lua or raw client assets.
//! Output hashes (excluding only the provenance banner) pin the independent reference pack.
//! Areas are from identical root terrain on 70532 and 70959 with matching area hierarchies;
//! divergent or unresolved cells remain zero. Hubs are the 70532 guard/service disks. Creature
//! capsules are modeled, not live queries: Forever world placements, patrols and corrections
//! with client reactions, rank and level. Neither horizontal index certifies floor or line of sight.
use serde::{de::DeserializeOwned, Deserialize};
use sha2::{Digest, Sha256};
use std::collections::{BTreeMap, HashMap};
use std::fmt::Write;
use std::path::Path;

const MAPS: [u16; 3] = [0, 1, 2991];
const BANNER: &str = "-- Imported by forge nav layers ground; paired ground policy for builds 70532 and 70959.\n";

fn load<T: DeserializeOwned>(file: &Path, expected: &str) -> Result<T, String> {
	let bytes = std::fs::read(file).map_err(|e| format!("{}: {e}", file.display()))?;
	let actual = format!("{:x}", Sha256::digest(&bytes));
	if actual != expected {
		return Err(format!("{}: semantic export {actual}, expected {expected}", file.display()));
	}
	serde_json::from_slice(&bytes).map_err(|e| format!("{}: {e}", file.display()))
}

fn map_index(map: u16) -> Result<usize, String> {
	MAPS.iter().position(|&m| m == map).ok_or_else(|| format!("unreviewed ground map {map}"))
}

// Decimal Lua 5.1 escapes use exactly three digits even when the following byte is a digit.
fn literal(out: &mut String, bytes: impl IntoIterator<Item = u8>, plain: bool) {
	out.push('"');
	for b in bytes {
		if plain && (32..=126).contains(&b) && b != b'"' && b != b'\\' {
			out.push(char::from(b));
		} else {
			write!(out, "\\{b:03}").unwrap();
		}
	}
	out.push('"');
}

type Tile = (u16, u8, u8, Vec<u8>);

fn areas(tiles: &[Tile]) -> Result<String, String> {
	let mut out = String::from("local _,ns=...\nlocal p={\n");
	let mut pages = HashMap::new();
	let mut maps: [String; 3] = Default::default();
	for (map, col, row, cells) in tiles {
		if cells.len() != 256 || *col >= 64 || *row >= 64 {
			return Err(format!("malformed ground tile {map}/{col}_{row}"));
		}
		let mapping = &mut maps[map_index(*map)?];
		if !mapping.is_empty() {
			mapping.push(',');
		}
		write!(mapping, "[{}]=", u16::from(*row) * 64 + u16::from(*col)).unwrap();
		if cells.iter().all(|&b| b == cells[0]) {
			write!(mapping, "{}", cells[0]).unwrap();
		} else {
			let next = pages.len() + 1;
			let id = pages.entry(cells.as_slice()).or_insert_with(|| {
				literal(&mut out, cells.iter().copied(), false);
				out.push_str(",\n");
				next
			});
			write!(mapping, "p[{id}]").unwrap();
		}
	}
	out.push_str("}\nns.Nav.danger.areaCells={\n");
	for (map, mapping) in MAPS.into_iter().zip(maps) {
		writeln!(out, "[{map}]={{\n{mapping}\n}},").unwrap();
	}
	out.push_str("}\n");
	Ok(out)
}

#[derive(Deserialize)]
struct Hub {
	side: String,
	disks: Vec<[f64; 3]>,
}

#[derive(Deserialize)]
struct Hubs {
	build: String,
	#[serde(flatten)]
	maps: HashMap<String, serde_json::Value>,
}

fn bin(v: f64) -> i32 {
	(v / 128.0).floor() as i32
}

fn hubs(mut data: Hubs) -> Result<String, String> {
	if data.build != "1.60.1.70532" {
		return Err(format!("unreviewed hub build {}", data.build));
	}
	let mut out = String::from("local _,ns=...\nns.Nav.danger.hubBins={\n");
	for m in MAPS {
		let list: Vec<Hub> = serde_json::from_value(data.maps.remove(&m.to_string()).ok_or_else(|| format!("missing hub map {m}"))?).map_err(|e| e.to_string())?;
		writeln!(out, "[{m}]={{").unwrap();
		for (profile, enemy) in [("Horde", "Alliance"), ("Alliance", "Horde")] {
			let mut bins: BTreeMap<i32, String> = BTreeMap::new();
			for hub in list.iter().filter(|h| h.side == enemy) {
				for &[x, y, r] in &hub.disks {
					if x.abs() > 32767.0 || y.abs() > 32767.0 || !(0.0..256.0).contains(&r) {
						return Err(format!("invalid hub disk on map {m}"));
					}
					let padded = r + 0.55;
					let r2 = (padded * padded * 1e6).round() / 1e6;
					for i in bin(x - padded)..=bin(x + padded) {
						for j in bin(y - padded)..=bin(y + padded) {
							let entry = bins.entry(i * 512 + j).or_default();
							if !entry.is_empty() {
								entry.push(',');
							}
							write!(entry, "{x},{y},{r2}").unwrap();
						}
					}
				}
			}
			writeln!(out, "{profile}={{").unwrap();
			for (k, disks) in bins {
				writeln!(out, "[{k}]={{{disks}}},").unwrap();
			}
			out.push_str("},\n");
		}
		out.push_str("},\n");
	}
	out.push_str("}\n");
	Ok(out)
}

// Quantized, outward-padded capsules: never turn raw movement into a guessed floor or safe radius here.
#[derive(Deserialize)]
struct Capsule(u16, i16, i16, i16, i16, u8, u8, u8, u8);

fn creatures(input: &[Capsule]) -> Result<String, String> {
	let mut lookup = HashMap::new();
	let mut records: Vec<[u8; 10]> = Vec::new();
	let mut maps: [BTreeMap<i32, Vec<u32>>; 3] = Default::default();
	for &Capsule(m, mut x, mut y, mut xx, mut yy, radius, a, h, kinds) in input {
		let bins = &mut maps[map_index(m)?];
		if (x, y) > (xx, yy) {
			std::mem::swap(&mut x, &mut xx);
			std::mem::swap(&mut y, &mut yy);
		}
		let dx = i32::from(xx) - i32::from(x);
		let dy = i32::from(yy) - i32::from(y);
		if dx.abs() > 64 || dy.abs() > 64 || radius == 0 || (a == 0 && h == 0) || kinds % 8 > 5 || kinds / 8 > 5 {
			return Err(format!("invalid threat capsule on map {m}"));
		}
		let [lx, hx] = ((x as u16) ^ 0x8000).to_le_bytes();
		let [ly, hy] = ((y as u16) ^ 0x8000).to_le_bytes();
		let key = [a, h, kinds, lx, hx, ly, hy, (dx + 64) as u8, (dy + 64) as u8, radius];
		let idx = *lookup.entry(key).or_insert_with(|| {
			let i = records.len() as u32;
			records.push(key);
			i
		});
		if idx >= 1 << 24 {
			return Err("creature reference exceeds 24 bits".into());
		}
		let rr = f64::from(radius) + 0.46;
		for i in bin(f64::from(x.min(xx)) - rr)..=bin(f64::from(x.max(xx)) + rr) {
			for j in bin(f64::from(y.min(yy)) - rr)..=bin(f64::from(y.max(yy)) + rr) {
				if !(-256..256).contains(&j) {
					return Err("creature bin outside world extent".into());
				}
				bins.entry(i * 512 + j).or_default().push(idx);
			}
		}
	}
	let mut out = String::from("local _, ns = ...\nlocal data = { version = 1, blocks = {}, maps = {} }\nns.Nav.danger.creatureThreatData = data\n");
	for (i, block) in records.chunks(256).enumerate() {
		write!(out, "data.blocks[{}]=", i + 1).unwrap();
		literal(&mut out, block.iter().flatten().copied(), true);
		out.push('\n');
	}
	for (m, bins) in MAPS.into_iter().zip(maps) {
		writeln!(out, "data.maps[{m}]={{").unwrap();
		for (k, mut ids) in bins {
			ids.sort_unstable_by_key(|&i| {
				let row = &records[i as usize];
				(u8::MAX - row[0].max(row[1]), i)
			});
			ids.dedup();
			let mut max = [0_u8; 2];
			for &i in &ids {
				let row = &records[i as usize];
				max = [max[0].max(row[0]), max[1].max(row[1])];
			}
			write!(out, "[{k}]=").unwrap();
			literal(&mut out, max.into_iter().chain(ids.into_iter().flat_map(|i| i.to_le_bytes().into_iter().take(3))), true);
			out.push_str(",\n");
		}
		out.push_str("}\n");
	}
	Ok(out)
}

pub(super) fn import(from: &Path, out: &Path) -> Result<(), String> {
	let tiles = load::<Vec<Tile>>(&from.join("areas.json"), "631b76ab30cd0b156cca7e0f0d0ca8dbe7f958c7c29caad0640fe4023ea83c9e")?;
	let disks = load(&from.join("hubs.json"), "44ff820d885a8b0044cb2f751aba9db39905a05cd20b34335bc173c716f15fd4")?;
	let capsules = load::<Vec<Capsule>>(&from.join("creatures.json"), "08ecc9be1e8db68178151bc91704a01da3e47375cc70e007f90d0ba69b078960")?;
	let outputs = [
		("DangerAreas.lua", "73e4b5bdc1f53f3abb8c20f8ca57050461f1313d7c684868d2ece8678dd1c776", areas(&tiles)?),
		("DangerHubs.lua", "a6f1e506300271a68a05a3751493b66f631dfb24f296d83576827b484fa533b6", hubs(disks)?),
		("CreatureThreatData.lua", "f17a5d46fd8bbb54e05502da34920a08e3c605d011b8febf3c27907bc7671bb4", creatures(&capsules)?),
	];
	// Check every independent reference before touching even the first destination.
	for (name, reference, payload) in &outputs {
		let actual = format!("{:x}", Sha256::digest(payload.as_bytes()));
		if actual != *reference {
			return Err(format!("{name}: imported payload {actual}, expected {reference}; no files written"));
		}
	}
	std::fs::create_dir_all(out).map_err(|e| e.to_string())?;
	for (name, _, payload) in outputs {
		let dst = out.join(name);
		let tmp = dst.with_extension("lua.tmp");
		let mut file = std::fs::File::create(&tmp).map_err(|e| format!("{}: {e}", tmp.display()))?;
		use std::io::Write;
		file.write_all(BANNER.as_bytes()).and_then(|()| file.write_all(payload.as_bytes())).map_err(|e| format!("{}: {e}", tmp.display()))?;
		drop(file);
		std::fs::rename(&tmp, &dst).map_err(|e| format!("{}: {e}", dst.display()))?;
	}
	Ok(())
}
