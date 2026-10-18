'use strict';
// Reporting a problem (addon/Polestar/UI/Report.lua): the guide window's bug
// button, its menu entry and /polestar report open a window that sets the
// player's words above the details a fix needs, as one report: to copy for
// the Polestar Discord's #bugs, or in a link that opens a filled-in GitHub
// issue for a player with an account;
// the sidebars of the hub and the settings, and
// /polestar discord, give the invite with Discord's mark. Against the real
// Core, Theme and UI and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];
const INVITE = 'https://discord.gg/vMbee6F2e9';

function run(script, before = '') {
	return runAddon({
		stubs: ['stub_ui.lua'],
		before,
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\nlocal GF, UI = Polestar.UI.GuideFrame, Polestar.UI\n${script}`,
	}).emitted;
}

const lineWith = (text, needle) => text.split('\n').find((l) => l.includes(needle));

test('the bug in the navigator reports the step on screen: the player\'s words, then the guide, the step, each goal\'s state, ids and position, the arrow and the versions', () => {
	const [out] = run(`
		Polestar.Engine.SetGuide(nil)
		local noGuide = GF.parts.nav.Report:IsShown()
		uistub.setGuide(uistub.elwynn, 3)
		local nav = GF.parts.nav
		local shown = nav.Report:IsShown()
		nav.Report:Click()
		local F = PolestarReport
		local opened = { shown = F:IsShown(), typing = stub.focus == F.Desc, context = F.Context:GetText() }
		F.Desc:SetText("The vermin were all by the tents.")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		local hidden = not F.Box:IsShown()
		local closedH = F:GetHeight()
		F.Copy:Click()
		local text = F.Box:GetText()
		local selected = F.Box:IsShown() and stub.focus == F.Box
		local boxH = F.Box:GetHeight()
		local grown = F:GetHeight() - closedH
		local openH = F:GetHeight()
		F.Invite:Click()
		emit({ noGuide = noGuide, shown = shown, opened = opened, text = text, hidden = hidden, selected = selected, grown = grown, openH = openH,
			invite = { shown = PolestarCopy:IsShown(), text = PolestarCopy.Box:GetText(), focus = stub.focus == PolestarCopy.Box }, boxH = boxH })`);
	assert.equal(out.noGuide, false, 'no guide, no step to report: the bug is not there');
	assert.equal(out.shown, true);
	assert.deepEqual(out.opened, { shown: true, typing: true, context: 'Step 3 of 8  \u00b7  Kobold Camp  \u00b7  Elwynn Forest' });
	const lines = out.text.split('\n');
	assert.equal(lines[0], '**What went wrong:** The vermin were all by the tents.', 'the player\'s words come first, as they typed them');
	assert.equal(lines[1], '```');
	assert.equal(lines[lines.length - 1], '```', 'the details sit in one code block');
	assert.ok(lines.includes('Guide: Elwynn Forest (forever/alliance/human/01-elwynn-forest)'), out.text);
	assert.ok(lines.includes('Step 3 of 8: Kobold Camp'), out.text);
	const kill = lineWith(out.text, 'Kobold Vermin');
	assert.ok(kill.startsWith('[>] Kill Kobold Vermin 7/10'), `the arrow's goal, with its count: ${kill}`);
	for (const fact of ['quest 7', 'npc 6', 'map 1429 @47.60,35.10 live']) assert.ok(kill.includes(fact), `${fact} in ${kill}`);
	assert.ok(lineWith(out.text, 'Wolves Across the Border').startsWith('[x] Accept'), 'a done goal');
	const meat = lineWith(out.text, 'Tough Wolf Meat');
	assert.ok(meat.startsWith('[ ] Kill Young Wolf for Tough Wolf Meat 3/8') && meat.includes('item 750'), meat);
	assert.ok(lineWith(out.text, 'Arrow:').includes('42 yd'), out.text);
	assert.ok(lineWith(out.text, 'Where:').includes('Elwynn Forest'), out.text);
	const routes = lines.indexOf(lineWith(out.text, 'Routes:'));
	assert.equal(lines[routes], 'Routes: balanced', 'the default route style, and nothing else when the rest is at its defaults');
	assert.equal(routes, lines.indexOf(lineWith(out.text, 'Where:')) + 1, 'right after Where, so the bug bot still finds Arrow and Where by position');
	const who = lineWith(out.text, 'Human Warrior');
	assert.ok(who.includes('level 4') && who.includes('Alliance'), who);
	const versions = lineWith(out.text, 'client ');
	assert.ok(versions.startsWith('Polestar ') && versions.includes('client 1.60.1 (70338)') && versions.endsWith('enUS'), versions);
	assert.ok(lines.includes('Errors: none'), out.text);
	assert.equal(out.hidden, true, 'the report is not shown until it is asked for');
	assert.equal(out.selected, true, 'Copy report shows the report in focus, selected for Ctrl+C');
	assert.ok(out.grown >= out.boxH, `the window grows to hold it (${out.grown}px for a ${out.boxH}px box)`);
	assert.ok(out.openH <= 720, `with the report shown, the window fits a 720-unit screen (${out.openH})`);
	assert.deepEqual(out.invite, { shown: true, text: INVITE, focus: true }, 'Get the invite opens the invite on its own, selected');
	assert.ok(out.boxH >= lines.length * 11, `the box holds every line (${out.boxH}px for ${lines.length})`);
});

test('the report says how the arrow routes: the route style, then only the routing settings turned away from their defaults', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local function routes()
			UI.ShowReport()
			for line in PolestarReport.Box:GetText():gmatch("[^\\n]+") do
				if line:find("^Routes: ") then return line end
			end
		end
		local r = {}
		Polestar.Set("nav.routeStyle", "roads")
		r.roads = routes()
		Polestar.Set("nav.routeStyle", "fastest")
		Polestar.Set("nav.navRouting", false)
		Polestar.Set("nav.travel", false)
		r.off = routes()
		Polestar.Set("nav.routeStyle", "something old")
		r.unknown = routes()
		emit(r)`);
	assert.equal(out.roads, 'Routes: roads');
	assert.equal(out.off, 'Routes: fastest · real paths off · travel planner off');
	assert.equal(out.unknown, 'Routes: balanced · real paths off · travel planner off', 'a style the router reads as Balanced is reported as Balanced');
});

// The longest report a player can send: every line at its cap in `word`'s
// script under `locale`, the description at its most letters, 40 addons and
// a marked right spot. Returns the report for Discord and the issue link.
function longest(locale, word, letter, opts = {}) {
	return run(`
		local word, letter = ${JSON.stringify(word)}, ${JSON.stringify(letter)}
		local long = string.rep(word, 12)
		local goals = {}
		for i = 1, 9 do
			goals[i] = { t = "kill", verb = word, subject = long, subjectKind = "npc", npc = 1000000 + i, quest = 2000000 + i, item = 3000000 + i,
				progress = { cur = 99, max = 100 }, map = 1429, x = 47.123, y = 35.456, status = "active" }
		end
		local id = "test/a-long-guide"
		uistub.guides[id] = { id = id, pack = "guides", title = word, faction = "Alliance", minLevel = 1, maxLevel = 60, steps = { { title = long, goals = goals } } }
		for i = 1, 6 do Polestar.NoteError("Interface/AddOns/Polestar/UI/" .. string.rep("Long", 12) .. i .. ".lua:1: " .. long) end
		for i = 1, 40 do
			local name = ("QuestAndMapHelperWithALongName%02d"):format(i)
			stub.addons[#stub.addons + 1] = { name = name, loaded = true }
			stub.addonMeta[name] = { Version = "v12.34.56-" .. word }
		end
		uistub.player = { level = 59, xp = 1, xpMax = 3, race = long, class = "WARRIOR", faction = word }
		Polestar.Compat.GetZoneText = function() return word, "Goldshire Inn" end
		Polestar.Guides.Pack = function() return { title = long, version = word } end
		Polestar.Guides.Packs = function() return { { title = long, version = word, status = "on" }, { title = long, status = "on" } } end
		Polestar.Compat.GetPlayerMapPosition = function() return 1429, 51.234, 40.5 end
		for i = 1, 4 do stub.fire("ADDON_ACTION_BLOCKED", "Polestar_" .. string.rep("Long", 10), string.rep("Protected", 8) .. i .. "()") end
		uistub.setGuide(id, 1)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText(string.rep(letter, UI.Report.DESC_MAX))
		stub.RunScript(F.Desc, "OnTextChanged", true)
		${opts.unmarked ? '' : `F.Mark:Click()
		PolestarMark.Here:Click()`}
		${opts.linkMax ? `UI.Report.LINK_MAX = ${opts.linkMax}` : ''}
		F.GitHub:Click()
		local url = PolestarCopy.Box:GetText()
		F.Copy:Click()
		emit({ text = F.Box:GetText(), url = url, max = UI.Report.LINK_MAX, details = F.details.lines, height = F:GetHeight() })`, `function GetLocale() return "${locale}" end`)[0];
}

const SCRIPTS = [
	['enUS', 'Overlook of the Brightwater Lake ', 'w'],
	['ruRU', '\u0421\u043c\u043e\u0442\u0440\u043e\u0432\u0430\u044f \u043f\u043b\u043e\u0449\u0430\u0434\u043a\u0430 ', '\u0436'],
	['zhCN', '\u5e03\u83b1\u7279\u6c83\u7279\u6e56\u7684\u77ad\u671b\u53f0', '\u6e56'],
];

// The details code block of a report, its lines between the fences.
const block = (text) => text.slice(text.indexOf('```\n') + 4, text.lastIndexOf('\n```')).split('\n');

test('at its longest, with a marked spot and 40 addons, the report still fits one Discord message in every script: the Addons line is shortened, never a line the Discord bot reads', () => {
	for (const [locale, word, letter] of SCRIPTS) {
		const { text, details } = longest(locale, word, letter);
		const lines = text.split('\n');
		// Discord counts characters, as JavaScript does: one each, two past U+FFFF.
		assert.ok(text.length <= 2000, `${locale}: ${text.length} characters, ${Buffer.byteLength(text, 'utf8')} bytes`);
		assert.ok(lines[0].endsWith(letter.repeat(250)), `${locale}: the description is kept whole`);
		assert.deepEqual(block(text), details, `${locale}: every detail line, as taken`);
		assert.equal(lines[1], '**Right spot:** zone map 1429 · goto 51.23,40.50 live', `${locale}: the right spot is kept`);
	}
	const english = longest(...SCRIPTS[0]);
	assert.equal(english.text.length, 2000, 'English is the one that runs over');
	const addons = english.text.split('\n')[2];
	assert.match(addons, /^\*\*Addons:\*\* QuestAndMapHelperWithALongName01, .*\.\.\.$/, `the Addons line gives way: ${addons}`);
	const unmarked = longest(...SCRIPTS[0], { unmarked: true }).text;
	assert.equal(unmarked.split('\n')[1], '**Addons:** QuestAndMapHelperWithALongName01, QuestAndMapHelperWithALongName02, QuestAndMapHelperWithALongNam...', 'with room, the Addons line stays, cut at 100 bytes');
	assert.match(english.text, /^\.\.\. 3 more goals$/m, 'goals past the sixth are counted, not listed');
	assert.equal((english.text.match(/^ {2}1x /gm) || []).length, 3, 'the newest three of the errors and blocked calls together');
	assert.equal((english.text.match(/^ {2}1x blocked in Polestar_Long/gm) || []).length, 3, 'the blocked calls came last');
});

test('errors Polestar caught come with the report, counted, by their path from the AddOns folder; !BugGrabber adds the session\'s errors in Polestar\'s files', () => {
	const [out] = run(`
		Polestar.On("TEST_FAIL", function() error("Interface/AddOns/Polestar/UI/GuideFrame.lua:12: attempt to index a nil value", 0) end)
		pcall(Polestar.Fire, "TEST_FAIL")
		pcall(Polestar.Fire, "TEST_FAIL")
		BugGrabber = {
			GetSessionId = function() return 7 end,
			GetDB = function() return {
				{ message = "Interface/AddOns/Polestar/Nav/Arrow.lua:40: bad argument", counter = 3, session = 7 },
				{ message = "Interface/AddOns/OtherAddon/Main.lua:1: not ours", counter = 1, session = 7 },
				{ message = "Interface/AddOns/Polestar/Old.lua:1: an earlier session", counter = 1, session = 6 },
				{ message = "Interface/AddOns/Polestar/UI/GuideFrame.lua:12: attempt to index a nil value", counter = 2, session = 7 },
			} end,
		}
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		emit({ text = PolestarReport.Box:GetText() })`);
	const errors = out.text.split('\n').filter((l) => l.startsWith('  '));
	assert.deepEqual(errors, [
		'  2x Polestar/UI/GuideFrame.lua:12: attempt to index a nil value',
		'  3x Polestar/Nav/Arrow.lua:40: bad argument',
	]);
});

test('actions the game blocked from Polestar (taint, no Lua error) come with the report: by the addon blamed, counted, newest time, sharing the newest three with the errors; other addons\' are left out', () => {
	const [out] = run(`
		Polestar.NoteError("Interface/AddOns/Polestar/UI/GuideFrame.lua:1: oldest")
		stub.fire("ADDON_ACTION_BLOCKED", "Polestar", "UseAction()")
		stub.advance(5)
		stub.fire("ADDON_ACTION_FORBIDDEN", "OtherAddon", "CastSpellByName()")
		stub.fire("ADDON_ACTION_FORBIDDEN", "Polestar_Gamepad", "ClearOverrideBindings()")
		Polestar.NoteError("Interface/AddOns/Polestar/Nav/Arrow.lua:2: between")
		stub.fire("ADDON_ACTION_BLOCKED", "Polestar", "UseAction()")
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		emit({ text = PolestarReport.Box:GetText(), at = date("%H:%M:%S") })`);
	const lines = out.text.split('\n');
	assert.ok(!lines.includes('Errors: none'), out.text);
	assert.ok(lines.includes('Errors:'), out.text);
	assert.deepEqual(lines.filter((l) => l.startsWith('  ')), [
		`  1x blocked in Polestar_Gamepad: ClearOverrideBindings() (${out.at})`,
		'  1x Polestar/Nav/Arrow.lua:2: between',
		`  2x blocked in Polestar: UseAction() (${out.at})`,
	]);
});

test('what the player typed stays while it is the same step; a report on another step starts empty', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText("Half typed")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		F:Hide()
		UI.ShowReport()
		local same = { text = F.Desc:GetText(), placeholder = F.Desc.Placeholder:IsShown() }
		uistub.setStep(4)
		UI.ShowReport()
		local other = { text = F.Desc:GetText(), placeholder = F.Desc.Placeholder:IsShown(), report = F.Box:GetText():match("^[^\\n]*") }
		emit({ same = same, other = other })`);
	assert.deepEqual(out.same, { text: 'Half typed', placeholder: false });
	assert.deepEqual(out.other, { text: '', placeholder: true, report: '**What went wrong:** (not described)' });
});

test('the guide window\'s menu and /polestar report open it too; Escape closes it', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		GF.menuButton:Click()
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Report a problem" then r:Click() end end
		local fromMenu = PolestarReport:IsShown()
		PolestarReport:Hide()
		SlashCmdList.POLESTAR("report")
		local special = false
		for _, name in ipairs(UISpecialFrames) do if name == "PolestarReport" then special = true end end
		emit({ fromMenu = fromMenu, fromCommand = PolestarReport:IsShown(), special = special })`);
	assert.deepEqual(out, { fromMenu: true, fromCommand: true, special: true });
});

test('the hub and the settings carry the Polestar Discord at the foot of the sidebar: Discord\'s mark in its own colour, the invite selected on a click', () => {
	const [out] = run(`
		local T = Polestar.Theme
		local function mark(f)
			local b = f.Discord
			stub.RunScript(b, "OnEnter")
			stub.RunScript(b, "OnLeave")
			local r, g, bl = b.Icon:GetVertexColor()
			return { texture = b.Icon:GetTexture():match("([%w-]+)$"), color = { r, g, bl }, shown = b:IsShown() }
		end
		local function invite()
			return { shown = PolestarCopy:IsShown(), text = PolestarCopy.Box:GetText(), focus = stub.focus == PolestarCopy.Box,
				icon = PolestarCopy.Icon:IsShown() and PolestarCopy.Icon:GetTexture():match("([%w-]+)$") or false }
		end
		UI.ShowPicker()
		local hub = mark(PolestarPicker)
		PolestarPicker.Discord:Click()
		local fromHub = invite()
		PolestarCopy:Hide()
		UI.ShowOptions()
		local settings = mark(PolestarOptions)
		PolestarCopy:Hide()
		SlashCmdList.POLESTAR("discord")
		local fromCommand = invite()
		UI.ShowCopy("Your position", "zone map 1429")
		local r, g, b = T.Color("discord")
		emit({ hub = hub, settings = settings, fromHub = fromHub, fromCommand = fromCommand, discord = { r, g, b },
			after = { icon = PolestarCopy.Icon:IsShown(), text = PolestarCopy.Box:GetText() } })`);
	const mark = { texture: 'discord', color: out.discord, shown: true };
	assert.deepEqual(out.hub, mark, 'the mark keeps Discord\'s colour, under the cursor too');
	assert.deepEqual(out.settings, mark);
	const invite = { shown: true, text: INVITE, focus: true, icon: 'discord' };
	assert.deepEqual(out.fromHub, invite);
	assert.deepEqual(out.fromCommand, invite);
	assert.deepEqual(out.after, { icon: false, text: 'zone map 1429' }, 'the next text to copy comes without the mark');
});

test('the report names the other addons that are loaded; "Open on GitHub" gives a link that opens a new GitHub bug report with the report, its title, the version and those addons filled in; with a marked spot it is a Wrong step issue', () => {
	const [out] = run(`
		stub.addons[#stub.addons + 1] = { name = "Details", loaded = true }
		stub.addons[#stub.addons + 1] = { name = "TomTom", loaded = true }
		stub.addons[#stub.addons + 1] = { name = "Bagnon", loaded = true }
		stub.addons[#stub.addons + 1] = { name = "Questie", loaded = true }
		stub.addons[#stub.addons + 1] = { name = "NotLoaded", loaded = false }
		stub.addonMeta.Questie = { Version = "9.1.0" }
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText("The vermin were all by the tents.")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		local report = F.Box:GetText()
		F.GitHub:Click()
		local step = { shown = PolestarCopy:IsShown(), url = PolestarCopy.Box:GetText(), focus = stub.focus == PolestarCopy.Box, title = PolestarCopy.Title:GetText() }
		local spot = { "zone map 1429", "goto 51.23,40.50 live" }
		local marked = UI.Report.IssueURL(F.Desc:GetText(), F.details, spot)
		Polestar.Engine.SetGuide(nil)
		emit({ report = report, step = step, marked = marked, markedReport = UI.Report.Text(F.Desc:GetText(), F.details),
			noGuide = UI.Report.IssueURL("Lua error on login\\nthen again", UI.Report.Details(), spot) })`);
	assert.equal(out.report.split('\n')[1], '**Addons:** Questie, TomTom, Bagnon, Details', `under what went wrong, quest and map addons first, then A to Z: ${out.report}`);
	assert.equal(out.step.shown, true);
	assert.equal(out.step.title, 'Open on GitHub');
	assert.equal(out.step.focus, true, 'the link is selected for Ctrl+C');
	const url = new URL(out.step.url);
	assert.equal(url.origin + url.pathname, 'https://github.com/fitzforge/polestar/issues/new');
	const q = Object.fromEntries(url.searchParams);
	assert.deepEqual(Object.keys(q).sort(), ['addons', 'steps', 'template', 'title', 'version'], 'only the Bug report form\'s fields');
	assert.equal(q.template, 'bug-report.yml', 'a step on screen, no spot marked: a bug report');
	assert.equal(q.title, 'Bug: The vermin were all by the tents.');
	const noAddons = (t) => t.split('\n').filter((l) => !l.startsWith('**Addons:** ')).join('\n');
	assert.equal(q.steps, noAddons(out.report), 'the whole report, as the window shows it, the guide and the step in it, but the addons, which have their own field');
	assert.match(q.version, /^(\d+\.\d+\.\d+|dev)/);
	assert.equal(q.addons, 'Questie 9.1.0\nTomTom 0.1.0-test\nBagnon 0.1.0-test\nDetails 0.1.0-test');
	const wrong = Object.fromEntries(new URL(out.marked).searchParams);
	assert.deepEqual(Object.keys(wrong).sort(), ['addons', 'character', 'guide', 'step', 'template', 'title', 'version', 'where', 'wrong']);
	assert.equal(wrong.template, 'wrong-step.yml', 'a spot marked: a Wrong step issue');
	assert.equal(wrong.title, 'Wrong step: Elwynn Forest, step 3');
	assert.equal(wrong.guide, 'Elwynn Forest');
	assert.equal(wrong.step, '3: Kobold Camp');
	assert.match(wrong.character, /^Human Warrior · level 4/);
	assert.equal(wrong.where, 'zone map 1429\ngoto 51.23,40.50 live');
	assert.equal(wrong.wrong, noAddons(out.markedReport), 'the report without its Right spot and Addons lines');
	const bug = Object.fromEntries(new URL(out.noGuide).searchParams);
	assert.equal(bug.template, 'bug-report.yml', 'no step on screen: a bug report, spot or not');
	assert.equal(bug.title, 'Bug: Lua error on login', 'the first line of what the player typed');
	assert.match(bug.steps, /^\*\*What went wrong:\*\* Lua error on login\nthen again\n\*\*Right spot:\*\* zone map 1429 · goto 51\.23,40\.50 live\n```\n/, 'with no field for it, the spot stays in the report');
	assert.equal(bug.where, undefined);
});

test('with more addons than the link holds, the issue counts them all and lists the ones that fit, quest, map and guide addons first; the link stays short of GitHub\'s limit', () => {
	const [out] = run(`
		for i = 1, 400 do stub.addons[#stub.addons + 1] = { name = ("Addon%03d"):format(i), loaded = true } end
		stub.addons[#stub.addons + 1] = { name = "Questie", loaded = true }
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		emit({ url = UI.Report.IssueURL("The vermin were all by the tents.", PolestarReport.details), max = UI.Report.LINK_MAX })`);
	assert.ok(out.url.length <= out.max, `${out.url.length} characters`);
	const lines = new URL(out.url).searchParams.get('addons').split('\n');
	assert.equal(lines[0], 'The player has 401 other addons on. The ones that fit in the link, quest, map and guide addons first:');
	assert.equal(lines[1], 'Questie 0.1.0-test');
	assert.equal(lines[2], 'Addon001 0.1.0-test');
	assert.ok(lines.length > 50 && lines.length < 402, `${lines.length - 1} of 401 listed`);
});

test('"Mark the right spot" steps the window aside while the player walks; "Mark here" brings it back with the spot in the report and in the issue\'s right spot field, the rest of the report as it was', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText("The vermin were all by the tents.")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		local before = F.Box:GetText()
		F.Mark:Click()
		local walking = { report = F:IsShown(), bar = PolestarMark:IsShown() }
		Polestar.Compat.GetPlayerMapPosition = function() return nil end
		PolestarMark.Here:Click()
		local nowhere = { bar = PolestarMark:IsShown(), report = F:IsShown() }
		Polestar.Compat.GetPlayerMapPosition = function() return 1429, 51.234, 40.5 end
		PolestarMark.Here:Click()
		local back = { report = F:IsShown(), bar = PolestarMark:IsShown(), note = F.SpotNote:GetText(), button = F.Mark.Label:GetText() }
		local after = F.Box:GetText()
		local url = UI.Report.IssueURL(F.Desc:GetText(), F.details, F.spot)
		F:Hide()
		UI.ShowReport()
		local reopened = F.SpotNote:GetText()
		uistub.setStep(4)
		UI.ShowReport()
		emit({ walking = walking, nowhere = nowhere, back = back, before = before, after = after, url = url, reopened = reopened,
			otherStep = F.SpotNote:GetText(), otherReport = F.Box:GetText() })`);
	assert.deepEqual(out.walking, { report: false, bar: true });
	assert.deepEqual(out.nowhere, { bar: true, report: false }, 'no position: the bar stays for another try');
	assert.deepEqual(out.back, { report: true, bar: false, note: 'Right spot marked: zone map 1429 · goto 51.23,40.50 live', button: 'Mark again' });
	const added = out.after.split('\n').filter((l) => !out.before.split('\n').includes(l));
	assert.deepEqual(added, ['**Right spot:** zone map 1429 · goto 51.23,40.50 live'], 'the spot is the one line added: the report taken at the open is kept');
	assert.equal(new URL(out.url).searchParams.get('where'), 'zone map 1429\ngoto 51.23,40.50 live', 'the right spot field holds what /polestar where prints');
	assert.equal(new URL(out.url).searchParams.get('wrong'), out.before, 'the issue gives the spot once, in its own field');
	assert.equal(out.reopened, out.back.note, 'the spot stays while it is the same step');
	assert.match(out.otherStep, /^Optional:/, 'another step starts unmarked');
	assert.doesNotMatch(out.otherReport, /Right spot/);
});

test('the issue link holds the report taken when the window opened: the step on screen then, not where the guide is when Open on GitHub is pressed', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText("The vermin were all by the tents.")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		F.Mark:Click()
		uistub.setStep(4)
		Polestar.Compat.GetPlayerMapPosition = function() return 1429, 51.234, 40.5 end
		PolestarMark.Here:Click()
		F.GitHub:Click()
		local moved = PolestarCopy.Box:GetText()
		uistub.complete()
		F.GitHub:Click()
		emit({ moved = moved, done = PolestarCopy.Box:GetText(), report = F.Box:GetText() })`);
	for (const url of [out.moved, out.done]) {
		const q = Object.fromEntries(new URL(url).searchParams);
		assert.equal(q.template, 'wrong-step.yml', 'a step was on screen when the window opened');
		assert.equal(q.title, 'Wrong step: Elwynn Forest, step 3');
		assert.equal(q.step, '3: Kobold Camp');
		assert.match(q.wrong, /^Step 3 of 8: Kobold Camp$/m);
		assert.match(q.character, /^Human Warrior/);
	}
	assert.match(out.report, /^Step 3 of 8: Kobold Camp$/m);
});

test('the issue link stays under GitHub\'s limit in every script: goals past the arrow\'s are left out first, then the report is cut, its code block kept closed', () => {
	for (const [locale, word, letter] of SCRIPTS) {
		const out = longest(locale, word, letter);
		assert.ok(out.url.length <= out.max, `${locale}: ${out.url.length} characters`);
		const q = Object.fromEntries(new URL(out.url).searchParams);
		assert.equal(q.template, 'wrong-step.yml', locale);
		assert.ok(q.wrong.endsWith('\n```'), `${locale}: the code block is closed`);
		assert.ok(q.wrong.startsWith(`**`), locale);
		assert.ok(!q.wrong.includes('\ufffd'), `${locale}: no character cut in half`);
		for (const k of ['title', 'guide', 'step', 'character']) {
			assert.ok(Buffer.byteLength(q[k]) <= 120, `${locale}: ${k} is bounded (${Buffer.byteLength(q[k])} bytes)`);
		}
		assert.ok(q.addons, `${locale}: the addons field gets what is left`);
		if (locale !== 'enUS') assert.match(q.wrong, /^\.\.\. \d+ goals left out to fit the link$/m, locale);
		assert.match(q.wrong, /^\[>\] /m, `${locale}: the arrow's goal is kept`);
	}
});

test('a link too short for the report even without its goals cuts the report, its code block kept closed, no character cut in half', () => {
	for (const [locale, word, letter] of SCRIPTS) {
		const out = longest(locale, word, letter, { linkMax: 2000 });
		assert.ok(out.url.length <= 2000, `${locale}: ${out.url.length} characters`);
		const wrong = new URL(out.url).searchParams.get('wrong');
		assert.ok(wrong.endsWith('...\n```'), `${locale}: cut, then the code block closed: ${wrong.slice(-40)}`);
		assert.ok(!wrong.includes('\ufffd'), `${locale}: no character cut in half`);
		assert.doesNotMatch(wrong, /Polestar\/UI\/Long/, `${locale}: the report's last lines went`);
	}
});

test('a bug report with nothing typed is titled as its report reads: "Bug: (not described)"', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		emit({ url = UI.Report.IssueURL("  \\n  ", PolestarReport.details) })`);
	assert.equal(new URL(out.url).searchParams.get('title'), 'Bug: (not described)');
});

test('the bug button while the player walks to mark the right spot brings back the report they started: their words, the step and the snapshot, not a new report on the step the guide moved to', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText("The vermin were all by the tents.")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		local before = F.Box:GetText()
		F.Mark:Click()
		uistub.setStep(4)
		GF.parts.nav.Report:Click()
		emit({ desc = F.Desc:GetText(), bar = PolestarMark:IsShown(), shown = F:IsShown(), context = F.Context:GetText(), same = F.Box:GetText() == before })`);
	assert.deepEqual(out, { desc: 'The vermin were all by the tents.', bar: false, shown: true, context: 'Step 3 of 8  \u00b7  Kobold Camp  \u00b7  Elwynn Forest', same: true });
});

test('the issue body leaves out the Addons line: the addons have their own field', () => {
	const [out] = run(`
		stub.addons[#stub.addons + 1] = { name = "Questie", loaded = true }
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		emit({ url = UI.Report.IssueURL("x", PolestarReport.details), report = UI.Report.Text("x", PolestarReport.details) })`);
	const q = new URL(out.url).searchParams;
	assert.match(out.report, /^\*\*Addons:\*\* Questie$/m, 'the Discord report keeps it');
	assert.doesNotMatch(q.get('steps'), /Addons:/);
	assert.match(q.get('addons'), /^Questie /);
});

test('with no other addons the report has no Addons line', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		emit({ report = UI.Report.Text("x", PolestarReport.details) })`);
	assert.doesNotMatch(out.report, /Addons/);
	assert.equal(out.report.split('\n')[1], '```');
});

// The report as a player pastes it in #bugs, from the window in `locale`:
// typed words, two other addons, one caught error and a marked spot.
function pasted(locale) {
	return run(`
		stub.addons[#stub.addons + 1] = { name = "TomTom", loaded = true }
		stub.addons[#stub.addons + 1] = { name = "Questie", loaded = true }
		Polestar.NoteError("Interface/AddOns/Polestar/Nav/Arrow.lua:40: bad argument")
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText("The vermin were all by the tents.")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		F.Mark:Click()
		Polestar.Compat.GetPlayerMapPosition = function() return 1429, 51.234, 40.5 end
		PolestarMark.Here:Click()
		F.Copy:Click()
		emit({ text = F.Box:GetText() })`, `function GetLocale() return "${locale}" end`)[0].text;
}

test('the Discord bot reads the report the window gives: the details from the code block as before, the player\'s words with the right spot and the addons above them, which the issue quotes outside the folded full report', () => {
	const { parseReport } = require('../tools/discord-bot/lib/report');
	const { issueBody } = require('../tools/discord-bot/lib/issue');
	const text = pasted('enUS');
	const r = parseReport(text);
	assert.equal(r.description, 'The vermin were all by the tents.\n**Right spot:** zone map 1429 · goto 51.23,40.50 live\n**Addons:** Questie, TomTom');
	const d = r.details;
	assert.match(d.version, /^(\d+\.\d+\.\d+|dev)/);
	assert.equal(d.locale, 'enUS');
	assert.equal(d.client, '1.60.1');
	assert.match(d.character, /^Human Warrior · level 4/);
	assert.equal(d.guideId, 'forever/alliance/human/01-elwynn-forest');
	assert.equal(d.step, 3);
	assert.equal(d.stepCount, 8);
	assert.match(d.arrow, /^Arrow: .* · 42 yd$/);
	assert.match(d.where, /^Where: Elwynn Forest/);
	assert.deepEqual(d.errors, [{ count: 1, message: 'Polestar/Nav/Arrow.lua:40: bad argument' }]);
	assert.equal(r.block, block(text).join('\n'), 'the block is the details alone');
	const body = issueBody({ report: r, reporter: 'Tom', guild: '1', thread: '2' });
	const [open, folded] = body.split('<details><summary>Full report</summary>');
	assert.match(open, /^> The vermin were all by the tents\.\n> \*\*Right spot:\*\* zone map 1429 · goto 51\.23,40\.50 live\n> \*\*Addons:\*\* Questie, TomTom$/m);
	assert.match(open, /\| Guide \| Elwynn Forest · forever\/alliance\/human\/01-elwynn-forest \|/);
	assert.doesNotMatch(folded, /Right spot|Addons/);
	const ru = parseReport(pasted('ruRU'));
	assert.equal(ru.details.locale, 'ruRU');
	assert.equal(ru.details.guideId, 'forever/alliance/human/01-elwynn-forest');
	assert.equal(ru.details.step, 3);
	assert.equal(ru.details.errors.length, 1);
	assert.match(ru.description, /^The vermin were all by the tents\.\n\*\*[^*\n]+\*\* zone map 1429 · goto 51\.23,40\.50 live\n\*\*[^*\n]+\*\* Questie, TomTom$/);
	// zhCN's labels end in full-width colons and brackets, which the bot's
	// patterns do not match (its guide and step, its lead-in): only the block
	// and the lines above it are checked here.
	const zh = parseReport(pasted('zhCN'));
	assert.equal(zh.details.locale, 'zhCN');
	assert.equal(zh.details.errors.length, 1);
	assert.match(zh.description, /The vermin were all by the tents\.\n\*\*[^*\n]+\*\* zone map 1429 · goto 51\.23,40\.50 live\n\*\*[^*\n]+\*\* Questie, TomTom$/);
});

test('the Discord steps say to press Ctrl+C after Copy report: the button selects the report, the game copies nothing itself', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		emit({ note = PolestarReport.DiscordNote:GetText() })`);
	assert.match(out.note, /^1\. Press Copy report, then Ctrl\+C \(Cmd\+C on a Mac\)\./);
});

test('Copy report and Open on GitHub wait until the player says what went wrong in 5 letters or more, and say so', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		local function state()
			return { copy = F.Copy:IsEnabled(), github = F.GitHub:IsEnabled(), tip = F.Copy.psTip or false }
		end
		local empty = state()
		F.Copy:Click()
		local boxAfterClick = F.Box:IsShown()
		F.Desc:SetText("  bad ")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		local short = state()
		F.Desc:SetText("wrong")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		local enough = state()
		F.Copy:Click()
		local shown = F.Box:IsShown()
		F.Desc:SetText("")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		emit({ empty = empty, boxAfterClick = boxAfterClick, short = short, enough = enough, shown = shown, cleared = { state = state(), box = F.Box:IsShown() } })`);
	const waiting = { copy: false, github: false, tip: 'Say what went wrong first.' };
	assert.deepEqual(out.empty, waiting);
	assert.equal(out.boxAfterClick, false, 'a click while it waits shows nothing');
	assert.deepEqual(out.short, waiting, 'three letters and spaces are not enough');
	assert.deepEqual(out.enough, { copy: true, github: true, tip: false });
	assert.equal(out.shown, true);
	assert.deepEqual(out.cleared, { state: waiting, box: false }, 'emptied again: the report goes away until there is something to send');
});

test('Clear mark, beside Mark again, takes the right spot back out of the report', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText("The vermin were all by the tents.")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		local before = { clear = F.Clear:IsShown(), report = F.Box:GetText() }
		Polestar.Compat.GetPlayerMapPosition = function() return 1429, 51.234, 40.5 end
		F.Mark:Click()
		PolestarMark.Here:Click()
		local marked = { clear = F.Clear:IsShown(), spot = F.Box:GetText():find("51.23,40.50", 1, true) ~= nil }
		F.Clear:Click()
		emit({ before = before, marked = marked, after = { clear = F.Clear:IsShown(), button = F.Mark.Label:GetText(), report = F.Box:GetText(),
			template = UI.Report.IssueURL(F.Desc:GetText(), F.details, F.spot):match("template=([%w%-%.]+)") } })`);
	assert.equal(out.before.clear, false, 'nothing marked, nothing to clear');
	assert.deepEqual(out.marked, { clear: true, spot: true });
	assert.deepEqual(out.after, { clear: false, button: 'Mark the right spot', report: out.before.report, template: 'bug-report.yml' });
});

test('the 5 letters are letters: spaces a Chinese or Japanese input method types do not count, and an emoji is one', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		local res = {}
		for _, t in ipairs({ string.rep("\\227\\128\\128", 5), string.rep("\\194\\160", 5), "\\227\\128\\128a\\227\\128\\128b\\227\\128\\128",
				string.rep("\\240\\159\\152\\128", 3), string.rep("\\240\\159\\152\\128", 5), "\\230\\151\\165\\230\\156\\172\\232\\170\\158\\227\\131\\134\\227\\130\\185" }) do
			F.Desc:SetText(t)
			stub.RunScript(F.Desc, "OnTextChanged", true)
			res[#res + 1] = F.Copy:IsEnabled()
		end
		emit({ res = res })`);
	assert.deepEqual(out.res, [false, false, false, false, true, true], 'ideographic spaces, no-break spaces, two letters padded with them, three emoji: no; five emoji, five Japanese letters: yes');
});
