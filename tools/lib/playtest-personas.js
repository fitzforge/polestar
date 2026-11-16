'use strict';
// Imperfect players for `polestar playtest --persona` (tools/lib/playtest.js
// plays them; SIMULATE's PERSONA table carries what each went without). The
// perfect follower does every step in order; players don't, and a guide that
// only works for the perfect follower holds real players on a step they can
// never finish (An Apple Treat, reported six times). Each persona is played
// once per variant, as one race and class per guide:
//
//   skip       skips one step with the window's Skip, keeps going: every step
//              that gets an item a later goal must hand over, plus an even
//              sample of the others (`sample` steps in all)
//   lost       loses an item a direct hand-in or an item-started quest needs,
//              as soon as the route leaves the step that got it (or carries
//              none into the guide when no goal of it gets the item)
//   elsewhere  did one of the guide's quests (and the chain before it)
//              before the guide offers it: its rewards are long used up
//   update     played the last release's guide up to a point, then updated:
//              the current guide opens on that save (the Engine's mapping
//              through Core/LegacySteps.lua) and the play goes on from there
//   fresh      opened the guide with none of the earlier guides' quests done
//              or carried (a character starting the route there); played for
//              each guide the route leads into
//
// A play is stuck only when the guide holds the player on a step no action of
// theirs can ever complete: a hand-in whose item is gone and that no step
// gets again, an accept whose starting item is gone. What the quest log
// shows (objectives to finish, quests to take again) the player can always
// do, so the simulator does it, as for the perfect follower. Each guide is
// first played once as the persona with nothing taken away (the baseline): a
// guide stuck there counts as `baseline`, not as a persona's finding.

const PERSONAS = ['skip', 'lost', 'elsewhere', 'update', 'fresh'];

// The items quest q's objectives ask for -> { item: count }.
function itemNeeds(data, q) {
	const out = {};
	for (const o of data.questObjectives(q)) if (o.kind === 'item' && o.id != null) out[o.id] = Math.max(out[o.id] || 0, o.count || 1);
	return out;
}

// Whether the world gives item `id` itself (a drop, a vendor, a container).
function worldGives(data, id) {
	const it = data.item(id);
	if (!it) return false;
	const d = it.drops || {};
	const some = (o) => !!o && Object.keys(o).length > 0;
	return some(d.npc) || some(d.object) || (Array.isArray(it.vendors) && it.vendors.length > 0) || (Array.isArray(it.containers) && it.containers.length > 0);
}

// item -> the quests that hand it over (fixed rewards, or the item a quest
// gives with its accept), once per data.
const GIVERS = new WeakMap();
function questsGiving(data) {
	let map = GIVERS.get(data);
	if (map) return map;
	map = new Map();
	const add = (item, q) => {
		if (item == null) return;
		const list = map.get(Number(item)) || [];
		if (!list.includes(q)) list.push(q);
		map.set(Number(item), list);
	};
	for (const [id, q] of Object.entries(data.quests)) {
		if (!q) continue;
		for (const r of (q.web && q.web.items) || []) add(Array.isArray(r) ? r[0] : r, Number(id));
		add(q.sourceItem, Number(id));
	}
	GIVERS.set(data, map);
	return map;
}

// A quest only an item starts: its start item, else null.
function startItem(data, q) {
	const d = data.quest(q);
	const s = d && d.start;
	if (!s || (s.npc || []).length || (s.object || []).length || !(s.item || []).length) return null;
	return s.item[0];
}

// What a persona's play of guide g refuses without (SIMULATE's PERSONA
// tables): `needs` (quest -> { item: count }: g's direct hand-ins and
// item-started accepts, and the direct quests that hand over an item g
// collects), `gives` (item -> quests: g's collects of items only quests hand
// over), `rewards` (quest -> items: g's accepts and turn-ins that put a
// carried item in the bags) and `carried` (the items g's required goals must
// hand over).
function personaTables(g, data) {
	const needs = {};
	const gives = {};
	const carried = new Set();
	const goals = g.steps.flatMap((s) => s.goals);
	for (const x of goals) {
		if (!x.quest) continue;
		if (x.t === 'turnin' && x.direct) {
			const n = itemNeeds(data, x.quest);
			if (!Object.keys(n).length) continue;
			needs[x.quest] = n;
			if (!x.optional) for (const i of Object.keys(n)) carried.add(Number(i));
		} else if (x.t === 'accept') {
			const it = startItem(data, x.quest);
			if (it == null) continue;
			needs[x.quest] = { [it]: 1 };
			if (!x.optional) carried.add(Number(it));
		}
	}
	const givers = questsGiving(data);
	for (const x of goals) {
		if ((x.t !== 'collect' && x.t !== 'buy') || x.item == null || x.quest || worldGives(data, x.item)) continue;
		const from = givers.get(Number(x.item));
		if (!from) continue;
		gives[x.item] = from;
		for (const q of from) {
			const d = data.quest(q);
			if (d && d.direct && !needs[q]) {
				const n = itemNeeds(data, q);
				if (Object.keys(n).length) needs[q] = n;
			}
		}
	}
	const rewards = {};
	for (const x of goals) {
		const d = x.quest && data.quest(x.quest);
		if (!d) continue;
		const got = x.t === 'turnin' ? ((d.web && d.web.items) || []).map((r) => Number(Array.isArray(r) ? r[0] : r)) : x.t === 'accept' && d.sourceItem != null ? [Number(d.sourceItem)] : [];
		const kept = got.filter((i) => carried.has(i));
		if (kept.length) rewards[x.quest] = kept;
	}
	// The steps that lead to a source of an item their own hand-in or accept takes (a kill of a creature that
	// drops it, a click on an object that holds it, a talk with, or a buy from, an NPC who sells or gives it, a
	// collect of it or of its container): a player without it gets it there. Step number -> items.
	const restock = {};
	g.steps.forEach((s, k) => {
		const want = new Set();
		for (const x of s.goals) {
			if (!x.quest || !needs[x.quest] || !((x.t === 'turnin' && x.direct) || x.t === 'accept')) continue;
			for (const i of Object.keys(needs[x.quest])) want.add(Number(i));
		}
		const can = [...want].filter((i) => {
			const it = data.item(i) || {};
			const d = it.drops || {};
			const npcs = new Set([...Object.keys(d.npc || {}).map(Number), ...(it.vendors || []).map(Number)]);
			const objects = new Set(Object.keys(d.object || {}).map(Number));
			const items = new Set([i, ...(it.containers || []).map(Number)]);
			return s.goals.some((x) => (x.npc != null && npcs.has(Number(x.npc))) || (x.object != null && objects.has(Number(x.object))) || (x.item != null && x.t !== 'use' && items.has(Number(x.item))));
		});
		if (can.length) restock[k + 1] = can;
	});
	return { needs, gives, rewards, restock, carried: [...carried].sort((a, b) => a - b) };
}

// `n` of `list`, evenly spread, in order (all when it holds no more).
function spread(list, n) {
	if (list.length <= n) return list;
	const out = [];
	for (let k = 0; k < n; k++) out.push(list[Math.floor(((k + 0.5) * list.length) / n)]);
	return [...new Set(out)];
}

// The quests a quest needs done first, through `pre`/`preAll`/`preAny` (the first of preAny), transitively.
function chainBefore(data, q, seen = new Set()) {
	const d = data.quest(q);
	if (!d) return seen;
	for (const p of [...(d.pre || []), ...(d.preAll || []), ...(d.preAny || []).slice(0, 1)]) {
		if (seen.has(p)) continue;
		seen.add(p);
		chainBefore(data, p, seen);
	}
	return seen;
}

const itemLabel = (data, id) => {
	const it = data.item(id);
	return it && it.name ? `${it.name} (${id})` : `item ${id}`;
};
const questLabel = (data, id) => {
	const q = data.quest(id);
	return q && q.title ? `${id} (${q.title})` : String(id);
};

// The plays of `persona` for guide g -> [{ variant, persona, before }]:
// `persona` SIMULATE's PERSONA table, `before` Lua run before the play.
// `sample`: the most variants per guide (skip and elsewhere sample beyond
// what must be played).
function personaVariants(persona, g, data, sample = 8) {
	const t = personaTables(g, data);
	const base = { needs: t.needs, gives: t.gives, rewards: t.rewards, restock: t.restock };
	const goals = g.steps.map((s) => s.goals);
	if (persona === 'skip') {
		// The items a later goal hands over, and those the direct quests that hand them over take (the apples
		// for the Applejack Still).
		const wanted = new Set([...t.carried, ...Object.keys(t.gives).map(Number), ...Object.values(t.needs).flatMap((n) => Object.keys(n).map(Number))]);
		const producers = [];
		const others = [];
		goals.forEach((list, k) => {
			const gets = list.some((x) => ((x.t === 'collect' || x.t === 'buy' || x.t === 'craft') && x.item != null && !x.quest && wanted.has(Number(x.item))) || (x.quest && t.rewards[x.quest]));
			(gets ? producers : others).push(k + 1);
		});
		const steps = [...producers, ...spread(others, Math.max(0, sample - producers.length))].sort((a, b) => a - b);
		return steps.map((i) => ({ variant: `skips step ${i} "${g.steps[i - 1].title || ''}"`, persona: { ...base, skip: i }, before: '' }));
	}
	if (persona === 'lost') {
		const got = new Set([...goals.flat().filter((x) => (x.t === 'collect' || x.t === 'buy') && x.item != null && !x.quest).map((x) => Number(x.item)), ...Object.values(t.rewards).flat()]);
		return t.carried.map((it) => ({
			variant: `loses ${itemLabel(data, it)}${got.has(it) ? ' after getting it' : ' before the guide'}`,
			persona: got.has(it) ? { ...base, lose: it } : { ...base, lack: [it] },
			before: '',
		}));
	}
	if (persona === 'elsewhere') {
		const offered = [];
		// A repeatable quest done before is there to do again: never this persona's.
		for (const x of goals.flat()) {
			const d = x.quest && data.quest(x.quest);
			if (d && !d.repeatable && (x.t === 'accept' || (x.t === 'turnin' && x.direct)) && !offered.includes(x.quest)) offered.push(x.quest);
		}
		// Every quest whose hand-in or rewards matter to the bags, then an even sample of the rest.
		const matters = offered.filter((q) => t.needs[q] || t.rewards[q] || Object.values(t.gives).some((list) => list.includes(q)));
		const rest = offered.filter((q) => !matters.includes(q));
		const quests = [...matters, ...spread(rest, Math.max(0, sample - matters.length))];
		return quests.map((q) => {
			const done = [q, ...chainBefore(data, q)];
			return { variant: `did ${questLabel(data, q)} before the guide`, persona: { ...base }, before: `w.complete(${JSON.stringify(done).replace('[', '{').replace(/]$/, '}')})` };
		});
	}
	throw new Error(`unknown persona ${persona}`);
}

// The steps an update persona leaves the last release's guide `old` at:
// `points` of them, evenly spread over its steps (never the first).
function updatePoints(old, points = 3) {
	const n = old.steps.length;
	if (n < 2) return [];
	return [...new Set(Array.from({ length: points }, (_, k) => Math.max(2, Math.round(((k + 1) * n) / (points + 1)))))];
}

// Lua for the update persona's first play: at the step, log out and emit the
// world (as Lua that restores it) and the save.
const SNAPSHOT_LUA = `
local function __ser(v)
	if type(v) == "string" then return string.format("%q", v) end
	if type(v) ~= "table" then return tostring(v) end
	local parts = {}
	for k, x in pairs(v) do
		if type(x) ~= "function" then parts[#parts + 1] = "[" .. __ser(k) .. "]=" .. __ser(x) end
	end
	return "{" .. table.concat(parts, ",") .. "}"
end
function SNAPSHOT(k)
	local w = stub.world
	local lines = { "local w = stub.world", ("w.level = %d"):format(w.level) }
	local done = {}
	for q in pairs(w.completed) do done[#done + 1] = q end
	lines[#lines + 1] = "w.complete(" .. __ser(done) .. ")"
	for q, e in pairs(w.log) do
		local objs = {}
		for i, o in ipairs(e.objectives) do
			objs[i] = { required = o.numRequired, fulfilled = o.numFulfilled, type = o.type, text = o.text }
		end
		lines[#lines + 1] = ("w.onQuest(%d, %s, %s)"):format(q, __ser(objs), __ser(e.title))
	end
	for item, n in pairs(w.items) do lines[#lines + 1] = ("w.addItem(%d, %d)"):format(item, n) end
	if w.map and w.x and w.y then lines[#lines + 1] = ("w.moveTo(%d, %s, %s)"):format(w.map, tostring(w.x), tostring(w.y)) end
	if w.bindLocation then lines[#lines + 1] = "w.bindLocation = " .. __ser(w.bindLocation) end
	stub.fire("PLAYER_LOGOUT")
	emit({ snapshot = k, step = Polestar.Engine.GetStepIndex(), world = table.concat(lines, "\\n"), save = "PolestarCharDB = " .. __ser(PolestarCharDB) })
end
`;

module.exports = { PERSONAS, personaTables, personaVariants, updatePoints, SNAPSHOT_LUA, itemNeeds, spread };
