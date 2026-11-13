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
const INVITE = 'https://discord.gg/polestar';

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
	// As the player counts the steps, with the guide's own index for maintainers (#942).
	assert.ok(lines.includes('Step 3 of 8 (guide step 3): Kobold Camp'), out.text);
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
// script under `locale`, the description at its most letters (or
// `opts.descLen`), 40 addons and a marked right spot. Returns the report for
// Discord and the issue link.
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
		stub.addonMeta["Polestar_" .. string.rep("Long", 10)] = { Author = "Polestar" }
		for i = 1, 4 do stub.fire("ADDON_ACTION_BLOCKED", "Polestar_" .. string.rep("Long", 10), string.rep("Protected", 8) .. i .. "()") end
		uistub.setGuide(id, 1)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText(string.rep(letter, ${opts.descLen || 'UI.Report.DESC_MAX'}))
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

test('at its longest, a 1,000-letter description, a marked spot and 40 addons, the report still fits one Discord message in every script: the description is kept whole, details go, never a line the Discord bot reads', () => {
	const { parseReport } = require('../tools/discord-bot/lib/report');
	for (const [locale, word, letter] of SCRIPTS) {
		const { text, details } = longest(locale, word, letter);
		const lines = text.split('\n');
		// Discord counts characters, as JavaScript does: one each, two past U+FFFF.
		assert.ok(text.length <= 2000, `${locale}: ${text.length} characters, ${Buffer.byteLength(text, 'utf8')} bytes`);
		assert.ok(lines[0].endsWith(' ' + letter.repeat(1000)), `${locale}: the description is kept whole`);
		// The label is the locale's (ruRU translates it); the spot after it is kept whole.
		assert.match(lines[1], /^\*\*[^*]+\*\* zone map 1429 · goto 51\.23,40\.50 live$/, `${locale}: the right spot is kept`);
		assert.ok(!lines[2].startsWith('**'), `${locale}: the Addons line went first`);
		const kept = block(text);
		assert.match(kept[kept.length - 1], /^[(（].+[)）]$/, `${locale}: the block's last line says it was trimmed`);
		for (const i of [0, 1, 2, 3]) assert.equal(kept[i], details[i], `${locale}: versions, character, guide and step lines kept`);
		assert.ok(kept.some((l) => l.startsWith('[>] ')), `${locale}: the current goal is kept`);
		const r = parseReport(text);
		assert.ok(kept.includes(r.details.arrow) && r.details.arrow === details[details.indexOf(r.details.where) - 1], `${locale}: Arrow and Where kept, in their places`);
		assert.equal(r.description.split('\n')[0], letter.repeat(1000), `${locale}: the bot reads the description whole`);
		assert.equal(r.details.guideId, 'test/a-long-guide', locale);
		assert.equal(r.details.step, 1, locale);
		assert.equal(r.details.map, 1429, `${locale}: the bot still finds Where`);
	}
	const english = longest(...SCRIPTS[0]).text;
	assert.equal(lineWith(english, 'Arrow:'), longest(...SCRIPTS[0]).details.find((l) => l.startsWith('Arrow:')));
	assert.match(english, /^Errors:$/m, 'the Errors header stays');
	assert.match(english, /^\(trimmed to fit Discord\)\n```$/m);
});

test('with a short description the long report only gives up its log and shortens its Addons line, then says it was trimmed', () => {
	for (const [locale, word, letter] of SCRIPTS) {
		const { text, details } = longest(locale, word, letter, { descLen: 250 });
		assert.ok(text.length <= 2000, `${locale}: ${text.length} characters`);
		assert.ok(text.split('\n')[0].endsWith(letter.repeat(250)), `${locale}: the description is kept whole`);
		// The log's lines went, which the details do not hold.
		assert.deepEqual(block(text), [...details, '(trimmed to fit Discord)'], `${locale}: every detail line, as taken, and the note`);
	}
	const english = longest(...SCRIPTS[0], { descLen: 250 });
	assert.equal(english.text.length, 2000, 'English is the one that runs over');
	const addons = english.text.split('\n')[2];
	assert.match(addons, /^\*\*Addons:\*\* QuestAndMapHelperWithALongName.*\.\.\.$/, `the Addons line gives way: ${addons}`);
	const unmarked = longest(...SCRIPTS[0], { unmarked: true, descLen: 250 }).text;
	const unmarkedAddons = unmarked.split('\n')[1];
	assert.ok(unmarked.length <= 2000, `the unmarked report fits too: ${unmarked.length}`);
	assert.ok(unmarkedAddons.split(', ').length > english.text.split('\n')[2].split(', ').length, `without the Right spot line the Addons line takes the room it frees, not a fixed 100 bytes: ${unmarkedAddons}`);
	assert.match(english.text, /^\.\.\. 3 more goals$/m, 'goals past the sixth are counted, not listed');
	assert.equal((english.text.match(/^ {2}1x /gm) || []).length, 3, 'the newest three of the errors and blocked calls together');
	assert.equal((english.text.match(/^ {2}1x blocked in Polestar_Long/gm) || []).length, 3, 'the blocked calls came last');
});

// A report's details by kind, made by hand, for R.Text to trim with
// `textMax` characters of room; the long lines are padded to 90.
function trimmedAt(textMax, opts = {}) {
	return run(`
		local R = UI.Report
		R.TEXT_MAX = ${textMax}
		local function line(s) return s .. string.rep(".", 90 - #s) end
		local d = { lines = {}, kinds = {}, names = { "Questie", "TomTom" }, tail = { "log one", "log two" } }
		local function add(kind, s) d.lines[#d.lines + 1] = s; d.kinds[#d.lines] = kind end
		add("versions", "Polestar 0.3.7 · client 1.60.1 (70532) · enUS")
		add("character", "Human Warrior · level 4 · Alliance")
		add("guide", "Guide: Elwynn Forest (forever/alliance/human/01-elwynn-forest)")
		add("step", "Step 3 of 8 (guide step 3): Kobold Camp")
		d.goals = { first = #d.lines + 1, current = #d.lines + 3, more = 2 }
		for g = 1, 7 do add("goal", line((g == 3 and "[>]" or "[ ]") .. " goal " .. g)) end
		d.goals.last = #d.lines
		add("more", "... 2 more goals")
		add("arrow", "Arrow: goal 3 · 42 yd")
		add("where", "Where: Elwynn Forest · map 1429 @47.60,35.10 live")
		add("routes", "Routes: balanced")
		add("whilehere", line("While here: none"))
		add("packs", line("Packs: pack"))
		add("errors", "Errors:")
		for e = 1, 3 do add("error", line("  1x error " .. e)) end
		add("questlog", line("Quest log 2/40: 783 1/2"))
		add("settings", line("Settings: qol.stepInteract=true"))
		emit({ text = R.Text(${JSON.stringify(opts.desc || 'The vermin were all by the tents.')}, d), lines = d.lines })`)[0];
}

test('a report over one Discord message gives up, in order: the log, the Addons line, Settings, Packs, goals past the current one and the next two, the quest log, then the older errors; never the description, the guide and step, the current goal, Arrow, Where or the Errors header', () => {
	const order = [/^> log/, /^\*\*Addons:/, /^Settings:/, /^Packs:/, /^\[ \] goal 7/, /^\[ \] goal 6/, /^\[ \] goal 1/, /^\[ \] goal 2/, /^Quest log/, /^ {2}1x error 1/, /^ {2}1x error 2/];
	const never = [/^Polestar 0\.3\.7/, /^Human Warrior/, /^Guide: /, /^Step 3 of 8/, /^\[>\] goal 3/, /^\[ \] goal 4/, /^\[ \] goal 5/, /^Arrow: /, /^Where: /, /^Errors:$/];
	const untrimmed = trimmedAt(4000);
	assert.doesNotMatch(untrimmed.text, /trimmed/, 'room for all: nothing goes, no note');
	for (const re of [...order, ...never]) assert.match(untrimmed.text, new RegExp(re.source, 'm'));
	let gone = 0;
	let counted;
	for (let max = untrimmed.text.length - 1; max >= 800; max -= 30) {
		const { text } = trimmedAt(max);
		assert.ok(text.length <= max, `${text.length} > ${max}`);
		assert.ok(text.startsWith('**What went wrong:** The vermin were all by the tents.\n'), 'the description first, whole');
		const missing = order.map((re) => !new RegExp(re.source, 'm').test(text));
		const n = missing.indexOf(false) === -1 ? order.length : missing.indexOf(false);
		assert.deepEqual(missing.slice(n), missing.slice(n).map(() => false), `in order, at ${max}: ${missing}`);
		assert.ok(n >= gone, `nothing comes back as room shrinks, at ${max}`);
		gone = n;
		for (const re of never) assert.match(text, new RegExp(re.source, 'm'), `${re} kept at ${max}`);
		assert.match(text, /\n\(trimmed to fit Discord\)\n```$/, `the note closes the block at ${max}`);
		if (missing.slice(4, 8).some(Boolean)) assert.match(text, /^\.\.\. \d+ more goals$/m, 'goals left out are counted');
		if (!counted && missing[7] && !missing[8]) counted = text;
	}
	assert.equal(gone, order.length, 'the smallest room took every line the order names');
	assert.ok(counted, 'a room where every goal the order names went and the quest log stayed');
	const goals = counted.split('\n').filter((l) => /^\[/.test(l) || /^\.\.\. /.test(l));
	assert.deepEqual(goals.map((l) => l.slice(0, 12)), ['[>] goal 3..', '[ ] goal 4..', '[ ] goal 5..', '... 6 more g'], `the four goals left out, with the two never listed: ${counted}`);
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
		stub.addonMeta.Polestar_Gamepad = { Author = "Polestar" }
		stub.addonMeta.Polestar_Mob_Markers = { Author = "Someone else" }
		Polestar.NoteError("Interface/AddOns/Polestar/UI/GuideFrame.lua:1: oldest")
		stub.fire("ADDON_ACTION_BLOCKED", "Polestar", "UseAction()")
		stub.advance(5)
		stub.fire("ADDON_ACTION_FORBIDDEN", "OtherAddon", "CastSpellByName()")
		stub.fire("ADDON_ACTION_FORBIDDEN", "Polestar_Gamepad", "ClearOverrideBindings()")
		stub.fire("ADDON_ACTION_BLOCKED", "Polestar_Mob_Markers", "UNKNOWN()")
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
	], 'another author\'s Polestar_Mob_Markers (#1123) is not ours');
});

// Fyurie (#1113, #1116, #1118) and soockee (#1051) had "blocked in Polestar: UNKNOWN()": the game names a
// namespaced function (C_Item.IsItemInRange) or an anonymous frame's only so. The event fires inside the blocked
// call, so the stack names the line of ours under it: the report says where.
test('a blocked call says which line of ours made it, so "UNKNOWN()" can be traced', () => {
	const [out] = run(`
		local stacks = {
			'[string "@Interface/AddOns/Polestar/Core/Init.lua"]:587: in function <Interface/AddOns/Polestar/Core/Init.lua:587>\\n' ..
			'[C]: in function \\'IsItemInRange\\'\\n' ..
			'[string "@Interface/AddOns/Polestar/QoL/QoL.lua"]:394: in function \\'ItemInRange\\'\\n' ..
			'[string "@Interface/AddOns/Polestar/QoL/Buttons.lua"]:420: in function <...>\\n',
			'Interface\\\\AddOns\\\\Polestar\\\\Core\\\\Init.lua:587: in function <Init.lua:587>\\n' ..
			'Interface\\\\AddOns\\\\Polestar_Nav\\\\Router.lua:12: in function \\'Go\\'\\n',
		}
		local n = 0
		debugstack = function() return stacks[n] end
		n = 1
		stub.fire("ADDON_ACTION_BLOCKED", "Polestar", "UNKNOWN()")
		stub.fire("ADDON_ACTION_BLOCKED", "Polestar", "UNKNOWN()")
		n = 2
		stub.fire("ADDON_ACTION_BLOCKED", "Polestar", "UNKNOWN()")
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		emit({ text = PolestarReport.Box:GetText(), at = date("%H:%M:%S") })`);
	assert.deepEqual(out.text.split('\n').filter((l) => l.startsWith('  ')), [
		`  2x blocked in Polestar: UNKNOWN() Polestar/QoL/QoL.lua:394 (${out.at})`,
		`  1x blocked in Polestar: UNKNOWN() Polestar_Nav/Router.lua:12 (${out.at})`,
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

test('an everyday report names every other addon: the Addons line is only shortened when the whole report would not fit one Discord message (#527)', () => {
	const names = ['EllesmereUIMinimap', 'EllesmereUIQuestTracker', 'ForeverQuestTint', 'GearQuestForever', 'GearQuestForeverOptions', 'Leatrix_Maps',
		'QuestieDB', 'TomTom', 'AtlasBIStooltips', 'Baganator', 'Details', 'BugSack', 'Auctionator', 'WeakAuras', 'Plater', 'OmniCC', 'Bartender4', 'Prat-3.0'];
	const [out] = run(`
		for _, name in ipairs(${JSON.stringify(names).replace('[', '{').replace(/]$/, '}')}) do
			stub.addons[#stub.addons + 1] = { name = name, loaded = true }
		end
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText("If you use yellow accent colour, text is sometimes very hard to read.")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		emit({ report = F.Box:GetText() })`);
	const line = out.report.split('\n')[1];
	assert.ok(out.report.length < 2000);
	for (const name of names) assert.ok(line.includes(name), `${name} is on the Addons line: ${line}`);
	assert.ok(!line.endsWith('...'), `nothing is cut: ${line}`);
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
		assert.match(q.wrong, /^Step 3 of 8 \(guide step 3\): Kobold Camp$/m);
		assert.match(q.character, /^Human Warrior/);
	}
	assert.match(out.report, /^Step 3 of 8 \(guide step 3\): Kobold Camp$/m);
});

test('the issue link stays under GitHub\'s limit in every script: details go as in the Discord report, the description is kept whole, the code block closed', () => {
	for (const [locale, word, letter] of SCRIPTS) {
		for (const descLen of [250, 1000]) {
			const at = `${locale}, ${descLen} letters`;
			const out = longest(locale, word, letter, { descLen });
			assert.ok(out.url.length <= out.max, `${at}: ${out.url.length} characters`);
			const q = Object.fromEntries(new URL(out.url).searchParams);
			assert.equal(q.template, 'wrong-step.yml', at);
			assert.ok(q.wrong.endsWith('\n```'), `${at}: the code block is closed`);
			assert.ok(q.wrong.startsWith(`**`), at);
			assert.ok(!q.wrong.includes('\ufffd'), `${at}: no character cut in half`);
			for (const k of ['title', 'guide', 'step', 'character']) {
				assert.ok(Buffer.byteLength(q[k]) <= 120, `${at}: ${k} is bounded (${Buffer.byteLength(q[k])} bytes)`);
			}
			// A 1,000-letter description in Cyrillic or Chinese encodes to 6000 or
			// 9000 characters, more than GitHub takes in a link: only there is
			// the description itself cut.
			if (locale === 'enUS' || descLen === 250) {
				assert.ok(q.wrong.split('\n')[0].endsWith(' ' + letter.repeat(descLen)), `${at}: the description is kept whole`);
				assert.match(q.wrong, /^\[>\] /m, `${at}: the current goal is kept`);
				assert.ok(q.addons, `${at}: the addons field gets what is left`);
			}
			if (locale !== 'enUS' && descLen === 250) assert.match(q.wrong, /^\(trimmed to fit the link\)$/m, at);
		}
	}
});

test('Open on GitHub carries a 1,000-character description of several lines whole: the title is its first line, cut at 80', () => {
	const desc = ('The arrow points into the lake at Goldshire and never moves on.\n\n' + 'I walked round the lake twice, reloaded, and the step stayed. '.repeat(16)).slice(0, 990).trimEnd().padEnd(1000, '!');
	const [out] = run(`
		local desc = ${JSON.stringify(desc)}
		for i = 1, 40 do stub.addons[#stub.addons + 1] = { name = ("QuestAndMapHelperWithALongName%02d"):format(i), loaded = true } end
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText(desc)
		stub.RunScript(F.Desc, "OnTextChanged", true)
		emit({ desc = F.Desc:GetText(), url = UI.Report.IssueURL(F.Desc:GetText(), F.details), report = UI.Report.Text(F.Desc:GetText(), F.details), max = UI.Report.LINK_MAX })`);
	assert.equal(out.desc.length, 1000);
	assert.ok(out.url.length <= out.max, `${out.url.length} characters`);
	const q = new URL(out.url).searchParams;
	assert.equal(q.get('title'), 'Bug: The arrow points into the lake at Goldshire and never moves on.');
	assert.ok(q.get('steps').startsWith(`**What went wrong:** ${out.desc}\n\`\`\`\n`), 'the description whole, above the details');
	assert.match(q.get('steps'), /^Step 3 of 8 \(guide step 3\): Kobold Camp$/m);
	assert.ok(out.report.length <= 2000, `${out.report.length}`);
	assert.ok(out.report.startsWith(`**What went wrong:** ${out.desc}\n`), 'the Discord report keeps it whole too');
	const { parseReport } = require('../tools/discord-bot/lib/report');
	const r = parseReport(out.report);
	assert.ok(r.description.startsWith(out.desc.trim()), 'the bot reads all of it, its lines kept');
	assert.equal(r.details.guideId, 'forever/alliance/human/01-elwynn-forest');
	const long = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		emit({ url = UI.Report.IssueURL(string.rep("w", 120) .. "\\nmore", PolestarReport.details) })`)[0];
	assert.equal(new URL(long.url).searchParams.get('title'), `Bug: ${'w'.repeat(77)}...`);
});

test('the description box takes 1,000 letters: it grows with the text from three lines to seven, then scrolls, the window staying on a 720-unit screen', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		local function state()
			return { well = F.DescWell:GetHeight(), box = F.Desc:GetHeight(), content = F.DescScroll.psContent, window = F:GetHeight() }
		end
		local empty = state()
		F.Desc:SetText("One line.\\nTwo lines.\\nThree.\\nFour.\\nFive.")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		local five = state()
		F.Desc:SetText(string.rep("The vermin were all by the tents. ", 30):sub(1, UI.Report.DESC_MAX))
		stub.RunScript(F.Desc, "OnTextChanged", true)
		local full = state()
		emit({ max = UI.Report.DESC_MAX, empty = empty, five = five, full = full, letters = #F.Desc:GetText() })`);
	assert.equal(out.max, 1000);
	assert.equal(out.letters, 1000);
	assert.equal(out.empty.well, 3 * 16 + 16, 'three lines to start');
	assert.ok(out.five.well > out.empty.well && out.five.well < 7 * 16 + 16, `it grows with the lines typed (${out.five.well})`);
	assert.equal(out.full.well, 7 * 16 + 16, 'no taller than seven lines');
	assert.ok(out.full.box > out.full.well && out.full.content === out.full.box, `the text runs on in the scroll (${out.full.box} in ${out.full.well})`);
	assert.ok(out.full.window <= 720, `the window fits a 720-unit screen (${out.full.window})`);
});

test('report scrolling survives repeated cursor notifications, while real cursor movement follows the edited line (#1905)', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText(string.rep("A line of the report.\\n", 30))
		stub.RunScript(F.Desc, "OnTextChanged", true)
		local sf, e = F.DescScroll, F.Desc
		local y = -(sf.psContent - 16)
		local function cursor(x, cy) stub.RunScript(e, "OnCursorChanged", x, cy, 1, 16) end
		cursor(10, y)
		local bottom = sf:GetVerticalScroll()
		stub.RunScript(sf, "OnMouseWheel", 1)
		local wheeled = sf:GetVerticalScroll()
		for i = 1, 3 do cursor(10, y) end
		local repeated = sf:GetVerticalScroll()
		cursor(20, y)
		local horizontal = sf:GetVerticalScroll()
		stub.RunScript(sf, "OnMouseWheel", 1)
		e:SetText((e:GetText():gsub("A line", "B line")))
		stub.RunScript(e, "OnTextChanged", true)
		cursor(20, y)
		local edited = sf:GetVerticalScroll()
		stub.cursor = { 100, 500 }
		stub.RunScript(sf.Bar, "OnMouseDown", "LeftButton")
		stub.cursor = { 100, 1000 }
		stub.RunScript(sf.Bar, "OnUpdate", 0.1)
		stub.RunScript(sf.Bar, "OnMouseUp", "LeftButton")
		local dragged = sf:GetVerticalScroll()
		for i = 1, 3 do cursor(20, y) end
		local repeatedDrag = sf:GetVerticalScroll()
		cursor(20, y + 16)
		local vertical = sf:GetVerticalScroll()
		cursor(20, 0)
		emit({ bottom = bottom, wheeled = wheeled, repeated = repeated, horizontal = horizontal, edited = edited,
			dragged = dragged, repeatedDrag = repeatedDrag, vertical = vertical, firstLine = sf:GetVerticalScroll() })`);
	assert.ok(out.bottom > 60, 'the description needs scrolling');
	assert.equal(out.wheeled, out.bottom - 60, 'the wheel moves up');
	assert.equal(out.repeated, out.wheeled, 'unchanged cursor notifications keep the wheel position');
	assert.equal(out.horizontal, out.bottom, 'moving along the edited line brings it back into view');
	assert.equal(out.edited, out.bottom, 'new text follows the cursor even at unchanged coordinates');
	assert.equal(out.dragged, 0, 'the thumb can reach the first lines');
	assert.equal(out.repeatedDrag, 0, 'unchanged cursor notifications keep the dragged position');
	assert.ok(out.vertical > 0 && out.vertical < out.bottom, 'moving to the preceding line follows that line');
	assert.equal(out.firstLine, 0, 'moving the cursor to the first line scrolls back to the top');
});

test('the foreground report description forwards mouse-wheel scrolling to its viewport (#1905)', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText(string.rep("A line of the report.\\n", 30))
		stub.RunScript(F.Desc, "OnTextChanged", true)
		Polestar.Widgets.ScrollTo(F.DescScroll, F.DescScroll.psContent)
		local bottom = F.DescScroll:GetVerticalScroll()
		stub.RunScript(F.Desc, "OnMouseWheel", 1)
		emit({ enabled = rawget(F.Desc, "mouseWheel") or false, bottom = bottom, after = F.DescScroll:GetVerticalScroll() })`);
	assert.equal(out.enabled, true);
	assert.equal(out.after, out.bottom - 60);
});

test('the report description pads its viewport instead of its multiline text, keeping the outer window size (#1905)', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		stub.RunScript(F.Desc, "OnTextChanged", false)
		local function size()
			return { well = F.DescWell:GetHeight(), view = F.DescScroll.psView, window = F:GetHeight() }
		end
		local empty = size()
		F.Desc:SetText(string.rep("A line of the report.\\n", 30))
		stub.RunScript(F.Desc, "OnTextChanged", true)
		emit({ insets = F.Desc.testInsets, empty = empty, full = size(),
			top = select(5, F.DescScroll:GetPoint(1)), bottom = select(5, F.DescScroll:GetPoint(2)) })`, `
		-- Capture a native setting the stub does not model; caret rendering
		-- itself still needs the game client.
		local create = CreateFrame
		CreateFrame = function(kind, ...)
			local f = create(kind, ...)
			if kind == "EditBox" then
				local setInsets = f.SetTextInsets
				f.SetTextInsets = function(self, ...)
					self.testInsets = { ... }
					return setInsets(self, ...)
				end
			end
			return f
		end`);
	assert.deepEqual(out.insets, [10, 10, 0, 0], 'multiline text has no vertical insets');
	assert.equal(out.top, -8);
	assert.equal(out.bottom, 8);
	assert.equal(out.empty.well, 64, 'the empty well keeps its height');
	assert.equal(out.empty.view, 48);
	assert.equal(out.full.well, 128, 'the full well keeps its height');
	assert.equal(out.full.view, 112);
	assert.ok(out.full.window <= 720, 'the window still fits the screen');
});

// #1753: the report window as doctor-house had it in 0.3.6: 28 other addons,
// an error caught 63 times, a full quest log and changed settings, `desc`
// typed, Copy report pressed, then a theme repaint (what a UI scale or
// display size change runs). `outdated` adds the update line.
function crowded({ desc = 'Guide is throwing lua errors and the report a problem page is broken', addons = 28, errors = 63, outdated = false } = {}) {
	return run(`
		for i = 1, ${addons} do stub.addons[#stub.addons + 1] = { name = ("Details_SomeLongModuleName%02d"):format(i), loaded = true } end
		for i = 1, ${errors} do Polestar.NoteError("Interface/AddOns/Polestar/Core/Engine.lua:2311: attempt to compare nil with number") end
		local log = {}
		for i = 1, 23 do log[i] = 1000 + i * 37 end
		Polestar.Compat.GetLogQuests = function() return log end
		Polestar.Compat.GetQuestObjectives = function() return { { finished = true }, { finished = false } } end
		Polestar.Set("behavior.deathskips", true)
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		${outdated ? 'F.Outdated:SetText("Polestar 9.9.9 is out: update first, it may fix this."); F.Outdated:Show()' : ''}
		F.Desc:SetText(${JSON.stringify(desc)})
		stub.RunScript(F.Desc, "OnTextChanged", true)
		F.Copy:Click()
		stub.advance(0.1)
		-- Selected for Ctrl+C: in focus, all of it, once the frame has passed.
		local function sel() return { focus = stub.focus == F.Box, from = F.Box.highlight and F.Box.highlight[1] or false, to = F.Box.highlight and F.Box.highlight[2] or false } end
		local copied = sel()
		-- Ctrl+A in the box selects all of it again; so does a click in it.
		F.Box:HighlightText(0, 0)
		local ctrl = IsControlKeyDown
		IsControlKeyDown = function() return true end
		stub.RunScript(F.Box, "OnKeyDown", "A")
		IsControlKeyDown = ctrl
		local ctrlA = sel()
		F.Box:HighlightText(0, 0)
		F.Desc:SetFocus()
		stub.RunScript(F.Box, "OnMouseUp", "LeftButton")
		stub.advance(0.1)
		local clicked = sel()
		-- A click on the well around it (its insets, the space under a short
		-- report) does too.
		F.Box:HighlightText(0, 0)
		F.Desc:SetFocus()
		stub.RunScript(F.BoxWell, "OnMouseUp", "LeftButton")
		stub.advance(0.1)
		local wellClicked = sel()
		-- Each box is its view's own scroll child, as the game's scrolling
		-- input boxes are: nested in a child frame, rc1's took no click.
		local scroll = rawget(F, "BoxScroll")
		local children = { report = scroll ~= nil and scroll:GetScrollChild() == F.Box, description = F.DescScroll:GetScrollChild() == F.Desc }
		-- Selected, nothing sets the box's text or cursor again: not a compose
		-- for the description's box, not a theme repaint, not another click on
		-- the well, not the frames after (0.3.7-rc2 in game: the selection
		-- flashed, then the cursor sat at the start).
		Polestar.Widgets.SelectCopy(F.Box)
		stub.advance(0.1)
		local sets = {}
		local setText, setCursor = F.Box.SetText, F.Box.SetCursorPosition
		F.Box.SetText = function(self, t) sets[#sets + 1] = "SetText"; return setText(self, t) end
		F.Box.SetCursorPosition = function(self, p) sets[#sets + 1] = "SetCursorPosition"; return setCursor(self, p) end
		stub.RunScript(F.Desc, "OnTextChanged", false)
		Polestar.Theme.Refresh()
		stub.RunScript(F.BoxWell, "OnMouseUp", "LeftButton")
		stub.advance(0.1)
		local kept = sel()
		kept.sets = table.concat(sets, ",")
		F.Box.SetText, F.Box.SetCursorPosition = setText, setCursor
		-- Every font string drawn in the window, by its text.
		local drawn = {}
		local function walk(f)
			for _, r in ipairs({ f:GetRegions() }) do
				if r:GetObjectType() == "FontString" and r:IsVisible() and (r:GetText() or "") ~= "" then drawn[#drawn + 1] = r:GetText() end
			end
			for _, c in ipairs({ f:GetChildren() }) do walk(c) end
		end
		walk(F)
		-- Each part's top and bottom, down from the window's top.
		local function span(o) local y = select(5, o:GetPoint(1)); return { -y, -y + o:GetHeight() } end
		-- Before #1753 the box had no well of its own: the box stands for it.
		local well = rawget(F, "BoxWell") or F.Box
		emit({ report = F.Box:GetText(), bytes = #F.Box:GetText(), copied = copied, ctrlA = ctrlA, clicked = clicked, wellClicked = wellClicked, children = children, kept = kept, drawn = drawn, window = F:GetHeight(), boxShown = F.Box:IsShown(),
			box = F.Box:GetHeight(), view = well:GetHeight(), content = scroll and scroll.psContent or F.Box:GetHeight(),
			copy = span(F.Copy), well = span(well), rule = span(F.GitHubRule), github = span(F.GitHub),
			desc = span(F.DescWell), mark = span(F.Mark) })`)[0];
}

test('a long report with many addons and an error caught 63 times stays in its box: the box scrolls under Copy report, selected whole for Ctrl+C, nothing draws over the form, the window fits a 720-unit screen (#1753)', () => {
	const cases = [
		['short, one addon', { addons: 1, errors: 1 }],
		['the reporter\'s', {}],
		['the reporter\'s, outdated line shown', { outdated: true }],
		['1,000 letters', { desc: 'The arrow kept pointing at the bank. '.repeat(28).slice(0, 1000) }],
		['1,000 letters, outdated line shown', { desc: 'w'.repeat(1000), outdated: true }],
	];
	for (const [name, opts] of cases) {
		const out = crowded(opts);
		assert.equal(out.boxShown, true, name);
		assert.ok(out.report.length > 0 && out.report.length <= 2000, `${name}: ${out.report.length}`);
		// Copy report puts the box in focus with all of the report selected
		// (0.3.7-rc1: not selected in the scrolling box); Ctrl+A and a click
		// select it all again.
		const all = { focus: true, from: 0, to: out.bytes };
		assert.deepEqual(out.copied, all, `${name}: Copy report selects the whole report`);
		assert.deepEqual(out.ctrlA, all, `${name}: Ctrl+A selects the whole report`);
		assert.deepEqual(out.clicked, all, `${name}: a click in the box selects the whole report`);
		assert.deepEqual(out.wellClicked, all, `${name}: a click on its well selects the whole report`);
		assert.deepEqual(out.children, { report: true, description: true }, `${name}: each box is its view's scroll child`);
		assert.deepEqual(out.kept, { ...all, sets: '' }, `${name}: the selection stays; nothing sets the box's text or cursor again`);
		// The bug: the box's measuring string drew the report over the window
		// once a theme repaint gave it its colour's alpha back.
		for (const s of out.drawn) {
			assert.ok(!s.includes('Engine.lua:2311') && !s.includes('**What went wrong:**'), `${name}: a font string draws the report: ${s.slice(0, 80)}`);
		}
		assert.ok(out.window <= 720, `${name}: the window fits a 720-unit screen (${out.window})`);
		assert.ok(out.view <= out.box && out.view >= Math.min(out.box, 96), `${name}: the view (${out.view}) holds up to the box (${out.box})`);
		assert.equal(out.content, out.box, `${name}: the whole report scrolls in the view`);
		assert.ok(out.box >= out.report.split('\n').length * 11, `${name}: the box holds every line (${out.box})`);
		// The form stays where it is: the box sits between Copy report and the
		// GitHub row, under the description and the mark button.
		assert.ok(out.desc[1] <= out.mark[0] && out.mark[1] <= out.copy[0], `${name}: description, mark, copy in order`);
		assert.ok(out.well[0] >= out.copy[1] && out.well[1] <= out.rule[0] && out.rule[1] <= out.github[0], `${name}: the box between Copy report (${out.copy}) and the GitHub row (${out.rule}): ${out.well}`);
		assert.ok(out.github[1] <= out.window, `${name}: Open on GitHub inside the window`);
		if (name !== 'short, one addon') assert.ok(out.view < out.box, `${name}: a long report scrolls (${out.view} of ${out.box})`);
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
	// zhCN's labels end in full-width colons and brackets, which the bot reads too.
	const zh = parseReport(pasted('zhCN'));
	assert.equal(zh.details.locale, 'zhCN');
	assert.equal(zh.details.guideId, 'forever/alliance/human/01-elwynn-forest');
	assert.equal(zh.details.step, 3);
	assert.equal(zh.details.errors.length, 1);
	assert.match(zh.description, /^The vermin were all by the tents\.\n\*\*[^*\n]+\*\* zone map 1429 · goto 51\.23,40\.50 live\n\*\*[^*\n]+\*\* Questie, TomTom$/);
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

test('the report carries the quest log, the settings turned away from their defaults and the rolling log\'s last lines', () => {
	const [out] = run(`
		Polestar.Compat.GetLogQuests = function() return { 783, 7 } end
		Polestar.Compat.IsQuestReadyForTurnIn = function(q) return q == 7 end
		Polestar.Compat.GetQuestObjectives = function() return { { finished = true }, { finished = false } } end
		Polestar.Set("qol.stepInteract", true)
		Polestar.Debug("picked the inn at Goldshire")
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		emit({ text = PolestarReport.Box:GetText() })`);
	const lines = out.text.split('\n');
	assert.ok(lines.includes('Quest log 2/40: 783 1/2, 7 done'), out.text);
	assert.ok(lineWith(out.text, 'Settings: ').includes('qol.stepInteract=true'), out.text);
	const log = lines.indexOf('Log:');
	assert.ok(log > 0, out.text);
	assert.match(lines[lines.length - 2], /^> \d\d:\d\d:\d\d picked the inn at Goldshire$/, 'the newest line last, inside the block');
});
