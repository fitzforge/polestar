'use strict';
// The skin audit (tools/preview/audit.js; the "every look, every time"
// rule): every bundled look on every surface at UI scales 0.64, 1 and 1.5,
// each look saved before login as a player's is, checked for covered
// controls, overlapping and clipped text, contrast, close sizes, big-window
// frames on the guide window and its toasts, Lua errors, and surfaces that
// fail to show. Any finding not in EXPECTED fails the test, and so does an
// EXPECTED entry nothing matches any more (it was fixed: take it out). Each
// expected entry names its breakage and its owner; a check is never loosened
// to pass.
//
// The detectors below prove each check still fires: a probe breaks one thing
// on purpose and the audit has to report it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { audit, line, LOOKS } = require('../tools/preview/audit');

// Breakages known on the current looks: { look ('*': every look), surface
// ('*': every surface), check, match (a piece of the finding's where and
// detail), owner (the area), reason }. #1802 (a big window's title bar, drag
// strip and close on the guide window and the cards over it) is not here:
// the test fails on it until its fix lands.
const EXPECTED = [
	{
		look: '*', surface: '*', check: 'clickable', match: 'PolestarOptions Button "(scroll bar)": 100% covered by PolestarOptions Button "About"',
		owner: 'settings window', reason: "The sidebar's rows cover its scroll bar, so the bar can't be dragged (the mouse wheel still scrolls); fixed before 0.3.8 ships.",
	},
	{
		look: '*', surface: '*', check: 'clickable', match: 'PolestarOptions kit up: 100% covered by PolestarOptions Button "Guiding"',
		owner: 'settings window', reason: "In the game looks the same rows cover the sidebar's top scroll arrow; fixed before 0.3.8 ships.",
	},
	{
		look: '*', surface: '*', check: 'clickable', match: 'PolestarOptions kit down: 100% covered by PolestarOptions Button "Recorder"',
		owner: 'settings window', reason: "In the game looks the same rows cover the sidebar's bottom scroll arrow; fixed before 0.3.8 ships.",
	},
	{
		look: '*', surface: '*', check: 'clickable', match: 'covered by PolestarOptions kit forward',
		owner: 'game looks', reason: "WoW Forever and Blizzard: a slider's right step arrow overlaps the value box beside it; fixed before 0.3.8 ships.",
	},
	{
		look: '*', surface: '*', check: 'clickable', match: 'covered by PolestarOptions kit back',
		owner: 'game looks', reason: "WoW Forever and Blizzard: a slider's left step arrow overlaps the colour swatch beside it at UI scale 1.5; fixed before 0.3.8 ships.",
	},
	{
		look: '*', surface: 'picker', check: 'clickable', match: 'PolestarPicker Button "Alliance": 71% covered by PolestarPicker Button "Recent"',
		owner: 'game looks', reason: "In the game looks the picker's wider Recent tab covers the Alliance filter; fixed before 0.3.8 ships.",
	},
	{
		look: '*', surface: 'picker', check: 'overlap', match: '"Alliance" overlaps "Recent"',
		owner: 'game looks', reason: "The same tab's label overlaps the Alliance filter's; fixed before 0.3.8 ships.",
	},
	{
		look: 'classic', surface: '*', check: 'clickable', match: 'kit closeButton',
		owner: 'game looks', reason: "Classic: after a repaint a dialog shows two close buttons, the look's own over the window's; fixed before 0.3.8 ships.",
	},
	{
		look: '*', surface: 'toast-rare', check: 'close', match: 'PolestarRareToast Button "(close)"',
		owner: 'game looks', reason: "WoW Forever and Blizzard: the rare toast's close is drawn larger than the card's; fixed before 0.3.8 ships.",
	},
	{
		look: '*', surface: 'picker', check: 'contrast', match: 'Favourites: ',
		owner: 'Halo, Hearth, Umbra, Lanterns', reason: "The picker's empty Favourites row reads under 3:1 in these looks; fixed before 0.3.8 ships.",
	},
];

const matches = (e, f) => (e.look === '*' || e.look === f.look) && (e.surface === '*' || e.surface === f.surface) && e.check === f.check && `${f.where}: ${f.detail}`.includes(e.match);

test('every bundled look on every surface, at every UI scale', { timeout: 15 * 60 * 1000 }, async () => {
	const { findings } = await audit();
	const used = new Set();
	const unexpected = findings.filter((f) => {
		const i = EXPECTED.findIndex((e) => matches(e, f));
		if (i < 0) return true;
		used.add(i);
		return false;
	});
	const stale = EXPECTED.filter((_, i) => !used.has(i)).map((e) => `${e.look} · ${e.surface} · ${e.check} · ${e.match} (${e.owner})`);
	assert.deepEqual(
		{ unexpected: unexpected.map(line), stale },
		{ unexpected: [], stale: [] },
		`${unexpected.length} finding(s) on the bundled looks not in EXPECTED (fix them, or name each there with its owner); ${stale.length} EXPECTED entr(ies) no longer found (take them out)`,
	);
});

// Probes on the guide window, each breaking one thing the audit checks.
const TABS = 'uistub.openTabs({ { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }, 1)';
const PROBE = (key, script, roots = []) => ({ key, title: `the audit's probe: ${key}`, family: 'guide', roots: ['PolestarGuideFrame', ...roots], script: `${TABS}\nlocal F, GF = PolestarGuideFrame, Polestar.UI.GuideFrame\n${script}` });
const DETECTORS = [
	{
		check: 'clickable', match: 'covered by',
		surface: PROBE('cover', `local b = GF.parts.nav.Prev
local c = CreateFrame("Button", nil, F)
c:SetFrameLevel(F:GetFrameLevel() + 400)
c:SetAllPoints(b)`),
	},
	{
		check: 'overlap', match: 'Audit probe one',
		surface: PROBE('overlap', `for i, word in ipairs({ "one", "two" }) do
	local s = F:CreateFontString(nil, "OVERLAY")
	s:SetFont(STANDARD_TEXT_FONT, 14, "")
	s:SetText("Audit probe " .. word)
	s:SetPoint("CENTER", F, "CENTER", 0, 0)
end`),
	},
	{
		check: 'clipped', match: 'Audit probe running past the edge',
		surface: PROBE('clipped', `local s = F:CreateFontString(nil, "OVERLAY")
s:SetFont(STANDARD_TEXT_FONT, 14, "")
s:SetText("Audit probe running past the edge of the window")
s:SetPoint("LEFT", F, "RIGHT", -40, 0)`),
	},
	{
		check: 'contrast', match: 'Audit probe grey on grey',
		surface: PROBE('contrast', `local p = CreateFrame("Frame", nil, F)
p:SetFrameLevel(F:GetFrameLevel() + 400)
p:SetSize(220, 40)
p:SetPoint("CENTER", F, "CENTER", 0, 0)
local t = p:CreateTexture(nil, "BACKGROUND")
t:SetAllPoints(p)
t:SetColorTexture(0.2, 0.2, 0.2, 1)
local s = p:CreateFontString(nil, "OVERLAY")
s:SetFont(STANDARD_TEXT_FONT, 14, "")
s:SetText("Audit probe grey on grey")
s:SetTextColor(0.26, 0.26, 0.26, 1)
s:SetPoint("CENTER", p, "CENTER", 0, 0)`),
	},
	{
		check: 'close', match: 'units drawn',
		surface: PROBE('close', `local b = Polestar.Widgets.IconButton(F, "close", 30, "Audit probe", function() end)
b:SetFrameLevel(F:GetFrameLevel() + 400)
b:SetPoint("CENTER", F, "CENTER", 0, -60)
Polestar.Theme.KitIconButton(b)`),
	},
	{
		// #1802's order: painted as a window, then marked as the guide window.
		check: 'frame', match: 'drag',
		surface: PROBE('frame', `local p = CreateFrame("Frame", "PolestarAuditProbe", UIParent)
p:SetSize(320, 160)
p:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
Polestar.Theme.Skin(p, "window")
p.psGuide = true`, ['PolestarAuditProbe']),
	},
	{ check: 'error', match: 'Audit probe error', surface: PROBE('error', 'geterrorhandler()("Audit probe error")') },
	{ check: 'shown', match: 'not on screen', surface: PROBE('shown', 'F:Hide()') },
];

test('the audit reports each kind of breakage a probe makes', { timeout: 5 * 60 * 1000 }, async () => {
	const forever = LOOKS.filter((l) => l.id === 'forever');
	const { findings } = await audit({ looks: forever, surfaces: DETECTORS.map((d) => d.surface), scales: [1] });
	const missed = DETECTORS.filter((d) => !findings.some((f) => f.surface === d.surface.key && f.check === d.check && `${f.where}: ${f.detail}`.includes(d.match)));
	assert.deepEqual(missed.map((d) => `${d.surface.key}: no ${d.check} finding`), [], findings.map(line).join('\n'));
});
