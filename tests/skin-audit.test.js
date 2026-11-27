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
const { audit, line, LOOKS, SURFACES, TAB_STYLES } = require('../tools/preview/audit');

// Breakages known on the current looks: { look ('*': every look), surface
// ('*': every surface), check, match (a piece of the finding's where and
// detail), owner (the area), reason }. A release ships with none listed.
const EXPECTED = [];

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

// The same bar with a layout picked (Atlas, Polestar_Skins/Layouts/Atlas): every
// look on every surface, the layout saved before login as a player's is.
// EXPECTED_ATLAS as EXPECTED: a finding named with its owner, never a check
// loosened.
const EXPECTED_ATLAS = [];

test('every bundled look on every surface with the Atlas layout picked, at every UI scale', { timeout: 15 * 60 * 1000 }, async () => {
	const { findings } = await audit({ layout: 'atlas' });
	const used = new Set();
	const unexpected = findings.filter((f) => {
		const i = EXPECTED_ATLAS.findIndex((e) => matches(e, f));
		if (i < 0) return true;
		used.add(i);
		return false;
	});
	const stale = EXPECTED_ATLAS.filter((_, i) => !used.has(i)).map((e) => `${e.look} · ${e.surface} · ${e.check} · ${e.match} (${e.owner})`);
	assert.deepEqual(
		{ unexpected: unexpected.map(line), stale },
		{ unexpected: [], stale: [] },
		`${unexpected.length} finding(s) with Atlas picked not in EXPECTED_ATLAS (fix them, or name each there with its owner); ${stale.length} EXPECTED_ATLAS entr(ies) no longer found (take them out)`,
	);
});

// The same bar with each of the tab styles (Polestar/UI/TabStyles) picked: every look on
// the guide window's surfaces (the only ones the tab style draws on), the
// style saved before login as a player's is. EXPECTED_TAB_STYLES as EXPECTED:
// a finding named with its owner, never a check loosened.
const EXPECTED_TAB_STYLES = { switcher: [], edge: [], strip: [] };
const GUIDE_SURFACES = SURFACES.filter((s) => s.family === 'guide');

for (const style of TAB_STYLES.filter((s) => s !== 'underline')) {
	test(`every bundled look on the guide window's surfaces with the ${style} tab style, at every UI scale`, { timeout: 15 * 60 * 1000 }, async () => {
		const expected = EXPECTED_TAB_STYLES[style];
		const { findings } = await audit({ surfaces: GUIDE_SURFACES, tabStyle: style });
		const used = new Set();
		const unexpected = findings.filter((f) => {
			const i = expected.findIndex((e) => matches(e, f));
			if (i < 0) return true;
			used.add(i);
			return false;
		});
		const stale = expected.filter((_, i) => !used.has(i)).map((e) => `${e.look} · ${e.surface} · ${e.check} · ${e.match} (${e.owner})`);
		assert.deepEqual(
			{ unexpected: unexpected.map(line), stale },
			{ unexpected: [], stale: [] },
			`${unexpected.length} finding(s) with the ${style} tab style not in EXPECTED_TAB_STYLES.${style}; ${stale.length} entr(ies) there no longer found`,
		);
	});
}

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

test('long menus keep their rows clear of each game look scrollbar', async () => {
	const surface = {
		...PROBE('long-menu', `local items = {}
for i = 1, 13 do items[i] = { text = "Audit option " .. i } end
Polestar.Widgets.ShowMenu(GF.menuButton, items)
assert(PolestarMenu.Scroll:IsShown(), "the probe must exercise a scrolling menu")`, ['PolestarMenu']),
		targets: ['PolestarMenu'],
	};
	const looks = LOOKS.filter((l) => ['forever', 'blizzard', 'classic'].includes(l.id));
	const { findings } = await audit({ looks, surfaces: [surface] });
	assert.deepEqual(findings.map(line), []);
});

test('disabled menu rows are captured without disabling their enabled neighbours', async () => {
	const surface = {
		...PROBE('disabled-menu', `Polestar.Widgets.ShowMenu(GF.menuButton, {
	{ text = "Audit disabled row", disabled = true },
	{ text = "Audit enabled row" },
})
local disabled, enabled = {}, {}
preview.entryExtra(PolestarMenu.rows[1], disabled)
preview.entryExtra(PolestarMenu.rows[2], enabled)
assert(disabled.disabled == true, "the snapshot must record the menu item's disabled state")
assert(not enabled.disabled, "enabled neighbours must still receive the normal audit checks")`, ['PolestarMenu']),
		targets: ['PolestarMenu'],
	};
	const { findings } = await audit({ looks: LOOKS.filter((l) => l.id === 'polestar'), surfaces: [surface], scales: [1] });
	assert.deepEqual(findings.map(line), []);
});
