'use strict';
// The Guide packs page (addon/Polestar/UI/Packs.lua, registered by
// UI/Options.lua) against the real Core + Theme + UI manifests. The UI's
// fake Engine comes from tests/lua/stub_ui.lua; the guide registry is the
// real one (Core/Guides.lua), so the rows come from the core's own records
// and its scan of the AddOns list.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

// The AddOns list of the installed-pack scan (ours, Joe's, an empty pack, one turned
// off, one out of date, one too new, one that crashed before registering)
// plus a pack with two problems and one with dungeon guides only.
const ADDONS = `
ADDON_INTERFACE_VERSION = "Out of date"
stub.addons = {
	{ name = "Polestar", loaded = true },
	{ name = "Polestar_Guides", loaded = true },
	{ name = "JoeAddon", loaded = true },
	{ name = "EmptyAddon", loaded = true },
	{ name = "Off", reason = "DISABLED", enabled = false },
	{ name = "Old", reason = "INTERFACE_VERSION" },
	{ name = "Future", reason = "INTERFACE_VERSION" },
	{ name = "Crash", loaded = true },
	{ name = "Probs", loaded = true },
	{ name = "Dung", loaded = true },
}
local function toc(id, title, extra)
	local m = { ["X-Polestar-Pack"] = id, ["X-Polestar-Format"] = "1", Title = title, Author = title .. " Author", Version = "2.0", ["X-License"] = "CC0-1.0", ["X-Website"] = "https://example.org/" .. id }
	for k, v in pairs(extra or {}) do m[k] = v end
	return m
end
stub.addonMeta.Polestar_Guides = toc("guides", "Polestar Guides")
stub.addonMeta.JoeAddon = toc("joe", "Joe's Routes")
stub.addonMeta.EmptyAddon = toc("empty", "Empty")
stub.addonMeta.Off = toc("off", "Switched Off")
stub.addonMeta.Old = toc("old", "Old Pack")
stub.addonMeta.Future = toc("future", "Future Pack", { ["X-Polestar-Format"] = "4", ["X-Polestar-Needs"] = "0.4.0" })
stub.addonMeta.Crash = toc("crash", "Crashing Pack")
stub.addonMeta.Probs = toc("probs", "Problem Pack")
stub.addonMeta.Dung = toc("dung", "Dungeon Pack")
`;

const PACKS = `
uistub.install()
Polestar.Guides = uistub.realGuides
G = uistub.realGuides
local function meta(addon, id, title, extra)
	local m = { addon = addon, id = id, format = 1, title = title, author = title .. " Author", version = "1.2.0", license = "MIT" }
	for k, v in pairs(extra or {}) do m[k] = v end
	return m
end
local function guide(id, pack, extra)
	local g = { id = id, pack = pack, title = "T " .. id, minLevel = 10, maxLevel = 20, steps = { { goals = { { t = "level", level = 20 } } } } }
	for k, v in pairs(extra or {}) do g[k] = v end
	return Polestar.RegisterGuide(g)
end
assert(Polestar.RegisterPack(meta("Polestar_Guides", "guides", "Polestar Guides", { author = "Polestar", license = "GPL-3.0" })))
guide("forever/a", "guides")
guide("forever/b", "guides")
assert(Polestar.RegisterPack(meta("JoeAddon", "joe", JOE_TITLE or "Joe's Routes", { author = "Joe", license = "CC-BY-4.0",
	website = "https://github.com/joe/routes", source = JOE_SOURCE or "Written from my own play" })))
guide("joe/a", "joe")
assert(Polestar.RegisterPack(meta("EmptyAddon", "empty", "Empty")))
assert(Polestar.RegisterPack(meta("Probs", "probs", "Problem Pack")))
guide("probs/ok", "probs")
guide("elsewhere/one", "probs")
guide("elsewhere/two", "probs")
assert(Polestar.RegisterPack(meta("Dung", "dung", "Dungeon Pack")))
guide("dung/deadmines", "dung", { category = "Dungeons" })
stub.login()
UI, O, P = Polestar.UI, Polestar.UI.Options, Polestar.UI.Packs
function openPage() UI.ShowOptions("guidepacks"); return P.view end
function rowOf(addon)
	for _, r in ipairs(P.view.rows) do if r:IsShown() and r.psRecord.addon == addon then return r end end
end
function shownText(fs) return fs:IsShown() and fs:GetText() or false end
function navDot()
	for _, b in ipairs(PolestarOptions.navButtons) do
		if b:IsShown() and b.psKey == "guidepacks" then return b.Dot:IsShown() end
	end
end
`;

function run(script, { before = '' } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		before: ADDONS + before,
		addons: [{ name: 'Polestar', files: FILES }],
		script: `${PACKS}\n${script}`,
	}).emitted;
}

test('one row per pack, ours first: credits, count, website, source and each status', () => {
	const [out] = run(`
		openPage()
		local rows = {}
		for _, r in ipairs(P.view.rows) do
			if r:IsShown() then
				rows[#rows + 1] = { addon = r.psRecord.addon, title = r.Title:GetText(), credits = r.Credits:GetText(),
					count = shownText(r.Count), switch = r.Switch:IsShown(), enable = r.Enable:IsShown(),
					status = shownText(r.Status), problems = r.Problems:IsShown() and r.Problems.Text:GetText() or false,
					website = r.Website:IsShown() and r.Website.Label:GetText() or false, source = shownText(r.Source) }
			end
		end
		emit({ rows = rows, title = PolestarOptions.Title:GetText() })`);
	const by = Object.fromEntries(out.rows.map((r) => [r.addon, r]));
	assert.equal(out.title, 'Guide packs');
	assert.deepEqual(out.rows.map((r) => r.addon),
		['Polestar_Guides', 'Crash', 'Dung', 'EmptyAddon', 'Future', 'JoeAddon', 'Old', 'Probs', 'Off']);
	assert.deepEqual(by.Polestar_Guides, { addon: 'Polestar_Guides', title: 'Polestar Guides', credits: 'Polestar  ·  1.2.0  ·  GPL-3.0',
		count: '2 guides', switch: true, enable: false, status: false, problems: false, website: false, source: false });
	assert.deepEqual(by.JoeAddon, { addon: 'JoeAddon', title: "Joe's Routes", credits: 'Joe  ·  1.2.0  ·  CC-BY-4.0',
		count: '1 guide', switch: true, enable: false, status: false, problems: false,
		website: 'github.com/joe/routes', source: '“Written from my own play”' });
	assert.equal(by.EmptyAddon.status, 'broken: registered no guides');
	assert.equal(by.EmptyAddon.switch, false);
	assert.equal(by.Crash.status, 'broken: registered no guides');
	assert.equal(by.Crash.website, 'example.org/crash', 'a pack read from its TOC shows its website');
	assert.equal(by.Off.status, 'turned off in the AddOns list');
	assert.equal(by.Off.enable, true);
	assert.equal(by.Old.status, 'not loaded: Out of date');
	assert.equal(by.Future.status, 'needs Polestar 0.4.0 or newer');
	assert.equal(by.Probs.problems, '2 problems');
	assert.equal(by.Probs.switch, true);
	assert.equal(by.Probs.count, '1 guide');
});

test('a too-new pack without X-Polestar-Needs needs "a newer Polestar"', () => {
	const [out] = run(`openPage(); emit({ status = shownText(rowOf("Future").Status) })`,
		{ before: 'stub.addonMeta.Future["X-Polestar-Needs"] = nil' });
	assert.equal(out.status, 'needs a newer Polestar');
});

test('the switch hides and shows a pack through Guides.SetPackShown', () => {
	const [out] = run(`
		openPage()
		local calls = {}
		local set = G.SetPackShown
		G.SetPackShown = function(id, shown) calls[#calls + 1] = { id, shown }; return set(id, shown) end
		local row = rowOf("JoeAddon")
		row.Switch:Click()
		local off = { status = G.Pack("joe").status, checked = rowOf("JoeAddon").Switch.checked, stored = PolestarDB.packs.joe.off }
		rowOf("JoeAddon").Switch:Click()
		emit({ calls = calls, off = off, on = G.Pack("joe").status })`);
	assert.deepEqual(out.calls, [['joe', false], ['joe', true]]);
	assert.deepEqual(out.off, { status: 'off', checked: false, stored: true });
	assert.equal(out.on, 'on');
});

test('Enable and reload enables the addon, then reloads', () => {
	const [out] = run(`
		openPage()
		rowOf("Off").Enable:Click()
		emit({ enabled = stub.enabledAddOns, reloaded = stub.reloaded or false })`);
	assert.deepEqual(out.enabled, ['Off']);
	assert.equal(out.reloaded, true);
});

test('Show lists the problems; Copy report fills a selected box with the pack, versions, build and every problem', () => {
	const [out] = run(`
		openPage()
		local row = rowOf("Probs")
		local before = { list = row.List:IsShown(), report = row.Report:IsShown() }
		row.ShowList:Click()
		row = rowOf("Probs")
		local list = shownText(row.List)
		local label = row.ShowList.Label:GetText()
		row.CopyReport:Click()
		row = rowOf("Probs")
		local messages = {}
		for i, p in ipairs(G.Pack("probs").problems) do messages[i] = p.message end
		emit({ before = before, list = list, label = label, report = row.Report:IsShown() and row.Report:GetText() or false,
			focused = stub.focus == row.Report, messages = messages })`);
	assert.deepEqual(out.before, { list: false, report: false });
	assert.equal(out.label, 'Hide');
	assert.equal(out.messages.length, 2);
	for (const m of out.messages) {
		assert.ok(out.list.includes(m), `the list shows "${m}"`);
		assert.ok(out.report.includes(m), `the report has "${m}"`);
	}
	assert.match(out.report, /^Pack: probs \(Probs\)$/m);
	assert.match(out.report, /Pack version: 1\.2\.0/);
	assert.match(out.report, /Polestar version: 0\.1\.0-test/);
	assert.match(out.report, /1\.60\.1 \(70338\)/);
	assert.equal(out.focused, true, 'the report box takes focus, its text selected');
});

test('Copy report keeps the report open and selects it again; Hide or Escape closes it', () => {
	const [out] = run(`
		openPage()
		local row = rowOf("Probs")
		local selected = 0
		local highlight = row.Report.HighlightText
		row.Report.HighlightText = function(self, ...) selected = selected + 1; return highlight(self, ...) end
		row.CopyReport:Click()
		local first = selected
		rowOf("Probs").CopyReport:Click()
		local again = { open = rowOf("Probs").Report:IsShown(), selected = selected > first, label = rowOf("Probs").ShowList.Label:GetText() }
		rowOf("Probs").ShowList:Click()
		local hidden = rowOf("Probs").Report:IsShown()
		rowOf("Probs").CopyReport:Click()
		local report = rowOf("Probs").Report
		stub.RunScript(report, "OnEscapePressed")
		emit({ again = again, hidden = hidden, escaped = rowOf("Probs").Report:IsShown() })`);
	assert.deepEqual(out.again, { open: true, selected: true, label: 'Hide' });
	assert.equal(out.hidden, false, 'Hide closes the report');
	assert.equal(out.escaped, false, 'Escape closes the report');
});

test('the report box grows to fit a long problem message as it wraps', () => {
	const [out] = run(`
		openPage()
		local probs = G.Pack("probs").problems
		probs[#probs + 1] = { message = string.rep("a step's target names a quest that no guide in the pack has ", 6) }
		rowOf("Probs").CopyReport:Click()
		local report = rowOf("Probs").Report
		local _, newlines = report:GetText():gsub("\\n", "")
		emit({ h = report:GetHeight(), byLines = (newlines + 1) * 16 + 16 })`);
	assert.ok(out.h > out.byLines, `${out.h} > ${out.byLines}`);
});

test('a refused pack says why', () => {
	const [out] = run(`
		Polestar.RegisterPack({ addon = "JoeCopy", id = "joe", format = 1, title = "Joe Again", author = "X", version = "1", license = "MIT" })
		openPage()
		local row = rowOf("JoeCopy")
		emit({ status = shownText(row.Status), switch = row.Switch:IsShown() })`);
	assert.equal(out.switch, false);
	assert.match(out.status, /^refused: Pack id joe is already taken by JoeAddon; JoeCopy was refused\.$/);
});

test('a refused pack\'s id and addon, kept as given, print literally in the row title and the report', () => {
	const [out] = run(`
		Polestar.RegisterPack({ addon = "Bad|Addon", id = "bad|cffid", format = 1 })
		openPage()
		local row = rowOf("Bad|Addon")
		local title = row.Title:GetText()
		row.CopyReport:Click()
		row = rowOf("Bad|Addon")
		emit({ title = title, report = row.Report:IsShown() and row.Report:GetText() or false, status = shownText(row.Status) })`);
	assert.equal(out.title, 'bad||cffid');
	assert.ok(out.report, 'the report opens');
	assert.equal(out.report.split('\n')[0], 'Pack: bad||cffid (Bad||Addon)');
	// Once: the refusal message escaped the id already, the report adds nothing to it.
	assert.match(out.status, /Pack id bad\|\|cffid is not valid/);
	assert.doesNotMatch(out.report, /\|\|\|\|/);
});

test('the source wraps on its own line under the website box, at the row\'s full width', () => {
	const long = 'Written from my own play on a fresh character, every quest done in the order the route takes them';
	const [out] = run(`
		openPage()
		local row = rowOf("JoeAddon")
		local _, _, _, bx, by = row.Website:GetPoint(1)
		local _, _, _, sx, sy = row.Source:GetPoint(1)
		local _, _, _, cx = row.Credits:GetPoint(1)
		emit({ text = row.Source:GetText(), box = { x = bx, y = by, h = row.Website:GetHeight(), w = row.Website:GetWidth() },
			source = { x = sx, y = sy, w = row.Source:GetWidth(), h = row.Source:GetStringHeight() }, credits = cx,
			row = row:GetWidth(), rowH = row:GetHeight() })`,
	{ before: `JOE_SOURCE = "${long}"` });
	assert.equal(out.text, `“${long}”`);
	assert.equal(out.source.x, out.box.x, 'under the box, on the credits column');
	assert.equal(out.source.x, out.credits);
	assert.ok(out.source.y <= out.box.y - out.box.h, `below the box (${out.source.y} vs ${out.box.y}-${out.box.h})`);
	assert.ok(out.source.w > out.box.w, 'wider than the box');
	assert.equal(out.source.x + out.source.w, out.row - 12, 'to the row\'s right inset');
	assert.ok(out.source.h > 12, 'it wraps');
	assert.ok(out.rowH >= -out.source.y + out.source.h, 'the row grows to hold it');
});

test('Suggest guides from lists Polestar and packs with leveling guides; choosing one sets behavior.suggestFrom', () => {
	const [out] = run(`
		local view = openPage()
		view.Source.Button:Click()
		local choices = {}
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then choices[#choices + 1] = r.Text:GetText() end end
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Joe's Routes" then r:Click() end end
		emit({ choices = choices, setting = Polestar.Get("behavior.suggestFrom"), source = G.SuggestSource(),
			shown = view.Source.Button.Label:GetText(), sources = G.SuggestSources() })`);
	assert.deepEqual(out.sources, ['guides', 'joe', 'probs'], 'the page lists what the core allows');
	assert.deepEqual(out.choices, ['Polestar', "Joe's Routes", 'Problem Pack']);
	assert.equal(out.setting, 'joe');
	assert.equal(out.source, 'joe');
	assert.equal(out.shown, "Joe's Routes");
});

test('the navigation dot shows while a pack has problems and goes with them', () => {
	const [out] = run(`
		UI.ShowOptions("guide")
		local with = navDot()
		emit({ with = with })`);
	assert.equal(out.with, true);
	const [clean] = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()
			Polestar.Guides = uistub.realGuides
			assert(Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar Guides", author = "Polestar", version = "1", license = "GPL-3.0" }))
			assert(Polestar.RegisterGuide({ id = "forever/a", pack = "guides", title = "A", steps = { { goals = { { t = "level", level = 2 } } } } }))
			stub.login()
			Polestar.UI.ShowOptions("guide")
			local dot
			for _, b in ipairs(PolestarOptions.navButtons) do if b:IsShown() and b.psKey == "guidepacks" then dot = b.Dot:IsShown() end end
			emit({ dot = dot, problems = Polestar.Guides.ProblemCount() })`,
	}).emitted;
	assert.deepEqual(clean, { dot: false, problems: 0 });
});

test('/polestar packs opens the page', () => {
	const [out] = run(`
		SlashCmdList.POLESTAR("packs")
		emit({ shown = PolestarOptions:IsShown(), title = PolestarOptions.Title:GetText() })`);
	assert.deepEqual(out, { shown: true, title: 'Guide packs' });
});

test('the website and the docs line are links that open the copy window; without X-Website, the source path', () => {
	const [withSite] = run(`
		local view = openPage()
		local seen = { label = view.DocsLabel:GetText(), link = view.Docs:IsShown() and view.Docs.Label:GetText() or false,
			kind = view.Docs:GetObjectType() }
		view.Docs:Click()
		seen.docsTitle, seen.docsCopy = PolestarCopy.Title:GetText(), PolestarCopy.Box:GetText()
		rowOf("JoeAddon").Website:Click()
		seen.siteTitle, seen.siteCopy = PolestarCopy.Title:GetText(), PolestarCopy.Box:GetText()
		emit(seen)`,
	{ before: 'stub.addonMeta.Polestar = { ["X-Website"] = "https://github.com/polestar/polestar/" }' });
	assert.deepEqual(withSite, {
		label: 'Read more:', link: 'github.com/polestar/polestar/blob/HEAD/docs/GUIDE_PACKS.md', kind: 'Button',
		docsTitle: 'Guide packs, explained', docsCopy: 'https://github.com/polestar/polestar/blob/HEAD/docs/GUIDE_PACKS.md',
		siteTitle: "Joe's Routes website", siteCopy: 'https://github.com/joe/routes',
	});
	const [without] = run(`
		local view = openPage()
		emit({ label = view.DocsLabel:GetText(), link = view.Docs:IsShown() })`);
	assert.deepEqual(without, { label: "Read more: docs/GUIDE_PACKS.md in Polestar's source", link: false });
});

test('a 64-character title is cut to its column, inside the row', () => {
	const long = 'A'.repeat(64);
	const [out] = run(`
		local view = openPage()
		local row = rowOf("JoeAddon")
		local _, _, _, x = row.Title:GetPoint(1)
		emit({ text = row.Title:GetText(), width = row.Title:GetWidth(), x = x, row = row:GetWidth(),
			credits = select(4, row.Credits:GetPoint(1)) })`,
	{ before: `JOE_TITLE = "${long}"` });
	assert.equal(out.text.length, 64);
	assert.ok(out.width > 0 && out.x + out.width < out.credits, `title box ${out.x}+${out.width} ends before the credits at ${out.credits}`);
	assert.ok(out.x + out.width <= out.row);
});
