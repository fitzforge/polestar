#!/usr/bin/env node
// Cuts the travel golden's inputs from a full local source cache and writes its synthetic
// recordings (not run in CI):   node slice.js <data/sources> <out input dir>
// - Classic Era 1.15.9 client tables: TaxiNodes and AreaTrigger whole (a few hundred rows),
//   TaxiPath/TaxiPathNode cut to the flights between NODES.
// - Forever 1.60.1 client tables: TaxiNodes whole, TaxiPathNode cut to those paths plus the
//   Forever-only paths (its ships), TransportAnimation and SpellCastTimes whole, SpellEffect cut to
//   the teleport effects (5, 252) and SpellName/SpellMisc/SpellReagents/SkillLineAbility to their
//   spells, AreaTable as the data golden cuts it (inns' areas).
// - CMaNGOS classic-db: the cached transit.json extract (lift/tram spawns, portals, spell targets).
// - recordings: synthetic walks in Durotar (into Orgrimmar) and Elwynn Forest, cut by taxi/death.
'use strict';
const fs = require('node:fs');
const path = require('node:path');

const ERA = '1.15.9.70003';
const FOREVER = '1.60.1.70450';
// Stormwind, Sentinel Hill, Lakeshire, Ironforge, Thunder Bluff, Orgrimmar, Crossroads.
const NODES = new Set([2, 4, 5, 6, 22, 23, 25]);
const ZONES = new Set([14, 12, 2437]);

const [src, out] = process.argv.slice(2);
if (!src || !out) throw new Error('usage: slice.js <data/sources> <out>');
const read = (f) => fs.readFileSync(f, 'utf8');
const write = (f, t) => {
	fs.mkdirSync(path.dirname(f), { recursive: true });
	fs.writeFileSync(f, t);
};
function records(text) {
	const o = [];
	let start = 0;
	let q = false;
	for (let i = 0; i < text.length; i++) {
		const c = text[i];
		if (c === '"') q = !q;
		else if (c === '\n' && !q) {
			o.push(text.slice(start, i));
			start = i + 1;
		}
	}
	if (start < text.length) o.push(text.slice(start));
	return o;
}
// Fields of a record whose quoted fields hold no commas we care about (numeric columns only).
function fields(r) {
	const o = [];
	let cur = '';
	let q = false;
	for (const c of r) {
		if (c === '"') q = !q;
		else if (c === ',' && !q) {
			o.push(cur);
			cur = '';
		} else cur += c;
	}
	o.push(cur);
	return o;
}
function csv(build, table, keep) {
	const recs = records(read(path.join(src, 'wago', build, `${table}.csv`)));
	const header = recs[0].split(',');
	const col = (n) => {
		const i = header.indexOf(n);
		if (i < 0) throw new Error(`${table}.${n}?`);
		return i;
	};
	const kept = keep ? recs.slice(1).filter((r) => keep(fields(r), col)) : recs.slice(1);
	write(path.join(out, 'sources', 'wago', build, `${table}.csv`), `${[recs[0], ...kept].join('\n')}\n`);
	return kept.map(fields).map((f) => ({ f, col }));
}
const num = (f, col, n) => Number(f[col(n)]);

csv(ERA, 'TaxiNodes');
csv(ERA, 'AreaTrigger');
const paths = new Set(csv(ERA, 'TaxiPath', (f, col) => NODES.has(num(f, col, 'FromTaxiNode')) && NODES.has(num(f, col, 'ToTaxiNode'))).map(({ f, col }) => num(f, col, 'ID')));
const eraPaths = new Set(records(read(path.join(src, 'wago', ERA, 'TaxiPath.csv'))).slice(1).map((r) => Number(fields(r)[0])));
csv(ERA, 'TaxiPathNode', (f, col) => paths.has(num(f, col, 'PathID')));
csv(FOREVER, 'TaxiNodes');
csv(FOREVER, 'TaxiPathNode', (f, col) => paths.has(num(f, col, 'PathID')) || !eraPaths.has(num(f, col, 'PathID')));
csv(FOREVER, 'TransportAnimation');
csv(FOREVER, 'SpellCastTimes');
const spells = new Set(csv(FOREVER, 'SpellEffect', (f, col) => [5, 252].includes(num(f, col, 'Effect'))).map(({ f, col }) => num(f, col, 'SpellID')));
csv(FOREVER, 'SpellName', (f, col) => spells.has(num(f, col, 'ID')));
csv(FOREVER, 'SpellMisc', (f, col) => spells.has(num(f, col, 'SpellID')));
csv(FOREVER, 'SpellReagents', (f, col) => spells.has(num(f, col, 'SpellID')));
csv(FOREVER, 'SkillLineAbility', (f, col) => spells.has(num(f, col, 'Spell')));
csv(FOREVER, 'AreaTable', (f, col) => {
	const p = num(f, col, 'ParentAreaID');
	return p === 0 || ZONES.has(p) || ZONES.has(num(f, col, 'ID'));
});
const rev = '22b51464f162';
write(path.join(out, 'sources', 'cmangos', rev, 'transit.json'), read(path.join(src, 'cmangos', rev, 'transit.json')));

// Synthetic recordings: pos every 4 s along straight legs (map %, ~6 yd/s), cut by events.
function walk(legs, t0) {
	const ev = [];
	let t = t0;
	for (const leg of legs) {
		if (leg.e) {
			ev.push({ t: (t += 2), ...leg });
			continue;
		}
		const [map, x0, y0, x1, y1, n] = leg;
		for (let i = 0; i <= n; i++) {
			const r = (v) => Math.round(v * 100) / 100;
			ev.push({ t: (t += 4), e: 'pos', map, x: r(x0 + ((x1 - x0) * i) / n), y: r(y0 + ((y1 - y0) * i) / n) });
		}
	}
	return ev;
}
const session = (name, char, events) =>
	`${JSON.stringify({ schema: 1, build: '1.60.1.70450', session: name, char, started: 0, ended: events[events.length - 1].t, events, maps: {} }, null, '\t')}\n`;
write(
	path.join(out, 'recordings', 'walk-durotar.json'),
	session('walk-durotar', { name: 'Walker', realm: 'Fixture', race: 'Orc', class: 'WARRIOR', faction: 'Horde' }, walk([[1411, 42, 68, 45.5, 50, 36], [1411, 45.5, 50, 45.5, 12, 76], [1454, 49, 95, 49, 80, 20], { e: 'bind', map: 1454, x: 54, y: 68 }, [1454, 52, 70, 50, 78, 10], { e: 'death' }, [1411, 52, 42, 52.5, 44, 4]], 0)),
);
write(
	path.join(out, 'recordings', 'walk-elwynn.json'),
	session('walk-elwynn', { name: 'Stroller', realm: 'Fixture', race: 'Human', class: 'MAGE', faction: 'Alliance' }, walk([[1429, 48, 42, 46, 52, 20], [1429, 46, 52, 42.5, 64, 24], { e: 'taxi', map: 1429, x: 42.5, y: 64 }, [1429, 42, 66, 40, 70, 8]], 0)),
);
