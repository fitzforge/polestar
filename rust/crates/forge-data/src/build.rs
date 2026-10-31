//! `data build` (port of tools/lib/data/build.js): pfQuest + QuestieDB (Forever) + client map
//! tables + recordings -> data/forever/*.json. Precedence: recordings > questie-forever > pfQuest.
//! Offline only: every source is read from its cache or the local install.

use std::path::{Path, PathBuf};

use forge_guide::js::{json_quote, stringify, Obj, V};
use indexmap::IndexMap;
use rustc_hash::FxHashSet;

use crate::extras;
use crate::factions::{build_factions, build_races};
use crate::jsv::{arr, col_num, relative, Row};
use crate::maps::{build_maps, Frame, Maps};
use crate::merge::{apply_questie, Ctx, World};
use crate::normalize::normalize;
use crate::pfquest;
use crate::questie::{read_questie, QUESTIE_REPO, REPO as QUESTIEDB_REPO};
use crate::recordings::{apply_recordings, read_recordings};
use crate::spawns::{SpawnOptions, DEFAULTS};
use crate::tables::{self, Source};

/// Bumped when the output for the same inputs changes (forge build's stage key).
pub const VERSION: &str = "polestar-data 1";

pub struct Options {
	/// The checkout (relative cache paths in meta.json, forever-db/corrections).
	pub root: PathBuf,
	pub sources: PathBuf,
	pub recordings: PathBuf,
	pub pfquest: Option<PathBuf>,
	/// QuestieDB folder; None builds without it.
	pub questie: Option<PathBuf>,
	/// The corrections: a folder of section files (forever-db/corrections) or one file in the old
	/// single-file form.
	pub corrections: PathBuf,
	/// The private overlay: corrections whose only support is a local-only source, merged over
	/// `corrections` (data/local/corrections-private.json; read only with the local sources).
	pub corrections_private: Option<PathBuf>,
	/// Era wago build (default: newest cached).
	pub build: Option<String>,
	pub forever: bool,
	pub forever_build: Option<String>,
	pub forever_source: Source,
	pub web_xp: bool,
	/// Read the source cache only (the library default). Not offline, the web quest XP the build
	/// wants is looked up first (`sources::web_xp`); the CLI fetches the other sources before the build.
	pub offline: bool,
	pub web_zones: bool,
	pub cap: usize,
	/// meta.json builtAt (ISO 8601, as `new Date(x).toISOString()` prints it).
	pub built_at: String,
	/// The sim-v2 pipeline (m2a's `data build`): its merge rules, training.json and the knowledge
	/// base stage. None: the release build (next's `data build`).
	pub kb: Option<KbOptions>,
}

/// Inputs of the knowledge-base stage (m2a tools/lib/data/build.js `options.kb`).
pub struct KbOptions {
	/// <root>/data/local: facts.sqlite (with the `local-sources` feature), the mechanics layers,
	/// the KB's sqlite and verify-in-game.json.
	pub local: PathBuf,
	/// The Forever TDB (`$FOREVER_TDB`, else <local>/forever-tdb/world.sqlite); its extract is cached
	/// under <sources>/forever-tdb.
	pub tdb_db: PathBuf,
	/// The current trainers.json (the KB adds the TDB's trainers to it).
	pub trainers_file: PathBuf,
	/// <root>/data/sim: world-{horde,alliance}.json name the sim-v2 world's quests.
	pub sim_dir: PathBuf,
	/// Where the KB's sqlite and verify-in-game.json go (None: <local>/kb/...).
	pub kb_file: Option<PathBuf>,
	pub verify_file: Option<PathBuf>,
	/// The committed, editable mechanics layer (<root>/data/mechanics-public.json; absent: none).
	pub public_mechanics: PathBuf,
	/// The installed client as the `client` and `client.cache` sources (None: no client).
	pub client: Option<crate::client::Options>,
}

impl KbOptions {
	pub fn new(root: &Path, out_dir: &Path) -> KbOptions {
		let local = root.join("data").join("local");
		let tdb_db = std::env::var_os("FOREVER_TDB").map(PathBuf::from).unwrap_or_else(|| local.join("forever-tdb").join("world.sqlite"));
		KbOptions {
			tdb_db,
			trainers_file: out_dir.join("trainers.json"),
			sim_dir: root.join("data").join("sim"),
			kb_file: None,
			verify_file: None,
			public_mechanics: root.join("data").join("mechanics-public.json"),
			client: None,
			local,
		}
	}
}

fn tdb_source(revision: String) -> V {
	obj_of(vec![
		("name", s("Forever TrinityCore world database (sniffed spawns, quest objectives, timers, loot, class trainers)")),
		("url", s("https://github.com/advocaite/TrinityCore/tree/forever")),
		("license", s("GPL-2.0; used as facts: objective counts, quest time limits and next quests, sniffed spawn positions, sniffed drop rates, class trainer lists and costs")),
		("copyright", s("TrinityCore (https://www.trinitycore.org) and the advocaite/TrinityCore `forever` branch")),
		("revision", V::from(revision)),
	])
}

/// The vendors of the mounts a character can ride at `level` (Item ClassID 15 / SubclassID 5,
/// ItemSparse RequiredLevel `level`, BuyPrice copper): vendor npc -> [copper, item] of its cheapest
/// such mount (the lower item id on a tie).
pub fn mount_vendors(item_rows: &[Row], sparse_rows: &[Row], items: &Obj, level: f64) -> Obj {
	let mount: FxHashSet<i64> = item_rows.iter().filter(|r| col_num(r, "ClassID") == 15.0 && col_num(r, "SubclassID") == 5.0).map(|r| col_num(r, "ID") as i64).collect();
	let out: IndexMap<String, (f64, f64)> = sparse_rows.iter().fold(IndexMap::new(), |mut out, r| {
		let id = col_num(r, "ID");
		let price = col_num(r, "BuyPrice");
		let it = items.get(&forge_guide::js::num_str(id));
		if !mount.contains(&(id as i64)) || col_num(r, "RequiredLevel") != level || !(price > 0.0) || !it.truthy() {
			return out;
		}
		for v in it.get("vendors").items() {
			let k = v.to_js_string();
			match out.get(&k) {
				Some(o) if !(price < o.0 || (price == o.0 && id < o.1)) => {}
				_ => {
					out.insert(k, (price, id));
				}
			}
		}
		out
	});
	let mut e: Vec<(String, (f64, f64))> = out.into_iter().collect();
	e.sort_by(|a, b| (forge_guide::js::str_to_num(&a.0) - forge_guide::js::str_to_num(&b.0)).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal));
	let o = Obj::new();
	for (k, (p, id)) in e {
		o.set(&k, arr(vec![V::Num(p), V::Num(id)]));
	}
	o
}

/// Class training's spells named from SpellName and ranked (a spell's place among the class's
/// spells of that name, by level then id): { CLASS: { level: [[spell, copper, name, rank]] } }.
pub fn named_spells(spells: &V, name_rows: &[Row]) -> V {
	let mut name: rustc_hash::FxHashMap<i64, &str> = rustc_hash::FxHashMap::default();
	for r in name_rows {
		name.insert(col_num(r, "ID") as i64, crate::jsv::col_str(r, "Name_lang"));
	}
	let out = Obj::new();
	for (cls, per) in spells.entries() {
		let mut all: Vec<(f64, V, V)> = Vec::new();
		for (lvl, list) in per.entries() {
			for e in list.items() {
				all.push((forge_guide::js::str_to_num(&lvl), e.at(0), e.at(1)));
			}
		}
		all.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap().then(a.1.num().partial_cmp(&b.1.num()).unwrap()));
		let mut seen: rustc_hash::FxHashMap<String, f64> = rustc_hash::FxHashMap::default();
		let rows = Obj::new();
		for (lvl, id, copper) in all {
			let n = name.get(&(id.num() as i64)).copied().filter(|n| !n.is_empty() && id.num().fract() == 0.0);
			let rank = match n {
				Some(n) => {
					let r = seen.get(n).copied().unwrap_or(0.0) + 1.0;
					seen.insert(n.to_string(), r);
					r
				}
				None => 0.0,
			};
			let k = forge_guide::js::num_str(lvl);
			if !rows.has(&k) {
				rows.set(&k, V::arr());
			}
			rows.get(&k).push(arr(vec![id, copper, n.map(V::str).unwrap_or(V::Null), V::Num(rank)]));
		}
		out.set(&cls, rows);
	}
	V::Obj(out)
}

impl Options {
	pub fn new(root: &Path) -> Options {
		Options {
			root: root.to_path_buf(),
			sources: root.join("data").join("sources"),
			recordings: root.join("data").join("recordings"),
			pfquest: None,
			questie: None,
			corrections: crate::corrections::locate(root),
			corrections_private: if cfg!(feature = "local-sources") { Some(root.join("data").join("local").join("corrections-private.json")) } else { None },
			build: None,
			forever: true,
			forever_build: None,
			forever_source: Source::Wago,
			web_xp: true,
			offline: true,
			web_zones: true,
			cap: DEFAULTS.cap,
			built_at: now_iso(),
			kb: None,
		}
	}
}

/// The files of data/forever, in write order (meta.json last), and what the build noticed.
pub struct Output {
	pub files: Vec<(String, String)>,
	pub meta: V,
	pub warnings: Vec<String>,
	pub summary: String,
	/// Files an older build may have left that this one does not write (removed by `write`).
	pub stale: Vec<&'static str>,
	/// What each correction did (applied, created, redundant, unused): the fixes ledger's rows.
	pub corrections: Vec<crate::corrections::Entry>,
}

const QUESTIE_LICENSE: &str = "No license file in Questie/Questie or Questie/QuestieDB; CurseForge lists GPL-3.0, and the maintainers ask that it be treated as all rights reserved (https://github.com/Questie/Questie/issues/4447). Read from the local install; facts only (quest, NPC, object and item facts, no code or text) ship in Polestar's packs, credited here, and come out if the maintainers ask (data build --no-questie).";

/// Id-keyed table, one entry per line.
pub fn serialize_table(o: &Obj) -> String {
	let keys = o.keys();
	if keys.is_empty() {
		return "{}\n".into();
	}
	let mut s = String::with_capacity(1 << 20);
	s.push_str("{\n");
	for (i, k) in keys.iter().enumerate() {
		if i > 0 {
			s.push_str(",\n");
		}
		json_quote(&mut s, k);
		s.push(':');
		s.push_str(&stringify(&o.get(k), None));
	}
	s.push_str("\n}\n");
	s
}

fn pretty(v: &V) -> String {
	format!("{}\n", stringify(v, Some("\t")))
}

fn days_to_civil(z: i64) -> (i64, u32, u32) {
	let z = z + 719468;
	let era = z.div_euclid(146097);
	let doe = z.rem_euclid(146097);
	let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365;
	let y = yoe + era * 400;
	let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
	let mp = (5 * doy + 2) / 153;
	let d = (doy - (153 * mp + 2) / 5 + 1) as u32;
	let m = if mp < 10 { mp + 3 } else { mp - 9 } as u32;
	(if m <= 2 { y + 1 } else { y }, m, d)
}

fn civil_to_days(y: i64, m: u32, d: u32) -> i64 {
	let y = if m <= 2 { y - 1 } else { y };
	let era = y.div_euclid(400);
	let yoe = y.rem_euclid(400);
	let mp = if m > 2 { m - 3 } else { m + 9 } as i64;
	let doy = (153 * mp + 2) / 5 + d as i64 - 1;
	let doe = yoe * 365 + yoe / 4 - yoe / 100 + doy;
	era * 146097 + doe - 719468
}

pub fn iso_from_ms(ms: i64) -> String {
	let (days, rem) = (ms.div_euclid(86_400_000), ms.rem_euclid(86_400_000));
	let (y, mo, d) = days_to_civil(days);
	format!("{y:04}-{mo:02}-{d:02}T{:02}:{:02}:{:02}.{:03}Z", rem / 3_600_000, rem / 60_000 % 60, rem / 1000 % 60, rem % 1000)
}

/// `new Date(s).toISOString()` for ISO forms (date, date-time with optional seconds, fraction,
/// `Z` or offset; a date-time without a zone is UTC here).
pub fn parse_iso(s: &str) -> Result<String, String> {
	let bad = || format!("--built-at {s}: not an ISO 8601 date");
	let s = s.trim();
	let (date, time) = s.split_once('T').unwrap_or((s, ""));
	let dp: Vec<&str> = date.split('-').collect();
	if dp.len() != 3 {
		return Err(bad());
	}
	let (y, mo, d): (i64, u32, u32) = (dp[0].parse().map_err(|_| bad())?, dp[1].parse().map_err(|_| bad())?, dp[2].parse().map_err(|_| bad())?);
	let mut ms = civil_to_days(y, mo, d) * 86_400_000;
	if !time.is_empty() {
		let (clock, off) = if let Some(c) = time.strip_suffix('Z') {
			(c, 0i64)
		} else if let Some(i) = time.rfind(['+', '-']) {
			let (c, o) = time.split_at(i);
			let sign = if o.starts_with('-') { -1 } else { 1 };
			let hm: Vec<&str> = o[1..].split(':').collect();
			let h: i64 = hm[0].parse().map_err(|_| bad())?;
			let m: i64 = hm.get(1).map(|x| x.parse()).transpose().map_err(|_| bad())?.unwrap_or(0);
			(c, sign * (h * 60 + m) * 60_000)
		} else {
			(time, 0)
		};
		let cp: Vec<&str> = clock.split(':').collect();
		let h: i64 = cp[0].parse().map_err(|_| bad())?;
		let mi: i64 = cp.get(1).ok_or_else(bad)?.parse().map_err(|_| bad())?;
		let sec: f64 = cp.get(2).map(|x| x.parse()).transpose().map_err(|_| bad())?.unwrap_or(0.0);
		ms += (h * 3600 + mi * 60) * 1000 + (sec * 1000.0).floor() as i64 - off;
	}
	Ok(iso_from_ms(ms))
}

pub fn now_iso() -> String {
	if let Ok(e) = std::env::var("SOURCE_DATE_EPOCH") {
		if !e.is_empty() && e.bytes().all(|b| b.is_ascii_digit()) {
			return iso_from_ms(e.parse::<i64>().unwrap_or(0) * 1000);
		}
	}
	let ms = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).map(|d| d.as_millis() as i64).unwrap_or(0);
	iso_from_ms(ms)
}

fn count_points(t: &Obj, frame: &str) -> usize {
	let mut n = 0;
	for e in t.values() {
		for s in e.get("spawns").values() {
			if s.get("f").as_str() == Some(frame) {
				n += s.get("pts").len();
			}
		}
	}
	n
}

fn frame_changed(a: &Frame, b: &Frame) -> bool {
	a.c != b.c || (a.left - b.left).abs() > 1.0 || (a.right - b.right).abs() > 1.0 || (a.top - b.top).abs() > 1.0 || (a.bottom - b.bottom).abs() > 1.0
}

fn obj_of(pairs: Vec<(&str, V)>) -> V {
	let o = Obj::new();
	for (k, v) in pairs {
		o.set(k, v);
	}
	V::Obj(o)
}

fn s(v: &str) -> V {
	V::str(v)
}

fn so(v: &Option<String>) -> V {
	v.as_deref().map(V::str).unwrap_or(V::Null)
}

pub fn run(o: &Options, log: &dyn Fn(&str)) -> Result<Output, String> {
	let t0 = std::time::Instant::now();
	let times = std::env::var_os("POLESTAR_DATA_TIMES").is_some();
	let lap = |what: &str| {
		if times {
			eprintln!("[{:.2}s] {what}", t0.elapsed().as_secs_f64())
		}
	};
	let so_ = SpawnOptions { cap: o.cap, dedupe: DEFAULTS.dedupe };
	// m2a's npc, object and recording merge rules come with the knowledge base; the item rules (one
	// rate table per item, `dropScale`), the Forever tables, spawn heights with respawn times and
	// training.json are every build's (the JS release build took them over).
	let sim = o.kb.is_some();
	let mut warnings: Vec<String> = Vec::new();

	let (pf_dir, explicit) = match &o.pfquest {
		Some(d) => (d.clone(), true),
		None => (o.sources.join("pfQuest"), false),
	};
	let pf = pfquest::ensure(&pf_dir, explicit)?;
	warnings.extend(pf.warnings.iter().cloned());
	let license = pfquest::check_license(&pf.dir)?;

	let wago = tables::load(&o.sources, &tables::ERA, o.build.as_deref(), &Source::Wago, log)?;
	warnings.extend(wago.warnings.iter().cloned());
	let era_t = |t: &str| wago.get(t).map(Vec::as_slice).unwrap_or(&[]);
	let maps = build_maps(era_t("UiMap"), era_t("UiMapAssignment"), era_t("AreaTable"));
	warnings.extend(maps.warnings.iter().cloned());

	let mut fwago = None;
	let mut fmaps: Option<Maps> = None;
	if o.forever {
		match tables::load(&o.sources, &tables::FOREVER_SIM, o.forever_build.as_deref(), &o.forever_source, log) {
			Ok(f) => {
				warnings.extend(f.warnings.iter().cloned());
				let t = |n: &str| f.get(n).map(Vec::as_slice).unwrap_or(&[]);
				let m = build_maps(t("UiMap"), t("UiMapAssignment"), t("AreaTable"));
				warnings.extend(m.warnings.iter().map(|w| format!("forever {w}")));
				fmaps = Some(m);
				fwago = Some(f);
			}
			Err(e) => warnings.push(format!("Forever map tables unavailable ({e}); zones and frames from Classic Era, changed frames from QuestieDB's eraToForever list")),
		}
	}

	lap("tables");
	log(&format!("loading pfQuest database from {}", pf.dir.display()));
	let raw = pfquest::load(&pf.dir)?;
	lap("pfquest lua");
	let resolve = |a: f64| maps.resolve_area(a);
	let norm = normalize(&raw, &resolve, so_);
	drop(raw);

	lap("normalize");
	let qz = match &o.questie {
		Some(d) => Some(read_questie(d, log)?),
		None => None,
	};
	lap("questie read");
	let zones = maps.zones_obj();
	if let Some(fm) = &fmaps {
		for z in &fm.zones {
			zones.set(&z.id.to_string(), z.to_v());
		}
	}
	if let (Some(q), None) = (&qz, &fmaps) {
		for (&map, &area) in &q.ui_map_to_area {
			if map > 0 && !zones.has(&map.to_string()) {
				let name = maps.area_names.get(&(area as i64)).map(|n| V::str(n)).unwrap_or(V::Null);
				let name = if name.truthy() { name } else { V::Null };
				zones.set(&map.to_string(), obj_of(vec![("id", V::Num(map as f64)), ("name", name), ("areaId", V::Num(area)), ("parent", V::Null), ("type", V::Num(3.0))]));
			}
		}
	}
	// Maps whose points are live-frame: no Era frame, or a Forever frame that differs.
	let mut changed: Vec<i64> = Vec::new();
	if let Some(fm) = &fmaps {
		for (id, f) in &fm.frames {
			if let Some(e) = maps.frames.get(id) {
				if frame_changed(e, f) {
					changed.push(*id);
				}
			}
		}
	} else if let Some(q) = &qz {
		changed.extend(q.era_to_forever.ui_map_to_area.keys().copied());
	}
	let changed_set: FxHashSet<i64> = changed.iter().copied().collect();
	let live = |m: i64| changed_set.contains(&m) || !maps.frames.contains_key(&m);

	let mut qstats = None;
	let mut quest_counts = None;
	if let Some(q) = &qz {
		match crate::cmangos::load_quest_counts(&o.sources) {
			Ok(c) => quest_counts = Some(c),
			Err(e) => warnings.push(format!("CMaNGOS classic-db objective counts unavailable ({e}); counts QuestieDB and pfQuest lack stay null")),
		}
		let area_to_ui_map = |area: f64| -> Option<i64> {
			if let Some(&m) = q.area_to_ui_map.get(&(area as i64)).filter(|_| area.fract() == 0.0) {
				return (m > 0.0).then_some(m as i64);
			}
			fmaps.as_ref().and_then(|f| f.resolve_area(area)).or_else(|| maps.resolve_area(area))
		};
		let to_world = |map: i64, f: &str, x: f64, y: f64| -> Option<World> {
			let ff = fmaps.as_ref().and_then(|m| m.frames.get(&map));
			let fr = (if f == "l" { ff } else { None }).or_else(|| maps.frames.get(&map)).or(ff)?;
			Some(World { c: fr.c, wx: fr.top + ((fr.bottom - fr.top) * y) / 100.0, wy: fr.left + ((fr.right - fr.left) * x) / 100.0 })
		};
		// Area -> its dungeon or raid map (Forever's AreaTable + Map, else Era's AreaTable).
		let area_rows: &[Row] = fwago.as_ref().and_then(|f| f.get("AreaTable")).map(Vec::as_slice).unwrap_or_else(|| era_t("AreaTable"));
		let continent: rustc_hash::FxHashMap<i64, f64> = area_rows.iter().map(|r| (col_num(r, "ID") as i64, col_num(r, "ContinentID"))).collect();
		let instance_maps: Option<FxHashSet<i64>> =
			fwago.as_ref().and_then(|f| f.get("Map")).map(|rows| rows.iter().filter(|r| matches!(col_num(r, "InstanceType"), x if x == 1.0 || x == 2.0)).map(|r| col_num(r, "ID") as i64).collect());
		let instance_of_area = |area: f64| -> Option<i64> {
			if area.fract() != 0.0 {
				return None;
			}
			let c = *continent.get(&(area as i64))?;
			if !(c.is_finite() && c.fract() == 0.0) {
				return None;
			}
			let c = c as i64;
			match &instance_maps {
				Some(set) => set.contains(&c).then_some(c),
				None => (c > 1 && area_to_ui_map(area).is_none()).then_some(c),
			}
		};
		let ctx = Ctx {
			area_to_ui_map: &area_to_ui_map,
			live_maps: &live,
			spawn_options: so_,
			to_world: &to_world,
			instance_of_area: &instance_of_area,
			quest_counts: quest_counts.as_ref(),
			sim,
			item_rules: true,
		};
		qstats = Some(apply_questie(&crate::merge::Tables { quests: &norm.quests, npcs: &norm.npcs, objects: &norm.objects, items: &norm.items }, q, &ctx));
	}

	lap("questie merge");
	// The web zone lists' change notes, before our own corrections.
	let mut wh = None;
	if qz.is_some() && o.web_zones {
		let zl = extras::load_zone_quests(&o.sources)?;
		warnings.extend(zl.warnings.iter().cloned());
		let changed = extras::apply_change_notes(&norm.quests, &zl.rows);
		let facts = extras::apply_web_zone_facts(&norm.quests, &zl.rows);
		wh = Some((zl, changed, facts, 0usize));
	}
	let read = |f: &Path| -> Result<V, String> {
		let c = std::fs::read_to_string(f).map_err(|e| format!("{}: {e}", f.display()))?;
		forge_guide::js::parse_json(&c).map_err(|e| format!("{}: {e}", f.display()))
	};
	let private = match o.corrections_private.as_deref().filter(|f| f.exists()) {
		Some(f) => Some((f.to_path_buf(), read(f)?)),
		None => None,
	};
	let corrections = {
		let public = crate::corrections::load(&o.corrections)?;
		match &private {
			Some((_, p)) => crate::corrections::overlay(&public, p),
			None => public,
		}
	};
	// Applied with or without Forever's quest data: a correction for an absent record becomes the
	// record when it can stand alone, else it is named in the warnings.
	let applied = crate::corrections::apply(&corrections, &norm.quests, &norm.npcs, &norm.objects, &norm.items, true);
	// The private overlay: one line saying what it applied, as a warning when the other private sources
	// (the web quest-list cache, the local knowledge base or fact check) are here but the overlay is not.
	let mut private_applied = 0usize;
	match &private {
		Some((f, p)) => {
			for (kind, table) in [("quests", &norm.quests), ("npcs", &norm.npcs), ("objects", &norm.objects), ("items", &norm.items)] {
				private_applied += p.get(kind).keys().iter().filter(|id| table.has(id)).count();
			}
			// Mechanics fixes (flat or under `quests`) go to the knowledge base's mechanics.
			private_applied += crate::corrections::overlay(&V::obj(), p).get("mechanics").keys().iter().filter(|id| norm.quests.has(id)).count();
			log(&format!("private corrections: {private_applied} applied from {}", f.display()));
		}
		None => {
			let line = "private corrections: none found (public corrections only)";
			let local = o.root.join("data").join("local");
			let others = [extras::cache_dir(&o.sources), local.join("kb"), local.join("factcheck")].iter().any(|p| p.exists());
			if others && o.corrections_private.is_some() {
				warnings.push(line.to_string());
			} else {
				log(line);
			}
		}
	}
	if let Some(st) = qstats.as_mut() {
		st.corrections = applied.records;
	}
	for u in &applied.unused {
		warnings.push(format!("correction not applied: {u}"));
	}

	let mut webxp = None;
	if o.web_xp {
		let want: Vec<f64> = norm.quests.values().iter().filter(|q| !q.get("xp").as_num().is_some_and(f64::is_finite)).map(|q| q.get("id").num()).collect();
		if !o.offline {
			warnings.extend(crate::sources::web_xp(&o.sources, &want, log)?);
		}
		let w = extras::load_web_xp(&o.sources, &want)?;
		for (id, (xp, source)) in &w.xp {
			let q = norm.quests.get(&id.to_string());
			q.set("xp", xp.clone());
			let src = q.get("source");
			if !src.items().iter().any(|x| x.as_str() == Some(source)) {
				src.push(*source);
			}
		}
		webxp = Some(w);
	}
	if let Some(w) = wh.as_mut() {
		w.3 = extras::fill_web_zone_xp(&norm.quests, &w.0.rows);
	}

	lap("zone lists/corrections/webxp");
	// Forever's Faction rows win by id; Era rows fill the rest.
	let mut faction_rows: IndexMap<i64, &Row> = IndexMap::new();
	for r in era_t("Faction") {
		faction_rows.insert(col_num(r, "ID") as i64, r);
	}
	if let Some(rows) = fwago.as_ref().and_then(|f| f.get("Faction")) {
		for r in rows {
			faction_rows.insert(col_num(r, "ID") as i64, r);
		}
	}
	let factions = build_factions(&faction_rows.values().copied().collect::<Vec<_>>());
	let races = fwago.as_ref().and_then(|f| match (f.get("ChrRaces"), f.get("ChrClasses"), f.get("CharBaseInfo")) {
		(Some(a), Some(b), Some(c)) => Some(build_races(a, b, c)),
		_ => None,
	});
	let recordings = read_recordings(&o.recordings)?;
	let instances = Obj::new();
	let rec = apply_recordings(
		&crate::recordings::Db { quests: &norm.quests, npcs: &norm.npcs, objects: &norm.objects, items: &norm.items, zones: &zones, factions: &factions, instances: &instances },
		&recordings,
		recordings.min_voters,
		so_,
		&live,
		sim,
	);
	let durations = extras::item_durations(fwago.as_ref().and_then(|f| f.get("ItemSparse")).map(Vec::as_slice).unwrap_or(&[]), &norm.items);

	lap("recordings");
	let mut heights = match crate::cmangos::load_spawn_heights(&o.sources, true) {
		Ok(h) => Some(h),
		Err(e) => {
			warnings.push(format!("CMaNGOS classic-db spawn heights unavailable ({e}); spawnz.json not written, so compiled goals carry no z"));
			None
		}
	};

	// sim-v2: class training costs per level (copper), from the same dump, and the knowledge base.
	let mut training_doc: Option<V> = None;
	let mut trainers_doc: Option<V> = None;
	let mut kb: Option<crate::kb::KbOut> = None;
	let mut tdb_meta: Option<V> = None;
	match crate::cmangos::load_training(&o.sources) {
		Ok(t) => training_doc = Some(obj_of(vec![("schema", V::Num(1.0)), ("source", s(&format!("cmangos classic-db {}", &crate::cmangos::DB_REV[..12]))), ("classes", t.get("classes"))])),
		Err(e) => warnings.push(format!("CMaNGOS classic-db training costs unavailable ({e}); training.json not written")),
	}
	if let Some(ko) = &o.kb {
		let tdb = crate::tdb::load(&o.sources, &ko.tdb_db, log)?;
		let quest_xp = match crate::players::load_quest_xp(&o.sources) {
			Ok(q) => Some(q),
			Err(e) => {
				warnings.push(format!("QuestXP table unavailable ({e}); EG Link XP from difficulty and multiplier not computed"));
				None
			}
		};
		let eg = crate::players::load_eg(&o.sources, quest_xp.as_ref(), log).unwrap_or_else(|e| {
			warnings.push(format!("EG Link output unavailable ({e})"));
			None
		});
		let vo = crate::players::load_vo(&o.sources, log).unwrap_or_else(|e| {
			warnings.push(format!("forever-vo captures unavailable ({e})"));
			None
		});
		let client = match &ko.client {
			Some(c) => match crate::client::load(c, quest_xp.as_ref(), log) {
				Ok(cl) => {
					if let Some(cl) = &cl {
						warnings.extend(cl.warnings.iter().cloned());
					}
					cl
				}
				Err(e) => {
					warnings.push(format!("the client unavailable ({e})"));
					None
				}
			},
			None => None,
		};
		trainers_doc = match std::fs::read_to_string(&ko.trainers_file) {
			Ok(t) => Some(forge_guide::js::parse_json(&t).map_err(|e| format!("{}: {e}", ko.trainers_file.display()))?),
			Err(_) => None,
		};
		let mut v2_quests = FxHashSet::default();
		for side in ["horde", "alliance"] {
			let wf = ko.sim_dir.join(format!("world-{side}.json"));
			if let Ok(t) = std::fs::read_to_string(&wf) {
				let w = forge_guide::js::parse_json(&t).map_err(|e| format!("{}: {e}", wf.display()))?;
				for q in w.get("quests").items() {
					v2_quests.insert(q.get("id").num() as i64);
				}
			}
		}
		let frames = Obj::new();
		frames.set("era", maps.frames_v());
		if let Some(fm) = &fmaps {
			frames.set("forever", fm.frames_v());
		}
		let local = &ko.local;
		let mech = |a: &str, b: &str| local.join(a).join(b);
		let inputs = crate::kb::KbInputs {
			quests: &norm.quests,
			npcs: &norm.npcs,
			objects: &norm.objects,
			items: &norm.items,
			frames: V::Obj(frames),
			zones: &zones,
			live: changed_set.iter().copied().collect(),
			corrections: corrections.clone(),
			// The fact check's local database is a local-only source.
			facts_file: if cfg!(feature = "local-sources") { Some(local.join("factcheck").join("facts.sqlite")) } else { None },
			tdb: tdb.as_ref().filter(|t| t.get("schema").num() >= 2.0).cloned(),
			// CMaNGOS's quest and creature facts, to show which values it confirms (check-only).
			classic: crate::cmangos::load_quest_facts(&o.sources).ok(),
			factoruide_file: if cfg!(feature = "local-sources") { Some(local.join("factcheck").join("sources").join("factoruide-forever.sqlite")) } else { None },
			quest_xp,
			spawnz: heights.as_ref().map(|h| (h.npc.clone(), h.object.clone())),
			training: training_doc.clone(),
			trainers: trainers_doc.clone(),
			mechanics: crate::kb::MechFiles {
				quest_mechanics: mech("mechanics", "quest-mechanics.json"),
				quest_steps: mech("mechanics", "quest-steps.json"),
				tdb_layer: local.join("forever-tdb").join("analysis").join("mechanics.json"),
				web: mech("mechanics", "web-verdicts.json"),
				public: ko.public_mechanics.clone(),
				evidence: local.join("mechanics").join("evidence"),
			},
			v2_quests,
			eg,
			vo,
			client,
			kb_file: Some(ko.kb_file.clone().unwrap_or_else(|| local.join("kb").join("forever-kb.sqlite"))),
			verify_file: Some(ko.verify_file.clone().unwrap_or_else(|| local.join("kb").join("verify-in-game.json"))),
		};
		let out = crate::kb::build_kb(&inputs, log)?;
		tdb_meta = tdb.as_ref().map(|t| t.get("meta"));
		training_doc = out.training.clone();
		let ft = |n: &str| fwago.as_ref().and_then(|f| f.get(n)).map(Vec::as_slice);
		if let Some(td) = training_doc.as_ref() {
			let riding = td.get("riding");
			if riding.truthy() {
				if let (Some(item), Some(sparse)) = (ft("Item"), ft("ItemSparse")) {
					let r = Obj::new();
					for (k, v) in riding.entries() {
						r.set(&k, v);
					}
					r.set("vendors", mount_vendors(item, sparse, &norm.items, riding.get("level").num()));
					let t = Obj::new();
					for (k, v) in td.entries() {
						t.set(&k, v);
					}
					t.set("riding", r);
					training_doc = Some(V::Obj(t));
				}
			}
		}
		if let (Some(td), Some(names)) = (training_doc.as_ref(), ft("SpellName")) {
			if td.get("spells").truthy() {
				let t = Obj::new();
				for (k, v) in td.entries() {
					t.set(&k, v);
				}
				t.set("spells", named_spells(&td.get("spells"), names));
				training_doc = Some(V::Obj(t));
			}
		}
		if let (Some(h), true, Some((npc, object))) = (heights.as_mut(), out.spawnz_changed, out.spawnz.as_ref()) {
			let db = Obj::new();
			db.set("npc", npc.clone());
			db.set("object", object.clone());
			h.text = crate::cmangos::serialize_spawn_heights(&V::Obj(db));
		}
		kb = Some(out);
	}

	// ---- meta.json sources
	let mut sources: Vec<V> = Vec::new();
	sources.push(obj_of(vec![
		("name", s("pfQuest")),
		("url", s(pfquest::REPO)),
		("revision", so(&pf.revision)),
		("license", s(&license.license)),
		("copyright", so(&license.copyright)),
		("notice", s(&license.notice)),
	]));
	sources.push(obj_of(vec![
		("name", s("World of Warcraft Classic Era client tables (UiMap, UiMapAssignment, AreaTable, Faction) via wago.tools")),
		("url", s(&format!("https://wago.tools/db2?build={}", wago.build))),
		("revision", s(&format!("{} {}", tables::ERA.key, wago.build))),
		("license", s("Blizzard Entertainment game client data; factual map geometry, names and faction hierarchy only")),
		("copyright", s("World of Warcraft (c) Blizzard Entertainment, Inc.")),
		("tables", arr(wago.urls.iter().map(|u| s(u)).collect())),
	]));
	if let Some(q) = &qz {
		let qi = q.questie.as_ref().map(|i| obj_of(vec![("url", s(QUESTIE_REPO)), ("version", so(&i.version)), ("revision", so(&i.build_commit)), ("authors", so(&i.author))])).unwrap_or(V::Null);
		sources.push(obj_of(vec![
			("name", s("QuestieDB (Questie-Forever), baked Forever store and support data")),
			("url", s(QUESTIEDB_REPO)),
			("revision", s(&format!("{} {}", q.info.version.as_deref().unwrap_or("null"), q.info.build_commit.as_deref().unwrap_or("null")))),
			("license", s(QUESTIE_LICENSE)),
			("copyright", so(&q.info.author)),
			("builtAt", so(&q.info.build_time)),
			("flavor", so(&q.flavor)),
			("contract", so(&q.contract)),
			("questie", qi),
			("dir", s(&q.dir.to_string_lossy())),
		]));
	}
	if let Some(w) = webxp.as_ref().filter(|w| !w.xp.is_empty()) {
		sources.push(obj_of(vec![
			("name", s("Quest XP for quests QuestieDB lacks: two Forever web quest databases (one from the beta client's quest cache)")),
			("revision", s(&format!("{} quests; cache {}", w.xp.len(), relative(&o.root, &w.file)))),
			("license", s("Public web pages; facts (XP numbers) only, used locally with permission")),
			("copyright", V::Null),
		]));
	}
	if let Some((zl, _, _, _)) = &wh {
		let read = if zl.fetched_at.truthy() { format!(" read {}", zl.fetched_at.to_js_string()) } else { String::new() };
		sources.push(obj_of(vec![
			("name", s("the web quest database: zone quest lists (XP, levels, Forever change notes)")),
			("revision", s(&format!("{} listed quests{read}; cache {}", zl.rows.len(), relative(&o.root, &zl.file)))),
			("license", s("Public web pages; facts (ids, XP, levels, instance categories, rewards) only, used locally")),
			("copyright", V::Null),
		]));
	}
	if let Some(f) = &fwago {
		let has = |t: &str| f.get(t).is_some();
		let list = format!(
			"UiMap, UiMapAssignment, AreaTable{}{}{}{}{}",
			if races.is_some() { ", ChrRaces, ChrClasses, CharBaseInfo" } else { "" },
			if has("Faction") { ", Faction" } else { "" },
			if has("Map") { ", Map" } else { "" },
			if has("ItemSparse") { ", ItemSparse" } else { "" },
			if has("QuestV2") { ", QuestV2" } else { "" },
		) + if has("SpellName") { ", SpellName" } else { "" };
		let license = format!("Blizzard Entertainment game client data; factual map geometry, names{} and race/class combinations only", if has("ItemSparse") { ", item durations" } else { "" });
		let (name, url) = if f.from_client {
			(format!("World of Warcraft: Forever client tables ({list}) read from the installed client"), V::Null)
		} else {
			(format!("World of Warcraft: Forever client tables ({list}) via wago.tools"), s(&format!("https://wago.tools/db2?build={}", f.build)))
		};
		sources.push(obj_of(vec![
			("name", s(&name)),
			("url", url),
			("revision", s(&format!("{} {}", f.product, f.build))),
			("license", s(&license)),
			("copyright", s("World of Warcraft (c) Blizzard Entertainment, Inc.")),
			("tables", arr(f.urls.iter().map(|u| s(u)).collect())),
		]));
	}
	if !recordings.is_empty() {
		sources.push(obj_of(vec![
			("name", s("Polestar recordings")),
			("url", V::Null),
			("revision", s(&crate::recordings::revision(&recordings))),
			("license", s("Polestar original work")),
			("copyright", V::Null),
			("sessions", arr(recordings.iter().map(|r| s(&r.file)).collect())),
		]));
	}
	if heights.is_some() {
		sources.push(crate::cmangos::heights_source());
	}
	if qstats.as_ref().is_some_and(|q| q.objective_counts_from_classic_db > 0) {
		sources.push(crate::cmangos::counts_source());
	}
	if let Some(k) = &kb {
		if let (true, Some(m)) = (k.tdb_used, &tdb_meta) {
			let head = m.get("branchHead").to_js_string();
			sources.push(tdb_source(format!("{} + {}", m.get("release").to_js_string(), head.chars().take(12).collect::<String>())));
		}
		sources.extend(k.credits.iter().cloned());
		if !k.mechanics.keys().is_empty() {
			sources.push(crate::kb::mechanics_source());
		}
	}

	lap("heights+sources");
	// ---- outputs
	let mut files: Vec<(String, String)> = vec![
		("quests".into(), serialize_table(&norm.quests)),
		("npcs".into(), serialize_table(&norm.npcs)),
		("objects".into(), serialize_table(&norm.objects)),
		("items".into(), serialize_table(&norm.items)),
		("zones".into(), serialize_table(&zones)),
		("map-frames".into(), {
			let mf = Obj::new();
			mf.set("era", maps.frames_v());
			if let Some(fm) = &fmaps {
				mf.set("forever", fm.frames_v());
			}
			pretty(&V::Obj(mf))
		}),
		("factions".into(), serialize_table(&factions)),
		("instances".into(), serialize_table(&instances)),
	];
	if let Some(r) = &races {
		files.push(("races".into(), serialize_table(r)));
	}
	if let Some(h) = &heights {
		files.push(("spawnz".into(), h.text.clone()));
	}
	if let Some(t) = &training_doc {
		files.push(("training".into(), pretty(t)));
	}
	if let Some(k) = &kb {
		if !k.mechanics.keys().is_empty() {
			let table = serialize_table(&k.mechanics);
			files.push(("mechanics".into(), format!("{{\"schema\":1,\"sources\":{},\"quests\":{}}}\n", stringify(&arr(vec![crate::kb::mechanics_source()]), None), table.trim_end())));
		}
		if let Some(t) = &k.trainers {
			let same = trainers_doc.as_ref().is_some_and(|d| stringify(d, None) == stringify(t, None));
			if !same {
				files.push(("trainers".into(), pretty(t)));
			}
		}
	}
	let fobj = Obj::new();
	for (n, t) in &files {
		fobj.set(&format!("{n}.json"), t.len());
	}

	let counts = Obj::new();
	let c = |k: &str, v: V| counts.set(k, v);
	let n = |x: usize| V::Num(x as f64);
	c("quests", n(norm.quests.len()));
	c("npcs", n(norm.npcs.len()));
	c("objects", n(norm.objects.len()));
	c("items", n(norm.items.len()));
	c("zones", n(zones.len()));
	c("mapFrames", n(maps.frames.len()));
	if let Some(fm) = &fmaps {
		c("foreverMapFrames", n(fm.frames.len()));
	}
	c("factions", n(factions.len()));
	if let Some(r) = &races {
		c("races", n(r.len()));
	}
	if fwago.as_ref().is_some_and(|f| f.get("ItemSparse").is_some()) {
		c("timedItems", n(durations));
	}
	if let Some(h) = &heights {
		c("spawnHeightNpcs", n(h.npc.len()));
		c("spawnHeightObjects", n(h.object.len()));
	}
	c("recorderOnlyFactions", n(rec.recorder_only_factions));
	c("eraSpawnPoints", n(count_points(&norm.npcs, "e") + count_points(&norm.objects, "e")));
	c("liveSpawnPoints", n(count_points(&norm.npcs, "l") + count_points(&norm.objects, "l")));
	c("unmappedSpawnPoints", n(norm.stats.unmapped_points));
	c("untitledQuestsSkipped", n(norm.stats.skipped_quests));
	c("recordings", n(rec.recordings));
	c("recordingEvents", n(rec.events));
	c("recordedQuests", n(rec.touched_quests));
	c("recorderOnlyQuests", n(rec.recorder_only_quests));
	c("recordedKills", n(rec.recorded_kills));
	c("recordedLoots", n(rec.recorded_loots));
	c("recordedSightings", n(rec.recorded_sightings));
	c("recordedDropChances", n(rec.recorded_drop_chances));
	c("recordedTreasures", n(rec.recorded_treasures));
	c("recordedInstances", n(rec.recorded_instances));
	c("recordedEncounters", n(rec.recorded_encounters));
	c("spawnCap", n(o.cap));
	c("correctionsPrivate", n(private_applied));
	if let Some(q) = &qstats {
		c("questieQuests", n(q.questie_quests));
		c("questieOnlyQuests", n(q.questie_only_quests));
		c("questieNpcs", n(q.questie_npcs));
		c("questieOnlyNpcs", n(q.questie_only_npcs));
		c("questieObjects", n(q.questie_objects));
		c("questieOnlyObjects", n(q.questie_only_objects));
		c("questieItems", n(q.questie_items));
		c("questieOnlyItems", n(q.questie_only_items));
		c("unmappedQuestiePoints", n(q.unmapped_questie_points));
		c("questsWithXp", n(norm.quests.values().iter().filter(|q| q.get("xp").as_num().is_some_and(f64::is_finite)).count()));
		c("questXpFromQuestie", n(q.quest_xp));
		c("questXpFromWeb", n(webxp.as_ref().map_or(0, |w| w.xp.len())));
		c("questXpFromWebZones", n(wh.as_ref().map_or(0, |w| w.3)));
		c("webZonesChanged", wh.as_ref().map(|w| extras::changed_v(&w.1)).unwrap_or(V::Null));
		c("webZonesFacts", n(wh.as_ref().map_or(0, |w| w.2)));
		c("prereqsCleaned", n(q.prereqs_cleaned));
		c("reverseLinks", n(q.reverse_links));
		c("itemsRegainedEntries", n(q.items_regained_entries));
		{
			c("dropRatesMixedAvoided", n(q.drop_rates_mixed_avoided.unwrap_or(0)));
		}
		c("npcsRegainedRoles", n(q.npcs_regained_roles));
		c("questsRegainedGivers", n(q.quests_regained_givers));
		c("objectiveCountsFromClassicDb", n(q.objective_counts_from_classic_db));
		c("corrections", n(q.corrections));
	} else {
		c("corrections", n(applied.records));
	}
	if applied.created > 0 {
		c("correctionsCreated", n(applied.created));
	}
	if let Some(k) = &kb {
		c(
			"knowledgeBase",
			obj_of(vec![("changes", n(k.changes)), ("byClass", k.report.get("byClass")), ("tdb", k.report.get("tdb")), ("eg", k.report.get("eg")), ("mechanics", k.report.get("mechanics"))]),
		);
	}
	let meta = Obj::new();
	meta.set("builtAt", o.built_at.as_str());
	meta.set("sources", arr(sources));
	meta.set("counts", counts);
	let mut lf = changed.clone();
	lf.sort();
	meta.set("liveFrameMaps", arr(lf.iter().map(|&x| V::Num(x as f64)).collect()));
	if let Some(q) = &qstats {
		let cf = Obj::new();
		for (k, v) in &q.changed_quests {
			cf.set(k, *v);
		}
		meta.set("questie", obj_of(vec![("notInStore", arr(q.removed_quests.iter().map(|&x| V::Num(x)).collect())), ("changedFields", V::Obj(cf))]));
	}
	meta.set("files", fobj);
	meta.set("warnings", arr(warnings.iter().map(|w| s(w)).collect()));
	files.push(("meta".into(), pretty(&V::Obj(meta.clone()))));
	lap("serialize");

	let total: usize = files.iter().filter(|(n, _)| n != "meta").map(|(_, t)| t.len()).sum();
	let mut summary = format!(
		"{} quests, {} npcs, {} objects, {} items, {} zones, {} map frames, {} factions, {} recordings ({} MiB)",
		norm.quests.len(),
		norm.npcs.len(),
		norm.objects.len(),
		norm.items.len(),
		zones.len(),
		maps.frames.len(),
		factions.len(),
		rec.recordings,
		forge_guide::js::to_fixed(total as f64 / 1048576.0, 1)
	);
	if let Some(q) = &qstats {
		let with_xp = norm.quests.values().iter().filter(|q| q.get("xp").as_num().is_some_and(f64::is_finite)).count();
		summary.push_str(&format!("; QuestieDB: {} quests ({} Forever-only), {with_xp} with xp", q.questie_quests, q.questie_only_quests));
	}
	let mut stale = Vec::new();
	if heights.is_none() {
		stale.push("spawnz");
	}
	if training_doc.is_none() {
		stale.push("training");
	}
	Ok(Output { files, meta: V::Obj(meta), warnings, summary, stale, corrections: applied.entries })
}

/// Writes the output files (`<name>.json`, each atomically); removes an older spawnz.json when
/// this build has none.
pub fn write(out_dir: &Path, out: &Output) -> Result<(), String> {
	std::fs::create_dir_all(out_dir).map_err(|e| format!("{}: {e}", out_dir.display()))?;
	for (name, text) in &out.files {
		let file = out_dir.join(format!("{name}.json"));
		let tmp = out_dir.join(format!("{name}.json.tmp"));
		std::fs::write(&tmp, text).map_err(|e| format!("{}: {e}", tmp.display()))?;
		std::fs::rename(&tmp, &file).map_err(|e| format!("{}: {e}", file.display()))?;
	}
	for name in &out.stale {
		let _ = std::fs::remove_file(out_dir.join(format!("{name}.json")));
	}
	Ok(())
}
