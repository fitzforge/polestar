'use strict';
// An item's tooltip lists the guides whose steps use it: the active guide with
// its step (title when it has one), then the guides ahead with their levels,
// under "Used in guides:" in the accent colour, or "Don't sell, used in
// guides:" in the warning colour while a merchant is open.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };

const SCRIPT = `
	local QoL, q = Polestar.QoL, stub.qol
	local function pack(b) if not b then return false end
		local t = { header = b.header, lines = {} }
		for i, l in ipairs(b.lines) do t.lines[i] = l end
		return t end
	local duskwood = { id = "duskwood", title = "Duskwood", minLevel = 12, maxLevel = 13, steps = {
		[3] = { goals = {} },
		[4] = { title = "Look To The Stars", goals = {} },
		[5] = { title = "Buy the following items for faster turn ins at Westfall shortly:", goals = {} },
	} }
	local westfall = { id = "westfall", title = "Westfall", minLevel = 13, maxLevel = 15, steps = {} }
	local solo = { id = "solo", title = "Solo", minLevel = 20, maxLevel = 20, steps = {} }
	q.engine.itemGuides = {
		[4371] = { { guide = duskwood, step = 3 }, { guide = westfall } },
		[772] = { { guide = duskwood, step = 4 } },
		[773] = { { guide = duskwood, step = 5 } },
		[555] = { { guide = westfall }, { guide = solo } },
	}
	emit(pack(QoL.KeptLines(4371)))
	emit(pack(QoL.KeptLines(772)))
	emit(pack(QoL.KeptLines(555)))
	emit(pack(QoL.KeptLines(999)))
	emit(pack(QoL.KeptLines(773)))
	q.openMerchant()
	emit(pack(QoL.KeptLines(772)))
	q.closeMerchant()
`;

test('tooltip block: active guide with step, upcoming guides, unknown item, merchant header', () => {
	const out = runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], login: true, script: SCRIPT }).emitted;
	const text = (b) => b.lines.map((l) => l[0]);
	assert.equal(out[0].header[0], 'Used in guides:');
	assert.deepEqual(text(out[0]), ['12-13 Duskwood: step 3', '13-15 Westfall']);
	assert.deepEqual(text(out[1]), ['12-13 Duskwood: step 4 (Look To The Stars)']);
	assert.deepEqual(text(out[2]), ['13-15 Westfall', '20 Solo'], 'an item only a later guide uses still lists');
	assert.equal(out[3], false);
	assert.deepEqual(text(out[4]), ['12-13 Duskwood: step 5 (Buy the following items for\u2026)'], 'a long step title is cut at a word within 32 characters');
	assert.equal(out[5].header[0], "Don't sell, used in guides:");
	assert.notDeepEqual(out[5].header.slice(1), out[1].header.slice(1), 'the warning colour differs from the accent');
});

test('QoL.Kept stays the active guide only: an item of a later guide is listed, not kept', () => {
	const out = runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], login: true, script: `
		local QoL, q = Polestar.QoL, stub.qol
		q.engine.kept = {}
		q.engine.itemGuides = { [555] = { { guide = { id = "w", title = "W", steps = {} } } } }
		emit({ kept = QoL.Kept(555) or false, lines = #QoL.KeptLines(555).lines })
	` }).emitted;
	assert.deepEqual(out[0], { kept: false, lines: 1 });
});
