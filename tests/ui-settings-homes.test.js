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
// every registered control of a key as "page > tab > section") and returns what it emits.
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
				for _, c in ipairs(O.AllControls()) do
					local function look(x)
						if x.key == key then out[#out + 1] = c.page.key .. " > " .. tostring(c.tab or "") .. " > " .. tostring(c.section or "") end
						for _, e in ipairs(x.extras or {}) do look(e) end
						for _, m in ipairs(x.more or {}) do look(m) end
					end
					look(c)
				end
				return out
			end
			${script}`,
	}).emitted[0];
}

test('the quests-new-in-Forever mark sits with the quest log and tooltips, the update notices on About', () => {
	const out = run(`UI.ShowOptions("about")
		local about = O.Controls("about")["update.card"]
		emit({ mark = homes("ui.newInForever"), update = homes("update.card"),
			aboutRow = about ~= nil and about:IsShown(), aboutOn = about ~= nil and about.checked })`);
	assert.deepEqual(out.mark, ['questing > Quests > Quest log and tooltips'], 'the mark: Questing > Quests, not the guide window\'s page');
	assert.deepEqual(out.update, ['about >  > Install'], 'the update notices: About, with Install');
	assert.equal(out.aboutRow, true, 'About shows the switch as a row');
	assert.equal(out.aboutOn, true, 'on by default');
});
