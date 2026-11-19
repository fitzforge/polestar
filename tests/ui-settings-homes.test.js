'use strict';
// Where the settings window keeps a setting (addon/Polestar_Options/UI/Options.lua,
// UI/Looks/GuideWindow.lua): each setting has one home, the page a player
// looks for it on. Against the real addon's modules and the fakes of
// tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml'];

// Opens the settings window, runs `script` (Lua, `O` the window, `homes`:
// every home of a key as "page > tab > section") and returns what it emits.
function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local UI, O = Polestar.UI, Polestar.UI.Options
			UI.ShowOptions()
			local function homes(key)
				local out = {}
				-- Every home, an extra or a cog's setting among them.
				for _, c in ipairs(O.AllControls()) do
					if c.key == key then out[#out + 1] = c.page.key .. " > " .. tostring(c.tab or "") .. " > " .. tostring(c.section or "") end
				end
				return out
			end
			${script}`,
	}).emitted[0];
}

test('the quests-new-in-Forever mark sits with the quest log, the update notices on Profiles with Install', () => {
	const out = run(`UI.ShowOptions("profiles")
		local row = O.Controls("profiles")["update.card"]
		emit({ mark = homes("ui.newInForever"), update = homes("update.card"),
			row = row ~= nil and row:IsShown(), on = row ~= nil and row.checked })`);
	assert.deepEqual(out.mark, ['questing > Quests > Quest log'], 'the mark: Questing > Quests, not the guide window\'s page');
	assert.deepEqual(out.update, ['profiles > Profiles > Install & updates'], 'the update notices: Setup > Profiles, with Install');
	assert.equal(out.row, true, 'Profiles shows the switch as a row of its Install & updates card');
	assert.equal(out.on, true, 'on by default');
});

// The guide window's own settings: what it shows, when it hides and where it sits.
const WINDOW_KEYS = ['ui.shown', 'ui.compact', 'ui.wholeStep', 'ui.maxHeight', 'ui.showNotes', 'ui.notesOpen', 'ui.upcoming',
	'ui.upcomingOpen', 'ui.combat', 'ui.instance', 'ui.growUp', 'ui.barsBottom', 'ui.locked'];

test('every guide-window setting has one home, on Look > Guide window', () => {
	const out = run(`local out = {}
		for _, k in ipairs({ ${WINDOW_KEYS.map((k) => JSON.stringify(k)).join(', ')} }) do out[k] = homes(k) end
		local reset
		for _, c in ipairs(O.AllControls()) do if c.label == Polestar.L["Reset position"] then reset = c.page.key .. " > " .. c.tab .. " > " .. c.section end end
		emit({ homes = out, reset = reset })`);
	for (const k of WINDOW_KEYS) {
		assert.equal(out.homes[k].length, 1, `${k} has one home: ${out.homes[k].join(', ')}`);
		assert.match(out.homes[k][0], /^guidewindow > /, `${k} on Look > Guide window: ${out.homes[k][0]}`);
	}
	assert.equal(out.reset, 'guidewindow > Window > Position', 'the window\'s Reset position with its lock');
});

test('Guide opens on While you play, and each page links to the other', () => {
	const out = run(`UI.ShowOptions("guide")
		local guide = { tab = O.view.psTab.name, cards = {} }
		for _, card in ipairs(O.view.cards) do if card:IsShown() and card.psHeader then guide.cards[#guide.cards + 1] = card.psName end end
		local link = O.view.XLink
		guide.link = { shown = link ~= nil and link:IsShown(), text = link and link.Text:GetText(), to = link and link.Link.Label:GetText() }
		link.Link:Click()
		local landed = { page = O.page.key, tab = O.view.psTab.name }
		local back = O.view.XLink
		local look = { shown = back ~= nil and back:IsShown(), text = back and back.Text:GetText(), to = back and back.Link.Label:GetText() }
		back.Link:Click()
		emit({ guide = guide, landed = landed, look = look, back = { page = O.page.key, tab = O.view.psTab.name } })`);
	assert.equal(out.guide.tab, 'While you play', 'Guide\'s first tab is While you play');
	assert.deepEqual(out.guide.cards, ['Dynamic Questing', 'Pause', 'Level pace']);
	assert.deepEqual(out.guide.link, { shown: true, text: 'What the window shows, when it hides and where it sits:', to: 'Look › Guide window' });
	assert.deepEqual(out.landed, { page: 'guidewindow', tab: 'Window' }, 'the link opens Look > Guide window');
	assert.deepEqual(out.look, { shown: true, text: 'Dynamic Questing and pause:', to: 'Guiding › Guide' });
	assert.deepEqual(out.back, { page: 'guide', tab: 'While you play' }, 'and its own link leads back');
});
