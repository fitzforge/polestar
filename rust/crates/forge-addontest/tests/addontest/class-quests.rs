//! Class quests (addon/Polestar/QoL/ClassQuests.lua + the UI/GuideFrame.lua banner): when one of the character's
//! Class guides opens, the guide window offers it in a tab, once per guide; "Later" asks again at a higher level.
//!
//! Section 1: the banner (stub_ui, like tests/riding.rs).
//! Section 2: ClassQuests.lua (stub_qol), with the guides and the engine stubbed.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const UI_FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const UI_PRE: &str = r#"uistub.install()
stub.login()
local GF = Polestar.UI.GuideFrame
local B = GF.parts.banner
uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
local opened, resolved = {}, {}
Polestar.Engine.OpenTab = function(id) opened[#opened + 1] = id; return 2 end
Polestar.QoL = { ClassQuests = { Resolve = function(id, later) resolved[#resolved + 1] = { id = id, later = later or false } end } }
"#;

fn run_ui(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &UI_FILES)], script: format!("{UI_PRE}{script}"), ..Default::default() })
}

#[test]
fn class_quest_ready_shows_the_offer_the_guide_why_open_in_a_tab_and_later() {
	let out = run_ui(
		r#"
		Polestar.Fire("CLASS_QUEST_READY", { guideId = "forever/class/shaman/call-of-air-horde", title = "Call of Air", why = "The Air Totem." })
		emit({ shown = B:IsShown(), text = B.Text:GetText(), jump = B.Jump.Label:GetText(), later = B.Later:IsShown() and B.Later.Label:GetText(), close = B.Close:IsShown() })"#,
	);
	let out = &out[0];
	assert_eq!(out["shown"], true);
	assert_eq!(out["text"], "Class quest ready: Call of Air\nThe Air Totem.");
	assert_eq!(out["jump"], "Open in a tab");
	assert_eq!(out["later"], "Later");
	assert_eq!(out["close"], true);
}

#[test]
fn the_banner_opens_the_guide_in_a_tab_or_asks_again_later_or_is_dismissed_for_good() {
	let out = run_ui(
		r#"
		local n = { guideId = "g/one", title = "One" }
		Polestar.Fire("CLASS_QUEST_READY", n)
		B.Jump:Click()
		emit({ opened = opened, resolved = resolved[1], shown = B:IsShown() })
		Polestar.Fire("CLASS_QUEST_READY", n)
		B.Later:Click()
		emit(resolved[2])
		Polestar.Fire("CLASS_QUEST_READY", n)
		B.Close:Click()
		emit(resolved[3])"#,
	);
	assert_eq!(out[0], json!({ "opened": ["g/one"], "resolved": { "id": "g/one", "later": false }, "shown": false }));
	assert_eq!(out[1], json!({ "id": "g/one", "later": true }));
	assert_eq!(out[2], json!({ "id": "g/one", "later": false }));
}

// ---------------------------------------------------------------------------
// Section 2: ClassQuests.lua
// ---------------------------------------------------------------------------

fn qol_files() -> Addon {
	Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"])
}

// Three Class guides: a Shaman one that is open (no gate), a Shaman one that waits on level 30, and a Rogue one.
const PRELUDE: &str = r#"
local q = stub.qol
local C = Polestar.Compat
local CQ = Polestar.QoL.ClassQuests
Polestar.RegisterDefaults("behavior", { offerClassQuests = true })
local inLog, done = {}, {}
C.IsOnQuest = function(id) return inLog[id] == true end
C.IsQuestCompleted = function(id) return done[id] == true end
C.GetPlayerInfo = function() return { name = "T", level = q.level, race = "Orc", class = "SHAMAN", faction = "Horde" } end
local guides = {
	{ id = "c/fire", title = "Call of Fire", category = "Class", classes = { "SHAMAN" }, why = "The Fire Totem.", steps = { { goals = { { t = "accept", quest = 1 } } } } },
	{ id = "c/air", title = "Call of Air", category = "Class", classes = { "SHAMAN" }, steps = { { goals = { { t = "accept", quest = 2 } } } } },
	{ id = "c/poisons", title = "Poisons", category = "Class", classes = { "ROGUE" }, steps = { { goals = { { t = "accept", quest = 3 } } } } },
	{ id = "l/durotar", title = "Durotar", category = "Leveling", steps = { { goals = { { t = "accept", quest = 4 } } } } },
}
local byId = {}
for _, g in ipairs(guides) do byId[g.id] = g end
Polestar.Guides = {
	List = function() return guides end,
	Get = function(id) return byId[id] end,
	GuideMatches = function(g, p) return not g.classes or g.classes[1] == p.class end,
}
local gates = { ["c/air"] = { level = 30 } }
Polestar.Engine = {
	StartGate = function(id) return gates[id] end,
	GetGuideState = function() return "new" end,
}
local offers = {}
Polestar.On("CLASS_QUEST_READY", function(n) offers[#offers + 1] = n end)
local function levelUp(n)
	q.level = n
	stub.fire("PLAYER_LEVEL_UP", n, 0, 0, 0, 0, 0, 0, 0, 0)
	stub.advance(3)
end
"#;

fn run_qol(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_qol.lua"], addons: vec![qol_files()], login: true, script: format!("{PRELUDE}{script}"), ..Default::default() })
}

#[test]
fn only_the_class_guides_this_character_can_start_now_and_has_not_started_are_ready() {
	let out = run_qol(
		r#"
		q.level = 20
		local ids = {}
		for _, g in ipairs(CQ.Ready()) do ids[#ids + 1] = g.id end
		emit(ids)
		inLog[1] = true
		emit(#CQ.Ready())"#,
	);
	assert_eq!(out[0], json!(["c/fire"]), "not the gated one, not another class, not a leveling guide");
	assert_eq!(out[1], 0, "a quest of it in the log: under way");
}

#[test]
fn a_level_up_offers_one_guide_at_a_time_later_asks_again_at_a_higher_level_a_dismiss_never() {
	let out = run_qol(
		r#"
		levelUp(20)
		emit({ n = #offers, id = offers[1] and offers[1].guideId, why = offers[1] and offers[1].why })
		levelUp(21)
		emit(#offers)
		CQ.Resolve("c/fire", true)
		emit(#offers)
		levelUp(22)
		emit(#offers)
		CQ.Resolve("c/fire")
		levelUp(23)
		emit(#offers)"#,
	);
	assert_eq!(out[0], json!({ "n": 1, "id": "c/fire", "why": "The Fire Totem." }));
	assert_eq!(out[1], 1, "not again while the offer is up");
	assert_eq!(out[2], 1, "Later: not at this level");
	assert_eq!(out[3], 2, "again at a higher level");
	assert_eq!(out[4], 2, "dismissed for good");
}

#[test]
fn the_gated_guide_is_offered_once_its_gate_opens_nothing_with_the_setting_off() {
	let out = run_qol(
		r#"
		levelUp(20)
		CQ.Resolve("c/fire")
		gates["c/air"] = nil
		levelUp(30)
		emit(offers[#offers].guideId)
		Polestar.Set("behavior.offerClassQuests", false)
		CQ.Resolve("c/air", true)
		levelUp(31)
		emit(#offers)"#,
	);
	assert_eq!(out[0], "c/air");
	assert_eq!(out[1], 2);
}

// ---------------------------------------------------------------------------
// Section 3: the class-quest card (UI/ClassCard.lua) over a class quest's step
// ---------------------------------------------------------------------------

// The Cat Form chain as the Darkshore guide carries it (Druid steps, quest 98393 and on), with
// the class card's data (UI/ClassRewards.lua) and a client whose spell icons name the spell.
const CARD_PRE: &str = r#"uistub.install()
stub.login()
local GF = Polestar.UI.GuideFrame
local CC = Polestar.UI.ClassCard
GetSpellTexture = function(id) return "Interface\\Icons\\spell-" .. id end
GetItemIcon = function(id) return "Interface\\Icons\\item-" .. id end
Polestar.Compat.GetMapName = function(id) return ({ [1457] = "Darnassus", [1450] = "Moonglade" })[id] end
local function G(t, f) f.t = t; return f end
local DRUID = { classes = { "DRUID" } }
uistub.guides["test/darkshore"] = { id = "test/darkshore", pack = "guides", title = "Darkshore", faction = "Alliance", minLevel = 16, maxLevel = 21,
	category = "Leveling", zone = 1439, zoneName = "Darkshore", author = "Polestar", version = 1, steps = {
	{ title = "Mathrengyl Bearwalker", only = DRUID, goals = {
		G("accept", { verb = "Accept", subject = "The Great Cat Spirit", subjectKind = "quest", quest = 98393, npc = 4217, npcName = "Mathrengyl Bearwalker", minLevel = 20, map = 1457, x = 35.4, y = 8.4, status = "active" }),
	} },
	{ title = "Dendrite Starblaze", only = DRUID, goals = {
		G("turnin", { verb = "Turn in", subject = "The Great Cat Spirit", subjectKind = "quest", quest = 98393, npc = 11802, npcName = "Dendrite Starblaze", map = 1450, x = 56.2, y = 30.6, status = "pending" }),
		G("accept", { verb = "Accept", subject = "The Great Cat Spirit", subjectKind = "quest", quest = 98394, npc = 11802, npcName = "Dendrite Starblaze", minLevel = 20, map = 1450, x = 56.2, y = 30.6, status = "pending" }),
	} },
	{ title = "To Darnassus", only = DRUID, goals = {
		G("turnin", { verb = "Turn in", subject = "To Darnassus", subjectKind = "quest", quest = 98397, npc = 4217, npcName = "Mathrengyl Bearwalker", map = 1457, x = 35.4, y = 8.4, status = "pending" }),
	} },
	{ title = "Auberdine", goals = { G("accept", { verb = "Accept", subject = "Buzzbox 827", subjectKind = "quest", quest = 983, npc = 3663, npcName = "Gwennyth Bly'Leggonde", map = 1439, x = 36.6, y = 46.3, status = "pending" }) } },
} }
local function card()
	local f = CC.frame
	local on = f ~= nil and f:IsShown()
	-- The accept's goal row (not a summary line naming another person's accept).
	local row
	for _, r in ipairs(GF.rows) do
		local s = r:IsShown() and r.Text:GetText()
		if s and s:find("Accept |c", 1, true) then row = r.Text break end
	end
	return { shown = on, head = on and f.Head:GetText() or nil, title = on and f.Title:GetText() or nil, learn = on and f.Learn:GetText() or nil,
		badge = on and f.Badge:IsShown() and f.Badge.Text:GetText() or nil, trip = on and f.Trip:GetText() or nil,
		only = on and f.Only:GetText() or nil, icon = on and f.Icon:GetTexture() or nil, row = row and row:GetText() or nil,
		accept = on and f.Accept:IsShown() and f.Accept.Text:GetText() or nil }
end
"#;

fn run_card(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &UI_FILES)], script: format!("{CARD_PRE}{script}"), ..Default::default() })
}

#[test]
fn a_druid_on_a_druid_only_accept_sees_the_class_card_with_the_reward_spells_icon_a_warrior_does_not() {
	let out = run_card(
		r#"
		uistub.player.class, uistub.player.race, uistub.player.level = "DRUID", "NightElf", 20
		uistub.setGuide("test/darkshore", 1)
		emit(card())
		uistub.player.class = "WARRIOR"
		uistub.setStep(1)
		emit(card())"#,
	);
	let druid = &out[0];
	assert_eq!(druid["shown"], true, "{druid}");
	assert_eq!(druid["head"], "DRUID · LEVEL 20");
	assert_eq!(druid["title"], "The Great Cat Spirit");
	// Cat Form (768), the chain's final reward, from its own spell icon.
	assert_eq!(druid["icon"], "Interface\\Icons\\spell-768");
	assert!(druid["learn"].as_str().unwrap().starts_with("Learn ") && druid["learn"].as_str().unwrap().contains("Cat Form"), "{druid}");
	assert_eq!(druid["badge"], "NEW ABILITY");
	assert_eq!(druid["trip"], "Darnassus  ›  Moonglade  ›  Darnassus  ·  3 steps");
	assert_eq!(druid["only"], "Only you see this: it's your class's quest. Part of your route: just follow the guide.");
	// The accept reads inside the card, with its giver and zone; no row repeats the quest's name.
	assert_eq!(druid["accept"], "Accept from Mathrengyl Bearwalker, Darnassus");
	assert_eq!(druid["row"], Value::Null, "{druid}");
	// The spell in the class colour (Druid orange, lifted to read on Dusk), not the theme's quest
	// colour (ffffd673), which the Warrior's row keeps.
	assert_eq!(druid["learn"], "Learn |cfffe8f2fCat Form|r");
	let warrior = &out[1];
	assert_eq!(warrior["shown"], false, "{warrior}");
	assert_eq!(warrior["row"], "Accept |cffffd673The Great Cat Spirit|r");
}

// Only the quest data makes a class quest (UI/ClassRewards.lua's class mask), never a line's
// `only`: Michael's report (#812) had `only !Paladin` lines taken for the reader's own class quest
// (a Mage told to learn Redemption at Tirisfal's 99152, Warriors in Durotar carded for Vile
// Familiars), and `only Paladin` beside them made 99152 a Paladin quest though every class takes it.
#[test]
fn only_the_quest_data_makes_a_class_quest_never_a_line_s_only() {
	let out = run_card(
		r#"
		local function allBut(c)
			local out = {}
			for _, k in ipairs({ "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID" }) do
				if k ~= c then out[#out + 1] = k end
			end
			return { classes = out }
		end
		emit({
			mage = CC.ClassQuest({ t = "accept", quest = 99152, only = allBut("PALADIN") }, "MAGE"),
			paladin = CC.ClassQuest({ t = "accept", quest = 99152, only = { classes = { "PALADIN" } } }, "PALADIN"),
			warrior = CC.ClassQuest({ t = "accept", quest = 792, only = allBut("WARLOCK") }, "WARRIOR"),
			druid = CC.ClassQuest({ t = "accept", quest = 6361, only = { classes = { "DRUID" } } }, "DRUID"),
			catForm = CC.ClassQuest({ t = "accept", quest = 98393 }, "DRUID"),
			catFormWarrior = CC.ClassQuest({ t = "accept", quest = 98393 }, "WARRIOR"),
			stalk = CC.ClassQuest({ t = "accept", quest = 76160 }, "SHAMAN"),
		})"#,
	);
	assert_eq!(out[0], json!({ "mage": false, "paladin": false, "warrior": false, "druid": false, "catForm": true, "catFormWarrior": false, "stalk": false }));
}

// The class-quest audit: Mulgore's Druids ride to Thunder Bluff for A Bundle of Hides (6361) on an
// `only Druid` step, a detour of the route, and the card told them "it's your class's quest";
// every class can take it. The data-limited Cat Form chain keeps its card.
#[test]
fn a_druid_only_step_of_an_open_quest_shows_no_card_a_data_limited_druid_quest_does() {
	let out = run_card(
		r#"
		uistub.guides["test/mulgore"] = { id = "test/mulgore", pack = "guides", title = "Mulgore", faction = "Horde", minLevel = 1, maxLevel = 12,
			category = "Leveling", zone = 1412, zoneName = "Mulgore", author = "Polestar", version = 1, steps = {
			{ title = "Jahan Hawkwing", only = DRUID, goals = {
				G("accept", { verb = "Accept", subject = "A Bundle of Hides", subjectKind = "quest", quest = 6361, npc = 3390, npcName = "Jahan Hawkwing", minLevel = 10, map = 1413, x = 44.8, y = 59.1, status = "active" }),
			} },
		} }
		uistub.player.class, uistub.player.race, uistub.player.level = "DRUID", "Tauren", 10
		uistub.setGuide("test/mulgore", 1)
		emit(card())
		uistub.player.race, uistub.player.level = "NightElf", 20
		uistub.setGuide("test/darkshore", 1)
		emit(card())"#,
	);
	assert_eq!(out[0]["shown"], false, "{}", out[0]);
	assert_eq!(out[0]["row"], "Accept |cffffd673A Bundle of Hides|r");
	assert_eq!(out[1]["shown"], true, "{}", out[1]);
	assert_eq!(out[1]["title"], "The Great Cat Spirit");
}

// A Skyborne Druid's report (0.3.2): at Zephras Isle's "Denaaris Stargale" the card for Child of
// Nature (94912) said "Learn Bear Form" though he had learned it on the island 4 levels before
// (The Great Ursera Spirit, 94006). A chain whose reward is known or owned shows no card, taken
// or not; the accept is a row like any other.
const ZEPHRAS: &str = r#"
uistub.guides["test/zephras"] = { id = "test/zephras", pack = "guides", title = "Zephras Isle", faction = "Alliance", minLevel = 1, maxLevel = 10,
	category = "Leveling", zone = 1416, zoneName = "Alterac Mountains", author = "Polestar", version = 1, steps = {
	{ title = "Denaaris Stargale", goals = {
		G("accept", { verb = "Accept", subject = "Child of Nature", subjectKind = "quest", quest = 94912, npc = 270459, npcName = "Alfina Nightgaze", minLevel = 10, only = DRUID, status = "active" }),
		G("accept", { verb = "Accept", subject = "The Skyborne Portal", subjectKind = "quest", quest = 94947, npc = 270458, npcName = "Denaaris Stargale", status = "pending" }),
	} },
} }
KNOWN = {}
IsPlayerSpell = function(id) return KNOWN[id] == true end
uistub.player.class, uistub.player.race, uistub.player.level = "DRUID", "Skyborne", 10
local function box()
	local c = CC.frame and CC.frame.Accept.Check
	return { checked = c ~= nil and c:IsShown() and c:GetChecked() or false, line = CC.frame and CC.frame.Accept:IsShown() and CC.frame.Accept.Text:GetText() or nil }
end
"#;

#[test]
fn no_card_for_a_chain_whose_reward_the_character_already_knows() {
	let out = run_card(&format!(
		r#"{ZEPHRAS}
		uistub.setGuide("test/zephras", 1)
		emit(card())
		KNOWN[5487] = true -- Bear Form
		uistub.update()
		emit(card())"#
	));
	assert_eq!(out[0]["shown"], true, "{}", out[0]);
	assert_eq!(out[0]["learn"], "Learn |cfffe8f2fBear Form|r");
	assert_eq!(out[1]["shown"], false, "{}", out[1]);
	assert_eq!(out[1]["row"], "Accept |cffffd673Child of Nature|r");
}

// The same report: ticking the card's box "didn't do anything". The Engine keeps an accept open
// until the quest is in the log (a tick never stands for the quest, #739) and says so on the
// accept ("... isn't in your quest log"); the card showed neither the tick nor that line, so the
// box sprang back unticked. It now shows both, and a second click undoes the tick.
#[test]
fn the_card_s_tick_box_ticks_the_accept_and_shows_it_ticked_and_why_it_stays_open() {
	let out = run_card(&format!(
		r#"{ZEPHRAS}
		local toggled = {{}}
		Polestar.Engine.ToggleGoal = function(s, g)
			toggled[#toggled + 1] = s .. ":" .. g
			local goal = uistub.goal(s, g)
			goal.ticked = not goal.ticked
			goal.noticeText = goal.ticked and "Child of Nature isn't in your quest log" or nil
			uistub.update()
			return true
		end
		uistub.setGuide("test/zephras", 1)
		emit(box())
		stub.RunScript(CC.frame.Accept.Check, "OnClick", "LeftButton")
		emit(box())
		stub.RunScript(CC.frame.Accept.Check, "OnClick", "LeftButton")
		emit(box())
		emit(toggled)"#
	));
	assert_eq!(out[0], json!({ "checked": false, "line": "Accept from Alfina Nightgaze" }));
	assert_eq!(out[1], json!({ "checked": true, "line": "Child of Nature isn't in your quest log" }));
	assert_eq!(out[2], json!({ "checked": false, "line": "Accept from Alfina Nightgaze" }));
	assert_eq!(out[3], json!(["1:1", "1:1"]));
}

#[test]
fn a_reward_choice_reads_as_one_line_and_the_card_shines_and_chimes_once_per_chain() {
	let out = run_card(
		r#"
		uistub.player.class, uistub.player.level = "DRUID", 20
		stub.sounds = {}
		uistub.setGuide("test/darkshore", 1)
		local first = #stub.sounds
		uistub.setStep(2)
		uistub.setStep(1)
		emit({ first = first, again = #stub.sounds, seen = Polestar.CharState().classCardSeen ~= nil })
		local whirl = { kind = "weapon", show = "item", items = { 6975, 6977, 6976 }, itemNames = { "Whirlwind Axe", "Whirlwind Sword", "Whirlwind Warhammer" }, choice = true }
		emit({ line = CC.RewardLine(whirl), badge = CC.BadgeText(whirl), icon = CC.Icon(whirl, "WARRIOR") })"#,
	);
	assert_eq!(out[0]["first"], 1, "{}", out[0]);
	assert_eq!(out[0]["again"], 1, "{}", out[0]);
	assert_eq!(out[1]["line"], "Earn the Whirlwind Axe, Sword or Warhammer");
	assert_eq!(out[1]["badge"], "NEW WEAPON");
	assert_eq!(out[1]["icon"], "Interface\\Icons\\item-6975");
}

// Dun Morogh's Anvilmar step for a Gnome Mage (guides/forever/alliance/dwarf-gnome/01-dun-morogh.guide):
// Glyphic Memorandum from Sten Stoutarm, A New Threat from Balir Frosthammer next to him, the memorandum
// to Marryk Nurribit inside Anvilmar. `later` moves the hand-in to the next step.
const ANVILMAR: &str = r#"
Polestar.Compat.GetMapName = function(id) return ({ [1426] = "Dun Morogh" })[id] end
local MAGE = { classes = { "MAGE" } }
local function anvilmar(later)
	local memo = G("turnin", { verb = "Turn in", subject = "Glyphic Memorandum", subjectKind = "quest", quest = 3114, npc = 944, npcName = "Marryk Nurribit", only = MAGE, map = 1426, status = "active" })
	local first = {
		G("accept", { verb = "Accept", subject = "Glyphic Memorandum", subjectKind = "quest", quest = 3114, npc = 658, npcName = "Sten Stoutarm", only = MAGE, minLevel = 1, map = 1426, status = "active" }),
		G("accept", { verb = "Accept", subject = "A New Threat", subjectKind = "quest", quest = 170, npc = 713, npcName = "Balir Frosthammer", map = 1426, status = "active" }),
	}
	if not later then first[3] = memo end
	uistub.guides["test/dunmorogh"] = { id = "test/dunmorogh", pack = "guides", title = "Dun Morogh", faction = "Alliance", minLevel = 1, maxLevel = 10,
		category = "Leveling", zone = 1426, zoneName = "Dun Morogh", author = "Polestar", version = 1, steps = {
		{ title = "Anvilmar", goals = first },
		{ title = "The troggs", goals = { G("kill", { verb = "Kill", subject = "Rockjaw Trogg", subjectKind = "npc", npc = 707, status = "active" }), later and memo or nil } },
	} }
end
local function slim()
	local f = CC.frame
	local on = f ~= nil and f:IsShown()
	return { shown = on, slim = on and f.psSlim or false, ring = on and f.Ring:IsShown() or false, head = on and f.Head:IsShown() or false,
		only = on and f.Only:IsShown() and f.Only:GetText() or nil, trip = on and f.Trip:IsShown() or false,
		line = on and f.Accept:IsShown() and f.Accept.Text:GetText() or nil, check = on and f.Accept.Check:IsShown() or false,
		height = on and f:GetHeight() or 0, person = GF.parts.person.Name:GetText(),
		row = uistub.findText(GF.parts.card, "Glyphic Memorandum") and true or false,
		giverLine = uistub.findText(GF.parts.card, "Sten Stoutarm") and true or false }
end
uistub.player.class, uistub.player.race, uistub.player.level = "MAGE", "Gnome", 1
"#;

#[test]
fn once_the_class_quest_is_taken_the_card_folds_to_one_line_naming_who_gets_it_and_the_person_keeps_the_focus() {
	let out = run_card(&format!(
		r#"{ANVILMAR}
		anvilmar(false)
		uistub.setGuide("test/dunmorogh", 1)
		emit(slim())
		-- In the quest log: the engine says the accept is done.
		uistub.goal(1, 1).status = "done"
		uistub.update()
		emit(slim())
		-- Ticked by hand: the box stays so the tick can be undone.
		uistub.goal(1, 1).ticked = true
		uistub.update()
		emit(slim())
		-- Handed in: the card is gone, the accept a goal like any other (on the persons-done line, #843).
		uistub.goal(1, 1).ticked = false
		uistub.goal(1, 3).status = "done"
		uistub.update()
		emit(slim())"#
	));
	let before = &out[0];
	assert_eq!(before["slim"], false, "{before}");
	assert_eq!(before["ring"], true, "{before}");
	assert_eq!(before["head"], true, "{before}");
	assert_eq!(before["only"], "Only you see this: it's your class's quest. Part of your route: just follow the guide.");
	assert_eq!(before["line"], "Accept from Sten Stoutarm, Dun Morogh");
	assert_eq!(before["check"], true, "{before}");
	let taken = &out[1];
	assert_eq!(taken["shown"], true, "{taken}");
	assert_eq!(taken["slim"], true, "{taken}");
	assert_eq!(taken["ring"], false, "{taken}");
	assert_eq!(taken["head"], false, "{taken}");
	assert_eq!(taken["trip"], false, "{taken}");
	assert_eq!(taken["only"], Value::Null, "{taken}");
	assert_eq!(taken["line"], "Mage quest taken: hand it in to Marryk Nurribit");
	// The quest log says it is taken: no tick box that could read as the step done.
	assert_eq!(taken["check"], false, "{taken}");
	assert!(taken["height"].as_f64().unwrap() < before["height"].as_f64().unwrap() / 2.0, "{taken} vs {before}");
	assert_eq!(taken["person"], "Balir Frosthammer", "{taken}");
	let ticked = &out[2];
	assert_eq!(ticked["slim"], true, "{ticked}");
	assert_eq!(ticked["check"], true, "{ticked}");
	let handed = &out[3];
	assert_eq!(handed["shown"], false, "{handed}");
	assert_eq!(handed["giverLine"], true, "the accept's giver stays on the card, on the line of the persons done: {handed}");
}

#[test]
fn a_hand_in_in_a_later_step_reads_later_in_this_guide() {
	let out = run_card(&format!(
		r#"{ANVILMAR}
		anvilmar(true)
		uistub.setGuide("test/dunmorogh", 1)
		uistub.goal(1, 1).status = "done"
		uistub.update()
		emit(slim())"#
	));
	assert_eq!(out[0]["slim"], true, "{}", out[0]);
	assert_eq!(out[0]["line"], "Mage quest taken: hand it in to Marryk Nurribit, later in this guide");
}

// ---------------------------------------------------------------------------
// Section 4: the class quest heads-up (UI/ClassToast.lua) and its new tab
// ---------------------------------------------------------------------------

// A Warlock class guide with three chains in order (Imp, Voidwalker, Succubus: the Orc's quests,
// Ruzan, Ophek and Gan'rul Bloodeye), a Druid one for Cat Form, and a Durotar leveling guide that
// takes the Voidwalker chain at its third step.
const TOAST_PRE: &str = r#"uistub.install()
stub.login()
local GF = Polestar.UI.GuideFrame
local CT = Polestar.UI.ClassToast
GetSpellTexture = function(id) return "Interface\\Icons\\spell-" .. id end
Polestar.Compat.GetMapName = function(id) return ({ [1411] = "Durotar", [1454] = "Orgrimmar", [1457] = "Darnassus", [1420] = "Tirisfal Glades" })[id] end
-- What the character already has, and the quests it has done or holds.
KNOWN, OWNED, DONE, INLOG = {}, {}, {}, {}
IsPlayerSpell = function(id) return KNOWN[id] == true end
GetItemCount = function(id) return OWNED[id] or 0 end
Polestar.Compat.IsQuestCompleted = function(q) return DONE[q] == true end
Polestar.Compat.IsOnQuest = function(q) return INLOG[q] == true end
local function G(t, f) f.t = t; return f end
local function q(t, id, title, npc, status) return G(t, { verb = t == "accept" and "Accept" or "Turn in", subject = title, subjectKind = "quest", quest = id, npcName = npc, status = status or "pending" }) end
local function add(g) uistub.guides[g.id] = g; table.insert(uistub.order, g.id) end
add({ id = "test/class/warlock", pack = "guides", title = "Warlock demons", category = "Class", classes = { "WARLOCK" }, minLevel = 1, maxLevel = 30,
	zone = 1411, zoneName = "Durotar", author = "Polestar", version = 1, steps = {
	{ title = "Ruzan", goals = { q("accept", 1485, "Vile Familiars", "Ruzan", "active") } },
	{ title = "Vile Familiars", goals = { q("turnin", 1485, "Vile Familiars", "Ruzan") } },
	{ title = "Ophek", goals = { q("accept", 1506, "Gan'rul's Summons", "Ophek") } },
	{ title = "Creature of the Void", goals = { q("turnin", 1506, "Gan'rul's Summons", "Gan'rul Bloodeye"), q("accept", 1501, "Creature of the Void", "Gan'rul Bloodeye") } },
	{ title = "Gan'rul Bloodeye", goals = { q("accept", 1507, "Devourer of Souls", "Gan'rul Bloodeye") } },
	{ title = "Blind Cazul", goals = { q("turnin", 1507, "Devourer of Souls", "Blind Cazul") } },
} })
add({ id = "test/class/cat-form", pack = "guides", title = "Cat Form", category = "Class", classes = { "DRUID" }, minLevel = 20, maxLevel = 22,
	zone = 1457, zoneName = "Darnassus", author = "Polestar", version = 1, steps = {
	{ title = "Mathrengyl Bearwalker", goals = { q("accept", 98393, "The Great Cat Spirit", "Mathrengyl Bearwalker", "active") } },
	{ title = "To Darnassus", goals = { q("turnin", 98397, "To Darnassus", "Mathrengyl Bearwalker") } },
} })
add({ id = "test/durotar", pack = "guides", title = "Durotar", faction = "Horde", category = "Leveling", minLevel = 1, maxLevel = 12,
	zone = 1411, zoneName = "Durotar", author = "Polestar", version = 1, steps = {
	{ title = "Thunder Ridge", goals = { G("kill", { verb = "Kill", subject = "Thunder Lizard", subjectKind = "npc", npc = 3130, status = "active" }) } },
	{ title = "Razor Hill", goals = { G("note", { text = "Step 2", status = "pending" }) } },
	{ title = "Orgrimmar", only = { classes = { "WARLOCK" } }, goals = { q("accept", 1506, "Gan'rul's Summons", "Ophek") } },
} })
local function toast()
	local f, m = CT.frame, CT.current
	local on = f ~= nil and f:IsShown()
	return { shown = on, quest = m and m.quest or nil, title = on and f.Title:GetText() or nil, giver = on and f.Giver:IsShown() and f.Giver:GetText() or nil,
		route = on and f.Route:IsShown() and f.Route:GetText() or nil, open = on and f.Open:IsShown() or false, showMe = on and f.ShowMe:IsShown() or false, badge = on and f.Badge:IsShown() and f.Badge.Text:GetText() or nil,
		icon = on and f.Icon:GetTexture() or nil, side = on and CT.side or nil }
end
local function who(class, race, faction, level) uistub.player.class, uistub.player.race, uistub.player.faction, uistub.player.level = class, race, faction, level end
"#;

fn run_toast(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &UI_FILES)], script: format!("{TOAST_PRE}{script}"), ..Default::default() })
}

#[test]
fn a_druid_reaching_20_gets_the_cat_form_heads_up_once_a_warrior_does_not() {
	let out = run_toast(
		r#"
		who("DRUID", "NightElf", "Alliance", 19)
		stub.sounds = {}
		stub.fire("PLAYER_LEVEL_UP", 20)
		emit(toast())
		CT.Hide()
		stub.fire("PLAYER_LEVEL_UP", 20)
		emit({ again = CT.frame:IsShown(), sounds = #stub.sounds })
		uistub.player.class, uistub.player.race, uistub.player.level = "WARRIOR", "Human", 19
		Polestar.CharState().classToastSeen = nil
		CT.Hide()
		stub.fire("PLAYER_LEVEL_UP", 20)
		emit(toast())"#,
	);
	let druid = &out[0];
	assert_eq!(druid["shown"], true, "{druid}");
	assert_eq!(druid["quest"], 98393);
	assert_eq!(druid["title"], "Cat Form ready");
	assert_eq!(druid["giver"], "Get it from Mathrengyl Bearwalker, Darnassus.");
	assert_eq!(druid["icon"], "Interface\\Icons\\spell-768");
	assert_eq!(druid["badge"], "NEW ABILITY");
	assert_eq!(druid["open"], true, "the Cat Form class guide is there: {druid}");
	// Once per quest per character; the chime once.
	assert_eq!(out[1], json!({ "again": false, "sounds": 1 }), "the level-up again shows nothing new");
	let warrior = &out[2];
	assert_ne!(warrior["quest"], 98393, "{warrior}");
	assert!(!warrior["title"].as_str().unwrap_or("").contains("Cat Form"), "{warrior}");
}

#[test]
fn open_in_a_new_tab_lands_each_chain_on_its_own_section_of_the_class_guide() {
	let out = run_toast(
		r#"
		uistub.player.class, uistub.player.race, uistub.player.faction, uistub.player.level = "WARLOCK", "Orc", "Horde", 10
		uistub.openTabs({ { "test/durotar", 1 } }, 1)
		local E = Polestar.Engine
		CT.Show(1506)
		emit(toast())
		CT.Open()
		local tabs, active = E.GetTabs()
		emit({ tabs = #tabs, guide = E.GetGuide().id, step = E.GetStepIndex(), toast = CT.frame:IsShown(),
			back = Polestar.CharState().classReturn and Polestar.CharState().classReturn["test/class/warlock"] })
		-- The card on the landing step folds the accept in: no row of its own repeats the quest.
		local CC = Polestar.UI.ClassCard
		emit({ card = CC.frame:IsShown(), accept = CC.frame.Accept:IsShown() and CC.frame.Accept.Text:GetText() or false,
			row = uistub.findText(GF.parts.card, "Accept |c") ~= nil })
		for _, quest in ipairs({ 1485, 1507 }) do
			E.SelectTab(1)
			CT.Show(quest)
			CT.Open()
			emit({ quest = quest, guide = E.GetGuide().id, step = E.GetStepIndex(), tabs = #(E.GetTabs()) })
		end
		-- No class guide for the chain: no button; Later dismisses.
		uistub.guides["test/class/warlock"].category = "Leveling"
		CT.Show(1506)
		local open = CT.frame.Open:IsShown()
		CT.frame.Later:Click()
		emit({ open = open, shown = CT.frame:IsShown() })"#,
	);
	let t = &out[0];
	assert_eq!(t["title"], "Voidwalker ready");
	assert_eq!(t["giver"], "Get it from Ophek, Durotar.");
	assert_eq!(t["route"], "Your route takes you there at Orgrimmar.");
	assert_eq!(t["badge"], "NEW PET");
	assert_eq!(t["open"], true);
	// A new tab on the Voidwalker's accept (step 3), not the Imp at step 1; the leveling tab stays.
	assert_eq!(out[1], json!({ "tabs": 2, "guide": "test/class/warlock", "step": 3, "toast": false, "back": "test/durotar" }));
	assert_eq!(out[2]["card"], true);
	assert_eq!(out[2]["accept"], "Accept from Ophek");
	assert_eq!(out[2]["row"], false, "{}", out[2]);
	// Each chain on its own section, in the tab already open.
	assert_eq!(out[3], json!({ "quest": 1485, "guide": "test/class/warlock", "step": 1, "tabs": 2 }));
	assert_eq!(out[4], json!({ "quest": 1507, "guide": "test/class/warlock", "step": 5, "tabs": 2 }));
	assert_eq!(out[5], json!({ "open": false, "shown": false }));
}

#[test]
fn a_finished_class_guide_offers_to_close_its_tab_and_go_back_to_the_leveling_tab() {
	let out = run_toast(
		r#"
		uistub.player.class, uistub.player.race, uistub.player.faction, uistub.player.level = "WARLOCK", "Orc", "Horde", 10
		uistub.openTabs({ { "test/durotar", 2 } }, 1)
		local E = Polestar.Engine
		CT.Show(1506)
		CT.Open()
		uistub.complete()
		local e = GF.parts.empty
		emit({ text = e.Text:GetText(), primary = e.Primary.Label and e.Primary.Label:GetText() or nil })
		e.Primary.psAction()
		local tabs = E.GetTabs()
		emit({ tabs = #tabs, guide = E.GetGuide().id, step = E.GetStepIndex() })"#,
	);
	let text = out[0]["text"].as_str().unwrap();
	assert!(text.starts_with("Your class quest is done. Back to |c") && text.ends_with("Durotar|r."), "{}", out[0]);
	assert_eq!(out[0]["primary"], "Close and return");
	assert_eq!(out[1], json!({ "tabs": 1, "guide": "test/durotar", "step": 2 }));
}

#[test]
fn the_heads_up_sits_on_the_guide_window_follows_it_and_hides_with_it() {
	let out = run_toast(
		r#"
		who("WARLOCK", "Orc", "Horde", 10)
		uistub.openTabs({ { "test/durotar", 1 } }, 1)
		CT.Show(1506)
		local f, w = CT.frame, GF.frame
		local p, rel, rp = f:GetPoint(1)
		emit({ side = CT.side, point = p, rel = rel == w, relPoint = rp, width = f:GetWidth() == w:GetWidth(), behind = f:GetFrameLevel() < w:GetFrameLevel(),
			strata = f:GetFrameStrata() == w:GetFrameStrata() })
		w:Hide()
		local hidden = f:IsShown()
		w:Show()
		emit({ hidden = hidden, back = f:IsShown() })
		-- No room above the window: under it.
		w.y = UIParent.height - w:GetHeight() + 10
		CT.Place(false)
		local p2, _, rp2 = f:GetPoint(1)
		emit({ side = CT.side, point = p2, relPoint = rp2 })"#,
	);
	assert_eq!(out[0], json!({ "side": "above", "point": "BOTTOMLEFT", "rel": true, "relPoint": "TOPLEFT", "width": true, "behind": true, "strata": true }));
	assert_eq!(out[1], json!({ "hidden": false, "back": true }));
	assert_eq!(out[2], json!({ "side": "below", "point": "TOPLEFT", "relPoint": "BOTTOMLEFT" }));
}

#[test]
fn no_heads_up_for_a_reward_already_known_or_owned_or_a_chain_already_taken() {
	let out = run_toast(
		r#"
		who("DRUID", "NightElf", "Alliance", 19)
		KNOWN[768] = true
		stub.fire("PLAYER_LEVEL_UP", 20)
		emit({ known = CT.frame ~= nil and CT.frame:IsShown() or false })
		KNOWN[768] = nil
		DONE[98394] = true -- a later quest of the Cat Form chain
		stub.fire("PLAYER_LEVEL_UP", 20)
		emit({ done = CT.frame ~= nil and CT.frame:IsShown() or false })
		DONE[98394] = nil
		INLOG[98393] = true
		stub.fire("PLAYER_LEVEL_UP", 20)
		emit({ inlog = CT.frame ~= nil and CT.frame:IsShown() or false })
		-- An item reward in the bags or the bank: the Whirlwind weapon, for a Warrior at 30.
		INLOG[98393] = nil
		who("WARRIOR", "Human", "Alliance", 30)
		OWNED[6977] = 1
		local whirl = false
		for _, q in ipairs(CT.Candidates(30, "any")) do
			local r = Polestar.ClassRewards.rewards[Polestar.ClassRewards.quests[q][3]]
			if r.items and r.items[1] == 6975 then whirl = true end
		end
		emit({ whirlwind = whirl, known = CT.RewardKnown({ items = { 6975, 6977, 6976 } }) })
		-- Nothing in the way: the Druid hears of it once.
		who("DRUID", "NightElf", "Alliance", 19)
		stub.fire("PLAYER_LEVEL_UP", 20)
		emit(toast())"#,
	);
	assert_eq!(out[0], json!({ "known": false }));
	assert_eq!(out[1], json!({ "done": false }));
	assert_eq!(out[2], json!({ "inlog": false }));
	assert_eq!(out[3], json!({ "whirlwind": false, "known": true }));
	assert_eq!(out[4]["quest"], 98393, "{}", out[4]);
}

#[test]
fn login_tells_only_of_chains_opened_in_the_last_two_levels_and_never_of_level_1_ones() {
	let out = run_toast(
		r#"
		local seen = {}
		for _, lvl in ipairs({ 20, 22, 23 }) do
			who("DRUID", "NightElf", "Alliance", lvl)
			Polestar.CharState().classToastSeen = nil
			local list = CT.Candidates(lvl, "login")
			local has = false
			for _, q in ipairs(list) do if q == 98393 then has = true end end
			seen[#seen + 1] = has
		end
		-- The Undead Warlock of the report: level 7 after login. The Imp (level 1) is learned at
		-- the start; nothing else has opened.
		who("WARLOCK", "Scourge", "Horde", 7)
		Polestar.CharState().classToastSeen = nil
		emit({ cat = seen, warlock7 = #CT.Candidates(7, "login"), any = #CT.Candidates(7, "any") })"#,
	);
	assert_eq!(out[0], json!({ "cat": [true, true, false], "warlock7": 0, "any": 0 }));
}

#[test]
fn the_giver_is_the_one_for_the_characters_race_and_without_a_class_guide_show_me_points_the_arrow() {
	let out = run_toast(
		r#"
		-- An Undead Warlock reaching 10: the Voidwalker from Ageron Kargal in Tirisfal, never
		-- Ophek, the Orcs' and Trolls' giver in Durotar.
		who("WARLOCK", "Scourge", "Horde", 9)
		stub.fire("PLAYER_LEVEL_UP", 10)
		emit(toast())
		emit({ orcStart = CT.Model(1506) ~= nil, undeadStart = CT.Model(1478) ~= nil })
		-- No class guide takes that chain: "Show me" puts the arrow on the giver.
		CT.frame.ShowMe:Click()
		emit({ target = uistub.target and uistub.target.label, map = uistub.target and uistub.target.map, shown = CT.frame:IsShown() })"#,
	);
	let t = &out[0];
	assert_eq!(t["quest"], 1478, "{t}");
	assert_eq!(t["title"], "Voidwalker ready");
	assert_eq!(t["giver"], "Get it from Ageron Kargal, Tirisfal Glades.");
	assert_eq!(t["open"], false);
	assert_eq!(t["showMe"], true);
	assert_eq!(out[1], json!({ "orcStart": false, "undeadStart": true }));
	assert_eq!(out[2], json!({ "target": "Ageron Kargal", "map": 1420, "shown": false }));
}

// Fitz, 2026-11-05: "NEW WEAPON" crowded the quest's name. With a badge the title starts
// below the badge (10 down, 20 high) with a gap, never beside or under it.
#[test]
fn the_class_card_title_starts_below_the_reward_badge() {
	let out = run_card(
		r#"
		uistub.player.class, uistub.player.race, uistub.player.level = "DRUID", "NightElf", 20
		uistub.setGuide("test/darkshore", 1)
		local f = CC.frame
		local _, _, _, _, ty = f.Title:GetPoint(1)
		local _, _, _, _, by = f.Badge:GetPoint(1)
		emit({ badge = f.Badge:IsShown(), titleTop = -ty, badgeBottom = -by + f.Badge:GetHeight() })"#,
	);
	let r = &out[0];
	assert_eq!(r["badge"], true, "{r}");
	assert!(r["titleTop"].as_f64().unwrap() >= r["badgeBottom"].as_f64().unwrap() + 4.0, "{r}");
}
