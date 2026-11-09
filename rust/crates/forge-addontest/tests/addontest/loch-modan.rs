//! The real Loch Modan guide (guides/forever/alliance/03-loch-modan.guide), compiled with the reference data
//! (data/forever; tests skip with a note without it) and played by the full addon on the stub world: a level 19
//! Warrior of the race given, standing at the Loch Modan tunnel. Shared by the Start from here, Skip and
//! travel-step tests (engine-start-here.rs, engine-skip-passed.rs, engine-travel-run.rs).

use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;
use std::sync::LazyLock;

/// Lua helpers for the scenarios: E (the Engine), flush(), G() (the guide), step(title[, nth]) (a step index
/// by title), goalAt(s[, t]) (a located goal of step s), walk(s) (stand at it), knowFP(name), live()/view()
/// (step titles), state() (live, view and the saved skips).
pub const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25); stub.advance(0.25) end
function G() return E.GetGuide() end
function title(s) local st = s and G().steps[s]; return st and st.title or "nil" end
function step(t, nth)
	local n = 0
	for s, st in ipairs(G().steps) do
		if st.title == t then
			n = n + 1
			if n == (nth or 1) then return s end
		end
	end
end
function goalAt(s, t)
	for _, g in ipairs(G().steps[s].goals) do if (not t or g.t == t) and g.map and g.x then return g end end
end
function walk(s, t) local g = goalAt(s, t); stub.world.moveTo(g.map, g.x, g.y); flush(); stub.advance(1.5); flush() end
function knowFP(name)
	local f = PolestarCharDB.flags
	f.fp = f.fp or {}; f.fp[name] = true
	f.taxi = f.taxi or {}
	for _, st in ipairs(G().steps) do
		for _, g in ipairs(st.goals) do
			if g.t == "getfp" and g.location == name and g.node then f.taxi[g.node] = true end
		end
	end
end
function live() return title(E.GetLiveStep()) end
function view() return title(E.GetStepIndex()) end
function skips()
	local sk, keys = PolestarCharDB.skipped[G().id] or {}, {}
	for k, v in pairs(sk) do keys[#keys + 1] = { k, v } end
	table.sort(keys, function(a, b) return tostring(a[1]) < tostring(b[1]) end)
	local out = {}
	for _, e in ipairs(keys) do out[#out + 1] = title(e[1]) .. "=" .. tostring(e[2]) end
	return table.concat(out, ", ")
end
"#;

/// Loch Modan done up to the tunnel post (86585 handed in), 301 for Ironforge in the log, the Menethil and
/// Thelsamar flight paths known: the live step is "Into Dun Morogh".
pub const AT_THE_TUNNEL: &str = r#"
local w = stub.world
w.complete({ 307, 250, 199, 86614, 436, 297, 86613, 257, 258, 86758, 385, 298, 86585 })
w.onQuest(301, {})
E.SetGuide("forever/alliance/03-loch-modan"); flush()
knowFP("Menethil Harbor"); knowFP("Thelsamar"); flush()
"#;

/// The Dwarf of the report (#29 of 51) at the tram: Ironforge done (its flight path, 301 handed in, trained
/// at 18), the live step "Tram to Stormwind".
pub const AT_THE_TRAM: &str = r#"
local w = stub.world
w.complete({ 307, 250, 199, 86614, 436, 297, 86613, 257, 258, 86758, 385, 298, 86585, 301 })
PolestarCharDB.classTrainVisit = 18
E.SetGuide("forever/alliance/03-loch-modan"); flush()
knowFP("Menethil Harbor"); knowFP("Thelsamar"); knowFP("Ironforge"); flush()
"#;

struct Pack {
	loads: String,
	maps: String,
}

static PACK: LazyLock<Option<Pack>> = LazyLock::new(|| {
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() {
		return None;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let file = "guides/forever/alliance/03-loch-modan.guide";
	let text = std::fs::read_to_string(root().join(file)).unwrap();
	let compiled = compile_with(&[(file, &text)], &data, None);
	assert!(compiled.errors.is_empty(), "{}", compiled.text);
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let loads = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect::<Vec<_>>().join("\n");
	let mut maps = String::new();
	for (id, name) in [
		("1432", "Loch Modan"),
		("1426", "Dun Morogh"),
		("1455", "Ironforge"),
		("1429", "Elwynn Forest"),
		("1433", "Redridge Mountains"),
		("1453", "Stormwind City"),
		("1437", "Wetlands"),
		("1436", "Westfall"),
	] {
		let f = data.map_frames.get("forever").get(id);
		maps.push_str(&format!(
			"w.addMap({id}, {{ name = \"{name}\", c = {}, left = {}, right = {}, top = {}, bottom = {} }})\n",
			f.get("c").to_js_string(),
			f.get("left").to_js_string(),
			f.get("right").to_js_string(),
			f.get("top").to_js_string(),
			f.get("bottom").to_js_string()
		));
	}
	// The pack's folder lives as long as the tests.
	std::mem::forget(pack);
	Some(Pack { loads, maps })
});

/// Runs `scenario` (after HELPERS) for a level 19 Warrior of `race` at the Loch Modan tunnel; None (with a
/// note) without the reference data.
pub fn run_as(race: &str, scenario: &str) -> Option<Vec<Value>> {
	let Some(p) = PACK.as_ref() else {
		eprintln!("skipped: no reference data at data/forever");
		return None;
	};
	let before = format!(
		"local w = stub.world\n{}\nw.race, w.raceName, w.class, w.className, w.faction, w.level = \"{race}\", \"{race}\", \"WARRIOR\", \"WARRIOR\", \"Alliance\", 19\nw.moveTo(1432, 21.0, 68.0)\n",
		p.maps
	);
	let script = format!("do local ns = {{}}\n{}\nend\nstub.login()\nstub.fire(\"QUEST_LOG_UPDATE\")\n{HELPERS}\n{scenario}\n", p.loads);
	Some(emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() }))
}
