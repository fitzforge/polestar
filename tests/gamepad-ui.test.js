'use strict';
// Forever's Gamepad interface style (Options, Gamepad, Enable Gamepad UI).
// Its navigation opens, closes and focuses the game's windows, popups, menus
// and chat box from Blizzard's code and makes protected calls in the same
// execution. Addon code running in that flow gets them blocked, and the
// "AddOn blocked" popup's own gamepad handling blocks the next one until the
// client freezes (Blizzard forum threads 2367777 and 2370253). With it on,
// Polestar keeps to its own windows: Core/Init.lua's ns.GamepadUI() is read
// once as the addon loads, and every reach into the game's UI asks it first.
//
// Two checks:
//   * loaded with each style, Polestar registers its slash commands, its
//     tracking menu entries and its Escape-closable windows only with the
//     keyboard and mouse, opens the world map only then, and with the
//     gamepad shows the minimap button by default (its way in);
//   * every line of addon code that reaches into the game's UI (REACHES) is
//     in a file listed in ALLOWED with its count and reason. A new one fails
//     here: guard it with ns.GamepadUI() (or keep it out of the game's UI),
//     then list it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ADDONS } = require('./helpers/lua');

// cvar: the InputDeviceInterfaceStyle CVar's value (the client's API answers
// for the style; the CVar can stay "1" with the keyboard and mouse).
function load(gamepad, cvar) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: `
Enum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }
C_InputInterfaceStyle = { GetCurrentStyle = function() return ${gamepad ? 1 : 0} end }
${cvar ? `C_CVar = C_CVar or {}
do
	local get = C_CVar.GetCVar
	C_CVar.GetCVar = function(name) if name == "InputDeviceInterfaceStyle" then return ${JSON.stringify(cvar)} end return get and get(name) end
	local global = GetCVar
	GetCVar = function(name) if name == "InputDeviceInterfaceStyle" then return ${JSON.stringify(cvar)} end return global and global(name) end
end` : ''}
__menus = {}
Menu = { ModifyMenu = function(tag) __menus[#__menus + 1] = tag end }
C_Map.OpenWorldMap = function() end
`,
		addons: ['Polestar', 'Polestar_Recorder'],
		login: true,
		script: `
Polestar.Set("nav.answerTomTom", true)              -- /way, when nothing else owns it
Polestar.Fire("TOGGLE_FRAME")
Polestar.UI.ShowOptions()
stub.advance(0.5)
local special = {}
for _, name in ipairs(UISpecialFrames) do
	if type(name) == "string" and name:find("^Polestar") then special[#special + 1] = name end
end
emit({
	gamepad = Polestar.GamepadUI(),
	padActive = Polestar.Gamepad.IsActive(),
	slash = SlashCmdList.POLESTAR ~= nil and SLASH_POLESTAR1 ~= nil,
	way = SLASH_POLESTARWAY1 ~= nil,
	recorderSlash = SlashCmdList.POLESTARREC ~= nil,
	recorderCommand = type(PolestarRecorder_Command),
	menus = #__menus,
	special = #special,
	openMap = Polestar.Compat.CanOpenWorldMap(),
	minimapButton = Polestar.Get("maps.minimapButton"),
})
`,
	}).emitted[0];
}

test('with the keyboard and mouse Polestar registers its slash commands, menu entries and Escape-closable windows', () => {
	const r = load(false);
	assert.equal(r.gamepad, false);
	assert.deepEqual(
		{ slash: r.slash, way: r.way, recorderSlash: r.recorderSlash, recorderCommand: r.recorderCommand, openMap: r.openMap, minimapButton: r.minimapButton },
		{ slash: true, way: true, recorderSlash: true, recorderCommand: 'function', openMap: true, minimapButton: false },
	);
	assert.equal(r.menus, 2, 'the world map and minimap tracking menus');
	assert.ok(r.special > 0, 'its windows close with Escape');
});

// A client playing with the keyboard and mouse whose style CVar still reads
// "1" (Gamepad): the interface's own answer wins, so nothing of the gamepad
// shows (no hint bar, no button chips) and the slash commands stay.
test('the keyboard and mouse interface wins over a style CVar left at Gamepad', () => {
	const r = load(false, '1');
	assert.deepEqual(
		{ gamepad: r.gamepad, padActive: r.padActive, slash: r.slash, recorderSlash: r.recorderSlash, minimapButton: r.minimapButton },
		{ gamepad: false, padActive: false, slash: true, recorderSlash: true, minimapButton: false },
	);
});

test('with the gamepad interface Polestar keeps to its own windows, and its minimap button is the way in', () => {
	const r = load(true);
	assert.equal(r.gamepad, true);
	assert.deepEqual(
		{ slash: r.slash, way: r.way, recorderSlash: r.recorderSlash, menus: r.menus, special: r.special, openMap: r.openMap },
		{ slash: false, way: false, recorderSlash: false, menus: 0, special: 0, openMap: false },
		'no slash command, menu entry, UISpecialFrames entry or world map opened from addon code',
	);
	assert.equal(r.recorderCommand, 'function', "the Recorder's page in Polestar's options still runs its commands");
	assert.equal(r.minimapButton, true, 'the minimap button, on by default');
});

// What reaches into the game's UI: its command, window, popup, menu and
// error tables and openers, the map's own tables, override bindings (they
// sit over the gamepad interface's own) and its gamepad managers.
const REACHES = new RegExp('\\b(' + [
	'SlashCmdList', 'SLASH_[A-Z]\\w*', 'UISpecialFrames', 'Menu\\.ModifyMenu', 'MenuUtil\\.\\w+',
	'ShowUIPanel', 'HideUIPanel', 'StaticPopup_Show', 'StaticPopup_Hide', 'StaticPopupDialogs',
	'OpenWorldMap', 'ToggleWorldMap', 'ToggleQuestLog', 'CloseAllWindows',
	'AddDataProvider', 'AddCanvasClickHandler', 'AddGlobalPinMouseActionHandler', 'AcquirePin', 'pinPools',
	'SetMessageTypeEnabled', 'seterrorhandler',
	'SetOverrideBinding\\w*', 'ClearOverrideBindings', 'GamepadMode', 'SmartNavigation',
].join('|') + ')\\b');

// file -> [lines that reach, why it is safe with the gamepad interface]
const ALLOWED = {
	'Polestar/Core/Init.lua': [5, 'ns.CloseOnEscape and the /polestar registration, neither with the gamepad interface'],
	'Polestar/Core/Compat.lua': [3, 'Compat.OpenWorldMap opens nothing with the gamepad interface'],
	'Polestar/Dungeons/Dungeons.lua': [1, 'through Compat.OpenWorldMap'],
	'Polestar/Nav/Journey.lua': [6, "the map's canvas click handler and /way, neither with the gamepad interface; wayTaken only reads"],
	'Polestar/Nav/Nearby.lua': [3, 'the tracking menus, not with the gamepad interface'],
	'Polestar/QoL/Social.lua': [2, "dialogs closed for the player, never with the gamepad interface (its focus owns them)"],
	'Polestar/QoL/Toggles.lua': [3, 'the error-message setting, which does nothing with the gamepad interface'],
	'Polestar/UI/Options.lua': [2, "closing the game's Settings panel, never with the gamepad interface or in combat"],
	'Polestar/UI/Gamepad.lua': [3, "a window's override bindings, only with the keyboard and mouse interface; the gamepad interface's focused window only read (a field, never a call)"],
	'Polestar_Recorder/Commands.lua': [3, '/psrec, not with the gamepad interface'],
};

function luaFiles(dir) {
	const out = [];
	for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
		const full = path.join(dir, entry.name);
		if (entry.isDirectory()) {
			if (entry.name !== 'Locales') out.push(...luaFiles(full));
		} else if (entry.name.endsWith('.lua')) {
			out.push(full);
		}
	}
	return out;
}

test("every reach into the game's UI is guarded for the gamepad interface and listed", () => {
	const found = {};
	for (const name of fs.readdirSync(ADDONS)) {
		if (!name.startsWith('Polestar') || /^Polestar_(Names_|Guides)/.test(name)) continue;
		for (const file of luaFiles(path.join(ADDONS, name))) {
			const rel = path.relative(ADDONS, file).split(path.sep).join('/');
			const src = fs.readFileSync(file, 'utf8');
			let n = 0;
			for (const line of src.split('\n')) {
				if (REACHES.test(line.replace(/(^|\s)--.*$/, ''))) n++;
			}
			if (n) found[rel] = n;
		}
	}
	const counts = Object.fromEntries(Object.entries(ALLOWED).map(([f, [n]]) => [f, n]));
	assert.deepEqual(found, counts, 'a reach into the game\'s UI was added or removed: guard it with ns.GamepadUI() and update ALLOWED');
	for (const file of Object.keys(ALLOWED)) {
		const src = fs.readFileSync(path.join(ADDONS, file), 'utf8');
		assert.match(src, /GamepadUI|gamepadUI\(\)|Compat\.OpenWorldMap/, `${file} asks whether the gamepad interface is on`);
	}
});
