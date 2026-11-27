'use strict';
// Guide kinds (Core/Guides.lua, GuideKinds; docs/GUIDE_FORMAT.md, "Guide kind"): a guide's `kind`, else its
// category's, decides the guide window's parts and its menu. A profession guide's XP row is its skill line
// (no XP an hour, no pace), and its menu leads with its trainer and has no Free mode, quest hand-ins or quest
// log clean-up; a leveling guide keeps all of them; a part's setting still turns it off.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const script = (guide, setup = '') => `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide(${guide})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local C = Polestar.Compat
C.GetSkillRank = function(line) if line == 197 or line == "Tailoring" then return 87, 150 end return nil end
C.GetSkillLineName = function(line) return line == 197 and "Tailoring" or nil end
Polestar.Handins.Ready = function() return { 1, 2 } end
Polestar.RoutePlan.Unneeded = function() return { { quest = 1 } } end
${setup}
local E = Polestar.Engine
E.SetGuide("test/kind")
local GF = Polestar.UI.GuideFrame
GF.Layout(); stub.advance(1)
GF.UpdateXP({ rate = 12000, timeToLevel = 1800 })
local W = Polestar.Widgets
local got
local show = W.ShowMenu
W.ShowMenu = function(_, items) got = items end
GF.OpenMenu(CreateFrame("Button", nil, UIParent))
W.ShowMenu = show
local menu = {}
for _, it in ipairs(got or {}) do
	if it.separator then menu[#menu + 1] = "-" elseif it.bar then menu[#menu + 1] = "bar" else menu[#menu + 1] = it.text end
end
emit({ kind = E.GuideKind(), xp = GF.xp.psHas and GF.xp.Text:GetText() or false, menu = menu, handinRow = GF.KindHas("handinRow", "handinRow") })`;

const PROFESSION = (extra = '') => `{ id = "test/kind", pack = "test", title = "Tailoring 1-300", minLevel = 5, maxLevel = 60, category = "Professions"${extra},
	sections = { { skill = "Tailoring", skillLine = 197, from = 1, to = 150 } },
	steps = {
		{ title = "Woolen Cape to 100", goals = { { t = "craft", spell = 2402, spellName = "Woolen Cape", item = 2580, itemName = "Woolen Cape", skillLine = 197, untilSkill = 100, yellow = 80, grey = 115 } } },
		{ title = "Artisan Tailoring", goals = { { t = "level", level = 35 }, { t = "train", skill = "Tailoring", skillLine = 197, rank = 200, rankMax = 300 } } },
	} }`;

const LEVELING = `{ id = "test/kind", pack = "test", title = "Elwynn", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } } } }`;

const run = (guide, setup) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: script(guide, setup) }).emitted[0];

test('a profession guide: the skill line in the XP row, no XP or pace; its menu leads with its trainer, no hand-ins, Free mode or log clean-up', () => {
	const out = run(PROFESSION());
	assert.equal(out.kind, 'profession', 'the Professions category');
	assert.equal(out.xp, 'Tailoring 87 / 150  ·  next stretch to 100  ·  step 2 needs level 35 (Artisan Tailoring)');
	assert.ok(!out.menu.some((t) => /Hand in finished|None to hand in|Clean up quest log|Quest log is clean|Free mode/.test(t)), out.menu.join(' | '));
	assert.deepEqual(out.menu.slice(0, 4), ['bar', '-', 'Nearest Tailoring trainer', '-'], 'the trainer first, after the window toggles');
});

test('a leveling guide is unchanged: XP and pace, hand-ins and the log clean-up in the menu, no skill line', () => {
	const out = run(LEVELING);
	assert.ok(out.xp && out.xp.includes('XP/h') && !out.xp.includes('Tailoring'), String(out.xp));
	assert.ok(out.menu.includes('Hand in finished quests (2)') && out.menu.includes('Clean up quest log (1)'), out.menu.join(' | '));
	assert.ok(!out.menu.some((t) => /trainer/.test(t)), out.menu.join(' | '));
});

test('`kind` beats the category; a part turned off in the settings stays off in a leveling guide', () => {
	assert.equal(run(PROFESSION(', kind = "reputation"')).kind, 'reputation');
	assert.equal(run(PROFESSION(', kind = "nonsense"')).kind, 'profession', 'a kind Polestar does not know: the category');
	assert.equal(run(LEVELING, 'Polestar.Set("guideWindow.xpLine", false)').xp, false);
});

const DUNGEON = (extra = '') => `{ id = "test/kind", pack = "test", title = "Blackfathom Deeps", minLevel = 20, maxLevel = 30, category = "Dungeons"${extra},
	steps = { { goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } } } }`;

test('the finished quests\' row (handinRow): a dungeon guide has none, whatever the log holds; a leveling guide keeps it', () => {
	assert.equal(run(DUNGEON()).handinRow, false, 'the Dungeons category');
	assert.equal(run(DUNGEON(', kind = "dungeon"')).handinRow, false, 'kind dungeon');
	assert.equal(run(LEVELING.replace('maxLevel = 20,', 'maxLevel = 20, kind = "dungeon",')).handinRow, false, 'kind beats a leveling category');
	assert.equal(run(LEVELING).handinRow, true, 'a leveling guide with the same two finished quests');
	assert.equal(run(DUNGEON().replace('category = "Dungeons"', 'category = "Leveling"')).handinRow, true, 'category alone decides, never the id');
});
