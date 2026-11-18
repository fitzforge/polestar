'use strict';
// `nav city freeze`: the gate's held-out trips, chosen once and kept (<priv>/<uiMap>/gate-trips.json) so every gate run
// scores the same walks. From `nav city match`'s trips.json: held-out people only (1 in 5), purposeful walks (the
// matched walk at most 4x the straight line, no long wait: dt <= walk / 3 yd/s + 90 s), one per person and pair of
// stops, round-robin over people up to max. Each trip gets its id i (its place in the list). PRIVATE output.

const fs = require('node:fs');
const path = require('node:path');

function freezeTrips({ priv, map, max = 200, force = false }) {
	const dir = path.join(priv, String(map));
	const out = path.join(dir, 'gate-trips.json');
	if (fs.existsSync(out) && !force) throw new Error(`${out} exists: the gate's trips are frozen (--force to choose them again; baselines then no longer compare)`);
	const all = JSON.parse(fs.readFileSync(path.join(dir, 'trips.json'), 'utf8'));
	const seen = new Set();
	const byWho = new Map();
	for (const t of all) {
		if (!t.test || t.L / t.straight > 4 || t.dt > t.L / 3 + 90) continue;
		const key = `${t.who}|${t.A.npc || t.A.kind}|${t.B.npc || t.B.kind}`;
		if (seen.has(key)) continue;
		seen.add(key);
		if (!byWho.has(t.who)) byWho.set(t.who, []);
		byWho.get(t.who).push(t);
	}
	const picked = [];
	for (let r = 0; picked.length < max; r++) {
		let any = false;
		for (const list of byWho.values()) {
			if (!list[r]) continue;
			any = true;
			if (picked.length < max) picked.push(list[r]);
		}
		if (!any) break;
	}
	const trips = picked.map((t, i) => ({ i, who: t.who, A: t.A, B: t.B, straight: t.straight, path: t.path, samples: t.samples }));
	fs.writeFileSync(out, JSON.stringify(trips));
	return { trips: trips.length, people: new Set(trips.map((t) => t.who)).size };
}

module.exports = { freezeTrips };
