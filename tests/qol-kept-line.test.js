'use strict';
// A kept item's tooltip line names the step that needs it (its title when it
// has one) and the guide, in the accent colour, and after "Don't sell: " in
// the warning colour while a merchant is open.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };

test('kept line: step title and guide name, step number without a title, merchant warning', () => {
	const out = runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], login: true, script: `
		local QoL, q = Polestar.QoL, stub.qol
		q.engine.guide = { id = "duskwood", title = "Duskwood", steps = {
			[3] = { goals = {} },
			[4] = { title = "Look To The Stars", goals = {} },
		} }
		q.engine.kept = { [4371] = 3, [772] = 4 }
		emit({ QoL.KeptLine(4371) })
		emit({ QoL.KeptLine(772) })
		emit(QoL.KeptLine(999) or false)
		q.openMerchant()
		emit({ QoL.KeptLine(4371) })
		emit({ QoL.KeptLine(772) })
		q.closeMerchant()
		q.engine.guide.title = nil
		emit({ QoL.KeptLine(4371) })
	` }).emitted;
	assert.equal(out[0][0], 'Used in step 3 in Duskwood');
	assert.equal(out[1][0], 'Used in step 4 (Look To The Stars) in Duskwood');
	assert.equal(out[2], false);
	assert.equal(out[3][0], "Don't sell: used in step 3 in Duskwood");
	assert.equal(out[4][0], "Don't sell: used in step 4 (Look To The Stars) in Duskwood");
	assert.notDeepEqual(out[1].slice(1), out[4].slice(1));
	assert.equal(out[5][0], 'Used in step 3 in duskwood');
});
