use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const SCRIPT: &str = r#"
local calls = 0
Polestar.Nav = Polestar.Nav or {}
Polestar.Nav.EstimateTravel = function(a, b)
	calls = calls + 1
	local mapGap = math.abs((a.map or 0) - (b.map or 0)) * 1000
	return mapGap + math.abs((a.x or 0) - (b.x or 0)) + math.abs((a.y or 0) - (b.y or 0))
end

local function showItem(id)
	GameTooltip:SetOwner(UIParent)
	lookuprt.showItem(GameTooltip, id, "|cffffffff|Hitem:" .. id .. "::::::::20:::::|h[x]|h|r")
	return GameTooltip.lines
end

local before = calls
local itemLines = showItem(8000)
local itemTooltipCalls = calls - before

before = calls
Polestar.Lookup.Sources("mount", 8000)
local itemLookupCalls = calls - before

lookuprt.units.target = { guid = "Player-1-0000BEEF", player = true }
lookuprt.auras.target = { { spellId = 9502, name = "Ember Wolf", icon = 132226 } }
GameTooltip:SetOwner(UIParent)
before = calls
Polestar.Lookup.UnitTooltip(GameTooltip, "target")
local unitTooltipCalls = calls - before
local unitLines = GameTooltip.lines

before = calls
Polestar.Lookup.Sources("mount", 8012)
local unitLookupCalls = calls - before

emit({
	itemTooltipCalls = itemTooltipCalls,
	itemLookupCalls = itemLookupCalls,
	unitTooltipCalls = unitTooltipCalls,
	unitLookupCalls = unitLookupCalls,
	itemLines = itemLines,
	unitLines = unitLines,
})"#;

/// The addMap lines for the codex's frames, in JS Object.entries order (integer keys ascending).
fn maps(codex: &Value) -> String {
	let frames = codex["frames"].as_object().unwrap();
	let mut ids: Vec<&String> = frames.keys().collect();
	ids.sort_by_key(|k| (k.parse::<u64>().map_err(|_| ()).map_or((1, 0), |n| (0, n)), (*k).clone()));
	ids.into_iter()
		.map(|id| {
			let f = &frames[id];
			let name = serde_json::to_string(codex["zones"][id]["name"].as_str().unwrap()).unwrap();
			format!("w.addMap({id}, {{ name = {name}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})", f["c"], f["left"], f["right"], f["top"], f["bottom"])
		})
		.collect::<Vec<_>>()
		.join("\n")
}

fn run(script: &str) -> Value {
	let codex = fixture("lookup.json");
	let pack = write_codex_pack(&codex, &CodexOpts::default());
	let before = format!(
		"{}\nlocal w = stub.world\n{}\nw.level, w.race, w.raceName, w.faction = 20, \"Human\", \"Human\", \"Alliance\"\nw.class, w.className = \"WARRIOR\", \"WARRIOR\"\nw.moveTo(9001, 50, 50)",
		pack.stub_lua,
		maps(&codex)
	);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_lookup_runtime.lua"],
		before,
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Lookup/Lookup.xml"])],
		login: true,
		script: script.into(),
		..Default::default()
	})
	.remove(0);
	drop(pack);
	out
}

#[test]
fn source_tooltips_never_invoke_route_planning_and_do_not_fill_the_routed_cache() {
	let out = run(SCRIPT);
	assert_eq!(out["itemTooltipCalls"], 0, "item tooltip must not invoke Nav.EstimateTravel");
	assert_eq!(out["unitTooltipCalls"], 0, "unit mount tooltip must not invoke Nav.EstimateTravel");
	assert!(out["itemLookupCalls"].as_f64().unwrap() > 0.0, "normal item lookup must still route after the tooltip");
	assert!(out["unitLookupCalls"].as_f64().unwrap() > 0.0, "normal mount lookup must still route after the unit tooltip");
	// Item 8000 is a mount without a curated guide: no Alt-click promise.
	assert_eq!(out["itemLines"], json!(["From Mira Saddler | Vendor · Amber Vale"]));
	assert_eq!(out["unitLines"], json!(["Mount: Ember Wolf | Horde only", "/pole mount: how to get it"]));
}

#[test]
fn a_recent_lookup_stays_hot_across_cleanup_and_idle_results_can_be_collected() {
	let out = run(r#"
		local lookup = Polestar.Lookup.Sources
		local function tick(s) stub.now = stub.now + s; stub.runTimers() end
		local weak = setmetatable({}, { __mode = "v" })
		weak[1] = lookup("mount", 8000, true)
		tick(4)
		local recent = lookup("mount", 8012, true)
		tick(2)
		local hit = lookup("mount", 8012, true) == recent
		local fresh = lookup("mount", 8000, true) ~= weak[1]
		weak[1], weak[2] = lookup("mount", 8000, true), recent
		recent = nil
		tick(5); tick(5)
		collectgarbage(); collectgarbage()
		emit({ hit = hit, fresh = fresh, released = next(weak) == nil })"#);
	assert_eq!(out, json!({ "hit": true, "fresh": true, "released": true }));
}
