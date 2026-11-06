//! The dungeon heads-up's table, addon/Polestar/Dungeons/OpensData.lua: what the heads-up (UI/DungeonToast.lua)
//! needs to tell a character a dungeon has opened, without loading the Codex pack (about 7 MB). Built from the
//! Codex's dungeon journal and quests (data/forever/codex) and data/forever's quests and NPCs, by `forge data
//! codex` after each build and by `forge data headsup` from a build on disk.
//!
//! Per dungeon (raids are left out): its name, level range, instance map, zone and zone name, and per side
//! ("A", "H") its page quests that side may take, as one string read only when the heads-up checks the dungeon
//! (Dungeons.Opens, Dungeons/Opens.lua, which counts them as Dungeons.PickupPlan does). A quest's side follows
//! Dungeons/Pickup.lua (#1027): the Codex quest's faction, else the quest database's (forge_data::questdb's
//! quest_faction over data/forever), else the page's, else that of the page quests it leads to (`closedBy`, the
//! page quests whose chain names it). The rest of PickupPlan's choices that do not depend on the character's
//! progress are made here, for each side: whether the quest has a giver outside of that side's to go to
//! (Dungeons.Giver), and its chain (Lookup.QuestChain with nothing done): a prerequisite the side can never take
//! means it is never picked up, one the race or class can't take keeps that race or class out (not one reached
//! through a `preAny`, which the game picks among those the character may take); the page quests before it that
//! are errands (Pickup.lua's `errand`, standing not counted) are done on the way, the other page quests before it
//! must be done first.
//!
//! Row: `id,minLevel,level,xp` then optional fields, each a letter and its value: `g0` (never picked up: no
//! giver for the side, or a chain the side can't take), `r`/`c` the quest's race and class masks, `R`/`C` its
//! chain's (every one of them must allow the character for it to be picked up), `x` its `closedBy`, `w` the page
//! quests that must be done first, `v` the errands done on the way (ids joined by `/`). Rows are joined by `;`.

use forge_guide::js::{num_str, V};
use rustc_hash::FxHashSet;

pub struct Inputs<'a> {
	/// data/forever/codex/journal.json
	pub journal: &'a V,
	/// data/forever/codex/{quests,npcs,objects}.json
	pub quests: &'a V,
	pub npcs: &'a V,
	pub objects: &'a V,
	/// data/forever/{quests,npcs}.json (the quest database's side)
	pub fv_quests: &'a V,
	pub fv_npcs: &'a V,
	/// The Codex's meta builtAt.
	pub built_at: &'a str,
}

const SIDES: [&str; 2] = ["A", "H"];
const CLASS_BIT: [(&str, u32); 9] = [("WARRIOR", 1), ("PALADIN", 2), ("HUNTER", 4), ("ROGUE", 8), ("PRIEST", 16), ("SHAMAN", 64), ("MAGE", 128), ("WARLOCK", 256), ("DRUID", 1024)];

fn ids(v: &V) -> Vec<f64> {
	if v.is_arr() {
		v.items().iter().filter(|x| x.is_num()).map(|x| x.num()).collect()
	} else {
		Vec::new()
	}
}

fn mask(v: &V) -> Option<f64> {
	v.as_num().filter(|m| *m > 0.0)
}

/// Both masks as one: a character must match each (None: no limit).
fn both(a: Option<f64>, b: Option<f64>) -> Option<f64> {
	match (a, b) {
		(Some(x), Some(y)) => {
			// Masks can hold bits above 2^32 (the high races); AND the low and high words.
			let (xl, xh) = ((x % 4294967296.0) as u64, (x / 4294967296.0).floor() as u64);
			let (yl, yh) = ((y % 4294967296.0) as u64, (y / 4294967296.0).floor() as u64);
			Some(((xh & yh) as f64) * 4294967296.0 + ((xl & yl) as f64))
		}
		(x, None) => x,
		(None, y) => y,
	}
}

struct Ctx<'a> {
	inp: &'a Inputs<'a>,
}

impl Ctx<'_> {
	fn quest(&self, id: f64) -> V {
		self.inp.quests.get(&num_str(id))
	}

	/// Lookup.QuestSide: the Codex quest's faction, else the quest database's (None without a Codex quest).
	fn quest_side(&self, id: f64) -> Option<String> {
		let rec = self.quest(id);
		if !rec.truthy() {
			return None;
		}
		if let Some(s) = rec.get("faction").as_str().filter(|s| !s.is_empty()) {
			return Some(s.to_string());
		}
		let fq = self.inp.fv_quests.get(&num_str(id));
		if !fq.truthy() {
			return None;
		}
		match crate::questdb::quest_faction(&fq, self.inp.fv_npcs) {
			crate::questdb::Val::Num(1.0) => Some("A".into()),
			crate::questdb::Val::Num(2.0) => Some("H".into()),
			_ => None,
		}
	}

	/// Lookup.SideOK
	fn side_ok(code: Option<&str>, side: &str) -> bool {
		match code {
			None | Some("AH") => true,
			Some(c) => c.contains(side),
		}
	}

	fn npc_side_ok(&self, id: f64, side: &str) -> bool {
		let npc = self.inp.npcs.get(&num_str(id));
		!npc.truthy() || Self::side_ok(npc.get("faction").as_str(), side)
	}

	fn spawned(v: &V) -> bool {
		v.truthy() && v.get("spawns").is_arr() && !v.get("spawns").is_empty()
	}

	/// Lookup.QuestEnd over a start or end ({ npc, object }): Some(hostile) for the giver it finds, None for none.
	fn quest_end(&self, ends: &V, side: &str) -> Option<bool> {
		if !ends.truthy() {
			return None;
		}
		let mut other = false;
		for id in ids(&ends.get("npc")) {
			if Self::spawned(&self.inp.npcs.get(&num_str(id))) {
				if self.npc_side_ok(id, side) {
					return Some(false);
				}
				other = true;
			}
		}
		for id in ids(&ends.get("object")) {
			if Self::spawned(&self.inp.objects.get(&num_str(id))) {
				return Some(false);
			}
		}
		other.then_some(true)
	}

	/// Dungeons.Giver: whether the side has a giver outside to go to.
	fn giver(&self, pq: &V, side: &str) -> bool {
		let s = pq.get("start");
		let kind = s.get("kind");
		if pq.get("startItem").truthy() || pq.get("inside").truthy() || kind.as_str() == Some("item") || s.get("inside").truthy() {
			return false;
		}
		let rec = self.quest(pq.get("id").num());
		let st = rec.get("start");
		if !ids(&st.get("item")).is_empty() {
			return false;
		}
		let located = !s.get("map").is_nullish() && !s.get("x").is_nullish() && !s.get("y").is_nullish();
		let page = matches!(kind.as_str(), Some("npc") | Some("object")) && s.get("id").truthy() && located && (kind.as_str() != Some("npc") || self.npc_side_ok(s.get("id").num(), side));
		let givers = if st.truthy() { ids(&st.get("npc")).len() + ids(&st.get("object")).len() } else { 0 };
		if page && givers <= 1 {
			return true;
		}
		if givers > 0 {
			match self.quest_end(&st, side) {
				Some(true) => return false,
				Some(false) => return true,
				None => {}
			}
		}
		page
	}

	/// Pickup.lua's errand, standing not counted: no objectives, given (not by an item) and turned in outside by
	/// an NPC or object the side may use.
	fn errand(&self, id: f64, side: &str) -> bool {
		let r = self.quest(id);
		if !r.truthy() || !r.get("objectives").is_empty() {
			return false;
		}
		let st = r.get("start");
		if !st.truthy() || !ids(&st.get("item")).is_empty() {
			return false;
		}
		self.quest_end(&st, side) == Some(false) && self.quest_end(&r.get("end"), side) == Some(false)
	}

	/// Lookup.QuestChain with nothing done: the quest's prerequisites, oldest first (the quest itself left out),
	/// each with whether it was reached through a `preAny`. Of a `preAny`, the first one the side may take: in
	/// the game the first one the character may take (race, class, level), so one reached that way never keeps
	/// the character out; with none open to the character there is none in the chain.
	fn chain(&self, id: f64, side: &str) -> Vec<(f64, bool)> {
		let mut order = Vec::new();
		let mut seen = FxHashSet::default();
		self.visit(id, side, false, &mut seen, &mut order);
		order.retain(|(x, _)| *x != id);
		order
	}

	fn visit(&self, id: f64, side: &str, any: bool, seen: &mut FxHashSet<u64>, order: &mut Vec<(f64, bool)>) {
		if !seen.insert(id.to_bits()) {
			return;
		}
		let q = self.quest(id);
		if !q.truthy() {
			return;
		}
		for p in ids(&q.get("pre")) {
			self.visit(p, side, any, seen, order);
		}
		for p in ids(&q.get("preAny")) {
			if self.quest(p).truthy() && Self::side_ok(self.quest_side(p).as_deref(), side) {
				self.visit(p, side, true, seen, order);
				break;
			}
		}
		order.push((id, any));
	}
}

fn page_classes(v: &V) -> Option<f64> {
	if !v.is_arr() || v.is_empty() {
		return None;
	}
	let m: u32 = v.items().iter().filter_map(|c| c.as_str()).filter_map(|c| CLASS_BIT.iter().find(|(k, _)| *k == c).map(|(_, b)| *b)).fold(0, |a, b| a | b);
	(m > 0).then_some(m as f64)
}

fn join(list: &[f64]) -> String {
	list.iter().map(|x| num_str(*x)).collect::<Vec<_>>().join("/")
}

fn lua_str(s: &str) -> String {
	format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\""))
}

fn num_or_0(v: &V) -> String {
	if v.is_num() {
		num_str(v.num())
	} else {
		"0".into()
	}
}

/// The rows of one page for one side.
fn rows(cx: &Ctx, page: &V, side: &str) -> String {
	let quests = page.get("quests").items();
	let on_page: FxHashSet<u64> = quests.iter().map(|q| q.get("id").num().to_bits()).collect();
	let page_quest = |id: f64| quests.iter().find(|q| q.get("id").num() == id).cloned();
	// Pickup.lua's ledSide: the side of the page quests a side-less one leads to, when they are all one side's.
	let led_side = |pq: &V| -> Option<String> {
		let me = pq.get("id").num();
		let mut side: Option<String> = None;
		let mut mixed = false;
		let mut by = |id: f64| {
			let s = cx.quest_side(id).or_else(|| page_quest(id).and_then(|q| q.get("faction").as_str().map(String::from)));
			if let Some(s) = s {
				if s == "AH" || side.as_ref().is_some_and(|x| *x != s) {
					mixed = true;
				}
				if !mixed {
					side = Some(s);
				}
			}
		};
		for id in ids(&pq.get("closedBy")) {
			by(id);
		}
		for q in &quests {
			if ids(&q.get("chain")).contains(&me) {
				by(q.get("id").num());
			}
		}
		if mixed {
			None
		} else {
			side
		}
	};
	let mut out = Vec::new();
	for pq in &quests {
		let id = pq.get("id").num();
		let rec = cx.quest(id);
		let own = cx.quest_side(id);
		if !Ctx::side_ok(own.as_deref(), side) {
			continue;
		}
		let s = own.or_else(|| pq.get("faction").as_str().map(String::from)).or_else(|| led_side(pq));
		if !Ctx::side_ok(s.as_deref(), side) {
			continue;
		}
		let min = if rec.get("minLevel").is_num() {
			rec.get("minLevel").num()
		} else if pq.get("minLevel").is_num() {
			pq.get("minLevel").num()
		} else {
			1.0
		};
		let mut row = format!("{},{},{},{}", num_str(id), num_str(min), num_or_0(&pq.get("level")), num_or_0(&pq.get("rewards").get("xp")));
		let races = mask(&rec.get("races"));
		let classes = both(mask(&rec.get("classes")), page_classes(&pq.get("classes")));
		let (mut take, mut cr, mut cc) = (cx.giver(pq, side), None, None);
		let (mut needs, mut via) = (Vec::new(), Vec::new());
		if take && rec.truthy() {
			for (r, any) in cx.chain(id, side) {
				let rq = cx.quest(r);
				if !Ctx::side_ok(cx.quest_side(r).as_deref(), side) {
					take = false;
				}
				if !any {
					cr = both(cr, mask(&rq.get("races")));
					cc = both(cc, mask(&rq.get("classes")));
				}
				if on_page.contains(&r.to_bits()) {
					if cx.errand(r, side) {
						via.push(r);
					} else {
						needs.push(r);
					}
				}
			}
		}
		if !take {
			row.push_str(",g0");
		}
		for (k, m) in [("r", races), ("c", classes)] {
			if let Some(m) = m {
				row.push_str(&format!(",{k}{}", num_str(m)));
			}
		}
		if take {
			for (k, m) in [("R", cr), ("C", cc)] {
				if let Some(m) = m {
					row.push_str(&format!(",{k}{}", num_str(m)));
				}
			}
		}
		let closed = ids(&pq.get("closedBy"));
		for (k, l) in [("x", &closed), ("w", &needs), ("v", &via)] {
			if !l.is_empty() && (k == "x" || take) {
				row.push_str(&format!(",{k}{}", join(l)));
			}
		}
		out.push(row);
	}
	out.join(";")
}

/// The Lua file and how many dungeons it holds.
pub fn emit(inp: &Inputs, source: &str) -> (String, usize) {
	let cx = Ctx { inp };
	let dungeons = inp.journal.get("dungeons");
	let mut keys: Vec<String> = dungeons.keys().iter().map(|k| k.to_string()).collect();
	keys.sort();
	let mut body = String::new();
	let mut n = 0;
	for key in keys {
		let p = dungeons.get(&key);
		if p.get("kind").as_str() != Some("dungeon") || !p.get("minLevel").is_num() {
			continue;
		}
		let (a, h) = (rows(&cx, &p, SIDES[0]), rows(&cx, &p, SIDES[1]));
		if a.is_empty() && h.is_empty() {
			continue;
		}
		n += 1;
		body.push_str(&format!(
			"\t[{}] = {{ {}, {}, {}, {}, {}, {}, A = {}, H = {} }},\n",
			lua_str(&key),
			lua_str(p.get("name").as_str().unwrap_or(&key)),
			num_str(p.get("minLevel").num()),
			num_or_0(&p.get("maxLevel")),
			num_or_0(&p.get("map")),
			num_or_0(&p.get("zone")),
			lua_str(p.get("zoneName").as_str().unwrap_or("")),
			lua_str(&a),
			lua_str(&h),
		));
	}
	let lua = format!(
		"-- Generated by `forge data codex` (or `forge data headsup`) from {source}. Do not edit: rebuild with that command.\n\
-- The dungeon heads-up's table (rust/crates/forge-data/src/codex/opens.rs; read by Dungeons/Opens.lua).\n\
\n\
local ADDON, ns = ...\n\
local D = ns.Dungeons\n\
if not (D and D.RegisterOpens) then return end\n\
\n\
D.RegisterOpens({}, {{\n\
\t-- [key] = {{ name, minLevel, maxLevel, instance map, zone, zone name, A = rows, H = rows }}\n\
{body}}})\n",
		lua_str(inp.built_at)
	);
	(lua, n)
}

fn read_json(path: &std::path::Path) -> Result<V, String> {
	let text = std::fs::read_to_string(path).map_err(|e| format!("{}: {e}", path.display()))?;
	forge_guide::js::parse_json(&text).map_err(|e| format!("{}: {e}", path.display()))
}

/// Builds the table from a Codex build's JSON (`codex_dir`: data/forever/codex) and data/forever (`data_dir`)
/// and writes it to `out`. -> how many dungeons, the file's size in bytes
pub fn write(codex_dir: &std::path::Path, data_dir: &std::path::Path, out: &std::path::Path) -> Result<(usize, usize), String> {
	let journal = read_json(&codex_dir.join("journal.json"))?;
	let quests = read_json(&codex_dir.join("quests.json"))?;
	let npcs = read_json(&codex_dir.join("npcs.json"))?;
	let objects = read_json(&codex_dir.join("objects.json"))?;
	let meta = read_json(&codex_dir.join("meta.json"))?;
	let fv_quests = read_json(&data_dir.join("quests.json"))?;
	let fv_npcs = read_json(&data_dir.join("npcs.json"))?;
	let built_at = meta.get("builtAt").as_str().unwrap_or("").to_string();
	let inp = Inputs { journal: &journal, quests: &quests, npcs: &npcs, objects: &objects, fv_quests: &fv_quests, fv_npcs: &fv_npcs, built_at: &built_at };
	let (lua, n) = emit(&inp, "data/forever/codex (journal, quests, NPCs, objects) and data/forever (quests, NPCs)");
	std::fs::write(out, &lua).map_err(|e| format!("{}: {e}", out.display()))?;
	Ok((n, lua.len()))
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_guide::js::parse_json;

	fn j(s: &str) -> V {
		parse_json(s).unwrap()
	}

	// In Search of Thaelrid's case (#1026, #1027): a side-less quest takes the side of the page quest it leads to,
	// so the Horde's rows leave it out; an errand before a quest (In Search of Thaelrid, a talk quest; Trouble in
	// the Deeps) is done on the way, an item quest before one must be done first; a quest an item starts is never
	// picked up.
	#[test]
	fn sides_follow_pickup_and_the_chain_says_what_comes_first() {
		let at = |npc: u32| format!(r#"{{ "kind": "npc", "id": {npc}, "map": 1, "x": 1, "y": 1, "inside": false }}"#);
		let journal = j(&format!(
			r#"{{ "dungeons": {{ "bfd": {{ "key": "bfd", "name": "Blackfathom Deeps", "kind": "dungeon", "minLevel": 22, "maxLevel": 28, "map": 48, "zone": 1440, "zoneName": "Ashenvale",
				"quests": [
					{{ "id": 1198, "faction": null, "minLevel": 18, "level": 24, "closedBy": [1200], "start": {s1}, "rewards": {{ "xp": 5700 }} }},
					{{ "id": 1200, "faction": "A", "minLevel": 18, "level": 27, "chain": [1198], "start": {s1}, "rewards": {{ "xp": 7850 }} }},
					{{ "id": 6562, "faction": "H", "minLevel": 17, "level": 22, "start": {s2} }},
					{{ "id": 6564, "faction": "H", "minLevel": 17, "level": 22, "startItem": {{ "id": 16790 }}, "start": {{ "kind": "item", "id": 16790 }} }},
					{{ "id": 6565, "faction": "H", "minLevel": 17, "level": 26, "chain": [6562, 6564], "start": {s2} }}
				] }},
				"ony": {{ "key": "ony", "name": "Onyxia's Lair", "kind": "raid", "minLevel": 60, "quests": [] }} }} }}"#,
			s1 = at(4786),
			s2 = at(12736)
		));
		let quests = j(r#"{
			"1198": { "id": 1198, "faction": null, "minLevel": 18, "start": { "npc": [4786], "object": [], "item": [] }, "end": { "npc": [4787] }, "objectives": [] },
			"1200": { "id": 1200, "faction": "A", "minLevel": 18, "pre": [1198], "start": { "npc": [4786], "object": [], "item": [] }, "objectives": [{ "id": 1 }] },
			"6562": { "id": 6562, "faction": "H", "minLevel": 17, "start": { "npc": [12736], "object": [], "item": [] }, "end": { "npc": [12736] }, "objectives": [] },
			"6564": { "id": 6564, "faction": "H", "minLevel": 17, "start": { "npc": [], "object": [], "item": [16790] }, "objectives": [] },
			"6565": { "id": 6565, "faction": "H", "minLevel": 17, "pre": [6562, 6564], "start": { "npc": [12736], "object": [], "item": [] }, "objectives": [{ "id": 2 }] }
		}"#);
		let npcs = j(r#"{ "4786": { "faction": null, "spawns": [{ "map": 1 }] }, "4787": { "faction": null, "spawns": [{ "map": 2 }] },
			"12736": { "faction": "H", "spawns": [{ "map": 3 }] } }"#);
		let (objects, none) = (V::obj(), V::obj());
		let (lua, n) = emit(&Inputs { journal: &journal, quests: &quests, npcs: &npcs, objects: &objects, fv_quests: &none, fv_npcs: &none, built_at: "t" }, "a test");
		assert_eq!(n, 1, "raids are left out");
		assert!(lua.contains(r#"D.RegisterOpens("t", {"#), "{lua}");
		assert!(
			lua.contains(
				r#"["bfd"] = { "Blackfathom Deeps", 22, 28, 48, 1440, "Ashenvale", A = "1198,18,24,5700,x1200;1200,18,27,7850,v1198", H = "6562,17,22,0;6564,17,22,0,g0;6565,17,26,0,w6564,v6562" },"#
			),
			"{lua}"
		);
	}
}
