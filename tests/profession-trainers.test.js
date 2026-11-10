'use strict';
// Forge's curated profession trainer table (forge-data's professions/trainers.rs)
// checked against Forever's NPCs in forever-db. `train <Profession>` sends the
// arrow to the nearest name on the list, so one wrong name sends a player to
// an NPC who teaches nothing (#1536: Sinda, a leather armor merchant in
// Dolanaar, was listed for Tailoring).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const ROOT = path.join(__dirname, '..');
const TRAINERS = path.join(ROOT, 'rust', 'crates', 'forge-data', 'src', 'professions', 'trainers.rs');
const DB = path.join(ROOT, 'forever-db', 'data');

const jsonl = (name) =>
	fs
		.readFileSync(path.join(DB, `${name}.jsonl`), 'utf8')
		.split('\n')
		.filter(Boolean)
		.map((l) => JSON.parse(l));

// Every NPC name a profession's entry lists, in any group (train, novice,
// expert, artisan), read from the Rust source.
function curatedNames(profession) {
	const src = fs.readFileSync(TRAINERS, 'utf8');
	const entry = src.split('\n\tCurated {').find((b) => b.includes(`\n\t\tname: "${profession}",`));
	assert.ok(entry, `${profession} is in trainers.rs`);
	const body = entry.slice(0, entry.indexOf('\n\t\tmain:'));
	return [...new Set([...body.matchAll(/"((?:[^"\\]|\\.)*)"/g)].map((m) => m[1]).filter((n) => n !== profession))];
}

const npcs = jsonl('npc');
const byName = new Map();
for (const n of npcs) byName.set(n.name, [...(byName.get(n.name) || []), n]);

for (const [profession, title] of [
	['Tailoring', /Tailor/],
	['Leatherworking', /Leather/],
]) {
	test(`every ${profession} trainer on the curated list is a ${profession} NPC in Forever's data`, () => {
		const bad = curatedNames(profession).filter((name) => !(byName.get(name) || []).some((n) => title.test(n.subname || '')));
		assert.deepEqual(bad, [], `listed for ${profession}: ${bad.map((n) => `${n} (${(byName.get(n) || []).map((r) => r.subname).join(', ') || 'no NPC'})`).join('; ')}`);
	});
}

// Teldrassil's campfire quests send a new Night Elf to the profession's
// trainer: Camping 101: Tailoring (97950) to Trianna, Leatherworking (97946)
// to Nadyia Maneweaver. Both must be on their own profession's list.
test("the Night Elf campfire quests' trainers are on their profession's list", () => {
	const enders = jsonl('quest_end');
	const nameOf = (quest) => {
		const e = enders.find((r) => r.quest === quest && r.kind === 'npc');
		return npcs.find((n) => n.id === e.id).name;
	};
	assert.ok(curatedNames('Tailoring').includes(nameOf(97950)), `${nameOf(97950)} teaches Tailoring`);
	assert.ok(curatedNames('Leatherworking').includes(nameOf(97946)), `${nameOf(97946)} teaches Leatherworking`);
});
