'use strict';
// Guide packs in the guide menu (addon/Polestar/UI/Picker.lua) and the
// credits line on every guide, over the real guide registry
// (uistub.realGuides) and the UI's fake Engine (tests/lua/stub_ui.lua). Our
// categories list only our guides; All lists every shown guide; a "Guide
// packs" heading lists one entry per shown pack with guides.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

const SETUP = `
uistub.install()
Polestar.Guides = uistub.realGuides
G = uistub.realGuides
local function guide(id, pack, extra)
	local g = { id = id, pack = pack, title = extra.title, minLevel = 10, maxLevel = 20, steps = { { goals = { { t = "level", level = 20 } } } } }
	for k, v in pairs(extra) do g[k] = v end
	assert(Polestar.RegisterGuide(g))
end
assert(Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar Guides", author = OURS_AUTHOR or "Polestar", version = "0.1.0", license = "GPL-3.0" }))
guide("forever/westfall", "guides", { title = "Westfall", category = "Leveling" })
guide("forever/cooking", "guides", { title = "Cooking", category = "Professions" })
assert(Polestar.RegisterPack({ addon = "JoeAddon", id = "joe", format = 1, title = JOE_TITLE or "Joe's Routes", author = "Joe", version = "1.2.0",
	license = "CC-BY-4.0", source = JOE_SOURCE or "Written from my own play" }))
guide("joe/barrens", "joe", { title = "Joe's Barrens" })
guide("joe/redridge", "joe", { title = "Joe's Redridge", minLevel = 15, maxLevel = 25 })
guide("joe/tailoring", "joe", { title = "Joe's Tailoring", category = "Professions", author = "Ann" })
guide("joe/night", "joe", { title = "Night Run", folder = "Night routes" })
stub.login()
UI, P = Polestar.UI, Polestar.UI.Picker
function titles(entries)
	local out = {}
	for _, e in ipairs(entries) do out[#out + 1] = e.kind == "guide" and e.guide.title or ("[" .. e.text .. "]") end
	return out
end
function nav()
	local out = {}
	for _, b in ipairs(PolestarPicker.navButtons) do
		if b:IsShown() then out[#out + 1] = (b.psHeading and "# " or "") .. b.Label:GetText() end
	end
	return out
end
function rowFor(title)
	for _, f in ipairs(stub.frames) do
		if f.psGuide and rawget(f, "Range") and f:IsShown() and f.psGuide.title == title then return f end
	end
end
`;

function run(script, { before = '' } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `${before}\n${SETUP}\n${script}`,
	}).emitted;
}

test('our categories list only our guides; All lists both', () => {
	const [out] = run(`
		emit({ leveling = titles(P.Entries("All", "", "Leveling")), professions = titles(P.Entries("All", "", "Professions")),
			all = titles(P.Entries("All", "", "All")) })`);
	assert.deepEqual(out.leveling, ['[Leveling 1–30]', 'Westfall']);
	assert.deepEqual(out.professions, ['[Professions]', 'Cooking']);
	for (const t of ['Westfall', 'Cooking', "Joe's Barrens", "Joe's Redridge", "Joe's Tailoring", 'Night Run']) {
		assert.ok(out.all.includes(t), `All lists ${t}`);
	}
});

test('a pack\'s entry lists its guides grouped by its folders, categories and bands', () => {
	const [out] = run('emit({ joe = titles(P.Entries("All", "", "pack:joe")) })');
	assert.deepEqual(out.joe, ['[Leveling 1–30]', "Joe's Barrens", "Joe's Redridge", '[Night routes]', 'Night Run', '[Professions]', "Joe's Tailoring"]);
});

test('the "Guide packs" heading and one entry per shown pack, "<title> · <author>"; hiding the pack removes them', () => {
	const [out] = run(`
		UI.ShowPicker()
		P.SetCategory("pack:joe")
		local shown = { nav = nav(), title = PolestarPicker.Title:GetText(), joe = rowFor("Joe's Barrens") ~= nil }
		G.SetPackShown("joe", false)
		emit({ shown = shown, hidden = { nav = nav(), category = P.Category(), joe = rowFor("Joe's Barrens") ~= nil,
			all = titles(P.Entries("All", "", "All")) } })`);
	assert.deepEqual(out.shown.nav.slice(-2), ['# Guide packs', "Joe's Routes  ·  Joe"]);
	assert.equal(out.shown.title, "Joe's Routes");
	assert.equal(out.shown.joe, true);
	assert.ok(!out.hidden.nav.includes('# Guide packs'), out.hidden.nav.join(', '));
	assert.ok(!out.hidden.nav.some((l) => l.startsWith("Joe's Routes")));
	assert.equal(out.hidden.category, 'All');
	assert.equal(out.hidden.joe, false);
	assert.ok(!out.hidden.all.includes("Joe's Barrens"));
});

test('our pack switched off while one of our categories is selected: back to All, not an empty list blaming the faction', () => {
	const [out] = run(`
		UI.ShowPicker()
		P.SetCategory("Professions")
		local before = { category = P.Category(), title = PolestarPicker.Title:GetText() }
		G.SetPackShown("guides", false)
		emit({ before = before, category = P.Category(), title = PolestarPicker.Title:GetText(), empty = PolestarPicker.Empty:IsShown() and PolestarPicker.Empty:GetText() or false,
			joe = rowFor("Joe's Barrens") ~= nil })`);
	assert.deepEqual(out.before, { category: 'Professions', title: 'Professions' });
	assert.equal(out.category, 'All');
	assert.equal(out.title, 'All guides');
	assert.equal(out.empty, false);
	assert.equal(out.joe, true);
});

test('no heading without a shown pack that has guides', () => {
	const [out] = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()
			Polestar.Guides = uistub.realGuides
			assert(Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar Guides", author = "Polestar", version = "1", license = "GPL-3.0" }))
			assert(Polestar.RegisterGuide({ id = "forever/a", pack = "guides", title = "A", steps = { { goals = { { t = "level", level = 2 } } } } }))
			assert(Polestar.RegisterPack({ addon = "EmptyAddon", id = "empty", format = 1, title = "Empty", author = "E", version = "1", license = "MIT" }))
			stub.login()
			Polestar.UI.ShowPicker()
			local out = {}
			for _, b in ipairs(PolestarPicker.navButtons) do if b:IsShown() then out[#out + 1] = b.Label:GetText() end end
			emit(out)`,
	}).emitted;
	assert.ok(!out.includes('Guide packs'), out.join(', '));
});

test('pack guides carry their pack\'s title in rows and search results', () => {
	const [out] = run(`
		UI.ShowPicker()
		P.SetCategory("All")
		local all = { joe = rowFor("Joe's Barrens").Note:GetText(), ours = rowFor("Westfall").Note:GetText() }
		P.SetQuery("barrens")
		local search = rowFor("Joe's Barrens").Note:GetText()
		P.SetQuery("")
		P.SetCategory("pack:joe")
		emit({ all = all, search = search, own = rowFor("Joe's Barrens").Note:GetText() })`);
	assert.deepEqual(out.all, { joe: "Joe's Routes", ours: '' });
	assert.equal(out.search, "Joe's Routes");
	assert.equal(out.own, '', 'the pack\'s own list does not repeat its title');
});

test('details: the credits line for every guide, with the pack\'s source; the guide\'s own author wins', () => {
	const [out] = run(`
		UI.ShowPicker()
		local function credits(id)
			P.Select(id)
			local d = P.details
			return { credits = d.Credits:IsShown() and d.Credits:GetText() or false, source = d.Source:IsShown() and d.Source:GetText() or false }
		end
		emit({ joe = credits("joe/barrens"), ann = credits("joe/tailoring"), ours = credits("forever/westfall") })`);
	assert.deepEqual(out.joe, { credits: "By Joe  ·  Joe's Routes 1.2.0  ·  CC-BY-4.0", source: '“Written from my own play”' });
	assert.deepEqual(out.ann, { credits: "By Ann  ·  Joe's Routes 1.2.0  ·  CC-BY-4.0", source: '“Written from my own play”' });
	assert.deepEqual(out.ours, { credits: 'By Polestar', source: false });
});

test('a "|" in a pack title and source prints literally in the sidebar, the header, a row\'s note and the credits', () => {
	const [out] = run(`
		UI.ShowPicker()
		P.SetCategory("All")
		local note = rowFor("Joe's Barrens").Note:GetText()
		P.SetCategory("pack:joe")
		P.Select("joe/barrens")
		local d = P.details
		emit({ nav = nav(), title = PolestarPicker.Title:GetText(), note = note, credits = d.Credits:GetText(), source = d.Source:GetText() })`,
	{ before: 'JOE_TITLE = "Joe |cffff0000Red|r Routes"; JOE_SOURCE = "My |Hitem:1|h notes"' });
	// Every "|" doubled once: the client prints "||" as one "|", so no colour or link starts.
	const title = 'Joe ||cffff0000Red||r Routes';
	assert.equal(out.nav.at(-1), `${title}  ·  Joe`);
	assert.equal(out.title, title);
	assert.equal(out.note, title);
	assert.equal(out.credits, `By Joe  ·  ${title} 1.2.0  ·  CC-BY-4.0`);
	assert.equal(out.source, '“My ||Hitem:1||h notes”');
});

test('the empty states name Polestar Guides and guide packs', () => {
	const [out] = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()
			Polestar.Guides = uistub.realGuides
			stub.login()
			Polestar.Set("ui.shown", true)
			Polestar.Fire("GUIDE_CHANGED", nil)
			Polestar.UI.ShowPicker()
			Polestar.UI.Picker.SetCategory("All")
			local GF = PolestarGuideFrame
			emit({ picker = PolestarPicker.Empty:GetText(), frame = { uistub.findText(GF, "No guides installed") ~= nil,
				uistub.findText(GF, "Enable Polestar Guides or a guide pack in the AddOns list on the character screen, then reload.") ~= nil } })`,
	}).emitted;
	assert.equal(out.picker, 'No guides installed. Enable Polestar Guides or a guide pack in the AddOns list on the character screen, then reload.');
	assert.deepEqual(out.frame, [true, true]);
});

test('credits name our pack\'s author, whoever that is (nothing hard-coded)', () => {
	const [out] = run(`
		UI.ShowPicker()
		P.Select("forever/westfall")
		emit({ credits = P.details.Credits:GetText() })`, { before: 'OURS_AUTHOR = "The Polestar Team"' });
	assert.equal(out.credits, 'By The Polestar Team');
});

test('a 64-character pack title is cut: in the sidebar, the header and a row\'s note', () => {
	const long = 'R'.repeat(64);
	const [out] = run(`
		UI.ShowPicker()
		P.SetCategory("All")
		local row = rowFor("Joe's Barrens")
		local note = { text = row.Note:GetText(), w = row.Note:GetWidth(), row = row:GetWidth(), title = row.Title:GetWidth() }
		P.SetCategory("pack:joe")
		local entry
		for _, b in ipairs(PolestarPicker.navButtons) do if b:IsShown() and b.psKey == "pack:joe" then entry = b end end
		local p2, rel, rp, x = entry.Label:GetPoint(2)
		local t2, trel, trp, tx = PolestarPicker.Title:GetPoint(2)
		-- The width its anchors give it in the 240px sidebar (the stub does
		-- not resolve anchors): 64 characters wrap to many lines there, and
		-- the label keeps two.
		entry.Label:SetWidth(239 - 24 - 16 - 12 - 24)
		local fits = { lines = entry.Label:GetStringHeight() / entry.Label:GetLineHeight(), h = entry.Label:GetStringHeight(), row = entry:GetHeight() }
		emit({ note = note, fits = fits, count = entry.Count:IsShown() and math.ceil(entry.Count:GetStringWidth()) or 0, label = { n = entry.Label:GetNumPoints(), point = p2, own = rel == entry, rp = rp, x = x },
			title = { text = PolestarPicker.Title:GetText(), n = PolestarPicker.Title:GetNumPoints(), point = t2, own = trel == PolestarPicker.Header, x = tx } })`,
	{ before: `JOE_TITLE = "${long}"` });
	assert.equal(out.note.text, long);
	assert.ok(out.note.w <= Math.floor(out.note.row * 0.45), `note ${out.note.w} within 45% of ${out.note.row}`);
	assert.ok(out.note.title >= 40);
	assert.deepEqual(out.label, { n: 2, point: 'RIGHT', own: true, rp: 'RIGHT', x: -(24 + (out.count ? out.count + 8 : 0)) },
		'the label ends short of the count, as wide as it is');
	assert.equal(out.fits.lines, 2, 'a long label takes two lines at most');
	assert.ok(out.fits.h <= out.fits.row, `the label (${out.fits.h}) stays within its row (${out.fits.row})`);
	assert.equal(out.title.text, long);
	assert.deepEqual({ n: out.title.n, point: out.title.point, own: out.title.own }, { n: 2, point: 'TOPRIGHT', own: true });
	assert.ok(out.title.x < 0);
});

test('a pooled row measures its note and title from scratch: longer ones after shorter ones get their own width', () => {
	const [out] = run(`
		assert(Polestar.RegisterPack({ addon = "AnnAddon", id = "ann", format = 1, title = "Ann's Long Winding Routes", author = "Ann", version = "1", license = "MIT" }))
		guide("ann/barrens", "ann", { title = "Ann's Barrens Loop" })
		UI.ShowPicker()
		P.SetCategory("All")
		P.SetQuery("joe's barrens")
		local first = rowFor("Joe's Barrens")
		local short = { text = first.Note:GetText(), w = first.Note:GetWidth(), title = first.Title:GetWidth() }
		P.SetQuery("ann's barrens")
		local row = rowFor("Ann's Barrens Loop")
		emit({ same = row == first, short = short, text = row.Note:GetText(), w = row.Note:GetWidth(),
			full = row.Note:GetUnboundedStringWidth(), row = row:GetWidth(),
			title = row.Title:GetWidth(), titleFull = row.Title:GetUnboundedStringWidth() })`);
	assert.equal(out.same, true, 'the pool hands the same row back');
	assert.equal(out.short.text, "Joe's Routes");
	assert.equal(out.text, "Ann's Long Winding Routes");
	assert.ok(out.full > out.short.w, 'the second note is longer than the first');
	assert.equal(out.w, Math.min(Math.floor(out.full + 1), Math.floor(out.row * 0.45)));
	assert.ok(out.titleFull > out.short.title, 'the second title is longer than the first');
	assert.equal(out.title, Math.floor(out.titleFull + 1), 'the title has room and gets its whole width');
});

test('every pack switched off: the empty states point to the Guide packs page, not the AddOns list', () => {
	const [out] = run(`
		G.SetPackShown("guides", false)
		G.SetPackShown("joe", false)
		Polestar.Set("ui.shown", true)
		Polestar.Fire("GUIDE_CHANGED", nil)
		UI.ShowPicker()
		P.SetCategory("All")
		local GF = PolestarGuideFrame
		local button
		for _, f in ipairs(stub.frames) do
			if rawget(f, "psAction") and rawget(f, "Label") and f:IsVisible() and f.Label:GetText() == "Guide packs" then button = f end
		end
		local r = { picker = PolestarPicker.Empty:GetText(), title = uistub.findText(GF, "No guides shown") ~= nil,
			text = uistub.findText(GF, "The guide packs are switched off. Turn one on under Options, Guide packs (/polestar packs).") ~= nil,
			installed = uistub.findText(GF, "No guides installed") ~= nil, button = button ~= nil }
		if button then button.psAction() end
		r.options = PolestarOptions ~= nil and PolestarOptions:IsShown() and PolestarOptions.Title:GetText() or false
		emit(r)`);
	assert.equal(out.picker, 'No guides shown: the guide packs are switched off. Turn one on under Options, Guide packs (/polestar packs).');
	assert.deepEqual({ title: out.title, text: out.text, installed: out.installed, button: out.button },
		{ title: true, text: true, installed: false, button: true });
	assert.equal(out.options, 'Guide packs');
});
