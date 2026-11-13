//! Every leveling guide of ours, played in order, ends only at its end (#998): the guides compiled from guides/
//! with the reference data (data/forever; skipped with a note without it), loaded by the full addon on the stub
//! world, each played by the simulated player (tests/lua/simulate.lua) as one character it serves (its first
//! race and class, and one more of a class its last step is only for). Every hand-in comes as the game brings it:
//! the giver's window first, listing the quest as ready and offering only what the character can take right then
//! (so a follow-up waits for the hand-in that opens it, as Regthar Deathgate's Verog the Dervish waits for Kolkar
//! Leaders), and every move puts the player in its map's zone, as the zone text says (the guide's own stop in the
//! Undercity at the start of Hillsbrad, whose last flight lands there, ended it in 0.3.5). GUIDE_END must never
//! fire while a step is still live.
//!
//! GUIDES_END_ONLY=<part of an id> plays only those guides; GUIDES_END_HISTORY=<file.json>, `{ "<guide id>":
//! [quest ids] }`, starts each guide's character with those quests turned in (a character that played an older
//! route up to that guide's level).

use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
use forge_addontest::playtest::SIMULATE;
use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon};
use forge_guide::js::V;
use forge_guide::project::find_guide_files;
use serde_json::Value;

// Before SIMULATE: GUIDE_END recorded with the live step, every move in its map's zone, and every hand-in preceded
// by its giver's window.
const SETUP: &str = r#"
stub.login()
stub.fire("QUEST_LOG_UPDATE")
local E = Polestar.Engine
Polestar.Set("behavior.groupQuests", "do")
E.SetDungeonRoute("skip") -- the solo route, whatever "Dungeons in my route" defaults to
ENDS = {}
Polestar.On("GUIDE_END", function(gid, i)
	ENDS[#ENDS + 1] = { id = gid, undone = i.undone, live = i.live or false }
end)
do
	local w, move = stub.world, stub.world.moveTo
	w.moveTo = function(map, x, y)
		move(map, x, y)
		local m = w.maps[map]
		if m and m.name and m.name ~= "" and m.name ~= w.zone then w.setZone(m.name, "") end
	end
	if w.map then w.moveTo(w.map, w.x, w.y) end
end
E.SetGuide(@ID@)
stub.advance(3)
SIM_GUIDE = E.GetGuide()
local G0, w = SIM_GUIDE, stub.world
local function preDone(a)
	if type(a.preAll) == "table" then
		for _, p in ipairs(a.preAll) do if not w.completed[p] then return false end end
	end
	if type(a.pre) == "table" and #a.pre > 0 then
		for _, p in ipairs(a.pre) do if w.completed[p] then return true end end
		return false
	end
	return true
end
local giver, offers = {}, {}
for _, st in ipairs(G0 and G0.steps or {}) do
	for _, g in ipairs(st.goals) do
		if g.t == "turnin" and g.quest and g.npc then giver[g.quest] = g.npc end
		if g.t == "accept" and g.quest and g.npc then
			offers[g.npc] = offers[g.npc] or {}
			table.insert(offers[g.npc], g)
		end
	end
end
local rawTurnIn = w.turnIn
w.turnIn = function(q, ...)
	local npc = giver[q]
	if npc then
		local avail, seen = {}, {}
		for _, a in ipairs(offers[npc] or {}) do
			local id = a.quest
			if not seen[id] and not w.log[id] and not w.completed[id] and preDone(a) and (w.level or 1) >= (tonumber(a.minLevel) or 0) then
				seen[id] = true
				avail[#avail + 1] = { questID = id }
			end
		end
		w.gossip(npc, { active = { { questID = q, isComplete = true } }, available = avail })
		stub.advance(0.3)
	end
	rawTurnIn(q, ...)
	if npc then w.close() end
end
"#;

fn s(v: &V, k: &str) -> String {
	v.get(k).to_js_string()
}

fn list(v: &V) -> Vec<String> {
	v.items().iter().map(|x| x.to_js_string()).collect()
}

#[test]
fn every_leveling_guide_played_in_order_with_its_givers_windows_ends_only_at_its_end() {
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() && !data_dir.exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let dir = root().join("guides");
	let files = find_guide_files(&dir, false);
	let texts: Vec<(String, String)> = files.iter().map(|f| (format!("guides/{f}"), std::fs::read_to_string(dir.join(f)).unwrap())).collect();
	let sources: Vec<(&str, &str)> = texts.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let compiled = compile_with(&sources, &data, None);
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	let mut maps = String::new();
	for era in ["forever", "era"] {
		let frames = data.map_frames.get(era);
		for (id, f) in frames.as_obj().map(|o| o.entries()).unwrap_or_default() {
			let id = id.to_string();
			let name = data.zones.get(&id).get("name").to_js_string();
			maps.push_str(&format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})\n",
				serde_json::to_string(if name == "undefined" { "" } else { &name }).unwrap(),
				f.get("c").to_js_string(),
				f.get("left").to_js_string(),
				f.get("right").to_js_string(),
				f.get("top").to_js_string(),
				f.get("bottom").to_js_string()
			));
		}
	}

	// GUIDES_END_HISTORY: per guide id, the quests its character has turned in before it.
	let history: Value =
		std::env::var("GUIDES_END_HISTORY").ok().map(|p| serde_json::from_str(&std::fs::read_to_string(&p).expect("GUIDES_END_HISTORY")).expect("GUIDES_END_HISTORY json")).unwrap_or(Value::Null);

	// (who, before, script) per character; played on all cores, each run its own Lua state.
	let mut jobs: Vec<(String, String, String)> = Vec::new();
	for g in &compiled.guides {
		let cat = s(g, "category");
		if !(cat == "undefined" || cat == "Leveling") {
			continue;
		}
		let id = s(g, "id");
		if let Ok(only) = std::env::var("GUIDES_END_ONLY") {
			if !id.contains(&only) {
				continue;
			}
		}
		let faction = s(g, "faction");
		let races = list(&g.get("races"));
		let race = races.first().cloned().unwrap_or_else(|| if faction == "Horde" { "Orc".into() } else { "Human".into() });
		let mut classes = vec![list(&g.get("classes")).first().cloned().unwrap_or_else(|| "WARRIOR".into())];
		let steps = g.get("steps").items();
		if let Some(last) = steps.last() {
			let only = list(&last.get("only").get("classes"));
			if let Some(c) = only.first() {
				if !only.contains(&classes[0]) {
					classes.push(c.clone());
				}
			}
		}
		let first = steps.iter().flat_map(|st| st.get("goals").items()).find(|x| !x.get("map").is_nullish() && !x.get("x").is_nullish());
		let faction = if faction == "undefined" {
			if race == "Orc" || race == "Troll" || race == "Tauren" || race == "Scourge" {
				"Horde".into()
			} else {
				"Alliance".into()
			}
		} else {
			faction
		};
		for class in classes {
			let raw = s(g, "minLevel");
			let level = if raw == "undefined" { "1".to_string() } else { raw };
			let start = first.as_ref().map(|x| format!("w.moveTo({}, {}, {})", s(x, "map"), s(x, "x"), s(x, "y"))).unwrap_or_default();
			let race_name = if race == "Scourge" { "Undead".to_string() } else { race.clone() };
			let done = history[&id].as_array().map(|qs| format!("w.complete({{ {} }})\n", qs.iter().map(|q| q.to_string()).collect::<Vec<_>>().join(", "))).unwrap_or_default();
			let before = format!(
				"local w = stub.world\n{maps}w.race, w.raceName = {r:?}, {rn:?}\nw.class, w.className = {c:?}, {c:?}\nw.faction = {f:?}\nw.level = {level}\n{start}\n{done}",
				r = race,
				rn = race_name,
				c = class,
				f = faction
			);
			let script = format!("{loads}\n{}\n{SIMULATE}\nemit(ENDS)\n", SETUP.replace("@ID@", &serde_json::to_string(&id).unwrap()));
			jobs.push((format!("{id} ({race} {class})"), before, script));
		}
	}
	let threads = std::thread::available_parallelism().map_or(4, |n| n.get());
	let next = std::sync::atomic::AtomicUsize::new(0);
	let mut results: Vec<(usize, String, Option<String>)> = std::thread::scope(|scope| {
		let workers: Vec<_> = (0..threads)
			.map(|_| {
				scope.spawn(|| {
					let mut done = Vec::new();
					loop {
						let i = next.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
						let Some((who, before, script)) = jobs.get(i) else { break };
						let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: before.clone(), addons: vec![Addon::name("Polestar")], script: script.clone(), ..Default::default() });
						let sim = out.first().cloned().unwrap_or(Value::Null);
						let ends = out.get(1).cloned().unwrap_or(Value::Null);
						let early: Vec<&Value> = ends.as_array().map(|a| a.iter().filter(|e| e["live"] != false).collect()).unwrap_or_default();
						done.push(if early.is_empty() {
							(i, format!("ok    {who}: visited {} of {} steps, ends {}", sim["visited"], sim["steps"], ends), None)
						} else {
							let v = format!("FAIL  {who}: GUIDE_END with a live step {}", serde_json::to_string(&early).unwrap());
							(i, v.clone(), Some(v))
						});
					}
					done
				})
			})
			.collect();
		workers.into_iter().flat_map(|w| w.join().unwrap()).collect()
	});
	results.sort_by_key(|r| r.0);
	let rows: Vec<&str> = results.iter().map(|r| r.1.as_str()).collect();
	let fails: Vec<&str> = results.iter().filter_map(|r| r.2.as_deref()).collect();
	let report = rows.join("\n");
	let _ = std::fs::write(std::env::temp_dir().join("polestar-guides-end-early.txt"), &report);
	eprintln!("{report}");
	assert!(fails.is_empty(), "{}", fails.join("\n"));
}
