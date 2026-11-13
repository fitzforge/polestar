'use strict';
// Finished quests no route ahead hands in (jaff's report), in every skin and
// at window scales 0.64, 1.0 and 1.5: the guide window's "Still to do" row
// (UI/GuideFrame.lua, RoutePlan.Carried) and the outlevelled banner's
// "finished quests here first" with its ask (UI/GuideFrameBanner.lua,
// RoutePlan.LeftBehind). The character, place and guide are skins.js's (a
// Tauren Hunter at 18 on the shipped Barrens guide), at its first step: the
// row and the banner don't depend on the step. The quests are set by the
// shot. Shots: <skin>-row-<scale>, <skin>-banner-<scale> (the banner after
// its first click: the ask).

const skins = require('./skins');

const SCALES = { '064': 0.64, 100: 1, 150: 1.5 };

const CARRIED = `local P = Polestar.RoutePlan
P.Carried = function()
	return { { quest = 869, title = "Raptor Thieves", status = "unplanned", xp = 540 }, { quest = 855, title = "Centaur Bracers", status = "skipped", xp = 360 } }
end
Polestar.UI.GuideFrame.Render()
stub.advance(0.5)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)
local GF, shown = Polestar.UI.GuideFrame, {}
for _, r in ipairs(GF.alongRows) do if r:IsShown() then shown[#shown + 1] = r.Text:GetText() end end
return { along = GF.parts.along:IsShown(), rows = table.concat(shown, " | ") }`;

const BANNER = `local P, E = Polestar.RoutePlan, Polestar.Engine
P.LeftBehind = function() return { n = 2, xp = 900, quests = {} } end
local g = E.GetGuide()
Polestar.Fire("GUIDE_OUTLEVELED", g.id, g.next or g.id)
stub.advance(0.5)
Polestar.UI.GuideFrame.parts.banner.Jump:Click()
stub.advance(0.5)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

const scaled = (s) => `Polestar.Set("ui.scale", ${s})
stub.advance(0.5)`;

const shots = {};
for (const name of Object.keys(skins.SKINS)) {
	const base = skins.shots[`${name}-guide`].lua;
	for (const [tag, s] of Object.entries(SCALES)) {
		shots[`${name}-row-${tag}`] = { title: `${name} at ${s}: "2 finished quests to hand in elsewhere (900 XP)" in Still to do`, lua: `${base}\n${scaled(s)}\n${CARRIED}` };
		shots[`${name}-banner-${tag}`] = { title: `${name} at ${s}: outlevelled, "2 finished quests here first (900 XP)" and the ask`, lua: `${base}\n${scaled(s)}\n${BANNER}` };
	}
}

module.exports = {
	title: 'Finished quests no route hands in: the Still to do row and the outlevelled banner, every skin',
	character: skins.character,
	place: skins.place,
	guide: { id: skins.guide.id },
	settings: skins.settings,
	window: skins.window,
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarGuideFrame'],
	shots,
};
