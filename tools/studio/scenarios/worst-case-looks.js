'use strict';
// The worst cases in every look at UI scales 0.64, 1.0 and 1.5, on a
// 1920x1080 screen: Make room in your quest log with the 25-quest log of a
// character who installed Polestar at 34, its first row pointed at (its name
// is cut: the tooltip has it whole); Characters with the account's worst
// snapshots; Options > Profiles, its In use chip on the profile's picture;
// the class card over the Whirlwind Weapon's first step (worst-case.js's
// pieces; with --locale ruRU its class line goes under the badge). The looks
// are skins.js's, each put on as skins.js puts it. Shots:
// <look>-room-<scale>, <look>-alts-<scale>, <look>-profiles-<scale>,
// <look>-classcard-<scale> (studio worst-case-looks/hearth-room-1.0 ...).

const skins = require('./skins');
const { screen, fill, log34, ALTS, CLASS_CARD } = require('./worst-case').lua;

const SCALES = ['0.64', '1.0', '1.5'];

const ROOM = `${fill(log34)}
Polestar.UI.ShowQuestRoom()
stub.advance(0.5)
local F = PolestarQuestRoom
stub.RunScript(F.rows[1], "OnEnter")
return { height = F:GetHeight(), top = F:GetTop(), bottom = F:GetBottom(), screen = UIParent:GetHeight() }`;

const PROFILES = `Polestar.UI.ShowOptions("profiles")
stub.advance(0.5)
return { shown = PolestarOptions:IsShown(), height = PolestarOptions:GetHeight(), screen = UIParent:GetHeight() }`;

// The dungeon card over the guide window placed where 1300, 900 px on screen
// is (dungeon-route's place: at UI scale 1.5 no room above it): its side,
// the card's and the window's rectangles and how far the window's own drawing
// (a skin's border or corner marks) reaches past them, in screen pixels.
const DUNGEON_CARD = (scale) => `Polestar.Set("ui.pos", { 1300 / ${scale}, 900 / ${scale} })
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)
local DT = Polestar.UI.DungeonToast
local c = DT.Candidates(stub.world.level, "any")
assert(c and c[1], "no dungeon card at this level")
DT.Show(c[1])
stub.advance(1)
local f, w = PolestarClassToast, PolestarGuideFrame
local function rect(x) local e = x:GetEffectiveScale() return { x:GetLeft() * e, x:GetBottom() * e, x:GetRight() * e, x:GetTop() * e } end
local lo, hi = math.huge, -math.huge
local function walk(x)
	if not x:IsShown() then return end
	for _, r in ipairs({ x:GetRegions() }) do
		if r:IsShown() and r:GetBottom() then
			local e = x:GetEffectiveScale()
			lo, hi = math.min(lo, r:GetBottom() * e), math.max(hi, r:GetTop() * e)
		end
	end
	for _, ch in ipairs({ x:GetChildren() }) do walk(ch) end
end
walk(w)
local wr = rect(w)
return { side = Polestar.UI.ClassToast.side, card = rect(f), win = wr, drawnBelow = wr[2] - lo, drawnAbove = hi - wr[4] }`;

const SURFACES = {
	room: { what: 'Make room with 25 quests', lua: ROOM, capture: ['PolestarQuestRoom', 'GameTooltip'] },
	alts: { what: 'Characters, the worst of each field', lua: ALTS, capture: ['PolestarPicker'] },
	profiles: { what: 'Options > Profiles', lua: PROFILES, capture: ['PolestarOptions'] },
	classcard: { what: 'the Whirlwind Weapon class card', lua: CLASS_CARD, capture: ['PolestarGuideFrame'] },
	dungeoncard: { what: 'the dungeon card where there is no room above the window', lua: DUNGEON_CARD, capture: ['PolestarGuideFrame', 'PolestarClassToast'] },
};

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(skins.SKINS)) {
	for (const [key, s] of Object.entries(SURFACES)) {
		for (const scale of SCALES) {
			shots[`${name}-${key}-${scale}`] = {
				title: `${name}: ${s.what} at UI scale ${scale}`,
				capture: s.capture,
				lua: `${skins.pick(id, folder, variant)}\n${screen(1920, 1080, Number(scale))}\n${typeof s.lua === 'function' ? s.lua(scale) : s.lua}`,
			};
		}
	}
}

module.exports = {
	title: "The worst cases' Quest room, Characters, Profiles and class card in every look at UI scales 0.64, 1.0 and 1.5",
	character: { race: 'Human', cls: 'WARRIOR', faction: 'Alliance', level: 34, money: 412345 },
	place: { map: 1443, x: 66.2, y: 6.6, zone: 'Desolace', subzone: "Nijel's Point" },
	guide: { id: 'forever/alliance/30-40/02-desolace' },
	settings: { 'behavior.offerClassQuests': false },
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarQuestRoom', 'GameTooltip'],
	shots,
};
