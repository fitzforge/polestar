'use strict';
// The confirm dialog's choices (addon/Polestar/Theme/Widgets.lua, W.Modal)
// run while the dialog and the clicked button are still up, then the dialog
// closes, as the game's popups do (StaticPopup_OnClick). ReloadUI needs the
// player's hardware event; with the dialog hidden before its action ran, a
// "Reload UI" choice closed the dialog and the interface did not reload.
// Against the real addon's modules and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

function run(script) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {} }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local W = Polestar.Widgets
			local reloads = {}
			function ReloadUI()
				local m = rawget(_G, "PolestarModal")
				local shown = m and m:IsShown() and m.Box.Action:IsShown() and true or false
				reloads[#reloads + 1] = shown
			end
			${script}`,
	}).emitted;
}

test('every choice runs before the dialog closes; a choice that opens another dialog leaves that one up', () => {
	const [out] = run(`
		local seen = {}
		local function spec(extra)
			local s = { title = "T", action = "Go", alt = "Other",
				onAccept = function() seen[#seen + 1] = { "accept", PolestarModal:IsShown() } end,
				onCancel = function() seen[#seen + 1] = { "cancel", PolestarModal:IsShown() } end,
				onAlt = function() seen[#seen + 1] = { "alt", PolestarModal:IsShown() } end }
			for k, v in pairs(extra or {}) do s[k] = v end
			return s
		end
		local m = W.Modal(spec())
		stub.mouseClick(m.Box.Action, {})
		local afterAccept = m:IsShown()
		W.Modal(spec()); stub.mouseClick(m.Box.Cancel, {})
		local afterCancel = m:IsShown()
		W.Modal(spec()); stub.mouseClick(m.Box.Alt, {})
		local afterAlt = m:IsShown()
		-- A choice that asks again: the next dialog stays.
		W.Modal(spec({ onAccept = function() W.Modal({ title = "Next", action = "OK" }) end }))
		stub.mouseClick(m.Box.Action, {})
		local next = m:IsShown() and m.Box.Title:GetText()
		W.HideModal()
		-- A choice that fails still closes the dialog, and its error is not lost.
		W.Modal(spec({ onAccept = function() error("boom") end }))
		pcall(function() stub.mouseClick(m.Box.Action, {}) end)
		emit({ seen = seen, afterAccept = afterAccept, afterCancel = afterCancel, afterAlt = afterAlt, next = next,
			afterFail = m:IsShown() })`);
	assert.deepEqual(out.seen, [['accept', true], ['cancel', true], ['alt', true]], 'each choice runs with the dialog up');
	assert.equal(out.afterAccept, false, 'the action closes it');
	assert.equal(out.afterCancel, false, 'Cancel closes it');
	assert.equal(out.afterAlt, false, 'the third choice closes it');
	assert.equal(out.next, 'Next', 'the dialog a choice opened stays up');
	assert.equal(out.afterFail, false, 'a failing choice still closes the dialog');
});
