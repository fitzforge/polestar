'use strict';
// Polestar.Codex lookups (addon/Polestar/Lookup/Codex.lua): an entry is found
// by halving its chunk's id-ordered lines, not by a find over the whole blob
// (0.3.7 perf: a guide opened or a step changed asks for hundreds). Every id a
// chunk holds is found with its name, an id between them is absent (and stays
// absent until a chunk that has it is registered), and string keys (roles)
// still resolve. Synthetic chunks in the pack's format, no data needed.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

// Sorted ids, spread with gaps, in chunks of at most `per`, like the pack's.
function chunks(ids, per) {
	const out = [];
	for (let i = 0; i < ids.length; i += per) out.push(ids.slice(i, i + per));
	return out;
}
const blob = (ids) => ids.map((id) => `\n${id}\t\tZone ${id}`).join('');

test('Codex: every id of id-ordered chunks is found by halving, the ones between are absent', () => {
	const ids = [];
	let id = 1;
	for (let i = 0; i < 3000; i++) {
		ids.push(id);
		id += 1 + ((i * 7919) % 13);
	}
	const held = new Set(ids);
	const parts = chunks(ids, 700);
	const register = parts.map((c) => `C.Register("zone", ${JSON.stringify(blob(c))}, nil, ${c[0]}, ${c[c.length - 1]})`).join('\n');
	const gaps = [];
	for (let k = 0; k <= id + 5; k++) if (!held.has(k)) gaps.push(k);
	const [r] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Lookup/Codex.lua'] }],
		script: `
local C = Polestar.Codex
C.Register("meta", { sources = {} })
${register}
C.Register("role", "\\ntrainer\\t\\t12,40\\nvendor\\t\\t7")
local ids, gaps = ${JSON.stringify(`{${ids.join(',')}}`)}, ${JSON.stringify(`{${gaps.join(',')}}`)}
ids, gaps = loadstring("return " .. ids)(), loadstring("return " .. gaps)()
local wrong, found = {}, 0
for _, i in ipairs(ids) do
	local z = C.Zone(i)
	if z and z.id == i and z.name == "Zone " .. i and C.Name("zone", i) == z.name then found = found + 1
	else wrong[#wrong + 1] = i end
end
local present = {}
for _, i in ipairs(gaps) do
	if C.Zone(i) or C.Name("zone", i) then present[#present + 1] = i end
end
local again = C.Zone(gaps[2]) == nil
C.Register("zone", "\\n" .. gaps[2] .. "\\t\\tLate Zone", nil, gaps[2], gaps[2])
local late = C.Zone(gaps[2])
emit({ found = found, wrong = table.concat(wrong, ","), present = table.concat(present, ","), again = again, late = late and late.name or false,
	trainer = table.concat(C.WithRole("trainer"), ","), vendor = table.concat(C.WithRole("vendor"), ","), none = #C.WithRole("banker") })`,
	}).emitted;
	assert.equal(r.found, ids.length, `ids not found or wrong: ${r.wrong.slice(0, 200)}`);
	assert.equal(r.present, '', 'ids no chunk holds are absent');
	assert.ok(r.again, 'an absent id stays absent when asked again');
	assert.equal(r.late, 'Late Zone', 'a chunk registered later is found (the remembered absence goes)');
	assert.deepEqual([r.trainer, r.vendor, r.none], ['12,40', '7', 0], 'string keys (roles) resolve');
});
