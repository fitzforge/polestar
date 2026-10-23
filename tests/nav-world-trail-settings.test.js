'use strict';
// Real Core settings, lifecycle, bus and slash dispatcher; no substituted methods.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ROOT } = require('./helpers/lua');

function run(script, saved = 'PolestarDB = nil', before = '') {
	// Allow the first RED to report the missing feature, not a missing-file error.
	const adapter = 'Nav/WorldTrail.lua';
	const files = ['Core/Init.lua', 'Core/Commands.lua'];
	if (fs.existsSync(path.join(ROOT, 'addon/Polestar', adapter))) files.push(adapter);
	return runAddon({
		addons: [{ name: 'Polestar', files }],
		before,
		saved: { Polestar: saved },
		login: true,
		script: `assert(Polestar.WorldTrail, "native world-trail adapter is registered")
		local W = Polestar.WorldTrail
		${script}
		assert(#Polestar.Errors() == 0, "no swallowed lifecycle/bus/command errors")`,
	}).emitted;
}

test('runtime numbers clamp to accepted bounds and reject wrong types and nonfinite values', () => {
	const [out] = run(`
		local cases = {
			{ "intensity", 0, 1 }, { "subtlety", 0, 1 }, { "size", 6, 28 },
			{ "speed", 0, 1 }, { "maxSparkles", 10, 400 }, { "groundLength", 10, 200 },
			{ "groundFade", 0, 1 }, { "groundLift", -3, 3 }, { "groundGap", 0.3, 8 },
			{ "groundWidth", 0, 3 }, { "groundAhead", 0, 10 },
		}
		for _, c in ipairs(cases) do
			local key, lo, hi = unpack(c)
			local path = "nav." .. W.SETTINGS[key]
			Polestar.Set(path, lo - 10); assert(W.Settings()[key] == lo, key .. " lower bound")
			Polestar.Set(path, hi + 10); assert(W.Settings()[key] == hi, key .. " upper bound")
			for _, bad in ipairs({ 0/0, math.huge, -math.huge, "12", false, {} }) do
				Polestar.Set(path, bad)
				assert(W.Settings()[key] == W.DEFAULTS[key], key .. " invalid fallback")
			end
		end
		Polestar.Set("nav.worldTrailMax", 25.7)
		assert(W.Settings().maxSparkles == 26, "sparkle cap is integral")
		Polestar.Set("nav.worldTrail", "true")
		Polestar.Set("nav.worldTrailSight", 1)
		Polestar.Set("nav.worldTrailColor", "unknown")
		emit({ enabled = W.Settings().enabled, sight = W.Settings().groundSight,
			color = W.Settings().color, helper = W.Clamp(5, 0, 1), fallback = W.ColorOf("unknown").key,
			colors = W.COLORS })`);
	assert.equal(out.enabled, false);
	assert.equal(out.sight, true);
	assert.equal(out.color, 'gold');
	assert.equal(out.helper, 1);
	assert.equal(out.fallback, 'gold');
	assert.deepEqual(out.colors.map(c => [c.key, c.rgb]), [
		['gold', [1, 0.84, 0.38]], ['arcane', [0.55, 0.75, 1]], ['fel', [0.55, 1, 0.45]],
		['rose', [1, 0.55, 0.75]], ['white', [1, 1, 1]],
	]);
});

test('seven accepted looks apply only appearance without enabling or changing maps, indoors or sight', () => {
	const expected = [
		['lantern', 1, 0.35, 14, 0.5, 1, 30, 2, 0.5, 5, 'gold'],
		['whisper', 0.55, 0.75, 11, 0.3, 1, 18, 0.8, 1.2, 4, 'gold'],
		['witcher', 0.9, 0.5, 13, 0.35, 1, 22, 2.6, 0.4, 3.5, 'white'],
		['breadcrumbs', 1, 0.2, 16, 0, 0.7, 35, 0, 3, 4, 'gold'],
		['ribbon', 0.85, 0.45, 12, 0.7, 0.9, 45, 0.5, 0.3, 4, 'arcane'],
		['fairy', 1, 0, 17, 0.9, 1, 28, 1.6, 0.6, 4, 'rose'],
		['fel', 1, 0.25, 14, 0.6, 1, 30, 1.4, 0.7, 4, 'fel'],
	];
	const [out] = run(`
		local rows = {}
		for _, name in ipairs({ "lantern", "whisper", "witcher", "breadcrumbs", "ribbon", "fairy", "fel" }) do
			assert(W.ApplyPreset(name), "accepted look")
			local d = W.Settings()
			assert(not d.enabled and d.groundIndoors and not d.groundSight, "behavior preserved")
			rows[#rows+1] = { name, d.intensity, d.subtlety, d.size, d.speed, d.groundFade,
				d.groundLength, d.groundWidth, d.groundGap, d.groundAhead, d.color }
		end
		local before = Polestar.Get("nav.worldTrailColor")
		assert(W.ApplyPreset("unknown") == false)
		assert(W.ApplyPreset({}) == false)
		assert(Polestar.Get("nav.worldTrailColor") == before)
		emit({ rows = rows, map = Polestar.Get("nav.minimapTrail"), ui = Polestar.Get("ui.scale") })`,
		'PolestarDB = { settings = { nav = { worldTrailIndoors = true, worldTrailSight = false, minimapTrail = false }, ui = { scale = 1.2 } } }');
	assert.deepEqual(out.rows, expected);
	assert.equal(out.map, false);
	assert.equal(out.ui, 1.2);
});

test('custom look saves a detached appearance whitelist and restores sanitized values only', () => {
	const [out] = run(`
		assert(W.ApplyPreset("mine") == false, "no empty custom look")
		Polestar.Set("nav.worldTrailIntensity", 0)
		Polestar.Set("nav.worldTrailFlow", 0.63)
		local saved = W.SaveLook()
		assert(saved.intensity == 0 and saved.speed == 0.63)
		assert(saved.enabled == nil and saved.groundSight == nil and saved.density == nil)
		saved.size = 6
		assert(Polestar.Get("nav.worldTrailCustomLook").size == 14, "returned look is detached")
		Polestar.Set("nav.worldTrailCustomLook", { size = 999, intensity = 0, speed = 0/0,
			groundWidth = false, color = "fel", enabled = true, groundIndoors = true,
			groundSight = false, minimap = true, density = 10, ["ui.scale"] = 4 })
		assert(W.ApplyPreset("mine"))
		emit({ db = W.Settings(), ui = Polestar.Get("ui.scale"), raw = PolestarDB.settings.nav })`);
	assert.equal(out.db.enabled, false);
	assert.equal(out.db.size, 28);
	assert.equal(out.db.intensity, 0);
	assert.equal(out.db.speed, 0.5);
	assert.equal(out.db.groundWidth, 1);
	assert.equal(out.db.color, 'fel');
	assert.equal(out.db.groundIndoors, false);
	assert.equal(out.db.groundSight, true);
	assert.equal(out.db.density, 5);
	assert.equal(out.db.minimap, false);
	assert.equal(out.ui, undefined);
	assert.equal(out.raw.minimap, undefined);
});

test('reset restores only registered world-trail keys and disables the master', () => {
	const [out] = run(`
		Polestar.Set("nav.worldTrail", true)
		W.ApplyPreset("fel"); W.SaveLook()
		Polestar.Set("nav.worldTrailIndoors", true)
		W.Reset()
		emit({ db = W.db, custom = next(Polestar.Get("nav.worldTrailCustomLook")) == nil,
			map = Polestar.Get("nav.worldTrailDensity"), pins = Polestar.Get("nav.worldPins"),
			arrow = Polestar.Get("nav.arrow"), ui = Polestar.Get("ui.scale") })`,
		'PolestarDB = { settings = { nav = { worldTrailDensity = 7, worldPins = false, arrow = false }, ui = { scale = 1.4 } } }');
	assert.equal(out.db.enabled, false);
	assert.equal(out.db.color, 'gold');
	assert.equal(out.db.groundIndoors, false);
	assert.equal(out.db.groundSight, true);
	assert.equal(out.custom, true);
	assert.equal(out.map, 7);
	assert.equal(out.pins, false);
	assert.equal(out.arrow, false);
	assert.equal(out.ui, 1.4);
});

test('native slash commands open groundtrail, change only master, and speak only when requested', () => {
	const [out] = run(`
		local pages = {}
		Polestar.On("SHOW_OPTIONS", function(page) pages[#pages+1] = page end)
		assert(#stub.messages == 0)
		SlashCmdList.POLESTAR("trail")
		assert(#stub.messages == 0, "opening options is silent")
		SlashCmdList.POLESTAR("trail on")
		assert(W.db.enabled == true, "native command updates runtime immediately")
		SlashCmdList.POLESTAR("trail off")
		assert(W.db.enabled == false)
		SlashCmdList.POLESTAR("trail status")
		emit({ pages = pages, messages = stub.messages, map = Polestar.Get("nav.minimapTrail") })`,
		'PolestarDB = { settings = { nav = { minimapTrail = false } } }');
	assert.deepEqual(out.pages, ['groundtrail']);
	assert.deepEqual(out.messages, [
		'|cff4fd1c5Polestar|r: World trail: on',
		'|cff4fd1c5Polestar|r: World trail: off',
		'|cff4fd1c5Polestar|r: World trail: off',
	]);
	assert.equal(out.map, false);
});

test('native change bus refreshes exact trail keys and section resets, not separate map controls', () => {
	const [out] = run(`
		local rebuilds = 0
		-- Observe the renderer boundary only; all settings/lifecycle/bus code is real.
		W.Render = { Rebuild = function() rebuilds = rebuilds + 1 end }
		for key, setting in pairs(W.SETTINGS) do
			local value = W.DEFAULTS[key]
			if type(value) == "number" then value = value + 0.1
			elseif type(value) == "boolean" then value = not value
			else value = "rose" end
			local before = rebuilds
			Polestar.Set("nav." .. setting, value)
			assert(rebuilds == before + 1, setting .. " triggers one rebuild")
			assert(W.db[key] == W.Settings()[key], setting .. " refreshes runtime")
		end
		local before = rebuilds
		for _, path in ipairs({ "nav.worldTrailDensity", "nav.minimapTrail", "nav.worldPins",
			"ui.scale", "nav.worldTrailUnknown", "nav.worldTrailCustomLook" }) do
			Polestar.Set(path, {})
		end
		assert(rebuilds == before, "unrelated paths do not rebuild")
		W.ApplyPreset("fel")
		assert(rebuilds == before + 1, "preset rebuild is batched")
		W.Reset()
		assert(rebuilds == before + 2 and not W.db.enabled, "reset rebuilds once and disables")
		Polestar.Set("nav.worldTrail", true)
		Polestar.ResetSettings("nav")
		assert(not W.db.enabled, "nav reset refreshes the default off")
		Polestar.Set("nav.worldTrail", true)
		Polestar.ResetSettings()
		assert(not W.db.enabled, "whole settings reset refreshes the default off")
		W.Refresh()
		emit({ ok = true, messages = #stub.messages })`);
	assert.deepEqual(out, { ok: true, messages: 0 });
});

test('fresh install defaults off through native settings and initialization', () => {
	const [out] = run('emit({ master = Polestar.Get("nav.worldTrail"), db = W.db, settings = W.Settings(), messages = #stub.messages })');
	assert.equal(out.master, false);
	assert.equal(out.db.enabled, false);
	assert.deepEqual(out.db, out.settings);
	assert.equal(out.messages, 0);
	assert.deepEqual(out.db, {
		enabled: false, intensity: 0.75, density: 5, subtlety: 0.35, size: 14,
		speed: 0.5, maxSparkles: 200, color: 'gold', minimap: false, worldmap: false,
		wholeRoute: false, ground: true, groundMode: 'camera', groundLength: 30,
		groundFade: 1, groundIndoors: false, groundLift: 0, groundGap: 1.7,
		groundWidth: 1, groundAhead: 3, groundSight: true, groundStart: 0.4,
	});
});

test('upgrade defaults off without touching existing map or unrelated settings', () => {
	const [out] = run('emit({ enabled = W.db.enabled, saved = PolestarDB.settings })',
		'PolestarDB = { schema = 1, settings = { nav = { minimapTrail = false, worldTrailDensity = 9, worldPins = true }, ui = { scale = 1.3 } } }');
	assert.equal(out.enabled, false);
	assert.deepEqual(out.saved, { nav: { minimapTrail: false, worldTrailDensity: 9, worldPins: true }, ui: { scale: 1.3 } });
});

test('existing false booleans and valid custom numbers survive initialization', () => {
	const [out] = run('emit({ db = W.db, saved = PolestarDB.settings })',
		'PolestarDB = { settings = { nav = { worldTrail = false, worldTrailSight = false, worldTrailIndoors = false, worldTrailIntensity = 0, worldTrailSize = 28, worldTrailFlow = 0.6, worldTrailLength = 75, worldTrailCustomLook = { size = 22 }, minimapTrail = false } } }');
	assert.equal(out.db.enabled, false);
	assert.equal(out.db.groundSight, false);
	assert.equal(out.db.groundIndoors, false);
	assert.equal(out.db.intensity, 0);
	assert.equal(out.db.size, 28);
	assert.equal(out.db.speed, 0.6);
	assert.equal(out.db.groundLength, 75);
	assert.deepEqual(out.saved.nav.worldTrailCustomLook, { size: 22 });
	assert.equal(out.saved.nav.minimapTrail, false);
});
