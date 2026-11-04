//! CMaNGOS classic-db's transit facts (port of tools/lib/travel/cmangos.js loadClassicDb /
//! extractLines): lift and tram spawns, walk-in portal destinations and spell target positions,
//! cached as transit.json beside the pinned dump; rebuilt from the cached dump when missing, never
//! fetched.

use std::io::BufRead;
use std::path::Path;

use forge_guide::js::{parse_json, str_to_num, stringify, Obj, V};

use crate::cmangos::{db_url, DB_REV};

const LIFT_ENTRIES: [f64; 9] = [4170.0, 4171.0, 11898.0, 11899.0, 20649.0, 20652.0, 20655.0, 47296.0, 47297.0];
const TRAM_ENTRIES: [f64; 6] = [176080.0, 176081.0, 176082.0, 176083.0, 176084.0, 176085.0];
const PORTAL_TRIGGERS: [f64; 2] = [527.0, 542.0];

pub struct ClassicDb {
	pub rev: &'static str,
	pub url: String,
	/// { spawns, portals, positions }.
	pub data: V,
}

/// SQL tuple body -> fields, quoted strings unquoted (cmangos.js sqlFields).
fn sql_fields(body: &str) -> Vec<String> {
	let mut out = Vec::new();
	let mut cur = String::new();
	let mut quoted = false;
	let mut it = body.chars();
	while let Some(ch) = it.next() {
		if quoted {
			if ch == '\\' {
				match it.next() {
					Some(n) => cur.push(n),
					None => cur.push(ch),
				}
			} else if ch == '\'' {
				quoted = false;
			} else {
				cur.push(ch);
			}
		} else if ch == '\'' {
			quoted = true;
		} else if ch == ',' {
			out.push(cur.trim().to_string());
			cur.clear();
		} else {
			cur.push(ch);
		}
	}
	out.push(cur.trim().to_string());
	out
}

/// The tuple bodies of an `INSERT INTO ... VALUES (...),(...);` line (cmangos.js TUPLE).
fn tuples(line: &str) -> Vec<Vec<String>> {
	let mut out = Vec::new();
	let Some(start) = line.find(" VALUES ") else { return out };
	let b = line.as_bytes();
	let mut i = start;
	while i < b.len() {
		if b[i] != b'(' {
			i += 1;
			continue;
		}
		let mut j = i + 1;
		let mut ok = false;
		while j < b.len() {
			match b[j] {
				b'\'' => {
					j += 1;
					let mut closed = false;
					while j < b.len() {
						if b[j] == b'\\' && j + 1 < b.len() {
							j += 2;
						} else if b[j] == b'\'' {
							closed = true;
							j += 1;
							break;
						} else if b[j] == b'\\' {
							break;
						} else {
							j += 1;
						}
					}
					if !closed {
						break;
					}
				}
				b'(' => break,
				b')' => {
					ok = true;
					break;
				}
				_ => j += 1,
			}
		}
		if ok {
			out.push(sql_fields(&line[i + 1..j]));
			i = j + 1;
		} else {
			i += 1;
		}
	}
	out
}

fn point(map: &str, f: &[String]) -> Obj {
	let o = Obj::new();
	o.set("map", str_to_num(map));
	o.set("x", str_to_num(&f[0]));
	o.set("y", str_to_num(&f[1]));
	o.set("z", str_to_num(&f[2]));
	o
}

fn field(r: &[String], i: usize) -> &str {
	r.get(i).map(String::as_str).unwrap_or("")
}

/// extractLines: the dump's lines -> { spawns, portals, positions }.
fn extract_lines(lines: impl Iterator<Item = String>) -> Result<V, String> {
	let spawns = Obj::new();
	let portals = Obj::new();
	let positions = Obj::new();
	let want_spawn = |e: f64| LIFT_ENTRIES.contains(&e) || TRAM_ENTRIES.contains(&e);
	for line in lines {
		if line.starts_with("INSERT INTO `gameobject` VALUES") {
			for r in tuples(&line) {
				let entry = str_to_num(field(&r, 1));
				let map = str_to_num(field(&r, 2));
				if !want_spawn(entry) || !(map == 0.0 || map == 1.0 || map == 369.0) || r.len() < 8 {
					continue;
				}
				let o = Obj::new();
				o.set("guid", str_to_num(&r[0]));
				for (k, v) in point(&r[2], &r[4..7]).entries() {
					o.set_str(k, v);
				}
				o.set("o", str_to_num(&r[7]));
				let key = forge_guide::js::num_str(entry);
				if !spawns.has(&key) {
					spawns.set(&key, V::arr());
				}
				spawns.get(&key).push(o);
			}
		} else if line.starts_with("INSERT INTO `areatrigger_teleport` VALUES") {
			for r in tuples(&line) {
				if r.len() >= 10 && PORTAL_TRIGGERS.contains(&str_to_num(&r[0])) {
					portals.set(&r[0], point(&r[6], &r[7..10]));
				}
			}
		} else if line.starts_with("INSERT INTO `spell_target_position` VALUES") {
			for r in tuples(&line) {
				if r.len() >= 5 {
					positions.set(&r[0], point(&r[1], &r[2..5]));
				}
			}
		}
	}
	for list in spawns.values() {
		if let V::Arr(a) = list {
			a.0.borrow_mut().sort_by(|x, y| (x.get("guid").num() - y.get("guid").num()).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal));
		}
	}
	let mut missing: Vec<String> = LIFT_ENTRIES.iter().chain(TRAM_ENTRIES.iter()).filter(|e| !spawns.has(&forge_guide::js::num_str(**e))).map(|e| forge_guide::js::num_str(*e)).collect();
	missing.extend(PORTAL_TRIGGERS.iter().filter(|t| !portals.has(&forge_guide::js::num_str(**t))).map(|t| format!("trigger {}", forge_guide::js::num_str(*t))));
	if !missing.is_empty() || positions.is_empty() {
		let what = if missing.is_empty() { "spell_target_position".to_string() } else { missing.join(", ") };
		return Err(format!("classic-db {}: missing {what}", &DB_REV[..8]));
	}
	let o = Obj::new();
	o.set("spawns", spawns);
	o.set("portals", portals);
	o.set("positions", positions);
	Ok(V::Obj(o))
}

fn dump_lines(dump: &Path) -> Result<impl Iterator<Item = String>, String> {
	let f = std::fs::File::open(dump).map_err(|e| format!("{}: {e}", dump.display()))?;
	let r = std::io::BufReader::new(flate2::read::GzDecoder::new(f));
	Ok(r.split(b'\n').map_while(Result::ok).map(|l| {
		let s = String::from_utf8_lossy(&l).into_owned();
		s.strip_suffix('\r').map(str::to_string).unwrap_or(s)
	}))
}

/// loadClassicDb (offline).
pub fn load_classic_db(sources: &Path) -> Result<ClassicDb, String> {
	let dir = sources.join("cmangos").join(&DB_REV[..12]);
	let file = dir.join("transit.json");
	if !file.exists() {
		let dump = dir.join("classicdb.sql.gz");
		if !dump.exists() {
			return Err(format!("--offline: missing cached {}", file.display()));
		}
		let data = extract_lines(dump_lines(&dump)?)?;
		let tmp = dir.join("transit.json.tmp");
		std::fs::write(&tmp, format!("{}\n", stringify(&data, Some("\t")))).map_err(|e| e.to_string())?;
		std::fs::rename(&tmp, &file).map_err(|e| e.to_string())?;
	}
	let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
	let data = parse_json(&text).map_err(|e| format!("{}: {e}", file.display()))?;
	Ok(ClassicDb { rev: DB_REV, url: db_url(), data })
}
