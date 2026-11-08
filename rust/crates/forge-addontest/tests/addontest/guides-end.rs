//! Every leveling guide of ours reaches its end when the player does its last step ahead of the live one
//! (behavior.guideEnd "ask"; Engine, Own.noteEnd / Own.endDoneAhead): the guides compiled from guides/ with
//! the reference data (data/forever; skipped with a note without it), loaded by the full addon on the stub
//! world. Per guide one character it serves (its first race and class, at its first level and first located
//! goal), and one more of a class its last step is only for. The last step is the last one for everyone: a
//! class's or a race's own steps after it (Own.forSome: Cat Form at the end of The Barrens for Druids) are no
//! end; done ahead first, they must not end the guide (`own`). With the live step left early, only the last
//! applicable step's goals are done the way the game does them (quest state, the level, bags, flight paths
//! from the flight map, position for goto and explore, the zone text for a flight's landing, the named NPC's
//! window for train, vendor and talk; a vendor beside other work is left alone, Own.sideVendor); then
//! GUIDE_END must fire with steps left undone and the guide stay.
//! `train class` (any trainer of the class) cannot end a guide out of turn: those guides are listed, not failed.

use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon};
use forge_guide::js::V;
use forge_guide::project::find_guide_files;
use serde_json::Value;

const PLAY: &str = r#"
${loads}
stub.login()
stub.fire("QUEST_LOG_UPDATE")
Polestar.Set("behavior.autoAccept", false)
Polestar.Set("behavior.autoTurnin", false)
local E, G, w = Polestar.Engine, Polestar.Guides, stub.world
local ENDS = {}
Polestar.On("GUIDE_END", function(id, i) ENDS[#ENDS + 1] = { id = id, undone = i.undone } end)
E.SetGuide(@ID@)
stub.advance(3)
local g = G.Get(@ID@)
local live = E.GetLiveStep()
local function someOnly(o)
	return type(o) == "table" and ((o.classes and #o.classes > 0) or (o.races and #o.races > 0))
end
-- A class's or a race's own step (Engine, Own.forSome): its `only`, or that of each goal of its work.
local function forSome(s, v)
	if someOnly(g.steps[s].only) then return true end
	local any = false
	for gi, goal in ipairs(g.steps[s].goals) do
		if goal.t ~= "note" and not goal.optional and v.goals[gi] and v.goals[gi].status ~= "na" then
			if not someOnly(goal.only) then return false end
			any = true
		end
	end
	return any
end
-- forAll: the last step for everyone.
local function lastWork(below, forAll)
	for s = (below or #g.steps + 1) - 1, 1, -1 do
		local v = E.GetStepView(s)
		if v and v.status ~= "na" and not g.steps[s].along and not (forAll and forSome(s, v)) then
			for gi, goal in ipairs(g.steps[s].goals) do
				if goal.t ~= "note" and not goal.optional and v.goals[gi] and v.goals[gi].status ~= "na" then return s end
			end
		end
	end
end
local function statuses(s)
	local st = {}
	for gi, gv in ipairs(E.GetStepView(s).goals) do st[gi] = gv.status end
	return table.concat(st, ",")
end
local r = { id = @ID@, live = live or false, last = lastWork(nil, true) or false, kinds = {}, unhandled = {} }
if not (live and r.last and r.last > live) then emit(r) return end
r.own = lastWork()
if r.own == r.last then r.own = nil end
r.before = statuses(r.last)
do
	local req, v = {}, E.GetStepView(r.last)
	for gi, goal in ipairs(g.steps[r.last].goals) do
		local st = v.goals[gi] and v.goals[gi].status
		if goal.t ~= "note" and not goal.optional and not (v.goals[gi] and v.goals[gi].side) and st ~= "na" then req[#req + 1] = st end
	end
	r.required = table.concat(req, ",")
end
-- A vendor check-off beside other work (the view's `side`) is left alone, as
-- by a player with nothing to sell: it must never hold the step (Own.sideVendor).
local function satisfy(s, again)
	local view = E.GetStepView(s)
	for gi, goal in ipairs(g.steps[s].goals) do
		local gv = view.goals[gi]
		local t = goal.t
		if gv and gv.status ~= "na" and t ~= "note" and not goal.optional and not gv.side then
			if not again then r.kinds[#r.kinds + 1] = t .. (t == "train" and goal.class and " class" or "") end
			if t == "accept" then if not w.log[goal.quest] and not w.completed[goal.quest] then w.accept(goal.quest, {}) end
			elseif t == "turnin" then w.turnIn(goal.quest)
			elseif t == "complete" or t == "kill" or (t == "collect" and goal.quest and goal.oi) then
				if not w.log[goal.quest] then w.accept(goal.quest, { goal.count or 1 }) end
				w.finish(goal.quest)
			elseif t == "collect" or t == "buy" then w.addItem(goal.item, goal.count or 1)
			elseif t == "level" then w.setLevel(math.floor(goal.level or 1) + ((goal.frac or (goal.level or 1) % 1 > 0) and 1 or 0))
			elseif t == "goto" or t == "explore" then
				if goal.map and goal.x then w.moveTo(goal.map, goal.x, goal.y); stub.advance(1.5) end
				if t == "explore" and goal.area then w.explore(goal.area) end
			elseif t == "fly" or t == "hearth" or t == "enter" then
				if goal.location then w.setZone(goal.location, goal.location) end
			elseif t == "getfp" then
				-- The flight map records the node (Nav/Travel.lua) as the game shows it.
				local f = Polestar.CharState().flags
				f.taxi = type(f.taxi) == "table" and f.taxi or {}
				if goal.node then f.taxi[goal.node] = true end
				w.taxi(goal.npc or 0, goal.location); w.close()
			elseif t == "sethome" then w.bind(goal.location or "")
			elseif t == "train" and goal.npc then w.trainer(goal.npc); w.close()
			elseif t == "vendor" and goal.npc then w.merchant(goal.npc); w.close()
			elseif t == "talk" and goal.npc then w.gossip(goal.npc); w.close()
			elseif t == "train" and goal.class then -- any class trainer: not out of turn
			elseif not again then r.unhandled[#r.unhandled + 1] = t end
			stub.advance(0.5)
		end
	end
end
-- A class's or race's own steps after the last step for everyone, done
-- ahead first (Cat Form in the class guide): no end.
if r.own then
	for i = r.last + 1, #g.steps do
		local v = E.GetStepView(i)
		if v and v.status ~= "na" then satisfy(i, true) end
	end
	stub.advance(2)
	r.ownEnded = ENDS[1] ~= nil
end
-- A last step whose `when` stops holding once done (`level<N`) leaves the
-- step before it as the last: that one next, a few times.
local s = lastWork(nil, true)
for _ = 1, 3 do
	if not s or s <= live or ENDS[1] then break end
	satisfy(s)
	stub.advance(2)
	local now = lastWork(nil, true)
	if not (now and now < s) then break end
	s = now
end
-- The place guard (open work earlier in the last step's place): with the
-- steps between skipped, the same again ends it.
if not ENDS[1] then
	for i = live + 1, r.last - 1 do
		E.Goto(i)
		if E.GetStepIndex() == i then E.Skip() end
	end
	E.Goto(live)
	stub.advance(1)
	local s = lastWork(nil, true)
	if s and s > live then
		satisfy(s, true)
		stub.advance(2)
		r.guarded = ENDS[1] ~= nil
	end
end
r.ended = ENDS[1] and ENDS[1].id == @ID@ or false
r.undone = ENDS[1] and ENDS[1].undone or false
r.stays = E.GetGuide() and E.GetGuide().id == @ID@ or false
r.now = E.GetLiveStep() or false
r.after = statuses(r.last)
emit(r)
"#;

fn s(v: &V, k: &str) -> String {
	v.get(k).to_js_string()
}

fn list(v: &V) -> Vec<String> {
	v.items().iter().map(|x| x.to_js_string()).collect()
}

#[test]
fn every_leveling_guide_ends_when_its_last_step_is_done_ahead_of_the_live_step() {
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

	let mut rows: Vec<String> = Vec::new();
	let mut fails: Vec<String> = Vec::new();
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
		// A class its last step is only for, when the first does not get it.
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
			let before = format!(
				"local w = stub.world\n{maps}w.race, w.raceName = {r:?}, {rn:?}\nw.class, w.className = {c:?}, {c:?}\nw.faction = {f:?}\nw.level = {level}\n{start}\n",
				r = race,
				rn = race_name,
				c = class,
				f = faction
			);
			let script = PLAY.replace("${loads}", &loads).replace("@ID@", &serde_json::to_string(&id).unwrap());
			let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() });
			let r: Value = out.into_iter().next().unwrap_or(Value::Null);
			let kinds: Vec<String> = r["kinds"].as_array().map(|a| a.iter().map(|k| k.as_str().unwrap_or("").to_string()).collect()).unwrap_or_default();
			let who = format!("{id} ({race} {class})");
			let own = if r["own"].is_null() { String::new() } else { format!(" (own steps from {} done ahead first: no end)", r["last"].as_i64().unwrap_or(0) + 1) };
			let verdict = if r["ownEnded"] == true {
				let v = format!("FAIL  {who}: a class's or race's own last steps done ahead ended the guide {r}");
				fails.push(v.clone());
				v
			} else if r["before"].is_null() {
				format!("skip  {who}: live {} last {}", r["live"], r["last"])
			} else if r["ended"] == true && r["stays"] == true && r["undone"].as_f64().unwrap_or(0.0) > 0.0 {
				if r["guarded"] == true {
					format!("guard {who}: [{}] (ends once the open steps in that place are behind: {})", kinds.join(", "), r["before"])
				} else {
					format!("pass  {who}: [{}]{own}", kinds.join(", "))
				}
			} else if r["required"].as_str().is_some_and(|b| b.split(',').all(|x| x == "done" || x == "skipped")) {
				format!("ready {who}: [{}] (reads done from the start, {}: ends when the rest is done)", kinds.join(", "), r["before"])
			} else if kinds.iter().any(|k| k == "train class") {
				format!("class {who}: [{}] (any class trainer: not out of turn)", kinds.join(", "))
			} else {
				let v = format!("FAIL  {who}: [{}] {}", kinds.join(", "), r);
				fails.push(v.clone());
				v
			};
			rows.push(verdict);
		}
	}
	let report = rows.join("\n");
	let _ = std::fs::write(std::env::temp_dir().join("polestar-guides-end.txt"), &report);
	eprintln!("{report}");
	assert!(fails.is_empty(), "{}", fails.join("\n"));
}
