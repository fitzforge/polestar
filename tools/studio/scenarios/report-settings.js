'use strict';
// The report window and its Settings section in every skin (#2093): the
// Tauren Hunter of skins.js, at 18 on the shipped Barrens guide, who turned
// a few settings (automation, the route style, the While here radius, gear,
// quality of life) on top of the skin's own layout preset. "-note": the
// window before Copy report, the note under its buttons saying what the
// report's Settings lines hold. "-0.64", "-1", "-1.5": the report written
// and copied at those UI scales (UIParent's scale, as the skin audit sets
// it), the report box scrolled to its end, where the Settings lines are.
// Shots: <skin>-note, <skin>-<scale> (studio report-settings/hearth-1 ...).

const skins = require('./skins');

const SCALES = [['0.64', 0.64], ['1', 1], ['1.5', 1.5]];

const SETTINGS = `Polestar.Set("behavior.autoAccept", false)
Polestar.Set("behavior.whileHereRadius", 300)
Polestar.Set("nav.routeStyle", "fastest")
Polestar.Set("gear.minUpgrade", 5)
Polestar.Set("qol.sellJunk", false)
stub.advance(0.3)`;

const OPEN = `if PolestarGuideFrame then PolestarGuideFrame:Hide() end
if PolestarNavArrow then PolestarNavArrow:Hide() end
Polestar.UI.ShowReport()
local F = PolestarReport
F.Desc:SetText("The arrow pointed at the lake instead of the kobold camp.")
stub.RunScript(F.Desc, "OnTextChanged", true)
stub.advance(0.3)`;

const COPY = `F.Copy:Click()
stub.advance(0.5)
Polestar.Widgets.ScrollTo(F.BoxScroll, math.max(0, F.Box:GetHeight() - F.BoxWell:GetHeight()))
stub.advance(0.3)`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(skins.SKINS)) {
	const base = skins.pick(id, folder, variant);
	shots[`${name}-note`] = { title: `${name}: the report window before Copy report, the note on what its Settings lines hold`, lua: `${base}\n${SETTINGS}\n${OPEN}` };
	for (const [label, scale] of SCALES) {
		shots[`${name}-${label}`] = {
			title: `${name} at UI scale ${label}: the report copied, its box at the end, the Settings lines`,
			lua: `UIParent:SetScale(${scale})\n${base}\n${SETTINGS}\n${OPEN}\n${COPY}`,
		};
	}
}

module.exports = {
	title: 'The report window\'s Settings section and its note in every skin, at UI scales 0.64, 1 and 1.5 (#2093)',
	character: skins.character,
	place: skins.place,
	guide: skins.guide,
	settings: {},
	window: skins.window,
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarReport'],
	pad: 24,
	shots,
};
