'use strict';
// Planner events -> `.guide` text (docs/GUIDE_FORMAT.md). Ids are written
// wherever the compiler resolves names and coordinates from data; places get
// explicit `goto` coordinates and readable labels.

function quote(s) {
	return `"${String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"')}"`;
}

// Rest-of-line text (step titles, tips): nothing the lexer would cut short.
function plain(s) {
	return String(s)
		.replace(/[\r\n\t]+/g, ' ')
		.replace(/ -- /g, ' - ')
		.replace(/(^|\s)#/g, '$1')
		.replace(/\s+/g, ' ')
		.trim();
}

function coord(pt) {
	return `${pt.x.toFixed(1)},${pt.y.toFixed(1)}`;
}

// `goto` coordinates are read in the guide's `coords` frame (era by default);
// points from live-frame (recorded) spawns say so.
function gotoLine(pt, label) {
	return `goto ${coord(pt)} ${quote(label)}${pt.f === 'l' ? ' live' : ''}`;
}

function joinNames(names) {
	const u = [...new Set(names)];
	if (u.length <= 1) return u[0] || '';
	return `${u.slice(0, -1).join(', ')} and ${u[u.length - 1]}`;
}

const onlyKey = (only) => (only && only.length ? only.join(',') : '');

function goalOnly(g) {
	if (g.only !== undefined) return g.only;
	return g.q ? g.q.only : null;
}

function goalLine(g) {
	const q = g.q;
	switch (g.verb) {
		case 'accept': {
			let s = `accept ${q.id}`;
			if (g.pickup) s += ` item ${g.pickup.item}`;
			else if (q.starters.length > 1) s += ` ${g.ent.kind} ${g.ent.id}`;
			if (g.optional) s += ' optional';
			return { s, note: g.pickup ? `${g.pickup.ent.kind === 'npc' ? 'Drops from' : 'Found in'} ${g.pickup.ent.name}` : null };
		}
		case 'turnin': {
			let s = `turnin ${q.id}`;
			if (q.enders.length > 1) s += ` ${g.ent.kind} ${g.ent.id}`;
			return { s };
		}
		case 'kill':
			return { s: `kill ${g.o.id} x${g.o.count} quest ${q.id}.${g.o.oi}` };
		case 'collect':
			return { s: `collect ${g.o.id} x${g.o.count} quest ${q.id}.${g.o.oi}` };
		case 'interact':
			// The objective link carries the count; interact takes no xN.
			return { s: `interact ${g.o.id} quest ${q.id}.${g.o.oi}` };
		case 'buy':
			// The nearest vendor of the player's faction when the step comes up,
			// not the one the route was planned at.
			return { s: `buy ${g.o.id} x${g.o.count} nearest`, note: `for ${q.title}` };
		case 'goto': {
			const note = g.o.type !== 'event' ? null : g.o.label === q.title ? 'Exploration objective' : `Explore for ${q.title}`;
			return { s: gotoLine(g.o.pt, g.o.label), note };
		}
		case 'train':
			return { s: `train ${g.ent.id}` };
		default:
			throw new Error(`emit: unknown goal verb ${g.verb}`);
	}
}

function stepTitle(ev) {
	if (ev.type === 'npc' || ev.type === 'train') return ev.ent.name;
	if (ev.type === 'level') return `Grind to level ${ev.level}`;
	// Buys are named for their items ("Buy Holy Candle"): the vendor is the game's pick.
	const names = ev.goals.filter((g) => g.verb !== 'buy').map((g) => (g.pickup ? g.pickup.ent.name : g.o.label));
	const buys = ev.goals.filter((g) => g.verb === 'buy').map((g) => g.o.label);
	if (buys.length) names.push(`Buy ${joinNames(buys)}`);
	return joinNames(names);
}

function emitGuide(plan, h) {
	const zoneById = new Map(h.zones.map((z) => [z.id, z]));
	const zoneRef = (id) => {
		const z = zoneById.get(id);
		return z && z.name && z.unique ? z.name : `map ${id}`;
	};
	const lines = [
		`guide ${h.id}`,
		`title ${plain(h.title)}`,
		`faction ${h.faction}`,
		`race ${h.race}`,
	];
	if (h.class) lines.push(`class ${h.class}`);
	lines.push(`levels ${h.levelMin}-${h.levelMax}`, `zone ${zoneRef(h.zones[0].id)}`);
	if (h.next) lines.push(`next ${h.next}`);
	for (const c of h.comments || []) lines.push(`# ${plain(c)}`);

	let zone = h.zones[0].id;
	for (const ev of plan.events) {
		lines.push('', `step ${plain(stepTitle(ev))}`);
		if (ev.pt && ev.pt.map !== zone) {
			zone = ev.pt.map;
			lines.push(`  zone ${zoneRef(zone)}`);
		}
		const onlys = (ev.goals || []).map(goalOnly);
		const shared = onlys.length && onlys.every((o) => onlyKey(o) && onlyKey(o) === onlyKey(onlys[0])) ? onlyKey(onlys[0]) : '';
		if (shared) lines.push(`  only ${shared}`);
		if (ev.type === 'level') {
			if (ev.ent) lines.push(`  tip Kill ${plain(ev.ent.name)} around here until level ${ev.level}.`);
			if (ev.pt) lines.push(`  ${gotoLine(ev.pt, ev.ent.name)}`);
			lines.push(`  level ${ev.level}`);
			continue;
		}
		// Kill, drop and object goals get their spawn areas from the data, so the
		// arrow leads to them without a goto (lint warns on one there). A buy
		// leads to the nearest vendor: a goto would fix the place again.
		const located = ev.goals.length && ['kill', 'collect', 'interact', 'buy'].includes(ev.goals[0].verb);
		const ownGoto = ev.goals.some((g) => g.verb === 'goto' && coord(g.o.pt) === coord(ev.pt) && g.o.pt.map === ev.pt.map);
		if (ev.type === 'obj' && !ownGoto && !located) lines.push(`  ${gotoLine(ev.pt, stepTitle(ev))}`);
		ev.goals.forEach((g, i) => {
			const { s, note } = goalLine(g);
			const own = shared ? '' : onlyKey(onlys[i]);
			lines.push(`  ${s}${own ? ` only ${own}` : ''}${note ? ` -- ${plain(note)}` : ''}`);
		});
	}
	return `${lines.join('\n')}\n`;
}

module.exports = { emitGuide };
