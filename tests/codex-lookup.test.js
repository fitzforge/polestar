'use strict';
// Polestar.Codex lookups (addon/Polestar/Lookup/Codex.lua): an entry is found
// by halving its chunk's id-ordered lines, not by a find over the whole blob
// (0.3.7 perf: a guide opened or a step changed asks for hundreds). Every id a
// chunk holds is found with its name, an id between them is absent (and stays
// absent until a chunk that has it is registered), and string keys (roles)
// still resolve. Synthetic chunks in the pack's format, no data needed; and,
// with the built Polestar_Codex present (local, skipped elsewhere), every id
// of every chunk of the real pack lands on the same line a plain find of
// "\n<id>\t" finds (its first), and ids next to them that no line holds on none.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ADDONS } = require('./helpers/lua');
const { localPacks } = require('./helpers/profile');

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

const codexBuilt = fs.existsSync(path.join(ADDONS, 'Polestar_Codex', 'Polestar_Codex.toc'));

test('Codex: on the real pack, every id is found at the offset a plain find gives, every gap is absent', { skip: !codexBuilt && 'Polestar_Codex not built' }, () => {
	const packs = localPacks();
	const [r] = runAddon({
		stubs: ['stub_world.lua', ...packs.stubs],
		before: packs.before,
		addons: ['Polestar'],
		script: `
stub.login()
local C = Polestar.Codex
assert(C.Load(), "the Codex pack loads")
local function up(fn, want)
	for i = 1, 255 do
		local n, v = debug.getupvalue(fn, i)
		if not n then return nil end
		if n == want then return v end
	end
end
local chunks = up(C.Register, "chunks")
local nameIn = up(up(up(C.Name, "nameOf"), "entryOf"), "nameIn")
local fieldAt = up(nameIn, "fieldAt")
assert(chunks and fieldAt, "Codex internals reached")
local find, sub, tonumber = string.find, string.sub, tonumber
local blobs, ids, gaps, bad = 0, 0, 0, {}
local function check(group, blob)
	blobs = blobs + 1
	-- What the plain find returned for each id: its first line (a field holds no "\\n").
	local first, list, at = {}, {}, 1
	while true do
		local s = find(blob, "\\n", at, true)
		if not s then break end
		local tab = find(blob, "\\t", s + 1, true)
		local k = sub(blob, s + 1, tab - 1)
		local id = tonumber(k) or k
		if first[id] == nil then first[id] = tab + 1; list[#list + 1] = id end
		at = tab + 1
	end
	for _, id in ipairs(list) do
		ids = ids + 1
		local got = fieldAt(blob, id)
		if got ~= first[id] and #bad < 20 then bad[#bad + 1] = group .. ":" .. tostring(id) .. " " .. tostring(got) .. "~=" .. first[id] end
		if type(id) == "number" then
			for _, g in ipairs({ id - 1, id + 1 }) do
				if first[g] == nil then
					gaps = gaps + 1
					local miss = fieldAt(blob, g)
					if miss ~= nil and #bad < 20 then bad[#bad + 1] = group .. ": absent " .. g .. " at " .. tostring(miss) end
				end
			end
		end
	end
end
for group, list in pairs(chunks) do
	for _, c in ipairs(list) do
		check(group, c.names)
		if c.recs then check(group, c.recs) end
	end
end
emit({ blobs = blobs, ids = ids, gaps = gaps, nbad = #bad, bad = table.concat(bad, "; ") })`,
	}).emitted;
	assert.ok(r.blobs > 20 && r.ids > 50000, `the whole pack was read: ${JSON.stringify({ blobs: r.blobs, ids: r.ids })}`);
	assert.ok(r.gaps > 1000, 'gaps checked');
	assert.equal(r.nbad, 0, `every lookup as the plain find: ${r.bad}`);
});

// A lookup's cost does not grow with where the id sits in its chunk: the pack's chunks hold up to a few
// megabytes, and a plain find read up to all of it for an id near the end. 2,000 lookups of the last ids of a
// 40,000-line chunk against 2,000 of the first ones (os.clock; the first ones are the cheap case of a plain
// find, so a find over the whole blob shows as hundreds of times slower).
test('Codex: finding an id near the end of a chunk costs about what one near the start does', () => {
	const n = 40000;
	const [r] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Lookup/Codex.lua'] }],
		script: `
local C = Polestar.Codex
C.Register("meta", { sources = {} })
local parts = {}
for i = 1, ${n} do parts[i] = "\\n" .. (i * 3) .. "\\t\\tZone number " .. i .. " with a name of some length" end
C.Register("zone", table.concat(parts), nil, 3, ${n} * 3)
local function time(from)
	local best = math.huge
	for _ = 1, 3 do
		local t0 = os.clock()
		for k = 0, 1999 do assert(C.Name("zone", (from + k) * 3)) end
		best = math.min(best, os.clock() - t0)
	end
	return best
end
emit({ first = time(1), last = time(${n} - 1999) })`,
	}).emitted;
	assert.ok(r.last <= Math.max(r.first * 5, 0.02), `last ids ${(r.last * 1000).toFixed(1)} ms vs first ${(r.first * 1000).toFixed(1)} ms`);
});
