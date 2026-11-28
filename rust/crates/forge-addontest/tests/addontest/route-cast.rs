//! The route's own cast (addon/Polestar/QoL/Buttons.lua Buttons.RouteCast, Nav/Travel.lua LegIcon, LegLabel and
//! WaitText): a teleport leg (a Mage's Teleport: Undercity, a Druid's Teleport: Moonglade, a Shaman's Astral Recall)
//! or a hearth leg shows its own icon in the Journey, and the Hearthstone's slot offers it as a secure button the step
//! key casts too. A hearth or teleport still on its cooldown counts it down in the Journey and on the arrow, and the
//! button waits greyed with its sweep. Runs the real addon on its own travel data and the client's map frames (no
//! reference data: skipped).

use crate::mage_teleports::{maps, HELPERS};
use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

/// What every trial reads: the Hearthstone's slot, the step key, the Journey's rows, and every call the game forbids
/// an addon (#4503's rule: a protected function, or a secure frame changed in combat).
const PRELUDE: &str = r#"
B, J, A = Polestar.QoL.Buttons, Polestar.UI.JourneyPanel, N.arrow
H, KEY = PolestarHearthButton, PolestarStepButton
ORG, UNDERCITY, TANARIS, RAZOR, NIGHTHAVEN = { 1454, 50, 60 }, { 1458, 66, 38 }, { 1446, 52, 28 }, { 1411, 51, 41 }, { 1450, 50, 60 }
MAGE = { 3563, 3566, 3567 }
NAMES = { [3563] = "Teleport: Undercity", [3566] = "Teleport: Thunder Bluff", [3567] = "Teleport: Orgrimmar", [18960] = "Teleport: Moonglade", [556] = "Astral Recall" }
function GetSpellInfo(id) return NAMES[id] end
function GetSpellTexture(id) return 900000 + id end
stub.world.itemInfo[6948] = { name = "Hearthstone", icon = 134414 }
-- Spell cooldowns: cd[spell] = { start, duration }.
cd = {}
function GetSpellCooldown(id) local c = cd[id]; if c and GetTime() < c[1] + c[2] then return c[1], c[2], 1 end return 0, 0, 1 end
-- The Hearthstone's cooldown from `start` for `duration` seconds (nil: ready).
function stone(start, duration)
	local f = function(id) if start and id == 6948 and GetTime() < start + duration then return start, duration, 1 end return 0, 0, 1 end
	C_Container = C_Container or {}
	C_Container.GetItemCooldown = f
	if C_Item then C_Item.GetItemCooldown = f end
	GetItemCooldown = f
end
forbidden = {}
for _, name in ipairs({ "CastSpellByName", "CastSpellByID", "UseItemByName", "UseContainerItem", "SetRaidTarget", "SpellStopCasting" }) do
	_G[name] = function() forbidden[#forbidden + 1] = name end
end
for _, m in ipairs({ "SetAttribute", "Show", "Hide", "SetPoint", "ClearAllPoints", "SetScale" }) do
	local o = stub.Methods[m]
	stub.Methods[m] = function(self, ...)
		if stub.inCombat and type(self.template) == "string" and self.template:find("Secure") then forbidden[#forbidden + 1] = tostring(self.name) .. ":" .. m end
		return o(self, ...)
	end
end
function combat(on)
	stub.inCombat = on
	stub.fire(on and "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED")
	stub.advance(0.1)
end
H.Cooldown.SetCooldown = function(self, s, d) self.cd = d end
H.Cooldown.Clear = function(self) self.cd = false end
-- Clicks run the secure action as the client does (stub.keyClick, stub.mouseClick): stub_world marks no frame secure.
H.secure, KEY.secure = true, true
function button()
	return { shown = H:IsShown(), type = H:GetAttribute("type") or false, spell = H:GetAttribute("spell") or false, item = H:GetAttribute("item") or false,
		icon = H.Icon:GetTexture() or false, grey = H.Icon.desaturated or false, sweep = H.Cooldown.cd or false }
end
-- What the step key would do, and what a press of it runs.
function key()
	local kind, value = B.StepAction()
	local ran = {}
	stub.keyClick(KEY, ran)
	return { kind or false, value or false, ran[1] and ran[1][1] or false, ran[1] and ran[1][2] or false }
end
-- The Journey as it draws the live route's legs (a sample panel): each row's icon and text.
function journey()
	local legs, ci = N.GetRoute()
	local s = J.Sample(UIParent)
	local left = {}
	for i = ci or 1, legs and #legs or 0 do left[#left + 1] = legs[i] end
	s.legs = left
	s.Layout(320)
	local rows = {}
	for _, r in ipairs(s.rows) do
		if r:IsShown() then rows[#rows + 1] = { r.Icon:GetTexture() or false, r.Text:GetText() or false } end
	end
	return rows
end
-- The arrow: its mode, its caption, its leg icon and whether that is greyed.
function arrow()
	return { A.GetMode() or false, A.distText:GetText() or false, A.legIcon:GetTexture() or false, A.legIcon.desaturated or false }
end
function plan(spec)
	local t = trial(spec)
	stub.advance(1)
	return t.first
end
"#;

/// The real addon: a Horde `class` of `race` at `level`, `guides` registered before login, `script` after it.
fn run(race: &str, class: &str, level: u32, guides: &str, script: &str) -> Option<Value> {
	let maps = maps()?;
	let raceid = match race {
		"Orc" => 2,
		"Tauren" => 6,
		other => panic!("no race id for {other}"),
	};
	let before = format!(
		"local w = stub.world\n{maps}w.race, w.raceName, w.raceID, w.faction = \"{race}\", \"{race}\", {raceid}, \"Horde\"\nw.class, w.className = \"{}\", \"{}\"\nw.level = {level}\nw.moveTo(1411, 51, 41)\n",
		class.to_uppercase(),
		class
	);
	let script = format!("{TEST_PACK}\n{TEST_SOURCE}\n{guides}\nstub.login()\nstub.fire(\"QUEST_LOG_UPDATE\")\n{HELPERS}\n{PRELUDE}\n{script}");
	let addons = vec![Addon::name("Polestar"), Addon::files("Polestar_Guides", &["MapFrames.lua"])];
	Some(emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons, script, ..Default::default() }).remove(0))
}

const TELEPORT_UNDERCITY: &str = "Teleport: Undercity";

// A Mage with a rune, from Orgrimmar to the Undercity: the Journey's first row is the teleport with its spell's icon,
// the Hearthstone's slot is a secure spell button for Teleport: Undercity (its tooltip names it) and the step key casts
// it. The travel button under the arrow steps aside for it. On a flight the slot goes and the key passes it over; with
// the rune used up, or the spell not known, there is none.
#[test]
fn a_mage_with_a_rune_gets_teleport_undercity_in_the_hearthstone_slot_and_on_the_step_key() {
	let Some(out) = run(
		"Orc",
		"Mage",
		50,
		"",
		r#"
		local r = {}
		r.first = plan{ from = ORG, to = UNDERCITY, spells = MAGE, runes = 1 }
		r.journey = journey()
		r.button = button()
		r.key = key()
		GameTooltip.SetSpellByID = function(self, id) self:AddLine(NAMES[id] or tostring(id)) end
		stub.RunScript(H, "OnEnter")
		r.tip = GameTooltip.lines[1] or false
		stub.RunScript(H, "OnLeave")
		local ran = {}
		stub.mouseClick(H, ran)
		r.click = ran[1] or false
		r.travelButton = PolestarTravelButton ~= nil and PolestarTravelButton:IsShown() or false
		-- A flight: no button, the key passes over the cast; back on landing.
		stub.world.onTaxi = true
		stub.fire("PLAYER_CONTROL_LOST"); stub.advance(1)
		r.taxi = { button().shown, key() }
		stub.world.onTaxi = false
		stub.fire("PLAYER_CONTROL_GAINED"); stub.advance(1)
		r.landed = button().shown
		-- The rune used up while the leg still says teleport: none.
		stub.world.items[17031] = nil
		stub.fire("BAG_UPDATE_DELAYED"); stub.advance(1)
		r.noRune = { button().shown, key() }
		-- A route without the rune, and one without the spell: no teleport leg, no button.
		r.noRunePlan = plan{ from = ORG, to = UNDERCITY, spells = MAGE, runes = 0 }
		r.noRunePlanButton = button().shown
		r.noSpellPlan = plan{ from = ORG, to = UNDERCITY, spells = {}, runes = 1 }
		r.noSpell = { button().shown, key() }
		r.forbidden = table.concat(forbidden, ", ")
		emit(r)"#,
	) else {
		return;
	};
	assert_eq!(out["first"], "teleport|Cast Teleport: Undercity", "{out}");
	assert_eq!(out["journey"][0], json!([903563, "Cast Teleport: Undercity"]), "the teleport's row has its spell's icon: {out}");
	assert_eq!(out["button"]["shown"], true, "{out}");
	assert_eq!(out["button"]["type"], "spell", "a secure spell button: {out}");
	assert_eq!(out["button"]["spell"], TELEPORT_UNDERCITY, "{out}");
	assert_eq!(out["button"]["icon"], 903563, "{out}");
	assert_eq!(out["button"]["grey"], false, "{out}");
	assert_eq!(out["key"], json!(["spell", 3563, "spell", TELEPORT_UNDERCITY]), "the step key casts it: {out}");
	assert_eq!(out["tip"], TELEPORT_UNDERCITY, "the tooltip names the spell: {out}");
	assert_eq!(out["click"], json!(["spell", TELEPORT_UNDERCITY]), "a click casts it: {out}");
	assert_eq!(out["travelButton"], false, "the travel button under the arrow steps aside for the same cast: {out}");
	assert_eq!(out["taxi"], json!([false, [false, false, false, false]]), "on a flight: hidden, the key passes it over: {out}");
	assert_eq!(out["landed"], true, "{out}");
	assert_eq!(out["noRune"], json!([false, [false, false, false, false]]), "no rune: no button, no cast: {out}");
	assert!(!out["noRunePlan"].as_str().unwrap().starts_with("teleport"), "{out}");
	assert_eq!(out["noRunePlanButton"], false, "{out}");
	assert!(!out["noSpellPlan"].as_str().unwrap().starts_with("teleport"), "{out}");
	assert_eq!(out["noSpell"], json!([false, [false, false, false, false]]), "the spell not known: no button, no cast: {out}");
	assert_eq!(out["forbidden"], "", "{out}");
}

// A fight never changes the secure buttons: the rune used up in it leaves the button casting until the fight ends, a
// rune bought in it shows the button only then, and no forbidden call is made on the way.
#[test]
fn a_fight_holds_the_route_cast_s_secure_changes_until_it_ends_with_no_forbidden_call() {
	let Some(out) = run(
		"Orc",
		"Mage",
		50,
		"",
		r#"
		local r = {}
		plan{ from = ORG, to = UNDERCITY, spells = MAGE, runes = 1 }
		r.before = button()
		combat(true)
		stub.world.items[17031] = nil
		stub.fire("BAG_UPDATE_DELAYED"); N.travel.Replan(); stub.advance(1)
		r.inFight = button()
		r.keyInFight = key()
		local ran = {}
		stub.mouseClick(H, ran)
		r.clickInFight = ran[1] or false
		combat(false)
		r.after = button()
		r.keyAfter = key()
		combat(true)
		stub.world.items[17031] = 1
		stub.fire("BAG_UPDATE_DELAYED"); N.travel.Replan(); stub.advance(1)
		r.backInFight = button()
		combat(false)
		r.backAfter = button()
		r.keyBack = key()
		r.forbidden = table.concat(forbidden, ", ")
		emit(r)"#,
	) else {
		return;
	};
	assert_eq!(out["before"]["spell"], TELEPORT_UNDERCITY, "{out}");
	assert_eq!(out["inFight"]["shown"], true, "the button keeps its cast in the fight: {out}");
	assert_eq!(out["inFight"]["spell"], TELEPORT_UNDERCITY, "{out}");
	assert_eq!(out["keyInFight"][2], "spell", "the key's secure action is unchanged in the fight: {out}");
	assert_eq!(out["clickInFight"], json!(["spell", TELEPORT_UNDERCITY]), "{out}");
	assert_eq!(out["after"]["shown"], false, "gone once the fight ends: {out}");
	assert_eq!(out["after"]["type"], false, "{out}");
	assert_eq!(out["keyAfter"][2], false, "{out}");
	assert_eq!(out["backInFight"]["shown"], false, "a rune bought in a fight shows it only after: {out}");
	assert_eq!(out["backAfter"]["shown"], true, "{out}");
	assert_eq!(out["backAfter"]["spell"], TELEPORT_UNDERCITY, "{out}");
	assert_eq!(out["keyBack"], json!(["spell", 3563, "spell", TELEPORT_UNDERCITY]), "{out}");
	assert_eq!(out["forbidden"], "", "no protected call and no secure change in combat: {out}");
}

// A guide's `hearth` goal keeps the slot and the key: the Hearthstone, not the route's teleport.
#[test]
fn a_guide_hearth_goal_still_wins_the_slot_and_the_key_over_the_route_s_teleport() {
	let Some(out) = run(
		"Orc",
		"Mage",
		50,
		r#"Polestar.RegisterGuide({ id = "test/hearth", pack = "test", title = "Hearth", minLevel = 1, maxLevel = 60, steps = {
			{ title = "Hearth to Thunder Bluff", goals = { { t = "hearth", location = "Thunder Bluff" }, { t = "talk", npc = 6929, npcName = "Innkeeper Pala" } } },
		} })"#,
		r#"
		local r = {}
		stub.world.bind("Thunder Bluff")
		stub.world.items[6948] = 1
		E.SetGuide("test/hearth"); stub.advance(1)
		r.first = plan{ from = ORG, to = UNDERCITY, spells = MAGE, runes = 1 }
		r.button = button()
		r.key = key()
		r.forbidden = table.concat(forbidden, ", ")
		local v = E.GetStepView(E.GetStepIndex() or 1)
		r.goal = { E.GetGuide() and E.GetGuide().id or false, v and v.goals[1] and v.goals[1].t or false, v and v.goals[1] and v.goals[1].status or false, B.WantsHearth(), E.GetStepIndex() or false, Polestar.QoL.Client.ItemCount(6948), Polestar.QoL.CurrentStep() ~= nil }
		emit(r)"#,
	) else {
		return;
	};
	assert_eq!(out["first"], "teleport|Cast Teleport: Undercity", "{out}");
	assert_eq!(out["button"]["type"], "item", "{out}");
	assert_eq!(out["button"]["item"], "item:6948", "the guide's hearth goal keeps the Hearthstone: {out}");
	assert_eq!(out["key"], json!(["item", 6948, "item", "item:6948"]), "{out}");
	assert_eq!(out["forbidden"], "", "{out}");
}

// A Druid's Teleport: Moonglade and a Shaman's Astral Recall (to the bind point, no Hearthstone) the same way.
#[test]
fn a_druid_s_teleport_moonglade_and_a_shaman_s_astral_recall_take_the_slot_and_the_key_the_same_way() {
	let Some(druid) = run(
		"Tauren",
		"Druid",
		40,
		"",
		r#"
		local r = {}
		r.first = plan{ from = ORG, to = NIGHTHAVEN, spells = { 18960 }, runes = 0 }
		r.journey = journey()
		r.button = button()
		r.key = key()
		r.unknown = plan{ from = ORG, to = NIGHTHAVEN, spells = {}, runes = 0 }
		r.unknownButton = button().shown
		r.forbidden = table.concat(forbidden, ", ")
		emit(r)"#,
	) else {
		return;
	};
	assert_eq!(druid["first"], "teleport|Cast Teleport: Moonglade", "{druid}");
	assert_eq!(druid["journey"][0], json!([918960, "Cast Teleport: Moonglade"]), "{druid}");
	assert_eq!(druid["button"]["type"], "spell", "{druid}");
	assert_eq!(druid["button"]["spell"], "Teleport: Moonglade", "{druid}");
	assert_eq!(druid["key"], json!(["spell", 18960, "spell", "Teleport: Moonglade"]), "{druid}");
	assert_eq!(druid["unknownButton"], false, "{druid}");
	assert_eq!(druid["forbidden"], "", "{druid}");

	let Some(shaman) = run(
		"Orc",
		"Shaman",
		40,
		"",
		r#"
		local r = {}
		stub.world.bind("Razor Hill")
		stub.world.items[6948] = nil
		r.first = plan{ from = TANARIS, to = RAZOR, spells = { 556 }, runes = 0 }
		r.journey = journey()
		r.button = button()
		r.key = key()
		r.forbidden = table.concat(forbidden, ", ")
		emit(r)"#,
	) else {
		return;
	};
	assert!(shaman["first"].as_str().unwrap().starts_with("teleport|Cast Astral Recall"), "{shaman}");
	assert_eq!(shaman["journey"][0][0], 900556, "{shaman}");
	assert_eq!(shaman["button"]["type"], "spell", "{shaman}");
	assert_eq!(shaman["button"]["spell"], "Astral Recall", "{shaman}");
	assert_eq!(shaman["key"], json!(["spell", 556, "spell", "Astral Recall"]), "{shaman}");
	assert_eq!(shaman["forbidden"], "", "{shaman}");
}

// The planner hearths when waiting out the Hearthstone's cooldown is faster (p.hearthWait). While it waits, the
// Journey's hearth row (the Hearthstone's icon) and the route's caption read "Wait 0:12 for your Hearthstone, then
// hearth to Razor Hill", counting down; the arrow points nowhere and says "Hearthstone ready in 0:12" over the greyed
// Hearthstone; the slot holds the Hearthstone greyed with its sweep and the step key leaves it. At 0 it all reads
// "Hearth to Razor Hill", the slot is ready and the key uses the stone.
#[test]
fn a_hearth_leg_waiting_on_its_cooldown_counts_down_in_the_journey_and_on_the_arrow_then_turns_into_hearth_to() {
	let Some(out) = run(
		"Orc",
		"Warrior",
		40,
		"",
		r#"
		local r = {}
		stub.world.bind("Razor Hill")
		stub.world.items[6948] = 1
		stub.advance(10) -- a cooldown starts at a time above 0
		stone(GetTime(), 12)
		r.first = plan{ from = TANARIS, to = RAZOR, spells = {}, runes = 0 }
		r.waiting = { journey = journey()[1], label = N.travel.CurrentLabel(), arrow = arrow(), button = button(), key = key() }
		stub.advance(3)
		r.later = { journey = journey()[1], arrow = arrow() }
		stub.advance(9)
		local legs, ci = N.GetRoute()
		r.ready = { first = legs and legs[ci].kind or false, journey = journey()[1], label = N.travel.CurrentLabel(), arrow = arrow(), button = button(), key = key() }
		r.forbidden = table.concat(forbidden, ", ")
		emit(r)"#,
	) else {
		return;
	};
	assert!(out["first"].as_str().unwrap().starts_with("hearth|"), "{out}");
	let w = &out["waiting"];
	assert_eq!(w["journey"], json!([134414, "Wait 0:11 for your Hearthstone, then hearth to Razor Hill"]), "the hearth row: the Hearthstone's icon, the wait: {out}");
	assert_eq!(w["label"], "Wait 0:11 for your Hearthstone, then hearth to Razor Hill", "{out}");
	assert_eq!(w["arrow"], json!(["instruction", "Hearthstone ready in 0:11", 134414, true]), "the arrow waits with the greyed stone: {out}");
	assert_eq!(w["button"]["item"], "item:6948", "{out}");
	assert_eq!(w["button"]["grey"], true, "{out}");
	assert_eq!(w["button"]["sweep"], 12, "the cooldown's sweep: {out}");
	assert_eq!(w["key"], json!([false, false, false, false]), "the key leaves a stone on its cooldown: {out}");
	assert_eq!(out["later"]["journey"][1], "Wait 0:08 for your Hearthstone, then hearth to Razor Hill", "it counts down: {out}");
	assert_eq!(out["later"]["arrow"][1], "Hearthstone ready in 0:08", "{out}");
	let r = &out["ready"];
	assert_eq!(r["first"], "hearth", "{out}");
	// The leg's own caption once ready ("Hearth to Razor Hill: saves 9 min": the planner's saving).
	let plain = |v: &Value| v.as_str().unwrap().starts_with("Hearth to Razor Hill");
	assert_eq!(r["journey"][0], 134414, "{out}");
	assert!(plain(&r["journey"][1]), "{out}");
	assert!(plain(&r["label"]), "{out}");
	assert_eq!(json!([r["arrow"][0], r["arrow"][2], r["arrow"][3]]), json!(["instruction", 134414, false]), "{out}");
	assert!(plain(&r["arrow"][1]), "the arrow says the leg again: {out}");
	assert_eq!(r["button"]["grey"], false, "ready: {out}");
	assert_eq!(r["button"]["sweep"], false, "{out}");
	assert_eq!(r["key"], json!(["item", 6948, "item", "item:6948"]), "the key hearths once it is ready: {out}");
	assert_eq!(out["forbidden"], "", "{out}");
}

// Astral Recall cooling down the same way: "Wait 0:12, then cast Astral Recall" and "Astral Recall ready in 0:12",
// then "Cast Astral Recall", the slot's spell ready and the key casting it.
#[test]
fn astral_recall_waiting_on_its_cooldown_counts_down_the_same_way() {
	let Some(out) = run(
		"Orc",
		"Shaman",
		40,
		"",
		r#"
		local r = {}
		stub.world.bind("Razor Hill")
		stub.world.items[6948] = nil
		stub.advance(10)
		cd[556] = { GetTime(), 12 }
		r.first = plan{ from = TANARIS, to = RAZOR, spells = { 556 }, runes = 0 }
		r.waiting = { journey = journey()[1], label = N.travel.CurrentLabel(), arrow = arrow(), button = button(), key = key() }
		stub.advance(12)
		r.ready = { journey = journey()[1], label = N.travel.CurrentLabel(), arrow = arrow(), button = button(), key = key() }
		r.forbidden = table.concat(forbidden, ", ")
		emit(r)"#,
	) else {
		return;
	};
	assert!(out["first"].as_str().unwrap().starts_with("teleport|Cast Astral Recall"), "{out}");
	let w = &out["waiting"];
	assert_eq!(w["journey"], json!([900556, "Wait 0:11, then cast Astral Recall"]), "{out}");
	assert_eq!(w["label"], "Wait 0:11, then cast Astral Recall", "{out}");
	assert_eq!(w["arrow"], json!(["instruction", "Astral Recall ready in 0:11", 900556, true]), "{out}");
	assert_eq!(w["button"]["spell"], "Astral Recall", "{out}");
	assert_eq!(w["button"]["grey"], true, "{out}");
	assert_eq!(w["button"]["sweep"], 12, "{out}");
	assert_eq!(w["key"], json!([false, false, false, false]), "{out}");
	let r = &out["ready"];
	let plain = |v: &Value| v.as_str().unwrap().starts_with("Cast Astral Recall");
	assert_eq!(r["journey"][0], 900556, "{out}");
	assert!(plain(&r["journey"][1]), "{out}");
	assert_eq!(json!([r["arrow"][0], r["arrow"][2], r["arrow"][3]]), json!(["instruction", 900556, false]), "{out}");
	assert!(plain(&r["arrow"][1]), "{out}");
	assert_eq!(r["button"]["grey"], false, "{out}");
	assert_eq!(r["key"], json!(["spell", 556, "spell", "Astral Recall"]), "{out}");
	assert_eq!(out["forbidden"], "", "{out}");
}
