'use strict';
// Free mode (#3701, Lookup/Free.lua) in every look at the game's UI scales
// 0.64, 1.0 and 1.5: the guide window with Free mode's tab over a guide, its
// banner (Return to the guide, the other order) and the nearest quest's card,
// its objectives with their counts and the hand-in with its XP; the window
// with no guide open, "Or follow your own quests: Free mode" under its
// buttons; an empty quest log's zone hint; and a quest line's right-click
// menu (Pin to the top, Leave out of Free mode). A level 12 Human Warrior at
// Sentinel Hill in Westfall with the shipped Westfall guide open, carrying The
// People's Militia (6/15, 2/15), Patrolling Westfall (3/8), Goretusk Liver Pie
// (8/8, ready) and The Forgotten Heirloom.
// Shots: <look>-<surface>-<scale> (studio free-mode/hearth-list-0.64 ...),
// surface list | empty | hint | menu | settings (Questing > Quests, its Free
// mode section).

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null] };
for (const [name, look] of Object.entries(skins.SKINS)) if (!look[2]) LOOKS[name] = look;
const SCALES = ['0.64', '1.0', '1.5'];

// The UI scale: UIParent at that scale, its size in UI units the screen's 1920 x 1080 over it, and the guide
// window at the same place on screen at every scale (its saved place is in UI units).
const SCALE = (scale) => `local s = ${scale}
UIParent:SetScale(s)
function UIParent:GetWidth() return 1920 / s end
function UIParent:GetHeight() return 1080 / s end
Polestar.Set("ui.pos", { 1300 / s, 900 / s })`;

const LOG = `local w = stub.world
w.accept(12, { { text = "Defias Trapper slain: 6/15", required = 15, fulfilled = 6 }, { text = "Defias Smuggler slain: 2/15", required = 15, fulfilled = 2 } }, "The People's Militia")
w.accept(102, { { text = "Gnoll Paw: 3/8", required = 8, fulfilled = 3, type = "item" } }, "Patrolling Westfall")
w.accept(22, { { text = "Goretusk Liver: 8/8", required = 8, fulfilled = 8, type = "item" } }, "Goretusk Liver Pie")
w.accept(64, { { text = "Furlbrow's Pocket Watch: 0/1", required = 1, type = "item" } }, "The Forgotten Heirloom")
stub.advance(1)`;

const START = `studio.clearHeadsUps()
assert(Polestar.Free.Start())
stub.advance(1)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)
return Polestar.Engine.GetStepView(Polestar.Engine.GetStepIndex() or 1).title`;

const LIST = `${LOG}
${START}`;

// No guide open: every tab closed.
const EMPTY = `local E = Polestar.Engine
for i = #E.GetTabs(), 1, -1 do E.CloseTab(i, true) end
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

// An empty log, away from any givers: the zone with the most quests for the level.
const HINT = `stub.world.moveTo(1436, 30.0, 80.0)
play.syncZone()
${START}`;

// A quest line's right-click menu in Free mode.
const MENU = `${LOG}
${START.replace(/\nreturn .*$/, '')}
local function find(f)
	for _, c in ipairs({ f:GetChildren() }) do
		if c:IsShown() and c.psGoal and c.psGoal.quest then return c end
		local r = find(c)
		if r then return r end
	end
end
local row = find(PolestarGuideFrame)
if row then stub.RunScript(row, "OnClick", "RightButton") end
stub.advance(0.3)
return row and row.psGoal.text`;

// The settings: Questing > Quests scrolled to its Free mode section, Free mode on.
const SETTINGS = `${LOG}
${START.replace(/\nreturn .*$/, '')}
if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
Polestar.UI.ShowOptions("questing")
stub.advance(0.5)
local card = Polestar.UI.Options.ShowSection("questing", "Quests", "Free mode")
stub.advance(1)
return card and card.psName`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	for (const scale of SCALES) {
		shots[`${name}-list-${scale}`] = { title: `${name} at UI scale ${scale}: Free mode's tab, banner and nearest quest`, lua: `${base}\n${SCALE(scale)}\n${LIST}` };
		shots[`${name}-empty-${scale}`] = { title: `${name} at UI scale ${scale}: no guide open, Free mode under the buttons`, lua: `${base}\n${SCALE(scale)}\n${EMPTY}` };
		shots[`${name}-hint-${scale}`] = { title: `${name} at UI scale ${scale}: an empty quest log's zone hint`, lua: `${base}\n${SCALE(scale)}\n${HINT}` };
		shots[`${name}-menu-${scale}`] = { title: `${name} at UI scale ${scale}: a quest line's right-click menu`, capture: ['PolestarGuideFrame', 'PolestarMenu'], lua: `${base}\n${SCALE(scale)}\n${MENU}` };
		shots[`${name}-settings-${scale}`] = { title: `${name} at UI scale ${scale}: Settings, Questing > Quests, Free mode`, capture: ['PolestarOptions'], lua: `${base}\n${SCALE(scale)}\n${SETTINGS}` };
	}
}

module.exports = {
	title: 'Free mode: its tab and banner, the empty window\'s link, the zone hint, the quest menu and its settings, in every look at UI scales 0.64, 1.0 and 1.5',
	character: { race: 'Human', cls: 'WARRIOR', faction: 'Alliance', level: 12, money: 5200 },
	place: { map: 1436, x: 56.4, y: 47.6, zone: 'Westfall', subzone: 'Sentinel Hill' },
	guide: { id: 'forever/alliance/02-westfall' },
	settings: { 'behavior.offerClassQuests': false },
	window: [1440, 690],
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarGuideFrame'],
	LOOKS,
	shots,
};
