'use strict';
// Home, the hub's first section (addon/Polestar/UI/Home.lua), against the
// fake Engine and sample guides of tests/lua/stub_ui.lua: the menu toggle
// opens it and "Choose a guide" opens the guide list; it has no sidebar, the
// brand sits in its footer; its cards come from the other modules' data and
// close up when one has nothing to say.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\nlocal UI, P, H = Polestar.UI, Polestar.UI.Picker, Polestar.UI.HomeSection\n${HELPERS}\n${script}`,
	}).emitted;
}

const HELPERS = `
local TABS = { { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }
local function shownCards()
	local out = {}
	for _, key in ipairs({ "hero", "build", "dungeons", "next", "trainer", "gear", "rares" }) do
		if H.Shown()[key] then out[#out + 1] = key end
	end
	return out
end
-- Talents as it would answer: a plan picked ("balance") or none ("auto").
local function fakeTalents(choice, status)
	local plans = { { key = "balance", specName = "Balance" }, { key = "feral", specName = "Feral Combat" }, { key = "resto", specName = "Restoration" } }
	Polestar.Talents = {
		FIRST_LEVEL = 10,
		Choice = function() return choice end,
		Choose = function(key) choice = key end,
		Data = function() return { builds = plans } end,
		Current = function()
			return { data = { nodes = { [1] = { spell = 16814 }, [2] = { spell = 16845 } } }, build = { specName = "Balance", picks = { { node = 1, rank = 1 }, { node = 2, rank = 1 } } },
				state = { status = status, unspent = status == "behind" and 1 or 0, spent = 0, done = 0, total = 2, next = { node = 1, rank = 1 } } }
		end,
		PickText = function() return "Improved Wrath 1/5" end,
		NodeName = function(_, id) return id == 1 and "Improved Wrath" or "Moonglow" end,
	}
	UI.TalentsSection = { Show = function() end }
end
local function fakeWorld(level, trained)
	uistub.player.level = level
	UI.DungeonsSection.ForYou = function() return { { key = "deadmines", name = "The Deadmines", minLevel = 17, maxLevel = 26, zoneName = "Westfall", quests = { A = 5, H = 0 } } } end
	Polestar.CharState().classTrainLevel = trained
	Polestar.Engine.NearestClassTrainer = function() return { npcName = "Khelden Bremen", map = 1429, x = 49.66, y = 39.4 } end
end
`;

test('the menu toggle opens Home; Choose a guide opens the guide list; once a section is picked the toggle keeps it', () => {
	const [out] = run(`
		Polestar.Fire("TOGGLE_PICKER")
		local r = { first = P.Section(), title = PolestarPicker.Title:GetText() }
		Polestar.Fire("SHOW_PICKER")
		r.choose = P.Section()
		PolestarPicker:Hide()
		P.ShowSection("Lookup")
		Polestar.Fire("TOGGLE_PICKER")
		r.kept = P.Section()
		emit(r)`);
	assert.deepEqual(out, { first: 'Home', title: 'Your journey', choose: 'Guides', kept: 'Lookup' });
});

test('Home has no sidebar: the page runs from the rail to the edge, the brand, version and Discord in its footer; other sections keep the sidebar', () => {
	const [out] = run(`
		H.Show()
		local F, foot = PolestarPicker, H.Footer()
		local _, rel = F.Main:GetPoint(1)
		local r = { sidebar = F.Sidebar:IsShown(), mainAfterRail = rel == F.Rail, tagline = foot.Tagline:GetText(),
			version = foot.Version:GetText(), discord = foot.Discord:IsShown(), heroW = H.Cards().hero:GetWidth() }
		P.ShowSection("Guides")
		local _, rel2 = F.Main:GetPoint(1)
		r.guides = { F.Sidebar:IsShown(), rel2 == F.Sidebar }
		emit(r)`);
	assert.equal(out.sidebar, false);
	assert.equal(out.mainAfterRail, true);
	assert.equal(out.tagline, 'A community project');
	assert.match(out.version, /^Version /);
	assert.equal(out.discord, true);
	assert.ok(out.heroW > 1000, `the hero spans the window (${out.heroW})`);
	assert.deepEqual(out.guides, [true, true]);
});

test('Home: the guide to continue with what is left of it, then the chosen talent plan, dungeons, where the guide leads and class training, three to a line', () => {
	const [out] = run(`
		fakeTalents("balance", "behind")
		fakeWorld(20, 18)
		uistub.openTabs(TABS, 1)
		H.Show()
		local c = H.Cards()
		local strip = function(s) return (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
		local r = { cards = shownCards(), subtitle = PolestarPicker.Subtitle:GetText(),
			hero = { strip(c.hero.Name:GetText()), c.hero.Step:GetText(), c.hero.Go.Label:GetText(), c.hero.Then.Value:GetText() },
			build = { c.build.Spec:GetText(), c.build.When:GetText(), c.build.Icons[1].psSpell, c.build.Icons[2].psSpell, c.build.Icons[3]:IsShown() },
			dungeons = { c.dungeons.Name:GetText(), c.dungeons.Quests:GetText(), c.dungeons.Count:GetText() },
			nxt = c.next.Name:GetText(),
			trainer = { c.trainer.Status:GetText(), c.trainer.Place:GetText(), c.trainer.Last:GetText() } }
		local _, _, _, bx, by = c.build:GetPoint(1)
		local _, _, _, dx, dy = c.dungeons:GetPoint(1)
		local _, _, _, nx, ny = c.next:GetPoint(1)
		local _, _, _, tx, ty = c.trainer:GetPoint(1)
		r.grid = { by == dy and dy == ny, bx < dx and dx < nx, ty < by, tx == bx }
		Polestar.Nav = { SetTarget = function(map, x, y, label) r.target = { map, label } end }
		c.trainer.Go:Click()
		emit(r)`);
	assert.deepEqual(out.cards, ['hero', 'build', 'dungeons', 'next', 'trainer']);
	assert.match(out.subtitle, /^Level 20/);
	assert.deepEqual(out.hero, ['Elwynn Forest  (1–13)', 'Step 3 of 8  ·  29% complete', 'Continue guide', 'Westfall (12–17)']);
	assert.deepEqual(out.build, ['Balance', '1 point to spend', 16814, 16845, false]);
	assert.deepEqual(out.dungeons, ['The Deadmines', '5 quests', '1 dungeon for your level']);
	assert.equal(out.nxt, 'Westfall');
	assert.deepEqual(out.trainer, ['New abilities available', 'Khelden Bremen, Elwynn Forest', 'Last trained at level 18']);
	assert.deepEqual(out.grid, [true, true, true, true], 'build, dungeons and up next share a line; training starts the next');
	assert.deepEqual(out.target, [1429, 'Khelden Bremen']);
});

test('Leveling build: no plan picked yet, the class\'s plans to pick from; picked, where you stand, before level 10 when the first point comes', () => {
	const [ask, early] = run(`
		fakeTalents("auto", "early")
		fakeWorld(8, 8)
		H.Show()
		local c = H.Cards().build
		local choices = {}
		for _, b in ipairs(c.Choices) do if b:IsShown() then choices[#choices + 1] = b.Label:GetText() end end
		emit({ cards = shownCards(), title = c.Spec:GetText(), ask = c.Ask:IsShown(), picks = c.Picks:IsShown(), choices = choices })
		c.Choices[1]:Click()
		P.Render()
		emit({ choice = Polestar.Talents.Choice(), title = c.Spec:GetText(), ask = c.Ask:IsShown(), when = c.When:GetText(),
			next = c.Next:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""), choices = c.Choices[1]:IsShown() })`);
	assert.deepEqual(ask, { cards: ['hero', 'build', 'dungeons', 'next', 'trainer'], title: 'Pick a leveling build', ask: true, picks: false,
		choices: ['Balance', 'Feral Combat', 'Restoration'] });
	assert.deepEqual(early, { choice: 'balance', title: 'Balance', ask: false, when: 'Your first talent point comes at level 10',
		next: 'Next talent:  Improved Wrath 1/5', choices: false });
});

test('Home: a card with nothing to say is left out; with no guide open the suggestion is featured, to load', () => {
	const [out] = run(`
		uistub.player.level = 10
		Polestar.CharState().classTrainLevel = 10
		Polestar.Engine.NearestClassTrainer = function() return { npcName = "Khelden Bremen", map = 1429, x = 49.66, y = 39.4 } end
		H.Show()
		local c = H.Cards()
		emit({ cards = shownCards(), status = c.trainer.Status:GetText(), go = c.hero.Go.Label:GetText(), step = c.hero.Step:GetText() })`);
	assert.deepEqual(out.cards, ['hero', 'next', 'trainer']);
	assert.equal(out.status, 'Class skills up to date');
	assert.equal(out.go, 'Load guide');
	assert.equal(out.step, 'Not started');
});

// Class training follows the guide: its own train step (the trainer the
// engine picked, the guide window's) wins over the level rule, which would
// call a character trained at this level up to date.
test('Class training: the guide\'s own training step and its trainer first; else the nearest trainer and the even-level rule', () => {
	const [guide, rule] = run(`
		uistub.player.level = 6
		Polestar.CharState().classTrainLevel = 6
		Polestar.Engine.NearestClassTrainer = function() return { npcName = "Somewhere Else", map = 1413, x = 50, y = 50 } end
		Polestar.Engine.IsClassTrainer = function(npc) return npc == 459 end
		local g = uistub.guides[uistub.elwynn]
		table.insert(g.steps, 4, { title = "Drusilla La Salle", goals = {
			{ t = "train", npc = 911, npcName = "Llane Beshere", map = 1429, x = 50.24, y = 42.29, status = "na" },
			{ t = "train", npc = 459, npcName = "Drusilla La Salle", map = 1429, x = 49.87, y = 42.65, status = "pending" },
		} })
		uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
		H.Show()
		local c = H.Cards().trainer
		local r = { status = c.Status:GetText(), place = c.Place:GetText() }
		Polestar.Nav = { SetTarget = function(map, x, y, label) r.target = { map, label } end }
		c.Go:Click()
		emit(r)
		table.remove(g.steps, 4)
		P.Render()
		emit({ status = c.Status:GetText(), place = c.Place:GetText() })`);
	assert.deepEqual(guide, { status: 'Your guide trains you next step', place: 'Drusilla La Salle, Elwynn Forest', target: [1429, 'Drusilla La Salle'] });
	assert.deepEqual(rule, { status: 'Class skills up to date', place: 'Somewhere Else, The Barrens' });
});

// The spells waiting: the class's trainer spells (Core/ClassSpells.lua) at
// or under the level, not known, the rank before known, not a talent.
test('Class training lists the spells to train: up to the level, not known, the rank before known, no talents', () => {
	const [out, none] = run(`
		uistub.player.level, uistub.player.class = 12, "WARLOCK"
		Polestar.CharState().classTrainLevel = 10
		local NAMES = { [348] = "Immolate", [707] = "Immolate", [172] = "Corruption", [695] = "Shadow Bolt", [705] = "Shadow Bolt",
			[1454] = "Life Tap", [17877] = "Shadowburn", [6222] = "Corruption", [1094] = "Immolate" }
		C_Spell = C_Spell or {}
		C_Spell.GetSpellName = function(id) return NAMES[id] end
		local known = { [348] = true, [695] = true, [1454] = true }
		IsPlayerSpell = function(id) return known[id] or false end
		Polestar.Engine.NearestClassTrainer = function() return { npcName = "Drusilla La Salle", map = 1429, x = 49.87, y = 42.65 } end
		Polestar.Engine.ClassSpells = function(cls)
			return cls == "WARLOCK" and {
				{ 348, 1, 0, 0 }, { 172, 4, 0, 0 }, { 695, 6, 0, 0 }, { 1454, 6, 0, 0 }, { 707, 10, 348, 0 },
				{ 705, 12, 695, 0 }, { 6222, 14, 172, 0 }, { 17877, 12, 0, 0 }, { 1094, 20, 707, 0 },
			} or nil
		end
		Polestar.Talents = { Data = function() return { nodes = { [1] = { spell = 17877 } } } end }
		H.Show()
		local c = H.Cards().trainer
		local icons = {}
		for _, b in ipairs(c.Icons) do if b:IsShown() then icons[#icons + 1] = b.psSpell end end
		emit({ status = c.Status:GetText(), icons = icons, spells = c.Spells:GetText() })
		known[172], known[707], known[705] = true, true, true
		P.Render()
		emit({ status = c.Status:GetText(), spells = c.Spells:GetText(), icon = c.Icons[1]:IsShown() })`);
	// Corruption 1 (known nothing), Immolate 2 (rank 1 known), Shadow Bolt 3 (rank 2 known); not Corruption 2
	// (level 14, rank 1 unknown), not Shadowburn (a talent), not Immolate 3 (level 20).
	assert.deepEqual(out, { status: '3 spells to train', icons: [172, 707, 705], spells: 'Corruption, Immolate, Shadow Bolt' });
	assert.deepEqual(none, { status: 'Class skills up to date', spells: '', icon: false });
});
