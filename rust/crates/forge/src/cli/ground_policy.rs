//! Import a reviewed local semantic export, not executable Lua or raw client assets.
//! Output hashes (excluding only the provenance banner) pin the independent reference pack.
//! Areas are from identical root terrain on 70532 and 70959 with matching area hierarchies;
//! divergent or unresolved cells remain zero. Hubs are the 70532 guard/service disks.
//! Neither horizontal index certifies floor or line of sight.
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
				// Fixed-width decimal escapes preserve all 256 policy bytes in Lua 5.1.
				out.push('"');
				for byte in cells {
					write!(out, "\\{byte:03}").unwrap();
				}
				out.push_str("\",\n");
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

pub(super) fn import(from: &Path, out: &Path) -> Result<(), String> {
	let tiles = load::<Vec<Tile>>(&from.join("areas.json"), "631b76ab30cd0b156cca7e0f0d0ca8dbe7f958c7c29caad0640fe4023ea83c9e")?;
	let disks = load(&from.join("hubs.json"), "44ff820d885a8b0044cb2f751aba9db39905a05cd20b34335bc173c716f15fd4")?;
	let outputs = [
		("DangerAreas.lua", "73e4b5bdc1f53f3abb8c20f8ca57050461f1313d7c684868d2ece8678dd1c776", areas(&tiles)?),
		("DangerHubs.lua", "a6f1e506300271a68a05a3751493b66f631dfb24f296d83576827b484fa533b6", hubs(disks)?),
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
