'use strict';
// The guide window's menu (UI/GuideFrameMenu.lua, W.ShowMenu in
// Theme/Widgets.lua): the window's toggles as an icon bar on top, then the
// entries in groups, each after a separator, the guide reset alone at the
// foot; a row the header offers as a button is left out while that button
// shows. Against the real Core, Theme and UI and the fakes of
// tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\nlocal GF, UI, W = Polestar.UI.GuideFrame, Polestar.UI, Polestar.Widgets\n${script}`,
	}).emitted;
}

// The list the menu is given, as text: "[bar]", "-" for a separator, a row's
// text with "(colour,confirm)" after it when it has a colour of its own.
const MENU = `
local function menu()
	local got
	local show = W.ShowMenu
	W.ShowMenu = function(_, items, opts) got = { items = items, opts = opts } end
	GF.OpenMenu(GF.menuButton)
	W.ShowMenu = show
	local out, bar = {}, nil
	for _, it in ipairs(got.items) do
		if it.bar then
			bar = { caption = it.caption, color = it.captionColor or false, entries = {} }
			for _, e in ipairs(it.bar) do bar.entries[#bar.entries + 1] = { text = e.text, checked = e.checked == true } end
			out[#out + 1] = "[bar]"
		elseif it.separator then out[#out + 1] = "-"
		else
			out[#out + 1] = it.text
			if it.color then out[#out + 1] = "(" .. it.color .. (it.confirm and ",confirm" or "") .. ")" end
		end
	end
	return { items = out, bar = bar, short = got.opts and got.opts.short or false }
end
`;

const groupsOf = (items) => items.slice(2).join('|').split('|-|').map((g) => g.split('|'));
const BAR = ['Compact mode', 'Transparent', 'Lock window', 'Pause'];

test('the guide menu: the window bar on top, then groups, the reset alone and in red, last, every row in view', () => {
	const [out] = run(`uistub.setGuide(uistub.elwynn, 3)\n${MENU}\nemit(menu())`);
	const { items, bar } = out;
	assert.equal(out.short, true, 'a menu of actions: no filter box past 12 rows');
	assert.equal(items[0], '[bar]');
	assert.equal(items[1], '-');
	assert.notEqual(items[items.length - 1], '-');
	for (let i = 1; i < items.length; i++) assert.ok(!(items[i] === '-' && items[i - 1] === '-'), `doubled separator: ${items}`);
	assert.deepEqual(bar.entries.map((e) => e.text), BAR);
	assert.ok(!bar.caption, 'no caption but under the pointer');
	for (const t of BAR) assert.ok(!items.includes(t), `${t} is in the bar, not a row`);
	const groups = groupsOf(items);
	const where = (t) => groups.findIndex((g) => g.includes(t));
	assert.equal(where('Choose guide'), 0);
	assert.equal(where('Open in new tab'), 0);
	assert.ok(where('Settings') > 0);
	if (where('Quick settings') !== -1) assert.equal(where('Quick settings'), where('Settings'));
	assert.deepEqual(groups[groups.length - 1], ['Reset from here', '(danger,confirm)', 'Reset everything', '(danger,confirm)'], 'the two resets stand alone, last, in the danger colour, asking twice');
});

test('rows the header shows as buttons stay out of the menu, and come back when those buttons are off', () => {
	const [shown, off] = run(`uistub.setGuide(uistub.elwynn, 3)\n${MENU}
		local nav = GF.menuButton:GetParent()
		nav.Skip:Show(); nav.Report:Show(); nav.Lookup:Show()
		emit(menu())
		nav.Skip:Hide(); nav.Report:Hide(); nav.Lookup:Hide()
		emit(menu())`);
	for (const t of ['Skip this step', 'Report a problem', 'Lookup']) {
		assert.ok(!shown.items.includes(t), `the header has ${t}: ${shown.items}`);
		assert.ok(off.items.includes(t), `${t} is back: ${off.items}`);
	}
	const groups = groupsOf(off.items);
	const where = (t) => groups.findIndex((g) => g.includes(t));
	assert.equal(where('Lookup'), 0, 'Lookup sits with Choose guide');
	assert.equal(where('Skip this step'), 1, 'the step on its own');
	assert.equal(where('Report a problem'), where('Settings'));
});

test('paused, the bar lights Pause and its caption says Polestar is paused, in the warning colour', () => {
	const [{ bar }] = run(`uistub.setGuide(uistub.elwynn, 3)\n${MENU}\nPolestar.TogglePaused()\nemit(menu())`);
	assert.deepEqual(bar.entries.find((e) => e.text === 'Pause'), { text: 'Pause', checked: true });
	assert.equal(bar.caption, 'Polestar is paused');
	assert.equal(bar.color, 'warning');
});

test('a pin row wears a pin glyph that ships with the addon', () => {
	const [icon] = run(`
		local C, E = Polestar.Compat, Polestar.Engine
		C.IsOnQuest = function() return true end
		C.IsQuestReadyForTurnIn = function() return false end
		C.GetQuestTitle = function() return "Kobold Camp Cleanup" end
		E.PinQuest = E.PinQuest or function() end
		E.IsPinned = function() return false end
		local rows = GF.PinItems({ goals = { { quest = 7 } } })
		emit(rows[1] and rows[1].icon or false)`);
	assert.ok(icon, 'the step\'s quest has a pin row');
	const file = icon.replace(/^Interface\\AddOns\\Polestar\\/, '').split('\\').join('/');
	assert.ok(fs.existsSync(path.join(__dirname, '..', 'addon', 'Polestar', `${file}.tga`)), `${icon} is a texture in Media`);
});

test('a toggle bar: its buttons light while on, hovering one names it and its state in the caption, a click acts and closes', () => {
	const [out] = run(`
		local anchor = CreateFrame("Frame", nil, UIParent)
		anchor:SetSize(100, 20)
		anchor:SetPoint("CENTER")
		local clicked
		W.ShowMenu(anchor, {
			{ caption = "Window", bar = {
				{ text = "Compact mode", icon = "compact", checked = false, onClick = function() clicked = "compact" end },
				{ text = "Pause", icon = "icon-dungeon", checked = true },
				{ text = "Hide window", icon = "close" },
			} },
			{ separator = true },
			{ text = "Options" },
		}, { short = true })
		local m = PolestarMenu
		local bar = m.Bar
		local b = bar.buttons
		local function cap() return bar.Caption:GetText() end
		local rest = cap()
		stub.RunScript(b[1], "OnEnter"); local hoverOff = cap()
		stub.RunScript(b[1], "OnLeave"); local back = cap()
		stub.RunScript(b[2], "OnEnter"); local hoverOn = cap()
		stub.RunScript(b[2], "OnLeave")
		stub.RunScript(b[3], "OnEnter"); local hoverAction = cap()
		stub.RunScript(b[3], "OnLeave")
		local fits = b[1]:GetWidth() >= 30 and b[1]:GetWidth() * 3 + 12 <= m:GetWidth()
			and select(4, b[3]:GetPoint(1)) + b[3]:GetWidth() <= m:GetWidth() - 6
		local lit = { b[1].Lit:IsShown(), b[2].Lit:IsShown(), b[3].Lit:IsShown() }
		-- Below the bar (both hang from the menu's top): the row starts under it.
		local rowBelow = select(5, m.rows[1]:GetPoint(1)) <= select(5, bar:GetPoint(1)) - bar:GetHeight()
		b[1]:Click()
		local after = { clicked = clicked, open = m:IsShown() }
		-- A menu with no bar hides it.
		W.ShowMenu(anchor, { { text = "Close tab" } })
		local gone = not bar:IsShown()
		-- No caption of its own: no caption row, and a hover is a tooltip.
		W.ShowMenu(anchor, { { bar = { { text = "Pause", icon = "icon-dungeon", checked = true } } }, { text = "Options" } }, { short = true })
		local plain = m.Bar
		local capH = bar:GetHeight()
		stub.RunScript(plain.buttons[1], "OnEnter")
		local tipText = GameTooltip.lines[1]
		stub.RunScript(plain.buttons[1], "OnLeave")
		W.ShowMenu(anchor, { { caption = "Window", bar = { { text = "Pause", icon = "icon-dungeon", checked = true } } }, { text = "Options" } }, { short = true })
		local capH2 = m.Bar:GetHeight()
		emit({ plainH = capH, capH = capH2, tipText = tipText, rest = rest, hoverOff = hoverOff, back = back, hoverOn = hoverOn, hoverAction = hoverAction, lit = lit, fits = fits,
			rowBelow = rowBelow, after = after, gone = gone })`);
	assert.equal(out.tipText, 'Pause · On', 'with no caption, a hover is a tooltip');
	assert.equal(out.capH - out.plainH, 16, 'the caption row takes room only when there is a caption');
	assert.equal(out.rest, 'Window');
	assert.equal(out.hoverOff, 'Compact mode · Off');
	assert.equal(out.back, 'Window', 'off the button, the caption is back');
	assert.equal(out.hoverOn, 'Pause · On');
	assert.equal(out.hoverAction, 'Hide window', 'an action with no state has its name alone');
	assert.deepEqual(out.lit, [false, true, false], 'the one on is lit');
	assert.equal(out.fits, true, 'the buttons share the menu\'s width');
	assert.equal(out.rowBelow, true);
	assert.deepEqual(out.after, { clicked: 'compact', open: false });
	assert.equal(out.gone, true);
});

test('a short menu shows every row past 12, with no filter box', () => {
	const [out] = run(`
		local anchor = CreateFrame("Frame", nil, UIParent)
		anchor:SetSize(100, 20)
		anchor:SetPoint("CENTER")
		local items = {}
		for i = 1, 16 do items[i] = { text = "Row " .. i } end
		W.ShowMenu(anchor, items, { short = true })
		local shown = 0
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then shown = shown + 1 end end
		local filter = rawget(PolestarMenu, "Filter")
		emit({ shown = shown, filter = filter ~= nil and filter:IsShown() })`);
	assert.deepEqual(out, { shown: 16, filter: false });
});
