'use strict';
// Fishing + Cooking's waters (guides/forever/professions/fishing-cooking.guide, tools/lib/professions/
// pair-fishing.js over gathering/fish-rounds.js): every stand of every loop is safe for the side the loop is
// offered to (never within reach of the other faction's towns and guards, its level at least what the
// hostile creatures by its stands ask, an elite counting three levels higher), and from where each faction
// levels in a band, the one water the arrow picks (the engine's rule: travel from where the player is plus
// the laps left times the lap, never a loop two or more levels above the player while another is not) is
// the nearby water of that faction. They read the committed guide and data/forever.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { DATA, needs } = require('./helpers/data');

const GUIDE = path.join(__dirname, '..', 'guides', 'forever', 'professions', 'fishing-cooking.guide');
const skip = needs('npcs.json', 'items.json', 'zones.json', 'map-frames.json');
const RUN = 7;
const CROSS_SECONDS = 3600; // another continent: a boat or zeppelin and the rides around it

// The guide's steps with their loops: { title, only, count, loops: [{ zone, lvl, lap, per, only, live, pts }] }.
function fishingSteps() {
	const out = [];
	for (const l of fs.readFileSync(GUIDE, 'utf8').split('\n')) {
		const m = /^step (.*)$/.exec(l);
		if (m) out.push({ title: m[1], only: null, count: null, loops: [] });
		const s = out[out.length - 1];
		if (!s) continue;
		const only = /^ {2}only (.+)$/.exec(l);
		if (only) s.only = only[1];
		const c = /^ {2}collect \d+ x(\d+) /.exec(l);
		if (c && s.count === null) s.count = Number(c[1]);
		const loop = /^ {2}loop (.+?) lvl (\d+) lap (\d+) (?:gain|yield) ([\d.]+) only (\S+)( live)? r \d+ at (.+)$/.exec(l);
		if (loop) s.loops.push({ zone: loop[1], lvl: Number(loop[2]), lap: Number(loop[3]), per: Number(loop[4]), only: loop[5], live: !!loop[6], pts: loop[7].split(' ').map((p) => p.split(',').map(Number)) });
	}
	return out;
}

// Whether a character of `race` and `faction` may take something under `only` (races, then the side).
function takes(only, race, faction) {
	if (!only) return true;
	const t = only.split(',');
	const sides = t.filter((x) => x === 'Alliance' || x === 'Horde');
	const races = t.filter((x) => x !== 'Alliance' && x !== 'Horde');
	return (!sides.length || sides.includes(faction)) && (!races.length || races.includes(race));
}

let cache = null;
function world() {
	if (cache) return cache;
	const { context } = require('../tools/lib/professions/gathering/common');
	const ctx = context(DATA);
	const maps = new Map(Object.values(ctx.data.zones).map((z) => [z.name, z.id]));
	cache = { ctx, maps, steps: fishingSteps() };
	return cache;
}

const stopsOf = (w, loop) => loop.pts.map(([x, y]) => ({ pt: w.ctx.project.point(w.maps.get(loop.zone), x, y, loop.live ? 'l' : 'e') }));

test('every stand of every fishing loop is safe for the side it is offered to', { skip }, () => {
	const { pointLevels } = require('../tools/lib/professions/gathering/loop');
	const w = world();
	const bad = [];
	const seen = new Set();
	for (const s of w.steps) {
		for (const loop of s.loops) {
			const key = `${loop.zone}|${loop.only}|${loop.pts.join(' ')}`;
			if (seen.has(key)) continue;
			seen.add(key);
			assert.ok(w.maps.has(loop.zone), `unknown zone ${loop.zone}`);
			for (const faction of ['Alliance', 'Horde'].filter((f) => loop.only.split(',').includes(f))) {
				pointLevels(w.ctx, w.maps.get(loop.zone), stopsOf(w, loop), faction, { strict: true }).forEach((lv, i) => {
					if (lv === null) bad.push(`${s.title}: ${loop.zone} ${loop.pts[i]} is within reach of the ${faction === 'Alliance' ? 'Horde' : 'Alliance'}'s town or guards`);
					else if (lv > loop.lvl - 1) bad.push(`${s.title}: ${loop.zone} ${loop.pts[i]} asks level ${lv}, the loop says ${loop.lvl - 1}`);
				});
			}
		}
	}
	assert.deepEqual(bad, []);
});

// From where each side levels in a band: [step title prefix, faction, race, level, zone, x, y (Era), the water picked].
const FROM = [
	['Fish Raw Longjaw Mud Snapper (Fishing 75', 'Alliance', 'Human', 12, 'Elwynn Forest', 42, 65, 'Stormwind City'],
	['Fish Raw Longjaw Mud Snapper (Fishing 75', 'Alliance', 'Dwarf', 12, 'Loch Modan', 35, 45, 'Loch Modan'],
	['Fish Raw Longjaw Mud Snapper (Fishing 75', 'Alliance', 'NightElf', 12, 'Darkshore', 37, 44, 'Darnassus'],
	['Fish Raw Longjaw Mud Snapper (Fishing 75', 'Horde', 'Orc', 12, 'Durotar', 52, 42, 'Orgrimmar'],
	['Fish Raw Longjaw Mud Snapper (Fishing 75', 'Horde', 'Undead', 12, 'Tirisfal Glades', 60, 52, 'Silverpine Forest'],
	['Fish Raw Longjaw Mud Snapper (Fishing 75', 'Horde', 'Tauren', 12, 'Mulgore', 47, 58, 'Thunder Bluff'],
	['Fish Raw Bristle Whisker Catfish (Fishing 130', 'Alliance', 'Human', 22, 'Redridge Mountains', 30, 45, 'Redridge Mountains'],
	// From the Barrens: Stonetalon's lake by Sun Rock Retreat, the band's catfish water, a short ride west.
	['Fish Raw Bristle Whisker Catfish (Fishing 130', 'Horde', 'Orc', 22, 'The Barrens', 52, 30, 'Stonetalon Mountains'],
	['Fish Raw Mithril Head Trout', 'Horde', 'Orc', 32, 'Desolace', 25, 72, 'Desolace'],
	// Feralas to 300: Redgill and Nightfin Snapper water by Feathermoon and by Camp Mojache.
	['Fish Raw Redgill', 'Alliance', 'Human', 45, 'Feralas', 31, 45, 'Feralas'],
	['Fish Raw Redgill', 'Horde', 'Orc', 45, 'Feralas', 75, 44, 'Feralas'],
];

test('from where each side levels in a band, the arrow picks the nearby water of that side, safe at the player\'s level', { skip }, () => {
	const { dist } = require('../tools/lib/route/geo');
	const w = world();
	const got = [];
	for (const [prefix, faction, race, level, zone, x, y, want] of FROM) {
		const s = w.steps.find((st) => st.title.startsWith(prefix) && takes(st.only, race, faction));
		assert.ok(s, `${prefix} for ${race} ${faction}`);
		const at = w.ctx.project.point(w.maps.get(zone), x, y, 'e');
		const open = s.loops.filter((l) => takes(l.only, race, faction));
		assert.ok(open.length, `${s.title}: no water for ${race} ${faction}`);
		// Never a loop two or more levels above the player while another is not (the engine's rule).
		const fit = open.filter((l) => l.lvl < level + 2);
		const pool = fit.length ? fit : open;
		const seconds = (l) => {
			const first = stopsOf(w, l)[0].pt;
			const travel = first.c === at.c ? dist(at, first) / RUN : CROSS_SECONDS;
			return travel + (s.count / l.per) * l.lap;
		};
		const pick = pool.slice().sort((a, b) => seconds(a) - seconds(b))[0];
		assert.ok(pick.lvl < level + 2, `${s.title} from ${zone}: ${pick.zone} asks level ${pick.lvl - 1}`);
		// A water of the player's level on their own continent wins over any across the sea.
		const first = stopsOf(w, pick)[0].pt;
		if (fit.some((l) => stopsOf(w, l)[0].pt.c === at.c)) assert.equal(first.c, at.c, `${s.title} from ${zone}: ${pick.zone} is on another continent`);
		got.push([prefix, race, zone, pick.zone]);
		if (want) assert.equal(pick.zone, want, `${s.title} from ${zone} (${race})`);
	}
	assert.equal(got.length, FROM.length);
});
