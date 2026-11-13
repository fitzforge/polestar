//! Forever Leveling BiS's public API (addon/Polestar/Gear/FLB.lua, Gear.lua, Bags.lua): with none installed, Polestar's
//! own advice; with version 1, its bag arrows (its "no" included), the rest Polestar's; with version 2, its gains,
//! scores, weights and the spec picked in it, said under the advice ("Scored by Forever Leveling BiS (Fury)"); only
//! while Stat weights is Automatic and gear.useFlbis is on; every call guarded. The API here is a stub, its numbers
//! invented for the test.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

// Items in the generated ItemDB format (forge-data gear/leveling.rs encode, `forge data itemdb`).
const ITEMS: &str = r#"{
	[9001] = "1 20 15 2 4 3 str5 sta3 armor150",
	[9002] = "1 25 20 2 4 3 str10 sta4 armor170",
	[9004] = "1 20 15 2 4 1 int10 spi5 armor30",
	[9005] = "1 35 30 2 4 4 str8 sta8 armor300",
	[9006] = "1 25 20 2 4 3 str10 sta4 armor170 crit1",
	[9040] = "16 20 15 2 4 1 sta3",
}"#;

// A level 30 Troll Warrior wearing the 9001 helm. In the bags: 9002 (a better helm), 9004 (a cloth cap, a downgrade),
// 9005 (plate: an upgrade only at level 40) and 9040 (a cloak for the empty back slot). `api(version)` installs a stub
// of the API: its IsUpgrade answers from `up`, GetGain from `gain`, ScoreItem from `score` (by item ID), GetSpec from
// `pick`, GetWeights from `weights`; `listeners` holds what was given to OnChanged, `asked` what was asked of it.
const PRELUDE: &str = r#"
g.equip(1, "item:9001")
g.bag(0, 1, "item:9002"); g.bag(0, 2, "item:9004"); g.bag(0, 3, "item:9005"); g.bag(0, 4, "item:9040")
local function idOf(link) return tonumber(tostring(link):match("item:(%d+)")) end
up, gain, score, pick, weights, listeners, asked = {}, {}, {}, nil, nil, {}, {}
function api(version)
	local t = {
		version = version,
		IsUpgrade = function(link) asked[#asked + 1] = "IsUpgrade"; return up[idOf(link)] end,
		OnChanged = function(f) listeners[#listeners + 1] = f end,
	}
	if version >= 2 then
		t.GetGain = function(link) asked[#asked + 1] = "GetGain"; return gain[idOf(link)] end
		t.ScoreItem = function(link) return score[idOf(link)] end
		t.GetSpec = function() return pick end
		t.GetWeights = function(class, spec, level) asked[#asked + 1] = "GetWeights " .. class .. " " .. spec .. " " .. level; return weights end
	end
	ForeverLevelingBiS_API = t
	G.Invalidate("spec")
	return t
end
local function arrow(button)
	for _, r in ipairs(button.regions) do
		if type(r.texture) == "string" and r.texture:find("qol%-upgrade$") and r:IsShown() then return r end
	end
end
function arrows()
	G.Bags.Redraw()
	local out = {}
	for slot = 1, 8 do if arrow(g.bagButton(0, slot)) then out[#out + 1] = slot end end
	return out
end
function tip(link)
	local out = {}
	for _, l in ipairs(g.showTooltip(GameTooltip, link)) do
		if l:find("^Polestar") or l:find("^Scored") then out[#out + 1] = l end
	end
	return out
end
g.openBag(0)
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before: r#"w = stub.world; g = stub.gear
w.class, w.className, w.classID, w.level = "WARRIOR", "Warrior", 1, 30
w.race, w.raceName, w.raceID, w.faction = "Troll", "Troll", 8, "Horde""#
			.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml"])],
		login: true,
		script: ["G = Polestar.Gear\nPolestar.ItemDB.Register({ schema = 1, build = \"test\" }, ", ITEMS, ")\n", PRELUDE, script].concat(),
		..Default::default()
	})
}

#[test]
fn without_forever_leveling_bis_gear_advice_is_polestar_s_own() {
	let out = run(r#"
		emit({ installed = G.FLB.Installed(), version = G.FLB.Version() or false, uses = G.UsesFLB(1), arrows = arrows(),
			tip = tip("item:9002"), spec = { G.GetSpec() }, flbis = G.GetWeightsInfo().source == "flbis" })
		-- Something else under that name: no API.
		ForeverLevelingBiS_API = 42
		G.Invalidate("spec")
		emit({ installed = G.FLB.Installed(), version = G.FLB.Version() or false, arrows = arrows() })
	"#);
	let o = &out[0];
	assert_eq!(o["installed"], false);
	assert_eq!(o["version"], false);
	assert_eq!(o["uses"], false);
	assert_eq!(o["arrows"], json!([1, 4]), "Polestar's own: the better helm and the cloak for the empty slot");
	assert_eq!(o["tip"][1], "Scored for Arms until you spend talent points");
	assert_eq!(o["spec"], json!(["arms", "Arms", "default"]));
	assert_eq!(o["flbis"], false);
	assert_eq!(out[1], json!({ "installed": false, "version": false, "arrows": [1, 4] }));
}

#[test]
fn version_1_its_bag_arrows_decide_its_no_included_and_the_rest_stays_polestar_s() {
	let out = run(r#"
		local own = tip("item:9002")
		api(1)
		-- Its answers: no for the better helm (its Bag upgrades switch off, say), yes for the cloth cap and the cloak.
		up[9002], up[9004], up[9040] = false, true, true
		emit({ version = G.FLB.Version(), uses = G.UsesFLB(1), scores = G.UsesFLB(2), arrows = arrows(),
			same = table.concat(tip("item:9002"), "|") == table.concat(own, "|"), scored = tip("item:9002")[2] })
		-- Its answers change and it says so: the arrows follow, once a frame.
		up[9002] = true
		for _, f in ipairs(listeners) do f() end
		stub.advance(0.3)
		emit({ arrows = arrows(), listeners = #listeners })
		-- Off in Settings, or a spec chosen in Stat weights: Polestar's own again.
		Polestar.Set("gear.useFlbis", false)
		local off = arrows()
		Polestar.Set("gear.useFlbis", true)
		Polestar.Set("gear.spec.WARRIOR", "arms")
		local chosen = arrows()
		Polestar.Set("gear.spec.WARRIOR", "auto")
		emit({ off = off, chosen = chosen, back = arrows() })
		-- An IsUpgrade that errors: Polestar's own, and no error.
		ForeverLevelingBiS_API.IsUpgrade = function() error("changed") end
		emit({ arrows = arrows() })
	"#);
	assert_eq!(out[0]["version"], 1);
	assert_eq!(out[0]["uses"], true);
	assert_eq!(out[0]["scores"], false, "version 1 has no scores");
	assert_eq!(out[0]["arrows"], json!([2, 4]), "its arrows: the cap and the cloak, not the helm it says no to");
	assert_eq!(out[0]["same"], true, "the tooltip's numbers stay Polestar's");
	assert_eq!(out[0]["scored"], "Scored for Arms until you spend talent points");
	assert_eq!(out[1], json!({ "arrows": [1, 2, 4], "listeners": 1 }), "one listener, and the arrows follow its change");
	assert_eq!(out[2], json!({ "off": [1, 4], "chosen": [1, 4], "back": [1, 2, 4] }));
	assert_eq!(out[3], json!({ "arrows": [1, 4] }));
}

#[test]
fn version_2_its_gains_scores_weights_and_spec_decide_while_stat_weights_is_automatic() {
	let out = run(r#"
		api(2)
		gain[9002], gain[9004], gain[9006] = 37.4, -12, 0.4
		score[9002] = 123.5
		pick = "fury"
		-- Its weights in its own stat names: crit and hit per 1%, haste per rating point at a crit rating of 0.3 per
		-- 3% crit, spell power that is all damage.
		weights = { str = 2, atkpwr = 1, sta = 0.5, critPct = 3, critstrkrtng = 0.3, hitPct = 4, hastertng = 5, dps = 12, ohDps = 4,
			splpwr = 0.6, spldmg = 0.6, speed = 7, block = 0.2 }
		local w = G.GetWeights()
		emit({ spec = { G.GetSpec() }, scored = G.ScoredFor(), short = G.ScoredFor(true), tip = tip("item:9002"), cap = tip("item:9004")[1],
			small = { G.IsUpgrade("item:9006") }, score = G.ScoreItem("item:9002"), source = G.GetWeightsInfo().source,
			w = { str = w.str, ap = w.ap, crit = w.crit, hit = w.hit, haste = w.haste, dps = w.dps, ohDps = w.ohDps, sp = w.sp,
				heal = w.heal or false, blockValue = w.blockValue, speed = w.speed or false } })
		-- No spec picked in it: the talents' (here the class default), still scored by it.
		pick = nil
		G.Invalidate("flbis")
		emit({ spec = { G.GetSpec() }, scored = G.ScoredFor(), asked = asked[#asked] })
	"#);
	let o = &out[0];
	assert_eq!(o["spec"], json!(["fury", "Fury", "flbis"]), "the spec picked in it");
	assert_eq!(o["scored"], "Scored by Forever Leveling BiS (Fury)");
	assert_eq!(o["short"], "Scored by Forever Leveling BiS");
	assert_eq!(o["tip"], json!(["Polestar | +37% upgrade · Head", "Scored by Forever Leveling BiS (Fury)"]), "its gain");
	assert_eq!(o["cap"], "Polestar | -12% downgrade · Head");
	assert_eq!(o["small"][0], false, "its +0.4% is under the 1% threshold, whatever Polestar's own weights say");
	assert_eq!(o["score"], 123.5);
	assert_eq!(o["source"], "flbis");
	let w = &o["w"];
	assert_eq!(w["str"], 2);
	assert_eq!(w["ap"], 1);
	assert_eq!(w["crit"], 3, "a Warrior's crit per 1% is melee crit");
	assert_eq!(w["hit"], 4);
	assert!((w["haste"].as_f64().unwrap() - 5.0 * 10.0 * 3.0 / (14.0 * 0.3)).abs() < 1e-9, "haste per 1%: {w}");
	assert_eq!(w["dps"], 12);
	assert_eq!(w["ohDps"], 4);
	assert_eq!(w["sp"], 0.6);
	assert_eq!(w["heal"], false, "its spell power is all damage");
	assert_eq!(w["blockValue"], 0.2, "its block is block value");
	assert_eq!(w["speed"], false, "speed weights are not Polestar's to weigh");
	assert_eq!(out[1], json!({ "spec": ["arms", "Arms", "default"], "scored": "Scored by Forever Leveling BiS (Arms)", "asked": "GetWeights WARRIOR arms 30" }));
}

#[test]
fn version_2_a_spec_or_custom_weights_chosen_in_polestar_or_the_setting_off_keep_polestar_s_own() {
	let out = run(r#"
		local own = { tip("item:9002"), G.ScoreItem("item:9002") }
		api(2)
		gain[9002], score[9002], pick = 37.4, 123.5, "fury"
		local function now() return { tip = tip("item:9002"), score = G.ScoreItem("item:9002"), spec = (G.GetSpec()) } end
		Polestar.Set("gear.spec.WARRIOR", "protection")
		local chosen = now()
		Polestar.Set("gear.spec.WARRIOR", "auto")
		local _, sc = G.Scales.Import('( Pawn: v1: "Mine": Strength=1, Stamina=1 )', "WARRIOR")
		Polestar.Set("gear.spec.WARRIOR", "custom:" .. sc.scale.id)
		local custom = now()
		Polestar.Set("gear.spec.WARRIOR", "auto")
		Polestar.Set("gear.useFlbis", false)
		local off = now()
		Polestar.Set("gear.useFlbis", true)
		emit({ own = own, chosen = chosen, custom = custom, off = off, again = now() })
	"#);
	let o = &out[0];
	assert_eq!(o["chosen"]["spec"], "protection");
	assert_eq!(o["chosen"]["tip"][1], "Scored for Protection (tank), as chosen in Settings");
	assert_ne!(o["chosen"]["score"], 123.5, "Polestar's own score for the chosen spec");
	assert_eq!(o["custom"]["tip"][1], "Scored with your custom weights: Mine");
	assert_ne!(o["custom"]["score"], 123.5);
	assert_eq!(o["off"]["tip"], o["own"][0], "off in Settings: Polestar's own");
	assert_eq!(o["off"]["score"], o["own"][1]);
	assert_eq!(o["again"]["tip"], json!(["Polestar | +37% upgrade · Head", "Scored by Forever Leveling BiS (Fury)"]));
}

#[test]
fn version_2_answers_that_error_or_make_no_sense_leave_polestar_s_own_and_raise_no_error() {
	let out = run(r#"
		local own = { tip("item:9002"), G.ScoreItem("item:9002"), G.GetWeights().str }
		local t = api(2)
		local junk = { "lots", 0 / 0, math.huge, -math.huge, { nothing = 1 }, true }
		local same = {}
		for i, v in ipairs(junk) do
			gain[9002], score[9002], pick, weights = v, v, v, (type(v) == "table" and v or nil)
			G.Invalidate("flbis")
			same[i] = tip("item:9002")[1] == own[1][1] and G.ScoreItem("item:9002") == own[2] and (G.GetSpec()) == "arms"
		end
		for _, name in ipairs({ "GetGain", "ScoreItem", "GetSpec", "GetWeights", "IsUpgrade" }) do
			t[name] = function() error("changed") end
		end
		G.Invalidate("flbis")
		emit({ same = same, tip = tip("item:9002")[1] == own[1][1], score = G.ScoreItem("item:9002") == own[2], str = G.GetWeights().str == own[3],
			arrows = arrows() })
		-- Gain and score in a table, a spec as a class and spec pair, or another class's.
		t.GetGain = function() return { pct = 21 } end
		t.ScoreItem = function() return { score = 9 } end
		t.GetSpec = function() return "WARRIOR", "Fury" end
		G.Invalidate("flbis")
		local pair = { tip("item:9002")[1], G.ScoreItem("item:9002"), (G.GetSpec()) }
		t.GetSpec = function() return "MAGE", "frost" end
		G.Invalidate("flbis")
		emit({ pair = pair, other = (G.GetSpec()) })
	"#);
	assert_eq!(out[0]["same"], json!([true, true, true, true, true, true]), "answers in no known shape");
	assert_eq!(out[0]["tip"], true);
	assert_eq!(out[0]["score"], true);
	assert_eq!(out[0]["str"], true);
	assert_eq!(out[0]["arrows"], json!([1, 4]));
	assert_eq!(out[1], json!({ "pair": ["Polestar | +21% upgrade · Head", 9, "fury"], "other": "arms" }));
}
