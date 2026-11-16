'use strict';
// Sell and repair before heading out (#2344): While you're here's sell and
// repair lines (Engine Own.hereVendor). A Tauren Hunter at 18 on the shipped
// Barrens guide, at Camp Taurajo (resting), the route's live step moved on
// to the first one out of town, Camp Taurajo's merchants from the Codex. In
// the house look at UI scales 0.64, 1 and 1.5, and the Blizzard and Vellum
// looks at 1:
//   <look>-<scale>-sell    3 bag slots free: "Sell before heading out:
//                          3 free slots"
//   <look>-<scale>-repair  the gear at 22%: "Repair before heading out:
//                          gear at 22%"
//   <look>-<scale>-both    both: the repairer's line says both
// Studio shot names: sell-repair/<look>-<scale>-<shot>.

const { SKINS, pick } = require('./skins');

const LOOKS = { 'polestar-064': ['polestar', 0.64], 'polestar-100': ['polestar', 1], 'polestar-150': ['polestar', 1.5],
	'blizzard-100': ['blizzard', 1], 'vellum-100': ['vellum', 1] };

// The game's UI scale (UIParent's), the window's top left 60 px from the
// screen's left and 1000 px up whatever the scale, clear of the arrow and the
// minimap (its position is in UIParent's units: at 1.5 the scenario's own
// numbers sit off the screen).
const SCALE = (s) => `UIParent:SetScale(${s})
Polestar.Set("ui.pos", { ${60 / s}, ${1000 / s} })
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

// The bags (a 16-slot backpack, `free` of it free) and the gear (`pct` of its
// durability), then the route's live step moved to the first one whose first
// placed goal is out of town (400 yd and more from Camp Taurajo), and the
// player in Camp Taurajo by its merchants.
const NEEDS = (free, pct) => `C_Container = C_Container or {}
C_Container.GetContainerNumSlots = function(bag) return bag == 0 and 16 or 0 end
C_Container.GetContainerNumFreeSlots = function(bag) return bag == 0 and ${free} or 0, 0 end
GetInventoryItemDurability = function(slot) if slot == 5 then return ${pct}, 100 end end
local E, w, C = Polestar.Engine, stub.world, Polestar.Compat
w.resting = true
local hc, hx, hy = C.MapToWorld(1413, 44.5, 59.14)
local g = E.GetGuide()
for s = (E.GetLiveStep() or 1), #g.steps do
	local far = false
	for _, goal in ipairs(g.steps[s].goals) do
		if goal.map and goal.x and goal.y then
			local c, x, y = C.MapToWorld(goal.map, goal.x, goal.y, goal.f)
			far = c ~= hc or ((x - hx) ^ 2 + (y - hy) ^ 2) ^ 0.5 > 400
			break
		end
	end
	if far then
		if s ~= E.GetLiveStep() then E.SkipUpTo(s) end
		break
	end
end
w.moveTo(1413, 44.5, 59.14); play.syncZone()
w.zone, w.subzone = "The Barrens", "Camp Taurajo"
studio.clearHeadsUps()
stub.fire("BAG_UPDATE_DELAYED")
stub.fire("UPDATE_INVENTORY_DURABILITY")
stub.advance(3)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)
local list = E.GetWhileHereList()
local kinds = {}
for _, v in ipairs(list) do kinds[#kinds + 1] = v.here end
assert(kinds[1] == "sell" or kinds[1] == "repair" or kinds[2] == "sell" or kinds[2] == "repair", "no sell or repair line: " .. table.concat(kinds, ", "))`;

const NEEDED = { sell: [3, 100], repair: [16, 22], both: [3, 22] };

const shots = {};
for (const [name, [look, s]] of Object.entries(LOOKS)) {
	const [id, folder, variant] = SKINS[look];
	const base = pick(id, folder, variant);
	for (const [shot, [free, pct]] of Object.entries(NEEDED)) {
		shots[`${name}-${shot}`] = {
			title: `${look} at ${s}: ${free} bag slots free, the gear at ${pct}%: While you're here's ${shot} line before heading out`,
			lua: `${base}\n${SCALE(s)}\n${NEEDS(free, pct)}`,
		};
	}
}

module.exports = {
	title: "Sell and repair before heading out (#2344): While you're here's sell and repair lines",
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 18, money: 4200 },
	place: { map: 1413, x: 44.5, y: 59.14, zone: 'The Barrens', subzone: 'Camp Taurajo' },
	guide: { id: 'forever/horde/02-the-barrens', play: 39, hours: 1 },
	settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false },
	window: [1440, 690],
	stubs: require('./skins').stubs,
	capture: ['PolestarGuideFrame'],
	shots,
};
