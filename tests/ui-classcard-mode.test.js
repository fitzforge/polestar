'use strict';
// The class quest card's Show setting (toasts.classcard.mode,
// addon/Polestar/UI/ClassCard.lua): "full" is the whole card (compact with
// the window), "compact" a smaller one with no trip or note, "off" no card:
// the accept is then no longer folded into it and reads as a row of its own
// (#2483).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function card(mode, windowCompact) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\nlocal GF, CC = Polestar.UI.GuideFrame, Polestar.UI.ClassCard
			uistub.setGuide(uistub.elwynn, 3)
			GF.Layout()
			-- A warrior quest (class bit 1) of its own chain, giving nothing listed.
			Polestar.ClassRewards = { rewards = {}, quests = { [90001] = { 1, 90001, 0 } } }
			${mode ? `Polestar.Set("toasts.classcard.mode", "${mode}")` : ''}
			Polestar.Set("ui.compact", ${windowCompact ? 'true' : 'false'})
			local guide = { id = "test/classcard", steps = {
				{ title = "Trainer", goals = { { t = "accept", quest = 90001, title = "Simple Letter", npcName = "Llane Beshere" } } },
			} }
			local view = { index = 1, goals = { { status = "active", tickable = true, subject = "Simple Letter" } } }
			local hex = CC.Fill(guide, 1, view)
			local F = CC.Frame()
			emit({
				default = Polestar.UI.Toasts.Get("classcard", "mode"),
				hex = hex ~= nil, shown = F ~= nil and F:IsShown() or false,
				compact = F ~= nil and F.psCompact or false,
				trip = F ~= nil and F.Trip:IsShown() or false,
				fold = CC.Fold(guide, view) or false,
			})`,
	}).emitted[0];
}

test('the class card shows full by default, with its trip and the accept folded in', () => {
	const out = card(null, false);
	assert.equal(out.default, 'full');
	assert.equal(out.shown, true);
	assert.equal(out.hex, true, 'the step\'s quest names take the class colour');
	assert.equal(out.compact, false);
	assert.equal(out.trip, true);
	assert.equal(out.fold, 1, 'the accept reads inside the card');
});

test('Show: Full turns compact with the window', () => {
	const out = card('full', true);
	assert.equal(out.shown, true);
	assert.equal(out.compact, true);
	assert.equal(out.trip, false);
});

test('Show: Compact draws the smaller card in the full window', () => {
	const out = card('compact', false);
	assert.equal(out.shown, true);
	assert.equal(out.compact, true);
	assert.equal(out.trip, false, 'no trip line');
	assert.equal(out.fold, 1, 'the accept still reads inside the card');
});

test('Show: Off hides the card and gives the accept back its own row', () => {
	const out = card('off', false);
	assert.equal(out.shown, false);
	assert.equal(out.hex, false, 'no class colour on the quest names');
	assert.equal(out.fold, false, 'no fold: the accept is a row like any other');
});
