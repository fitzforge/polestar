'use strict';
// Engine parity reference: a `next` chain played whole through the real addon
// on tests/lua/stub_world.lua (tools/lib/playtest.js's stub play), recording
// every goal the simulated player completes, in order.
//
//   node engine-chain.js <guides root> <first guide file> <race> <faction> <class> <data dir> <out.json> [stop|skip]
//
// playtest.js's SIMULATE script is used as is, patched in memory only: it runs
// once per guide (the engine hands over through `next` by itself,
// autoNextGuide, as playtest's handOver play sets it), act() appends
// { k: "goal", g, s, i, t, id } to a trace (`m` when the player then ticks the
// goal by hand). At a stuck goal the play stops ("stop", SIMULATE's own end)
// or, with "skip", the player skips the step (Engine.Skip) and plays on, so
// the whole chain is covered. Output: { files, trace, level, ms, luaMs }:
// trace entries { k: "login", id } (the guide the login opened by itself),
// { k: "guide", id }, goals, { k: "stuck", g, s, i, t, status, why },
// { k: "missing", g, list: [[s, g], ...] } (accept/turn-in goals without a
// location, once per guide).

const fs = require('node:fs');
const path = require('node:path');

const WT = path.resolve(__dirname, '../../../../..');
const { buildSimPack, playOptions, SIMULATE } = require(path.join(WT, 'tools/lib/playtest.js'));
const { runAddon } = require(path.join(WT, 'tests/helpers/lua.js'));
const { loadData } = require(path.join(WT, 'tools/lib/dsl/data.js'));

const [root, first, race, faction, cls, dataDir, out, mode = 'stop'] = process.argv.slice(2);
const VERBOSE = !!process.env.ENGINE_VERBOSE;

// A guide's id and its `next` options in order (every line; `next <id> when ...` names one).
const header = (text) => ({
	id: (text.match(/^guide\s+(\S+)/m) || [])[1],
	next: [...text.matchAll(/^next\s+(.+)$/gm)].flatMap((m) => (/\swhen\s/.test(m[1]) ? [m[1].trim().split(/\s+/)[0]] : m[1].split(/[\s,]+/).filter(Boolean))),
});

// The guides reachable from `first` through `next` (every route option), first and then in order.
function chain() {
	const byId = new Map();
	const walk = (dir) => {
		for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
			const p = path.join(dir, e.name);
			if (e.isDirectory()) walk(p);
			else if (e.name.endsWith('.guide')) {
				const text = fs.readFileSync(p, 'utf8');
				const h = header(text);
				if (h.id) byId.set(h.id, { rel: path.relative(root, p), text, next: h.next });
			}
		}
	};
	walk(path.join(root, 'forever'));
	const files = [];
	const seen = new Set();
	const queue = [header(fs.readFileSync(path.join(root, first), 'utf8')).id];
	while (queue.length) {
		const id = queue.shift();
		if (!id || !byId.has(id) || seen.has(id)) continue;
		seen.add(id);
		const g = byId.get(id);
		files.push(g);
		queue.push(...g.next);
	}
	return files;
}

function patch(src, from, to) {
	if (!src.includes(from)) throw new Error(`patch target missing: ${from.slice(0, 60)}`);
	return src.replace(from, to);
}

let sim = SIMULATE;
const extra = VERBOSE ? ', sub = g.subject, st = g.status, now = GetTime(), lvl = w.level' : '';
sim = patch(sim, 'local function act(i, g, r)\n\tlocal t, q = g.t, g.quest\n', `local function act(i, g, r)\n\tlocal t, q = g.t, g.quest\n\tTRACE[#TRACE + 1] = { k = "goal", g = G.id, s = i, i = g.index, t = r.t, id = r.quest or r.item or r.npc or r.spell${extra} }\n`);
sim = patch(sim, '\t\t\tE.ToggleGoal(i, open.index)\n', '\t\t\tE.ToggleGoal(i, open.index)\n\t\t\tTRACE[#TRACE].m = true\n');
sim = patch(sim, 'emit({ done =', 'return ({ done =');
const script = `
TRACE = { { k = "login", id = PRE_GUIDE } }
local function simOnce()
${sim}
end
local missingSeen, lastGuide = {}, nil
for n = 1, 4000 do
	SIM_GUIDE = Polestar.Engine.GetGuide()
	if not SIM_GUIDE then break end
	local G = SIM_GUIDE
	if lastGuide ~= G.id then
		lastGuide = G.id
		TRACE[#TRACE + 1] = { k = "guide", id = G.id }
	end
	if not missingSeen[G.id] then
		missingSeen[G.id] = true
		local list = {}
		for si, s in ipairs(G.steps) do
			for gi, g in ipairs(s.goals) do
				if (g.t == "accept" and not g.item or g.t == "turnin") and not (g.map and g.x and g.y) then list[#list + 1] = { si, gi } end
			end
		end
		if #list > 0 then TRACE[#TRACE + 1] = { k = "missing", g = G.id, list = list } end
	end
	local r = simOnce()
	if r.stuck then
		local s = r.stuck
		TRACE[#TRACE + 1] = { k = "stuck", g = G.id, s = s.step, i = s.goal, t = s.t, status = s.status, why = s.why }
		if ${mode === 'skip' ? 'false' : 'true'} or Polestar.Engine.GetGuide() ~= G or Polestar.Engine.GetStepIndex() ~= s.step then break end
		Polestar.Engine.Skip()
	else
		local now = Polestar.Engine.GetGuide()
		if not now or now == G then break end
	end
end
emit({ trace = TRACE, level = stub.world.level })
`;

const t0 = Date.now();
const files = chain();
const data = loadData(dataDir);
const pack = buildSimPack(files.map((f) => ({ file: path.join('guides', f.rel), text: f.text })), data);
try {
	for (const d of pack.diag.list.filter((x) => x.severity === 'error')) console.error('compile error:', d.file, d.line, d.message);
	const firstId = header(files[0].text).id;
	const g = pack.guides.find((x) => x.id === firstId);
	const next = g.nextChoices && g.nextChoices.length ? g.nextChoices : g.next ? [g.next] : [];
	const opts = playOptions(pack, g, { race, faction, cls, handOver: next.length ? next : null, script });
	opts.script = patch(opts.script, 'Polestar.Engine.SetGuide(', 'PRE_GUIDE = Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id or false\n\t\t\tPolestar.Engine.SetGuide(');
	const t1 = Date.now();
	const [res] = runAddon(opts).emitted;
	const luaMs = Date.now() - t1;
	const ms = Date.now() - t0;
	fs.mkdirSync(path.dirname(out), { recursive: true });
	fs.writeFileSync(out, JSON.stringify({ files: files.map((f) => f.rel), trace: res.trace, level: res.level, ms, luaMs }));
	const goals = res.trace.filter((e) => e.k === 'goal').length;
	const stucks = res.trace.filter((e) => e.k === 'stuck').length;
	console.log(`${files.length} guides, ${goals} goals, ${stucks} stuck, ${ms} ms (Lua play ${luaMs} ms)`);
} finally {
	pack.dispose();
}
