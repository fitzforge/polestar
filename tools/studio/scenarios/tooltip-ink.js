'use strict';
// Polestar's lines on the game's tooltip, which keeps its own dark ground in
// every look (Theme.TipColor; #2032): in the light looks the dim ink is
// lifted toward the look's paper until it reads there. Vellum is the light
// one among the looks in the download; Sheen and the house style show the
// dark looks' lines as they were. A Troll Warrior at 22 hands in Free From
// the Hold (898) in Ratchet, at UI scale 1.0:
//   <look>-item  the turn-in's reward pick, hovered: the item's tooltip with
//                Gear's lines (the upgrade line, the best pick)
//   <look>-hint  the guide window's Next button, hovered: W.Tooltip's title
//                and the hint under it
// The window sits left of the screen's middle so each tooltip shows whole
// (the game keeps a tooltip on the screen; the studio draws it where it is).
//
// Stand-in, said on the render: the item tooltip's post-call (the client runs
// Gear's lines after SetHyperlink; the studio's tooltip runs them here).

const skins = require('./skins');

const LOOKS = ['polestar', 'sheen', 'vellum'];
const QUEST = 898;
const CHOICES = [5311, 5312, 270011];

// The turn-in step and the tooltip's post-call.
const SETUP = `local set = GameTooltip.SetHyperlink
GameTooltip.SetHyperlink = function(self, l)
	local r = set(self, l)
	for _, line in ipairs(Polestar.Gear.TooltipLines(l)) do Polestar.Hooks.AddLine(self, unpack(line, 1, 8)) end
	return r
end
Polestar.RegisterPack({ addon = "Polestar_Studio", id = "studio", format = 1, title = "Studio", author = "Studio", version = "1", license = "MIT" })
Polestar.RegisterGuide({ id = "studio/ink", pack = "studio", title = "The Barrens", minLevel = 20, maxLevel = 24, steps = {
	{ title = "Ratchet", goals = { { t = "turnin", quest = ${QUEST}, title = "Free From the Hold", npc = 3339,
		npcName = "Captain Thalo'thas Brightsun", map = 1413, x = 62.29, y = 39.03 } } },
} })
stub.world.onQuest(${QUEST}, { { required = 1, fulfilled = 1 } }, "Free From the Hold")
Polestar.Engine.SetGuide("studio/ink")
stub.advance(1)
studio.clearHeadsUps()`;

const PLACE = `Polestar.Set("ui.pos", { math.floor(UIParent:GetWidth() * 0.4), math.floor(UIParent:GetHeight() - 240) })
Polestar.UI.GuideFrame.ApplyPosition()
Polestar.Fire("STEP_UPDATED")
stub.advance(0.5)`;

const ITEM = `${PLACE}
local pick
for _, r in ipairs(Polestar.UI.GuideFrame.rows) do
	if r:IsShown() and r.psGearPick and r.psGearPick:IsShown() then pick = r.psGearPick end
end
assert(pick, "no reward pick under the turn-in")
studio.hover(pick)
studio.label("Stand-in: the item tooltip's post-call", 24, 24)
return GameTooltip.lines`;

const HINT = `${PLACE}
studio.hover(Polestar.UI.GuideFrame.parts.nav.Next)
return GameTooltip.lines`;

const shots = {};
for (const name of LOOKS) {
	const [id, folder, variant] = skins.SKINS[name];
	const base = skins.pick(id, folder, variant);
	shots[`${name}-item`] = {
		title: `${name}: the reward pick hovered, Gear's lines on the item's tooltip`,
		lua: `${base}\n${ITEM}`,
	};
	shots[`${name}-hint`] = {
		title: `${name}: the guide window's Next button hovered, the hint under its title`,
		lua: `${base}\n${HINT}`,
	};
}

module.exports = {
	title: "Polestar's lines on the game's tooltip in the light look and two dark ones (#2032)",
	character: { race: 'Troll', cls: 'WARRIOR', faction: 'Horde', level: 22, money: 4200 },
	place: { map: 1413, x: 62.29, y: 39.03, zone: 'The Barrens', subzone: 'Ratchet' },
	settings: { 'behavior.offerClassQuests': false },
	data: { items: CHOICES },
	stubs: skins.stubs,
	art: skins.art,
	setup: SETUP,
	capture: ['PolestarGuideFrame', 'GameTooltip'],
	pad: 32,
	shots,
};
