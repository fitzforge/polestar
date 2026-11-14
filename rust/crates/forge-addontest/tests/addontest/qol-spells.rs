//! Class spells (addon/Polestar/QoL/Spells.lua + UI/SpellCards.lua on the UI/ClassToast.lua card): the spells the
//! class trainer has at a new level, and the spells on the action bars that are an old rank with their Upgrade.
//!
//! Section 1: Spells.lua (stub_qol), with the class data, the spellbook and the action slots stubbed.
//! Section 2: the cards (stub_ui).

use forge_addontest::{emitted, text, Addon, RunAddon};
use serde_json::{json, Value};

// ---------------------------------------------------------------------------
// Section 1: Spells.lua
// ---------------------------------------------------------------------------

const QOL_FILES: &[&str] = &["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"];

// A Human Priest. At 10 the trainer has Shadow Word: Pain 2 (rank 1 known), Renew 2 (rank 1 known), Fade, a Night
// Elf spell (race mask 8) and a talent's second rank (its first not known); at 12 nothing; at 14 Smite 2, whose
// rank 1 is trainable at 6 (not known: training missed).
const PRELUDE: &str = r#"
local q = stub.qol
local S = Polestar.QoL.Spells
local C = Polestar.Compat
Polestar.QoL.SetClassSpells({ PRIEST = "6=591:100:2:585;10=139:300:2:136,586:300:1,594:300:2:589,2651:300:1:0:8,15262:300:2:14914;14=598:1200:3:591" })
KNOWN = { [589] = true, [136] = true, [585] = true }
C.IsSpellKnown = function(id) return KNOWN[id] == true end
IsPlayerSpell = function(id) return KNOWN[id] == true end
C.GetPlayerInfo = function() return { name = "T", level = q.level, race = "Human", class = "PRIEST", faction = "Alliance" } end
UnitRace = function() return "Human", "Human", 1 end
NAMES, RANKS = {}, {}
C_Spell.GetSpellName = function(id) return NAMES[id] end
C_Spell.GetSpellSubtext = function(id) return RANKS[id] and ("Rank " .. RANKS[id]) or "" end
local function spell(id, name, rank) NAMES[id] = name; RANKS[id] = rank end
-- The spellbook: the player's spell ids in order.
BOOK = {}
C_SpellBook = {
	GetNumSpellBookSkillLines = function() return 1 end,
	GetSpellBookSkillLineInfo = function() return { itemIndexOffset = 0, numSpellBookItems = #BOOK } end,
	GetSpellBookItemInfo = function(i) return BOOK[i] and { spellID = BOOK[i], itemType = 1, name = NAMES[BOOK[i]] } or nil end,
}
-- The action slots: slot -> { kind, id }; the cursor.
ACTIONS, CURSOR, PLACED = {}, nil, {}
HasAction = function(s) return ACTIONS[s] ~= nil end
GetActionInfo = function(s) local a = ACTIONS[s]; if a then return a[1], a[2] end end
GetCursorInfo = function() if CURSOR then return CURSOR[1], CURSOR[2] end end
C_Spell.PickupSpell = function(id) CURSOR = { "spell", id } end
PlaceAction = function(s)
	if InCombatLockdown() then return end
	local old = ACTIONS[s]
	ACTIONS[s] = CURSOR
	CURSOR = old
	PLACED[#PLACED + 1] = s
	stub.fire("ACTIONBAR_SLOT_CHANGED", s)
end
ClearCursor = function() CURSOR = nil end
-- The player puts something in a slot (or empties it).
local function put(slot, kind, id)
	ACTIONS[slot] = kind and { kind, id } or nil
	stub.fire("ACTIONBAR_SLOT_CHANGED", slot)
end
local cards, ranks = {}, {}
Polestar.On("LEVELUP_SPELLS", function(n) cards[#cards + 1] = n end)
Polestar.On("OLD_RANKS", function(n) ranks[#ranks + 1] = n or false end)
local function levelUp(n)
	q.level = n
	stub.fire("PLAYER_LEVEL_UP", n, 0, 0, 0, 0, 0, 0, 0, 0)
	stub.advance(3)
end
local function ids(list)
	local out = {}
	for i, s in ipairs(list or {}) do out[i] = s.id end
	return out
end
-- Renew 1-3 in the spellbook, rank 2 on bar 1 slot 5, optionally rank 3 on bestSlot, a macro and the Hearthstone beside them.
local function renew(bestSlot)
	spell(139, "Renew", 2); spell(6074, "Renew", 3); spell(136, "Renew", 1); spell(6075, "Renew", 4)
	BOOK = { 136, 139, 6074 }
	ACTIONS[5] = { "spell", 139 }
	if bestSlot then ACTIONS[bestSlot] = { "spell", 6074 } end
	ACTIONS[6] = { "macro", 12 }
	ACTIONS[7] = { "item", 6948 }
	ACTIONS[8] = { "spell", 9999 }
	spell(9999, "Shoot", nil)
	BOOK[#BOOK + 1] = 9999
	stub.advance(7)
end
"#;

fn run_qol(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_qol.lua"], addons: vec![Addon::files("Polestar", QOL_FILES)], login: true, script: format!("{PRELUDE}{script}"), ..Default::default() })
}

#[test]
fn a_ding_with_three_new_spells_tells_those_three_with_their_cost() {
	let out = run_qol(
		r#"
		q.money = 1000
		levelUp(10)
		local n = cards[1]
		emit({ count = #cards, level = n.level, ids = ids(n.spells), cost = n.cost, money = n.money })"#,
	);
	// The Night Elf spell and the talent's second rank are left out.
	assert_eq!(out[0], json!({ "count": 1, "level": 10, "ids": [139, 586, 594], "cost": 900, "money": 1000 }));
}

#[test]
fn a_level_with_nothing_new_shows_no_card_and_a_rank_after_a_missed_one_still_counts() {
	let out = run_qol(
		r#"
		levelUp(12)
		emit(#cards)
		levelUp(14)
		emit(ids(cards[1] and cards[1].spells))
		KNOWN[594], KNOWN[139], KNOWN[586] = true, true, true
		cards = {}
		levelUp(10)
		emit(#cards)"#,
	);
	assert_eq!(out[0], 0, "nothing new at 12");
	assert_eq!(out[1], json!([598]), "Smite 3: its rank 2 is trainable since 6");
	assert_eq!(out[2], 0, "everything at 10 already known");
}

#[test]
fn a_ding_in_combat_waits_for_the_fight_to_end_and_an_instance_stays_silent() {
	let out = run_qol(
		r#"
		q.combat(true)
		levelUp(10)
		emit(#cards)
		q.combat(false)
		stub.advance(2)
		emit(#cards)
		IsInInstance = function() return true, "party" end
		cards = {}
		levelUp(10)
		emit(#cards)"#,
	);
	assert_eq!(out[0], 0, "nothing in combat");
	assert_eq!(out[1], 1, "told once combat ends");
	assert_eq!(out[2], 0, "nothing in a dungeon");
}

#[test]
fn the_setting_off_shows_no_level_up_card() {
	let out = run_qol(
		r#"
		Polestar.Set("qol.levelUpSpells", false)
		levelUp(10)
		emit(#cards)"#,
	);
	assert_eq!(out[0], 0);
}

#[test]
fn a_lower_rank_on_bar_1_slot_5_with_a_higher_one_known_is_listed_macros_items_and_rankless_spells_are_not() {
	let out = run_qol(
		r#"
		renew()
		local n = ranks[#ranks]
		emit({ slots = n.slots, spells = n.spells })"#,
	);
	assert_eq!(out[0], json!({ "slots": 1, "spells": [{ "id": 139, "bestId": 6074, "name": "Renew", "have": 2, "best": 3, "slots": [5] }] }));
}

#[test]
fn upgrade_replaces_only_that_slot_and_leaves_macros_and_items_alone() {
	let out = run_qol(
		r#"
		renew()
		local done = S.Upgrade()
		emit({ done = done, s5 = ACTIONS[5][2], macro = ACTIONS[6], item = ACTIONS[7], shoot = ACTIONS[8][2],
			placed = PLACED, cursor = CURSOR or false, last = ranks[#ranks] })"#,
	);
	assert_eq!(out[0], json!({ "done": 1, "s5": 6074, "macro": ["macro", 12], "item": ["item", 6948], "shoot": 9999, "placed": [5], "cursor": false, "last": false }));
}

#[test]
fn a_lower_rank_is_left_alone_when_the_highest_known_rank_is_on_any_bar() {
	for slot in [1, 180] {
		let out = run_qol(&format!(
			r#"
			renew({slot})
			local list, n = S.OldRanks()
			emit({{ listed = #list, slots = n, notice = ranks[#ranks], done = S.Upgrade(),
				low = ACTIONS[5][2], best = ACTIONS[{slot}][2], placed = #PLACED, cursor = CURSOR or false }})"#,
		));
		assert_eq!(out[0], json!({ "listed": 0, "slots": 0, "notice": false, "done": 0, "low": 139, "best": 6074, "placed": 0, "cursor": false }), "highest rank in slot {slot}");
	}
}

#[test]
fn removing_the_highest_rank_from_the_bars_makes_the_lower_rank_eligible_again() {
	let out = run_qol(
		r#"
		renew(17)
		put(17, nil)
		S.CheckRanks(true)
		local n = ranks[#ranks]
		emit({ slots = n.slots, ids = ids(n.spells), done = S.Upgrade(), low = ACTIONS[5][2] })"#,
	);
	assert_eq!(out[0], json!({ "slots": 1, "ids": [139], "done": 1, "low": 6074 }));
}

#[test]
fn learning_new_ranks_only_upgrades_the_highest_rank_on_the_bars() {
	for slot in [1, 180] {
		let out = run_qol(&format!(
			r#"
			renew({slot})
			spell(6076, "Renew", 5)
			for _, learned in ipairs({{ 6075, 6076 }}) do
				BOOK[#BOOK + 1] = learned
				stub.fire("LEARNED_SPELL_IN_TAB", learned, 2)
				stub.fire("SPELLS_CHANGED")
				stub.advance(2)
				local n = ranks[#ranks]
				emit({{ slots = n.slots, ids = ids(n.spells), best = n.spells[1].bestId,
					done = S.Upgrade(), low = ACTIONS[5][2], higher = ACTIONS[{slot}][2],
					last = ranks[#ranks], cursor = CURSOR or false }})
			end"#,
		));
		assert_eq!(out[0], json!({ "slots": 1, "ids": [6074], "best": 6075, "done": 1, "low": 139, "higher": 6075, "last": false, "cursor": false }), "rank 4 learned, higher rank in slot {slot}");
		assert_eq!(out[1], json!({ "slots": 1, "ids": [6075], "best": 6076, "done": 1, "low": 139, "higher": 6076, "last": false, "cursor": false }), "rank 5 learned, higher rank in slot {slot}");
	}
}

#[test]
fn training_upgrades_every_copy_of_the_highest_rank_on_the_bars_and_keeps_the_lower_rank() {
	let out = run_qol(
		r#"
		renew(1)
		ACTIONS[180] = { "spell", 6074 }
		BOOK[#BOOK + 1] = 6075
		stub.fire("LEARNED_SPELL_IN_TAB", 6075, 2)
		stub.fire("SPELLS_CHANGED")
		stub.advance(2)
		local n = ranks[#ranks]
		emit({ slots = n.slots, spells = n.spells, done = S.Upgrade(),
			low = ACTIONS[5][2], first = ACTIONS[1][2], last = ACTIONS[180][2], placed = PLACED })"#,
	);
	assert_eq!(
		out[0],
		json!({ "slots": 2, "spells": [{ "id": 6074, "bestId": 6075, "name": "Renew", "have": 3, "best": 4, "slots": [1, 180] }],
			"done": 2, "low": 139, "first": 6075, "last": 6075, "placed": [1, 180] })
	);
}

#[test]
fn an_intentional_lower_rank_does_not_hide_another_spells_outdated_rank_or_treat_macros_and_items_as_spells() {
	let out = run_qol(
		r#"
		spell(585, "Smite", 1); spell(591, "Smite", 2)
		ACTIONS[30] = { "spell", 585 }
		ACTIONS[31] = { "macro", 591 }
		ACTIONS[32] = { "item", 591 }
		renew(17)
		BOOK[#BOOK + 1] = 585; BOOK[#BOOK + 1] = 591
		S.CheckRanks(true)
		local n = ranks[#ranks]
		emit({ slots = n.slots, ids = ids(n.spells), done = S.Upgrade(), renew = ACTIONS[5][2],
			best = ACTIONS[17][2], smite = ACTIONS[30][2], macro = ACTIONS[31], item = ACTIONS[32], placed = PLACED })"#,
	);
	assert_eq!(out[0], json!({ "slots": 1, "ids": [585], "done": 1, "renew": 139, "best": 6074, "smite": 591, "macro": ["macro", 591], "item": ["item", 591], "placed": [30] }));
}

#[test]
fn upgrade_in_combat_waits_for_the_fight_to_end_and_never_drops_what_the_cursor_holds() {
	let out = run_qol(
		r#"
		renew()
		q.combat(true)
		emit({ result = S.Upgrade() or false, s5 = ACTIONS[5][2] })
		q.combat(false)
		emit(ACTIONS[5][2])
		ACTIONS[5] = { "spell", 139 }
		CURSOR = { "item", 6948 }
		emit({ done = S.Upgrade(), s5 = ACTIONS[5][2], cursor = CURSOR })"#,
	);
	assert_eq!(out[0], json!({ "result": false, "s5": 139 }), "waits in combat");
	assert_eq!(out[1], 6074, "upgraded once combat ends");
	assert_eq!(out[2], json!({ "done": 0, "s5": 139, "cursor": ["item", 6948] }), "something on the cursor: nothing touched");
}

#[test]
fn keep_this_rank_is_respected_by_the_list_and_upgrade() {
	let out = run_qol(
		r#"
		renew()
		S.Keep(139)
		local list = S.OldRanks()
		emit({ listed = #list, done = S.Upgrade(), s5 = ACTIONS[5][2] })
		S.ForgetKept()
		emit(#S.OldRanks())"#,
	);
	assert_eq!(out[0], json!({ "listed": 0, "done": 0, "s5": 139 }));
	assert_eq!(out[1], 1, "forgotten: listed again");
}

#[test]
fn a_lower_rank_the_player_puts_on_a_bar_is_kept_even_after_a_higher_rank_is_learned_a_moved_one_is_not() {
	let out = run_qol(
		r#"
		renew()
		-- From the spellbook, Renew 1 onto slot 9 while knowing rank 3: deliberate.
		put(9, "spell", 136)
		local function listed()
			local out = {}
			for _, e in ipairs(S.OldRanks()) do out[#out + 1] = { id = e.id, best = e.best, slots = e.slots } end
			return out
		end
		emit(listed())
		-- Rank 4 learned at the trainer: only the highest bar rank in slot 17 is listed.
		put(17, "spell", 6074)
		BOOK[#BOOK + 1] = 6075
		emit(listed())
		-- Remove rank 3; Renew 2 dragged from slot 5 to slot 10 is a move, still listed.
		put(17, nil)
		put(5, nil)
		put(10, "spell", 139)
		emit(listed())
		-- With no higher rank left on the bars, the deliberately placed rank 1 is still kept.
		put(10, nil)
		emit(#S.OldRanks())"#,
	);
	assert_eq!(out[0], json!([{ "id": 139, "best": 3, "slots": [5] }]));
	assert_eq!(out[1], json!([{ "id": 6074, "best": 4, "slots": [17] }]));
	assert_eq!(out[2], json!([{ "id": 139, "best": 4, "slots": [10] }]));
	assert_eq!(out[3], 0, "deliberate placement remains kept without another rank on the bars");
}

#[test]
fn a_new_rank_learned_at_the_trainer_tells_the_old_ranks_once() {
	let out = run_qol(
		r#"
		spell(139, "Renew", 2); spell(6074, "Renew", 3)
		BOOK = { 139 }
		ACTIONS[5] = { "spell", 139 }
		stub.advance(7)
		emit(ranks[#ranks])
		BOOK = { 139, 6074 }
		stub.fire("LEARNED_SPELL_IN_TAB", 6074, 2)
		stub.fire("SPELLS_CHANGED")
		stub.advance(2)
		local n = ranks[#ranks]
		emit({ count = #ranks, id = n and n.spells[1].id, best = n and n.spells[1].bestId })
		stub.fire("SPELLS_CHANGED")
		stub.advance(2)
		emit(#ranks)"#,
	);
	assert_eq!(out[0], false, "nothing old at login");
	assert_eq!(out[1], json!({ "count": 2, "id": 139, "best": 6074 }));
	assert_eq!(out[2], 2, "the same list is not told again");
}

// ---------------------------------------------------------------------------
// Section 2: the cards
// ---------------------------------------------------------------------------

const UI_FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const UI_PRE: &str = r#"uistub.install()
stub.login()
local CT = Polestar.UI.ClassToast
GetSpellTexture = function(id) return "Interface\\Icons\\spell-" .. id end
if C_Spell then C_Spell.GetSpellTexture = GetSpellTexture end
uistub.player.class, uistub.player.level = "PRIEST", 10
local upgraded, kept, checked = 0, {}, 0
Polestar.QoL = { Spells = {
	Upgrade = function() upgraded = upgraded + 1 end,
	Keep = function(id) kept[#kept + 1] = id end,
	CheckRanks = function() checked = checked + 1 end,
} }
local function card()
	local f, m = CT.frame, CT.current
	local on = f ~= nil and f:IsShown()
	local icons = 0
	for _, b in ipairs(on and f.SpellRow or {}) do if b:IsShown() then icons = icons + 1 end end
	return { shown = on, kind = m and m.kind or nil, title = on and f.Title:GetText() or nil, giver = on and f.Giver:IsShown() and f.Giver:GetText() or nil,
		route = on and f.Route:IsShown() and f.Route:GetText() or nil, icons = icons, more = on and f.SpellMore:IsShown() and f.SpellMore:GetText() or nil,
		act = on and f.Act:IsShown() and (f.Act.Label and f.Act.Label:GetText() or f.Act:GetText()) or nil,
		buttons = on and (f.Act:IsShown() or f.Open:IsShown() or f.ShowMe:IsShown()) or false,
		laterFirst = on and select(2, f.Later:GetPoint(1)) == f or false }
end
local function lastCall(name)
	for i = #uistub.calls, 1, -1 do
		if uistub.calls[i][1] == name then return uistub.calls[i] end
	end
end
local function spells(n)
	local out = {}
	for i = 1, n do out[i] = { id = 1000 + i, rank = 1, cost = 100 } end
	return out
end
"#;

fn run_ui(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &UI_FILES)], script: format!("{UI_PRE}{script}"), ..Default::default() })
}

#[test]
fn the_level_up_card_shows_the_spells_their_cost_the_trainer_and_hides_by_itself() {
	let out = run_ui(
		r#"
		stub.sounds = {}
		uistub.plannerTrainer = { npc = 376, npcName = "High Priestess Laurena", map = 1453, x = 49.5, y = 44.6 }
		Polestar.Fire("LEVELUP_SPELLS", { level = 10, spells = spells(3), cost = 300, money = 1000 })
		emit(card())
		emit(#stub.sounds)
		stub.advance(31)
		emit(card().shown)"#,
	);
	let c = &out[0];
	assert_eq!(c["shown"], true, "{c}");
	assert_eq!(c["kind"], "levelUp");
	assert_eq!(c["title"], "3 new spells to train");
	assert_eq!(c["icons"], 3);
	assert!(text(&c["giver"]).contains("Cost 3s: you can pay"), "{c}");
	assert_eq!(c["route"], "Class trainer: High Priestess Laurena, Stormwind City.", "{c}");
	assert_eq!(c["act"], "Show me");
	assert_eq!(out[1], 0, "a quiet card: no chime");
	assert_eq!(out[2], false, "gone by itself");
}

#[test]
fn ten_new_spells_show_eight_icons_and_two_more_and_a_short_purse_says_so() {
	let out = run_ui(
		r#"
		Polestar.Fire("LEVELUP_SPELLS", { level = 20, spells = spells(10), cost = 1000, money = 400 })
		emit(card())"#,
	);
	let c = &out[0];
	assert_eq!(c["icons"], 8);
	assert_eq!(c["more"], "+2 more");
	assert!(text(&c["giver"]).contains("Cost 10s: you have 4s."), "{c}");
}

#[test]
fn the_old_ranks_card_lists_them_upgrades_and_keeps_a_rank_on_right_click() {
	let out = run_ui(
		r#"
		Polestar.Fire("OLD_RANKS", { slots = 1, spells = { { id = 139, bestId = 6074, name = "Renew", have = 2, best = 3, slots = { 5 } } } })
		emit(card())
		CT.Act()
		local b = CT.frame.SpellRow[1]
		b:GetScript("OnClick")(b, "RightButton")
		emit({ upgraded = upgraded, kept = kept, checked = checked })
		Polestar.Fire("OLD_RANKS", nil)
		emit(card().shown)"#,
	);
	let c = &out[0];
	assert_eq!(c["kind"], "oldRanks", "{c}");
	assert_eq!(c["title"], "1 spell on your bars is an old rank");
	assert_eq!(c["giver"], "Renew: rank 2 to 3", "plain text: the game's fonts have no arrow");
	assert_eq!(c["icons"], 1);
	assert_eq!(c["act"], "Upgrade");
	assert_eq!(out[1], json!({ "upgraded": 1, "kept": [139], "checked": 1 }));
	assert_eq!(out[2], false, "nothing left: the card goes");
}

#[test]
fn the_old_ranks_card_puts_one_spell_per_line_four_at_most() {
	let out = run_ui(
		r#"
		local function e(id, name, have) return { id = id, bestId = id + 1, name = name, have = have, best = have + 1, slots = { id } } end
		Polestar.Fire("OLD_RANKS", { slots = 2, spells = { e(1978, "Serpent Sting", 2), e(13165, "Aspect of the Hawk", 1) } })
		emit(card().giver)
		Polestar.Fire("OLD_RANKS", { slots = 6, spells = { e(1, "Serpent Sting", 2), e(2, "Aspect of the Hawk", 1), e(3, "Arcane Shot", 3),
			e(4, "Raptor Strike", 4), e(5, "Mend Pet", 2), e(6, "Hunter's Mark", 1) } })
		emit(card())"#,
	);
	assert_eq!(out[0], "Serpent Sting: rank 2 to 3\nAspect of the Hawk: rank 1 to 2");
	let c = &out[1];
	assert_eq!(c["giver"], "Serpent Sting: rank 2 to 3\nAspect of the Hawk: rank 1 to 2\nArcane Shot: rank 3 to 4\nRaptor Strike: rank 4 to 5\n+2 more", "{c}");
	assert_eq!(c["icons"], 6, "every icon still shows (up to 8): {c}");
}

#[test]
fn a_card_already_up_goes_first_and_the_level_up_card_follows_it() {
	let out = run_ui(
		r#"
		CT.ShowCard({ kind = "other", head = "H", title = "Other", act = { label = "Go", run = function() end } })
		Polestar.Fire("LEVELUP_SPELLS", { level = 10, spells = spells(2), cost = 200, money = 1000 })
		emit(card().kind)
		CT.Hide()
		stub.advance(1)
		emit(card().kind)"#,
	);
	assert_eq!(out[0], "other");
	assert_eq!(out[1], "levelUp");
}

#[test]
fn costs_leave_zero_units_out() {
	let out = run_ui(
		r#"
		local SC = Polestar.UI.SpellCards
		emit({ SC.Money(6400), SC.Money(10005), SC.Money(0), SC.Money(123456) })"#,
	);
	assert_eq!(out[0], json!(["64s", "1g 5c", "0c", "12g 34s 56c"]));
}

#[test]
fn the_guides_own_training_stop_within_ten_steps_wins_over_the_planners_trainer_as_on_the_training_banner() {
	let out = run_ui(
		r#"
		uistub.plannerTrainer = { npc = 3171, npcName = "Thotar", map = 1411, x = 51.8, y = 43.5 }
		uistub.trainStop = { 6, "Orgrimmar" }
		Polestar.Fire("LEVELUP_SPELLS", { level = 20, spells = spells(2), cost = 200, money = 1000 })
		emit(card())
		CT.Hide()
		uistub.trainStop = { 1, "Orgrimmar" }
		Polestar.Fire("LEVELUP_SPELLS", { level = 20, spells = spells(2), cost = 200, money = 1000 })
		emit(card().route)
		CT.Hide()
		uistub.trainStop = { 14, "Thunder Bluff" }
		Polestar.Fire("LEVELUP_SPELLS", { level = 20, spells = spells(2), cost = 200, money = 1000 })
		emit(card())
		CT.Act()
		emit(lastCall("SetTarget"))"#,
	);
	let near = &out[0];
	assert_eq!(near["route"], "The guide trains you in 6 steps (Orgrimmar).", "{near}");
	assert_eq!(near["buttons"], false, "no arrow to another trainer: {near}");
	assert_eq!(near["laterFirst"], true, "Later leads the row: {near}");
	assert_eq!(out[1], "Your guide's current step trains you.");
	let far = &out[2];
	assert_eq!(far["route"], "Class trainer: Thotar, Durotar.", "{far}");
	assert_eq!(far["act"], "Show me");
	// Show me aims where the training banner's Show does: the advice's trainer.
	assert_eq!(out[3], json!(["SetTarget", 1411, 51.8, 43.5, "Thotar"]));
}

#[test]
fn with_the_guide_windows_training_reminder_up_the_card_names_no_trainer() {
	let out = run_ui(
		r#"
		uistub.plannerTrainer = { npc = 3169, npcName = "Jen'shan", map = 1411, x = 42.5, y = 69 }
		Polestar.UI.GuideFrame.BannerNotice = function() return "train" end
		Polestar.Fire("LEVELUP_SPELLS", { level = 20, spells = spells(2), cost = 200, money = 1000 })
		emit(card())"#,
	);
	let c = &out[0];
	assert_eq!(c["shown"], true, "{c}");
	assert_eq!(c["route"], Value::Null, "{c}");
	assert_eq!(c["buttons"], false, "{c}");
}

#[test]
fn a_spell_tooltip_sits_beside_the_card_never_over_its_lines() {
	let out = run_ui(
		r#"
		Polestar.Fire("LEVELUP_SPELLS", { level = 10, spells = spells(2), cost = 200, money = 1000 })
		local f = CT.frame
		local function hover()
			local b = f.SpellRow[1]
			b:GetScript("OnEnter")(b)
			local point, rel, relPoint = GameTooltip:GetPoint(1)
			return { point = point, rel = rel == f, relPoint = relPoint, side = CT.tipSide }
		end
		-- The card on the left half of the screen: the tooltip on its right.
		f.GetCenter = function() return 200, 300 end
		UIParent.GetCenter = function() return 960, 540 end
		emit(hover())
		-- On the right half: on its left.
		f.GetCenter = function() return 1600, 300 end
		emit(hover())"#,
	);
	assert_eq!(out[0], json!({ "point": "TOPLEFT", "rel": true, "relPoint": "TOPRIGHT", "side": "right" }));
	assert_eq!(out[1], json!({ "point": "TOPRIGHT", "rel": true, "relPoint": "TOPLEFT", "side": "left" }));
}
