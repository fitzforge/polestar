'use strict';
// The leveling guides under guides/forever/{horde,alliance} are written by
// Polestar Forge (`forge build`, then `forge guide publish`) and listed with
// their SHA-256 in guides/GENERATED.json; the seed Forge starts from is
// forge/seed/guides, listed in forge/seed/SEED.json. A hand edit to either is
// undone by the next build, so it fails here, saying where the fix goes.
// Before the cutover neither manifest exists and the test is skipped.
// The same check: `forge guide check-generated` (rust/crates/forge/src/generated.rs).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');

const root = path.join(__dirname, '..');
const manifests = [
	{ file: 'guides/GENERATED.json', base: 'guides' },
	{ file: 'forge/seed/SEED.json', base: 'forge/seed/guides' },
].filter((m) => fs.existsSync(path.join(root, m.file)));

const WHERE = `Put the fix where every build applies it:
  - a quest fact (giver, turn-in, prerequisite, objective, XP, races), an NPC's or object's place
    or rank, a wrong drop: forever-db/corrections (quests.json, npcs.json, objects.json, items.json)
  - how a quest is done (an item from a chest, a delayed offer, an object to click):
    forever-db/corrections/mechanics.json
  - whether the route takes a quest, or an order players asked for: data/route-fixes.json
  - the check that pins the fix: tests/guides-reported.test.js
A step's wording, tip or arrow point has no record file yet: describe the fix on the issue and the
maintainer applies it. docs/FORGE.md, "Fixing a generated guide", has the details.`;

/** Files of a manifest whose bytes no longer match, as "<path>: edited" or "<path>: missing". */
function edited(m) {
	const { files } = JSON.parse(fs.readFileSync(path.join(root, m.file), 'utf8'));
	const out = [];
	for (const [rel, sha] of Object.entries(files || {})) {
		const f = path.join(root, m.base, rel);
		if (!fs.existsSync(f)) out.push(`${m.base}/${rel}: missing`);
		else if (crypto.createHash('sha256').update(fs.readFileSync(f)).digest('hex') !== sha) out.push(`${m.base}/${rel}: edited`);
	}
	return out;
}

test('generated guides and the seed are not edited by hand', { skip: manifests.length === 0 && 'no guides/GENERATED.json or forge/seed/SEED.json (before the Forge cutover)' }, () => {
	const bad = manifests.flatMap(edited);
	assert.deepEqual(bad, [], `These files are written by forge build, which would undo the edit:\n  ${bad.join('\n  ')}\n${WHERE}`);
});
