'use strict';
// A class guide's own spells in its texts (docs/GUIDE_FORMAT.md, "Names in
// texts"): a spell of the guide's class is its token even where an NPC,
// object or item has its name ("Cold Snap" is the Mage talent in a Mage
// guide, not the staff), still behind the guide's own names and still words
// where a one-word spell owns something; every other guide reads the name as
// before. (rust/crates/forge-guide/tests/guide/class_spell_tokens.rs is the
// Rust side.)

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { tmpdir } = require('./helpers/tmp');
const { compile, fixtureData } = require('./helpers/dsl');
const { Data } = require('../tools/lib/dsl/data');

// The fixture data with the Forever client's names for Cold Snap (item
// 19130), Ice Block (object 181247) and Frostbite (item 19103), and the
// client's spell tables of build 1.60.1.70862 beside it: the Mage's Cold
// Snap (12472), Ice Block (11958) and Frostbite (11071, its proc 12494),
// ClassMask 128.
function classData() {
	const root = tmpdir('polestar-class-spells-');
	const wago = path.join(root, 'sources', 'wago', '1.60.1.70862');
	fs.mkdirSync(wago, { recursive: true });
	fs.writeFileSync(path.join(wago, 'SpellName.csv'), 'ID,Name_lang\n11071,Frostbite\n11958,"Ice Block"\n12472,"Cold Snap"\n12494,Frostbite\n');
	fs.writeFileSync(path.join(wago, 'SkillLineAbility.csv'), 'ID,SkillLine,Spell,ClassMask\n6356,6,11958,128\n6742,6,12472,128\n6760,6,11071,128\n');
	const base = fixtureData();
	const meta = { ...base.meta, sources: [...base.meta.sources, { name: 'World of Warcraft: Forever client tables (SpellName) via wago.tools', revision: 'wow_classic_beta 1.60.1.70862' }] };
	const items = { ...base.items, 19103: { id: 19103, name: 'Frostbite', drops: { npc: {}, object: {} }, vendors: [] }, 19130: { id: 19130, name: 'Cold Snap', drops: { npc: {}, object: {} }, vendors: [] } };
	const objects = { ...base.objects, 181247: { id: 181247, name: 'Ice Block', spawns: {} } };
	return new Data({ quests: base.quests, npcs: base.npcs, objects, items, zones: base.zones, 'map-frames': base.mapFrames, meta }, { dir: path.join(root, 'forever') });
}

const guide = (id, header) =>
	[`guide t/${id}`, 'title Test', 'category Class', ...header, 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', '', 'step Level 46: Cold Snap', "  tip Cold Snap resets Ice Block, and Frostbite roots the target. Frostbite's chance grows.", '  accept 7', ''].join('\n');

test("a class guide's own spells are their tokens where an NPC, object or item has the name too; other guides read them as before", () => {
	const leveling = guide('leveling', ['class Mage']).replace('category Class', 'category Leveling').replace("Frostbite's chance grows.", 'Your Frostbite procs more often.');
	const r = compile({ 'mage.guide': guide('mage', ['class Mage']), 'notwarrior.guide': guide('notwarrior', ['class !Warrior']), 'warrior.guide': guide('warrior', ['class Warrior']), 'none.guide': guide('none', []), 'staff.guide': guide('staff', ['class Mage', 'reward item 19130']), 'leveling.guide': leveling }, classData());
	assert.deepEqual(r.errors, []);
	const step = (id) => {
		const s = r.guides.find((g) => g.id === `t/${id}`)._localised.steps[0];
		return [s.title, s.note];
	};
	assert.deepEqual(step('mage'), ['Level 46: {spell:12472}', "{spell:12472} resets {spell:11958}, and {spell:11071} roots the target. Frostbite's chance grows."]);
	// Every class but the Warrior: the Mage's too.
	assert.deepEqual(step('notwarrior'), step('mage'));
	const before = ['Level 46: {item:19130}', "{item:19130} resets {object:181247}, and Frostbite roots the target. Frostbite's chance grows."];
	assert.deepEqual(step('warrior'), before);
	assert.deepEqual(step('none'), before);
	// The guide's own names come first: its reward is the staff.
	assert.deepEqual(step('staff'), ['Level 46: {item:19130}', "{item:19130} resets {spell:11958}, and {spell:11071} roots the target. Frostbite's chance grows."]);
	// Outside a Class guide a one-word one only after "cast" or "your".
	assert.deepEqual(step('leveling'), ['Level 46: {spell:12472}', '{spell:12472} resets {spell:11958}, and Frostbite roots the target. Your {spell:11071} procs more often.']);
});
