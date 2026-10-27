'use strict';
// /psrec trail (addon/Polestar_Recorder/Trail.lua): a dense position trail
// sampled at 4 Hz, written after 1 yd of movement (height included), a map
// change or 2 s, as `pos` records with the trail flag (64) between a
// "trail on" and a "trail off" `mark` (docs/RECORDING.md).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

// Elwynn Forest (1429) in stub_recorder.lua is 5200 yd wide: 1 yd = 100/5200 %.
const YD = 100 / 5200;
const TRAIL = 64;

test('trail on records a sample per yard moved, height change, map change or 2 s, until trail off, recorder off or 30 min', () => {
	const { emitted: [out] } = runAddon({
		stubs: ['stub_recorder.lua'],
		addons: ['Polestar_Recorder'],
		login: true,
		script: `
		local cmd = SlashCmdList.POLESTARREC
		-- the trail's records so far: marks and trail samples, { kind, dt, fields... }
		local function trail()
			stub.fire("PLAYER_LOGOUT") -- writes the open chunk
			local seqs, out = {}, {}
			for seq in pairs(PolestarRecorderDB.chunks) do seqs[#seqs + 1] = seq end
			table.sort(seqs)
			for _, s in ipairs(seqs) do
				for _, r in ipairs(stub.records(PolestarRecorderDB.chunks[s])) do
					if r[1] == "mark" or (r[1] == "pos" and tonumber(r[6]) >= ${TRAIL}) then out[#out + 1] = r end
				end
			end
			stub.fire("PLAYER_ENTERING_WORLD", false, true) -- and goes on recording, as after a reload
			return out
		end
		cmd("off")
		stub.messages = {}
		cmd("trail on refused")
		local refused = { msg = stub.messages[1] }
		cmd("on")
		stub.moveTo(50, 50)
		stub.world.speed, stub.world.z = 7, 10
		stub.messages = {}
		cmd("trail on Brill test")           -- the mark + a first sample
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
		local messages = stub.messages
		cmd("trail on second")
		cmd("off")                           -- the recorder off ends the trail
		local all = trail()
		local afterOff = all[#all]
		cmd("on")
		stub.messages = {}
		cmd("trail on long")
		stub.advance(30 * 60 + 1)
		all = trail()
		emit({ refused = refused, first = first, messages = messages, afterOff = afterOff, last = all[#all], lastMsg = stub.messages[#stub.messages] })`,
	});

	assert.match(out.refused.msg, /recording is off; \/psrec on first/);

	const recs = out.first;
	assert.deepEqual(recs.map((r) => r[0]), ['mark', 'pos', 'pos', 'pos', 'pos', 'pos', 'mark']);
	assert.equal(recs[0][5], 'trail on: Brill test');
	const pts = recs.slice(1, -1);
	assert.deepEqual(pts.map((p) => p[2]), ['1429', '1429', '1429', '1429', '1453']);
	assert.equal(pts[0][3], '5000');
	assert.equal(pts[1][3], String(Math.round((50 + 2 * YD) * 100)), 'x in hundredths of a percent');
	assert.ok(Number(pts[3][1]) - Number(pts[2][1]) >= 20, 'the still sample comes after the 2 s gap (dt in tenths)');
	assert.equal(pts[0][5], String(TRAIL), 'no flags but the trail bit');
	assert.equal(pts[0][6], '70', 'speed in yards/s x 10');
	assert.deepEqual([pts[4][5], pts[4][6]], [String(TRAIL + 1 + 4), '140'], 'mounted and indoors');
	assert.equal(recs[6][5], 'trail off: Brill test (5 points, 4 yd, off)', '2 yd along and 1.5 up');

	const msgs = out.messages.join('\n');
	assert.match(msgs, /trail on: Brill test \(stops by itself after 30 min/);
	assert.match(msgs, /trail already on: Brill test/);
	assert.match(msgs, /trail off: Brill test, 5 points/);
	assert.match(msgs, /no trail running/);
	assert.equal(out.afterOff[5], 'trail off: second (1 points, 0 yd, recording off)');

	assert.match(out.last[5], /^trail off: long \(\d+ points, \d+ yd, timeout\)$/);
	assert.match(out.lastMsg, /trail stopped after 30 min: long, \d+ points/);
});
