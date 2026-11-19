'use strict';
// Run the addon's own planner (Nav/Travel.lua with Nav/TravelData.lua) under
// Lua 5.1, so routes printed by the toolchain are exactly what players get.

const fs = require('node:fs');
const path = require('node:path');
const { luaToJson } = require('../lua');
const { Frames } = require('./geo');

const { ROOT, DATA } = require('../paths');
const NAV = path.join(ROOT, 'addon', 'Polestar', 'Nav');
const { grid } = require('../../../addon/Polestar_Nav/PACK.json');

function luaLiteral(v) {
	if (v === null || v === undefined) return 'nil';
	if (typeof v === 'number') return Number.isFinite(v) ? String(v) : 'nil';
	if (typeof v === 'boolean') return v ? 'true' : 'false';
	if (typeof v === 'string') return `"${v.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '\\n')}"`;
	if (Array.isArray(v)) return `{${v.map(luaLiteral).join(',')}}`;
	return `{${Object.entries(v)
		.map(([k, x]) => `[${/^\d+$/.test(k) ? k : luaLiteral(k)}]=${luaLiteral(x)}`)
		.join(',')}}`;
}

const FACTIONS = { alliance: 1, horde: 2 };

// known: node ids or names ("Sentinel Hill" or "Sentinel Hill, Westfall"),
// matched against travel.json for the faction. An entry that matches no node
// as a whole and contains commas is read as a comma-separated list, so both
// "Sentinel Hill, Westfall" and "Sentinel Hill,Lakeshire" work.
function resolveKnown(travel, known, faction) {
	const side = faction === 1 ? 'Alliance' : 'Horde';
	const match = (k) => {
		const q = String(k).trim();
		const id = Number(q);
		return travel.taxi.nodes.filter((n) => {
			if (!(n.faction === 3 || n.faction === faction)) return false;
			if (q !== '' && Number.isInteger(id)) return n.id === id;
			const lq = q.toLowerCase();
			return n.name.toLowerCase() === lq || n.short.toLowerCase() === lq;
		});
	};
	const out = {};
	for (const k of known) {
		let hits = match(k);
		if (!hits.length && String(k).includes(',')) {
			hits = [];
			for (const part of String(k).split(',').map((s) => s.trim()).filter(Boolean)) {
				const found = match(part);
				if (!found.length) throw new Error(`no ${side} flight master matches "${part}"`);
				hits.push(...found);
			}
		}
		if (!hits.length) throw new Error(`no ${side} flight master matches "${k}"`);
		for (const n of hits) out[n.id] = true;
	}
	return out;
}

// The Lua that loads the addon planner into `ns` (Nav/Travel.lua, a
// TravelData.lua and optionally Polestar_Travel's Crossings.lua), stubbing
// the addon core; ns.Nav.PlanRoute is ready after it. Shared with batched
// runs (tools/lib/nav/arrow.js).
function plannerLua({ travelLua = path.join(NAV, 'TravelData.lua'), crossingsLua } = {}) {
	const split = grid.build.lastIndexOf('.');
	return `local noop = function() end
local ns = { L = setmetatable({}, { __index = function(_, k) return k end }), Nav = { RegisterModule = noop } }
ns.RegisterDefaults, ns.On, ns.Fire, ns.RegisterEvent, ns.OnInit, ns.OnLogin, ns.RegisterCommand, ns.Print = noop, noop, noop, noop, noop, noop, noop, noop
ns.Get = function() return true end
ns.CharState = function() return { flags = {} } end
Polestar = ns
-- An offline trip uses the build of its walking pack, not a live player's build.
GetBuildInfo = function() return ${luaLiteral(grid.build.slice(0, split))}, ${luaLiteral(grid.build.slice(split + 1))} end
${['Danger.lua', 'DangerAreas.lua', 'DangerHubs.lua', 'GroundSafety.lua'].map(file => `assert(loadfile(${luaLiteral(path.join(NAV, file))}))("Polestar", ns)`).join('\n')}
assert(loadfile(${luaLiteral(path.join(NAV, 'Travel.lua'))}))("Polestar", ns)
assert(loadfile(${luaLiteral(travelLua)}))("Polestar", ns)
${crossingsLua ? `assert(loadfile(${luaLiteral(crossingsLua)}))("Polestar_Travel", {})` : ''}`;
}

// crossingsLua: Polestar_Travel's Crossings.lua (the local crossings), loaded after TravelData.lua.
// cls: the character's class file name ("DRUID"), for a class's own flights (Nighthaven's); teleports: its class
// teleports as Transit.Teleports gives them ({ spell, name, cast, ready, to = { name, c, wx, wy, map, x, y, f } }).
function planRoute({ from, to, faction = 'Alliance', known = [], speed, hearth, dataDir = DATA, travelLua = path.join(NAV, 'TravelData.lua'), crossingsLua, cls, teleports }) {
	const read = (f) => JSON.parse(fs.readFileSync(path.join(dataDir, f), 'utf8'));
	const frames = new Frames(read('map-frames.json').era, read('zones.json'));
	const travel = read('travel.json');
	const fbit = FACTIONS[String(faction).toLowerCase()];
	if (!fbit) throw new Error(`unknown faction "${faction}" (expected Alliance or Horde)`);
	const a = frames.toWorld(from.map, from.x, from.y);
	const b = frames.toWorld(to.map, to.x, to.y);
	if (!a) throw new Error(`no Era map frame for map ${from.map}`);
	if (!b) throw new Error(`no Era map frame for map ${to.map}`);
	let inn = null;
	if (hearth) {
		const q = hearth.toLowerCase();
		const hit = travel.inns.find((i) => i.names.some((n) => n.toLowerCase() === q));
		if (!hit) throw new Error(`no inn named "${hearth}"`);
		inn = { name: hit.location, c: hit.c, wx: hit.wx, wy: hit.wy, map: hit.map, x: hit.x, y: hit.y, f: hit.f };
	}
	const params = {
		c: a.c,
		wx: a.wx,
		wy: a.wy,
		map: from.map,
		target: { c: b.c, wx: b.wx, wy: b.wy, label: `${frames.name(to.map)} ${to.x}, ${to.y}`, map: to.map, x: to.x, y: to.y, f: 'e' },
		faction: fbit,
		known: resolveKnown(travel, known, fbit),
		speed,
		hearth: inn,
		hearthName: inn ? hearth : undefined,
		teleports,
	};
	const expr = `
${plannerLua({ travelLua, crossingsLua })}
${cls ? `ns.Compat = { GetPlayerInfo = function() return { class = ${luaLiteral(cls)}, faction = ${luaLiteral(faction)} } end }` : ''}
local legs = ns.Nav.PlanRoute(${luaLiteral(params)})
if legs then for _, leg in ipairs(legs) do leg.rest = nil end end
return legs`;
	return luaToJson({ expr });
}

module.exports = { planRoute, plannerLua, resolveKnown, luaLiteral, FACTIONS };
