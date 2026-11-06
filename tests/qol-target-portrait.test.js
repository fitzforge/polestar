'use strict';
// The target and rare buttons show the face of the mob they target while it
// is close (the target or on a nameplate), and the crosshair otherwise.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };

function run(script) {
	return runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], login: true,
		script: `local q = stub.qol
		local icon = PolestarTargetButton.Icon
		local function show() stub.runTimers(); emit({ icon:GetTexture(), icon.vertexColor and icon.vertexColor[1] }) end
		${script}` }).emitted;
}

test('target portrait: the crosshair until a named mob is close, its face while it is, the crosshair once it goes', () => {
	const out = run(`
		q.step({ { t = "kill", target = "Wolf" }, { t = "kill", target = "Boar" } })
		show()
		q.units.nameplate3 = { name = "Boar" }
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate3")
		show()
		q.units.nameplate1 = { name = "Wolf" }
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		show()
		q.units.nameplate1 = nil
		stub.fire("NAME_PLATE_UNIT_REMOVED", "nameplate1")
		q.units.nameplate3 = nil
		stub.fire("NAME_PLATE_UNIT_REMOVED", "nameplate3")
		show()
	`);
	const crosshair = out[0][0];
	assert.match(crosshair, /qol-target/);
	assert.notEqual(out[0][1], 1, 'the crosshair keeps its tint');
	assert.deepEqual(out[1], ['portrait:Boar', 1], 'any name on the button counts');
	assert.deepEqual(out[2], ['portrait:Wolf', 1], 'the name the next click targets first wins');
	assert.equal(out[3][0], crosshair);
	assert.notEqual(out[3][1], 1);
});

test('target portrait: the current target counts; dead mobs, other names and unreadable names do not', () => {
	const out = run(`
		q.step({ { t = "kill", target = "Wolf" } })
		q.target = { name = "Wolf", hostile = true, dead = true }
		stub.fire("PLAYER_TARGET_CHANGED")
		show()
		q.target = { name = "Bear", hostile = true }
		stub.fire("PLAYER_TARGET_CHANGED")
		show()
		q.target = { name = "Wolf", hostile = true }
		stub.fire("PLAYER_TARGET_CHANGED")
		show()
		-- In combat the client may hide names: the face stays until it can read again.
		local SECRET = {}
		issecretvalue = function(v) return v == SECRET end
		q.target = { name = SECRET, hostile = true }
		stub.fire("PLAYER_TARGET_CHANGED")
		show()
	`);
	assert.match(out[0][0], /qol-target/);
	assert.match(out[1][0], /qol-target/);
	assert.deepEqual(out[2], ['portrait:Wolf', 1]);
	assert.deepEqual(out[3], ['portrait:Wolf', 1]);
});

test('target portrait: a new step without the mob puts the crosshair back', () => {
	const out = run(`
		q.step({ { t = "kill", target = "Wolf" } })
		q.target = { name = "Wolf", hostile = true }
		stub.fire("PLAYER_TARGET_CHANGED")
		show()
		q.step({ { t = "kill", target = "Boar" } })
		show()
	`);
	assert.deepEqual(out[0], ['portrait:Wolf', 1]);
	assert.match(out[1][0], /qol-target/);
});
