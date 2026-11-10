'use strict';
// A grey item that begins a quest, or one a quest needs, is never deleted for bag space or sold as
// junk (#1557: Noboru's Cudgel, a grey quest starter, was deleted and its quest with it).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };

// A full backpack: a grey quest starter and a grey quest item, both cheaper than the plain grey.
const BAGS = `
	local q = stub.qol
	q.bags[0].size = 3
	q.items[901] = { name = "Starter", quality = 0, price = 1, questID = 7 }
	q.items[902] = { name = "Quest Bit", quality = 0, price = 2, questItem = true }
	q.items[903] = { name = "Broken Fang", quality = 0, price = 50 }
	q.addItem(0, 1, 901)
	q.addItem(0, 2, 902)
	q.addItem(0, 3, 903)
`;

test('bag space: the delete skips a quest starter and a quest item, cheaper or not', () => {
	const out = runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], login: true, script: BAGS + `
		local Space = Polestar.QoL.Space
		Space.Refresh()
		local j = Space.Junk()
		emit(j and j.id or false)
		emit({ Space.Press(), Space.Press() })
		stub.advance(0.1)
		emit(q.deleted or {})
	` }).emitted;
	assert.deepEqual(out, [903, ['armed', 'deleted'], [903]]);
});

test('merchant: selling junk skips a quest starter and a quest item', () => {
	const out = runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], login: true, script: BAGS + `
		q.openMerchant()
		stub.advance(2)
		emit(q.sold or {})
	` }).emitted;
	assert.deepEqual(out, [[903]]);
});
