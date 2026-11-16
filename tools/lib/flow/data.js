'use strict';
// The flow audit's inputs (tools/flow-audit.js, docs/ROUTE-FEEL.md): the compiled guides and their baked legs as the
// addon loads them (Guides.lua and Legs.lua from `forge guide compile`, read by Lua), the reference data, and the
// small models the walk prices goals with (map percent to world yards, a baked leg's points, mob and quest XP).

const fs = require('node:fs');
const path = require('node:path');
const { luaToJson } = require('../lua');

const WALK_YPS = 7.0;
const FLY_YPS = 30.0;
const XP_TO_LEVEL = [0, 400, 900, 1400, 2100, 2800, 3600, 4500, 5400, 6500, 7600, 8800, 10100, 11400, 12900,
	14400, 16000, 17700, 19400, 21300, 23200, 25200, 27300, 29400, 31700, 34000, 36400, 38900,
	41400, 44300, 47400, 50800, 54500, 58600, 62800, 67100, 71600, 76100, 80800, 85700, 90700,
	95800, 101000, 106300, 111800, 117500, 123200, 129100, 135100, 141200, 147500, 153900,
	160400, 167100, 173900, 180800, 187900, 195000, 202300, 209800];
// Extra mobs on the way and drop-rate kills (calibrated against players' recordings).
const KILL_XP_FACTOR = 1.6;

// The guides and legs of an addon folder: every Polestar_Guides* part and Polestar_Experimental (the route choices'
// experimental guides). Compiled guides call only Polestar.RegisterGuide, RegisterExperimental, RetireGuides and
// RegisterLegs; the rest are no-ops here.
const LOADER = `
__guides, __legs = {}, {}
Polestar = setmetatable({
  RegisterGuide = function(g) __guides[#__guides + 1] = g end,
  RegisterLegs = function(_, _, list)
    for id, steps in pairs(list) do
      __legs[id] = __legs[id] or {}
      for k, v in pairs(steps) do __legs[id][tostring(k)] = v end
    end
  end,
}, { __index = function() return function() end end })
`;

function compiledFiles(addon) {
	const files = [];
	for (const d of fs.readdirSync(addon).sort()) {
		if (!d.startsWith('Polestar_Guides') && d !== 'Polestar_Experimental') continue;
		for (const f of ['Guides.lua', 'Legs.lua']) {
			const p = path.join(addon, d, f);
			if (fs.existsSync(p)) files.push(p);
		}
	}
	return files;
}

// { guides: [...], legs: { guideId: { step: legString } } }
function loadCompiled(addon) {
	const files = compiledFiles(addon);
	if (!files.some((f) => f.endsWith('Guides.lua'))) throw new Error(`no compiled guides under ${addon}: run forge guide compile --out ${path.join(addon, 'Polestar_Guides')}`);
	const r = luaToJson({ files, prelude: LOADER, expr: 'return { guides = __guides, legs = __legs }', timeout: 600000 });
	return { guides: Array.isArray(r.guides) ? r.guides : [], legs: r.legs && !Array.isArray(r.legs) ? r.legs : {} };
}

function readJson(dir, file) {
	return JSON.parse(fs.readFileSync(path.join(dir, file), 'utf8'));
}

// Map percent to world yards: goals carry era-frame coordinates; Forever's frames only fill maps the era lacks.
class Proj {
	constructor(mapFrames) {
		this.frames = { ...(mapFrames.forever || {}), ...(mapFrames.era || {}) };
	}

	at(m, x, y) {
		const f = this.frames[String(m)];
		if (!f || x == null || y == null) return null;
		return [f.c, f.top + (f.bottom - f.top) * y / 100.0, f.left + (f.right - f.left) * x / 100.0];
	}
}

function dist(a, b) {
	if (a == null || b == null || a[0] !== b[0]) return Infinity;
	return Math.hypot(a[1] - b[1], a[2] - b[2]);
}

const VALUE = {};
'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'.split('').forEach((c, i) => { VALUE[c] = i; });

// The points [wx, wy] of a baked leg (pack format 7, leg versions 1 and 2), or null.
function decodeLeg(s) {
	let pos = 0;
	const nxt = () => {
		let v = 0, mul = 1;
		while (pos < s.length) {
			const d = VALUE[s[pos]];
			pos++;
			if (d === undefined) return null;
			if (d >= 32) {
				v += (d - 32) * mul;
				mul *= 32;
			} else {
				return v + d * mul;
			}
		}
		return null;
	};
	const sg = () => {
		const u = nxt();
		if (u === null) return null;
		return u % 2 ? -Math.floor((u + 1) / 2) : Math.floor(u / 2);
	};
	const ver = nxt();
	if (ver !== 1 && ver !== 2) return null;
	const n = nxt();
	if (!n || n < 2) return null;
	let qx = 0, qy = 0;
	const pts = [];
	for (let i = 0; i < n; i++) {
		const dx = sg(), dy = sg(), dz = sg();
		if (dx === null || dy === null || dz === null) return null;
		qx += dx;
		qy += dy;
		pts.push([qx * 0.5, qy * 0.5]);
	}
	return pts;
}

function mobXp(L, P) {
	if (L == null) L = P;
	const base = L * 5 + 45;
	if (L >= P) return base * (1 + 0.05 * Math.min(L - P, 4));
	const zd = P < 8 ? 5 : P < 10 ? 6 : P < 12 ? 7 : P < 16 ? 8 : P < 20 ? 9 : P < 30 ? 11 : P < 40 ? 12 : P < 45 ? 13 : P < 50 ? 14 : P < 55 ? 15 : 16;
	return P - L >= zd ? 0 : base * (1 - (P - L) / zd);
}

// Forever's quest XP: full to 5 levels over the quest, then 80, 60, 40, 20 and 10 percent.
function questXp(xp, qlvl, P) {
	if (!xp) return 0;
	if (qlvl == null || P <= qlvl + 5) return xp;
	const d = P - qlvl;
	return xp * (d === 6 ? 0.8 : d === 7 ? 0.6 : d === 8 ? 0.4 : d === 9 ? 0.2 : 0.1);
}

// A goal's spawn areas: [[point, radius 30-120 yd, spawns, mob level]] from its spawn spots (`spotsPacked`
// "x,y,z,r,n,?,lvl;..."), else its own point.
function parseSpots(g, proj) {
	const out = [];
	const sp = g.spotsPacked;
	if (sp) {
		for (const part of sp.split(';')) {
			const f = part.split(',');
			const x = Number(f[0]), y = Number(f[1]);
			if (f.length < 2 || f[0] === '' || f[1] === '' || !Number.isFinite(x) || !Number.isFinite(y)) continue;
			const r = f.length > 3 && f[3] ? Number(f[3]) : 40.0;
			const n = f.length > 4 && f[4] ? Math.trunc(Number(f[4])) : 1;
			const lvl = f.length > 6 && f[6] ? Math.trunc(Number(f[6])) : g.lvl;
			const p = proj.at(g.map, x, y);
			if (p) out.push([p, Math.max(30.0, Math.min(r, 120.0)), n, lvl]);
		}
	} else if (g.x != null) {
		const p = proj.at(g.map, g.x, g.y);
		if (p) out.push([p, 40.0, 1, g.lvl]);
	}
	return out;
}

// quest -> timer seconds: quests.json `limit` and mechanics.json quest timers (the larger wins).
function timedQuests(dataDir, quests) {
	const out = new Map();
	for (const [q, v] of Object.entries(quests)) if (v.limit) out.set(Number(q), Number(v.limit));
	const mpath = path.join(dataDir, 'mechanics.json');
	if (fs.existsSync(mpath)) {
		for (const [qid, m] of Object.entries(readJson(dataDir, 'mechanics.json').quests || {})) {
			const secs = (m.params || []).filter((p) => p.kind === 'timed' && p.what === 'quest timer' && p.seconds).map((p) => p.seconds);
			if (secs.length) out.set(Number(qid), Math.max(out.get(Number(qid)) || 0, Math.max(...secs)));
		}
	}
	return out;
}

// The reference data the walk reads.
function loadData(dataDir) {
	const quests = readJson(dataDir, 'quests.json');
	const travel = readJson(dataDir, 'travel.json');
	const proj = new Proj(readJson(dataDir, 'map-frames.json'));
	const nodes = new Map(travel.taxi.nodes.map((nd) => [nd.id, [nd.c, nd.wx, nd.wy]]));
	return {
		dataDir, quests, proj, nodes,
		races: readJson(dataDir, 'races.json'),
		zones: readJson(dataDir, 'zones.json'),
		inns: (travel.inns || []).map((i) => proj.at(i.map, i.x, i.y)).filter(Boolean),
	};
}

// Python's round(x, nd), which the audit's numbers were first written with: correct rounding of the double's exact
// value, an exact tie going to the even digit (toFixed would take the larger one).
function pyRound(x, nd = 0) {
	if (!Number.isFinite(x) || x === 0) return x === 0 ? 0 : x;
	const exact = Math.abs(x).toFixed(100);
	const [, frac = ''] = exact.split('.');
	let s;
	if (frac[nd] === '5' && /^0*$/.test(frac.slice(nd + 1))) {
		const down = Math.abs(x).toFixed(100).slice(0, exact.indexOf('.') + (nd ? nd + 1 : 0));
		const last = Number(down.replace('.', '').slice(-1));
		const lo = Number(down);
		s = last % 2 === 0 ? lo : lo + 10 ** -nd;
		s = Number(s.toFixed(nd));
	} else {
		s = Number(Math.abs(x).toFixed(nd));
	}
	const out = x < 0 ? -s : s;
	return Object.is(out, -0) ? 0 : out;
}

module.exports = { WALK_YPS, FLY_YPS, XP_TO_LEVEL, KILL_XP_FACTOR, loadCompiled, loadData, Proj, dist, decodeLeg, mobXp, questXp, parseSpots, timedQuests, pyRound };
