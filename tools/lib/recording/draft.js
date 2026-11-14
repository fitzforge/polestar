'use strict';
// A recorded session (data/recordings/<session>.json) -> a draft guide in the
// .guide DSL (docs/GUIDE_FORMAT.md), for an author to edit.
//
//   const { draftGuide } = require('./recording/draft');
//   const { id, name, text } = draftGuide(session);
//
// The route becomes steps clustered by place and time: quest-giver visits
// (accept/turnin/getfp/sethome/train/vendor) group when they are close
// together; objective work (kill/collect at the centroid of where the
// objective advanced) groups by area. A flight ends its step. Map changes
// emit `zone` directives; `/psrec mark` notes become `note` lines; levels,
// deaths and abandons become author comments.

// Clustering thresholds.
const HUB_RADIUS = 100; // yards from the step's first goal for NPC visits (a small town)
const HUB_GAP = 300; // seconds between goals of one NPC-visit step
const FIELD_RADIUS = 250; // yards for objective work
const FIELD_GAP = 900;
const MAX_GOALS = 10;
// Map size when the session has no bounds for a map (a typical zone).
const FALLBACK_W = 3500;
const FALLBACK_H = 2333;

const CLASS_NAMES = {
	WARRIOR: 'Warrior', PALADIN: 'Paladin', HUNTER: 'Hunter', ROGUE: 'Rogue', PRIEST: 'Priest',
	SHAMAN: 'Shaman', MAGE: 'Mage', WARLOCK: 'Warlock', DRUID: 'Druid',
};
const RACE_NAMES = { Scourge: 'Undead' }; // client race file -> DSL name; others are identical
const UI_MAP_TYPE_ZONE = 3;

function className(classFile) {
	if (!classFile) return null;
	return CLASS_NAMES[classFile] || classFile.charAt(0) + classFile.slice(1).toLowerCase();
}

function raceName(raceFile) {
	if (!raceFile) return null;
	return RACE_NAMES[raceFile] || raceFile;
}

// "double quoted" token with the DSL's escapes. ` -- ` would start a note and
// a newline would end the line, so neither survives.
function quote(s) {
	const clean = String(s)
		.replace(/[\r\n]+/g, ' ')
		.replace(/\s--\s/g, ' - ')
		.replace(/\\/g, '\\\\')
		.replace(/"/g, '\\"');
	return `"${clean}"`;
}

// Free text for `step` titles and `zone` names: rest of line, so no `#`
// (comment) and no ` -- ` (note).
function plain(s) {
	return String(s).replace(/[\r\n]+/g, ' ').replace(/#/g, '').replace(/\s--\s/g, ' - ').replace(/\s+/g, ' ').trim();
}

// A flight point's town: its name before the first comma ("Sentinel Hill,
// Westfall" -> "Sentinel Hill"), what a `fly` goal names (docs/GUIDE_FORMAT.md).
function town(name) {
	return String(name).split(',')[0].trim();
}

function num(v) {
	return Math.min(100, Math.max(0, v)).toFixed(1);
}

function at(p) {
	return p && typeof p.x === 'number' && typeof p.y === 'number' ? ` @${num(p.x)},${num(p.y)}` : '';
}

function mapSize(maps, map) {
	const m = maps[String(map)];
	if (m && typeof m.left === 'number' && typeof m.right === 'number' && typeof m.top === 'number' && typeof m.bottom === 'number') {
		const w = Math.abs(m.right - m.left);
		const h = Math.abs(m.bottom - m.top);
		if (w > 0 && h > 0) return [w, h];
	}
	return [FALLBACK_W, FALLBACK_H];
}

function yards(maps, map, a, b) {
	if (!a || !b || typeof a.x !== 'number' || typeof b.x !== 'number') return 0;
	const [w, h] = mapSize(maps, map);
	const dx = ((a.x - b.x) * w) / 100;
	const dy = ((a.y - b.y) * h) / 100;
	return Math.hypot(dx, dy);
}

function zoneLine(maps, map) {
	const m = maps[String(map)];
	if (m && m.name && plain(m.name) && (m.type === undefined || m.type === UI_MAP_TYPE_ZONE)) return `zone ${plain(m.name)}`;
	return `zone map ${map}`;
}

function objectiveLabel(text) {
	return String(text || '').replace(/:\s*\d+\s*\/\s*\d+\s*$/, '').trim();
}

function centroid(points) {
	let x = 0;
	let y = 0;
	for (const p of points) {
		x += p.x;
		y += p.y;
	}
	return { x: x / points.length, y: y / points.length };
}

function mostCommon(counts) {
	let best = null;
	for (const [key, n] of counts) if (!best || n > best[1]) best = [key, n];
	return best ? best[0] : null;
}

function pad(n) {
	return String(n).padStart(2, '0');
}

// Events of quests abandoned later (and never turned in in between) do not
// belong in the route, including quests accepted before this recording.
function abandonedIndices(events) {
	const open = new Map();
	const abandoned = new Set();
	const dropped = new Set();
	// Kills may be appended after an abandon with their earlier death time.
	const indices = [...events.keys()].sort((a, b) => events[a].t - events[b].t || a - b);
	indices.forEach((i) => {
		const ev = events[i];
		if (ev.e === 'accept') {
			abandoned.delete(ev.q);
			open.set(ev.q, [i]);
		} else if ((ev.e === 'progress' || ev.e === 'kill' || ev.e === 'loot') && ev.q !== undefined) {
			// A delayed record can be clamped to a new chunk's start, tying the
			// abandon. Once closed, only a recorded accept opens another attempt.
			// Before the first abandon, work may belong to a pre-recording quest.
			if (abandoned.has(ev.q)) {
				dropped.add(i);
				return;
			}
			if (!open.has(ev.q)) open.set(ev.q, []);
			open.get(ev.q).push(i);
		} else if (ev.e === 'abandon') {
			for (const j of open.get(ev.q) || []) dropped.add(j);
			open.delete(ev.q);
			abandoned.add(ev.q);
		} else if (ev.e === 'turnin') open.delete(ev.q);
	});
	return dropped;
}

// session -> { id, name, text }. `pack`: the id of the guide pack the draft
// belongs to; another pack's drafts are `<pack>/draft/...`, ours `draft/...`.
function draftGuide(session, { pack = 'guides' } = {}) {
	const events = Array.isArray(session.events) ? session.events : [];
	const maps = session.maps || {};
	const char = session.char || {};
	const dropped = abandonedIndices(events);
	const live = (i) => !dropped.has(i);

	// Titles, accepted quests, objectives.
	const titles = new Map();
	const accepted = new Set();
	const objectives = new Map(); // "q.oi" -> { q, oi, type, text, max, first, map, points, npcs, names, items, itemNames }
	events.forEach((ev, i) => {
		if (ev.e === 'accept' && ev.title) titles.set(ev.q, ev.title);
		if (ev.e === 'accept' && live(i)) accepted.add(ev.q);
		if (ev.e !== 'progress' || !live(i)) return;
		const key = `${ev.q}.${ev.oi}`;
		let o = objectives.get(key);
		if (!o) {
			o = { q: ev.q, oi: ev.oi, type: ev.type, text: ev.text, max: ev.max, first: i, map: ev.map, points: [], npcs: new Map(), names: new Map(), items: new Map(), itemNames: new Map() };
			objectives.set(key, o);
		}
		if (ev.max !== undefined) o.max = ev.max;
		if (ev.map === o.map && typeof ev.x === 'number') o.points.push({ x: ev.x, y: ev.y });
	});
	const objectivesOf = (q) => [...objectives.values()].filter((o) => o.q === q);
	events.forEach((ev, i) => {
		if (!live(i) || ev.q === undefined) return;
		if (ev.e === 'kill') {
			const o = objectives.get(`${ev.q}.${ev.oi}`);
			if (!o) return;
			if (ev.npc !== undefined) o.npcs.set(ev.npc, (o.npcs.get(ev.npc) || 0) + 1);
			if (ev.npcName) o.names.set(ev.npcName, (o.names.get(ev.npcName) || 0) + 1);
		} else if (ev.e === 'loot') {
			let o = ev.oi !== undefined ? objectives.get(`${ev.q}.${ev.oi}`) : null;
			if (!o && ev.itemName) o = objectivesOf(ev.q).find((c) => c.type === 'item' && String(c.text || '').includes(ev.itemName));
			if (!o) return;
			if (ev.item !== undefined) o.items.set(ev.item, (o.items.get(ev.item) || 0) + 1);
			if (ev.itemName && ev.item !== undefined) o.itemNames.set(ev.item, ev.itemName);
		}
	});

	// Route items, in event order.
	const items = [];
	const titleOf = (q) => (titles.has(q) ? ` ${quote(titles.get(q))}` : '');
	const notAccepted = (q) => (accepted.has(q) ? [] : [`# quest ${q} was accepted before this recording`]);
	let zoneMap = null;
	events.forEach((ev, i) => {
		if (!live(i)) return;
		const pos = { map: ev.map ?? zoneMap, x: ev.x, y: ev.y };
		const hub = (line, who, extra = []) => items.push({ cat: 'hub', t: ev.t, ...pos, line, who, comments: extra });
		switch (ev.e) {
			case 'zone':
				if (ev.map !== undefined) zoneMap = ev.map;
				break;
			case 'accept': {
				let line = `accept ${ev.q}${titleOf(ev.q)}`;
				if (ev.npc !== undefined) line += ` npc ${ev.npc}`;
				if (ev.object !== undefined) line += ` object ${ev.object}`;
				if (ev.item !== undefined) line += ` item ${ev.item}`;
				hub(line + at(ev), ev.npcName || ev.objName || titles.get(ev.q));
				break;
			}
			case 'turnin': {
				let line = `turnin ${ev.q}${titleOf(ev.q)}`;
				if (ev.npc !== undefined) line += ` npc ${ev.npc}`;
				if (ev.object !== undefined) line += ` object ${ev.object}`;
				hub(line + at(ev), ev.npcName || ev.objName || titles.get(ev.q), notAccepted(ev.q));
				break;
			}
			case 'fp':
				if (ev.location) hub(`getfp ${quote(ev.location)}${ev.npc !== undefined ? ` npc ${ev.npc}` : ''}${at(ev)}`, ev.npcName || ev.location);
				break;
			case 'bind':
				if (ev.location) hub(`sethome ${quote(ev.location)}${at(ev)}`, ev.location);
				break;
			case 'trainer': {
				const cls = className(char.class);
				hub(`train${ev.npc !== undefined ? ` ${ev.npc}` : ''}${at(ev)}${cls ? ` only ${cls}` : ''}`, ev.npcName);
				break;
			}
			case 'vendor':
				hub(`vendor${ev.npc !== undefined ? ` ${ev.npc}` : ''}${at(ev)}`, ev.npcName);
				break;
			case 'taxi':
				if (ev.to) items.push({ cat: 'travel', t: ev.t, map: zoneMap, line: `fly ${quote(town(ev.to))}`, who: `Fly to ${ev.to}`, comments: [] });
				break;
			case 'mark':
				if (ev.text) items.push({ cat: 'note', t: ev.t, ...pos, line: `note ${quote(ev.text)}` });
				break;
			case 'level':
				items.push({ cat: 'comment', line: `# reached level ${ev.lvl}${at(ev)}` });
				break;
			case 'death':
				items.push({ cat: 'comment', line: `# died${at(ev)}` });
				break;
			case 'abandon':
				items.push({ cat: 'comment', line: `# abandoned quest ${ev.q}${titles.has(ev.q) ? ` ${plain(titles.get(ev.q))}` : ''}` });
				break;
			case 'progress': {
				const o = objectives.get(`${ev.q}.${ev.oi}`);
				if (!o || o.first !== i) break;
				const c = o.points.length ? centroid(o.points) : null;
				const link = `${o.max > 1 ? ` x${o.max}` : ''} quest ${o.q}.${o.oi}`;
				const comments = notAccepted(o.q);
				let line;
				if (o.type === 'monster') {
					const npc = mostCommon(o.npcs);
					const name = mostCommon(o.names) || objectiveLabel(o.text).replace(/\s+slain$/i, '');
					line = `kill ${npc !== null ? npc : quote(name)}${link}${at(c)}`;
				} else if (o.type === 'item' && o.items.size) {
					const item = mostCommon(o.items);
					const name = o.itemNames.get(item);
					line = `collect ${item}${name ? ` ${quote(name)}` : ''}${link}${at(c)}`;
				} else if (c) {
					comments.push(`# quest ${o.q}.${o.oi} (${o.type || 'objective'}): no ${o.type === 'item' ? 'item' : 'target'} id recorded`);
					line = `goto ${num(c.x)},${num(c.y)} ${quote(objectiveLabel(o.text) || `Quest ${o.q} objective ${o.oi}`)}`;
				} else {
					comments.push(`# quest ${o.q}.${o.oi}: ${plain(o.text || '')} (no position recorded)`);
					line = `complete ${o.q}${titleOf(o.q)}`;
				}
				items.push({ cat: 'field', t: ev.t, map: o.map ?? pos.map, x: c ? c.x : undefined, y: c ? c.y : undefined, line, who: titles.get(o.q) || objectiveLabel(o.text), comments });
				break;
			}
			default:
				break;
		}
	});

	// Steps.
	const steps = [];
	let cur = null;
	let loose = [];
	const open = (item) => {
		cur = { cat: item.cat, map: item.map, anchor: item, last: item.t, goals: 0, closed: false, lines: loose, title: item.who };
		loose = [];
		steps.push(cur);
	};
	for (const item of items) {
		if (item.cat === 'comment') {
			(cur ? cur.lines : loose).push(item.line);
			continue;
		}
		if (item.cat === 'note' || item.cat === 'travel') {
			if (!cur || cur.closed) open(item);
		} else {
			const radius = item.cat === 'hub' ? HUB_RADIUS : FIELD_RADIUS;
			const gap = item.cat === 'hub' ? HUB_GAP : FIELD_GAP;
			const fresh =
				!cur ||
				cur.closed ||
				(cur.cat !== item.cat && cur.cat !== 'note') ||
				(item.map !== undefined && cur.map !== undefined && item.map !== cur.map) ||
				yards(maps, item.map, item, cur.anchor) > radius ||
				(typeof item.t === 'number' && typeof cur.last === 'number' && item.t - cur.last > gap) ||
				cur.goals >= MAX_GOALS;
			if (fresh) open(item);
			else if (cur.cat === 'note' || cur.cat === 'travel') {
				// A step opened by a note adopts the first real goal's kind.
				Object.assign(cur, { cat: item.cat, map: item.map, anchor: item, title: cur.title || item.who });
			}
		}
		if (cur.map === undefined && item.map !== undefined) cur.map = item.map;
		if (!cur.title && item.who) cur.title = item.who;
		for (const c of item.comments || []) cur.lines.push(c);
		cur.lines.push(item.line);
		cur.goals++;
		if (typeof item.t === 'number') cur.last = item.t;
		if (item.cat === 'travel') cur.closed = true;
	}
	if (!cur) throw new Error(`session ${session.session} has no quest, travel or mark events to draft`);
	cur.lines.push(...loose);

	// Header.
	const firstMap = events.find((ev) => ev.map !== undefined && typeof ev.x === 'number')?.map ?? events.find((ev) => ev.map !== undefined)?.map;
	if (firstMap === undefined) throw new Error(`session ${session.session} has no map data; nothing to draft`);
	const levelsSeen = [];
	for (const ev of events) {
		if (typeof ev.lvl !== 'number') continue;
		levelsSeen.push(ev.e === 'level' ? ev.lvl - 1 : ev.lvl, ev.lvl);
	}
	const minLevel = levelsSeen.length ? Math.max(1, levelsSeen[0]) : 1;
	const maxLevel = levelsSeen.length ? Math.max(minLevel, ...levelsSeen) : 60;
	const started = new Date((session.started || 0) * 1000);
	const date = `${started.getUTCFullYear()}-${pad(started.getUTCMonth() + 1)}-${pad(started.getUTCDate())}`;
	const time = `${pad(started.getUTCHours())}${pad(started.getUTCMinutes())}`;
	const faction = char.faction === 'Alliance' || char.faction === 'Horde' ? char.faction : null;
	const race = raceName(char.race);
	const slug = (s) => String(s || 'any').toLowerCase().replace(/[^a-z0-9_-]+/g, '-').replace(/^-+|-+$/g, '') || 'any';
	const id = `${pack === 'guides' ? '' : `${pack}/`}draft/${slug(faction)}/${slug(race)}/${date}-${time}`;
	const name = `${slug(faction)}-${slug(race)}-${date}-${time}`;
	const zoneName = maps[String(firstMap)]?.name;

	const out = [];
	out.push(`guide ${id}`);
	out.push(`title ${plain(zoneName || 'Recorded route')} (draft ${date})`);
	if (faction) out.push(`faction ${faction}`);
	if (race) out.push(`race ${race}`);
	out.push(`levels ${minLevel}-${maxLevel}`);
	out.push(zoneLine(maps, firstMap));
	// Recorded coordinates are in the live Forever map frame.
	out.push('coords live');
	out.push(`# drafted from recording ${session.session}: ${char.name || '?'}${char.realm ? `-${char.realm}` : ''}, ${className(char.class) || 'unknown class'}${levelsSeen.length ? '' : ', no level data'}`);

	let zone = firstMap;
	for (const step of steps) {
		out.push('');
		const title = step.title ? plain(step.title) : '';
		out.push(title ? `step ${title}` : 'step');
		if (step.map !== undefined && step.map !== zone) {
			out.push(`  ${zoneLine(maps, step.map)}`);
			zone = step.map;
		}
		for (const line of step.lines) out.push(`  ${line}`);
	}
	return { id, name, text: `${out.join('\n')}\n` };
}

module.exports = { draftGuide, quote };
