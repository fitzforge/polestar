//! The public data pack: `forge data pack` gathers what forge build needs when the private
//! sources are absent (src/pack-spec.json: each source's files, licence and credit), builds the
//! knowledge base's public part, scans the result for anything private (the guard), writes
//! `manifest.json` and archives it as `polestar-data-pack.tar.gz` with an index
//! (`polestar-data-pack.json`: the archive's BLAKE3 and size, and the manifest).
//! `forge data fetch` (fetch.rs) downloads, verifies and unpacks it.

use rusqlite::Connection;
use serde_json::{json, Value};
use std::io::{Read, Write};
use std::path::{Path, PathBuf};

type VerifyRow = (Option<i64>, String, i64, Option<String>, Option<i64>, Option<String>);
type SourceRow = (String, Option<f64>, Option<String>, Option<String>);

pub const SPEC: &str = include_str!("pack-spec.json");
pub const ARCHIVE: &str = "polestar-data-pack.tar.gz";
pub const INDEX: &str = "polestar-data-pack.json";
pub const MANIFEST: &str = "manifest.json";

/// A quest step's sources the public pack takes (kb.rs `steps.source`).
pub const STEP_SOURCES: [&str; 4] = ["server", "forever-data", "correction", "public"];
/// Evidence classes that quote the site's text (kb.rs `steps.evidence`): a step citing any is left out.
pub const SITE_EVIDENCE: [&str; 5] = ["comment", "description", "objectives", "completion", "progress"];

pub fn spec() -> Value {
	serde_json::from_str(SPEC).expect("pack-spec.json")
}

pub struct PackOpts {
	/// The checkout the files come from (data/sources, data/local/kb, data/*.json, addon, data/sim).
	pub root: PathBuf,
	/// The forge build output whose walks/store-<faction>.psbn go in (none: no walk stores).
	pub walks_from: Option<PathBuf>,
	/// The grid the walk stores were built on (their key); default <root>/data/local/nav4.
	pub grid: Option<PathBuf>,
	/// The walk model fingerprint the stores were built with ($POLESTAR_NAV_FP of that build).
	pub nav_fp: Option<String>,
	/// Leffe's navigation pack (the folder with PACK.json and Nav/): its own release asset.
	pub leffe: Option<PathBuf>,
	pub out: PathBuf,
}

pub struct Packed {
	pub dir: PathBuf,
	pub archive: PathBuf,
	pub index: PathBuf,
	pub files: usize,
	pub bytes: u64,
	pub archive_bytes: u64,
	pub per_source: Vec<(String, usize, u64)>,
	/// The separate release assets (id, archive, bytes).
	pub assets: Vec<(String, PathBuf, u64)>,
}

fn hex_file(p: &Path) -> Result<(String, u64), String> {
	let mut f = std::fs::File::open(p).map_err(|e| format!("{}: {e}", p.display()))?;
	let mut h = blake3::Hasher::new();
	let mut buf = vec![0u8; 1 << 20];
	let mut n = 0u64;
	loop {
		let k = f.read(&mut buf).map_err(|e| format!("{}: {e}", p.display()))?;
		if k == 0 {
			break;
		}
		h.update(&buf[..k]);
		n += k as u64;
	}
	Ok((h.finalize().to_hex().to_string(), n))
}

pub fn blake3_file(p: &Path) -> Result<String, String> {
	hex_file(p).map(|x| x.0)
}

/// The newest cached client-table build of a product line ("1.15." Era, "1.60." Forever) that
/// holds `must` (a CSV every reader needs).
fn newest_build(root: &Path, prefix: &str, must: &str) -> Option<String> {
	let dir = root.join("data/sources/wago");
	let mut builds: Vec<(Vec<u64>, String)> = std::fs::read_dir(&dir)
		.ok()?
		.flatten()
		.filter_map(|e| e.file_name().into_string().ok())
		.filter(|b| b.starts_with(prefix) && b.split('.').all(|p| p.parse::<u64>().is_ok()) && dir.join(b).join(must).is_file())
		.map(|b| (b.split('.').map(|p| p.parse().unwrap()).collect(), b))
		.collect();
	builds.sort();
	builds.pop().map(|x| x.1)
}

/// The files under `root` matching `pattern` (relative, `/`-separated; a `*` matches within one
/// path segment), sorted.
fn glob(root: &Path, pattern: &str) -> Vec<String> {
	fn seg_match(p: &str, s: &str) -> bool {
		match p.split_once('*') {
			None => p == s,
			Some((a, rest)) => {
				if !s.starts_with(a) {
					return false;
				}
				let s = &s[a.len()..];
				(0..=s.len()).any(|k| s.is_char_boundary(k) && seg_match(rest, &s[k..]))
			}
		}
	}
	let segs: Vec<&str> = pattern.split('/').collect();
	let mut cur: Vec<String> = vec![String::new()];
	for (i, seg) in segs.iter().enumerate() {
		let last = i + 1 == segs.len();
		let mut next = Vec::new();
		for c in &cur {
			let dir = if c.is_empty() { root.to_path_buf() } else { root.join(c) };
			if !seg.contains('*') {
				let p = dir.join(seg);
				if (last && p.is_file()) || (!last && p.is_dir()) {
					next.push(if c.is_empty() { seg.to_string() } else { format!("{c}/{seg}") });
				}
				continue;
			}
			let Ok(rd) = std::fs::read_dir(&dir) else {
				continue;
			};
			for e in rd.flatten() {
				let Ok(name) = e.file_name().into_string() else {
					continue;
				};
				if name.starts_with('.') || !seg_match(seg, &name) {
					continue;
				}
				let p = e.path();
				if (last && p.is_file()) || (!last && p.is_dir()) {
					next.push(if c.is_empty() { name } else { format!("{c}/{name}") });
				}
			}
		}
		cur = next;
	}
	cur.sort();
	cur
}

/// params.json as the pack ships it: the calibration, with the fit's source file reduced to its
/// path inside the dungeon journal's folder (the maintainer's absolute install path stays home).
pub fn public_params(bytes: &[u8]) -> Result<Vec<u8>, String> {
	let mut v: Value = serde_json::from_slice(bytes).map_err(|e| format!("params.json: {e}"))?;
	if let Some(f) = v.pointer_mut("/fit/sources/questXp/forever/file") {
		if let Some(s) = f.as_str() {
			let tail: Vec<&str> = s.rsplit(['/', '\\']).take(3).collect();
			*f = Value::String(tail.into_iter().rev().collect::<Vec<_>>().join("/"));
		}
	}
	Ok(format!("{}\n", serde_json::to_string_pretty(&v).map_err(|e| e.to_string())?).into_bytes())
}

/// The knowledge base's public part (see the spec's `kb` source): the tables forge reads, with
/// the same schema. facts: public sources, high confidence or two sources agreeing; uncertain
/// quest facts as markers (value withheld, source `kb`). mechanics: their public sources only
/// (`mech_private`, the site's groups and ForeverDB, dropped): two or more keep the row, one keeps
/// it at medium, none leaves a driving one as a marker (status withheld). steps: high confidence
/// from a public source quoting none of the site's text. verify_in_game: the fields in conflict
/// only. sources: the public ones.
pub fn public_kb(from: &Path, to: &Path, public: &[String], mech_public: &[String], mech_private: &[String]) -> Result<(), String> {
	let e = |x: rusqlite::Error| format!("{}: {x}", to.display());
	let _ = std::fs::remove_file(to);
	if let Some(p) = to.parent() {
		std::fs::create_dir_all(p).map_err(|x| x.to_string())?;
	}
	let src = Connection::open_with_flags(from, rusqlite::OpenFlags::SQLITE_OPEN_READ_ONLY).map_err(|x| format!("{}: {x}", from.display()))?;
	let mut dst = Connection::open(to).map_err(e)?;
	dst.execute("attach database ?1 as src", [from.to_string_lossy().as_ref()]).map_err(e)?;
	let tx = dst.transaction().map_err(e)?;
	for t in ["facts", "mechanics", "steps", "verify_in_game", "sources"] {
		let sql: String = src.query_row("select sql from sqlite_master where type = 'table' and name = ?1", [t], |r| r.get(0)).map_err(|x| format!("{}: table {t}: {x}", from.display()))?;
		tx.execute(&sql, []).map_err(e)?;
	}
	let is_public = |s: &str| public.iter().any(|p| p == s);
	// facts
	{
		let mut st = src.prepare("select kind, id, field, value, source, confidence, agree, total from facts").map_err(e)?;
		let mut ins = tx.prepare("insert into facts values (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8)").map_err(e)?;
		let mut rows = st.query([]).map_err(e)?;
		while let Some(r) = rows.next().map_err(e)? {
			let (kind, id, field): (String, i64, String) = (r.get(0).map_err(e)?, r.get(1).map_err(e)?, r.get(2).map_err(e)?);
			let value: Option<String> = r.get(3).map_err(e)?;
			let source: String = r.get::<_, Option<String>>(4).map_err(e)?.unwrap_or_default();
			let conf: String = r.get::<_, Option<String>>(5).map_err(e)?.unwrap_or_default();
			let (agree, total): (Option<i64>, Option<i64>) = (r.get(6).map_err(e)?, r.get(7).map_err(e)?);
			let sure = conf == "high" || agree.unwrap_or(0) >= 2;
			if sure && is_public(&source) {
				ins.execute(rusqlite::params![kind, id, field, value, source, conf, agree, total]).map_err(e)?;
			} else if kind == "quest" && (conf == "low" || conf == "medium") {
				ins.execute(rusqlite::params![kind, id, field, "", "kb", conf, agree, total]).map_err(e)?;
			}
		}
	}
	// mechanics
	{
		let mut st = src.prepare("select quest, kind, status, source, confidence, drives, sources from mechanics").map_err(e)?;
		let mut ins = tx.prepare("insert into mechanics values (?1, ?2, ?3, ?4, ?5, ?6, ?7)").map_err(e)?;
		let mut rows = st.query([]).map_err(e)?;
		while let Some(r) = rows.next().map_err(e)? {
			let quest: i64 = r.get(0).map_err(e)?;
			let kind: Option<String> = r.get(1).map_err(e)?;
			let status: Option<String> = r.get(2).map_err(e)?;
			let conf: String = r.get::<_, Option<String>>(4).map_err(e)?.unwrap_or_default();
			let drives: Option<i64> = r.get(5).map_err(e)?;
			let srcs: Vec<String> = r.get::<_, Option<String>>(6).map_err(e)?.and_then(|s| serde_json::from_str(&s).ok()).unwrap_or_default();
			// The KB's rule (kb.rs): high needs two agreeing groups. Without the site's groups:
			// two or more public ones keep the row; one keeps its status at medium; none leaves
			// only a marker of a driving mechanic (status withheld, low).
			let private = srcs.iter().any(|s| mech_private.contains(s));
			let kept: Vec<&String> = srcs.iter().filter(|s| mech_public.contains(s)).collect();
			let srcs_json = serde_json::to_string(&kept).unwrap();
			match kept.len() {
				0 if drives == Some(1) => {
					ins.execute(rusqlite::params![quest, kind, Option::<String>::None, Option::<String>::None, "low", drives, "[]"]).map_err(e)?;
				}
				0 => {}
				1 if private => {
					ins.execute(rusqlite::params![quest, kind, status, kept[0], "medium", drives, srcs_json]).map_err(e)?;
				}
				_ => {
					ins.execute(rusqlite::params![quest, kind, status, kept[0], conf, drives, srcs_json]).map_err(e)?;
				}
			}
		}
	}
	// steps: only where the KB records each step's source and evidence (kb.rs): high confidence,
	// a public source, and no quote of the site's text (comments, description, objectives,
	// completion, progress); the evidence column left empty. Without those columns, none (every
	// quest's steps were then a model reading of the page snapshot).
	let step_cols: Vec<String> = {
		let mut st = tx.prepare("select name from pragma_table_info('steps', 'src')").map_err(e)?;
		let v = st.query_map([], |r| r.get(0)).map_err(e)?.collect::<Result<_, _>>().map_err(e)?;
		v
	};
	if step_cols.iter().any(|c| c == "source") && step_cols.iter().any(|c| c == "evidence") {
		tx.execute("drop table steps", []).map_err(e)?;
		let sql: String = src.query_row("select sql from sqlite_master where type = 'table' and name = 'steps'", [], |r| r.get(0)).map_err(e)?;
		tx.execute(&sql, []).map_err(e)?;
		let cols = step_cols.iter().map(|c| format!("\"{c}\"")).collect::<Vec<_>>().join(", ");
		let picked = step_cols.iter().map(|c| if c == "evidence" { "null".to_string() } else { format!("\"{c}\"") }).collect::<Vec<_>>().join(", ");
		let srcs = STEP_SOURCES.iter().map(|x| format!("'{x}'")).collect::<Vec<_>>().join(", ");
		let ev = SITE_EVIDENCE.iter().map(|x| format!("'{x}'")).collect::<Vec<_>>().join(", ");
		tx.execute(
            &format!("insert into steps ({cols}) select {picked} from src.steps where confidence = 'high' and source in ({srcs}) and not exists (select 1 from json_each(coalesce(src.steps.evidence, '[]')) where value in ({ev}))"),
            [],
        )
        .map_err(e)?;
	}
	// verify_in_game
	{
		let mut st = tx.prepare("select rank, kind, id, name, yards, conflicts from src.verify_in_game").map_err(e)?;
		let rows: Vec<VerifyRow> = st.query_map([], |r| Ok((r.get(0)?, r.get(1)?, r.get(2)?, r.get(3)?, r.get(4)?, r.get(5)?))).map_err(e)?.collect::<Result<_, _>>().map_err(e)?;
		drop(st);
		let mut ins = tx.prepare("insert into verify_in_game values (?1, ?2, ?3, ?4, ?5, ?6)").map_err(e)?;
		for (rank, kind, id, name, yards, conflicts) in rows {
			let fields: Vec<Value> = conflicts
				.as_deref()
				.and_then(|c| serde_json::from_str::<Value>(c).ok())
				.and_then(|v| v.as_array().cloned())
				.unwrap_or_default()
				.iter()
				.filter_map(|x| x["field"].as_str().map(|f| json!({ "field": f })))
				.collect();
			ins.execute(rusqlite::params![rank, kind, id, name, yards, serde_json::to_string(&fields).unwrap()]).map_err(e)?;
		}
	}
	// sources
	{
		let mut st = tx.prepare("select name, tier, label, version from src.sources").map_err(e)?;
		let rows: Vec<SourceRow> = st.query_map([], |r| Ok((r.get(0)?, r.get(1)?, r.get(2)?, r.get(3)?))).map_err(e)?.collect::<Result<_, _>>().map_err(e)?;
		drop(st);
		let mut ins = tx.prepare("insert into sources values (?1, ?2, ?3, ?4)").map_err(e)?;
		for (name, tier, label, version) in rows {
			if is_public(&name) {
				ins.execute(rusqlite::params![name, tier, label, version]).map_err(e)?;
			}
		}
		ins.execute(rusqlite::params!["kb", 9.0, "Polestar knowledge base: uncertain or disputed, value withheld from the public pack", Option::<String>::None]).map_err(e)?;
	}
	tx.commit().map_err(e)?;
	dst.execute("detach database src", []).map_err(|x| format!("{}: {x}", to.display()))?;
	dst.execute_batch("vacuum").map_err(|x| format!("{}: {x}", to.display()))?;
	Ok(())
}

/// The guard: every file of a pack directory, by path and (text files and SQLite text cells) by
/// content, against the spec's `never` and `neverText`. Returns what it found (empty: clean).
pub fn scan_private(dir: &Path) -> Result<Vec<String>, String> {
	let sp = spec();
	let never: Vec<String> = sp["never"].as_array().into_iter().flatten().filter_map(Value::as_str).map(str::to_lowercase).collect();
	let words: Vec<String> = sp["neverText"].as_array().into_iter().flatten().filter_map(Value::as_str).map(str::to_lowercase).collect();
	let exempt = |rel: &str| sp["textScanExempt"].get(rel).is_some();
	let mut found = Vec::new();
	let mut stack = vec![dir.to_path_buf()];
	while let Some(d) = stack.pop() {
		for en in std::fs::read_dir(&d).map_err(|x| format!("{}: {x}", d.display()))?.flatten() {
			let p = en.path();
			let rel = p.strip_prefix(dir).unwrap_or(&p).to_string_lossy().replace('\\', "/");
			let low = rel.to_lowercase();
			if let Some(n) = never.iter().find(|n| low.contains(n.as_str())) {
				found.push(format!("{rel}: path matches never-packed `{n}`"));
			}
			if p.is_dir() {
				stack.push(p);
				continue;
			}
			if rel.ends_with(".psbn") || exempt(&rel) {
				continue;
			}
			if rel.ends_with(".sqlite") {
				found.extend(scan_sqlite(&p, &words, &rel)?);
				continue;
			}
			let bytes = std::fs::read(&p).map_err(|x| format!("{}: {x}", p.display()))?;
			let text = String::from_utf8_lossy(&bytes).to_lowercase();
			for w in &words {
				if let Some(at) = text.find(w.as_str()) {
					found.push(format!("{rel}: holds `{w}` at byte {at}"));
				}
			}
		}
	}
	found.sort();
	Ok(found)
}

fn scan_sqlite(p: &Path, words: &[String], rel: &str) -> Result<Vec<String>, String> {
	let e = |x: rusqlite::Error| format!("{}: {x}", p.display());
	let c = Connection::open_with_flags(p, rusqlite::OpenFlags::SQLITE_OPEN_READ_ONLY).map_err(e)?;
	let tables: Vec<String> = c.prepare("select name from sqlite_master where type = 'table'").map_err(e)?.query_map([], |r| r.get(0)).map_err(e)?.collect::<Result<_, _>>().map_err(e)?;
	let mut found = Vec::new();
	let mech_private: Vec<String> =
		spec()["sources"].as_array().into_iter().flatten().filter_map(|s| s["kb"]["mechanicsPrivate"].as_array()).flatten().filter_map(Value::as_str).map(String::from).collect();
	if tables.iter().any(|t| t == "steps") {
		let cols: Vec<String> = c.prepare("select name from pragma_table_info('steps')").map_err(e)?.query_map([], |r| r.get(0)).map_err(e)?.collect::<Result<_, _>>().map_err(e)?;
		if cols.iter().any(|x| x == "source") {
			let srcs = STEP_SOURCES.iter().map(|x| format!("'{x}'")).collect::<Vec<_>>().join(", ");
			let n: i64 = c.query_row(&format!("select count(*) from steps where source is null or source not in ({srcs})"), [], |r| r.get(0)).map_err(e)?;
			if n > 0 {
				found.push(format!("{rel}: steps holds {n} rows from a private or unknown source"));
			}
			if cols.iter().any(|x| x == "evidence") {
				let n: i64 = c.query_row("select count(*) from steps where evidence is not null and evidence != '[]'", [], |r| r.get(0)).map_err(e)?;
				if n > 0 {
					found.push(format!("{rel}: steps.evidence holds quote origins in {n} rows"));
				}
			}
		} else {
			let n: i64 = c.query_row("select count(*) from steps", [], |r| r.get(0)).map_err(e)?;
			if n > 0 {
				found.push(format!("{rel}: steps holds {n} rows with no source column (quest steps were model readings of the page snapshot)"));
			}
		}
	}
	if tables.iter().any(|t| t == "mechanics") {
		for m in &mech_private {
			let n: i64 = c.query_row("select count(*) from mechanics where sources like ?1", [format!("%\"{m}\"%")], |r| r.get(0)).map_err(e)?;
			if n > 0 {
				found.push(format!("{rel}: mechanics.sources names the private source `{m}` in {n} rows"));
			}
		}
	}
	for t in tables {
		let cols: Vec<String> = c.prepare(&format!("select name from pragma_table_info('{t}')")).map_err(e)?.query_map([], |r| r.get(0)).map_err(e)?.collect::<Result<_, _>>().map_err(e)?;
		for col in cols {
			for w in words {
				let n: i64 = c.query_row(&format!("select count(*) from \"{t}\" where lower(cast(\"{col}\" as text)) like ?1"), [format!("%{w}%")], |r| r.get(0)).map_err(e)?;
				if n > 0 {
					found.push(format!("{rel}: {t}.{col} holds `{w}` in {n} rows"));
				}
			}
			if col == "source" || col == "name" && t == "sources" {
				let n: i64 = c
                    .query_row(&format!("select count(*) from \"{t}\" where \"{col}\" = 'page' or \"{col}\" = 'web' or \"{col}\" like 'foreverdb%' or \"{col}\" like 'forevervo%' or \"{col}\" like 'tdb%' or \"{col}\" like 'questie%'"), [], |r| r.get(0))
                    .map_err(e)?;
				if n > 0 {
					found.push(format!("{rel}: {t}.{col} names a private source in {n} rows"));
				}
			}
		}
	}
	Ok(found)
}

/// The content hash of a grid as the walks read it: index.json, the tiles' .nav.gz, graph/ and
/// the walk layers' road masks (relative path and bytes, sorted). The walk stores' key.
pub fn grid_hash(grid: &Path) -> Result<String, String> {
	if !grid.join("index.json").is_file() {
		return Err(format!("{}: no index.json (not a grid)", grid.display()));
	}
	let mut files: Vec<String> = vec!["index.json".into()];
	files.extend(glob(grid, "tiles/*/*.nav.gz"));
	files.extend(glob(grid, "graph/*"));
	files.extend(glob(grid, "walk/roads-*.bin"));
	files.sort();
	let mut h = blake3::Hasher::new();
	for f in &files {
		h.update(f.as_bytes());
		h.update(b"\0");
		let (x, n) = hex_file(&grid.join(f))?;
		h.update(&n.to_le_bytes());
		h.update(x.as_bytes());
	}
	Ok(h.finalize().to_hex().to_string())
}

/// The content hash of Leffe's navigation maps as the walks read them: Nav.xml and the per-map
/// headers `Nav<map>.lua` (relative path and bytes, sorted). The Leffe walk stores' key.
pub fn leffe_hash(dir: &Path) -> Result<String, String> {
	let nav = if dir.join("Nav.xml").is_file() { dir.to_path_buf() } else { dir.join("Nav") };
	if !nav.join("Nav.xml").is_file() {
		return Err(format!("{}: no Nav.xml (not Leffe's navigation maps)", dir.display()));
	}
	let mut files: Vec<String> = glob(&nav, "Nav*")
		.into_iter()
		.filter(|f| f == "Nav.xml" || (f.strip_prefix("Nav").and_then(|x| x.strip_suffix(".lua")).is_some_and(|m| !m.is_empty() && m.bytes().all(|b| b.is_ascii_digit()))))
		.collect();
	files.sort();
	let mut h = blake3::Hasher::new();
	for f in &files {
		h.update(f.as_bytes());
		h.update(b"\0");
		let (x, n) = hex_file(&nav.join(f))?;
		h.update(&n.to_le_bytes());
		h.update(x.as_bytes());
	}
	Ok(h.finalize().to_hex().to_string())
}

/// `forge data pack`.
pub fn pack(o: &PackOpts, log: &mut dyn FnMut(&str)) -> Result<Packed, String> {
	let sp = spec();
	let dir = o.out.join("pack");
	let _ = std::fs::remove_dir_all(&dir);
	std::fs::create_dir_all(&dir).map_err(|x| format!("{}: {x}", dir.display()))?;
	let era = newest_build(&o.root, "1.15.", "UiMap.csv").ok_or("no Classic Era client tables in data/sources/wago")?;
	let forever = newest_build(&o.root, "1.60.", "AreaTable.csv").ok_or("no Forever client tables in data/sources/wago")?;
	let mut files_doc = Vec::new();
	let mut sources_doc = Vec::new();
	let mut per_source = Vec::new();
	let mut walks_doc = Value::Null;
	for s in sp["sources"].as_array().unwrap() {
		let id = s["id"].as_str().unwrap();
		let mut n = 0usize;
		let mut bytes = 0u64;
		let mut rels: Vec<String> = Vec::new();
		if s["walks"].as_bool() == Some(true) {
			let Some(from) = &o.walks_from else {
				log("  walks: no --walks-from, no walk stores in the pack");
				continue;
			};
			let grid = o.grid.clone().unwrap_or_else(|| o.root.join("data/local/nav4"));
			let gh = grid_hash(&grid)?;
			for p in s["files"].as_array().unwrap().iter().filter_map(Value::as_str) {
				let src = from.join(p.trim_start_matches("walks/"));
				if src.is_file() {
					let dest = dir.join(p);
					std::fs::create_dir_all(dest.parent().unwrap()).map_err(|x| x.to_string())?;
					std::fs::copy(&src, &dest).map_err(|x| format!("{}: {x}", src.display()))?;
					rels.push(p.to_string());
				}
			}
			let leffe_h = o.leffe.as_deref().map(leffe_hash).transpose()?;
			walks_doc = json!({ "grid": gh, "navFp": o.nav_fp, "leffe": leffe_h, "gridBuild": serde_json::from_slice::<Value>(&std::fs::read(grid.join("index.json")).unwrap_or_default()).ok().map(|v| json!({ "build": v["build"], "builtAt": v["builtAt"] })) });
		} else if s["from"].as_str() == Some("leffe") {
			let Some(from) = &o.leffe else {
				log(&format!("  {id}: no --leffe, not in the pack"));
				continue;
			};
			for pat in s["files"].as_array().unwrap().iter().filter_map(Value::as_str) {
				for rel in glob(from, pat) {
					let dest = dir.join(id).join(&rel);
					std::fs::create_dir_all(dest.parent().unwrap()).map_err(|x| x.to_string())?;
					if std::fs::hard_link(from.join(&rel), &dest).is_err() {
						std::fs::copy(from.join(&rel), &dest).map_err(|x| format!("{rel}: {x}"))?;
					}
					rels.push(format!("{id}/{rel}"));
				}
			}
			if rels.is_empty() {
				return Err(format!("{id}: no {} in {}", s["files"], from.display()));
			}
		} else if let Some(kb) = s.get("kb") {
			let from = o.root.join(kb["from"].as_str().unwrap());
			let strs = |k: &str| kb[k].as_array().into_iter().flatten().filter_map(Value::as_str).map(String::from).collect::<Vec<_>>();
			let rel = s["files"][0].as_str().unwrap();
			public_kb(&from, &dir.join(rel), &strs("public"), &strs("mechanicsPublic"), &strs("mechanicsPrivate"))?;
			rels.push(rel.to_string());
		} else {
			for pat in s["files"].as_array().unwrap().iter().filter_map(Value::as_str) {
				let (pat, optional) = match pat.strip_suffix('?') {
					Some(p) => (p, true),
					None => (pat, false),
				};
				let pat = pat.replace("{wago-era}", &era).replace("{wago-forever}", &forever);
				let got = glob(&o.root, &pat);
				if got.is_empty() && optional {
					continue;
				}
				if got.is_empty() {
					return Err(format!("{id}: nothing at {pat} in {}", o.root.display()));
				}
				for rel in got {
					let dest = dir.join(&rel);
					std::fs::create_dir_all(dest.parent().unwrap()).map_err(|x| x.to_string())?;
					if rel == "data/sim/params.json" {
						std::fs::write(&dest, public_params(&std::fs::read(o.root.join(&rel)).map_err(|x| format!("{rel}: {x}"))?)?).map_err(|x| format!("{rel}: {x}"))?;
					} else {
						std::fs::copy(o.root.join(&rel), &dest).map_err(|x| format!("{rel}: {x}"))?;
					}
					rels.push(rel);
				}
			}
		}
		for rel in &rels {
			let (h, len) = hex_file(&dir.join(rel))?;
			n += 1;
			bytes += len;
			files_doc.push(json!({ "path": rel, "size": len, "blake3": h, "source": id }));
		}
		per_source.push((id.to_string(), n, bytes));
		log(&format!("  {id}: {n} files, {:.1} MB", bytes as f64 / 1e6));
		sources_doc.push(json!({ "id": id, "title": s["title"], "credit": s["credit"], "licence": s["licence"], "url": s["url"], "files": n, "bytes": bytes, "asset": s["asset"] }));
	}
	let found = scan_private(&dir)?;
	if !found.is_empty() {
		return Err(format!("the pack holds private data; nothing written:\n  {}", found.join("\n  ")));
	}
	let total: u64 = per_source.iter().map(|x| x.2).sum();
	let manifest = json!({
		"pack": sp["version"],
		"builtWith": format!("forge {}", env!("CARGO_PKG_VERSION")),
		"clientTables": { "era": era, "forever": forever },
		"sources": sources_doc,
		"external": sp["external"],
		"requires": sp["requires"],
		"walks": walks_doc,
		"files": files_doc,
		"bytes": total,
	});
	let mtext = serde_json::to_string_pretty(&manifest).unwrap();
	std::fs::write(dir.join(MANIFEST), &mtext).map_err(|x| x.to_string())?;
	// The archives: the pack's (manifest.json first, then its files in manifest order) and one
	// per asset source (its files).
	let asset_of: std::collections::HashMap<&str, &str> = sp["sources"].as_array().unwrap().iter().filter_map(|s| Some((s["id"].as_str()?, s["asset"].as_str()?))).collect();
	let mut groups: Vec<(String, Vec<String>)> = vec![(ARCHIVE.to_string(), vec![MANIFEST.to_string()])];
	for fd in &files_doc {
		let rel = fd["path"].as_str().unwrap().to_string();
		let name = asset_of.get(fd["source"].as_str().unwrap()).map_or(ARCHIVE, |a| *a);
		match groups.iter_mut().find(|g| g.0 == name) {
			Some(g) => g.1.push(rel),
			None => groups.push((name.to_string(), vec![rel])),
		}
	}
	let mut written: Vec<(String, PathBuf, u64, String)> = Vec::new();
	for (name, rels) in &groups {
		let path = o.out.join(name);
		write_archive(&dir, rels, &path)?;
		let (h, len) = hex_file(&path)?;
		std::fs::write(o.out.join(format!("{name}.blake3")), format!("{h}  {name}\n")).map_err(|x| x.to_string())?;
		written.push((name.clone(), path, len, h));
	}
	let (archive, alen, ah) = (written[0].1.clone(), written[0].2, written[0].3.clone());
	let assets: Vec<Value> = written[1..].iter().map(|(name, _, len, h)| json!({ "archive": name, "size": len, "blake3": h })).collect();
	let index = o.out.join(INDEX);
	let idx = json!({ "pack": sp["version"], "archive": ARCHIVE, "size": alen, "blake3": ah, "assets": assets, "manifest": manifest });
	std::fs::write(&index, serde_json::to_string_pretty(&idx).unwrap()).map_err(|x| x.to_string())?;
	Ok(Packed { dir, archive, index, files: files_doc.len(), bytes: total, archive_bytes: alen, per_source, assets: written[1..].iter().map(|(n, p, l, _)| (n.clone(), p.clone(), *l)).collect() })
}

/// A deterministic tar.gz of `rels` (relative to `dir`).
fn write_archive(dir: &Path, rels: &[String], path: &Path) -> Result<(), String> {
	let f = std::fs::File::create(path).map_err(|x| format!("{}: {x}", path.display()))?;
	let gz = flate2::write::GzEncoder::new(std::io::BufWriter::new(f), flate2::Compression::new(6));
	let mut tar = tar::Builder::new(gz);
	tar.mode(tar::HeaderMode::Deterministic);
	for rel in rels {
		tar.append_path_with_name(dir.join(rel), rel).map_err(|x| format!("{rel}: {x}"))?;
	}
	let gz = tar.into_inner().map_err(|x| x.to_string())?;
	let mut w = gz.finish().map_err(|x| x.to_string())?;
	w.flush().map_err(|x| x.to_string())
}

#[cfg(test)]
mod tests {
	use super::glob;

	#[test]
	fn glob_matches_one_segment() {
		let d = std::env::temp_dir().join(format!("forge-glob-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&d);
		for p in ["a/x1/b.csv", "a/x2/b.csv", "a/x2/c.txt", "a/y/b.csv"] {
			std::fs::create_dir_all(d.join(p).parent().unwrap()).unwrap();
			std::fs::write(d.join(p), "1").unwrap();
		}
		assert_eq!(glob(&d, "a/x*/*.csv"), vec!["a/x1/b.csv", "a/x2/b.csv"]);
		assert_eq!(glob(&d, "a/y/b.csv"), vec!["a/y/b.csv"]);
		assert!(glob(&d, "a/z/*.csv").is_empty());
		let _ = std::fs::remove_dir_all(&d);
	}
}
