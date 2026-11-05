//! `forge gamedata list` and `forge gamedata export --table T --out FILE`: the installed
//! client's tables read locally (CASC + DB2 + WoWDBDefs). `cache` decodes the client's WDB
//! caches (quests, creatures, gameobjects the server described to it) to JSON; `hotfix` reads its
//! DBCache.bin (the server's hotfix rows): a per-table summary, or one table's rows decoded.
//! `compare --wago DIR` (a developer check, not in the help) exports every table a wago.tools
//! build folder holds and compares the CSVs.
//!
//! Common options: `--wow DIR` (World of Warcraft folder; default `$POLESTAR_WOW_DIR` or the
//! detected install), `--product P` (default wow_classic_beta, the product wago.tools lists
//! Forever under; `wowf` is the `_forever_` client), `--build auto|X.Y.Z.B` (the installed one;
//! anything else must equal it), `--locale enUS`, `--defs DIR` (WoWDBDefs checkout; default
//! `<checkout>/data/sources/wowdbdefs`).

use std::io::Write;
use std::path::{Path, PathBuf};
use std::time::Instant;

use super::{usage, Fail};
use forge_gamedata::db2::{Table, Value};
use forge_gamedata::dbd::Kind as ColKind;
use forge_gamedata::hotfix::{self, DbCache};
use forge_gamedata::wdb::{self, Kind, WdbFile};
use forge_gamedata::{csv, find_install, flavor_dir, Client};

pub(super) const USAGE: &str = "usage: forge gamedata list [options]                 the tables the client holds
       forge gamedata export --table <name> [--out <file>] [options]   a table as CSV (no --out: stdout)
       forge gamedata check [--maps 0,1,...] [options]   is the install complete? (exit 1 when not)
       forge gamedata cache [--kind quest|creature|gameobject|all] [--cache <dir>] [--out <file.json>] [options]
                 the client's WDB caches as JSON keyed by id (all: keyed by kind, then id), with counts
                 per file (--cache default: <wow>/<the product's client folder>/Cache/WDB/<locale>)
       forge gamedata hotfix [--table <name> [--status valid|all] [--out <file.csv|file.json>] [--db2]] [--cache <file>] [options]
                 the client's hotfixes (DBCache.bin): entries per table and status; with --table that
                 table's rows decoded (RecordID, Status, PushID, then the table's columns; --db2
                 compares them with the installed tables' rows of the same IDs)
                 (--cache default: <the product's client folder>/Cache/ADB/<locale>/DBCache.bin)

options: --wow <dir>  --product <name> (default wow_classic_beta)  --build auto|X.Y.Z.B  --locale enUS  --defs <dir>";

pub fn main() {
	super::exit("gamedata", run());
}

struct Opts {
	cmd: String,
	wow: Option<PathBuf>,
	product: String,
	build: String,
	locale: String,
	defs: Option<PathBuf>,
	table: Option<String>,
	out: Option<PathBuf>,
	wago: Option<PathBuf>,
	tables: Option<Vec<String>>,
	maps: Option<Vec<u32>>,
	kind: String,
	cache: Option<PathBuf>,
	all_statuses: bool,
	db2: bool,
}

fn parse() -> Result<Opts, Fail> {
	let mut args = super::args().skip(1);
	let mut o = Opts {
		cmd: String::new(),
		wow: None,
		product: "wow_classic_beta".into(),
		build: "auto".into(),
		locale: "enUS".into(),
		defs: None,
		table: None,
		out: None,
		wago: None,
		tables: None,
		maps: None,
		kind: "all".into(),
		cache: None,
		all_statuses: false,
		db2: false,
	};
	while let Some(a) = args.next() {
		let mut val = || args.next().ok_or_else(|| usage(format!("{a} needs a value")));
		match a.as_str() {
			"--wow" => o.wow = Some(val()?.into()),
			"--product" => o.product = val()?,
			"--build" => o.build = val()?,
			"--locale" => o.locale = val()?,
			"--defs" => o.defs = Some(val()?.into()),
			"--table" => o.table = Some(val()?),
			"--out" => o.out = Some(val()?.into()),
			"--wago" => o.wago = Some(val()?.into()),
			"--maps" => o.maps = Some(val()?.split(',').map(|m| m.trim().parse().map_err(|_| usage(format!("--maps: {m}: not a map id")))).collect::<Result<_, _>>()?),
			"--tables" => o.tables = Some(val()?.split(',').map(str::to_string).collect()),
			"--kind" => {
				o.kind = val()?;
				if !["quest", "creature", "gameobject", "all"].contains(&o.kind.as_str()) {
					return Err(usage(format!("--kind {}: quest, creature, gameobject or all", o.kind)));
				}
			}
			"--cache" => o.cache = Some(val()?.into()),
			"--status" => {
				o.all_statuses = match val()?.as_str() {
					"valid" => false,
					"all" => true,
					s => return Err(usage(format!("--status {s}: valid or all"))),
				}
			}
			"--db2" => o.db2 = true,
			"-h" | "--help" => {
				println!("{USAGE}");
				std::process::exit(0)
			}
			s if s.starts_with('-') => return Err(usage(format!("unknown option {s}"))),
			s if o.cmd.is_empty() => o.cmd = s.to_string(),
			s => return Err(usage(format!("unexpected argument {s}"))),
		}
	}
	Ok(o)
}

/// `data/sources/wowdbdefs` in the checkout above the current folder.
fn default_defs() -> Option<PathBuf> {
	let cwd = std::env::current_dir().ok()?;
	cwd.ancestors().map(|d| d.join("data/sources/wowdbdefs")).find(|d| d.join("definitions").is_dir())
}

fn wow_dir(o: &Opts) -> Result<PathBuf, String> {
	o.wow.clone().or_else(find_install).ok_or_else(|| "no World of Warcraft folder found; pass --wow or set POLESTAR_WOW_DIR".to_string())
}

fn defs_dir(o: &Opts) -> Result<PathBuf, String> {
	o.defs.clone().or_else(default_defs).ok_or_else(|| "no WoWDBDefs checkout; git clone https://github.com/wowdev/WoWDBDefs data/sources/wowdbdefs, or pass --defs".to_string())
}

fn open(o: &Opts) -> Result<Client, String> {
	let wow = wow_dir(o)?;
	let defs = defs_dir(o)?;
	let t = Instant::now();
	let c = Client::open(&wow, &o.product, &defs)?;
	if o.build != "auto" && o.build != c.storage.version {
		return Err(format!("--build {}: the installed {} is {} (local storage holds only the installed build)", o.build, o.product, c.storage.version));
	}
	eprintln!("{} {} ({}), opened in {:.0} ms", o.product, c.storage.version, wow.display(), t.elapsed().as_secs_f64() * 1e3);
	Ok(c)
}

fn run() -> Result<(), Fail> {
	let o = parse()?;
	match o.cmd.as_str() {
		"list" => {
			let c = open(&o)?;
			let mut out = std::io::stdout().lock();
			for (name, fdid) in c.tables() {
				writeln!(out, "{name}\t{fdid}").map_err(|e| e.to_string())?;
			}
			Ok(())
		}
		"check" => {
			let c = open(&o)?;
			let t = Instant::now();
			let r = forge_gamedata::completeness::check(&c, o.maps.as_deref())?;
			println!("{} maps, {} files checked in {:.1} s", r.maps_checked, r.files_checked, t.elapsed().as_secs_f64());
			for l in r.lines() {
				println!("  {l}");
			}
			for m in &r.maps {
				let ids: Vec<String> = m.missing.iter().take(12).map(|(f, _)| f.to_string()).collect();
				println!("    {} {}{}", m.name, ids.join(" "), if m.missing.len() > 12 { " ..." } else { "" });
			}
			if r.complete() {
				println!("complete: every file these maps use is in the local archives");
				Ok(())
			} else {
				println!("incomplete install: {}", forge_gamedata::completeness::FIX);
				std::process::exit(1)
			}
		}
		"export" => {
			let table = o.table.clone().ok_or_else(|| usage("export needs --table <name>"))?;
			let c = open(&o)?;
			let t = Instant::now();
			let tb = c.table(&table, &o.locale)?;
			let bytes = csv::write_table(&tb);
			for n in &tb.notes {
				eprintln!("{table}: {n}");
			}
			match &o.out {
				Some(p) => std::fs::write(p, &bytes).map_err(|e| format!("{}: {e}", p.display()))?,
				None => std::io::stdout().write_all(&bytes).map_err(|e| e.to_string())?,
			}
			eprintln!("{table}: {} rows in {:.1} ms", tb.rows(), t.elapsed().as_secs_f64() * 1e3);
			Ok(())
		}
		"compare" => Ok(compare(&o)?),
		"cache" => Ok(cache(&o)?),
		"hotfix" => Ok(hotfix_cmd(&o)?),
		x => Err(usage(format!("unknown command {x}"))),
	}
}

/// The product's client folder's `Cache/<sub>/<locale>` (`--cache` overrides it).
fn cache_dir(o: &Opts, sub: &str) -> Result<PathBuf, String> {
	Ok(flavor_dir(&wow_dir(o)?, &o.product)?.join("Cache").join(sub).join(&o.locale))
}

fn write_out(out: Option<&Path>, bytes: &[u8]) -> Result<(), String> {
	match out {
		Some(p) => std::fs::write(p, bytes).map_err(|e| format!("{}: {e}", p.display())),
		None => std::io::stdout().write_all(bytes).map_err(|e| e.to_string()),
	}
}

/// One WDB file decoded: `"id": {...}` lines in file order, and the per-file counts printed.
fn cache_file(dir: &Path, kind: Kind, json: &mut Vec<u8>) -> Result<(), String> {
	let path = dir.join(kind.file_name());
	let f = WdbFile::read(&path)?;
	let head = format!("{}: build {} {} record version {}", kind.file_name(), f.build, f.locale, f.record_version);
	let decoded: Vec<(u32, Result<serde_json::Value, String>)> = match kind {
		Kind::Quest => f.decode(kind, wdb::decode_quest)?.into_iter().map(|(id, r)| (id, r.map(|q| q.to_json()))).collect(),
		Kind::Creature => f.decode(kind, wdb::decode_creature)?.into_iter().map(|(id, r)| (id, r.map(|c| c.to_json()))).collect(),
		Kind::GameObject => f.decode(kind, wdb::decode_gameobject)?.into_iter().map(|(id, r)| (id, r.map(|g| g.to_json()))).collect(),
		_ => {
			match f.records.len() {
				0 => eprintln!("{head}: empty"),
				n => eprintln!("{head}: {n} records, format not decoded"),
			}
			return Ok(());
		}
	};
	json.extend_from_slice(b"{");
	let mut failed = 0;
	let mut first = true;
	for (id, r) in &decoded {
		match r {
			Ok(v) => {
				json.extend_from_slice(if first { b"\n" } else { b",\n" });
				first = false;
				write!(json, "\"{id}\": {v}").map_err(|e| e.to_string())?;
			}
			Err(e) => {
				failed += 1;
				if failed <= 5 {
					eprintln!("{}: record {id}: {e}", kind.file_name());
				}
			}
		}
	}
	json.extend_from_slice(b"\n}");
	println!("{head}: {} records, {} decoded, {failed} failed", decoded.len(), decoded.len() - failed);
	Ok(())
}

/// `forge gamedata cache`: the WDB caches as JSON.
fn cache(o: &Opts) -> Result<(), String> {
	let dir = match &o.cache {
		Some(d) => d.clone(),
		None => cache_dir(o, "WDB")?,
	};
	let decoded = [(Kind::Quest, "quest"), (Kind::Creature, "creature"), (Kind::GameObject, "gameobject")];
	let mut json = Vec::new();
	if o.kind == "all" {
		json.extend_from_slice(b"{");
		for (i, (kind, name)) in decoded.iter().enumerate() {
			write!(json, "{}\"{name}\": ", if i > 0 { ",\n" } else { "\n" }).map_err(|e| e.to_string())?;
			cache_file(&dir, *kind, &mut json)?;
		}
		json.extend_from_slice(b"\n}\n");
		for kind in [Kind::Npc, Kind::PageText, Kind::Petition] {
			if dir.join(kind.file_name()).is_file() {
				cache_file(&dir, kind, &mut json)?;
			}
		}
	} else {
		let kind = decoded.iter().find(|(_, n)| *n == o.kind).ok_or_else(|| format!("--kind {}: quest, creature, gameobject or all", o.kind))?.0;
		cache_file(&dir, kind, &mut json)?;
		json.push(b'\n');
	}
	write_out(o.out.as_deref(), &json)
}

/// `forge gamedata hotfix`: DBCache.bin summarised, or one table's rows decoded.
fn hotfix_cmd(o: &Opts) -> Result<(), String> {
	let file = match &o.cache {
		Some(f) => f.clone(),
		None => cache_dir(o, "ADB")?.join("DBCache.bin"),
	};
	let cache = DbCache::read(&file)?;
	eprintln!("{}: version {}, build {}, {} entries", file.display(), cache.version, cache.build, cache.entries.len());
	let Some(table) = &o.table else {
		let names = forge_gamedata::dbd::table_hashes(&defs_dir(o)?.join("manifest.json"))?;
		return summary(&cache, &names);
	};
	let c = open(o)?;
	// DBCache.bin records only the build number: the rows are typed by that build of the installed
	// version (an update keeps the cache until the client next writes it).
	let [major, minor, patch, installed] = c.build.0;
	let build = forge_gamedata::Build([major, minor, patch, cache.build]);
	if installed != cache.build {
		eprintln!("note: {} is from build {build}, the installed {} is {}; rows typed by {build}'s definitions", file.display(), o.product, c.build);
	}
	let names = c.table_hashes()?;
	let hash = names.iter().find(|(_, n)| n.eq_ignore_ascii_case(table)).map(|(h, _)| *h).ok_or_else(|| format!("{table}: no tableHash in WoWDBDefs manifest.json"))?;
	let def = c.definition(&names[&hash], build)?;
	let rows = hotfix::rows(&cache, hash, &def, !o.all_statuses);
	let t = &rows.table;
	for (id, why) in rows.failures.iter().take(5) {
		eprintln!("{table}: record {id}: {why}");
	}
	eprintln!("{table}: {} rows, {} failed to decode", t.rows(), rows.failures.len());
	if o.db2 {
		let db2 = c.table(&names[&hash], &o.locale)?;
		let cmp = hotfix::compare(&rows, &db2);
		let pct = |e: usize, n: usize| if n == 0 { 100.0 } else { e as f64 * 100.0 / n as f64 };
		println!("{table}: {} rows compared with the DB2 ({} not in it), {} of {} values equal ({:.2}%)", cmp.rows, cmp.new_rows, cmp.equal, cmp.values, pct(cmp.equal, cmp.values));
		for (name, n, eq) in cmp.per_column.iter().filter(|(_, n, eq)| eq < n) {
			println!("  {name}: {eq} of {n} equal ({:.2}%)", pct(*eq, *n));
		}
	}
	let json = o.out.as_ref().is_some_and(|p| p.extension().is_some_and(|e| e.eq_ignore_ascii_case("json")));
	let bytes = if json { rows_json(t) } else { csv::write_table(t) };
	if o.out.is_some() || !o.db2 {
		write_out(o.out.as_deref(), &bytes)?;
	}
	Ok(())
}

/// Entries per table (by name where WoWDBDefs knows the hash), by status, and data bytes.
fn summary(cache: &DbCache, names: &rustc_hash::FxHashMap<u32, String>) -> Result<(), String> {
	// table hash -> (entries, [valid, deleted, removed, not public, other], bytes)
	let mut per: rustc_hash::FxHashMap<u32, (usize, [usize; 5], usize)> = Default::default();
	for e in &cache.entries {
		let p = per.entry(e.table_hash).or_default();
		p.0 += 1;
		p.1[match e.status {
			hotfix::status::VALID => 0,
			hotfix::status::DELETED => 1,
			hotfix::status::REMOVED => 2,
			hotfix::status::NOT_PUBLIC => 3,
			_ => 4,
		}] += 1;
		p.2 += e.data_size;
	}
	let mut v: Vec<(String, (usize, [usize; 5], usize))> = per.into_iter().map(|(h, p)| (names.get(&h).cloned().unwrap_or_else(|| format!("{h:08X}")), p)).collect();
	v.sort_by(|a, b| b.1 .0.cmp(&a.1 .0).then_with(|| a.0.cmp(&b.0)));
	let mut out = std::io::stdout().lock();
	let w = |out: &mut std::io::StdoutLock, s: String| writeln!(out, "{s}").map_err(|e| e.to_string());
	w(&mut out, "table\tentries\tvalid\tdeleted\tremoved\tnot_public\tother\tbytes".into())?;
	for (name, (n, s, bytes)) in v {
		w(&mut out, format!("{name}\t{n}\t{}\t{}\t{}\t{}\t{}\t{bytes}", s[0], s[1], s[2], s[3], s[4]))?;
	}
	Ok(())
}

/// Hotfix rows as a JSON array of objects (a row that is not a decoded row: table columns null).
fn rows_json(t: &Table) -> Vec<u8> {
	let mut out = b"[".to_vec();
	for r in 0..t.rows() {
		let mut m = serde_json::Map::new();
		for (c, v) in t.columns.iter().zip(t.row(r)) {
			let j = match (c.kind, v) {
				(ColKind::String | ColKind::LocString, Value::Str(..)) => serde_json::Value::from(String::from_utf8_lossy(t.str(v).unwrap_or_default())),
				(_, Value::Str(..)) => serde_json::Value::Null,
				(_, Value::Int(x)) => serde_json::Value::from(*x),
				(_, Value::UInt(x)) => serde_json::Value::from(*x),
				(_, Value::Float(f)) => wdb::json_f32(*f),
			};
			m.insert(c.name.clone(), j);
		}
		out.extend_from_slice(if r == 0 { b"\n" } else { b",\n" });
		out.extend_from_slice(serde_json::Value::Object(m).to_string().as_bytes());
	}
	out.extend_from_slice(b"\n]\n");
	out
}

/// Exports every table of the wago.tools folder and compares: equal bytes, or what differs.
fn compare(o: &Opts) -> Result<(), Fail> {
	let wago = o.wago.clone().ok_or_else(|| usage("compare needs --wago <dir>"))?;
	let c = open(o)?;
	let mut names: Vec<String> = match &o.tables {
		Some(t) => t.clone(),
		None => std::fs::read_dir(&wago).map_err(|e| format!("{}: {e}", wago.display()))?.filter_map(|e| e.ok()?.file_name().to_str()?.strip_suffix(".csv").map(str::to_string)).collect(),
	};
	names.sort();
	println!("table\trows\tread_ms\tcsv_ms\tresult");
	for name in names {
		let t = Instant::now();
		let tb = match c.table(&name, &o.locale) {
			Ok(tb) => tb,
			Err(e) => {
				println!("{name}\t-\t{:.1}\t-\tERROR {e}", t.elapsed().as_secs_f64() * 1e3);
				continue;
			}
		};
		let read_ms = t.elapsed().as_secs_f64() * 1e3;
		let t = Instant::now();
		let ours = csv::write_table(&tb);
		let csv_ms = t.elapsed().as_secs_f64() * 1e3;
		let (rows, notes) = (tb.rows(), &tb.notes);
		if let Some(dir) = &o.out {
			std::fs::write(dir.join(format!("{name}.csv")), &ours).map_err(|e| e.to_string())?;
		}
		let theirs = std::fs::read(wago.join(format!("{name}.csv"))).map_err(|e| format!("{name}: {e}"))?;
		let encrypted: std::collections::HashSet<String> = tb.encrypted_ids.iter().map(u32::to_string).collect();
		let verdict = if ours == theirs { "identical".to_string() } else { diff(&ours, &theirs, &encrypted) };
		let notes = if notes.is_empty() { String::new() } else { format!(" [{}]", notes.join("; ")) };
		println!("{name}\t{rows}\t{read_ms:.1}\t{csv_ms:.1}\t{verdict}{notes}");
	}
	Ok(())
}

/// RFC 4180 rows (quoted fields, doubled quotes, embedded newlines).
fn rows(b: &[u8]) -> Vec<Vec<String>> {
	let s = String::from_utf8_lossy(b);
	let mut out = Vec::new();
	let (mut row, mut field, mut q) = (Vec::new(), String::new(), false);
	let mut it = s.chars().peekable();
	while let Some(ch) = it.next() {
		if q {
			if ch == '"' {
				if it.peek() == Some(&'"') {
					field.push('"');
					it.next();
				} else {
					q = false;
				}
			} else {
				field.push(ch);
			}
			continue;
		}
		match ch {
			'"' => q = true,
			',' => row.push(std::mem::take(&mut field)),
			'\n' => {
				row.push(std::mem::take(&mut field));
				out.push(std::mem::take(&mut row));
			}
			'\r' => {}
			c => field.push(c),
		}
	}
	if !field.is_empty() || !row.is_empty() {
		row.push(field);
		out.push(row);
	}
	out
}

/// What differs between two CSVs of one table, keyed by the ID column (else the row number);
/// `encrypted`: IDs in sections we could not decrypt.
fn diff(ours: &[u8], theirs: &[u8], encrypted: &std::collections::HashSet<String>) -> String {
	let (a, b) = (rows(ours), rows(theirs));
	let (Some(ha), Some(hb)) = (a.first(), b.first()) else { return "empty CSV".into() };
	if ha != hb {
		let only_a: Vec<&String> = ha.iter().filter(|c| !hb.contains(c)).collect();
		let only_b: Vec<&String> = hb.iter().filter(|c| !ha.contains(c)).collect();
		return format!("columns differ: ours only {only_a:?}, wago only {only_b:?} ({} vs {} columns)", ha.len(), hb.len());
	}
	if a.len() == b.len() && a.iter().zip(&b).all(|(x, y)| x == y) {
		return "same values, different bytes (quoting or line ends)".into();
	}
	let idc = ha.iter().position(|c| c == "ID");
	let key = |r: &Vec<String>, i: usize| idc.and_then(|c| r.get(c).cloned()).unwrap_or_else(|| i.to_string());
	let ma: std::collections::HashMap<String, &Vec<String>> = a.iter().enumerate().skip(1).map(|(i, r)| (key(r, i), r)).collect();
	let mb: std::collections::HashMap<String, &Vec<String>> = b.iter().enumerate().skip(1).map(|(i, r)| (key(r, i), r)).collect();
	let only_a = ma.keys().filter(|k| !mb.contains_key(*k)).count();
	let only_b: Vec<&String> = mb.keys().filter(|k| !ma.contains_key(*k)).collect();
	let mut per_col: Vec<(usize, String)> = vec![(0, String::new()); ha.len()];
	let mut changed = 0;
	for (k, ra) in &ma {
		let Some(rb) = mb.get(k) else { continue };
		if ra == rb {
			continue;
		}
		changed += 1;
		for (ci, (x, y)) in ra.iter().zip(rb.iter()).enumerate() {
			if x != y {
				per_col[ci].0 += 1;
				if per_col[ci].1.is_empty() {
					per_col[ci].1 = format!("ID {k}: ours {x:?} wago {y:?}");
				}
			}
		}
	}
	let order = if only_a == 0 && only_b.is_empty() && changed == 0 { "; same rows in a different order" } else { "" };
	let cols: Vec<String> = per_col.iter().enumerate().filter(|(_, (n, _))| *n > 0).map(|(i, (n, ex))| format!("{} x{n} ({ex})", ha[i])).collect();
	let mut ob: Vec<&&String> = only_b.iter().take(5).collect();
	ob.sort();
	let in_encrypted = only_b.iter().filter(|k| encrypted.contains(**k)).count();
	format!(
		"rows ours {} wago {}; ours only {only_a}; wago only {} (e.g. {ob:?}; {in_encrypted} in encrypted sections); changed {changed}: {}{order}",
		a.len() - 1,
		b.len() - 1,
		only_b.len(),
		cols.join(", ")
	)
}
