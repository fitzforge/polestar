//! AtlasLoot Classic (GPL-2.0), the Codex's `--local-extras` input (port of
//! the JS importer it replaced): who drops what, collections, crafting, reputation and PvP rewards,
//! as the Forever build of the addon ships them. Reads the installed loot modules (only the files each
//! module's `<Module>_Forever.toc` loads), the drop rates and two core data files the modules lean on
//! (Data/Profession.lua, Data/Requirements.lua). forever.lua (outside the TOC) only adds instances
//! data.lua lacks and marks the ones it defines as Forever content. Facts only: ids, names, levels,
//! rates. Every run treats the client as Classic and reads both faction difficulties.
//!
//! Output (JS shapes, read by the Codex merge):
//!   meta        { source, version, licence, modules, files, warnings }
//!   instances   [{ key, name, kind, forever, areaId, levels, phase, bosses: [{ name, npc, object?, items }] }]
//!   droprates   { "<npcId>": { "<itemId>": percent } }
//!   collections [{ group, groupName, section, item, faction }]
//!   sets        [{ group, groupName, section, set, faction }]
//!   crafting    [{ profession, item, spell, skill, group }]
//!   factions    [{ factionId, name, rewards: [{ item, standing, faction? }] }]
//!   pvp         [{ group, groupName, section, item, faction, rank, honor }]

use std::path::{Path, PathBuf};

use forge_guide::js::{num_str, Obj, V};
use indexmap::IndexMap;

use crate::gear::addonlua::{lua_quote, read_addon_lua_with};
use crate::jsv::arr;

const CORE: &str = "AtlasLootClassic";
const MODULES: [&str; 5] = ["DungeonsAndRaids", "Collections", "Crafting", "Factions", "PvP"];
const PRELUDE: &str = include_str!("atlasloot.lua");
const EXTRA_CRAFTING: &str = include_str!("atlasloot_crafting.lua");
const EXTRA_PVP: &str = include_str!("atlasloot_pvp.lua");
const FOREVER_STORE: &str = "POLESTAR_forever";

fn core_files(module: &str) -> &'static [&'static str] {
	match module {
		"Crafting" => &["Data/Profession.lua"],
		"PvP" => &["Data/Requirements.lua"],
		_ => &[],
	}
}

fn standing_of(label: &str) -> Option<f64> {
	Some(match label {
		"hated" => 1.0,
		"hostile" => 2.0,
		"unfriendly" => 3.0,
		"neutral" => 4.0,
		"friendly" => 5.0,
		"honored" => 6.0,
		"revered" => 7.0,
		"exalted" => 8.0,
		_ => return None,
	})
}

fn list(v: &V) -> Vec<V> {
	if v.is_arr() {
		v.items()
	} else {
		Vec::new()
	}
}

fn num(v: &V) -> Option<f64> {
	v.as_num()
}

/// `a ?? b` over JS values (null and undefined fall through).
fn or(a: V, b: impl FnOnce() -> V) -> V {
	if a.is_nullish() {
		b()
	} else {
		a
	}
}

/// "<name>.toc" lines that are files, in order (comments and directives skipped).
fn toc_files(dir: &Path, folder: &str) -> (Option<String>, Vec<String>) {
	let forever = dir.join(format!("{folder}_Forever.toc"));
	let toc = if forever.exists() { forever } else { dir.join(format!("{folder}.toc")) };
	let Ok(bytes) = std::fs::read(&toc) else { return (None, Vec::new()) };
	let text = String::from_utf8_lossy(&bytes);
	let files = text.split('\n').map(|l| forge_guide::lexer::js_trim(l.strip_suffix('\r').unwrap_or(l))).filter(|l| !l.is_empty() && !l.starts_with('#')).map(|l| l.replace('\\', "/")).collect();
	(toc.file_name().map(|n| n.to_string_lossy().into_owned()), files)
}

/// Display text without colour codes, textures or atlas markup.
pub fn clean_text(v: &V) -> Option<String> {
	let s = v.as_str()?;
	let re = |p: &str| regex::Regex::new(p).unwrap();
	let out = re(r"\|c[0-9a-fA-F]{8}").replace_all(s, "");
	let out = out.replace("|r", "");
	let out = re(r"\|T[^|]*\|t").replace_all(&out, "");
	let out = re(r"\|A[^|]*\|a").replace_all(&out, "");
	let out = re(r"\s+").replace_all(&out, " ");
	let out = forge_guide::lexer::js_trim(&out);
	(!out.is_empty()).then(|| out.to_string())
}

/// "TheTempleOfAtal'Hakkar" -> "The Temple Of Atal'Hakkar"
pub fn key_name(key: &str) -> String {
	let a = regex::Regex::new(r"([a-z])([A-Z])").unwrap().replace_all(key, "$1 $2");
	let b = regex::Regex::new(r"([A-Z]+)([A-Z][a-z])").unwrap().replace_all(&a, "$1 $2");
	forge_guide::lexer::js_trim(&b).to_string()
}

fn marker() -> regex::Regex {
	regex::Regex::new(r"\{(area|faction|spell):(\d+)\}").unwrap()
}

/// A content's or section's name; one built from a client-only lookup falls back to `fallback`.
fn display_name(raw: &V, fallback: String) -> String {
	match clean_text(raw) {
		Some(t) if !marker().is_match(&t) => t,
		_ => fallback,
	}
}

fn section_name(raw: &V) -> V {
	let Some(text) = clean_text(raw) else { return V::Null };
	let s = marker().replace_all(&text, "");
	let s = regex::Regex::new(r"\s+").unwrap().replace_all(&s, " ");
	let s = regex::Regex::new(r"^[\s:-]+|[\s:-]+$").unwrap().replace_all(&s, "");
	if s.is_empty() {
		V::Null
	} else {
		V::str(&s)
	}
}

fn parse_price(v: &V) -> V {
	match v {
		V::Num(_) => v.clone(),
		_ => match v.as_str() {
			Some(s) => match s.strip_prefix("money:").filter(|d| !d.is_empty() && d.bytes().all(|b| b.is_ascii_digit())) {
				Some(d) => V::Num(forge_guide::js::str_to_num(d)),
				None => v.clone(),
			},
			None => V::Null,
		},
	}
}

struct Store {
	contents: Vec<V>,
	diffs: Vec<V>,
	ttypes: Vec<V>,
}

/// An empty Lua table reaches JSON as {}: lists back to arrays.
fn norm_store(store: &V) -> Option<Store> {
	if !store.truthy() {
		return None;
	}
	let contents = list(&store.get("contents"))
		.into_iter()
		.map(|c| {
			let c = V::Obj(c.as_obj().map(Obj::spread).unwrap_or_default());
			let bosses: Vec<V> = list(&c.get("bosses"))
				.into_iter()
				.map(|b| {
					let b = V::Obj(b.as_obj().map(Obj::spread).unwrap_or_default());
					let diffs: Vec<V> = list(&b.get("diffs"))
						.into_iter()
						.map(|d| {
							let d = V::Obj(d.as_obj().map(Obj::spread).unwrap_or_default());
							d.set("rows", arr(list(&d.get("rows"))));
							d
						})
						.collect();
					b.set("diffs", arr(diffs));
					b
				})
				.collect();
			c.set("bosses", arr(bosses));
			c
		})
		.collect();
	Some(Store { contents, diffs: list(&store.get("diffs")), ttypes: list(&store.get("ttypes")) })
}

/// Diff index -> Some('A' | 'H') | None, from the difficulty's unique name.
fn diff_sides(diffs: &[V]) -> Vec<Option<&'static str>> {
	diffs
		.iter()
		.map(|d| match d.get("unique").as_str() {
			Some("alliance") => Some("A"),
			Some("horde") => Some("H"),
			_ => None,
		})
		.collect()
}

/// The rows a difficulty shows: its own, plus those it inherits through GetItemsFromDiff for the
/// positions it does not occupy.
fn diff_rows(boss: &V, diff: &V, seen: &mut Vec<String>) -> Vec<V> {
	let from = diff.get("from");
	let d = diff.get("d").to_js_string();
	if from.is_nullish() || seen.contains(&d) {
		return list(&diff.get("rows"));
	}
	seen.push(d);
	let Some(source) = list(&boss.get("diffs")).into_iter().find(|x| x.get("d").strict_eq(&from)) else { return list(&diff.get("rows")) };
	let own = list(&diff.get("rows"));
	let taken: Vec<V> = own.iter().map(|r| r.get("p")).collect();
	let mut out = own;
	out.extend(diff_rows(boss, &source, seen).into_iter().filter(|r| !taken.iter().any(|t| t.strict_eq(&r.get("p")))));
	out
}

fn table_type(store: &Store, content: &V, boss: &V, diff: &V) -> String {
	let idx = or(diff.get("tt"), || or(boss.get("tt"), || or(content.get("itt"), || or(content.get("tt"), || V::Num(1.0)))));
	let i = idx.num() - 1.0;
	if i >= 0.0 && i.fract() == 0.0 {
		if let Some(t) = store.ttypes.get(i as usize).filter(|t| t.truthy()) {
			return t.to_js_string();
		}
	}
	"Item".into()
}

/// Every reward a row stands for: (id, side).
fn row_ids(row: &V, side: Option<&'static str>) -> Vec<(f64, Option<&'static str>)> {
	let mut out = Vec::new();
	let pos = |k: &str| num(&row.get(k)).filter(|n| *n > 0.0);
	if let Some(h) = pos("h") {
		out.push((h, Some("H")));
	}
	if let Some(a) = pos("a") {
		out.push((a, Some("A")));
	}
	let own = if matches!(row.get("h"), V::Bool(true)) {
		Some("H")
	} else if matches!(row.get("a"), V::Bool(true)) {
		Some("A")
	} else {
		side
	};
	if let Some(c2) = pos("c2") {
		out.push((c2, own));
	}
	if row.get("c2").is_num() {
		if let Some(c3) = pos("c3") {
			out.push((c3, own));
		}
	}
	out
}

struct Reward<'a> {
	id: f64,
	side: Option<&'static str>,
	row: &'a V,
	kind: &'a str,
	rep: Option<(f64, f64)>,
}

/// Walks one boss/section: `f` per reward of a table type in `kinds`, with the latest
/// "f<id>rep<n>" header as `rep`.
fn each_reward(store: &Store, content: &V, boss: &V, kinds: &[&str], f: &mut dyn FnMut(Reward)) {
	let sides = diff_sides(&store.diffs);
	let header = regex::Regex::new(r"^f(\d+)rep(\d)$").unwrap();
	for diff in list(&boss.get("diffs")) {
		let kind = table_type(store, content, boss, &diff);
		if !kinds.contains(&kind.as_str()) {
			continue;
		}
		let d = diff.get("d").num();
		let side = if d >= 1.0 && d.fract() == 0.0 { sides.get(d as usize - 1).copied().flatten() } else { None };
		let mut rep = None;
		let mut rows = diff_rows(boss, &diff, &mut Vec::new());
		let pkey = |r: &V| num(&r.get("p")).unwrap_or(0.0);
		rows.sort_by(|a, b| (pkey(a) - pkey(b)).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal));
		for row in &rows {
			if let Some(s) = row.get("c2").as_str() {
				if let Some(m) = header.captures(s) {
					rep = Some((forge_guide::js::str_to_num(&m[1]), forge_guide::js::str_to_num(&m[2])));
				}
				continue;
			}
			for (id, side) in row_ids(row, side) {
				f(Reward { id, side, row, kind: &kind, rep });
			}
		}
	}
}

/// Sides of one id seen several times: both factions (or a neutral sighting) -> none.
#[derive(Default)]
struct SideSet {
	map: IndexMap<u64, (f64, Option<&'static str>, Vec<(&'static str, V)>)>,
}

impl SideSet {
	fn add(&mut self, id: f64, side: Option<&'static str>, extra: Vec<(&'static str, V)>) {
		match self.map.get_mut(&id.to_bits()) {
			None => {
				self.map.insert(id.to_bits(), (id, side, extra));
			}
			Some(cur) => {
				if cur.1 != side {
					cur.1 = None;
				}
				for (k, v) in extra {
					if let Some(e) = cur.2.iter_mut().find(|e| e.0 == k) {
						if e.1.is_nullish() && !v.is_nullish() {
							e.1 = v;
						}
					} else {
						cur.2.push((k, v));
					}
				}
			}
		}
	}
}

fn side_v(s: Option<&str>) -> V {
	s.map(V::str).unwrap_or(V::Null)
}

fn skip_version(content: &V) -> bool {
	num(&content.get("gv")).is_some_and(|g| g > 1.0)
}

fn build_instances(store: &Store, forever_keys: &[String], droprates: &V) -> Vec<V> {
	let placeholder = regex::Regex::new(r"(?i)^loot will be updated").unwrap();
	let mut out = Vec::new();
	for content in &store.contents {
		if skip_version(content) {
			continue;
		}
		let mut bosses = Vec::new();
		for boss in list(&content.get("bosses")) {
			if boss.get("ignore").truthy() {
				continue;
			}
			let mut set = SideSet::default();
			each_reward(store, content, &boss, &["Item", "Profession"], &mut |r| {
				if r.kind != "Item" {
					return;
				}
				let quest = r.row.get("Quest");
				let price = r.row.get("Price");
				set.add(r.id, r.side, vec![("quest", if quest.is_num() { quest } else { V::Undef }), ("price", if price.is_nullish() { V::Undef } else { parse_price(&price) })]);
			});
			let items: Vec<V> = set
				.map
				.values()
				.map(|(item, side, extra)| {
					let rec = Obj::new();
					rec.set("item", *item);
					if let Some(s) = side {
						rec.set("faction", *s);
					}
					for (k, v) in extra {
						if !v.is_nullish() {
							rec.set(k, v.clone());
						}
					}
					for npc in list(&boss.get("npc")) {
						let rate = droprates.get(&npc.to_js_string()).get(&num_str(*item));
						if !rate.is_nullish() {
							rec.set("chance", rate);
							break;
						}
					}
					V::Obj(rec)
				})
				.collect();
			let name = clean_text(&boss.get("name"));
			if items.is_empty() && !boss.get("npc").truthy() && !boss.get("object").truthy() {
				// Set / icon lists and Forever's "loot will be updated" notice stand where a boss would.
				let lists = list(&boss.get("diffs")).iter().any(|d| table_type(store, content, &boss, d) == "Item");
				if !lists || placeholder.is_match(name.as_deref().unwrap_or("")) {
					continue;
				}
			}
			let b = Obj::new();
			b.set("name", name.map(|n| V::str(&n)).unwrap_or(V::Null));
			b.set("npc", if boss.get("npc").truthy() { boss.get("npc") } else { V::Null });
			if boss.get("object").truthy() {
				b.set("object", boss.get("object"));
			}
			b.set("items", arr(items));
			bosses.push(V::Obj(b));
		}
		let key = content.get("key").to_js_string();
		let ctype = content.get("ctype").as_str().unwrap_or("").to_string();
		let o = Obj::new();
		o.set("key", key.as_str());
		o.set("name", display_name(&content.get("name"), key_name(&key)));
		o.set(
			"kind",
			if key == "WorldBosses" {
				"world"
			} else if ctype.to_lowercase().contains("raid") {
				"raid"
			} else {
				"dungeon"
			},
		);
		o.set("forever", ctype.starts_with("Forever ") || forever_keys.contains(&key));
		o.set("areaId", if content.get("areaId").is_num() { content.get("areaId") } else { V::Null });
		let levels = content.get("levels");
		o.set("levels", if levels.is_arr() && levels.items().iter().all(V::is_num) { levels } else { V::Null });
		o.set("phase", if content.get("phase").is_num() { content.get("phase") } else { V::Null });
		o.set("bosses", arr(bosses));
		out.push(V::Obj(o));
	}
	out
}

/// Generic list modules (Collections, PvP): one row per reward and section.
fn build_list(store: &Store, extra_for: Option<&dyn Fn(f64) -> Vec<(&'static str, V)>>) -> Vec<V> {
	let mut out = Vec::new();
	for content in &store.contents {
		if skip_version(content) {
			continue;
		}
		let key = content.get("key").to_js_string();
		let group_name = display_name(&content.get("name"), key_name(&key));
		for boss in list(&content.get("bosses")) {
			let mut set = SideSet::default();
			each_reward(store, content, &boss, &["Item", "Profession"], &mut |r| {
				if r.kind == "Item" {
					set.add(r.id, r.side, Vec::new());
				}
			});
			let section = section_name(&boss.get("name"));
			for (item, side, _) in set.map.values() {
				let o = Obj::new();
				o.set("group", key.as_str());
				o.set("groupName", group_name.as_str());
				o.set("section", section.clone());
				o.set("item", *item);
				o.set("faction", side_v(*side));
				if let Some(f) = extra_for {
					for (k, v) in f(*item) {
						o.set(k, v);
					}
				}
				out.push(V::Obj(o));
			}
		}
	}
	out
}

/// "Set" tables (Collections, PvP): ItemSet ids, one row per set and section.
fn build_sets(store: &Store) -> Vec<V> {
	let mut out = Vec::new();
	for content in &store.contents {
		if skip_version(content) {
			continue;
		}
		let key = content.get("key").to_js_string();
		let group_name = display_name(&content.get("name"), key_name(&key));
		for boss in list(&content.get("bosses")) {
			let mut set = SideSet::default();
			each_reward(store, content, &boss, &["Set"], &mut |r| set.add(r.id, r.side, Vec::new()));
			let section = section_name(&boss.get("name"));
			for (id, side, _) in set.map.values() {
				let o = Obj::new();
				o.set("group", key.as_str());
				o.set("groupName", group_name.as_str());
				o.set("section", section.clone());
				o.set("set", *id);
				o.set("faction", side_v(*side));
				out.push(V::Obj(o));
			}
		}
	}
	out
}

fn build_crafting(store: &Store, professions: &V) -> Vec<V> {
	let mut out = Vec::new();
	for content in &store.contents {
		if skip_version(content) {
			continue;
		}
		let key = content.get("key").to_js_string();
		let profession = display_name(&content.get("name"), key_name(&key));
		for boss in list(&content.get("bosses")) {
			let group = section_name(&boss.get("name"));
			let mut seen: Vec<String> = Vec::new();
			each_reward(store, content, &boss, &["Item", "Profession"], &mut |r| {
				let k = format!("{}:{}", r.kind, num_str(r.id));
				if seen.contains(&k) {
					return;
				}
				seen.push(k);
				let o = Obj::new();
				o.set("profession", profession.as_str());
				if r.kind == "Profession" {
					let p = professions.get(&num_str(r.id));
					o.set("item", if p.truthy() && p.get("item").truthy() { p.get("item") } else { V::Null });
					o.set("spell", r.id);
					o.set("skill", if p.truthy() && p.get("skill").truthy() { p.get("skill") } else { V::Null });
				} else {
					o.set("item", r.id);
					o.set("spell", V::Null);
					o.set("skill", V::Null);
				}
				o.set("group", group.clone());
				out.push(V::Obj(o));
			});
		}
	}
	out
}

struct FactionRec {
	faction_id: V,
	name: V,
	rewards: Vec<Obj>,
	seen: Vec<(u64, Obj)>,
}

/// Rewards behind "f<id>rep<n>" headers in any module, plus the Factions module's sections.
fn collect_factions(stores: &[(Store, bool)]) -> Vec<FactionRec> {
	let mut factions: IndexMap<String, FactionRec> = IndexMap::new();
	for (store, is_factions) in stores {
		for content in &store.contents {
			if skip_version(content) {
				continue;
			}
			let key = content.get("key").to_js_string();
			let cfid = content.get("factionId");
			for boss in list(&content.get("bosses")) {
				let label = clean_text(&boss.get("name")).unwrap_or_default().to_lowercase();
				each_reward(store, content, &boss, &["Item", "Profession"], &mut |r| {
					if r.kind != "Item" {
						return;
					}
					let (faction_id, standing) = match r.rep {
						Some((f, s)) => (V::Num(f), s),
						None => {
							if !is_factions {
								return;
							}
							let Some(s) = standing_of(&label) else { return };
							(if cfid.is_num() { cfid.clone() } else { V::Null }, s)
						}
					};
					let fkey = if faction_id.is_nullish() { format!("key:{key}") } else { format!("id:{}", faction_id.to_js_string()) };
					let same = cfid.strict_eq(&faction_id);
					match factions.get_mut(&fkey) {
						None => {
							let named = *is_factions && (faction_id.is_nullish() || same);
							factions.insert(
								fkey.clone(),
								FactionRec {
									faction_id: faction_id.clone(),
									name: if named { V::str(&display_name(&content.get("name"), key_name(&key))) } else { V::Null },
									rewards: Vec::new(),
									seen: Vec::new(),
								},
							);
						}
						Some(rec) => {
							if !rec.name.truthy() && *is_factions && same {
								rec.name = V::str(&display_name(&content.get("name"), key_name(&key)));
							}
						}
					}
					let rec = factions.get_mut(&fkey).unwrap();
					if let Some((_, prev)) = rec.seen.iter().find(|(id, _)| *id == r.id.to_bits()) {
						if !prev.get("faction").strict_eq(&side_v(r.side)) {
							prev.delete("faction");
						}
						if standing < prev.get("standing").num() {
							prev.set("standing", standing);
						}
						return;
					}
					let reward = Obj::new();
					reward.set("item", r.id);
					reward.set("standing", standing);
					if let Some(s) = r.side {
						reward.set("faction", s);
					}
					rec.seen.push((r.id.to_bits(), reward.clone()));
					rec.rewards.push(reward);
				});
			}
		}
	}
	factions.into_values().collect()
}

fn rel(dir: &Path, f: &Path) -> String {
	f.strip_prefix(dir).map(|p| p.to_string_lossy().replace('\\', "/")).unwrap_or_else(|_| f.to_string_lossy().into_owned())
}

fn read_module(dir: &Path, core_dir: &Path, module: &str) -> Result<(V, Vec<PathBuf>, Vec<String>), String> {
	let folder = format!("{CORE}_{module}");
	let mod_dir = dir.join(&folder);
	let (toc, files) = toc_files(&mod_dir, &folder);
	let lua_files: Vec<PathBuf> = files.iter().filter(|f| f.to_lowercase().ends_with(".lua")).map(|f| mod_dir.join(f)).collect();
	let mut warnings = Vec::new();
	let mut core = Vec::new();
	for f in core_files(module) {
		let p = core_dir.join(f);
		if p.exists() {
			core.push(p);
		} else {
			warnings.push(format!("{CORE}/{f} missing: {module} rows lack its facts"));
		}
	}
	let mut extra_files = Vec::new();
	if module == "DungeonsAndRaids" {
		let forever = mod_dir.join("forever.lua");
		if forever.exists() && !lua_files.contains(&forever) {
			extra_files.push(forever);
		}
	}
	for f in &lua_files {
		if !f.exists() {
			warnings.push(format!("{folder}/{} listed in {} but missing", rel(&mod_dir, f), toc.as_deref().unwrap_or("null")));
		}
	}
	let extra_lua = match module {
		"Crafting" => EXTRA_CRAFTING,
		"PvP" => EXTRA_PVP,
		_ => "",
	};
	let expr = format!(
		"return {{\n  stores = {{ [{0}] = POLESTAR_dumpStore({0}), [{1}] = POLESTAR_dumpStore({1}) }},\n  droprates = POLESTAR_dumpDroprates(),\n  extra = POLESTAR_extra and POLESTAR_extra() or nil,\n}}",
		lua_quote(&folder),
		lua_quote(FOREVER_STORE)
	);
	let add_re = regex::bytes::Regex::new(r"ItemDB:Add\(\s*addonname").unwrap();
	let band_re = regex::bytes::Regex::new(r"\bbit\.band\b").unwrap();
	let run = |extra: &[PathBuf]| -> Result<(V, Vec<PathBuf>), String> {
		let mut all: Vec<PathBuf> = core.clone();
		all.extend(lua_files.iter().filter(|f| f.exists()).cloned());
		all.extend(extra.iter().cloned());
		let prelude = format!("{PRELUDE}{extra_lua}");
		let v = read_addon_lua_with(&all, &folder, &prelude, &expr, &|src, file| {
			let mut out = b"local _G = POLESTAR_G; ".to_vec();
			out.extend_from_slice(&src);
			if extra.iter().any(|e| e == file) {
				let replaced = add_re.replace_all(&out, format!("ItemDB:Add(\"{FOREVER_STORE}\"").as_bytes()).into_owned();
				out = b"local LTNX = \"\"; ".to_vec();
				out.extend_from_slice(&replaced);
			}
			if file.file_name().is_some_and(|n| n == "Requirements.lua") {
				out = band_re.replace_all(&out, &b"POLESTAR_band"[..]).into_owned();
			}
			out
		})?;
		Ok((v, all))
	};
	let (v, all) = match run(&extra_files) {
		Ok(r) => r,
		Err(e) => {
			// forever.lua is outside the TOC: a file that no longer loads costs only its gap-filling.
			if extra_files.is_empty() || !extra_files.iter().any(|f| e.contains(&*f.to_string_lossy())) {
				return Err(e);
			}
			let first = e.split('\n').next().unwrap_or("");
			let tail: String = {
				let u: Vec<u16> = first.encode_utf16().collect();
				String::from_utf16_lossy(&u[u.len().saturating_sub(160)..])
			};
			warnings.push(format!("{folder}/forever.lua did not load ({tail}); using the TOC files only"));
			run(&[])?
		}
	};
	Ok((v, all, warnings))
}

/// readAtlasLoot(dir): the AddOns folder holding AtlasLootClassic and its modules.
pub fn read_atlasloot(dir: &Path) -> Result<V, String> {
	let meta = Obj::new();
	meta.set("source", "AtlasLootClassic");
	meta.set("version", V::Null);
	meta.set("licence", "GPL-2.0");
	let (mut modules, mut files, mut warnings) = (Vec::new(), Vec::new(), Vec::new());
	let out = Obj::new();
	let (mut instances, droprates, mut collections, mut sets, mut crafting, mut pvp) = (Vec::new(), Obj::new(), Vec::new(), Vec::new(), Vec::new(), Vec::new());
	let finish = |meta: &Obj, modules: Vec<V>, files: Vec<V>, warnings: Vec<String>| {
		meta.set("modules", arr(modules));
		meta.set("files", arr(files));
		meta.set("warnings", arr(warnings.iter().map(|w| V::str(w)).collect()));
	};
	if !dir.is_dir() {
		warnings.push(format!("AddOns folder not found: {}", dir.display()));
		finish(&meta, modules, files, warnings);
		out.set("meta", V::Obj(meta));
		for k in ["instances", "collections", "sets", "crafting", "factions", "pvp"] {
			out.set(k, V::arr());
		}
		out.set("droprates", V::obj());
		return Ok(V::Obj(out));
	}
	let core_dir = dir.join(CORE);
	let toc = core_dir.join(format!("{CORE}_Forever.toc"));
	let mut version = if toc.exists() { crate::gear::addonlua::addon_version_in(&core_dir, &format!("{CORE}_Forever.toc")) } else { crate::gear::addonlua::addon_version(&core_dir) };
	let mut faction_stores: Vec<(Store, bool)> = Vec::new();
	for module in MODULES {
		let folder = format!("{CORE}_{module}");
		if !dir.join(&folder).exists() {
			warnings.push(format!("{folder} not installed"));
			continue;
		}
		let (res, all, w) = read_module(dir, &core_dir, module)?;
		warnings.extend(w);
		modules.push(V::str(module));
		files.extend(all.iter().map(|f| V::str(&rel(dir, f))));
		if version.is_none() {
			version = crate::gear::addonlua::addon_version(&dir.join(&folder));
		}
		let Some(store) = norm_store(&res.get("stores").get(&folder)) else {
			warnings.push(format!("{folder}: no loot tables registered"));
			continue;
		};
		let rates = res.get("droprates");
		match module {
			"DungeonsAndRaids" => {
				let forever = norm_store(&res.get("stores").get(FOREVER_STORE));
				let forever_keys: Vec<String> = forever.as_ref().map(|f| f.contents.iter().map(|c| c.get("key").to_js_string()).collect()).unwrap_or_default();
				instances.extend(build_instances(&store, &forever_keys, &rates));
				if let Some(f) = forever {
					// forever.lua predates data.lua's copy; it only fills gaps.
					let have: Vec<String> = store.contents.iter().map(|c| c.get("key").to_js_string()).collect();
					let extra = Store { contents: f.contents.into_iter().filter(|c| !have.contains(&c.get("key").to_js_string())).collect(), diffs: f.diffs, ttypes: f.ttypes };
					instances.extend(build_instances(&extra, &forever_keys, &rates));
				}
				for (k, v) in rates.entries() {
					droprates.set(&k, v);
				}
			}
			"Collections" => {
				collections.extend(build_list(&store, None));
				sets.extend(build_sets(&store));
			}
			"Crafting" => crafting.extend(build_crafting(&store, &or(res.get("extra"), V::obj))),
			"PvP" => {
				let ranks = or(res.get("extra"), V::obj);
				let extra = move |item: f64| {
					let r = ranks.get(&num_str(item));
					vec![("rank", if r.as_num().is_some_and(|n| n > 0.0) { r } else { V::Null }), ("honor", V::Null)]
				};
				pvp.extend(build_list(&store, Some(&extra)));
				sets.extend(build_sets(&store));
			}
			_ => {}
		}
		faction_stores.push((store, module == "Factions"));
	}
	let factions: Vec<V> = collect_factions(&faction_stores)
		.into_iter()
		.map(|f| {
			let o = Obj::new();
			o.set("factionId", f.faction_id);
			o.set("name", f.name);
			o.set("rewards", arr(f.rewards.into_iter().map(V::Obj).collect()));
			V::Obj(o)
		})
		.collect();
	meta.set("version", version.map(|v| V::str(&v)).unwrap_or(V::Null));
	finish(&meta, modules, files, warnings);
	out.set("meta", V::Obj(meta));
	out.set("instances", arr(instances));
	out.set("droprates", V::Obj(droprates));
	out.set("collections", arr(collections));
	out.set("sets", arr(sets));
	out.set("crafting", arr(crafting));
	out.set("factions", arr(factions));
	out.set("pvp", arr(pvp));
	Ok(V::Obj(out))
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn names_and_text() {
		assert_eq!(key_name("TheTempleOfAtal'Hakkar"), "The Temple Of Atal'Hakkar");
		assert_eq!(key_name("ZGBosses"), "ZG Bosses");
		assert_eq!(clean_text(&V::str("|cff00ff00Green|r  |TInterface\\Icon:0|tText ")).as_deref(), Some("Green Text"));
		assert_eq!(section_name(&V::str("{faction:72} - Exalted")).as_str(), Some("Exalted"));
		assert_eq!(display_name(&V::str("{area:1581}"), "Fallback".into()), "Fallback");
		assert_eq!(parse_price(&V::str("money:150")).num(), 150.0);
		assert_eq!(parse_price(&V::str("honor:5")).as_str(), Some("honor:5"));
	}
}
