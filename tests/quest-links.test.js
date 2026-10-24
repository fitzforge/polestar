'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { fakeLocale } = require('./helpers/locale');

const BEFORE = String.raw`
local menus = {}
Menu = { ModifyMenu = function(tag, fn) menus[tag] = fn end }
function questMenu(tag, owner)
	local root = { buttons = { { text = "Native action" } } }
	function root:QueueDivider() end
	function root:CreateButton(text, fn)
		self.buttons[#self.buttons + 1] = { text = text, click = fn }
	end
	if menus[tag] then menus[tag](owner, root) end
	return root.buttons
end
`;

function run(script, { before = '' } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		before: before + BEFORE,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: String.raw`
uistub.install()
Polestar.Guides.Matches = uistub.realGuides.Matches
Polestar.Compat.GetQuestTitle = function(id) return id == 7 and "Kobold Camp Cleanup" or nil end
stub.login()
local P = Polestar.UI.Picker
` + script,
	}).emitted[0];
}

test('quest log action opens guide search and matching steps without Codex or changing the active guide', () => {
	const r = run(String.raw`
uistub.setGuide(uistub.tailoring, 2)
local before = Polestar.Engine.GetGuide().id
local buttons = questMenu("MENU_QUEST_MAP_LOG_TITLE", { questID = 7 })
buttons[2].click()
emit({ label = buttons[2].text, native = buttons[1].text, shown = PolestarPicker:IsShown(),
	section = P.Section(), query = P.Query(), search = P.search:GetText(), selected = P.Selected(),
	preview = P.details.Pitch:GetText(), active = Polestar.Engine.GetGuide().id,
	before = before, step = Polestar.Engine.GetStepIndex() })
`);
	assert.equal(r.label, 'Polestar: Show in Guides');
	assert.equal(r.native, 'Native action');
	assert.equal(r.shown, true);
	assert.equal(r.section, 'Guides');
	assert.equal(r.query, 'Kobold Camp Cleanup');
	assert.equal(r.search, r.query);
	assert.equal(r.selected, 'forever/alliance/human/01-elwynn-forest');
	assert.match(r.preview, /Step 2 of \d+: Marshal McBride/);
	assert.match(r.preview, /Kobold Camp/);
	assert.equal(r.active, r.before);
	assert.equal(r.step, 2);
});

test('reopening a staged exact quest search preserves its context, with or without an explicit Guides destination', () => {
	const r = run(String.raw`
Polestar.Compat.GetQuestTitle = function() return "An exact quest search" end
P.ShowQuest(7)
local function matches()
	local ids = {}
	for _, e in ipairs(P.Entries("All", P.Query())) do
		if e.kind == "guide" then ids[#ids + 1] = e.guide.id end
	end
	return ids
end
local before = matches()
PolestarPicker:Hide()
Polestar.UI.ShowPicker()
local legacy = matches()
PolestarPicker:Hide()
Polestar.UI.ShowPicker({ section = "Guides" })
emit({ before = before, legacy = legacy, explicit = matches(), query = P.Query() })
`);
	assert.ok(r.before.length > 0, 'quest ID matches even though the search text is absent from the guides');
	assert.deepEqual(r.legacy, r.before);
	assert.deepEqual(r.explicit, r.before);
	assert.equal(r.query, 'An exact quest search');
});

test('a quest menu leaves the account-wide faction filter following each character', () => {
	const r = run(String.raw`
local function after(setting)
	Polestar.Set("ui.pickerFaction", setting)
	P.ShowQuest(7)
	return Polestar.Get("ui.pickerFaction")
end
emit({ auto = after("auto"), all = after("All"), other = after("Horde"), selected = P.Selected() })
`);
	assert.deepEqual([r.auto, r.all, r.other], ['auto', 'All', 'auto']);
	assert.equal(r.selected, 'forever/alliance/human/01-elwynn-forest');
});

test('tracker resolves the quest from the clicked block and freezes it when its row is reused', () => {
	const r = run(String.raw`
local opened = {}
P.ShowQuest = function(id) opened[#opened + 1] = id end
QuestObjectiveTracker, CampaignQuestObjectiveTracker = {}, {}
local block = CreateFrame("Frame")
block.parentModule, block.id = QuestObjectiveTracker, 7
local header = CreateFrame("Button", nil, block)
local child = CreateFrame("Frame", nil, header)
QuestObjectiveTracker.GetExistingBlock = function(_, id) if id == block.id then return block end end
GetMouseFoci = function() return { child } end
local buttons = questMenu("MENU_QUEST_OBJECTIVE_TRACKER", { questID = 783 })
block.id = 783
buttons[2].click()
block.parentModule = CampaignQuestObjectiveTracker
CampaignQuestObjectiveTracker.GetExistingBlock = QuestObjectiveTracker.GetExistingBlock
local campaign = questMenu("MENU_QUEST_OBJECTIVE_TRACKER", {})
campaign[2].click()
emit({ opened = opened, native = buttons[1].text })
`);
	assert.deepEqual(r.opened, [7, 783]);
	assert.equal(r.native, 'Native action');
});

test('quest log action keeps its original quest ID after a pooled row changes', () => {
	const r = run(String.raw`
local owner, opened = { questID = 7 }, nil
P.ShowQuest = function(id) opened = id end
local buttons = questMenu("MENU_QUEST_MAP_LOG_TITLE", owner)
owner.questID = 783
buttons[2].click()
emit({ opened = opened })
`);
	assert.equal(r.opened, 7);
});

test('unrelated tracker blocks and invalid or secret quest IDs do not add an action', () => {
	const r = run(String.raw`
local counts = {}
for _, id in ipairs({ 0, -1, 7.5, math.huge, "7", {} }) do
	counts[#counts + 1] = #questMenu("MENU_QUEST_MAP_LOG_TITLE", { questID = id })
end
issecretvalue = function(value) return value == 7 end
counts[#counts + 1] = #questMenu("MENU_QUEST_MAP_LOG_TITLE", { questID = 7 })
issecretvalue = nil
counts[#counts + 1] = #questMenu("MENU_QUEST_MAP_LOG_TITLE", {})
local other = CreateFrame("Frame")
other.id, other.parentModule = 7, {}
GetMouseFoci = function() return { other } end
counts[#counts + 1] = #questMenu("MENU_QUEST_OBJECTIVE_TRACKER", {})
QuestObjectiveTracker = { GetExistingBlock = function() return nil end }
other.parentModule = QuestObjectiveTracker
counts[#counts + 1] = #questMenu("MENU_QUEST_OBJECTIVE_TRACKER", {})
GetMouseFoci = nil
counts[#counts + 1] = #questMenu("MENU_QUEST_OBJECTIVE_TRACKER", {})
emit({ counts = counts })
`);
	assert.ok(r.counts.every((n) => n === 1), JSON.stringify(r.counts));
});

test('a quest absent from installed guides shows an empty search with no unrelated selection', () => {
	const r = run(String.raw`
Polestar.UI.ShowPicker()
local active = Polestar.Engine.GetGuide()
P.ShowQuest(999999)
emit({ query = P.Query(), count = P.shown.guides, selected = P.Selected(),
	empty = PolestarPicker.Empty:GetText(), active = Polestar.Engine.GetGuide() == active })
`);
	assert.equal(r.query, '999999');
	assert.equal(r.count, 0);
	assert.equal(r.selected, undefined);
	assert.match(r.empty, /No guides match/);
	assert.equal(r.active, true);
});

test('quest context uses the client title, filters inapplicable steps and clears on a new search', () => {
	const r = run(String.raw`
local westfall = uistub.guides["forever/alliance/02-westfall"]
westfall.steps[1].only = { classes = { "Mage" } }
westfall.steps[1].goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup" } }
Polestar.Compat.GetQuestTitle = function() return "Client quest title" end
P.ShowQuest(7)
local found, query = P.shown.guides, P.Query()
P.SetQuery("westfall")
emit({ found = found, query = query, selected = P.Selected(), count = P.shown.guides, preview = P.details.Pitch:IsShown() and P.details.Pitch:GetText() or "" })
`);
	assert.equal(r.found, 1);
	assert.equal(r.query, 'Client quest title');
	assert.equal(r.selected, 'forever/alliance/02-westfall');
	assert.equal(r.count, 1);
	assert.doesNotMatch(r.preview || '', /Step 2 of/);
});

test('menu wording and quest preview follow the client language', () => {
	const r = run(String.raw`
Polestar.Compat.GetQuestTitle = function() return "Titolo della missione" end
local buttons = questMenu("MENU_QUEST_MAP_LOG_TITLE", { questID = 7 })
buttons[2].click()
emit({ label = buttons[2].text, query = P.Query(), preview = P.details.Pitch:GetText() })
`, {
		before: fakeLocale('itIT', {
			'Show in Guides': 'Mostra nelle guide',
			'Step %d of %d: %s': 'Passaggio %d di %d: %s',
		}),
	});
	assert.equal(r.label, 'Polestar: Mostra nelle guide');
	assert.equal(r.query, 'Titolo della missione');
	assert.match(r.preview, /Passaggio 2 di/);
});


test('the shipped Undead guide opens at The Mindless Ones from the tracker menu', () => {
	const r = runAddon({
		stubs: ['stub_world.lua', 'stub_encoding.lua'],
		before: BEFORE + String.raw`
stub.world.race, stub.world.raceName, stub.world.raceID = "Scourge", "Undead", 5
stub.world.faction = "Horde"
stub.world.titles[364] = "The Mindless Ones"
`,
		addons: [
			{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Lookup/Lookup.xml', 'UI/UI.xml'] },
			'Polestar_Guides',
		],
		saved: { Polestar: 'PolestarDB = { schema = 1, welcomeSeen = 1, settings = { behavior = { autoSelectGuide = false } } }; PolestarCharDB = { schema = 1, welcomeSeen = 1 }' },
		login: true,
		script: String.raw`
QuestObjectiveTracker = {}
local block = CreateFrame("Frame")
block.id, block.parentModule = 364, QuestObjectiveTracker
QuestObjectiveTracker.GetExistingBlock = function(_, id) if id == 364 then return block end end
local header = CreateFrame("Button", nil, block)
GetMouseFoci = function() return { header } end
local before = Polestar.Engine.GetGuide()
questMenu("MENU_QUEST_OBJECTIVE_TRACKER", {})[2].click()
local P = Polestar.UI.Picker
emit({ query = P.Query(), selected = P.Selected(), preview = P.details.Pitch:GetText(),
	active = Polestar.Engine.GetGuide() == before })
`,
	}).emitted[0];
	assert.equal(r.query, 'The Mindless Ones');
	assert.equal(r.selected, 'forever/horde/undead/01-tirisfal-glades');
	assert.match(r.preview, /Shadow Priest Sarvis/);
	assert.match(r.preview, /Mindless Zombies/);
	assert.match(r.preview, /graveyard/);
	assert.equal(r.active, true);
});

for (const [locale, label] of [
	['deDE', 'In den Guides zeigen'], ['esES', 'Ver en Guías'], ['esMX', 'Ver en Guías'],
	['frFR', 'Voir dans les guides'], ['ptBR', 'Mostrar em Guias'], ['ruRU', 'Показать в гайдах'],
	['koKR', '가이드에서 보기'], ['zhCN', '在指南中显示'], ['zhTW', '在指南中顯示'],
]) {
	test('quest menu uses shipped ' + locale + ' wording', () => {
		const r = run(String.raw`
local buttons = questMenu("MENU_QUEST_MAP_LOG_TITLE", { questID = 7 })
emit({ label = buttons[2].text })
`, { before: 'function GetLocale() return "' + locale + '" end\n' });
		assert.equal(r.label, 'Polestar: ' + label);
	});
}
