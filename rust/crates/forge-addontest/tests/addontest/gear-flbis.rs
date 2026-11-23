//! Forever Leveling BiS's public API (addon/Polestar/Gear/FLB.lua, Gear.lua, Bags.lua, Rewards.lua): with none
//! installed, Polestar's own advice; with version 1 (or no version), its bag arrows (its "no" included), the rest
//! Polestar's; with version 2, its gains (in its score points, as its tooltip shows them), scores, weights and the
//! spec it scores for, said under the advice ("Scored by Forever Leveling BiS (Fury)"), an answer still loading
//! waited for rather than Polestar's own shown for a moment; only while Stat weights is Automatic and gear.useFlbis
//! is on; every call guarded, and values it may add later (specs, weapon setups, stats, sources) left aside. The API
//! here is a stub in the shapes of its reference (github.com/thunder426/ForeverLevelingBiS-API), its numbers
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
	[9020] = "11 20 15 2 4 0 str2",
	[9021] = "11 20 15 2 4 0 str8",
	[9022] = "11 20 15 2 4 0 str6",
	[9030] = "13 25 20 2 2 4 str5 dmin20 dmax30 speed2000",
	[9031] = "13 25 20 2 2 4 str2 dmin10 dmax15 speed2000",
	[9032] = "13 25 20 2 2 4 str6 dmin22 dmax33 speed2000",
}"#;

const WARRIOR: &str = r#"w.class, w.className, w.classID, w.level = "WARRIOR", "Warrior", 1, 30
w.race, w.raceName, w.raceID, w.faction = "Troll", "Troll", 8, "Horde""#;

// A level 30 Troll Warrior wearing the 9001 helm. In the bags: HELM (9002, a better helm, by its item link with a
// random suffix), 9004 (a cloth cap, a downgrade), 9005 (plate: an upgrade only at level 40) and 9040 (a cloak for
// the empty back slot). `api(version)` installs a stub of the API: IsUpgrade answers from `up`, GetGain from `gain`
// and ScoreItem from `score` (`offScore` for an off hand where it has one; by item ID; LOADING: nil, true), GetSpec
// from `spec`, GetWeights from `weights` and `info`; `listeners` holds what was given to OnChanged, `asked` what was
// asked of it ("GetGain 9002 link": about item 9002, by its item link).
const PRELUDE: &str = r#"
HELM = "|cff1eff00|Hitem:9002::::::-17:::30:::::|h[Sturdy Helm of the Bear]|h|r"
g.equip(1, "item:9001")
g.bag(0, 1, HELM); g.bag(0, 2, "item:9004"); g.bag(0, 3, "item:9005"); g.bag(0, 4, "item:9040")
local function idOf(item)
	if type(item) == "number" then return item end
	return tonumber(tostring(item):match("item:(%d+)"))
end
local function what(item) return type(item) == "string" and item:find("|Hitem:", 1, true) and "link" or type(item) end
LOADING = {}
local function answer(t, item)
	local v = t[idOf(item)]
	if v == LOADING then return nil, true end
	return v
end
up, gain, score, offScore, spec, weights, info, listeners, asked = {}, {}, {}, {}, { "arms", "twohand", "WARRIOR" }, nil, nil, {}, {}
function api(version)
	local t = {
		version = version,
		IsUpgrade = function(link) asked[#asked + 1] = "IsUpgrade"; return up[idOf(link)] end,
		OnChanged = function(f) listeners[#listeners + 1] = f end,
	}
	if (version or 1) >= 2 then
		t.GetGain = function(item) asked[#asked + 1] = "GetGain " .. tostring(idOf(item)) .. " " .. what(item); return answer(gain, item) end
		t.ScoreItem = function(item, offHand)
			asked[#asked + 1] = "ScoreItem " .. tostring(idOf(item)) .. " " .. what(item) .. (offHand and " off" or "")
			if offHand and offScore[idOf(item)] ~= nil then return answer(offScore, item) end
			return answer(score, item)
		end
		t.GetSpec = function() return spec[1], spec[2], spec[3] end
		t.GetSpecs = function() return { "arms", "fury", "protection" } end
		t.GetWeights = function(class, s, level, setup)
			asked[#asked + 1] = ("GetWeights %s %s %s %s"):format(tostring(class), tostring(s), tostring(level), tostring(setup))
			return weights, info
		end
		t.GetStatKeys = function() return { { key = "str", label = "Strength" } } end
	end
	ForeverLevelingBiS_API = t
	G.Invalidate("spec")
	return t
end
function wasAsked(text, from)
	for i = (from or 0) + 1, #asked do
		if asked[i] == text then return true end
	end
	return false
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

fn run_as(who: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before: ["w = stub.world; g = stub.gear\n", who].concat(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml"])],
		login: true,
		script: ["G = Polestar.Gear\nPolestar.ItemDB.Register({ schema = 1, build = \"test\" }, ", ITEMS, ")\n", PRELUDE, script].concat(),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_as(WARRIOR, script)
}

#[test]
fn without_forever_leveling_bis_gear_advice_is_polestar_s_own() {
	let out = run(r#"
		emit({ installed = G.FLB.Installed(), version = G.FLB.Version() or false, uses = G.UsesFLB(1), arrows = arrows(),
			tip = tip(HELM), spec = { G.GetSpec() }, flbis = G.GetWeightsInfo().source == "flbis" })
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
		local own = tip(HELM)
		api(1)
		-- Its answers: no for the better helm (its Bag upgrades switch off, say), yes for the cloth cap and the cloak.
		up[9002], up[9004], up[9040] = false, true, true
		emit({ version = G.FLB.Version(), uses = G.UsesFLB(1), scores = G.UsesFLB(2), arrows = arrows(),
			same = table.concat(tip(HELM), "|") == table.concat(own, "|"), scored = tip(HELM)[2] })
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
		-- No version field is version 1: version 2's functions are not asked, whatever the table holds.
		local t = api(nil)
		t.GetGain = function() asked[#asked + 1] = "GetGain"; return 50 end
		t.ScoreItem = function() asked[#asked + 1] = "ScoreItem"; return 50 end
		G.Invalidate("flbis")
		local from = #asked
		local line = tip(HELM)
		emit({ version = G.FLB.Version(), scores = G.UsesFLB(2), same = table.concat(line, "|") == table.concat(own, "|"),
			gain = wasAsked("GetGain", from), score = wasAsked("ScoreItem", from) })
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
	assert_eq!(out[4], json!({ "version": 1, "scores": false, "same": true, "gain": false, "score": false }));
}

#[test]
fn version_2_its_gains_scores_weights_and_spec_decide_while_stat_weights_is_automatic() {
	let out = run(r#"
		api(2)
		-- Its scores: the worn helm 80; its gains over it in the same points. The plate helm cannot be worn before
		-- level 40, so it has no gain (nil), only a score. The cloak fills the empty back slot.
		score[9001], score[9002], score[9004], score[9005], score[9006], score[9040] = 80, 86.1, 67.5, 95, 80.04, 3
		gain[9002], gain[9004], gain[9006], gain[9040] = 6.1, -12.5, 0.04, 3
		-- Its bag arrow's own answers, which version 2's gains overrule.
		up[9002], up[9004] = false, true
		spec = { "fury", "dualwield", "WARRIOR" }
		-- Its weights in its own stat names, and two it may add later.
		weights = { str = 2, agi = 1.37, sta = 1.17, atkpwr = 1, critPct = 3, hitPct = 4, exprtng = 0.5, dps = 12, ohDps = 4,
			splpwr = 0.6, spldmg = 0.6, speed = 7, speedRef = 2.6, block = 0.2, blockPct = 1.5, defrtng = 0.3, feratkpwr = 0.4,
			brandnew = 99 }
		info = { source = "model", profile = false, fromLevel = 30, toLevel = 39 }
		local w = G.GetWeights()
		local list, pick, best, pending = G.RankChoices({ "item:9004", HELM, "item:9005" })
		emit({ spec = { G.GetSpec() }, scored = G.ScoredFor(), short = G.ScoredFor(true), tip = tip(HELM), cap = tip("item:9004")[1],
			plate = tip("item:9005")[1], cloak = tip("item:9040")[1], same = tip("item:9006")[1], small = (G.IsUpgrade("item:9006")),
			up = { G.IsUpgrade(HELM) }, arrows = arrows(), bagSwitch = wasAsked("IsUpgrade"),
			score = G.ScoreItem(HELM), capScore = G.ScoreItem("item:9004"), info = G.GetWeightsInfo(),
			pick = pick, best = best, pending = pending, scores = { list[1].score, list[2].score, list[3].score },
			byLink = wasAsked("GetGain 9002 link"), byId = wasAsked("GetGain 9004 number"), worn = wasAsked("ScoreItem 9001 number"),
			weightsAsked = wasAsked("GetWeights WARRIOR fury 30 dualwield"),
			w = { str = w.str, agi = w.agi, sta = w.sta, ap = w.ap, crit = w.crit, spellCrit = w.spellCrit or false, hit = w.hit,
				expertise = w.expertise, dps = w.dps, ohDps = w.ohDps, sp = w.sp, heal = w.heal or false, blockValue = w.blockValue,
				block = w.block, defense = w.defense, speed = w.speed or false, brandnew = w.brandnew or false } })
		-- No spec picked in it: it scores for the class's first spec, and says so.
		spec = { "arms", "twohand", "WARRIOR" }
		G.Invalidate("flbis")
		emit({ spec = { G.GetSpec() }, scored = G.ScoredFor(), asked = wasAsked("GetWeights WARRIOR arms 30 twohand") })
		-- A weight profile of the player's own in it.
		info = { source = "My leveling set", profile = true, fromLevel = 1, toLevel = 60 }
		G.Invalidate("flbis")
		emit({ info = G.GetWeightsInfo() })
		-- A weapon setup or a spec it adds later: left aside, the spec then Polestar's own pick, its weights its default.
		spec = { "fury", "quadwield", "WARRIOR" }
		G.Invalidate("flbis")
		local setup = { (G.GetSpec()), wasAsked("GetWeights WARRIOR fury 30 nil") }
		spec = { "berserker", "twohand", "WARRIOR" }
		G.Invalidate("flbis")
		emit({ setup = setup, spec = { G.GetSpec() }, scored = G.ScoredFor(), asked = wasAsked("GetWeights WARRIOR nil 30 nil") })
	"#);
	let o = &out[0];
	assert_eq!(o["spec"], json!(["fury", "Fury", "flbis"]), "the spec it scores for");
	assert_eq!(o["scored"], "Scored by Forever Leveling BiS (Fury)");
	assert_eq!(o["short"], "Scored by Forever Leveling BiS");
	assert_eq!(o["tip"], json!(["Polestar | +6.1 (+8%) upgrade · Head", "Scored by Forever Leveling BiS (Fury)"]), "its gain in its points, and its share of the 80 it replaces");
	assert_eq!(o["cap"], "Polestar | -12.5 (-16%) downgrade · Head");
	assert_eq!(o["plate"], "Polestar | +15.0 (+19%) upgrade at level 40 · Head", "no gain now: its score against the worn helm's");
	assert_eq!(o["cloak"], "Polestar | +3.0 upgrade (empty slot)", "its gain, and no share of an empty slot");
	assert_eq!(o["same"], "Polestar | same as equipped · Head", "+0.04 reads as 0.0 at one decimal");
	assert_eq!(o["small"], false);
	assert_eq!(o["up"][0], true);
	assert!((o["up"][1].as_f64().unwrap() - 6.1).abs() < 1e-9, "{o}");
	assert!((o["up"][2].as_f64().unwrap() - 6.1 / 80.0 * 100.0).abs() < 1e-9, "{o}");
	assert_eq!(o["arrows"], json!([1, 4]), "its gains, not its bag arrow's answers");
	assert_eq!(o["bagSwitch"], false, "IsUpgrade is not asked from version 2");
	assert_eq!(o["score"], 86.1);
	assert_eq!(o["capScore"], 67.5);
	assert_eq!(o["info"], json!({ "source": "flbis", "from": 30, "upTo": 39 }));
	assert_eq!(o["pick"], 2);
	assert_eq!(o["best"], 2);
	assert_eq!(o["pending"], false);
	assert_eq!(o["scores"], json!([67.5, 86.1, 95]), "its scores rank the choices");
	assert_eq!(o["byLink"], true, "an item link is passed as it is");
	assert_eq!(o["byId"], true, "a bare item string is passed as its ID");
	assert_eq!(o["worn"], true);
	assert_eq!(o["weightsAsked"], true, "its weights for its spec and weapon setup");
	let w = &o["w"];
	assert_eq!(w["str"], 2);
	assert_eq!(w["agi"], 1.37);
	assert_eq!(w["sta"], 1.17);
	assert_eq!(w["ap"], 1);
	assert_eq!(w["crit"], 3, "a Warrior's crit per 1% is melee crit");
	assert_eq!(w["spellCrit"], false);
	assert_eq!(w["hit"], 4);
	assert_eq!(w["expertise"], 5, "its expertise per rating point, Polestar's per 1% (10 points)");
	assert_eq!(w["dps"], 12);
	assert_eq!(w["ohDps"], 4);
	assert_eq!(w["sp"], 0.6);
	assert_eq!(w["heal"], false, "its spell power is all damage");
	assert_eq!(w["blockValue"], 0.2, "its block is block value");
	assert_eq!(w["block"], 1.5, "its block chance per 1%");
	assert_eq!(w["defense"], 0.3);
	assert_eq!(w["speed"], false, "speed weights are not Polestar's to weigh");
	assert_eq!(w["brandnew"], false, "a stat it adds later is left aside");
	assert_eq!(out[1], json!({ "spec": ["arms", "Arms", "flbis"], "scored": "Scored by Forever Leveling BiS (Arms)", "asked": true }));
	assert_eq!(out[2], json!({ "info": { "source": "flbis", "note": "My leveling set", "profile": true, "from": 1, "upTo": 60 } }));
	assert_eq!(out[3]["setup"], json!(["fury", true]), "an unknown weapon setup: its default");
	assert_eq!(out[3]["spec"], json!(["arms", "Arms", "default"]), "an unknown spec: Polestar's own pick");
	assert_eq!(out[3]["scored"], "Scored by Forever Leveling BiS (Arms)");
	assert_eq!(out[3]["asked"], true, "its weights for its own main spec");
}

#[test]
fn version_2_an_answer_still_loading_waits_for_its_data_without_polestar_s_own_meanwhile() {
	let out = run(r#"
		api(2)
		score[9001], score[9002], score[9004] = 80, 86.1, 67.5
		gain[9002], gain[9004] = LOADING, -12.5
		spec = { "fury", "dualwield", "WARRIOR" }
		local function now()
			local _, pick, _, pending = G.RankChoices({ "item:9004", HELM })
			local t = tip(HELM)
			return { lines = #t, first = t[1] or false, up = (G.IsUpgrade(HELM)), arrows = table.concat(arrows(), ","),
				pick = pick or false, pending = pending }
		end
		local item = now()
		-- The worn helm loading instead.
		gain[9002], score[9001] = 6.1, LOADING
		local worn = now()
		-- Its data arrives: asked again, with no other change.
		score[9001] = 80
		stub.fire("GET_ITEM_INFO_RECEIVED", 9001, true)
		local loaded = now()
		-- Loading again, then it says its answers changed.
		gain[9002] = LOADING
		G.Invalidate("bags")
		local again = now()
		gain[9002], score[9002] = 7, 87
		for _, f in ipairs(listeners) do f() end
		stub.advance(0.3)
		emit({ item = item, worn = worn, loaded = loaded, again = again, changed = now() })
	"#);
	let o = &out[0];
	let waiting = json!({ "lines": 0, "first": false, "up": false, "arrows": "", "pick": false, "pending": true });
	assert_eq!(o["item"], waiting, "the helm loading: nothing yet, not Polestar's own");
	assert_eq!(o["worn"], waiting, "the worn helm loading: the same");
	assert_eq!(o["loaded"]["lines"], 2);
	assert_eq!(o["loaded"]["first"], "Polestar | +6.1 (+8%) upgrade · Head");
	assert_eq!(o["loaded"]["arrows"], "1");
	assert_eq!(o["loaded"]["pick"], 2);
	assert_eq!(o["loaded"]["pending"], false);
	assert_eq!(o["again"], waiting);
	assert_eq!(o["changed"]["first"], "Polestar | +7.0 (+9%) upgrade · Head");
}

#[test]
fn version_2_its_gain_s_share_is_of_the_worn_piece_it_measures_against_and_none_without_one() {
	let out = run(r#"
		api(2)
		spec = { "fury", "dualwield", "WARRIOR" }
		score[9002], gain[9002] = 86.1, 6.1
		local function helm()
			G.Invalidate("flbis")
			local _, _, pct = G.IsUpgrade(HELM)
			return { tip = tip(HELM)[1], pct = pct or false }
		end
		-- The worn helm with no score from it, or a score of 0: its gain alone.
		score[9001] = nil
		local none = helm()
		score[9001] = 0
		local zero = helm()
		score[9001] = 80
		local some = helm()
		-- Two rings worn: Polestar's weights call the first the weaker (Strength 2 against 8), its scores the
		-- second (20 against 30). Its gain of 6 for the new ring is over the second: that ring's slot, and the share
		-- of its 20.
		g.equip(11, "item:9020"); g.equip(12, "item:9021")
		score[9020], score[9021], score[9022], gain[9022] = 30, 20, 26, 6
		G.Invalidate("flbis")
		local function round(x) return x and math.floor(x * 1000 + 0.5) / 1000 end
		local ring = G.CompareToEquipped("item:9022")
		local rings = { slot = ring.slot, old = ring.old, pct = round(ring.pct), tip = tip("item:9022")[1] }
		-- A one-hander with one in each hand (Dual Wield at 20): its gain says which hand it measured.
		g.equip(16, "item:9030"); g.equip(17, "item:9031")
		score[9030], offScore[9031], score[9032], offScore[9032] = 50, 20, 56, 30
		local function hand(g)
			gain[9032] = g
			G.Invalidate("flbis")
			local r = G.CompareToEquipped("item:9032")
			return { slot = r.slot, old = r.old, pct = round(r.pct) }
		end
		emit({ none = none, zero = zero, some = some, rings = rings, main = hand(6), off = hand(10) })
	"#);
	let o = &out[0];
	assert_eq!(o["none"], json!({ "tip": "Polestar | +6.1 upgrade · Head", "pct": false }), "no score for the worn helm: no share");
	assert_eq!(o["zero"], json!({ "tip": "Polestar | +6.1 upgrade · Head", "pct": false }), "a worn score of 0: no share");
	assert_eq!(o["some"]["tip"], "Polestar | +6.1 (+8%) upgrade · Head");
	assert_eq!(o["rings"]["slot"], 12, "the ring its gain measures against, not Polestar's weaker one");
	assert_eq!(o["rings"]["old"], 20);
	assert_eq!(o["rings"]["pct"], 30);
	assert!(o["rings"]["tip"].as_str().unwrap().starts_with("Polestar | +6.0 (+30%) upgrade"), "{o}");
	assert_eq!(o["main"], json!({ "slot": 16, "old": 50, "pct": 12 }), "56 in the main hand against its 50");
	assert_eq!(o["off"], json!({ "slot": 17, "old": 20, "pct": 50 }), "30 in the off hand against its 20");
}

#[test]
fn version_2_its_bear_is_polestar_s_feral_said_as_bear() {
	let out = run_as(
		r#"w.class, w.className, w.classID, w.level = "DRUID", "Druid", 11, 30
w.race, w.raceName, w.raceID, w.faction = "Tauren", "Tauren", 6, "Horde""#,
		r#"
		api(2)
		spec = { "bear", "held", "DRUID" }
		weights = { str = 1, agi = 1.5, sta = 1.6, armor = 0.1, feratkpwr = 0.5 }
		G.Invalidate("flbis")
		emit({ spec = { G.GetSpec() }, scored = G.ScoredFor(), asked = wasAsked("GetWeights DRUID bear 30 held"), armor = G.GetWeights().armor })
		-- Another class's answer: none.
		spec = { "fury", "dualwield", "WARRIOR" }
		G.Invalidate("flbis")
		emit({ source = select(3, G.GetSpec()) })
	"#,
	);
	assert_eq!(out[0], json!({ "spec": ["feral", "Bear", "flbis"], "scored": "Scored by Forever Leveling BiS (Bear)", "asked": true, "armor": 0.1 }));
	assert_ne!(out[1]["source"], "flbis");
}

#[test]
fn version_2_a_spec_or_custom_weights_chosen_in_polestar_or_the_setting_off_keep_polestar_s_own() {
	let out = run(r#"
		local own = { tip(HELM), G.ScoreItem(HELM) }
		api(2)
		score[9001], score[9002], gain[9002], spec = 80, 86.1, 6.1, { "fury", "dualwield", "WARRIOR" }
		local function now() return { tip = tip(HELM), score = G.ScoreItem(HELM), spec = (G.GetSpec()) } end
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
	assert_ne!(o["chosen"]["score"], 86.1, "Polestar's own score for the chosen spec");
	assert_eq!(o["custom"]["tip"][1], "Scored with your custom weights: Mine");
	assert_ne!(o["custom"]["score"], 86.1);
	assert_eq!(o["off"]["tip"], o["own"][0], "off in Settings: Polestar's own");
	assert_eq!(o["off"]["score"], o["own"][1]);
	assert_eq!(o["again"]["tip"], json!(["Polestar | +6.1 (+8%) upgrade · Head", "Scored by Forever Leveling BiS (Fury)"]));
	assert_eq!(o["again"]["score"], 86.1);
}

#[test]
fn version_2_answers_that_error_or_make_no_sense_leave_polestar_s_own_and_raise_no_error() {
	let out = run(r#"
		local own = { tip(HELM), G.ScoreItem(HELM), G.GetWeights().str }
		local t = api(2)
		local junk = { "lots", 0 / 0, math.huge, -math.huge, { pct = 21, score = 9 }, true }
		local same = {}
		for i, v in ipairs(junk) do
			gain[9002], score[9002], score[9001], spec, weights = v, v, v, { v, v, v }, (type(v) == "table" and v or nil)
			G.Invalidate("flbis")
			same[i] = tip(HELM)[1] == own[1][1] and G.ScoreItem(HELM) == own[2] and (G.GetSpec()) == "arms"
				and G.GetWeights().str == own[3]
		end
		for _, name in ipairs({ "GetGain", "ScoreItem", "GetSpec", "GetWeights", "IsUpgrade" }) do
			t[name] = function() error("changed") end
		end
		G.Invalidate("flbis")
		emit({ same = same, tip = tip(HELM)[1] == own[1][1], score = G.ScoreItem(HELM) == own[2], str = G.GetWeights().str == own[3],
			arrows = arrows() })
		-- A gain with no scores to set it against: its gain alone; another class's spec: none.
		t.GetGain = function() return 6.1 end
		t.ScoreItem = function() return nil end
		t.GetSpec = function() return "frost", "held", "MAGE" end
		G.Invalidate("flbis")
		emit({ tip = tip(HELM)[1], spec = (G.GetSpec()) })
	"#);
	assert_eq!(out[0]["same"], json!([true, true, true, true, true, true]), "answers of no kind it gives");
	assert_eq!(out[0]["tip"], true);
	assert_eq!(out[0]["score"], true);
	assert_eq!(out[0]["str"], true);
	assert_eq!(out[0]["arrows"], json!([1, 4]));
	assert_eq!(out[1], json!({ "tip": "Polestar | +6.1 upgrade · Head", "spec": "arms" }));
}
