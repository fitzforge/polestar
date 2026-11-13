'use strict';
// The guide window's Transparent style (#1684): an Undead Warrior on the
// shipped Hillsbrad Foothills guide (horde/06) at "Hillsbrad Fields", Battle
// of Hillsbrad (527) taken with nothing killed yet ("Kill Hillsbrad Farmer
// 0/6", "Kill Hillsbrad Farmhand 0/6"), Elixir of Pain (501) at 3 of 10
// Mountain Lion Blood: "While you're here" offers it, the step's tip open.
// Style transparent, backing soft (the default). Meant over a bright world
// (--world <your screenshot>): the shade behind each line should stay light.

const STEP = `local E = Polestar.Engine
local w = stub.world
-- Played up to Hillsbrad Fields as the live step (While you're here shows
-- only on the live step).
local function title() local v = E.GetStepView(E.GetStepIndex()); return v and v.title end
for _ = 1, 40 do
	if title() == "Hillsbrad Fields" then break end
	local r = play.playStep()
	if r == "noguide" then break elseif r == "stuck" then E.Next(); stub.advance(0.6) end
end
assert(title() == "Hillsbrad Fields", "not at Hillsbrad Fields: " .. tostring(title()))
w.level = 23
-- Battle of Hillsbrad with nothing killed yet, Elixir of Pain at 3 of 10.
if w.log[527] then w.abandon(527) end
w.accept(527, { { text = "Hillsbrad Farmer slain", required = 6 }, { text = "Hillsbrad Farmhand slain", required = 6 },
	{ text = "Farmer Ray slain", required = 1 }, { text = "Farmer Getz slain", required = 1 } }, "Battle of Hillsbrad")
if w.log[501] then w.abandon(501) end
w.accept(501, { { text = "Mountain Lion Blood: 3/10", type = "item", required = 10, fulfilled = 3 } }, "Elixir of Pain")
w.moveTo(1424, 54.0, 40.0); play.syncZone()
stub.advance(3)
studio.clearHeadsUps()
-- The step's tip opened.
local p = Polestar.UI.GuideFrame.parts
if p and p.tip and p.tip.shown then p.tip:Click() end
Polestar.UI.GuideFrame.Layout()
stub.advance(1)`;

module.exports = {
	title: 'The Transparent guide window over a bright world (#1684)',
	character: { race: 'Scourge', cls: 'WARRIOR', faction: 'Horde', level: 23, money: 9000 },
	// Between the farms and the lions' hills, so Elixir of Pain's spot is near.
	place: { map: 1424, x: 52.0, y: 41.0, zone: 'Hillsbrad Foothills', subzone: 'Hillsbrad Fields' },
	guide: { id: 'forever/horde/06-hillsbrad-foothills' },
	settings: { 'behavior.offerClassQuests': false, 'ui.style': 'transparent', 'ui.backing': 'soft' },
	window: [1440, 690],
	capture: ['PolestarGuideFrame'],
	shots: {
		fields: {
			title: 'Hillsbrad Fields at the default width: the kill counts, the tip, While you\'re here',
			lua: STEP,
		},
		'fields-270': {
			title: 'Width 270, "Kill Hillsbrad Farmhand 0/6" ends its line (on next: "0/" then "6")',
			lua: `Polestar.Set("ui.width", 270)\n${STEP}`,
		},
		'fields-325': {
			title: 'Width 325, "Collect Mountain Lion Blood 3/10" ends its line (on next: "3/" then "10")',
			lua: `Polestar.Set("ui.width", 325)\n${STEP}`,
		},
		'fields-285-text120': {
			title: 'Width 285, text size 120 %: "Kill Hillsbrad Farmer 0/6" ends its line',
			lua: `Polestar.Set("ui.width", 285)\nPolestar.Set("ui.textSize", 1.2)\n${STEP}`,
		},
		'fields-305-text120': {
			title: 'Width 305, text size 120 %: "Kill Hillsbrad Farmhand 0/6" ends its line',
			lua: `Polestar.Set("ui.width", 305)\nPolestar.Set("ui.textSize", 1.2)\n${STEP}`,
		},
	},
};
