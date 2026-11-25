'use strict';
// The settings window's reorganization (docs/superpowers/specs/2026-11-17-settings-ia-review.md):
// each setting has one home row, and every other place it shows is a
// reference to that home (O.Ref). The saved keys stay as they were.
// Against the real addon's modules and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

// Every key the settings window holds, sorted, as it was before the reorganization.
const KEYS_FIXTURE = path.join(__dirname, 'fixtures', 'settings', 'registered-keys.json');

let cached;
function survey() {
	if (cached) return cached;
	cached = runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {} }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local K = O.Kit
			local rows, home, keys, seen = {}, {}, {}, {}
			for _, p in ipairs(K.pages) do
				for _, t in ipairs(p.tabs) do
					for _, s in ipairs(t.sections) do
						for _, c in ipairs(K.homeSettings(s)) do
							local key = c.key
							if key ~= nil then
								local at = { page = p.key, tab = t.name or "", section = s.name or "" }
								rows[key] = rows[key] or {}
								table.insert(rows[key], at)
								if not home[key] then home[key] = at end
								if not seen[key] then
									seen[key] = true
									keys[#keys + 1] = key
								end
							end
						end
					end
				end
			end
			table.sort(keys)
			local multiHome = {}
			for _, key in ipairs(keys) do
				if #rows[key] > 1 then
					local where = {}
					for _, at in ipairs(rows[key]) do where[#where + 1] = at.page .. " > " .. at.tab .. " > " .. at.section end
					multiHome[#multiHome + 1] = key .. ": " .. table.concat(where, " | ")
				end
			end
			emit({ multiHome = multiHome, home = home, keys = keys })`,
	}).emitted[0];
	return cached;
}

// Two homes on purpose (the review's "Intentional"): the walk colour and the
// route colour head both the Line and the Dots cards, and each card shows for
// one line style only.
const INTENTIONAL = ['nav.walkColor', 'nav.dotColor'];

test('every saved key has exactly one home row; every other appearance is a reference', () => {
	const multiHome = survey().multiHome.filter((line) => !INTENTIONAL.includes(line.split(':')[0]));
	assert.deepEqual(multiHome, []);
});

// page key, and the tab or section where the review names one.
const HOMES = {
	'qol.buyGoals': ['guide', 'Step errands'],
	'qol.autoBind': ['guide', 'Step errands'],
	'qol.flightHighlight': ['guide', 'Routes'],
	'qol.flightAutoTake': ['guide', 'Routes'],
	'qol.xpTargetMark': ['guide', 'Level pace'],
	'qol.instantQuestText': ['qualityoflife', 'Game'],
	'qol.hideErrors': ['qualityoflife', 'Game'],
	'qol.hideQuestTracker': ['qualityoflife', 'Game'],
	'nav.alerts': ['alerts', 'Transport alert'],
	'nav.alertBanner': ['alerts', 'Transport alert'],
	'rares.alerts': ['discovery', 'Rares'],
	'rares.combatAlerts': ['discovery'],
	'nav.arrow': ['guide'],
	'nav.distanceUnit': ['guide'],
	'qol.itemButton': ['questing', 'Buttons'],
	'nav.castPrompt': ['questing'],
	'qol.targetPlate': ['questing'],
	'maps.minimapButton': ['guidewindow', 'Show and hide'],
	'ui.launcher': ['guidewindow', 'Show and hide'],
	'nav.worldPins': ['map'],
	'nav.minimapRoute': ['map'],
	'nav.routeLines': ['guide'],
	'nav.journeySteps': ['guide'],
	'maps.coords': ['map'],
	'nav.nearbyMenu': ['guide'],
	'dungeons.headsUp': ['discovery'],
};

test('the homes match the review', () => {
	const { home } = survey();
	for (const [key, [page, section]] of Object.entries(HOMES)) {
		assert.ok(home[key], `${key} has a home`);
		assert.equal(home[key].page, page, `${key}'s home page: ${JSON.stringify(home[key])}`);
		if (section) assert.ok([home[key].tab, home[key].section].includes(section), `${key}'s home tab or section: ${JSON.stringify(home[key])}`);
	}
});

// The places that keep a reference (page > tab > section: key), the places a
// copy left without one, and words players searched the copies by.
const REFS = [
	'qualityoflife > Quests > Faster questing: behavior.autoAccept',
	'qualityoflife > Quests > Rewards, buttons and tracker: qol.itemButton',
	'questing > Quests > Faster questing: qol.instantQuestText',
	'questing > Quests > Quest log: qol.hideQuestTracker',
	'questing > Quests > Faster questing: qol.fastLoot',
	'guide > Arrow & routes > Along the route: nav.alerts',
	'alerts > Rare alert > Rare alert: rares.alerts',
	'alerts > Rare alert > Rare alert: rares.soundKit',
	'arrow > Look > Arrow: nav.arrow',
	'arrow > Text > Text: nav.arrowEta',
	'buttons > Action buttons > Buttons: qol.itemButton',
	'buttons > Action buttons > Buttons: nav.castPrompt',
	'buttons > Action buttons > Text: qol.targetPlate',
	'buttons > Launcher & minimap > Floating & minimap: maps.minimapButton',
	'mappins > Pins > Target pin: nav.worldPins',
	'routelines > Route > Route lines: nav.routeLines',
	'routelines > Route > Route lines: nav.lineStyle',
	'trackers > Travel > Flight timer: maps.flightTimer',
	'trackers > Travel > Journey: nav.journeySteps',
	'trackers > Party panel > Party panel: party.panel',
	'qualityoflife > Travel > Hearth and travel: nav.nearbyMenu',
	'guide > Automation > Guides: behavior.trainReminder',
	'alerts > Heads-up card > Card: dungeons.headsUp',
];
const DROPPED = [
	// Its home is Game, in the same group: Quests shows it no more.
	'qualityoflife > Quests > Faster questing: qol.fastLoot',
	'qualityoflife > Quests > Faster questing: qol.instantQuestText',
	'qualityoflife > Quests > Faster questing: qol.hideErrors',
	'qualityoflife > Quests > Rewards, buttons and tracker: qol.hideQuestTracker',
	'qualityoflife > Travel > Hearth and travel: nav.alerts',
	'map > Guide & quests > Guide: maps.minimapButton',
	'qualityoflife > Trackers & map > Minimap and coordinates: maps.minimapButton',
	// 10b: the review's order leaves these copies out.
	'qualityoflife > Trackers & map > Minimap and coordinates: maps.coords',
	'alerts > Rare alert > Card: toasts.stack',
	'alerts > Essentials > Alerts: toasts.stack',
	'theme > Frames > Frame & motion: ui.gameMenuButton',
	'about >  > Install: update.card',
];
const SEARCHED = {
	'who it targets': 'qol.targetPlate',
	'flash taskbar': 'nav.alertFlash',
	'hide with guide': 'nav.hideArrowWithGuide',
	'alert in combat': 'rares.combatAlerts',
	'transport banner countdown': 'nav.alertBanner',
};

let placesCached;
function places() {
	if (placesCached) return placesCached;
	placesCached = runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {} }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local UI, O, K = Polestar.UI, Polestar.UI.Options, Polestar.UI.Options.Kit
			UI.ShowOptions()
			local refs, any = {}, {}
			local function note(c, where)
				if not c.key then return end
				any[where .. ": " .. c.key] = true
				if rawget(c, "ref") then refs[where .. ": " .. c.key] = O.HomeOf(c) ~= nil end
			end
			for _, p in ipairs(K.pages) do
				for _, t in ipairs(p.tabs) do
					for _, s in ipairs(t.sections) do
						local where = p.key .. " > " .. (t.name or "") .. " > " .. (s.name or "")
						if s.toggle then note(s.toggle, where) end
						for _, c in ipairs(s.controls) do
							note(c, where)
							for _, e in ipairs(rawget(c, "extras") or {}) do note(e, where) end
						end
					end
				end
			end
			local found = {}
			for q, key in pairs(${luaTable(SEARCHED)}) do
				found[q] = false
				for _, g in ipairs(O.Search(q)) do
					for _, c in ipairs(g.controls) do if c.key == key then found[q] = true end end
				end
			end
			emit({ refs = refs, any = any, found = found })`,
	}).emitted[0];
	return placesCached;
}

function luaTable(obj) {
	return `{ ${Object.entries(obj).map(([k, v]) => `[${JSON.stringify(k)}] = ${JSON.stringify(v)}`).join(', ')} }`;
}

test('the other places show a reference that finds its home; the review\'s drops are gone', () => {
	const { refs, any } = places();
	for (const r of REFS) assert.equal(refs[r], true, `a reference with a home at ${r}`);
	for (const d of DROPPED) assert.ok(!any[d], `no copy left at ${d}`);
});

test('search still finds a setting by the words of the copy that became a reference', () => {
	const { found } = places();
	for (const q of Object.keys(SEARCHED)) assert.equal(found[q], true, `"${q}" finds ${SEARCHED[q]}`);
});

test('the reorganization changes no saved key', () => {
	const keysBefore = JSON.parse(fs.readFileSync(KEYS_FIXTURE, 'utf8'));
	assert.deepEqual(survey().keys, keysBefore);
});

// 10b: the player's journey (the review's §3, §4 and §7). The pages, tabs and
// sections in order, where the misplaced settings went, the module switches
// and the rows that follow a parent. One run, the new page on for its tree.
let journeyCached;
function journey() {
	if (journeyCached) return journeyCached;
	journeyCached = runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {}, optionsLayout = "grouped" }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local K, G = O.Kit, O.Grouped
			local SEP = " \\226\\128\\186 "
			local tree = {}
			for _, g in ipairs(G.Tree()) do
				local keys = {}
				for _, p in ipairs(g.pages) do keys[#keys + 1] = p.key end
				tree[g.key] = keys
			end
			local home, sectionOf, sectionToggle, refToggle, parentOf, layout = {}, {}, {}, {}, {}, {}
			local questsTabKeys = 0
			for _, p in ipairs(K.pages) do
				local tabs = {}
				for _, t in ipairs(p.tabs) do
					local secs = {}
					for _, s in ipairs(t.sections) do
						secs[#secs + 1] = s.name or ""
						local tg = s.toggle
						if tg and tg.key then
							if rawget(tg, "ref") then refToggle[s.name] = tg.key else sectionToggle[s.name] = tg.key end
						end
						for _, c in ipairs(K.homeSettings(s)) do
							if c.key and not home[c.key] then
								home[c.key] = p.key .. SEP .. (t.name or "") .. SEP .. (s.name or "")
								sectionOf[c.key] = s.name
								if p.key == "questing" and t.name == Polestar.L["Quests"] then questsTabKeys = questsTabKeys + 1 end
							end
						end
						for _, c in ipairs(s.controls) do
							local parent = rawget(c, "psParent")
							if c.key and parent and parent.key and not rawget(c, "ref") then parentOf[c.key] = parent.key end
						end
					end
					tabs[#tabs + 1] = { name = t.name or "", sections = secs }
				end
				layout[p.key] = tabs
			end
			local installHome
			for _, c in ipairs(O.AllControls()) do
				if c.label == Polestar.L["Set Polestar up again"] then installHome = c.page.key .. SEP .. tostring(c.tab) .. SEP .. tostring(c.section) end
			end
			local questingTabs = {}
			for _, t in ipairs(G.Tabs(K.pageByKey("questing"))) do questingTabs[#questingTabs + 1] = t.name end
			-- Route lines › Essentials › Style: its line style's home is a child of
			-- Route lines on Guide; with route lines off, the card says so.
			Polestar.Set("nav.routeLines", false)
			Polestar.UI.ShowOptions()
			O.Select("routelines", Polestar.L["Essentials"])
			local text = string.format(Polestar.L["Turn on %s first."], K.labelOf(O.HomeControl("nav.routeLines")))
			local styleLine
			for c, w in pairs(O.view.cache) do
				if w:IsShown() and c.kind == "button" and c.label == text then styleLine = c.button end
			end
			emit({ tree = tree, home = home, sectionOf = sectionOf, sectionToggle = sectionToggle, refToggle = refToggle,
				parentOf = parentOf, layout = layout, questsTabKeys = questsTabKeys, questingTabs = questingTabs,
				installHome = installHome, styleLine = styleLine or false, journal = ENCOUNTER_JOURNAL or Polestar.L["Dungeons"] })`,
	}).emitted[0];
	return journeyCached;
}

function tabsOf(out, page) { return out.layout[page].map((t) => t.name); }
function sectionsOf(out, page, tab) { return (out.layout[page].find((t) => t.name === tab) || { sections: [] }).sections; }

test('pages and sections follow the player journey order', () => {
	const out = journey();
	assert.deepEqual(out.tree.guiding, ['guide', 'questing', 'map', 'discovery']);
	assert.deepEqual(out.tree.qol, ['qualityoflife']);
	assert.equal(out.tree.look[0], 'guidewindow');
	assert.deepEqual(out.tree.look, ['guidewindow', 'theme', 'arrow', 'mappins', 'routelines', 'buttons', 'alerts', 'trackers']);
	assert.deepEqual(out.tree.setup, ['language', 'profiles', 'gamepad']);
	assert.deepEqual(out.tree.addons, ['integrations', 'guidepacks', 'recorder']);
	assert.deepEqual(out.tree.about, ['about', 'thanks']);
	// By name: pr/settings-essentials puts an Essentials tab before them.
	assert.deepEqual(out.questingTabs.filter((n) => n !== 'Essentials'), ['Quests', 'Rewards & gear', 'Buttons', 'Group']);
	assert.ok(out.questsTabKeys <= 22, out.questsTabKeys);

	assert.deepEqual(tabsOf(out, 'guide'), ['While you play', 'Automation', 'Arrow & routes']);
	assert.deepEqual(sectionsOf(out, 'guide', 'While you play'), ['Dynamic Questing', 'Pause', 'Level pace']);
	assert.deepEqual(sectionsOf(out, 'guide', 'Automation'), ['Guides', 'Quests', 'Profession guides', 'Step errands']);
	assert.deepEqual(sectionsOf(out, 'guide', 'Arrow & routes'), ['Arrow', 'Routes', 'Along the route', 'Getting around', 'Other waypoints']);

	assert.deepEqual(tabsOf(out, 'questing'), ['Quests', 'Rewards & gear', 'Buttons', 'Group']);
	assert.deepEqual(sectionsOf(out, 'questing', 'Quests'), ['Faster questing', 'Quest log', 'Quest data', 'Quest items', 'Free mode']);
	assert.deepEqual(sectionsOf(out, 'questing', 'Buttons'), ['Action buttons', 'Targeting']);
	assert.deepEqual(sectionsOf(out, 'questing', 'Group'), ['Group', 'Party chat']);

	// By name: pr/settings-essentials puts an Essentials tab before them.
	assert.deepEqual(tabsOf(out, 'qualityoflife').filter((n) => n !== 'Essentials'), ['Quests', 'Vendors', 'Travel', 'Leveling', 'Social', 'Game']);
	assert.deepEqual(sectionsOf(out, 'qualityoflife', 'Quests'), ['Faster questing', 'Rewards, buttons and tracker']);
	assert.deepEqual(sectionsOf(out, 'qualityoflife', 'Vendors'), ['Merchants', 'Restock', 'Bags']);
	assert.deepEqual(sectionsOf(out, 'qualityoflife', 'Travel'), ['Flights', 'Death', 'Hearth and travel']);
	assert.deepEqual(sectionsOf(out, 'qualityoflife', 'Leveling'), ['Experience', 'XP tracker', 'Trainers', 'Instances']);
	assert.deepEqual(sectionsOf(out, 'qualityoflife', 'Social'), ['Requests', 'Blocking']);

	assert.deepEqual(tabsOf(out, 'guidewindow'), ['Essentials', 'Window', 'Parts']);
	assert.deepEqual(sectionsOf(out, 'guidewindow', 'Window'), ['Window', 'Behaviour', 'Show and hide', 'Position', 'Background']);
	assert.deepEqual(sectionsOf(out, 'guidewindow', 'Parts'),
		['Bars', 'Step text', 'Step spacing', 'Target bar', 'Step tips', 'Up next', 'Still to do', 'Quest log notices', 'Progress & pace']);

	assert.deepEqual(tabsOf(out, 'alerts'), ['Essentials', 'Rare alert', 'Heads-up card', 'Transport alert', 'Class quest card']);
	assert.deepEqual(sectionsOf(out, 'alerts', 'Essentials'), ['Presets', 'All alerts', 'Alerts', 'Sound']);
});

test('misplaced settings sit in their new home', () => {
	const out = journey();
	const has = (page, tab) => tabsOf(out, page).includes(tab);
	assert.equal(out.home['toasts.stack'], 'alerts › Essentials › All alerts');
	for (const k of ['toasts.growth', 'toasts.spacing', 'toasts.max']) assert.equal(out.home[k], 'alerts › Essentials › All alerts', k);
	assert.equal(out.home['ui.gameMenuButton'], 'guidewindow › Window › Show and hide');
	for (const k of ['ui.launcher', 'maps.minimapButton', 'ui.lockHud']) assert.equal(out.home[k], 'guidewindow › Window › Show and hide', k);
	for (const k of ['ui.locked', 'movers.snap', 'movers.grid', 'movers.gridSize']) assert.equal(out.home[k], 'guidewindow › Window › Position', k);
	assert.equal(out.home['update.card'], 'profiles › Profiles › Install & updates');
	assert.equal(out.installHome, 'profiles › Profiles › Install & updates');
	assert.equal(out.home['qol.fastLoot'], 'qualityoflife › Game › Game options');
	assert.equal(out.home['qol.ridingReminder'], 'qualityoflife › Leveling › Trainers');
	assert.equal(out.home['qol.hideErrors'], 'qualityoflife › Game › Game options');
	assert.equal(out.sectionOf['qol.questBagMarks'], 'Quest items');
	assert.equal(out.sectionOf['qol.questSellWarning'], 'Quest items');
	assert.equal(out.sectionOf['qol.auctionBuys'], 'Quest items');
	assert.equal(has('guide', 'Professions'), false);
	assert.equal(out.home['professions.materials'], 'guide › Automation › Profession guides');
	assert.equal(out.home['professions.altMaterials'], 'guide › Automation › Profession guides');
});

test('Quest data is a module switch; dependent rows are children', () => {
	const out = journey();
	assert.equal(out.sectionToggle['Quest data'], 'qol.questDB');
	assert.equal(out.refToggle['Quest markers'], 'qol.questDB', "Map's quest markers fold with it: its switch as a reference");
	assert.equal(out.sectionToggle[out.journal], 'dungeons.enabled');
	assert.equal(out.home['dungeons.headsUp'], `discovery › Lookup › ${out.journal}`);
	assert.equal(out.sectionToggle['Characters'], 'alts.enabled');
	assert.equal(out.sectionToggle['XP tracker'], 'qol.xpTracker');
	const PARENTS = {
		'party.waitForGroup': 'party.show', 'party.lootNeeds': 'party.show',
		'party.chatEcho': 'party.chat', 'party.chatOnlyNeeded': 'party.chat',
		'qol.markMob': 'qol.markTarget', 'qol.markNpc': 'qol.markTarget',
		'qol.bagsLow': 'qol.bagSpace', 'qol.itemMarksClick': 'qol.itemMarks',
		'toasts.transport.linger': 'nav.alertBanner',
		'trackers.journey.numbers': 'nav.journeySteps',
		'trackers.xp.tickWidth': 'qol.xpTargetMark', 'trackers.xp.label': 'qol.xpTargetMark', 'trackers.xp.labelSize': 'qol.xpTargetMark',
		'rares.soundKit': 'rares.sound',
		// the existing link survives the move
		'update.probe': 'party.share',
	};
	for (const [k, parent] of Object.entries(PARENTS)) assert.equal(out.parentOf[k], parent, k);
});

test("a reference whose home is a child row waits on that row's parent: Route lines › Essentials › Style", () => {
	assert.equal(journey().styleLine, 'Guiding › Guide', 'the line names the parent\'s group and page');
});

// 10c: the labels (the review's §6) and the small fixes carried with them.
// Every keyed row on each classic page, refs as they draw (their own label,
// or their home's). A double: two keys under one label among the rows a
// card shows together (an extra on a row is named by its row; a row of
// another line style is not drawn).
let labelsCached;
function labels() {
	if (labelsCached) return labelsCached;
	labelsCached = runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {} }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local L, O = Polestar.L, Polestar.UI.Options
			local K = O.Kit
			Polestar.UI.ShowOptions()
			local label, inCard, refAt = {}, {}, {}
			local function note(c, where, row)
				if not c.key then return end
				if rawget(c, "ref") then
					O.HomeOf(c)
					refAt[where .. ": " .. c.key] = c
				end
				local text = K.labelOf(c)
				if not text or text == "" then return end
				if not rawget(c, "ref") and not label[c.key] then label[c.key] = text end
				if not row or not K.available(c) then return end
				inCard[where] = inCard[where] or {}
				local keys = inCard[where][text] or {}
				keys[c.key] = true
				inCard[where][text] = keys
			end
			for _, p in ipairs(K.pages) do
				for _, t in ipairs(p.tabs) do
					for _, s in ipairs(t.sections) do
						local where = p.key .. " > " .. (t.name or "") .. " > " .. (s.name or "")
						if s.toggle then note(s.toggle, where, true) end
						for _, c in ipairs(s.controls) do
							note(c, where, true)
							for _, e in ipairs(rawget(c, "extras") or {}) do note(e, where, false) end
							for _, m in ipairs(rawget(c, "more") or {}) do note(m, where, false) end
						end
					end
				end
			end
			local dupLabels = {}
			for where, texts in pairs(inCard) do
				for text, keys in pairs(texts) do
					local list = {}
					for k in pairs(keys) do list[#list + 1] = k end
					if #list > 1 then
						table.sort(list)
						dupLabels[#dupLabels + 1] = where .. ": " .. text .. " (" .. table.concat(list, ", ") .. ")"
					end
				end
			end
			table.sort(dupLabels)
			local function help(at) local c = refAt[at] return c and c.help or false end
			local units = refAt["arrow > Text > Text: nav.distanceUnit"]
			local unitTexts = {}
			for _, ch in ipairs(units and K.choicesOf(units) or {}) do unitTexts[#unitTexts + 1] = ch.text end
			-- Quest items rows say why they are grey with Quest data off.
			Polestar.Set("qol.questDB", false)
			local why = {}
			for _, k in ipairs({ "qol.questBagMarks", "qol.questSellWarning", "qol.auctionBuys" }) do
				why[k] = K.whyOff(O.HomeControl(k)) or false
			end
			local qol = K.pageByKey("qualityoflife")
			emit({ label = label, dupLabels = dupLabels, unitTexts = unitTexts, why = why,
				arrowHelp = help("arrow > Look > Arrow: nav.arrow"),
				minimapRouteHelp = help("routelines > Route > Route lines: nav.minimapRoute"),
				qolSubtitle = qol and qol.subtitle or false,
				turnOnQuestData = string.format(L["Turn on %s first."], label["qol.questDB"] or "") })`,
	}).emitted[0];
	return labelsCached;
}

test('the renamed labels read in plain words', () => {
	const out = labels();
	// qol.xpBoostedRest and qol.xpPace (XP row parts) are not in this tree, so their renames are not here.
	const RENAMED = {
		'maps.instanceDisplay': 'Compact instance tracker',
		'qol.questDB': 'Quest data for markers and tooltips',
		'nav.routeStyle': 'Which way to walk',
		'ui.starAlpha': 'Stars in the band',
		'qol.boostedRest': 'Boosted Rest timer',
		'toasts.headsup.seconds': 'Stays for',
		'toasts.whilehere.seconds': 'Suggestion stays for',
		'update.probe': "Check my party's Polestar version",
		'ui.compact': 'Compact window',
		'toasts.headsup.compact': 'Compact card',
		'guideWindow.leftOut': 'Skipped quests line',
		'ui.opacity': 'Whole window opacity',
		'guideWindow.idleAlpha': 'Opacity when not pointed at',
		'alts.enabled': 'Your other characters',
		'nav.arrowNoTarget': 'With nowhere to go',
		'ui.animSpeed': 'Animation speed',
		'toasts.headsup.place': 'Where it shows',
		'qol.auctionBuys': 'Quest items to buy at the auction house',
	};
	for (const [key, text] of Object.entries(RENAMED)) assert.equal(out.label[key], text, key);
	assert.deepEqual(Object.values(out.dupLabels), [], 'no two different keys share a label in one card');
});

test('references whose home help points elsewhere read right where they are', () => {
	const out = labels();
	assert.ok(out.arrowHelp && !/Arrow page/.test(out.arrowHelp), `Arrow page's switch: ${out.arrowHelp}`);
	assert.ok(out.minimapRouteHelp && !/gear beside/.test(out.minimapRouteHelp), `Route lines' minimap switch: ${out.minimapRouteHelp}`);
	assert.deepEqual(out.unitTexts, ['Yards', 'Metres'], 'Arrow › Text › Units');
	assert.ok(!/the map\./.test(out.qolSubtitle), `Quality of Life's subtitle: ${out.qolSubtitle}`);
});

test('Quest items rows that read the quest data say why they are grey', () => {
	const { why, turnOnQuestData } = labels();
	assert.equal(why['qol.questBagMarks'], turnOnQuestData);
	assert.equal(why['qol.questSellWarning'], turnOnQuestData);
	assert.equal(why['qol.auctionBuys'], false, 'the auction house list needs no quest data');
});

// The new page's dependency line walks a reference's home up its parents to
// the first that is off. Rare alert's Sound (rares.soundKit) waits on Play a
// sound, which waits on Alert for rares.
function soundKitLine(settings) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {}, optionsLayout = "grouped" }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local K, G = O.Kit, O.Grouped
			for k, v in pairs(${luaTable(settings)}) do Polestar.Set(k, v) end
			local ref
			for _, s in ipairs(K.pageByKey("alerts").tabs) do
				for _, sec in ipairs(s.sections) do
					for _, c in ipairs(sec.controls) do
						if rawget(c, "ref") and c.key == "rares.soundKit" and not rawget(c, "extras") then ref = c end
					end
				end
			end
			-- The plain reference (Essentials' Sound, without Play a sound as an
			-- extra) on its own: a section without Alert for rares.
			local d = G._dependency({ name = "Test", controls = { ref } })
			emit({ toggle = d and d.toggle.key or false })`,
	}).emitted[0].toggle;
}

test('a dependency line: a parent that is on shows none; a grandparent that is off with the parent on shows its line', () => {
	assert.equal(soundKitLine({ 'rares.enabled': true, 'rares.alerts': true, 'rares.sound': true }), false);
	assert.equal(soundKitLine({ 'rares.enabled': true, 'rares.alerts': false, 'rares.sound': true }), 'rares.alerts');
	assert.equal(soundKitLine({ 'rares.enabled': true, 'rares.alerts': true, 'rares.sound': false }), 'rares.sound');
	assert.equal(soundKitLine({ 'rares.enabled': false, 'rares.alerts': true, 'rares.sound': true }), 'rares.enabled');
});
