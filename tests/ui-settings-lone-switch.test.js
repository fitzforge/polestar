'use strict';
// A section that is only its header switch (Discovery > Lookup > Characters) draws no empty body: its card
// carries the switch's help as one muted line, in the new grouped page and in the classic one
// (layoutSections in addon/Polestar_Options/UI/Options.lua). Against the real addon's modules and the fakes of
// tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

function run(saved) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: saved },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			Polestar.UI.ShowOptions()
			local c = O.ControlByKey("alts.enabled")
			O.Select(c.page.key, c.tab)
			local card
			for _, k in ipairs(O.view.cards) do
				if k:IsShown() and k.psSection == c.psSection then card = k end
			end
			local note = card and rawget(card, "HelpNote")
			local rows = 0
			for ctl, w in pairs(O.view.cache) do if w:IsShown() and ctl.psSection == c.psSection and ctl ~= c then rows = rows + 1 end end
			local before = note and note:IsShown() and note:GetText() or false
			-- The module switched off: the folded card's own line (grouped) or the same help (classic).
			Polestar.Set("alts.enabled", false)
			emit({ line = before, rows = rows, cardH = card and card:GetHeight() or 0, rowsTop = card and card.RowsTop or 0 })`,
	}).emitted;
}

const HELP = 'Keep a note of each character you play, for the Characters page (/pole alts).';

for (const [name, saved] of [
	['grouped page', 'PolestarDB = { settings = {}, optionsLayout = "grouped" }'],
	['classic page', 'PolestarDB = { settings = {} }'],
]) {
	test(`${name}: a switch-only card holds the switch's help as one line, not an empty body`, () => {
		const [out] = run(saved);
		assert.equal(out.line, HELP);
		assert.equal(out.rows, 0);
		assert.ok(out.cardH > out.rowsTop, `the card is taller than its header (${out.cardH} > ${out.rowsTop})`);
	});
}
