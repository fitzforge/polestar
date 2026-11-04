//! Riding reminder (addon/Polestar/QoL/Riding.lua + UI/GuideFrame.lua banner): fires a banner at levels 40 and
//! 60 when riding has not been learned, once per tier per character; gold-gated "Take me there" button; class
//! routing for Warlocks and Alliance Paladins.
//!
//! Section 1: banner rendering and interaction (stub_ui, like tests/ui.rs).
//! Section 2: Riding.lua unit logic (stub_qol, like the old riding test).

use forge_addontest::{emitted, text, truthy, Addon, RunAddon};
use serde_json::Value;

// ---------------------------------------------------------------------------
// Section 1: Banner (GuideFrame.lua "riding" notice kind)
// ---------------------------------------------------------------------------
// Runs the real Core + Theme + UI against stub_ui.lua — same pattern as tests/ui.rs. GuideFrame is loaded;
// QoL is NOT (the banner must work without QoL loaded, using the cost baked into the notice and the fallback
// money formatter).

const UI_FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const UI_PRELUDE: &str = "uistub.install()\nstub.login()\nlocal GF = Polestar.UI.GuideFrame\nlocal B = GF.parts.banner\nlocal TABS = { { uistub.elwynn, 3 } }\n";

fn run_ui(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", UI_FILES)], script: UI_PRELUDE.to_string() + script, ..Default::default() })
}

// ---- RIDING_DUE fires banner --------------------------------------------------

#[test]
fn riding_due_shows_a_riding_banner_icon_mount_title_body_dismiss_button() {
	// Before fix: no "riding" notice kind — banner would be absent.
	let out = run_ui(
		r#"
		uistub.openTabs(TABS, 1)
		local notice = { tier = 1, cost = 1000000,
			trainer = { map = 1429, x = 84.3, y = 64.9, npcName = "Randal Hunter" }, factionID = 72 }
		function GetMoney() return 1120000 end
		Polestar.Fire("RIDING_DUE", notice)
		emit({ shown = B:IsShown(),
			text  = B.Text:GetText(),
			close = B.Close:IsShown(),
			later = B.Later:IsShown(),
			jump  = B.Jump:IsShown(),
			jumpLabel = B.Jump:IsShown() and B.Jump.Label:GetText() or nil })
	"#,
	);
	let out = &out[0];
	assert_eq!(out["shown"], true, "banner visible");
	assert!(text(&out["text"]).contains("Level 40"), "title has level");
	assert!(text(&out["text"]).contains("100 g"), "body has cost");
	assert!(text(&out["text"]).contains("112 g"), "balance uses \"N g\" style with space");
	assert!(text(&out["text"]).contains("10% off at Honored"), "discount always shown");
	assert_eq!(out["close"], true, "dismiss × shown");
	assert_eq!(out["later"], false, "no Later button");
	assert_eq!(out["jump"], true, "Take me there shown when can afford");
	assert_eq!(out["jumpLabel"], "Take me there");
}

#[test]
fn riding_due_hides_take_me_there_when_player_cannot_afford() {
	// Before fix: no riding banner kind → jump button state irrelevant.
	let out = run_ui(
		r#"
		uistub.openTabs(TABS, 1)
		function GetMoney() return 430000 end   -- 43g < 100g
		Polestar.Fire("RIDING_DUE", { tier = 1, cost = 1000000,
			trainer = { map = 1429, x = 84.3, y = 64.9, npcName = "Randal Hunter" }, factionID = 72 })
		emit({ jump = B.Jump:IsShown(), close = B.Close:IsShown() })
	"#,
	);
	let out = &out[0];
	assert_eq!(out["jump"], false, "Take me there hidden when broke");
	assert_eq!(out["close"], true, "dismiss still shown");
}

#[test]
fn riding_due_with_classkind_warlock_shows_class_mount_text_and_always_shows_take_me_there() {
	let out = run_ui(
		r#"
		uistub.openTabs(TABS, 1)
		function GetMoney() return 0 end   -- 0g, but free for Warlock
		Polestar.Fire("RIDING_DUE", { tier = 1, cost = 0,
			trainer = { map = 1413, x = 62.6, y = 35.5, npcName = "Strahad Farsan" }, classKind = "WARLOCK" })
		emit({ text = B.Text:GetText(), jump = B.Jump:IsShown() })
	"#,
	);
	let out = &out[0];
	assert!(text(&out["text"]).contains("Warlock"), "Warlock class mount title");
	assert!(text(&out["text"]).contains("Felsteed"), "Felsteed quest chain in body");
	assert_eq!(out["jump"], true, "Take me there always shown for class mount");
}

#[test]
fn riding_due_with_classkind_paladin_shows_tome_of_nobility_text() {
	let out = run_ui(
		r#"
		uistub.openTabs(TABS, 1)
		function GetMoney() return 0 end
		Polestar.Fire("RIDING_DUE", { tier = 1, cost = 0,
			trainer = { map = 1453, x = 48.43, y = 50.22, npcName = "Lord Grayson Shadowbreaker" }, classKind = "PALADIN" })
		emit({ text = B.Text:GetText(), jump = B.Jump:IsShown() })
	"#,
	);
	let out = &out[0];
	assert!(text(&out["text"]).contains("Paladin"), "Paladin class mount title");
	assert!(text(&out["text"]).contains("Tome"), "Tome of Nobility in body");
	assert_eq!(out["jump"], true, "Take me there shown for class mount");
}

#[test]
fn tier_2_banner_shows_journeyman_riding_title_and_1_000_g_cost() {
	let out = run_ui(
		r#"
		uistub.openTabs(TABS, 1)
		function GetMoney() return 15000000 end
		Polestar.Fire("RIDING_DUE", { tier = 2, cost = 10000000,
			trainer = { map = 1429, x = 84.3, y = 64.9, npcName = "Randal Hunter" }, factionID = 72 })
		emit(B.Text:GetText())
	"#,
	);
	let out = text(&out[0]);
	assert!(out.contains("Journeyman"), "Journeyman Riding title");
	assert!(out.contains("1,000 g"), "1000g cost shown");
}

#[test]
fn banner_shows_honored_90_g_when_player_is_honored_with_home_faction() {
	// Before fix: discount was skipped when standing was nil; when Honored, showed "10% off" not price.
	let out = run_ui(
		r#"
		uistub.openTabs(TABS, 1)
		function GetMoney() return 1120000 end
		-- Override GetFactionStanding to return Honored (5) for Stormwind (72).
		Polestar.Compat.GetFactionStanding = function(id) if id == 72 then return 5 end end
		Polestar.Fire("RIDING_DUE", { tier = 1, cost = 900000, factionID = 72,
			trainer = { map = 1429, x = 84.3, y = 64.9, npcName = "Randal Hunter" } })
		emit(B.Text:GetText())
	"#,
	);
	let out = text(&out[0]);
	assert!(out.contains("Honored: 90 g"), "shows discounted price when Honored");
	assert!(!out.contains("10% off at Honored"), "does not double-show");
}

#[test]
fn banner_shows_10_off_at_honored_when_faction_standing_is_unknown() {
	// Before fix: when GetFactionStanding returns nil, the discount was dropped entirely.
	let out = run_ui(
		r#"
		uistub.openTabs(TABS, 1)
		function GetMoney() return 1120000 end
		-- Compat.GetFactionStanding returns nil (no faction data yet).
		Polestar.Compat.GetFactionStanding = function() return nil end
		Polestar.Fire("RIDING_DUE", { tier = 1, cost = 1000000, factionID = 72,
			trainer = { map = 1429, x = 84.3, y = 64.9, npcName = "Randal Hunter" } })
		emit(B.Text:GetText())
	"#,
	);
	assert!(text(&out[0]).contains("10% off at Honored"), "discount shown even when standing unknown");
}

// ---- Dismiss and Take me there -----------------------------------------------

#[test]
fn clicking_dismiss_hides_the_banner() {
	let out = run_ui(
		r#"
		uistub.openTabs(TABS, 1)
		function GetMoney() return 1120000 end
		Polestar.Fire("RIDING_DUE", { tier = 1, cost = 1000000,
			trainer = { map = 1429, x = 84.3, y = 64.9, npcName = "Randal Hunter" } })
		B.Close:Click()
		emit(B:IsShown())
	"#,
	);
	assert_eq!(out[0], false);
}

#[test]
fn clicking_take_me_there_sets_nav_arrow_to_trainer_and_hides_banner() {
	let out = run_ui(
		r#"
		uistub.openTabs(TABS, 1)
		function GetMoney() return 1120000 end
		Polestar.Fire("RIDING_DUE", { tier = 1, cost = 1000000,
			trainer = { map = 1429, x = 84.3, y = 64.9, npcName = "Randal Hunter" } })
		B.Jump:Click()
		local t = uistub.target
		emit({ hidden = not B:IsShown(), map = t and t.map, x = t and t.x, label = t and t.label })
	"#,
	);
	let out = &out[0];
	assert_eq!(out["hidden"], true, "banner hides after Take me there");
	assert_eq!(out["map"], 1429);
	assert_eq!(out["x"], 84.3);
	assert_eq!(out["label"], "Randal Hunter");
}

// ---- RIDING_MONEY re-renders button ------------------------------------------

#[test]
fn riding_money_re_renders_banner_adds_take_me_there_once_gold_crosses_threshold() {
	// Before fix: no RIDING_MONEY handler → button never appeared after level-up.
	let out = run_ui(
		r#"
		uistub.openTabs(TABS, 1)
		local copper = 430000   -- start broke
		function GetMoney() return copper end
		Polestar.Fire("RIDING_DUE", { tier = 1, cost = 1000000,
			trainer = { map = 1429, x = 84.3, y = 64.9, npcName = "Randal Hunter" } })
		emit(B.Jump:IsShown())       -- (1) broke: no button
		copper = 1120000             -- now can afford
		Polestar.Fire("RIDING_MONEY")
		emit(B.Jump:IsShown())       -- (2) rich: button appears
	"#,
	);
	assert_eq!(out[0], false, "no button when broke");
	assert_eq!(out[1], true, "button appears after RIDING_MONEY when affordable");
}

// ---- Riding banner after train banner priority --------------------------------

#[test]
fn training_banner_shows_first_riding_banner_shows_after_it_is_dismissed() {
	let out = run_ui(
		r#"
		uistub.openTabs(TABS, 1)
		function GetMoney() return 1120000 end
		Polestar.Fire("TRAIN_DUE", 12, { npc = 914, npcName = "Ander Germaine", map = 1453, x = 79.6, y = 70.2 })
		Polestar.Fire("RIDING_DUE", { tier = 1, cost = 1000000,
			trainer = { map = 1429, x = 84.3, y = 64.9, npcName = "Randal Hunter" } })
		emit(B.Text:GetText())         -- train has priority
		B.Later:Click()                -- dismiss train via Later
		emit(B.Text:GetText())         -- now riding shows
	"#,
	);
	let (first, second) = (text(&out[0]), text(&out[1]));
	assert!(first.contains("Level 12") || first.contains("class skills"), "train shows first");
	assert!(second.contains("Level 40") || second.contains("learn to ride"), "riding shows after");
}

// ---------------------------------------------------------------------------
// Section 2: Riding.lua unit logic (stub_qol)
// ---------------------------------------------------------------------------

const QOL_FILES: &[&str] = &["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"];

const PRELUDE: &str = r#"
local q  = stub.qol
local R  = Polestar.QoL.Riding
local C  = Polestar.Compat
local _ridingRank, _ridingMaxRank = nil, nil
local _spells = {}
local _quests = {}
local _factions = {}

C.GetSkillRank    = function(line) if line == 762 then return _ridingRank, _ridingMaxRank end end
C.IsSpellKnown    = function(id)  return _spells[id] == true end
C.IsQuestCompleted = function(id) return _quests[id] == true end
C.GetFactionStanding = function(id) return _factions[id] end

local function setRiding(tier)
    if tier == 1 then _ridingRank, _ridingMaxRank = 1, 75
    elseif tier == 2 then _ridingRank, _ridingMaxRank = 75, 150
    else _ridingRank, _ridingMaxRank = nil, nil end
end

local function setMoney(copper) q.money = copper end
local function setRep(fid, standing) _factions[fid] = standing end

-- defaults: Human WARRIOR Alliance
C.GetPlayerInfo = function() return { name="T", level=q.level, race="Human", class="WARRIOR", faction="Alliance" } end

local ridings = {}   -- captures from RIDING_DUE
Polestar.On("RIDING_DUE", function(n) ridings[#ridings + 1] = n end)

local function levelUp(n)
    q.level = n
    stub.fire("PLAYER_LEVEL_UP", n, 0,0,0,0,0,0,0,0)
    stub.runTimers()
end

local function enterWorld()
    stub.fire("PLAYER_ENTERING_WORLD")
    stub.runTimers()
end
"#;

fn run_qol_with(script: &str, saved: Option<&str>) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_qol.lua"],
		addons: vec![Addon::files("Polestar", QOL_FILES)],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		login: true,
		script: PRELUDE.to_string() + script,
		..Default::default()
	})
}

fn run_qol(script: &str) -> Vec<Value> {
	run_qol_with(script, None)
}

const SEEN_40: Option<&str> = Some("PolestarCharDB = { schema = 1, flags = { ridingReminder40 = true } }");

// ---- RIDING_DUE event fires instead of Print ---------------------------------

#[test]
fn riding_due_fires_at_level_40_when_riding_not_known() {
	let out = run_qol("levelUp(40); emit(#ridings)");
	assert_eq!(out[0], 1);
}

#[test]
fn riding_due_fires_with_correct_tier_and_trainer() {
	let out = run_qol("levelUp(40); emit(ridings[1])");
	let n = &out[0];
	assert_eq!(n["tier"], 1);
	assert!(truthy(&n["trainer"]), "has trainer");
	assert!(n["cost"].as_f64().unwrap() > 0.0, "cost baked in");
}

#[test]
fn no_riding_due_at_level_39() {
	let out = run_qol("levelUp(39); emit(#ridings)");
	assert_eq!(out[0], 0);
}

#[test]
fn no_riding_due_when_riding_apprentice_is_already_known() {
	let out = run_qol("setRiding(1); levelUp(40); emit(#ridings)");
	assert_eq!(out[0], 0);
}

#[test]
fn riding_due_fires_only_once_per_tier_second_check_is_silent() {
	let out = run_qol(
		r#"
		levelUp(40); emit(#ridings)
		ridings = {}
		R.Check(40); emit(#ridings)
	"#,
	);
	assert_eq!(out[0], 1);
	assert_eq!(out[1], 0);
}

#[test]
fn once_per_tier_note_flag_persists_across_reload() {
	let out = run_qol_with("levelUp(40); emit(#ridings)", SEEN_40);
	assert_eq!(out[0], 0);
}

// ---- Tier 2 ------------------------------------------------------------------

#[test]
fn riding_due_fires_at_level_60_when_only_apprentice_known() {
	let out = run_qol("setRiding(1); q.level=59; levelUp(60); emit(ridings[1])");
	let n = &out[0];
	assert!(truthy(n), "event fired");
	assert_eq!(n["tier"], 2);
}

#[test]
fn no_riding_due_at_60_when_journeyman_known() {
	let out = run_qol("setRiding(2); levelUp(60); emit(#ridings)");
	assert_eq!(out[0], 0);
}

// ---- PLAYER_ENTERING_WORLD ---------------------------------------------------

#[test]
fn riding_due_fires_on_login_for_level_40_character_who_has_not_seen_it() {
	let out = run_qol(
		r#"
		q.level = 40
		C.GetPlayerInfo = function() return { name="T", level=40, race="Human", class="WARRIOR", faction="Alliance" } end
		enterWorld(); emit(#ridings)
	"#,
	);
	assert_eq!(out[0], 1);
}

#[test]
fn no_riding_due_on_login_at_level_39() {
	let out = run_qol(
		r#"
		q.level = 39
		C.GetPlayerInfo = function() return { name="T", level=39, race="Human", class="WARRIOR", faction="Alliance" } end
		enterWorld(); emit(#ridings)
	"#,
	);
	assert_eq!(out[0], 0);
}

#[test]
fn login_silent_when_note_flag_already_set() {
	let out = run_qol_with(
		r#"
		q.level = 40
		C.GetPlayerInfo = function() return { name="T", level=40, race="Human", class="WARRIOR", faction="Alliance" } end
		enterWorld(); emit(#ridings)
	"#,
		SEEN_40,
	);
	assert_eq!(out[0], 0);
}

// ---- RIDING_MONEY fires when note set but not resolved -----------------------

#[test]
fn riding_money_fires_when_gold_changes_and_tier_is_pending() {
	let out = run_qol(
		r#"
		local moneyFired = 0
		Polestar.On("RIDING_MONEY", function() moneyFired = moneyFired + 1 end)
		levelUp(40)                           -- note fires, watcher registers
		stub.fire("PLAYER_MONEY")
		stub.runTimers()
		emit(moneyFired)
	"#,
	);
	assert!(out[0].as_f64().unwrap() >= 1.0, "RIDING_MONEY fired at least once");
}

#[test]
fn riding_money_stops_firing_after_onresolve_is_called() {
	let out = run_qol(
		r#"
		local count = 0
		Polestar.On("RIDING_MONEY", function() count = count + 1 end)
		levelUp(40)
		stub.fire("PLAYER_MONEY"); stub.runTimers()
		emit(count)
		R.OnResolve(1)
		count = 0
		stub.fire("PLAYER_MONEY"); stub.runTimers()
		emit(count)
	"#,
	);
	assert!(out[0].as_f64().unwrap() >= 1.0, "fires before resolve");
	assert_eq!(out[1], 0, "silent after resolve");
}

// ---- Class routing (RIDING_DUE carries correct trainer) ----------------------

#[test]
fn warlock_fires_with_classkind_warlock_and_strahad_farsan() {
	let out = run_qol(
		r#"
		C.GetPlayerInfo = function() return { name="T", level=q.level, race="Human", class="WARLOCK", faction="Alliance" } end
		levelUp(40); emit(ridings[1])
	"#,
	);
	let n = &out[0];
	assert_eq!(n["classKind"], "WARLOCK");
	assert_eq!(n["trainer"]["npcName"], "Strahad Farsan");
	assert_eq!(n["cost"], 0, "cost is 0 for class mount");
}

#[test]
fn alliance_paladin_fires_with_classkind_paladin_and_lord_grayson() {
	let out = run_qol(
		r#"
		C.GetPlayerInfo = function() return { name="T", level=q.level, race="Human", class="PALADIN", faction="Alliance" } end
		levelUp(40); emit(ridings[1])
	"#,
	);
	let n = &out[0];
	assert_eq!(n["classKind"], "PALADIN");
	assert_eq!(n["trainer"]["npcName"], "Lord Grayson Shadowbreaker");
}

#[test]
fn warlock_at_tier_2_fires_with_no_classkind_riding_trainer() {
	let out = run_qol(
		r#"
		C.GetPlayerInfo = function() return { name="T", level=q.level, race="Orc", class="WARLOCK", faction="Horde" } end
		setRiding(1); q.level=59; levelUp(60); emit(ridings[1])
	"#,
	);
	let n = &out[0];
	assert!(!truthy(&n["classKind"]), "no classKind at tier 2");
	assert_eq!(n["trainer"]["npcName"], "Kildar", "Orc trainer at tier 2");
}

#[test]
fn warlock_with_quest_4490_done_falls_back_to_race_trainer() {
	let out = run_qol(
		r#"
		_quests[4490] = true
		C.GetPlayerInfo = function() return { name="T", level=q.level, race="Human", class="WARLOCK", faction="Alliance" } end
		levelUp(40); emit(ridings[1])
	"#,
	);
	let n = &out[0];
	assert!(!truthy(&n["classKind"]), "no classKind after chain done");
	assert_eq!(n["trainer"]["npcName"], "Randal Hunter");
}

#[test]
fn undead_paladin_fires_with_riding_trainer_no_class_chain() {
	let out = run_qol(
		r#"
		C.GetPlayerInfo = function() return { name="T", level=q.level, race="Scourge", class="PALADIN", faction="Horde" } end
		levelUp(40); emit(ridings[1])
	"#,
	);
	let n = &out[0];
	assert!(!truthy(&n["classKind"]));
	assert_eq!(n["trainer"]["npcName"], "Velma Warnam");
}

// ---- EffectiveCost includes Honored discount ---------------------------------

#[test]
fn effectivecost_returns_900000_when_honored_with_home_faction() {
	let out = run_qol(
		r#"
		setRep(72, 5)    -- Honored with Stormwind
		emit(R.EffectiveCost(1, 72))
	"#,
	);
	assert_eq!(out[0], 900000);
}

#[test]
fn effectivecost_returns_full_1000000_when_not_honored() {
	let out = run_qol("emit(R.EffectiveCost(1, 72))");
	assert_eq!(out[0], 1000000);
}

// ---- option off --------------------------------------------------------------

#[test]
fn option_off_no_riding_due_fires() {
	let out = run_qol(
		r#"
		Polestar.Set("qol.ridingReminder", false)
		levelUp(40); emit(#ridings)
	"#,
	);
	assert_eq!(out[0], 0);
}

// ---- HasRiding ---------------------------------------------------------------

#[test]
fn hasriding_1_false_with_no_skill() {
	let out = run_qol("emit(R.HasRiding(1))");
	assert_eq!(out[0], false);
}

#[test]
fn hasriding_1_true_with_apprentice_rank() {
	let out = run_qol("setRiding(1); emit(R.HasRiding(1))");
	assert_eq!(out[0], true);
}

#[test]
fn hasriding_2_false_with_only_apprentice() {
	let out = run_qol("setRiding(1); emit(R.HasRiding(2))");
	assert_eq!(out[0], false);
}

#[test]
fn hasriding_2_true_with_journeyman() {
	let out = run_qol("setRiding(2); emit(R.HasRiding(2))");
	assert_eq!(out[0], true);
}

#[test]
fn hasriding_1_true_via_isspellknown_33388() {
	let out = run_qol("_spells[33388] = true; emit(R.HasRiding(1))");
	assert_eq!(out[0], true);
}
