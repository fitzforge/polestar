'use strict';
// Play next in the guide menu (#2552), on the hub's "resume first" Home: the
// top suggestion gets a card under the active tab's card (with nothing open,
// Start here is that card) and above Browse's list, a "Suggested" mark on its
// Browse row (or its folded band), and leads the details pane with why. Open
// already, or nothing that fits: no card, no mark. Against the real Core, Theme and UI and the fakes
// of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\nlocal UI, P = Polestar.UI, Polestar.UI.Picker\n${script}`,
	}).emitted;
}

const HEAD = `
	local ELW, WEST = uistub.elwynn, "forever/alliance/02-westfall"
	-- inList: only the list pane's own text (false: the details pane's)
	local function count(root, text, inList)
		local n = 0
		local function walk(f)
			if inList == false and f == PolestarPicker.Body then return end
			for _, r in ipairs(f.regions or {}) do
				if r.kind == "FontString" and r.text == text and stub.Methods.IsVisible(r) then n = n + 1 end
			end
			for _, c in ipairs(f.children or {}) do walk(c) end
		end
		walk(PolestarPicker)
		return n
	end
	local function card()
		local found
		local function walk(f)
			if f.psPlayNext and stub.Methods.IsVisible(f) then found = f end
			for _, c in ipairs(f.children or {}) do walk(c) end
		end
		walk(PolestarPicker)
		return found
	end
	local function hero() return P.hero and stub.Methods.IsVisible(P.hero) and P.hero or nil end
	local function state()
		local pn = P.PlayNext()
		local c = card()
		return { pn = pn and pn.guide.id, why = pn and pn.why, card = c ~= nil, title = c and c.Title:GetText(),
			cardWhy = c and c.Why:GetText(), tag = count(PolestarPicker, "Suggested"), lead = count(PolestarPicker, "Suggested for you", false) }
	end
`;

test('Home with nothing open: Start here is the card (no second one); the details lead with why', () => {
	const [out] = run(`${HEAD}
		Polestar.Engine.SetGuide(nil)
		UI.ShowPicker()
		local s = state()
		emit({ s = s, eyebrow = hero() and hero().Eyebrow:GetText(), heroGuide = hero() and hero().psGuide.id })`);
	assert.equal(out.s.pn, 'forever/alliance/human/01-elwynn-forest');
	assert.equal(out.s.why, 'Fits level 4');
	assert.equal(out.s.card, false, 'Start here is the card: no Play next card beside it');
	assert.equal(out.s.lead, 1, 'the details lead with Suggested for you');
	assert.equal(out.heroGuide, out.s.pn);
	assert.equal(out.eyebrow, 'START HERE');
});

test('Home with tabs open: the card sits under the active tab card, ahead of Other tabs, Start opens a new tab, the list does not repeat it', () => {
	const [out] = run(`${HEAD}
		uistub.openTabs({ { WEST, 3 }, { uistub.darkshore or "forever/alliance/03-darkshore", 2 } }, 1)
		UI.ShowPicker()
		local before = state()
		local c = card()
		local rows = {}
		for _, f in ipairs({ PolestarPicker.Body:GetChildren() }) do
			if f:IsShown() and rawget(f, "psGuide") and rawget(f, "Note") and not rawget(f, "Front") and not f.psPlayNext then rows[#rows + 1] = f.psGuide.id end
		end
		local _, _, _, _, cardY = c:GetPoint(1)
		local _, _, _, _, heroY = P.hero:GetPoint(1)
		c.Start:Click()
		emit({ before = before, rows = rows, cardY = cardY, heroY = heroY, tabs = #Polestar.Engine.GetTabs() })`);
	assert.equal(out.before.card, true);
	assert.equal(out.before.cardWhy, out.before.why);
	assert.equal(out.before.lead, 1);
	assert.equal(out.rows.includes(out.before.pn), false, 'the card guide is not a row too');
	assert.equal(out.cardY, out.heroY - 114 - 24, 'one section gap under the tab card');
	assert.equal(out.tabs, 3);
});

test('the top suggestion already open, or nothing that fits: no card, no mark, no lead', () => {
	const [out] = run(`${HEAD}
		uistub.setGuide(ELW, 2)
		UI.ShowPicker()
		local open = state()
		P.SetView("browse")
		local openBrowse = state()
		P.SetView("home")
		uistub.setGuide(nil)
		uistub.player.level = 60
		uistub.suggestions = { WEST }
		P.Render()
		local none = state()
		P.SetView("browse")
		emit({ open = open, openBrowse = openBrowse, none = none, noneBrowse = state() })`);
	const none = { card: false, tag: 0, lead: 0 };
	for (const k of ['open', 'openBrowse', 'none', 'noneBrowse']) {
		assert.equal(out[k].pn, undefined, k);
		assert.equal(out[k].card, false, k);
		assert.equal(out[k].tag, 0, k);
		assert.equal(out[k].lead, 0, k);
	}
});

test('Browse: the card above the list, the suggested row marked; a folded band is marked instead of unfolded', () => {
	const [out] = run(`${HEAD}
		Polestar.Engine.SetGuide(nil)
		UI.ShowPicker()
		P.SetCategory("Leveling")
		local open = state()
		local band = P.FolderOf(ELW)
		P.SetCollapsed(band, true)
		P.Render()
		local folded = state()
		local collapsed = P.IsCollapsed(band)
		emit({ open = open, folded = folded, collapsed = collapsed })`);
	assert.equal(out.open.card, true);
	assert.equal(out.open.tag, 1, 'the row carries the mark');
	assert.equal(out.folded.card, true);
	assert.equal(out.folded.tag, 1, 'the folded band carries it');
	assert.equal(out.collapsed, true, 'nothing unfolds on its own');
});

test('Gamepad: the Play next card is one clickable stop that carries its guide (X starts it)', () => {
	const [out] = run(`${HEAD}
		uistub.openTabs({ { WEST, 3 } }, 1)
		UI.ShowPicker()
		local c = card()
		emit({ psGuide = c.psGuide and c.psGuide.id, clickable = c:GetScript("OnClick") ~= nil })`);
	assert.deepEqual(out, { psGuide: 'forever/alliance/human/01-elwynn-forest', clickable: true });
});
