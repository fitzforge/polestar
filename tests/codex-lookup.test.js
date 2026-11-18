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
// Codex.FollowUps reads the quest records once, on its first ask: the same
// follow-ups, in pack order, each once, chunks registered later included, and
// no copy of the records on later asks.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ADDONS } = require('./helpers/lua');
const { localPacks } = require('./helpers/profile');
const { assertTiming } = require('./helpers/timing');

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
	assertTiming(r.last <= Math.max(r.first * 5, 0.02), `last ids ${(r.last * 1000).toFixed(1)} ms vs first ${(r.first * 1000).toFixed(1)} ms`);
});

// Codex.FollowUps on quest records in the pack's format: field 12 is `pre`, 15 `preAny`; `f` maps a
// field number to its text (the rest empty), `extra` holds the fields after 15 (objectives, x<xp>).
const questRec = (id, { extra = [], ...f } = {}) => {
	const t = Array(15).fill('');
	for (const [k, v] of Object.entries(f)) t[Number(k) - 1] = v;
	return `\n${id}\t${[...t, ...extra].join(';')}`;
};
const questNames = (ids) => ids.map((id) => `\n${id}\t\tQuest ${id}`).join('');
const questChunk = (rows) => {
	const ids = rows.map((r) => r[0]);
	return `C.Register("quest", ${JSON.stringify(questNames(ids))}, ${JSON.stringify(rows.map(([id, f]) => questRec(id, f)).join(''))}, ${ids[0]}, ${ids[ids.length - 1]})`;
};

test('Codex: FollowUps lists the quests whose pre or preAny names a quest, once each, in pack order, late chunks too', () => {
	const first = questChunk([
		[100, { 6: '7', 13: '7' }], // the id in its zone and rewards only
		[101, { 12: '7' }],
		[102, { 12: '7,7', 15: '7' }], // named three times: one follow-up
		[103, { 15: '50,7' }],
		[104, { 12: '8', 13: '7', 14: '7', extra: ['k7,1,Seven', 'x700'] }],
		[105, { 12: '70,17,77' }], // ids holding the digits of 7
	]);
	// Registered after the first ask, with lower ids: pack order puts them after the first chunk's.
	const late = questChunk([
		[60, { 12: '7' }],
		[61, { 15: '101' }],
	]);
	const [r] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Lookup/Codex.lua'] }],
		script: `
local C = Polestar.Codex
C.Register("meta", { sources = {} })
local function ids(id)
	local t = {}
	for i, q in ipairs(C.FollowUps(id)) do t[i] = q.id .. "=" .. q.title end
	return table.concat(t, ",")
end
local none = C.FollowUps(7)
local before = { none = #none }
${first}
before.seven = ids(7)
C.Register("quest", "\\n106\\t\\tQuest 106", "\\n106\\t" .. string.rep(";", 11) .. "23", 106, 106)
before.short = ids(23)
before.text = ids("7")
before.eight, before.seventeen, before.seventy = ids(8), ids(17), ids(70)
before.nohit = ids(9) .. ids(101) .. ids(100) .. ids(1.5) .. ids(-7) .. ids("abc") .. ids(nil) .. ids(5)
${late}
emit({ before = before, seven = ids(7), oneOhOne = ids(101), fifty = ids(50) })`,
	}).emitted;
	assert.deepEqual(r.before, {
		none: 0,
		seven: '101=Quest 101,102=Quest 102,103=Quest 103',
		text: '101=Quest 101,102=Quest 102,103=Quest 103',
		short: '106=Quest 106',
		eight: '104=Quest 104',
		seventeen: '105=Quest 105',
		seventy: '105=Quest 105',
		nohit: '',
	});
	assert.equal(r.seven, '101=Quest 101,102=Quest 102,103=Quest 103,60=Quest 60', 'a chunk registered later is read');
	assert.equal(r.oneOhOne, '61=Quest 61');
	assert.equal(r.fifty, '103=Quest 103');
});

// Hold the collector for one warm lookup: collecting the discarded records
// during the call would hide the allocation we want to prevent.
test('Codex: after the first FollowUps, an ask does not copy the quest records', () => {
	const [r] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Lookup/Codex.lua'] }],
		script: `
local C = Polestar.Codex
C.Register("meta", { sources = {} })
local names, recs = {}, {}
for i = 1, 1000 do
	local id = i * 2
	names[i] = "\\n" .. id .. "\\t\\tQuest " .. id
	recs[i] = "\\n" .. id .. "\\t" .. (i % 60) .. ";;;;;" .. (i % 90) .. ";" .. (3000 + i) .. ";;;" .. (3000 + i) .. ";;" .. (id - 2) .. ";" .. (5000 + i) .. ";;;k" .. (7000 + i) .. ",8,Things;x" .. (i * 10)
end
local blob = table.concat(recs)
C.Register("quest", table.concat(names), blob, 2, 2000)
names, recs = nil, nil
local function cost(id)
	collectgarbage("collect")
	local k0 = collectgarbage("count")
	collectgarbage("stop")
	local out = C.FollowUps(id)
	local k = collectgarbage("count") - k0
	collectgarbage("restart")
	return k, out
end
local _, first = cost(10)
local wrong, worst = (#first == 1 and first[1].id == 12) and 0 or 1, 0
for _, id in ipairs({ 7, 16, 808, 1996, 2001 }) do
	local k, got = cost(id)
	worst = math.max(worst, k)
	local want = id % 2 == 0 and id < 2000 and id + 2 or nil
	if (want and not (#got == 1 and got[1].id == want)) or (not want and #got ~= 0) then wrong = wrong + 1 end
end
emit({ worst = worst, wrong = wrong })`,
	}).emitted;
	assert.equal(r.wrong, 0, 'every ask lists its follow-up');
	assert.ok(r.worst < 16, `a warm lookup allocated ${r.worst.toFixed(1)} KiB`);
});

test('Codex: on the real pack, FollowUps of every quest is what reading each record\'s pre and preAny gives', { skip: !codexBuilt && 'Polestar_Codex not built' }, () => {
	const packs = localPacks();
	const [r] = runAddon({
		stubs: ['stub_world.lua', ...packs.stubs],
		before: packs.before,
		addons: ['Polestar'],
		script: `
local C = Polestar.Codex
local chunks, register = {}, C.Register
C.Register = function(group, names, records, ...)
	if group == "quest" and records then chunks[#chunks + 1] = records end
	return register(group, names, records, ...)
end
stub.login()
assert(C.Load(), "the Codex pack loads")
C.Register = register
local want, asked, rows = {}, {}, 0
for _, records in ipairs(chunks) do
	for qid, s in string.gmatch(records, "\\n([^\\t\\n]*)\\t([^\\n]*)") do
		rows = rows + 1
		local t, n = {}, 0
		for f in string.gmatch(s .. ";", "([^;]*);") do n = n + 1; t[n] = f end
		local named = {}
		for _, f in ipairs({ t[12] or "", t[15] or "" }) do
			for p in string.gmatch(f, "[^,]+") do
				p = tonumber(p)
				if p and not named[p] then
					named[p] = true
					if not want[p] then want[p] = {} end
					table.insert(want[p], tonumber(qid))
				end
			end
		end
		local id = tonumber(qid)
		if id then asked[id] = true end
	end
end
local bad, edges = {}, 0
for id in pairs(want) do asked[id] = true end
for id in pairs(asked) do
	local got = {}
	for i, q in ipairs(C.FollowUps(id)) do got[i] = q.id end
	local w = want[id] and table.concat(want[id], ",") or ""
	if want[id] then edges = edges + #want[id] end
	if table.concat(got, ",") ~= w and #bad < 10 then bad[#bad + 1] = id .. ": " .. table.concat(got, ",") .. " ~= " .. w end
end
emit({ rows = rows, edges = edges, nbad = #bad, bad = table.concat(bad, "; ") })`,
	}).emitted;
	assert.ok(r.rows > 1000 && r.edges > 1000, `the quest records were read: ${JSON.stringify(r)}`);
	assert.equal(r.nbad, 0, `every quest's follow-ups: ${r.bad}`);
});

// Quest 67 in the shipped pack: the first hover walks a 13-quest chain. Count
// full passes over a quest chunk instead of imposing a machine-dependent time limit.
// The small fixture runs in CI without any installed packs.
test('the first guide tooltip for a long quest chain reads each quest chunk at most once', () => {
	const count = `local gmatch = string.gmatch
stub.recordScans = 0
string.gmatch = function(s, pattern)
	if s == stub.questRecords then stub.recordScans = stub.recordScans + 1 end
	return gmatch(s, pattern)
end`;
	const [r] = runAddon({
		stubs: ['stub_world.lua'], before: count, addons: ['Polestar'],
		script: `stub.login()
local C, L = Polestar.Codex, Polestar.Lookup
local names, records = {}, {}
for id = 66, 1066 do
	names[#names + 1] = "\\n" .. id .. "\\t\\tQuest " .. id
	local pre = id > 66 and id <= 78 and tostring(id - 1) or ""
	records[#records + 1] = "\\n" .. id .. "\\t" .. string.rep(";", 11) .. pre .. ";;;"
end
stub.questRecords = table.concat(records)
C.Register("meta", { sources = {} })
C.Register("quest", table.concat(names), stub.questRecords, 66, 1066)
local first = L.ChainTooltipText(67)
local scans = stub.recordScans
local again = L.ChainTooltipText(67)
emit({ first = first, again = again, scans = scans, repeatScans = stub.recordScans - scans })`,
	}).emitted;
	assert.equal(r.first, 'Chain: 1 of 13');
	assert.equal(r.again, r.first);
	assert.ok(r.scans <= 1, `first hover read the whole quest chunk ${r.scans} times`);
	assert.equal(r.repeatScans, 0);
});
