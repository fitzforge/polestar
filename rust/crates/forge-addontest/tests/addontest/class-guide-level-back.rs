//! A Class guide waiting levels ahead points back to leveling (UI/GuideFrame.lua, GF.LevelBack): a player on
//! Discord (17 Nov) took the Warrior class guide at 20 for Ruga's Bulwark; once the shield was his, Brutal Armor
//! waited for level 29 with nothing to do in it, and nothing in the window led back to his Barrens guide. Under a
//! `level` goal 2 or more levels above the character, a guide that is no leveling guide now lists "Level with
//! <leveling guide> meanwhile: this guide picks up at level N"; a click shows that guide's tab (the one the class
//! heads-up opened it from, else an open leveling guide), or opens the leveling guide for the character in a new
//! tab when none is open. The class guide keeps its tab.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const BEFORE: &str = r#"local w = stub.world
-- 21: past Ruga's own hold (the Trial at 21), the shield done, so Brutal Armor's next wait is Thun'grim's 29.
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Orc", "Orc", "Horde", "WARRIOR", "Warrior", 21
w.money = 50000
w.moveTo(1413, 52.0, 30.0); w.zone, w.subzone = "The Barrens", "The Crossroads""#;

const PRE: &str = r#"
E = Polestar.Engine
for id, b in pairs(Polestar.MapFrames.era) do stub.world.addMap(id, b) end
stub.login(); stub.advance(0.25)
Polestar.Set("behavior.autoAccept", false)
Polestar.Set("behavior.autoTurnin", false)
Polestar.Set("ui.shown", true)
BARRENS, BRUTAL = "forever/horde/02-the-barrens", "forever/class/warrior/brutal-armor"
function tabs()
	local list, active = E.GetTabs()
	local ids = {}
	for i, t in ipairs(list or {}) do ids[i] = t.guideId end
	return { ids = ids, active = list[active] and list[active].guideId or false }
end
-- The guide window's summary line whose text starts with `prefix`, shown.
function line(prefix)
	local root = _G.PolestarGuideFrame
	local function shown(f) while f do if f.shown == false then return false end if f == root then return true end f = f.parent end return false end
	for _, f in ipairs(stub.frames) do
		if type(f.Text) == "table" and f.Text.GetText and f.Chevron and shown(f) then
			local t = f.Text:GetText()
			if type(t) == "string" and t:sub(1, #prefix) == prefix then return f, t end
		end
	end
end
-- Ruga's Bulwark taken (Trial at the Field of Giants handed in), Speak with Thun'grim in the log.
function shield()
	stub.world.complete({ 1823, 1824 })
	stub.world.onQuest(1825, { { required = 1, fulfilled = 1 } })
	stub.fire("QUEST_LOG_UPDATE"); stub.advance(3)
end
"#;

fn run(script: &str) -> Value {
	let dir = forge_addontest::run::addons_dir();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: BEFORE.to_string(),
		addons: vec![
			Addon::name("Polestar"),
			Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")),
			Addon::dir("Polestar_Guides_Horde", dir.join("Polestar_Guides_Horde")),
			Addon::dir("Polestar_Guides_Orc", dir.join("Polestar_Guides_Orc")),
		],
		script: format!("{PRE}{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn brutal_armor_from_the_heads_up_waits_for_29_and_leads_back_to_the_barrens_tab() {
	let out = run(r#"
		E.SetGuide(BARRENS); stub.advance(1)
		local CT = Polestar.UI.ClassToast
		CT.Show(1823); CT.Open(); stub.advance(1)
		shield()
		local l, text = line("Level with")
		local r = { opened = tabs(), step = E.GetGuide().steps[E.GetStepIndex()].title, text = text or false }
		Polestar.Set("ui.compact", true); Polestar.UI.GuideFrame.Refill(); stub.advance(1)
		r.compact = (select(2, line("Level with"))) or false
		l = line("Level with")
		if l then stub.RunScript(l, "OnClick", "LeftButton"); stub.advance(1) end
		r.after = tabs()
		emit(r)"#);
	assert_eq!(out["opened"], json!({ "ids": ["forever/horde/02-the-barrens", "forever/class/warrior/brutal-armor"], "active": "forever/class/warrior/brutal-armor" }), "{out}");
	assert_eq!(out["step"], "Thun'grim Firegaze", "the guide waits at Thun'grim Firegaze: {out}");
	assert_eq!(out["text"], "Level with The Barrens meanwhile: this guide picks up at level 29", "{out}");
	assert_eq!(out["compact"], out["text"], "compact mode too: {out}");
	assert_eq!(
		out["after"],
		json!({ "ids": ["forever/horde/02-the-barrens", "forever/class/warrior/brutal-armor"], "active": "forever/horde/02-the-barrens" }),
		"back on the Barrens tab, Brutal Armor kept in its own: {out}"
	);
}

#[test]
fn a_level_wait_one_level_off_stays_a_grind_and_a_class_guide_alone_opens_the_leveling_guide_in_a_new_tab() {
	let out = run(r#"
		E.SetGuide(BRUTAL); stub.advance(1)
		shield()
		local l, text = line("Level with")
		local r = { alone = tabs(), text = text or false }
		if l then stub.RunScript(l, "OnClick", "LeftButton"); stub.advance(1) end
		r.after = tabs()
		E.SelectTab(1); stub.advance(1)
		stub.world.setLevel(28); stub.advance(2)
		-- The window repaints on the XP the level-up brings in game; the stub world gives none.
		Polestar.UI.GuideFrame.Refill(); stub.advance(1)
		r.at28 = (select(2, line("Level with"))) or false
		emit(r)"#);
	assert_eq!(out["alone"], json!({ "ids": ["forever/class/warrior/brutal-armor"], "active": "forever/class/warrior/brutal-armor" }), "{out}");
	assert_eq!(out["text"], "Level with The Barrens meanwhile: this guide picks up at level 29", "the leveling guide for the character at 21: {out}");
	assert_eq!(out["after"], json!({ "ids": ["forever/class/warrior/brutal-armor", "forever/horde/02-the-barrens"], "active": "forever/horde/02-the-barrens" }), "it opens in a new tab: {out}");
	assert_eq!(out["at28"], false, "one level to go: no way back offered, the guide just has you reach it: {out}");
}
