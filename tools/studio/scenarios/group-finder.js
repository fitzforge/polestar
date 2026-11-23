'use strict';
// The group finder line under a dungeon's way in (UI.FinderLine; #1671): a
// level 18 Tauren Hunter in the Barrens, solo and outside the instance, opens
// the Wailing Caverns pick-up guide (Dungeons/Pickup.lua over the local
// Codex's Dungeons1.lua) and goes to its last step, "Enter Wailing Caverns".
// The group finder's key (TOGGLEGROUPFINDER) is "I", then unbound.

const PICKUP = (key) => `GetBindingText = function(k) return k end
GetBindingKey = function(action) if action == "TOGGLEGROUPFINDER" then return ${key ? `"${key}"` : 'nil'} end end
local E = Polestar.Engine
local ok, err = Polestar.Dungeons.PickUp("wailing-caverns")
stub.advance(1)
local g = E.GetGuide()
assert(g and g.dungeon == "wailing-caverns" or (g and g.title or ""):find("Wailing"), "no pick-up guide: " .. tostring(err))
E.Goto(#g.steps)
stub.advance(0.5)
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

module.exports = {
	title: 'The group finder line under a dungeon\'s "Enter" step (#1671)',
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 18, money: 4200 },
	place: { map: 1413, x: 46.0, y: 36.0, zone: 'The Barrens', subzone: 'The Crossroads' },
	settings: { 'behavior.offerClassQuests': false },
	window: [1440, 690],
	capture: ['PolestarGuideFrame'],
	shots: {
		bound: {
			title: '"Need a group? Press I for the group finder." under "Enter Wailing Caverns"',
			lua: PICKUP('I'),
		},
		unbound: {
			title: 'No key for the group finder: "Need a group? Open the group finder."',
			lua: PICKUP(null),
		},
	},
};
