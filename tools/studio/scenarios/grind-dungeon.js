'use strict';
// The dungeon line under a grind step (UI/DungeonToast.lua, DT.GrindLine, on the guide window's card): an Orc
// Warrior at 28 on the shipped Ashenvale guide's "Level 28.9" top-up below Darkcloud Pinnacle, the Grimtotem
// camps' grind, with one line under it offering a dungeon that fits the character's level now and its quests,
// which opens its page in Dungeons. Polestar, Halo and Vellum at UI scale 1.0, Polestar at 0.64 and 1.5 too, and the
// line hovered (its tooltip). Render with the Codex pack in the checkout given with --checkout (the line
// needs it loaded): each shot returns the step and the line, which polestar studio prints.
//
// Shots: <look>-<scale> (studio grind-dungeon/polestar-1.0 ...), polestar-hover-1.0.

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null], vellum: ['vellum', 'Polestar_Skin_Vellum'] };

// UI scale `s` on the studio's 1920x1080 screen: UIParent drawn at s and 1920/s x 1080/s units big, the guide
// window at the same place on screen at every scale.
const SCALE = (s) => `local s = ${s}
UIParent:SetScale(s)
function UIParent:GetWidth() return 1920 / s end
function UIParent:GetHeight() return 1080 / s end
Polestar.Set("ui.pos", { 1300 / s, 760 / s })`;

// The guide on its "Level 28.9" step, the Codex loaded (the line waits for it), the card filled again.
const GRIND = `local E = Polestar.Engine
local g = E.GetGuide()
local at
for i, st in ipairs(g.steps) do if st.title == "Level 28.9" then at = i break end end
assert(at, "no Level 28.9 step in " .. tostring(g.id))
E.Goto(at)
stub.advance(1)
Polestar.Codex.Load()
stub.advance(1)
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)
local line
for _, l in ipairs(Polestar.UI.GuideFrame.lines) do if l:IsShown() and l.psKey == "dungeon" then line = l end end
assert(line, "no dungeon line on step " .. at)`;

const RESULT = 'return { step = at, line = line.Text:GetText() }';

const shots = {};
for (const [look, [id, folder]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder);
	for (const s of look === 'polestar' ? ['0.64', '1.0', '1.5'] : ['1.0']) {
		shots[`${look}-${s}`] = {
			title: `${look} at UI scale ${s}: the "Level 28.9" grind with the dungeon line under it`,
			lua: `${base}\n${SCALE(s)}\n${GRIND}\n${RESULT}`,
		};
	}
}
shots['polestar-hover-1.0'] = {
	title: 'polestar at UI scale 1.0: the dungeon line hovered, its tooltip',
	capture: ['PolestarGuideFrame', 'GameTooltip'],
	lua: `${skins.pick('polestar', null)}\n${SCALE('1.0')}\n${GRIND}\nstudio.hover(line)\n${RESULT}`,
};

module.exports = {
	title: 'The dungeon line under a grind step: "Or run <dungeon> (<levels>) with a group: <n> quests to pick up first."',
	character: { race: 'Orc', cls: 'WARRIOR', faction: 'Horde', level: 28, money: 52000 },
	place: { map: 1441, x: 35.0, y: 31.5, zone: 'Thousand Needles', subzone: 'Darkcloud Pinnacle' },
	guide: { id: 'forever/horde/07-ashenvale' },
	settings: { 'behavior.offerClassQuests': false, 'nav.arrow': false },
	window: [1440, 760],
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarGuideFrame'],
	shots,
};
