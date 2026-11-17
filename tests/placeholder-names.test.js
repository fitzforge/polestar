'use strict';
// #2614: no compiled guide pack shows one of the game's internal placeholder names. Forever's quest data names
// some objectives by the invisible creature the server credits ("[DNT] Kill Credit", "Credit", the
// battlegrounds' "PvP Tower Credit Marker", Alterac Valley's "Trigger Ichman"), and 0.4.0.1's packs passed them
// straight through: No Soldier Left Behind read "Kill [DNT] Kill Credit 1/5". The data build (forge-data
// credit.rs) and the compiler (forge-guide placeholder.rs) now give those objectives the quest log's words,
// and lint fails on any left; this reads the packs that ship.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const ADDON = path.join(__dirname, '..', 'addon');

// The same list as forge-guide's placeholder.rs and Compat.Placeholder.
const TAGS = ['[DNT]', '(DNT)', '[PH]', '(DND)', '<UNUSED>', '<TEST>', 'Credit Marker', 'Kill Credit'];
function placeholder(name) {
	const s = name.trim();
	return s === 'Credit' || s.startsWith('Trigger ') || s.startsWith('DND FLAG') || TAGS.some((t) => s.includes(t));
}

// The fields of a compiled goal or step a player reads.
const SHOWN = /\b(title|target|npcName|objName|itemName|from|fromAlso|startItemName|text|note) = "((?:[^"\\]|\\.)*)"/g;

function packs() {
	return fs
		.readdirSync(ADDON)
		.filter((d) => d.startsWith('Polestar_Guides') || d === 'Polestar_Experimental')
		.map((d) => path.join(ADDON, d, 'Guides.lua'))
		.filter((f) => fs.existsSync(f));
}

test('the placeholder test reads the shipped guide packs', () => {
	const names = packs().map((f) => path.basename(path.dirname(f)));
	for (const p of ['Polestar_Guides', 'Polestar_Guides_Alliance', 'Polestar_Guides_Horde']) assert.ok(names.includes(p), p);
	assert.ok(placeholder('[DNT] Kill Credit') && placeholder('Credit') && placeholder('PvP Tower Credit Marker') && placeholder('Trigger Ichman'));
	assert.ok(!placeholder('Credit Union') && !placeholder('Mulgore Trigger') && !placeholder('Farholde Scouts rescued'));
});

test('#2614: no guide pack shows the game\'s placeholder names ("[DNT] Kill Credit", "PvP Tower Credit Marker", "Trigger Ichman")', () => {
	const found = [];
	for (const file of packs()) {
		const text = fs.readFileSync(file, 'utf8');
		for (const m of text.matchAll(SHOWN)) {
			const value = m[2].replace(/\\(.)/g, '$1');
			if (placeholder(value)) found.push(`${path.relative(ADDON, file)}: ${m[1]} = "${value}"`);
		}
	}
	assert.deepEqual(found, []);
});
