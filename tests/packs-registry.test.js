'use strict';
// The guide pack registry (addon/Polestar/Core/Guides.lua): pack ids and
// ownership, clashes, formats, problems recorded per pack, map frames and
// author text escaped once at registration.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

const PRELUDE = `
G = Polestar.Guides
function pack(id, addon, extra)
	local m = { addon = addon or "JoeAddon", id = id, format = 1, title = "Joe's Routes", author = "Joe", version = "1.0.0", license = "MIT" }
	for k, v in pairs(extra or {}) do m[k] = v end
	return { Polestar.RegisterPack(m) }
end
function guide(id, packId, extra)
	local g = { id = id, pack = packId, title = "Guide " .. id, steps = { { goals = { { t = "level", level = 2 } } } } }
	for k, v in pairs(extra or {}) do g[k] = v end
	return { Polestar.RegisterGuide(g) }
end
function messages(r)
	local out = {}
	for i, p in ipairs(r.problems) do out[i] = p.kind .. ": " .. p.message end
	return out
end
`;

function run(script, before) {
	return runAddon({ before, addons: [CORE], login: false, script: PRELUDE + script }).emitted;
}

test('a pack registers and its own guides join it', () => {
	const [out] = run(`
		local p = pack("joe")
		local g = guide("joe/a", "joe")
		local r = G.Pack("joe")
		emit({ p = p[1], g = g[1], count = r.guideCount, status = r.status, guides = r.guides, got = G.Get("joe/a").id, official = r.official })
	`);
	assert.deepEqual(out, { p: true, g: true, count: 1, status: 'on', guides: ['joe/a'], got: 'joe/a', official: false });
});

test('a guide outside its pack\'s prefix is refused and the problem names the prefix', () => {
	const [out] = run(`
		pack("joe")
		local a = guide("forever/x", "joe")
		local b = guide("joe-routes/x", "joe")
		emit({ a = a[1], b = b[1], got = G.Get("forever/x") ~= nil or G.Get("joe-routes/x") ~= nil, problems = G.Pack("joe").problems })
	`);
	assert.equal(out.a, false);
	assert.equal(out.b, false);
	assert.equal(out.got, false);
	assert.equal(out.problems.length, 2);
	for (const p of out.problems) {
		assert.equal(p.kind, 'guide-refused');
		assert.match(p.message, /joe\//);
	}
	assert.deepEqual(out.problems.map((p) => p.guide), ['forever/x', 'joe-routes/x']);
});

test('a pack id already taken refuses the second pack whole: the guides it registers while loading stay out, even under the holder\'s ids', () => {
	const [out] = run(`
		pack("joe", "A")
		guide("joe/a", "joe")
		stub.addonLoaded("A")
		local second = pack("joe", "B")
		local same = guide("joe/a", "joe", { title = "Not A" })
		local own = guide("joe/b", "joe")
		stub.addonLoaded("B")
		local later = guide("joe/c", "joe")
		local refused
		for _, r in ipairs(G.Packs()) do if r.addon == "B" then refused = r end end
		local a = G.Pack("joe")
		emit({ second = second[1], same = same[1], own = own[1], later = later[1], status = refused.status, problems = messages(refused),
			reason = refused.reason, holder = a.addon, guides = a.guides, title = G.Get("joe/a").title, hasB = G.Get("joe/b") ~= nil, n = #G.Packs() })
	`);
	assert.equal(out.second, false);
	assert.equal(out.same, false, "B's guide under the holder's id is dropped");
	assert.equal(out.own, false);
	assert.equal(out.later, true, 'after B has loaded, a guide for pack joe goes to its holder');
	assert.equal(out.status, 'refused');
	assert.equal(out.problems.length, 1);
	assert.match(out.problems[0], /^pack-refused: /);
	assert.match(out.problems[0], /\bA\b/);
	assert.match(out.problems[0], /\bB\b/);
	assert.match(out.problems[0], / 2 guides dropped\.$/);
	assert.equal(out.reason, out.problems[0].replace(/^pack-refused: /, ''));
	assert.equal(out.holder, 'A');
	assert.deepEqual(out.guides, ['joe/a', 'joe/c']);
	assert.equal(out.title, 'Guide joe/a', "the holder's guide is untouched");
	assert.equal(out.hasB, false);
	assert.equal(out.n, 2);
});

test('a pack refused for a reserved id drops the guides it registers while loading', () => {
	const [out] = run(`
		pack("guides", "Polestar_Guides")
		guide("forever/a", "guides")
		stub.addonLoaded("Polestar_Guides")
		pack("guides", "Imposter")
		local g = guide("forever/a", "guides", { title = "Not ours" })
		local refused
		for _, r in ipairs(G.Packs()) do if r.addon == "Imposter" then refused = r end end
		emit({ g = g[1], title = G.Get("forever/a").title, problems = messages(refused) })
	`);
	assert.equal(out.g, false);
	assert.equal(out.title, 'Guide forever/a');
	assert.deepEqual(out.problems, ['pack-refused: Pack id guides is reserved for Polestar. 1 guide dropped.']);
});

test('a guide registered before its pack is refused and the pack records it', () => {
	const [out] = run(`
		local g = guide("joe/a", "joe")
		local stray = guide("nobody/a", "nobody")
		pack("joe")
		emit({ g = g[1], stray = stray[1], got = G.Get("joe/a") ~= nil, problems = G.Pack("joe").problems, count = G.Pack("joe").guideCount })
	`);
	assert.equal(out.g, false);
	assert.equal(out.stray, false);
	assert.equal(out.got, false);
	assert.equal(out.count, 0);
	assert.equal(out.problems.length, 1);
	assert.equal(out.problems[0].kind, 'guide-refused');
	assert.equal(out.problems[0].guide, 'joe/a');
	assert.match(out.problems[0].message, /before its pack/);
});

test('a pack of a format the core does not read is refused whole with the version it needs', () => {
	const [out] = run(`
		local p = pack("joe", "JoeAddon", { format = 4 })
		local g1 = guide("joe/a", "joe")
		local g2 = guide("joe/b", "joe")
		local r = G.Pack("joe")
		emit({ p = p[1], g = g1[1] or g2[1], status = r.status, needs = r.needs, problems = messages(r), got = G.Get("joe/a") ~= nil })
	`, 'stub.addonMeta.JoeAddon = { ["X-Polestar-Needs"] = "0.3.0" }');
	assert.equal(out.p, false);
	assert.equal(out.g, false);
	assert.equal(out.status, 'too-new');
	assert.equal(out.needs, '0.3.0');
	assert.equal(out.problems.length, 1);
	assert.match(out.problems[0], /0\.3\.0/);
	assert.equal(out.got, false);
});

test('an unknown verb refuses only that guide', () => {
	const [out] = run(`
		pack("joe")
		local bad = guide("joe/bad", "joe", { steps = { { goals = { { t = "dance" } } } } })
		local good = guide("joe/good", "joe")
		local r = G.Pack("joe")
		emit({ bad = bad[1], good = good[1], status = r.status, guides = r.guides, problems = r.problems })
	`);
	assert.equal(out.bad, false);
	assert.equal(out.good, true);
	assert.equal(out.status, 'on');
	assert.deepEqual(out.guides, ['joe/good']);
	assert.equal(out.problems.length, 1);
	assert.equal(out.problems[0].guide, 'joe/bad');
	assert.match(out.problems[0].message, /unknown verb dance/);
});

test('a pack registering its own id again replaces the guide in its first slot', () => {
	const [out] = run(`
		pack("joe")
		guide("joe/a", "joe", { title = "One" })
		guide("joe/z", "joe")
		local again = guide("joe/a", "joe", { title = "Two" })
		local ids = {}
		for i, h in ipairs(G.List()) do ids[i] = h.id end
		emit({ again = again[1], title = G.Get("joe/a").title, header = G.List()[1].title, ids = ids, count = G.Pack("joe").guideCount })
	`);
	assert.deepEqual(out, { again: true, title: 'Two', header: 'Two', ids: ['joe/a', 'joe/z'], count: 2 });
});

test('reserved, internal and malformed pack ids are refused', () => {
	const [out] = run(`
		local res = {}
		res.forever = pack("forever")[1]
		res.polestar = pack("polestar")[1]
		res.draft = pack("draft")[1]
		res.guidesElsewhere = pack("guides", "NotOurs")[1]
		res.lookupPlain = pack("lookup")[1]
		res.internalOther = Polestar.RegisterPack({ id = "joe", title = "Joe", internal = true })
		res.upper = pack("Joe")[1]
		res.short = pack("x")[1]
		res.long = pack(string.rep("a", 33))[1]
		res.ok = pack("joe")[1]
		res.internalLookup = Polestar.RegisterPack({ id = "lookup", title = "Lookup", internal = true })
		local listed = {}
		for _, r in ipairs(G.Packs()) do listed[#listed + 1] = r.id .. ":" .. r.status end
		emit({ res = res, listed = listed, lookupInternal = G.Pack("lookup").internal, guidesHeld = G.Pack("guides").status })
	`);
	assert.deepEqual(out.res, {
		forever: false, polestar: false, draft: false, guidesElsewhere: false, lookupPlain: false,
		internalOther: false, upper: false, short: false, long: false, ok: true, internalLookup: true,
	});
	assert.equal(out.lookupInternal, true);
	assert.equal(out.guidesHeld, 'refused');
	assert.ok(!out.listed.some((s) => s.startsWith('lookup:on')), 'the internal pack is not listed');
	assert.ok(out.listed.includes('joe:on'));
});

test('our pack is only ours from Polestar_Guides and comes first in the list', () => {
	const [out] = run(`
		pack("aaa", "Aaa", { title = "Aardvark" })
		local ours = pack("guides", "Polestar_Guides", { title = "Polestar Guides" })
		pack("zed", "Zed", { title = "beta" })
		guide("forever/a", "guides")
		guide("draft/b", "guides")
		local wrong = guide("guides/c", "guides")
		local ids = {}
		for i, r in ipairs(G.Packs()) do ids[i] = r.id end
		emit({ ours = ours[1], official = G.Pack("guides").official, ids = ids, count = G.Pack("guides").guideCount, wrong = wrong[1],
			owns = { G.OwnsId("guides", "forever/x"), G.OwnsId("guides", "draft/x"), G.OwnsId("lookup", "lookup/x"), G.OwnsId("joe", "joe/x"), G.OwnsId("joe", "joex/y") } })
	`);
	assert.equal(out.ours, true);
	assert.equal(out.official, true);
	assert.deepEqual(out.ids, ['guides', 'aaa', 'zed']);
	assert.equal(out.count, 2);
	assert.equal(out.wrong, false);
	assert.deepEqual(out.owns, [true, true, true, true, false]);
});

test('map frames: ours win for a map both cover, whatever the load order; packs add the maps ours lack', () => {
	const script = (first, second) => `
		pack("joe")
		local A = { c = 0, left = 1, right = -1, top = 1, bottom = -1 }
		local B = { c = 0, left = 2, right = -2, top = 2, bottom = -2 }
		local C = { c = 1, left = 3, right = -3, top = 3, bottom = -3 }
		local calls = {
			joe = function() Polestar.RegisterMapFrames({ era = { [1429] = A, [9999] = C } }, "joe") end,
			guides = function() Polestar.RegisterMapFrames({ era = { [1429] = B } }, "guides") end,
		}
		calls.${first}(); calls.${second}()
		local era = Polestar.MapFrames.era
		emit({ era[1429] == B, era[9999] == C })
	`;
	assert.deepEqual(run(script('joe', 'guides'))[0], [true, true]);
	assert.deepEqual(run(script('guides', 'joe'))[0], [true, true]);
});

test('author text prints literally: every | doubled once at registration, ids unchanged', () => {
	const [out] = run(`
		pack("joe", "JoeAddon", { title = "Joe|r", notes = "a|b" })
		guide("joe/a", "joe", { title = "|cffff0000Red|r", next = "joe/b", steps = {
			{ title = "S|1", goals = { { t = "note", text = "x|y" }, { t = "level", level = 2, note = "n|n", text = "lvl|2" } } } } })
		local g = G.Get("joe/a")
		local r = G.Pack("joe")
		emit({ title = g.title, header = G.List()[1].title, step = g.steps[1].title, text = g.steps[1].goals[1].text,
			note = g.steps[1].goals[2].note, text2 = g.steps[1].goals[2].text, id = g.id, next = g.next, pack = g.pack,
			packTitle = r.title, packNotes = r.notes, esc = Polestar.EscapeText("a|b|c"), plain = Polestar.EscapeText("abc") })
	`);
	assert.deepEqual(out, {
		title: '||cffff0000Red||r', header: '||cffff0000Red||r', step: 'S||1', text: 'x||y', note: 'n||n', text2: 'lvl||2',
		id: 'joe/a', next: 'joe/b', pack: 'joe', packTitle: 'Joe||r', packNotes: 'a||b', esc: 'a||b||c', plain: 'abc',
	});
});

test('a pack missing a required field is refused and the problem names the field', () => {
	const [out] = run(`
		local p = Polestar.RegisterPack({ addon = "JoeAddon", id = "joe", format = 1, title = "Joe", version = "1", license = "MIT" })
		local g = guide("joe/a", "joe")
		local r = G.Pack("joe")
		emit({ p = p, g = g[1], status = r.status, problems = messages(r) })
	`);
	assert.equal(out.p, false);
	assert.equal(out.g, false);
	assert.equal(out.status, 'refused');
	assert.equal(out.problems.length, 1);
	assert.match(out.problems[0], /author/);
});

test('a pack misusing `internal` or the lookup id is refused, listed with its problem, and never reported broken', () => {
	const [out] = run(`
		local a = { Polestar.RegisterPack({ addon = "IntlAddon", id = "intl", format = 1, title = "Intl", author = "I", version = "1", license = "MIT", internal = true }) }
		local b = { Polestar.RegisterPack({ addon = "LookAddon", id = "lookup", format = 1, title = "Look", author = "L", version = "1", license = "MIT" }) }
		G.ScanInstalled()
		local rows = {}
		for _, r in ipairs(G.Packs()) do rows[r.addon] = { id = r.id, status = r.status, problems = messages(r) } end
		emit({ a = a[1], b = b[1], rows = rows, count = G.ProblemCount() })
	`, `stub.addons = { { name = "IntlAddon", loaded = true }, { name = "LookAddon", loaded = true } }
		stub.addonMeta.IntlAddon = { ["X-Polestar-Pack"] = "intl", ["X-Polestar-Format"] = "1" }
		stub.addonMeta.LookAddon = { ["X-Polestar-Pack"] = "lookup", ["X-Polestar-Format"] = "1" }`);
	assert.equal(out.a, false);
	assert.equal(out.b, false);
	assert.deepEqual(Object.keys(out.rows).sort(), ['IntlAddon', 'LookAddon']);
	assert.equal(out.rows.IntlAddon.status, 'refused');
	assert.equal(out.rows.IntlAddon.problems.length, 1);
	assert.match(out.rows.IntlAddon.problems[0], /^pack-refused: .*internal/);
	assert.doesNotMatch(out.rows.IntlAddon.problems[0], /reserved/);
	assert.equal(out.rows.LookAddon.status, 'refused');
	assert.deepEqual(out.rows.LookAddon.problems, ['pack-refused: Pack id lookup is reserved for Polestar.']);
	assert.equal(out.count, 2);
});

test('an `internal` pack whose id is taken or reserved is refused whole: its guides stay out of the holder', () => {
	const [out] = run(`
		pack("joe", "A")
		guide("joe/a", "joe")
		stub.addonLoaded("A")
		pack("joe", "B", { internal = true })
		local taken = guide("joe/b", "joe")
		stub.addonLoaded("B")
		pack("guides", "Polestar_Guides")
		stub.addonLoaded("Polestar_Guides")
		pack("guides", "C", { internal = true })
		local reserved = guide("forever/x", "guides")
		emit({ taken = taken[1], reserved = reserved[1], hasB = G.Get("joe/b") ~= nil, hasX = G.Get("forever/x") ~= nil, guides = G.Pack("joe").guides })
	`);
	assert.deepEqual(out, { taken: false, reserved: false, hasB: false, hasX: false, guides: ['joe/a'] });
});

test('map frames of a refused pack are ignored, even under the holder\'s id', () => {
	const [out] = run(`
		local A = { c = 0, left = 1, right = -1, top = 1, bottom = -1 }
		local B = { c = 1, left = 2, right = -2, top = 2, bottom = -2 }
		pack("joe", "A")
		stub.addonLoaded("A")
		pack("joe", "B")
		Polestar.RegisterMapFrames({ era = { [9999] = B } }, "joe")
		pack("guides", "C")
		Polestar.RegisterMapFrames({ era = { [8888] = B } }, "guides")
		stub.addonLoaded("C")
		Polestar.RegisterMapFrames({ era = { [7777] = A } }, "joe")
		local era = Polestar.MapFrames.era
		emit({ era[9999] == nil, era[8888] == nil, era[7777] == A })
	`);
	assert.deepEqual(out, [true, true, true]);
});
