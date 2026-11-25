'use strict';
// `nav city extract`: players' recordings (the private archive of session files, `forge record pull`) -> one line per
// session that moves on an area's map: <out>/<uiMap>.jsonl ({ sid, who, fac, lvl, ev: [[t, kind, map, x, y, flags,
// speed, extra], ...] }), plus <out>/totals.json. PRIVATE: raw positions; <out> must never be committed or shipped
// (only `nav city trails`' aggregated counts leave the build machine).
//
// Kept per session: `pos` breadcrumbs, the NPC windows (offer, gossip, vendor, trainer, turnin, accept, detail, fp,
// bind) whose npc pins the player's floor, and what cuts a walk (zone, taxi, land, enter, death, revive, ride). The
// archive's config.json `exclude` contributors are left out.

const fs = require('node:fs');
const path = require('node:path');

const KEEP = new Set(['pos', 'zone', 'offer', 'gossip', 'vendor', 'trainer', 'turnin', 'accept', 'fp', 'taxi', 'land', 'bind', 'death', 'revive', 'ride', 'enter', 'detail', 'session']);
const EXTRA = ['npc', 'subzone', 'zone', 'indoors', 'on', 'node', 'fromNode', 'toNode', 'inst'];

function extract({ recordings, out, maps, log = () => {} }) {
	fs.mkdirSync(out, { recursive: true });
	const cfg = path.join(recordings, 'config.json');
	const excl = new Set(fs.existsSync(cfg) ? JSON.parse(fs.readFileSync(cfg, 'utf8')).exclude || [] : []);
	const want = new Set(maps);
	const fh = new Map(maps.map((m) => [m, fs.openSync(path.join(out, `${m}.jsonl`), 'w')]));
	const tot = { sessions: 0, hours: 0, people: new Set(), excluded: 0, maps: Object.fromEntries(maps.map((m) => [m, 0])) };
	const files = fs.readdirSync(recordings).filter((f) => /^2\d{7}T.*\.json$/.test(f)).sort();
	files.forEach((f, i) => {
		let d;
		try {
			d = JSON.parse(fs.readFileSync(path.join(recordings, f), 'utf8'));
		} catch {
			return;
		}
		if (excl.has(d.contributor)) {
			tot.excluded++;
			return;
		}
		const ev = d.events || [];
		tot.sessions++;
		tot.people.add(d.contributor);
		if (d.started && d.ended) tot.hours += Math.max(0, d.ended - d.started) / 3600;
		const on = new Set();
		for (const e of ev) if (want.has(e.map) && e.e === 'pos') on.add(e.map);
		for (const m of on) {
			const rows = [];
			let cur = null;
			for (const e of ev) {
				const em = e.map;
				if (em !== undefined && em !== null) cur = em;
				if (!KEEP.has(e.e)) continue;
				if ((em === undefined || em === null) && cur !== m && e.e !== 'taxi' && e.e !== 'session') continue;
				if (em !== undefined && em !== null && em !== m && !['zone', 'land', 'session', 'enter'].includes(e.e)) continue;
				let extra = null;
				for (const k of EXTRA) if (e[k] !== undefined) (extra = extra || {})[k] = e[k];
				rows.push([e.t, e.e, em === undefined ? null : em, e.x === undefined ? null : e.x, e.y === undefined ? null : e.y, e.flags === undefined ? null : e.flags, e.speed === undefined ? null : e.speed, extra]);
			}
			tot.maps[m]++;
			fs.writeSync(fh.get(m), JSON.stringify({ sid: f.slice(0, -5), who: d.contributor, fac: (d.char || {}).faction || null, lvl: (d.char || {}).level || null, ev: rows }) + '\n');
		}
		if (i % 1000 === 0) log(`extract: ${i}/${files.length}`);
	});
	for (const fd of fh.values()) fs.closeSync(fd);
	const summary = { ...tot, people: tot.people.size, hours: Math.round(tot.hours) };
	fs.writeFileSync(path.join(out, 'totals.json'), JSON.stringify(summary, null, 1));
	return summary;
}

module.exports = { extract };
