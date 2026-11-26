'use strict';
// The flight games with the game's gamepad interface on (Maps/Arcade.lua, Polestar_Arcade): only Tetris is
// offered, because it has gamepad controls (D-pad, A, B, X, Y, Start through Polestar.Gamepad); Freedoom Arcade
// and Sky Jewels play with the keyboard and mouse. The flight card offers it, its window takes and gives back the
// gamepad, the Flight arcade settings show (and a search finds them) with only the games that play there, and a
// saved choice of another game stays saved. Polestar_Arcade registers no slash command then. Against the real
// Core, Theme, Nav, Maps and UI on the small travel world of tests/lua/stub_maps.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Maps/Maps.xml', 'UI/UI.xml'];

const style = (gamepad) => `
stub.maps.useWorld(); stub.maps.place(0, 800); stub.world.faction = "Alliance"
Enum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }
C_InputInterfaceStyle = { GetCurrentStyle = function() return ${gamepad ? 1 : 0} end }`;

// A flight from West Hold to Mid Camp (tests/addontest/maps-arcade.rs's), the card under its timer, Polestar_Arcade in
// the AddOns list as the client gives it (loaded on demand).
const PRELUDE = `
stub.addons[#stub.addons + 1] = { name = "Polestar_Arcade", reason = "DEMAND_LOADED" }
local M, A, G, UI = Polestar.Maps, Polestar.Arcade, Polestar.Gamepad, Polestar.UI
local m = stub.maps
Polestar.Nav.RegisterTravelData(m.travel, true)
Polestar.CharState().flags.taxi = { [1] = true, [2] = true, [3] = true }
local function takeoff(seconds)
	M.CharTable("flightTimes")["1>3"] = seconds
	m.openTaxi(1, { 3, 2 })
	TakeTaxiNode(2)
	m.board()
	stub.advance(1)
end
local function card()
	local c = stub.frame("PolestarArcadeOffer")
	return c ~= nil and c:IsShown() and c.mode or false
end
local function chat()
	local out = {}
	for _, s in ipairs(stub.messages) do out[#out + 1] = (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
	return out
end
`;

function run(script, { gamepad = true, saved } = {}) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_maps.lua', 'stub_ui.lua', 'stub_gamepad.lua'],
		before: style(gamepad),
		addons: [{ name: 'Polestar', files: FILES }],
		saved: saved ? { Polestar: saved } : undefined,
		login: true,
		script: PRELUDE + script,
	}).emitted;
}

const SKY_JEWELS = 'PolestarDB = { schema = 1, settings = { arcade = { game = "skyjewels" } } }';

test('with the gamepad interface the flight card offers Tetris alone, and a saved other game falls back to it', () => {
	const [out] = run(
		`
		takeoff(300)
		local games = card() == "ask" and stub.frame("PolestarArcadeOffer").Ask.Games or {}
		local shown = {}
		for id, b in pairs(games) do shown[id] = b:IsShown() end
		emit({ card = card(), shown = shown, choice = A.Choice().id, saved = Polestar.Get("arcade.game"),
			available = { freedoom = A.Available("freedoom"), skyjewels = A.Available("skyjewels"), tetris = A.Available("tetris") } })`,
		{ saved: SKY_JEWELS },
	);
	assert.equal(out.card, 'ask');
	assert.deepEqual(out.shown, { freedoom: false, skyjewels: false, tetris: true });
	assert.equal(out.choice, 'tetris');
	assert.equal(out.saved, 'skyjewels', 'the saved choice is left alone');
	assert.deepEqual(out.available, { freedoom: false, skyjewels: false, tetris: true });
});

test('Tetris from the card: the D-pad moves, A rotates, Start pauses, RB closes and the buttons go back to the game', () => {
	const [out] = run(
		`
		takeoff(300)
		stub.frame("PolestarArcadeOffer").Ask.Games.tetris:Click()
		local T = PolestarTetris
		local g = T.Run()
		g.piece = { kind = "T", x = 4, y = 0, rot = 0 }
		local out = { open = PolestarTetrisAPI.IsOpen(), owner = G.owner == PolestarTetrisFrame, active = Polestar.Arcade.Active() }
		out.left = stub.press("PADDLEFT")
		out.moved = g.piece.x == 3
		out.rotate = stub.press("PAD1")
		out.rot = g.piece.rot
		out.start = stub.press("PADFORWARD")
		out.paused = g.paused
		stub.press("PADFORWARD")
		out.resumed = not g.paused
		out.close = stub.press("PADRSHOULDER")
		out.closed = not PolestarTetrisAPI.IsOpen()
		out.owner2 = G.owner == PolestarTetrisFrame
		out.back = stub.press("PADDLEFT")
		emit(out)`,
		{ saved: SKY_JEWELS },
	);
	assert.deepEqual(out, {
		open: true, owner: true, active: 'tetris',
		left: 'frame', moved: true, rotate: 'frame', rot: 1, start: 'frame', paused: true, resumed: true,
		close: 'frame', closed: true, owner2: false, back: 'game',
	});
});

test('playing Tetris from the card keeps a saved Freedoom Arcade or Sky Jewels, and Don\'t ask again still turns it off', () => {
	const kept = run(
		`
		takeoff(300)
		stub.frame("PolestarArcadeOffer").Ask.Games.tetris:Click()
		emit({ saved = Polestar.Get("arcade.game"), open = PolestarTetrisAPI.IsOpen() })`,
		{ saved: SKY_JEWELS },
	)[0];
	assert.deepEqual(kept, { saved: 'skyjewels', open: true });
	const never = run(
		`
		takeoff(300)
		local ask = stub.frame("PolestarArcadeOffer").Ask
		ask.Never:SetChecked(true)
		ask.Games.tetris:Click()
		emit({ saved = Polestar.Get("arcade.game") })`,
		{ saved: SKY_JEWELS },
	)[0];
	assert.deepEqual(never, { saved: 'none' });
	const chosen = run(
		`
		takeoff(300)
		stub.frame("PolestarArcadeOffer").Ask.Games.tetris:Click()
		emit({ saved = Polestar.Get("arcade.game") })`,
		{ gamepad: false },
	)[0];
	assert.deepEqual(chosen, { saved: 'tetris' }, 'with the keyboard and mouse a game played is the choice, as before');
});

test('Polestar_Arcade registers no slash command with the gamepad interface, and its commands still do with the keyboard', () => {
	const load = (gamepad) =>
		run(
			`
		Polestar.RunCommand("tetris")
		emit({ loaded = C_AddOns.IsAddOnLoaded("Polestar_Arcade"), tetris = PolestarTetrisAPI.IsOpen(),
			slash = SlashCmdList.FREEDOOMARCADE ~= nil, word = SLASH_FREEDOOMARCADE1 ~= nil })`,
			{ gamepad },
		)[0];
	assert.deepEqual(load(true), { loaded: true, tetris: true, slash: false, word: false });
	assert.deepEqual(load(false), { loaded: true, tetris: true, slash: true, word: true });
});

test('Freedoom Arcade and Sky Jewels say they need the keyboard and mouse instead of opening or claiming a missing folder', () => {
	const [out] = run(`
		Polestar.RunCommand("jewels")
		Polestar.RunCommand("arcade")
		local lines = {}
		for _, s in ipairs(chat()) do if s:find("keyboard and mouse", 1, true) then lines[#lines + 1] = s end end
		emit({ lines = lines, active = Polestar.Arcade.Active() or false, loaded = C_AddOns.IsAddOnLoaded("Polestar_Arcade") })`);
	assert.deepEqual(out.lines.map((s) => s.replace(/^.*?(Sky Jewels|Freedoom Arcade)/, '$1')), [
		"Sky Jewels needs the keyboard and mouse. With the game's gamepad interface on, Tetris is the game that plays.",
		"Freedoom Arcade needs the keyboard and mouse. With the game's gamepad interface on, Tetris is the game that plays.",
	]);
	assert.equal(out.active, false);
	assert.equal(out.loaded, false, 'nothing is loaded for a game that is not offered');
});

test('the Flight arcade settings show with the gamepad interface, a search finds them, and the picker lists only Tetris and None', () => {
	const settings = (gamepad, saved) =>
		run(
			`
		UI.LoadOptions()
		local O = Polestar.UI.Options
		local control
		for _, p in ipairs(O.Kit.pages) do
			for _, t in ipairs(p.tabs) do
				for _, s in ipairs(t.sections) do
					for _, c in ipairs(s.controls) do if rawget(c, "key") == "arcade.game" then control = c end end
				end
			end
		end
		local values = {}
		for _, ch in ipairs(O.Kit.choicesOf(control)) do values[#values + 1] = ch.value end
		local found = {}
		for _, q in ipairs({ "arcade", "game on flights", "tetris" }) do
			found[q] = false
			for _, g in ipairs(O.Search(q)) do
				for _, c in ipairs(g.controls) do if rawget(c, "key") == "arcade.game" then found[q] = true end end
			end
		end
		emit({ shown = control.needs(), values = values, picker = control.get(), saved = Polestar.Get("arcade.game"), found = found, help = control.help })`,
			{ gamepad, saved },
		)[0];
	const pad = settings(true, SKY_JEWELS);
	assert.equal(pad.shown, true, 'never hidden with the gamepad interface');
	assert.deepEqual(pad.values, ['tetris', 'none']);
	assert.equal(pad.picker, 'tetris', 'a saved Sky Jewels shows as the Tetris the flight offers');
	assert.equal(pad.saved, 'skyjewels');
	assert.deepEqual(pad.found, { arcade: true, 'game on flights': true, tetris: true });
	assert.match(pad.help, /only Tetris is offered, because it plays with the gamepad: Freedoom Arcade and Sky Jewels need the keyboard and mouse/);
	const keys = settings(false, SKY_JEWELS);
	assert.deepEqual(keys.values, ['freedoom', 'skyjewels', 'tetris', 'none'], 'the keyboard and mouse picker is as before');
	assert.equal(keys.picker, 'skyjewels');
});
