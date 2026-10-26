'use strict';
// The Recorder window (addon/Polestar_Recorder/Panel.lua) against
// tests/lua/stub_recorder.lua: the label comes from the next spot of the
// player's faction's tour, Start/Stop records a trail, and the stop ticks the
// spot in PolestarRecorderDB.spots and moves the label to the next spot.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('the window\'s Start/Stop records a trail with the next spot\'s label and ticks that spot', () => {
	const { emitted: [out] } = runAddon({
		stubs: ['stub_recorder.lua'],
		addons: ['Polestar_Recorder'],
		login: true,
		script: `
		local cmd = PolestarRecorder_Command
		stub.world.level = 30
		cmd("on")
		cmd("ui")
		local F = PolestarRecorderPanel
		local label = F.Label:GetText()
		local rows = {}
		for i, r in ipairs(F.Rows) do if r.spot then rows[i] = r.spot.id end end
		stub.moveTo(40, 40)
		F.Start:Click()
		local running = F.Start.text or (F.Start.Label and F.Start.Label:GetText())
		stub.moveTo(40.2, 40)
		stub.advance(0.6)
		F.Start:Click()
		local evs = {}
		for _, e in ipairs(PolestarRecorderDB.sessions[PolestarRecorderDB.current].events) do
			if e.e == "trail_start" or e.e == "trail_stop" then evs[#evs + 1] = { e = e.e, label = e.label, n = e.n, yd = e.yd } end
		end
		emit({
			label = label, rows = rows, running = running, evs = evs,
			ticked = PolestarRecorderDB.spots and PolestarRecorderDB.spots[11], next = F.Label:GetText(),
			trail = F.Trails[1]:GetText(), head = F.SpotsHead:GetText(),
			check = F.Rows[1].Check:IsShown(),
		})`,
	});
	// stub_recorder's player is Alliance: the Alliance tour starts at #11.
	assert.match(out.label, /^#11 /);
	assert.deepEqual(out.rows.slice(0, 2), [11, 20], "the Alliance tour order");
	assert.equal(out.running, 'Stop trail');
	assert.deepEqual(out.evs.map((e) => [e.e, e.label]), [['trail_start', out.label], ['trail_stop', out.label]]);
	assert.ok(out.evs[1].n >= 2 && out.evs[1].yd > 5, JSON.stringify(out.evs[1]));
	assert.equal(typeof out.ticked, 'number', 'spot 11 ticked');
	assert.match(out.next, /^#20 /, 'the label moves on to the next spot');
	assert.ok(out.trail.startsWith(`${out.label}: `), out.trail);
	assert.match(out.head, /1\/\d+$/);
	assert.equal(out.check, true);
});

test('with Polestar loaded the window is drawn in Polestar\'s theme and works the same', () => {
	const { emitted: [out] } = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Recorder'],
		login: true,
		script: `
		PolestarRecorder_Command("on")
		PolestarRecorder_Command("ui")
		local F = PolestarRecorderPanel
		F.Start:Click()
		stub.advance(1)
		local running = F.Start.Label:GetText()
		PolestarRecorder_Command("trail toggle") -- the key binding
		emit({ shown = F:IsShown(), polestarButton = F.Start.Label ~= nil, running = running, after = F.Start.Label:GetText(), trails = #F.Trails, first = F.Trails[1]:GetText() })`,
	});
	assert.deepEqual({ ...out, first: undefined }, { shown: true, polestarButton: true, running: 'Stop trail', after: 'Start trail', trails: 4, first: undefined });
	assert.match(out.first, /: \d+ points, 0:01, \d+ yd$/);
});
