'use strict';
// Eating and drinking (addon/Polestar_Recorder/World.lua): a Food or Drink
// aura becomes a `rest` record when it ends (docs/RECORDING.md). In restricted
// contexts the client passes UNIT_AURA secret values, which can't be tested.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function rests(script) {
	const { emitted: [out] } = runAddon({
		stubs: ['stub_recorder.lua'],
		addons: ['Polestar_Recorder'],
		saved: { Polestar_Recorder: 'PolestarRecorderDB = { schema = 2, enabled = true }' },
		login: true,
		script: `
		stub.world.spells[433], stub.world.spells[430] = "Food", "Drink"
		local function aura(info) stub.fire("UNIT_AURA", "player", info) end
		local ok, err = pcall(function() ${script} end)
		stub.fire("PLAYER_LOGOUT")
		local out = {}
		for _, chunk in pairs(PolestarRecorderDB.chunks) do
			for _, r in ipairs(stub.records(chunk)) do
				if r[1] == "rest" then out[#out + 1] = { r[3], tonumber(r[4]) } end
			end
		end
		emit({ ok = ok, err = err and tostring(err), rests = out })`,
	});
	return out;
}

test('a rest is recorded once, when its aura goes', () => {
	const out = rests(`
		stub.world.auras = { { auraInstanceID = 7, name = "Food" } }
		aura({ addedAuras = { { auraInstanceID = 7, name = "Food" } } })
		stub.advance(20)
		stub.world.auras = {}
		aura({ removedAuraInstanceIDs = { 7 } })`);
	assert.deepEqual(out, { ok: true, rests: [['f', 20]] });
});

// The stub can't make a boolean test on a secret error, as the client does; a
// handler that tests isFullUpdate would rescan here and end the rest at 10 s.
test('a secret isFullUpdate is not acted on', () => {
	const out = rests(`
		stub.world.auras = { { auraInstanceID = 7, name = "Food" } }
		aura({ addedAuras = { { auraInstanceID = 7, name = "Food" } } })
		stub.advance(10)
		stub.world.auras = {}
		aura({ isFullUpdate = stub.secret() })
		stub.advance(10)
		aura({ removedAuraInstanceIDs = { 7 } })`);
	assert.deepEqual(out, { ok: true, rests: [['f', 20]] });
});

test('secret aura updates neither end a rest early nor break the handler', () => {
	const out = rests(`
		stub.world.auras = { { auraInstanceID = 7, name = "Food" } }
		aura({ addedAuras = { { auraInstanceID = 7, name = "Food" } } })
		stub.advance(10)
		stub.world.auras = { { auraInstanceID = stub.secret(), name = stub.secret() } }
		aura({ isFullUpdate = stub.secret() })
		aura({ isFullUpdate = true })
		aura({ removedAuraInstanceIDs = { stub.secret() } })
		stub.advance(10)
		stub.world.auras = {}
		aura({ removedAuraInstanceIDs = { 7 } })`);
	assert.deepEqual(out, { ok: true, rests: [['f', 20]] });
});
