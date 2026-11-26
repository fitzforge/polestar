//! The Liminal Passage scroll (addon/Polestar/Nav/LiminalScroll.lua, #4341): a Mage resting in an inn or a city, on a long
//! trip, is offered the scroll when a party member stands at an inn and the teleport clearly shortens the trip, or is
//! told to buy scrolls when there are none. Runs the real Core/Init.lua + Nav/Nav.xml against tests/lua/stub_nav.lua's
//! travel world (the inn is Testshire Inn at world -500, -700).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const PRELUDE: &str = r#"
local N = Polestar.Nav
local Lim = N.liminal
local nav = stub.nav
local SCROLL = 213548
local class, resting, combat, members = "MAGE", true, false, {}
UnitClass = function() return class, class end
IsResting = function() return resting end
InCombatLockdown = function() return combat end
GetNumSubgroupMembers = function() return #members end
UnitIsConnected = function(unit) return members[tonumber(unit:match("%d+"))].online ~= false end
Polestar.Compat.GetUnitMapPosition = function(unit)
	local m = members[tonumber(unit:match("%d+"))]
	local map, x, y = nav.mapPoint(m.wx, m.wy)
	return map, x, y
end
Polestar.Compat.UnitFullName = function(unit) local m = members[tonumber(unit:match("%d+"))]; return m.name .. " Smith", m.name end
Polestar.Compat.GetUnitZone = function() return 9000 end
local function target(wx, wy, label)
	local m, x, y = nav.mapPoint(wx, wy)
	return N.SetTarget(m, x, y, label or "Target")
end
local function known(...)
	local flags = Polestar.CharState().flags
	flags.taxi = {}
	for _, id in ipairs({ ... }) do flags.taxi[id] = true end
end
local function member(name, wx, wy) return { name = name, wx = wx, wy = wy } end
local INN = { -500, -700 } -- Testshire Inn
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		login: true,
		script: format!(
			"{PRELUDE}\nnav.faction = \"Alliance\"\nPolestar.CharState().flags.taxiSeen = {{ [0] = true, [1] = true }}\nnav.useTravelWorld(6000)\nknown(1, 2)\nnav.place(0, 600)\n{script}"
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_resting_mage_with_a_scroll_is_offered_the_member_at_an_inn_when_the_teleport_clearly_shortens_a_long_trip() {
	let out = run(r#"
		local r = {}
		nav.items[SCROLL] = 2
		members = { member("Ana", INN[1], INN[2]) }
		target(0, -780, "Kobolds")
		local o = Lim.Find()
		r.kind, r.member, r.inn = o and o.kind, o and o.member, o and o.inn
		r.saves = o and o.saves >= 60
		r.target = o and o.target.label
		emit(r)"#);
	assert_eq!(out["kind"], "use");
	assert_eq!(out["member"], "Ana");
	assert_eq!(out["inn"], "Testshire Inn");
	assert_eq!(out["saves"], true, "the planner's margin for a class teleport");
	assert_eq!(out["target"], "Kobolds");
}

#[test]
fn an_offline_member_is_left_out() {
	let out = run(r#"
		local r = {}
		nav.items[SCROLL] = 1
		members = { member("Gone", INN[1], INN[2]), member("Here", INN[1], INN[2]) }
		members[1].online = false
		target(0, -780, "Kobolds")
		local o = Lim.Find()
		r.member = o and o.member
		emit(r)"#);
	assert_eq!(out["member"], "Here", "an offline member cannot be reached");
}

#[test]
fn a_mage_with_no_scroll_anywhere_is_told_to_buy_some_but_one_in_the_bank_is_enough() {
	let out = run(r#"
		local r = {}
		target(0, -780, "Kobolds")
		local o = Lim.Find()
		r.kind = o and o.kind
		local bank = Polestar.Compat.GetItemCount
		Polestar.Compat.GetItemCount = function(id, withBank) return (withBank and id == SCROLL) and 1 or 0 end
		r.bank = Lim.Find()
		Polestar.Compat.GetItemCount = bank
		emit(r)"#);
	assert_eq!(out["kind"], "need");
	assert_eq!(out["bank"], Value::Null, "a scroll in the bank is not a reason to buy; one not carried cannot be used either");
}

#[test]
fn no_offer_without_a_mage_rest_a_long_trip_a_setting_or_a_calm_moment() {
	let out = run(r#"
		local r = {}
		nav.items[SCROLL] = 1
		members = { member("Ana", INN[1], INN[2]) }
		target(0, -780, "Kobolds")
		r.base = Lim.Find() ~= nil
		class = "WARRIOR"; r.notMage = Lim.Find() == nil; class = "MAGE"
		resting = false; r.notResting = Lim.Find() == nil; resting = true
		combat = true; r.inCombat = Lim.Find() == nil; combat = false
		Polestar.Set("nav.liminalScroll", false); r.settingOff = Lim.Find() == nil; Polestar.Set("nav.liminalScroll", true)
		Polestar.Set("nav.teleports", false); r.teleportsOff = Lim.Find() == nil; Polestar.Set("nav.teleports", true)
		target(0, 560, "Next door") -- a short walk: no trip to shorten
		r.shortTrip = Lim.Find() == nil
		emit(r)"#);
	assert_eq!(out["base"], true);
	for key in ["notMage", "notResting", "inCombat", "settingOff", "teleportsOff", "shortTrip"] {
		assert_eq!(out[key], true, "{key}");
	}
}

#[test]
fn a_member_who_does_not_rest_at_an_inn_or_saves_too_little_is_not_offered() {
	let out = run(r#"
		local r = {}
		nav.items[SCROLL] = 1
		target(0, -780, "Kobolds")
		members = { member("Outdoors", 0, 100) } -- in the field, no inn near
		r.outdoors = Lim.Find() == nil
		members = { member("Ana", INN[1], INN[2]) }
		local margin = N.travel.TELEPORT_MARGIN
		N.travel.TELEPORT_MARGIN = 100000 -- the planner's own bar for a class teleport: not cleared, no offer
		r.belowMargin = Lim.Find() == nil
		N.travel.TELEPORT_MARGIN = margin
		r.clearsMargin = Lim.Find() ~= nil
		members = {}
		target(0, -780, "Kobolds")
		r.alone = Lim.Find() == nil
		emit(r)"#);
	for key in ["outdoors", "belowMargin", "clearsMargin", "alone"] {
		assert_eq!(out[key], true, "{key}");
	}
}

#[test]
fn the_offer_is_handed_on_with_every_look_and_once_more_when_it_is_gone() {
	let out = run(r#"
		local r = {}
		nav.items[SCROLL] = 1
		members = { member("Ana", INN[1], INN[2]) }
		local got, fired = nil, 0
		Polestar.On("LIMINAL_OFFER", function(o) got, fired = o, fired + 1 end)
		target(0, -780, "Kobolds")
		Lim.Refresh()
		r.first = got and got.kind
		Lim.Refresh()
		r.again = fired
		members = {}
		Lim.Refresh()
		r.gone = got == nil and fired == 3
		Lim.Refresh()
		r.quiet = fired == 3
		emit(r)"#);
	assert_eq!(out["first"], "use");
	assert_eq!(out["again"], 2, "told on every look: the card tells it once");
	assert_eq!(out["gone"], true);
	assert_eq!(out["quiet"], true, "no more once nothing is on offer");
}

#[test]
fn the_inn_lookup_matches_the_inn_by_yards() {
	let out = run(r#"
		local r = {}
		local inn = N.InnNear(0, INN[1] + 30, INN[2], 60)
		r.near = inn and inn.name
		r.far = N.InnNear(0, INN[1] + 90, INN[2], 60) == nil
		r.otherContinent = N.InnNear(1, INN[1], INN[2], 60) == nil
		emit(r)"#);
	assert_eq!(out, json!({ "near": "Testshire Inn", "far": true, "otherContinent": true }));
}
