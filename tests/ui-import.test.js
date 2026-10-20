'use strict';
// The Import page (addon/Polestar/UI/Import.lua), a hub section at the
// rail's foot above Options, over the real Core (Core/Import.lua, the guide
// registry) and the UI's fake Engine (tests/lua/stub_ui.lua); and the
// guide menu's "Imported" entry under Community guides.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { compile, fixtureData } = require('./helpers/dsl');
const { importString, encodeImport } = require('../tools/lib/pack/importstring');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

const GUIDE = `guide yendi/cozy-sleeping-bag
title Cozy Sleeping Bag
levels 30-40
zone Elwynn Forest
version 3

step Deputy Willem
  accept 783

step Marshal McBride
  turnin 783
`;

let text;
function string() {
	if (!text) {
		const c = compile({ 'cozy.guide': GUIDE }, fixtureData(), { pack: 'yendi', author: 'Yendi' });
		assert.deepEqual(c.errors, []);
		text = importString(c.guides[0], { manifest: { id: 'yendi', license: 'CC-BY-4.0' }, data: fixtureData() }).text;
	}
	return text;
}

const SETUP = `
uistub.install()
Polestar.Guides = uistub.realGuides
G = uistub.realGuides
assert(Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar Guides", author = "Polestar", version = "0.1.0", license = "GPL-3.0" }))
assert(Polestar.RegisterGuide({ id = "forever/westfall", pack = "guides", title = "Westfall", minLevel = 10, maxLevel = 20, steps = { { goals = { { t = "level", level = 20 } } } } }))
stub.login()
UI, P, IV = Polestar.UI, Polestar.UI.Picker, Polestar.UI.Import
function paste(text)
	local box = IV.parts.Box
	box:SetText(text)
	box:GetScript("OnTextChanged")(box, true)
end
function rail(frame)
	local out = {}
	for _, b in ipairs(frame.railButtons or {}) do
		if b:IsShown() then out[#out + 1] = b.psKey end
	end
	return out
end
`;

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua', 'stub_encoding.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `${SETUP}\n${script}`,
	}).emitted;
}

const str = (s) => JSON.stringify(s);

test('Import sits at the rail\'s foot, just above Options, in the hub and in the settings; /polestar import opens it', () => {
	const [out] = run(`
		SlashCmdList.POLESTAR("import")
		local hub = rail(PolestarPicker)
		local section = P.Section()
		UI.ShowOptions()
		emit({ hub = hub, section = section, options = rail(PolestarOptions), foot = P.FootItems() })
	`);
	assert.equal(out.section, 'Import');
	// The foot is placed first, from the bottom up: Options, then Import.
	assert.deepEqual(out.hub.slice(0, 2), ['Options', 'Import']);
	assert.deepEqual(out.options.slice(0, 2), ['Options', 'Import']);
	assert.equal(out.hub.filter((k) => k === 'Import').length, 1, 'not among the sections at the top too');
	assert.deepEqual(out.foot.map((i) => i.key), ['Options', 'Import']);
});

test('a pasted string shows its preview before anything is saved; Import saves it, lists it and adds it to the guide menu', () => {
	const [before, unsaved, after, menu] = run(`
		IV.Show()
		paste(${str(string())})
		emit(IV.Shown())
		emit({ saved = PolestarDB.imports == nil })
		IV.parts.Apply:Click()
		emit(IV.Shown())
		local g = G.Get("yendi/cozy-sleeping-bag")
		local nav = {}
		P.ShowSection("Guides")
		for _, b in ipairs(PolestarPicker.navButtons) do
			if b:IsShown() then nav[#nav + 1] = (b.psHeading and "# " or "") .. b.Label:GetText() end
		end
		emit({ credits = (P.Credits(g)), nav = nav, entries = #P.Entries("All", "", "pack:imported") })
	`);
	assert.equal(before.preview, 'Cozy Sleeping Bag  ·  by Yendi  ·  2 steps  ·  levels 30–40  ·  Alliance and Horde  ·  CC-BY-4.0');
	assert.equal(before.button, 'Import');
	assert.equal(before.refusal, undefined);
	assert.equal(Object.keys(before.list).length, 0);
	assert.equal(unsaved.saved, true, 'nothing saved before Import');
	assert.match(after.done, /Imported Cozy Sleeping Bag\. Find it in the guide menu under Community guides, Imported\./);
	assert.equal(after.preview, undefined);
	assert.deepEqual(after.list.map((r) => [r.title, r.credits]), [['Cozy Sleeping Bag', 'By Yendi  ·  version 3  ·  CC-BY-4.0']]);
	assert.equal(menu.credits, 'By Yendi  ·  Imported  ·  CC-BY-4.0');
	const at = menu.nav.indexOf('# Community guides');
	assert.ok(at >= 0, `the Community guides heading: ${menu.nav}`);
	assert.ok(menu.nav.slice(at).includes('Imported'), `Imported under it: ${menu.nav}`);
	assert.ok(menu.entries > 0);
});

test('a paste comes in one character at a time and is read on the next frame; the box keeps only its beginning', () => {
	const s = string();
	const [during, after] = run(`
		IV.Show()
		local box = IV.parts.Box
		local text = ${str(s)}
		for i = 1, #text do box:GetScript("OnChar")(box, text:sub(i, i)) end
		box:GetScript("OnTextChanged")(box, true)
		emit({ preview = IV.Shown().preview or false })
		stub.advance(0.02)
		emit({ preview = IV.Shown().preview, box = box:GetText() })
	`);
	assert.equal(during.preview, false, 'nothing read while the paste comes in');
	assert.match(after.preview, /^Cozy Sleeping Bag/);
	assert.equal(after.box, `${s.slice(0, 40)}… (${Math.ceil(s.length / 1024)} KB)`);
});

test('a refused string shows why and saves nothing; the same string again says it is already imported; a newer one offers Update', () => {
	const p = JSON.parse(JSON.stringify(require('../tools/lib/pack/importstring').decodeImport(string())));
	p.guide.version = 4;
	const [bad, same, newer] = run(`
		IV.Show()
		paste("!PS1!garbage")
		emit({ shown = IV.Shown(), saved = PolestarDB.imports == nil })
		paste(${str(string())})
		IV.parts.Apply:Click()
		paste(${str(string())})
		emit(IV.Shown())
		paste(${str(encodeImport(p))})
		emit(IV.Shown())
	`);
	assert.match(bad.shown.refusal, /damaged or incomplete/);
	assert.equal(bad.shown.button, undefined);
	assert.equal(bad.saved, true);
	assert.equal(same.note, 'This guide is already imported, at this version.');
	assert.equal(same.button, undefined);
	assert.match(newer.note, /You have version 3 of this guide\. Update replaces it/);
	assert.equal(newer.button, 'Update');
});

test('Delete asks for a second click, then removes the guide from the list and the store', () => {
	const [one, two] = run(`
		IV.Show()
		paste(${str(string())})
		IV.parts.Apply:Click()
		local row = IV.rows[1]
		row.Delete:Click()
		emit({ label = row.Delete.Label:GetText(), list = #IV.Shown().list })
		row.Delete:Click()
		emit({ list = #IV.Shown().list, stored = PolestarDB.imports["yendi/cozy-sleeping-bag"] == nil, got = G.Get("yendi/cozy-sleeping-bag") == nil })
	`);
	assert.equal(one.label, 'Click again to confirm');
	assert.equal(one.list, 1);
	assert.deepEqual(two, { list: 0, stored: true, got: true });
});
