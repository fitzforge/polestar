'use strict';
// /psrec trail (addon/Polestar_Recorder/Trail.lua): a dense position trail
// sampled at 4 Hz, stored after 1 yd of movement (height included), a map
// change or 2 s, between trail_start and trail_stop events; then through
// `record import` and out of `record trail`.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { tmpdir } = require('./helpers/tmp');
const { quiet } = require('./helpers/cli');
const { importFile } = require('../tools/lib/recording/import');
const record = require('../tools/commands/record');

// Elwynn Forest (1429) in stub_recorder.lua is 5200 yd wide: 1 yd = 100/5200 %.
const YD = 100 / 5200;

test('trail on records a sample per yard moved, height change, map change or 2 s, until trail off, recorder off or 30 min', () => {
	const { emitted: [out] } = runAddon({
		stubs: ['stub_recorder.lua'],
		addons: ['Polestar_Recorder'],
		login: true,
		script: `
		local cmd = SlashCmdList.POLESTARREC
		local function S() return PolestarRecorderDB.sessions[PolestarRecorderDB.current] end
		local function trail()
			local out = {}
			for _, e in ipairs(S().events) do
				if e.e == "trail" or e.e == "trail_start" or e.e == "trail_stop" then out[#out + 1] = e end
			end
			return out
		end
		cmd("off")
		stub.messages = {}
		cmd("trail on refused")
		local refused = { msg = stub.messages[1], n = #trail() }
		cmd("on")
		stub.moveTo(50, 50)
		stub.world.facing, stub.world.speed, stub.world.z = 1.5708, 7, 10
		stub.messages = {}
		cmd("trail on Brill test")           -- trail_start + a first sample
		stub.advance(0.3)                    -- not moved: nothing
		stub.moveTo(50 + 0.5 * ${YD}, 50)
		stub.advance(0.3)                    -- 0.5 yd: nothing
		stub.moveTo(50 + 2 * ${YD}, 50)
		stub.advance(0.3)                    -- 2 yd: a sample
		stub.world.z = 11.5
		stub.advance(0.3)                    -- 1.5 yd up (a lift): a sample
		stub.advance(2.4)                    -- standing still: one sample after 2 s
		stub.world.mounted, stub.world.indoors, stub.world.speed = true, true, 14
		stub.moveTo(50, 50, 1453)
		stub.advance(0.3)                    -- another map: a sample
		cmd("trail on again")                -- already running
		cmd("trail off")
		stub.advance(5)                      -- stopped: nothing more
		cmd("trail off")
		local first = trail()
		cmd("trail on second")
		cmd("off")                           -- the recorder off ends the trail
		local afterOff = { stop = trail()[#trail()], messages = stub.messages }
		cmd("on")
		cmd("trail on long")
		stub.advance(30 * 60 + 1)
		local all = trail()
		emit({ refused = refused, first = first, afterOff = afterOff, last = all[#all], lastMsg = stub.messages[#stub.messages] })`,
	});

	assert.match(out.refused.msg, /recording is off; \/psrec on first/);
	assert.equal(out.refused.n, 0);

	const evs = out.first;
	assert.deepEqual(evs.map((e) => e.e), ['trail_start', 'trail', 'trail', 'trail', 'trail', 'trail', 'trail_stop']);
	assert.equal(evs[0].label, 'Brill test');
	const pts = evs.slice(1, -1);
	assert.deepEqual(pts.map((p) => p.map), [1429, 1429, 1429, 1429, 1453]);
	assert.deepEqual(pts.map((p) => p.wz), [10, 10, 11.5, 11.5, 11.5]);
	assert.equal(pts[0].x, 50);
	assert.equal(pts[1].x, Math.round((50 + 2 * YD) * 1e4) / 1e4, 'x keeps 4 decimals');
	for (const p of pts) {
		assert.equal(typeof p.wx, 'number');
		assert.equal(typeof p.wy, 'number');
	}
	assert.ok(pts[3].t - pts[2].t >= 2, 'the still sample comes after the 2 s gap');
	assert.equal(pts[0].facing, 1.571);
	assert.equal(pts[0].speed, 7);
	assert.equal(pts[0].mounted, undefined, 'false flags are not stored');
	assert.deepEqual([pts[4].mounted, pts[4].indoors, pts[4].speed, pts[4].swimming], [true, true, 14, undefined]);
	assert.deepEqual({ label: evs[6].label, n: evs[6].n, reason: evs[6].reason }, { label: 'Brill test', n: 5, reason: 'off' });

	const msgs = out.afterOff.messages.join('\n');
	assert.match(msgs, /trail on: Brill test \(stops by itself after 30 min/);
	assert.match(msgs, /trail already on: Brill test/);
	assert.match(msgs, /trail off: Brill test, 5 points/);
	assert.match(msgs, /no trail running/);
	assert.equal(out.afterOff.stop.reason, 'recording off');
	assert.equal(out.afterOff.stop.label, 'second');

	assert.equal(out.last.e, 'trail_stop');
	assert.equal(out.last.reason, 'timeout');
	assert.match(out.lastMsg, /trail stopped after 30 min: long, \d+ points/);
});

test('record import carries trails through, and record trail writes them as labelled point lists', async () => {
	const sv = runAddon({
		stubs: ['stub_recorder.lua'],
		addons: ['Polestar_Recorder'],
		login: true,
		script: `
		SlashCmdList.POLESTARREC("on")
		stub.moveTo(40, 40)
		stub.world.z, stub.world.facing, stub.world.speed = 5, 0.5, 7
		SlashCmdList.POLESTARREC("trail on Brill to the Magic Quarter")
		stub.moveTo(40 + 3 * ${YD}, 40)
		stub.world.falling = true
		stub.advance(0.3)
		stub.fire("PLAYER_LOGOUT")
		emit(stub.serialize(PolestarRecorderDB))`,
	}).emitted[0];
	const dir = tmpdir('polestar-trail-');
	const svFile = path.join(dir, 'WTF', 'Account', 'TEST', 'SavedVariables', 'Polestar_Recorder.lua');
	fs.mkdirSync(path.dirname(svFile), { recursive: true });
	fs.writeFileSync(svFile, `PolestarRecorderDB = ${sv}\n`);
	const [imported] = importFile(svFile, { outDir: path.join(dir, 'recordings') }).sessions;
	const raw = imported.session.events.filter((e) => e.e.startsWith('trail'));
	assert.deepEqual(raw.map((e) => e.e), ['trail_start', 'trail', 'trail', 'trail_stop']);
	assert.equal(raw[2].falling, true, 'flags survive the import');

	const out = path.join(dir, 'trails.json');
	const run = await quiet(() => record.run(['trail', imported.file, '--out', out]));
	assert.equal(run.result, 0, run.out);
	assert.match(run.out, /1 trail\(s\), 2 points/);
	const trails = JSON.parse(fs.readFileSync(out, 'utf8'));
	assert.equal(trails.length, 1);
	assert.equal(trails[0].label, 'Brill to the Magic Quarter');
	assert.equal(trails[0].reason, 'logout');
	assert.deepEqual(Object.keys(trails[0].points[0]), ['t', 'map', 'x', 'y', 'wx', 'wy', 'wz', 'facing', 'speed', 'mounted', 'swimming', 'falling', 'indoors', 'onTaxi']);
	assert.deepEqual(trails[0].points.map((p) => [p.map, p.x, p.wz, p.falling]), [
		[1429, 40, 5, false],
		[1429, Math.round((40 + 3 * YD) * 1e4) / 1e4, 5, true],
	]);
});
