//! Writes the release folder's generated files (data/*.jsonl, schema/*.schema.json,
//! datapackage.json, index.json, CHANGELOG.md, corrections/LEDGER.md), seeds the hand-written ones
//! when absent (README.md, NOTICE.md, LICENSE, LICENSE-CC-BY-4.0.txt), and writes the private
//! provenance sidecar, the zip and the sqlite export.

use std::collections::{BTreeMap, BTreeSet};
use std::io::Write;
use std::path::{Path, PathBuf};

use serde_json::{json, Value};
use sha2::{Digest, Sha256};

use super::schema::{self, TableDef, SCHEMA_VERSION, TABLES};
use super::tables::Tables;

pub const DATASET: &str = "polestar-data-forever";

pub struct Meta {
	pub client_build: String,
	pub version: String,
	pub date: String,
	pub producer_commit: String,
	pub pfquest_notice: Option<String>,
}

fn io<E: std::fmt::Display>(p: &Path) -> impl Fn(E) -> String + '_ {
	move |e| format!("{}: {e}", p.display())
}

fn cmp_values(a: &Value, b: &Value) -> std::cmp::Ordering {
	match (a.as_f64(), b.as_f64()) {
		(Some(x), Some(y)) => x.total_cmp(&y),
		_ => schema::plain(a).cmp(&schema::plain(b)),
	}
}

fn sort_key<'a>(def: &TableDef, row: &'a BTreeMap<String, Value>) -> Vec<&'a Value> {
	def.key.iter().map(|k| row.get(*k).unwrap_or(&Value::Null)).collect()
}

/// One table's lines, sorted by key.
pub fn lines(def: &TableDef, t: &Tables) -> Vec<String> {
	let mut rows: Vec<&BTreeMap<String, Value>> = t.by.get(def.name).into_iter().flatten().map(|r| &r.row).collect();
	rows.sort_by(|a, b| {
		let (ka, kb) = (sort_key(def, a), sort_key(def, b));
		ka.iter().zip(kb.iter()).map(|(x, y)| cmp_values(x, y)).find(|o| o.is_ne()).unwrap_or(std::cmp::Ordering::Equal)
	});
	rows.into_iter().map(|r| serde_json::to_string(r).expect("row")).collect()
}

/// Rows of a release's data/<table>.jsonl by key (empty when absent).
pub fn read_table(dir: &Path, table: &str) -> Result<BTreeMap<String, serde_json::Map<String, Value>>, String> {
	let p = dir.join("data").join(format!("{table}.jsonl"));
	let mut out = BTreeMap::new();
	let Ok(text) = std::fs::read_to_string(&p) else { return Ok(out) };
	let def = schema::table(table).ok_or_else(|| format!("unknown table {table}"))?;
	for (i, l) in text.lines().enumerate().filter(|(_, l)| !l.trim().is_empty()) {
		let v: Value = serde_json::from_str(l).map_err(|e| format!("{}:{}: {e}", p.display(), i + 1))?;
		let o = v.as_object().cloned().ok_or_else(|| format!("{}:{}: not an object", p.display(), i + 1))?;
		out.insert(schema::key_of(def, &o), o);
	}
	Ok(out)
}

fn sha256_hex(b: &[u8]) -> String {
	let mut h = Sha256::new();
	h.update(b);
	h.finalize().iter().map(|x| format!("{x:02x}")).collect()
}

fn licence(def: &TableDef) -> Value {
	if def.own_layer {
		json!({"name": "CC-BY-4.0", "path": "https://creativecommons.org/licenses/by/4.0/", "title": "Creative Commons Attribution 4.0"})
	} else {
		json!({"name": "GPL-3.0-only", "path": "https://www.gnu.org/licenses/gpl-3.0.html", "title": "GNU General Public License v3.0"})
	}
}

fn pct(n: usize, of: usize) -> f64 {
	if of == 0 {
		0.0
	} else {
		n as f64 * 100.0 / of as f64
	}
}

/// The changelog: this version's section (a diff against `previous`, else the row counts) before the
/// existing file's sections of other versions.
fn changelog(out: &Path, t: &Tables, m: &Meta, previous: Option<&Path>, existing: &str) -> Result<(String, BTreeMap<String, (usize, usize, BTreeMap<String, usize>)>), String> {
	let mut s = String::from("# Changelog\n\nAll notable changes to this data set. The format follows Keep a Changelog\n(https://keepachangelog.com/en/1.1.0/); versions are CalVer (YYYY.MM.N).\n\n");
	s.push_str(&format!("## [{}] - {}\n\n", m.version, m.date));
	let mut diff: BTreeMap<String, (usize, usize, BTreeMap<String, usize>)> = BTreeMap::new();
	match previous {
		Some(prev) => {
			for def in TABLES {
				let old = read_table(prev, def.name)?;
				let new = read_table(out, def.name)?;
				let added = new.keys().filter(|k| !old.contains_key(*k)).count();
				let removed = old.keys().filter(|k| !new.contains_key(*k)).count();
				let mut changed: BTreeMap<String, usize> = BTreeMap::new();
				for (k, n) in &new {
					let Some(o) = old.get(k) else { continue };
					let fields: BTreeSet<&String> = n.keys().chain(o.keys()).collect();
					for f in fields {
						if n.get(f) != o.get(f) {
							*changed.entry(f.clone()).or_default() += 1;
						}
					}
				}
				diff.insert(def.name.to_string(), (added, removed, changed));
			}
			let prev_ver = std::fs::read(prev.join("index.json")).ok().and_then(|b| serde_json::from_slice::<Value>(&b).ok()).and_then(|v| v.get("version").and_then(Value::as_str).map(String::from));
			s.push_str(&format!("Compared with {}.\n\n", prev_ver.map(|v| format!("release {v}")).unwrap_or_else(|| "the previous release".into())));
			let section = |title: &str, items: Vec<String>| if items.is_empty() { String::new() } else { format!("### {title}\n\n{}\n\n", items.join("\n")) };
			s.push_str(&section("Added", diff.iter().filter(|d| d.1 .0 > 0).map(|(t, d)| format!("- {t}: {} rows", d.0)).collect()));
			s.push_str(&section("Removed", diff.iter().filter(|d| d.1 .1 > 0).map(|(t, d)| format!("- {t}: {} rows", d.1)).collect()));
			s.push_str(&section("Changed", diff.iter().flat_map(|(t, d)| d.2.iter().map(move |(f, n)| format!("- {t}.{f}: {n} values"))).collect()));
		}
		None => {
			// "First release" only when the file holds no section of another version.
			let older = existing.lines().filter_map(|l| l.strip_prefix("## [")).any(|v| v.split(']').next() != Some(m.version.as_str()));
			s.push_str(if older { "Rows per table.\n\n### Rows\n\n" } else { "First release.\n\n### Added\n\n" });
			for def in TABLES {
				let n = t.by.get(def.name).map_or(0, Vec::len);
				s.push_str(&format!("- {}: {n} rows\n", def.name));
				diff.insert(def.name.to_string(), (n, 0, BTreeMap::new()));
			}
			s.push('\n');
		}
	}
	if !t.coverage.is_empty() {
		// Over the full KB's entities that have the field (spawns, drops, chain links), else all.
		s.push_str("### Coverage\n\n");
		for (k, of, n) in &t.coverage {
			s.push_str(&format!("- {k}: {n} of {of} ({:.1}%)\n", pct(*n, *of)));
		}
		s.push('\n');
	}
	let mut cuts: BTreeMap<String, usize> = BTreeMap::new();
	for c in &t.cuts {
		*cuts.entry(format!("{}.{}", c.table, c.field)).or_default() += 1;
	}
	if !cuts.is_empty() {
		s.push_str("### Not published (no independent source holds the value)\n\n");
		for (k, n) in &cuts {
			s.push_str(&format!("- {k}: {n} values\n"));
		}
		s.push('\n');
	}
	// The sections of other versions, as they were.
	let mut keep = String::new();
	let mut on = false;
	for l in existing.lines() {
		if let Some(v) = l.strip_prefix("## [") {
			on = v.split(']').next() != Some(m.version.as_str());
		}
		if on {
			keep.push_str(l);
			keep.push('\n');
		}
	}
	if !keep.is_empty() {
		s.push_str(&keep);
	}
	Ok((s.trim_end().to_string() + "\n", diff))
}

/// NOTICE.md's first text (hand-written once seeded: publish never overwrites it).
fn notice(m: &Meta) -> String {
	let mut s =
		String::from("# NOTICE\n\nThe Polestar quest data for World of Warcraft: Forever. Every value in its tables is held by at\nleast one of the independent sources below.\n\n## Credits\n\n");
	s.push_str("- **EG Link.** EG Link output: World of Warcraft: Forever (https://github.com/JIVESCORP/eg-link-output-wowf),\n  data from Efficient Games (https://efficient.games), licensed under CC BY 4.0\n  (https://creativecommons.org/licenses/by/4.0/); reduced to quest facts.\n");
	s.push_str("- **CMaNGOS classic-db** (https://github.com/cmangos/classic-db), GPL-3.0.\n");
	s.push_str("- **VMaNGOS** values (through pfQuest) and **Factoruide** data (https://github.com/Factoruide), GPL-2.0-or-later.\n");
	s.push_str("- **ForeverTDB**, the Forever TrinityCore world database (https://github.com/advocaite/TrinityCore/tree/forever), GPL-2.0.\n");
	s.push_str("- **QuestieDB** (Questie team), credited per its maintainer; Questie is moving to GPL-3.0.\n");
	s.push_str("- **World of Warcraft: Forever client tables**, read from the game client.\n");
	s.push_str("- **pfQuest** (https://github.com/shagu/pfQuest), MIT licence:\n\n");
	let mit = m.pfquest_notice.clone().unwrap_or_else(|| "MIT License\n\nCopyright (c) 2017-2021 Eric Mauser (Shagu)".into());
	for l in mit.lines() {
		s.push_str(&format!("    {l}\n").replace("    \n", "\n"));
	}
	s.push_str(
		"\n## Disclaimer\n\nWorld of Warcraft and Blizzard Entertainment are trademarks or registered trademarks of Blizzard\nEntertainment, Inc. in the U.S. and/or other countries. This data set is not made, endorsed or\nsupported by Blizzard Entertainment. Names, ids and numbers describe the game for players; no game\nassets or game text beyond names and titles are included.\n",
	);
	s
}

/// The full GPL-3.0 text (LICENSE) and the CC BY 4.0 legal code (LICENSE-CC-BY-4.0.txt).
const GPL_3: &str = include_str!("licences/GPL-3.0.txt");
const CC_BY_4: &str = include_str!("licences/CC-BY-4.0.txt");

/// README.md's first text (hand-written once seeded: publish never overwrites it).
fn readme() -> String {
	let tier: Vec<String> = TABLES.iter().filter(|t| !t.own_layer).map(|t| format!("`data/{}.jsonl`", t.name)).collect();
	let own: Vec<String> = TABLES.iter().filter(|t| t.own_layer).map(|t| format!("`data/{}.jsonl`", t.name)).collect();
	format!(
		"# Polestar quest data for World of Warcraft: Forever\n\nOne row per line in data/*.jsonl; each table's JSON Schema is in schema/, and datapackage.json\nlists every file with its size, sha256 and licence. index.json names the version and client build.\n\n## Licences\n\n- **GPL-3.0** (LICENSE): the database tables {}.\n- **CC BY 4.0** (LICENSE-CC-BY-4.0.txt): our own layer: the quest step and mechanic text in {},\n  the schemas under schema/, and corrections/.\n\nCredits for the sources are in NOTICE.md.\n\n## Disclaimer\n\nWorld of Warcraft names and game data © Blizzard Entertainment; this project is not affiliated with\nor endorsed by Blizzard.\n",
		tier.join(", "),
		own.join(" and ")
	)
}

/// The files and folders `forge data publish` writes and replaces.
const GENERATED: &[&str] = &["data", "schema", "datapackage.json", "index.json", "CHANGELOG.md", "corrections/LEDGER.md"];
/// The hand-written files: seeded when absent, never overwritten.
const HAND_WRITTEN: &[&str] = &["README.md", "NOTICE.md", "LICENSE", "LICENSE-CC-BY-4.0.txt", "corrections"];

/// Copies the corrections into the release's corrections/ (section files, notes.json) unless they
/// are already that folder; the old single-file form is split by section.
pub fn copy_corrections(src: &Path, out: &Path) -> Result<(), String> {
	let dst = out.join("corrections");
	let same = |a: &Path, b: &Path| a.canonicalize().ok().zip(b.canonicalize().ok()).is_some_and(|(x, y)| x == y);
	if !src.exists() || same(src, &dst) {
		return Ok(());
	}
	std::fs::create_dir_all(&dst).map_err(io(&dst))?;
	if src.is_dir() {
		for e in std::fs::read_dir(src).map_err(io(src))? {
			let p = e.map_err(io(src))?.path();
			let name = p.file_name().unwrap_or_default().to_string_lossy().to_string();
			if p.is_file() && name.ends_with(".json") {
				std::fs::copy(&p, dst.join(&name)).map_err(io(&p))?;
			}
		}
		return Ok(());
	}
	let v: Value = serde_json::from_slice(&std::fs::read(src).map_err(io(src))?).map_err(io(src))?;
	for sec in crate::corrections::SECTIONS {
		let p = dst.join(format!("{sec}.json"));
		let body = v.get(sec).cloned().unwrap_or_else(|| json!({}));
		std::fs::write(&p, format!("{}\n", serde_json::to_string_pretty(&body).unwrap())).map_err(io(&p))?;
	}
	Ok(())
}

/// Writes the release folder's generated files, seeds the hand-written ones when absent; returns
/// the changelog diff per table.
pub fn write(out: &Path, t: &Tables, m: &Meta, previous: Option<&Path>, ledger: &str) -> Result<BTreeMap<String, (usize, usize, BTreeMap<String, usize>)>, String> {
	if out.exists() {
		let mut strange = Vec::new();
		for e in std::fs::read_dir(out).map_err(io(out))? {
			let name = e.map_err(io(out))?.file_name().to_string_lossy().to_string();
			if !GENERATED.contains(&name.as_str()) && !HAND_WRITTEN.contains(&name.as_str()) && !name.starts_with('.') {
				strange.push(name);
			}
		}
		if !strange.is_empty() {
			return Err(format!("{}: holds files that are not part of a release ({}); refusing to write there", out.display(), strange.join(", ")));
		}
	}
	let existing_changelog = std::fs::read_to_string(out.join("CHANGELOG.md")).unwrap_or_default();
	for g in GENERATED {
		let p = out.join(g);
		if p.is_dir() {
			std::fs::remove_dir_all(&p).map_err(io(&p))?;
		} else if p.exists() {
			std::fs::remove_file(&p).map_err(io(&p))?;
		}
	}
	std::fs::create_dir_all(out.join("data")).map_err(io(out))?;
	std::fs::create_dir_all(out.join("schema")).map_err(io(out))?;
	std::fs::create_dir_all(out.join("corrections")).map_err(io(out))?;
	let mut resources = Vec::new();
	let mut counts = serde_json::Map::new();
	for def in TABLES {
		let l = lines(def, t);
		counts.insert(def.name.into(), json!(l.len()));
		let mut text = l.join("\n");
		if !text.is_empty() {
			text.push('\n');
		}
		let p = out.join("data").join(format!("{}.jsonl", def.name));
		std::fs::write(&p, &text).map_err(io(&p))?;
		let sp = out.join("schema").join(format!("{}.schema.json", def.name));
		std::fs::write(&sp, format!("{}\n", serde_json::to_string_pretty(&schema::json_schema(def)).unwrap())).map_err(io(&sp))?;
		resources.push(json!({
			"name": def.name,
			"description": def.about,
			"path": format!("data/{}.jsonl", def.name),
			"format": "jsonl",
			"mediatype": "application/x-ndjson",
			"encoding": "utf-8",
			"bytes": text.len(),
			"hash": format!("sha256:{}", sha256_hex(text.as_bytes())),
			"schema": format!("schema/{}.schema.json", def.name),
			"licenses": [licence(def)],
		}));
	}
	let index = json!({
		"dataset": DATASET,
		"clientBuild": m.client_build,
		"schemaVersion": SCHEMA_VERSION,
		"version": m.version,
		"producerCommit": m.producer_commit,
		"counts": counts,
		"coverage": t.coverage.iter().map(|(k, of, n)| json!({"of": of, "what": k, "with": n})).collect::<Vec<_>>(),
	});
	let package = json!({
		"$schema": "https://datapackage.org/profiles/2.0/datapackage.json",
		"name": DATASET,
		"title": "Polestar quest data for World of Warcraft: Forever",
		"version": m.version,
		"created": m.date,
		"clientBuild": m.client_build,
		"schemaVersion": SCHEMA_VERSION,
		"producerCommit": m.producer_commit,
		"licenses": [
			{"name": "GPL-3.0-only", "path": "https://www.gnu.org/licenses/gpl-3.0.html", "title": "GNU General Public License v3.0"},
			{"name": "CC-BY-4.0", "path": "https://creativecommons.org/licenses/by/4.0/", "title": "Creative Commons Attribution 4.0"}
		],
		"resources": resources,
	});
	for (name, v) in [("index.json", &index), ("datapackage.json", &package)] {
		let p = out.join(name);
		std::fs::write(&p, format!("{}\n", serde_json::to_string_pretty(v).unwrap())).map_err(io(&p))?;
	}
	let (cl, diff) = changelog(out, t, m, previous, &existing_changelog)?;
	for (name, text) in [("CHANGELOG.md", cl), ("corrections/LEDGER.md", ledger.to_string())] {
		let p = out.join(name);
		std::fs::write(&p, text).map_err(io(&p))?;
	}
	for (name, text) in [("NOTICE.md", notice(m)), ("LICENSE", GPL_3.to_string()), ("LICENSE-CC-BY-4.0.txt", CC_BY_4.to_string()), ("README.md", readme())] {
		let p = out.join(name);
		if !p.exists() {
			std::fs::write(&p, text).map_err(io(&p))?;
		}
	}
	Ok(diff)
}

/// The private sidecar: every published value's sources, and the values cut.
pub fn write_sidecar(path: &Path, t: &Tables, m: &Meta) -> Result<(), String> {
	if let Some(d) = path.parent() {
		std::fs::create_dir_all(d).map_err(io(d))?;
	}
	if path.exists() {
		std::fs::remove_file(path).map_err(io(path))?;
	}
	let mut db = rusqlite::Connection::open(path).map_err(io(path))?;
	db.execute_batch(
		"create table meta(k text primary key, v text);
		create table prov(tbl text, key text, field text, value text, sources text, confidence text, primary key(tbl, key, field)) without rowid;
		create table cut(tbl text, key text, field text, value text, sources text);",
	)
	.map_err(io(path))?;
	let tx = db.transaction().map_err(io(path))?;
	{
		let mut st = tx.prepare("insert or replace into prov values (?, ?, ?, ?, ?, ?)").map_err(io(path))?;
		for def in TABLES {
			for r in t.by.get(def.name).into_iter().flatten() {
				let o: serde_json::Map<String, Value> = r.row.iter().map(|(k, v)| (k.clone(), v.clone())).collect();
				let key = schema::key_of(def, &o);
				for (field, p) in &r.prov {
					let value = if field == "_row" { serde_json::to_string(&r.row).unwrap() } else { r.row.get(field).map(|v| v.to_string()).unwrap_or_default() };
					st.execute(rusqlite::params![def.name, key, field, value, p.sources.join(","), p.confidence]).map_err(io(path))?;
				}
			}
		}
		let mut st = tx.prepare("insert into cut values (?, ?, ?, ?, ?)").map_err(io(path))?;
		for c in &t.cuts {
			st.execute(rusqlite::params![c.table, c.key, c.field, c.value, c.sources.join(",")]).map_err(io(path))?;
		}
		let mut st = tx.prepare("insert into meta values (?, ?)").map_err(io(path))?;
		for (k, v) in [("dataset", DATASET), ("version", &m.version), ("clientBuild", &m.client_build), ("producerCommit", &m.producer_commit)] {
			st.execute(rusqlite::params![k, v]).map_err(io(path))?;
		}
	}
	tx.commit().map_err(io(path))?;
	Ok(())
}

fn files_under(dir: &Path) -> Result<Vec<PathBuf>, String> {
	let mut out = Vec::new();
	let mut stack = vec![dir.to_path_buf()];
	while let Some(d) = stack.pop() {
		for e in std::fs::read_dir(&d).map_err(io(&d))? {
			let p = e.map_err(io(&d))?.path();
			if p.is_dir() {
				stack.push(p);
			} else {
				out.push(p);
			}
		}
	}
	out.sort();
	Ok(out)
}

pub fn release_files(dir: &Path) -> Result<Vec<PathBuf>, String> {
	files_under(dir)
}

/// Zips a folder (deflate, fixed timestamps, sorted names) into `zip`, every entry under `prefix/`.
pub fn zip(dir: &Path, zip: &Path, prefix: &str) -> Result<u64, String> {
	let mut body: Vec<u8> = Vec::new();
	let mut central: Vec<u8> = Vec::new();
	let files = files_under(dir)?;
	let (time, date) = (0u16, (1 << 5) | 1u16); // 1980-01-01 00:00
	for f in &files {
		let rel = f.strip_prefix(dir).unwrap().to_string_lossy().replace('\\', "/");
		let name = if prefix.is_empty() { rel } else { format!("{prefix}/{rel}") };
		let data = std::fs::read(f).map_err(io(f))?;
		let mut crc = flate2::Crc::new();
		crc.update(&data);
		let mut enc = flate2::write::DeflateEncoder::new(Vec::new(), flate2::Compression::best());
		enc.write_all(&data).map_err(io(f))?;
		let comp = enc.finish().map_err(io(f))?;
		let offset = body.len() as u32;
		let hdr = |sig: u32, central: bool| -> Vec<u8> {
			let mut h = Vec::new();
			h.extend(sig.to_le_bytes());
			if central {
				h.extend(20u16.to_le_bytes());
			}
			h.extend(20u16.to_le_bytes());
			h.extend(0x0800u16.to_le_bytes()); // utf-8 names
			h.extend(8u16.to_le_bytes());
			h.extend(time.to_le_bytes());
			h.extend(date.to_le_bytes());
			h.extend(crc.sum().to_le_bytes());
			h.extend((comp.len() as u32).to_le_bytes());
			h.extend((data.len() as u32).to_le_bytes());
			h.extend((name.len() as u16).to_le_bytes());
			h.extend(0u16.to_le_bytes());
			if central {
				h.extend(0u16.to_le_bytes()); // comment length
				h.extend(0u16.to_le_bytes()); // disk
				h.extend(0u16.to_le_bytes()); // internal attributes
				h.extend((0o100644u32 << 16).to_le_bytes());
				h.extend(offset.to_le_bytes());
			}
			h.extend(name.as_bytes());
			h
		};
		body.extend(hdr(0x04034b50, false));
		body.extend(&comp);
		central.extend(hdr(0x02014b50, true));
	}
	let cd_off = body.len() as u32;
	let cd_len = central.len() as u32;
	body.extend(central);
	body.extend(0x06054b50u32.to_le_bytes());
	body.extend([0u8; 4]);
	body.extend((files.len() as u16).to_le_bytes());
	body.extend((files.len() as u16).to_le_bytes());
	body.extend(cd_len.to_le_bytes());
	body.extend(cd_off.to_le_bytes());
	body.extend(0u16.to_le_bytes());
	std::fs::write(zip, &body).map_err(io(zip))?;
	Ok(body.len() as u64)
}

/// The release's tables as one sqlite file: a table per release table with its columns (place and
/// params as JSON text, booleans as 0/1), its key as the primary key, plus `meta` from index.json.
pub fn sqlite(dir: &Path, path: &Path) -> Result<u64, String> {
	use super::schema::Ty;
	if path.exists() {
		std::fs::remove_file(path).map_err(io(path))?;
	}
	let mut db = rusqlite::Connection::open(path).map_err(io(path))?;
	let tx = db.transaction().map_err(io(path))?;
	tx.execute_batch("create table meta(k text primary key, v text)").map_err(io(path))?;
	let index: Value = serde_json::from_slice(&std::fs::read(dir.join("index.json")).map_err(io(dir))?).map_err(io(dir))?;
	for k in ["dataset", "version", "clientBuild", "schemaVersion", "producerCommit"] {
		tx.execute("insert into meta values (?, ?)", rusqlite::params![k, schema::plain(&index[k])]).map_err(io(path))?;
	}
	for def in TABLES {
		let cols: Vec<String> = def
			.cols
			.iter()
			.map(|c| {
				let ty = match c.ty {
					Ty::Int(_) | Ty::IntOf(_) | Ty::Bool => "integer",
					Ty::Num => "real",
					_ => "text",
				};
				format!("\"{}\" {ty}", c.name)
			})
			.collect();
		let key: Vec<String> = def.key.iter().map(|k| format!("\"{k}\"")).collect();
		tx.execute_batch(&format!("create table \"{}\" ({}, primary key ({}))", def.name, cols.join(", "), key.join(", "))).map_err(io(path))?;
		let sql = format!("insert into \"{}\" values ({})", def.name, vec!["?"; def.cols.len()].join(", "));
		let mut st = tx.prepare(&sql).map_err(io(path))?;
		for row in read_table(dir, def.name)?.values() {
			let vals: Vec<rusqlite::types::Value> = def
				.cols
				.iter()
				.map(|c| match row.get(c.name) {
					None | Some(Value::Null) => rusqlite::types::Value::Null,
					Some(Value::Bool(b)) => rusqlite::types::Value::Integer(i64::from(*b)),
					Some(Value::Number(n)) => n.as_i64().map(rusqlite::types::Value::Integer).unwrap_or_else(|| rusqlite::types::Value::Real(n.as_f64().unwrap_or(0.0))),
					Some(Value::String(s)) => rusqlite::types::Value::Text(s.clone()),
					Some(v) => rusqlite::types::Value::Text(v.to_string()),
				})
				.collect();
			st.execute(rusqlite::params_from_iter(vals)).map_err(io(path))?;
		}
	}
	tx.commit().map_err(io(path))?;
	db.execute_batch("vacuum").map_err(io(path))?;
	drop(db);
	Ok(std::fs::metadata(path).map_err(io(path))?.len())
}
