//! `profession build` (port of tools/lib/professions/build.js, byte for byte, offline): the
//! Forever client's tables (cached wago.tools CSVs; Classic Era fills their gaps, [`tables`]) +
//! data/forever/{items,npcs,objects}.json + pfQuest's vendor stock limits + the Forever TDB's sniffed
//! profession trainer lists (the skill each recipe is learned at and its cost) -> professions.json.
//! Trainers come from a curated name list checked against npcs.json ([`trainers`]).

pub mod extract;
pub mod tables;
pub mod trainers;

use std::path::{Path, PathBuf};

use forge_guide::js::{json_quote, parse_json, stringify, Obj, V};

use crate::jsv::relative;
use extract::{Ctx, Stock};
use tables::nk;

pub struct Options {
	/// Reference data (data/forever): items.json, npcs.json, objects.json.
	pub data: PathBuf,
	/// Source cache (data/sources): wago/<build>/*.csv, pfQuest/db/items.lua, forever-tdb/extract.json.
	pub sources: PathBuf,
	/// The Forever TDB's database (re-extracted into the source cache when it changed; without it the
	/// cached extract is read as it is).
	pub tdb: PathBuf,
	/// Forever wago.tools build (default: the newest cached one holding its tables).
	pub build: Option<String>,
}

impl Options {
	pub fn new(root: &Path) -> Options {
		Options { data: root.join("data").join("forever"), sources: root.join("data").join("sources"), tdb: crate::build::tdb_db_default(root), build: None }
	}
}

pub struct Output {
	/// File name -> text: professions.json.
	pub files: Vec<(String, String)>,
	/// The Forever build read, and the Classic Era build that filled its gaps.
	pub build: String,
	pub era_build: String,
	/// One line per profession: `  <name> <n> recipes (left out: ...)`, as the JS prints them.
	pub report: Vec<String>,
	pub warnings: Vec<String>,
	/// Trainer recipes with a price from the Forever TDB's sniffed trainer lists (none without them).
	pub trainer_costs: usize,
}

impl Output {
	/// What `profession build` prints after writing `out` (paths relative to the working directory).
	pub fn summary(&self, out: &Path) -> String {
		let rel = cwd_relative(out);
		let rel = if rel.is_empty() { absolute(out).display().to_string() } else { rel };
		format!("wrote {rel} from Forever build {} (gaps filled from Classic Era {}):\n{}", self.build, self.era_build, self.report.join("\n"))
	}
}

/// The release gate: professions.json built without the Forever TDB's sniffed trainer lists has no
/// trainer price and Classic-estimated learn skills (every 0.3.6 build until the gate came: 351 of
/// 2181 learn skills off, e.g. Copper Mace 55 for 15), which the Codex and the generated profession
/// guides then carry. The data builds call this after `build`; the goldens build without a TDB on
/// purpose and do not.
pub fn require_trainer_costs(out: &Output) -> Result<(), String> {
	if out.trainer_costs > 0 {
		return Ok(());
	}
	Err("professions.json: no trainer recipe has a price, so the Forever TDB's sniffed trainer lists were not read (data/sources/forever-tdb/extract.json or data/local/forever-tdb/world.sqlite); trainer learn skills would be Classic estimates".into())
}

/// pfQuest db/items.lua: item -> ["V"] = { [npc] = limit } (0 = unlimited).
pub fn parse_vendor_stock(text: &str) -> Stock {
	/// `^ {indent}\[(\d+)\]` -> (digits, rest)
	fn bracket(line: &str, indent: usize) -> Option<(&str, &str)> {
		let b = line.as_bytes();
		if b.len() <= indent + 1 || !b[..indent].iter().all(|&c| c == b' ') || b[indent] != b'[' {
			return None;
		}
		let rest = &line[indent + 1..];
		let n = rest.bytes().take_while(u8::is_ascii_digit).count();
		if n == 0 {
			return None;
		}
		Some((&rest[..n], rest[n..].strip_prefix(']')?))
	}
	let mut stock = Stock::default();
	let mut item: Option<f64> = None;
	let mut in_v = false;
	for line in text.split('\n') {
		if let Some((id, rest)) = bracket(line, 2) {
			if rest.starts_with(" = {") {
				item = Some(id.parse().unwrap_or(f64::NAN));
				in_v = false;
				continue;
			}
		}
		if line.starts_with("    [\"V\"] = {") {
			in_v = true;
			continue;
		}
		if in_v {
			let entry = bracket(line, 6).and_then(|(npc, rest)| {
				let rest = rest.strip_prefix(" = ")?;
				let n = rest.bytes().take_while(u8::is_ascii_digit).count();
				(n > 0 && rest.as_bytes().get(n) == Some(&b',')).then(|| (npc, &rest[..n]))
			});
			if let Some((npc, limit)) = entry {
				// A V block before any item keys a null item no lookup ever matches.
				if let Some(it) = item {
					stock.entry(nk(it)).or_default().insert(nk(npc.parse().unwrap_or(f64::NAN)), limit.parse().unwrap_or(f64::NAN));
				}
			} else if line.starts_with("    }") {
				in_v = false;
			}
		}
	}
	stock
}

/// `path.resolve(p)`: absolute, `.` components dropped.
pub fn absolute(p: &Path) -> PathBuf {
	std::env::current_dir().unwrap_or_default().join(p).components().collect()
}

/// `path.relative(process.cwd(), p)`.
pub fn cwd_relative(p: &Path) -> String {
	relative(&std::env::current_dir().unwrap_or_default(), &absolute(p))
}

fn read_json(file: &Path) -> Result<V, String> {
	if !file.exists() {
		return Err(format!("{} missing (data build)", cwd_relative(file)));
	}
	let text = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	parse_json(&text).map_err(|e| format!("{}: {e}", file.display()))
}

fn as_obj(v: V) -> Obj {
	match v {
		V::Obj(o) => o,
		_ => Obj::new(),
	}
}

/// buildProfessions: the texts, nothing written.
pub fn build(opts: &Options) -> Result<Output, String> {
	let items = as_obj(read_json(&opts.data.join("items.json"))?);
	let npcs = as_obj(read_json(&opts.data.join("npcs.json"))?);
	let objects = as_obj(read_json(&opts.data.join("objects.json"))?);
	let mut warnings = Vec::new();
	let stock_file = opts.sources.join("pfQuest").join("db").join("items.lua");
	let mut stock = if stock_file.exists() {
		parse_vendor_stock(&std::fs::read_to_string(&stock_file).map_err(|e| format!("{}: {e}", stock_file.display()))?)
	} else {
		warnings.push(format!("{} missing: vendor stock limits unknown, every vendor counts as unlimited", absolute(&stock_file).display()));
		Stock::default()
	};
	let loaded = tables::load(&opts.sources, opts.build.as_deref())?;
	warnings.extend(loaded.warnings);
	// The Forever TDB's sniffed profession trainer lists: spell -> (skill to learn it, copper). Without
	// the TDB (no database, no extract) trainer recipes keep the estimate.
	let mut trained: rustc_hash::FxHashMap<i64, (f64, f64)> = rustc_hash::FxHashMap::default();
	let mut trained_classic: rustc_hash::FxHashMap<i64, (f64, f64)> = rustc_hash::FxHashMap::default();
	let mut trainer_lists: rustc_hash::FxHashMap<i64, Vec<i64>> = rustc_hash::FxHashMap::default();
	let mut currency: rustc_hash::FxHashSet<(i64, i64)> = rustc_hash::FxHashSet::default();
	match crate::tdb::load(&opts.sources, &opts.tdb, &|_| {})? {
		Some(t) if t.get("professionSpells").is_obj() => {
			for (k, v) in t.get("professionSpells").entries() {
				trained.insert(forge_guide::js::str_to_num(&k) as i64, (v.num_at(0), v.num_at(1)));
			}
			for (k, v) in t.get("professionSpellsClassic").entries() {
				trained_classic.insert(forge_guide::js::str_to_num(&k) as i64, (v.num_at(0), v.num_at(1)));
			}
			for (k, v) in t.get("professionTrainers").entries() {
				trainer_lists.insert(forge_guide::js::str_to_num(&k) as i64, v.items().iter().map(|x| x.num() as i64).collect());
			}
			for (k, v) in t.get("currencyVendors").entries() {
				let npc = forge_guide::js::str_to_num(&k) as i64;
				currency.extend(v.items().iter().map(|x| (npc, x.num() as i64)));
			}
			// An item every sniffed row sells for a currency is a currency item at every vendor of it,
			// sniffed or not (the other faction's Merchant's Favor quartermaster): (0, item).
			let mut gold: rustc_hash::FxHashSet<i64> = rustc_hash::FxHashSet::default();
			for (k, v) in t.get("vendors").entries() {
				let npc = forge_guide::js::str_to_num(&k) as i64;
				gold.extend(v.items().iter().map(|x| x.num() as i64).filter(|&item| !currency.contains(&(npc, item))));
			}
			let only: Vec<(i64, i64)> = currency.iter().filter(|&&(_, item)| !gold.contains(&item)).map(|&(_, item)| (0, item)).collect();
			currency.extend(only);
			// The sniffed rows' stock limits (npc_vendor maxcount) join pfQuest's: Forever's enchanting
			// supply vendors keep 1-4 Strange Dust and Lesser Magic Essence at a time.
			for (k, v) in t.get("vendorLimits").entries() {
				let npc = forge_guide::js::str_to_num(&k);
				for (item, n) in v.entries() {
					stock.entry(nk(forge_guide::js::str_to_num(&item))).or_default().insert(nk(npc), n.num());
				}
			}
		}
		Some(_) => warnings.push(format!(
			"{}: an extract older than schema {} has no profession trainer lists: trainer recipes' learn skill is estimated",
			absolute(&opts.sources.join("forever-tdb").join("extract.json")).display(),
			crate::tdb::SCHEMA
		)),
		None => {}
	}
	let ctx = Ctx {
		items: &items,
		npcs: &npcs,
		objects: &objects,
		stock: &stock,
		season: &loaded.season,
		trained: &trained,
		trained_classic: &trained_classic,
		era_yellow: &loaded.era_yellow,
		currency: &currency,
		trainer_lists: &trainer_lists,
	};
	let res = extract::extract(&loaded.tables, &ctx);
	warnings.extend(res.warnings);
	// One profession per line, like the other data/forever files.
	let mut text = String::with_capacity(1 << 21);
	text.push_str("{\n");
	for (i, (id, prof)) in res.professions.iter().enumerate() {
		if i > 0 {
			text.push_str(",\n");
		}
		json_quote(&mut text, &id.to_string());
		text.push(':');
		text.push_str(&stringify(&V::Obj(prof.clone()), None));
	}
	text.push_str("\n}\n");
	let report = res
		.report
		.iter()
		.map(|r| {
			let skipped = r.skipped.iter().map(|(k, n)| format!("{n} {k}")).collect::<Vec<_>>().join(", ");
			let left = if skipped.is_empty() { String::new() } else { format!(" (left out: {skipped})") };
			format!("  {:<15} {:>4} recipes{left}", r.name, r.recipes)
		})
		.collect();
	let trainer_costs =
		res.professions.iter().flat_map(|(_, prof)| prof.get("recipes").items()).filter(|r| r.get("source").to_js_string() == "trainer" && r.get("cost").as_num().is_some_and(|c| c > 0.0)).count();
	Ok(Output { files: vec![("professions.json".into(), text)], build: loaded.build, era_build: loaded.era_build, report, warnings, trainer_costs })
}

/// Writes each file into `out_dir` (atomically: `<file>.tmp`, then renamed).
pub fn write(out_dir: &Path, out: &Output) -> Result<(), String> {
	std::fs::create_dir_all(out_dir).map_err(|e| format!("{}: {e}", out_dir.display()))?;
	for (name, text) in &out.files {
		let file = out_dir.join(name);
		let tmp = out_dir.join(format!("{name}.tmp"));
		std::fs::write(&tmp, text).map_err(|e| format!("{}: {e}", tmp.display()))?;
		std::fs::rename(&tmp, &file).map_err(|e| format!("{}: {e}", file.display()))?;
	}
	Ok(())
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn vendor_stock() {
		let lua = "  [85] = {\n    [\"O\"] = {\n      [3] = 5,\n    },\n    [\"V\"] = {\n      [2113] = 0,\n      [3074] = 2,\n      [9] = 1.5,\n    },\n  },\n  [86] = {},\n      [7] = 3,\n";
		let s = parse_vendor_stock(lua);
		let v = &s[&nk(85.0)];
		assert_eq!(v.len(), 2);
		assert_eq!(v[&nk(3074.0)], 2.0);
		assert_eq!(v[&nk(2113.0)], 0.0);
		assert!(!s.contains_key(&nk(86.0)));
	}
}
