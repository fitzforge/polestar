'use strict';
// The command box (UI/CommandBox.lua): with the game's gamepad interface on there are no slash commands (the
// chat box calls a command and closes itself in its taint, which blocks the gamepad's actions), so Polestar's
// commands run from a box of Polestar's own: the same Polestar.RunCommand /polestar runs, typed with the
// keyboard or the game's, Enter runs, Escape or B closes, the D-pad moves between its buttons. Against the real
// Core, Theme, Nav, Maps and UI and the fakes of tests/lua/stub_ui.lua and stub_gamepad.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Maps/Maps.xml', 'UI/UI.xml'];

// The game's interface style, read once as Polestar loads (Core/Init.lua); and the chat box's entry points, which
// must never be called: anything of Polestar's that reached the chat would taint it.
const style = (gamepad) => `
Enum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }
C_InputInterfaceStyle = { GetCurrentStyle = function() return ${gamepad ? 1 : 0} end }
for _, name in ipairs({ "ChatEdit_ActivateChat", "ChatEdit_SendText", "ChatEdit_OnEnterPressed", "ChatEdit_InsertLink", "ChatFrame_OpenChat", "ChatFrame_SendTell" }) do
	_G[name] = function() error(name .. ": the chat box is not Polestar's to use") end
end`;

function run(script, { gamepad = true, recorder = false } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua', 'stub_gamepad.lua'],
		before: style(gamepad),
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()
stub.login()
local UI, G, B = Polestar.UI, Polestar.Gamepad, Polestar.UI.CommandBox
local pad = stub.pad
local got = {}
Polestar.RegisterCommand("probe", function(rest) got[#got + 1] = rest end, "a command the test types")
local function typed(text)
	UI.ShowCommandBox()
	local box = B.Frame().Box
	box:SetText(text)
	stub.RunScript(box, "OnEnterPressed", box)
	return B.Frame():IsShown()
end
${recorder ? 'function PolestarRecorder_Command(msg) got[#got + 1] = "rec:" .. msg end' : ''}
${script}`,
	}).emitted;
}

test('with the gamepad interface the box runs what /polestar runs, with or without the slash, and closes', () => {
	const [out] = run(`
		local lines = { "probe a b", "/ps probe a", "/polestar probe", "/pole probe", "  PROBE  x  ", "/probe y" }
		local open = {}
		for _, line in ipairs(lines) do open[#open + 1] = typed(line) end
		emit({ slash = SlashCmdList.POLESTAR ~= nil, got = got, open = open })`);
	assert.equal(out.slash, false, 'still no slash command with the gamepad interface');
	assert.deepEqual(out.got, ['a b', 'a', '', '', 'x', 'y']);
	assert.deepEqual(out.open, [false, false, false, false, false, false], 'Enter runs it and closes the box');
});

test('the box runs the same Polestar.RunCommand the slash command is, /way and the Recorder\'s /psrec included', () => {
	const [out] = run(
		`
		local ran = {}
		local runCommand = Polestar.RunCommand
		Polestar.RunCommand = function(msg) ran[#ran + 1] = msg; return runCommand(msg) end
		typed("/way 52 40 Mill")
		typed("next")
		typed("/psrec on")
		typed("polestarrec status")
		emit({ ran = ran, got = got })`,
		{ recorder: true },
	);
	assert.deepEqual(out.ran, ['way 52 40 Mill', 'next'], '/way and next go through Polestar.RunCommand');
	assert.deepEqual(out.got, ['rec:on', 'rec:status'], '/psrec goes to the Recorder\'s own command');
});

test('a word nothing answers to stays in the box, with the commands that begin with what was typed under it', () => {
	const [out] = run(`
		UI.ShowCommandBox()
		local box, F = B.Frame().Box, B.Frame()
		-- The stub's SetText fires no OnTextChanged: the client's does.
		local function type_(text) box:SetText(text); stub.RunScript(box, "OnTextChanged", box, true) end
		type_("ne")
		local listed = F.Matches:GetText()
		type_("zzz now")
		local open = typed("zzz now")
		local unknown = F.Matches:GetText()
		emit({ listed = listed, open = open, unknown = unknown, got = table.concat(got, ",") })`);
	assert.match(out.listed, /^Commands: .*next/);
	assert.equal(out.open, true, 'an unknown word keeps the box open');
	assert.equal(out.unknown, "Unknown command 'zzz'.");
	assert.equal(out.got, '', 'nothing ran');
});

test('nothing of the box reaches the game\'s chat or its Escape list, and Escape closes it', () => {
	const [out] = run(`
		UI.ShowCommandBox("probe a")
		local F = B.Frame()
		local focus = F.Box == stub.focus
		local chain, p = {}, F.Box
		while p do chain[#chain + 1] = p:GetName() or "?"; p = p:GetParent() end
		stub.RunScript(F.Box, "OnEscapePressed", F.Box)
		local special = {}
		for _, name in ipairs(UISpecialFrames) do special[#special + 1] = name end
		emit({ focus = focus, shown = F:IsShown(), chain = table.concat(chain, ">"), special = table.concat(special, ",") })`);
	assert.equal(out.focus, true, 'the keyboard is in the box as it opens');
	assert.equal(out.shown, false, 'Escape closes it');
	assert.ok(!/Chat/.test(out.chain), `the box is no child of the chat: ${out.chain}`);
	assert.ok(!/PolestarCommandBox/.test(out.special), 'no UISpecialFrames entry with the gamepad interface');
});

test('a gamepad moves through the box: the D-pad goes on to Run, A runs, B closes', () => {
	const [out] = run(`
		UI.ShowCommandBox("probe 7")
		local F = B.Frame()
		local owner = G.owner == F
		local first = G.Focused(F) == F.Box
		stub.press("PADDDOWN")
		local second = G.Focused(F) == F.Run
		stub.press("PAD1")
		local ranWith = got[1]
		local closedByRun = not F:IsShown()
		UI.ShowCommandBox()
		stub.press("PAD2")
		emit({ owner = owner, first = first, second = second, ranWith = ranWith, closedByRun = closedByRun, closedByB = not F:IsShown(), buttons = stub.press("PADDDOWN") })`);
	assert.deepEqual(out, { owner: true, first: true, second: true, ranWith: '7', closedByRun: true, closedByB: true, buttons: 'game' });
});

test('the minimap button\'s menu offers Run a command with the gamepad interface only', () => {
	const rows = (gamepad) =>
		run(
			`
		local items
		local W = Polestar.Widgets
		local show = W.ShowMenu
		W.ShowMenu = function(_, list) items = list end
		Polestar.Maps.ShowMenu(UIParent)
		W.ShowMenu = show
		local texts, row = {}, nil
		for _, it in ipairs(items) do
			if it.text then texts[#texts + 1] = it.text end
			if it.text == "Run a command" then row = it end
		end
		if row then row.onClick() end
		emit({ texts = texts, opened = B.Frame() ~= nil and B.Frame():IsShown() })`,
			{ gamepad },
		)[0];
	const withPad = rows(true);
	assert.ok(withPad.texts.includes('Run a command'), withPad.texts.join('|'));
	assert.equal(withPad.opened, true, 'the row opens the box');
	assert.ok(!rows(false).texts.includes('Run a command'), 'the keyboard and mouse interface has the chat');
});

test('the Gamepad page of the settings has the box, and a search for slash commands finds it', () => {
	const [out] = run(`
		UI.LoadOptions()
		local O = UI.Options
		local control
		for _, p in ipairs(O.Kit.pages) do
			for _, t in ipairs(p.tabs) do
				for _, s in ipairs(t.sections) do
					for _, c in ipairs(s.controls) do
						if rawget(c, "label") == "Run a command" then control = { page = p.key, help = c.help, click = c.onClick } end
					end
				end
			end
		end
		local found = {}
		for _, q in ipairs({ "slash commands", "type a command", "run command" }) do
			found[q] = false
			for _, g in ipairs(O.Search(q)) do
				for _, c in ipairs(g.controls) do if rawget(c, "label") == "Run a command" then found[q] = true end end
			end
		end
		control.click()
		emit({ page = control.page, help = control.help, found = found, opened = B.Frame():IsShown() })`);
	assert.equal(out.page, 'gamepad');
	assert.match(out.help, /slash commands are off/);
	assert.deepEqual(out.found, { 'slash commands': true, 'type a command': true, 'run command': true });
	assert.equal(out.opened, true);
});
