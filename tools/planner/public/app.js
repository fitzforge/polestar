// The route planner page: loads the route's Timeline, plays it on the map
// (requestAnimationFrame clock), edits the .guide source through the
// server's commands, and follows what MCP agents ask it to show.
import { MapView } from './map/mapview.js';
import { cmd, commands, events, reportView } from './api.js';
import { h, $, clear, glyph, dropdown, debounce, goalText, goalIconEl, nameColor, verbMeta, popover, closePopover, popoverOpen } from './ui/dom.js';
import { S, on, emit, loadPrefs, savePrefs, indexTimeline, guideOfStep, stepAt, stepHolds, stepOfLine } from './ui/state.js';
import { goalAt, stateAt, eventsBy } from './ui/playback.js';
import { stepsList } from './ui/steps.js';
import { characterPanel, className, raceName } from './ui/character.js';
import { stepEditor } from './ui/editor.js';
import { topbar, raceOptions } from './ui/topbar.js';
import { transport, SPEEDS } from './ui/transport.js';
import { openLibrary, closeLibrary, characterFor, guideAudience } from './ui/library.js';
import { changesDrawer } from './ui/changes.js';
import { mapController } from './ui/mapctl.js';
import { registerWebMcp } from './ui/webmcp.js';
import { toast } from './ui/toasts.js';
import * as edits from './ui/edits.js';

const LAYERS = [
	['terrain', 'Terrain'],
	['zoneArt', 'Zone art'],
	['route', 'Route'],
	['labels', 'Labels'],
	['spawns', 'Spawns'],
	['grid', 'ADT grid'],
	['walkable', 'Walkable'],
	['roads', 'Roads'],
	['hubs', 'Hubs'],
	['aids', 'Arrow aids'],
];
// Layers offered only when the planner has their data: the navigation grid, the roads and hubs layers, the arrow aids.
const layerOffered = ([k]) => (k === 'walkable' ? !!(S.info.nav && S.info.nav.available) : k === 'roads' ? !!S.roads : k === 'hubs' ? !!S.hubs : k === 'aids' ? !!S.aids : true);

// What the route layer draws (S.extent): the bird's-eye 'route' shows every
// leg from the start guide to the end, simplified by the renderer per zoom.
const EXTENTS = [
	['step', 'Around the step'],
	['guide', 'This guide'],
	['route', 'Whole route'],
];

let map = null;          // MapView, null when WebGL2 or the art is unavailable
let mc = null;           // map controller
let bar, list, panel, editor, tp, drawer;
let editTarget = null;   // { id, index }: the GuideView step the editor shows
let tlSeq = 0;
let lastPanelAt = 0;
let panelKey = '';
let bannerKey = '';
let mapNote = null;
let keptNote = null;     // [text, kind]: the note an add-waypoint hint covers

// ---------------------------------------------------------------- boot

async function main() {
	const [info, guides, schema, cmds] = await Promise.all([
		cmd('planner_info'),
		cmd('guides_list', {}),
		cmd('verbs_schema'),
		commands().catch(() => []),
	]);
	S.info = info;
	S.guides = guides;
	S.guideById = new Map(guides.map((g) => [g.id, g]));
	S.verbs = schema.verbs;
	S.commands = cmds;

	const prefs = loadPrefs();
	const def = info.defaults || {};
	S.start = prefs.start && S.guideById.has(prefs.start) ? prefs.start : def.start || (guides[0] && guides[0].id);
	const ch = prefs.character || def.character;
	if (ch && raceOptions().some((o) => o.race === ch.race && o.faction === ch.faction && o.classes.includes(ch.cls))) S.character = { ...ch };
	else if (def.character) S.character = { ...def.character };
	S.startLevel = prefs.startLevel || null;
	S.choices = prefs.choices || {};
	S.optional = prefs.optional === true;
	S.speed = SPEEDS.includes(prefs.speed) ? prefs.speed : 32;
	S.follow = prefs.follow !== false;
	if (prefs.layers) S.layers = { ...S.layers, ...prefs.layers };
	if (EXTENTS.some(([k]) => k === prefs.extent)) S.extent = prefs.extent;

	buildUi();
	await initMap();
	$('#boot').remove();

	let greeted = false;
	events({
		status(up) {
			S.connected = up;
			bar.update();
		},
		// Every hello after the first is a reconnect: changes made while the
		// stream was down sent no events, so reload what the page shows.
		hello() {
			drawer.refresh();
			if (greeted) resync();
			greeted = true;
		},
		changed: onChanged,
		diagnostics: onDiagnostics,
		// Progress of the walks being routed for the timeline shown (other pages' timelines route too).
		routing(d) {
			if (!S.routing || S.routing.id !== d.id) return;
			S.routing = d;
			routingHeard = true;
			tp.setRouting();
		},
		focus: onFocus,
		seek(d) {
			if (typeof d.t === 'number') seek(d.t, { fit: true });
		},
		play(d) {
			if (d.speed) setSpeed(nearestSpeed(d.speed));
			setPlaying(!!d.playing);
		},
	});
	registerWebMcp(cmds);
	drawer.refresh();
	await loadTimeline({ keep: false });
	requestAnimationFrame(tick);
}

function nearestSpeed(s) {
	return SPEEDS.reduce((a, b) => (Math.abs(b - s) < Math.abs(a - s) ? b : a), SPEEDS[0]);
}

// ---------------------------------------------------------------- layout

function buildUi() {
	bar = topbar($('#topbar'), {
		undo: () => doUndo(false),
		redo: () => doUndo(true),
		openLibrary: () => openLibrary(pickGuide),
		setMode,
		setCharacter(character, level, optional) {
			S.character = character;
			S.startLevel = level;
			S.optional = optional;
			savePrefs();
			bar.update();
			loadTimeline({ keep: false });
		},
		toggleChanges: () => drawer.toggle(),
		compile,
		shownGuideId: () => {
			const g = guideOfStep(S.step);
			return g ? g.id : null;
		},
	});

	list = stepsList($('#steps'), {
		onSelect: (i) => selectStep(i, { seek: true, fit: true }),
		onChoice(gid, next) {
			S.choices = { ...S.choices, [gid]: next };
			savePrefs();
			loadTimeline({ keep: true });
		},
	});

	const side = $('#side-panel');
	panel = characterPanel(side);
	editor = stepEditor(side, {
		apply: (ops, label) => edits.apply(editTarget.id, ops, label),
		showGoal(goal) {
			if (map && goal.world) map.fitWorld(goal.world.c, [[goal.world.wx, goal.world.wy]], { padding: 120, animate: true, maxZoom: 2 });
		},
		insertLocated: (verb, step, index) => insertLocated(verb, step, index, null),
		insertStep,
		selectLine: (line) => focusEditLine(editTarget.id, line),
		levelNow: () => (S.timeline && S.timeline.steps[S.step] ? S.timeline.steps[S.step].levelEnd : 1),
	});
	editor.el.hidden = true;

	tp = transport($('#transport'), {
		togglePlay: () => setPlaying(!S.playing),
		stepBy,
		seek: (t, { scrub }) => seek(t, { fit: !scrub }),
		stepAt,
		setSpeed,
	});
	tp.setSpeed(S.speed);
	tp.setPlaying(false);

	drawer = changesDrawer({ focusFileLine });
	on('changes', () => bar.update());
	on('lint', () => list.refresh());
	on('guide', onGuideView);
	on('edited', onEdited);

	buildMapChrome();
	document.addEventListener('keydown', onKey);
	bar.update();
}

function buildMapChrome() {
	const head = $('#map-head');
	const sel = h('select#map-select', { title: 'Continent' });
	for (const c of S.info.continents || []) sel.append(h('option', { value: String(c.c) }, c.name));
	sel.append(h('option', { value: 'world' }, 'World'));
	sel.addEventListener('change', () => {
		if (!map) return;
		if (sel.value === 'world') map.setMode('world');
		else {
			map.setMode('continent');
			map.setContinent(Number(sel.value));
		}
	});
	const follow = h('button', { class: `btn ghost${S.follow ? ' on' : ''}`, title: 'Keep the character in view while playing', 'aria-pressed': String(S.follow) }, glyph(S.follow ? 'eye' : 'eye-off'), 'Follow');
	follow.addEventListener('click', () => {
		S.follow = !S.follow;
		follow.classList.toggle('on', S.follow);
		follow.setAttribute('aria-pressed', String(S.follow));
		follow.firstChild.replaceWith(glyph(S.follow ? 'eye' : 'eye-off'));
		savePrefs();
	});
	const layersBtn = h('button.btn.ghost', { title: 'Map layers and how much route to draw' }, glyph('layers'), 'Layers', glyph('chevron-down'));
	layersBtn.addEventListener('click', () => {
		const row = (label, on, fn) => {
			const b = h('button', { class: on ? 'on' : '', role: 'menuitemcheckbox', 'aria-checked': String(on) }, label, glyph('check', 'chk'));
			b.addEventListener('click', () => fn(b));
			return b;
		};
		const boxes = LAYERS.filter(layerOffered).map(([k, label]) => row(label, !!S.layers[k], (b) => {
			S.layers[k] = !S.layers[k];
			b.classList.toggle('on', S.layers[k]);
			b.setAttribute('aria-checked', String(S.layers[k]));
			if (map) map.setLayer(k, S.layers[k]);
			if (k === 'aids') showOpenBorders();
			savePrefs();
		}));
		const radios = EXTENTS.map(([k, label]) => row(label, S.extent === k, (b) => {
			S.extent = k;
			for (const r of radios) {
				r.classList.toggle('on', r === b);
				r.setAttribute('aria-checked', String(r === b));
			}
			if (mc && S.step >= 0) mc.setStep(S.step, true);
			savePrefs();
		}));
		popover(h('div.menu', h('div.menu-head', 'Layers'), ...boxes, h('div.menu-sep'), h('div.menu-head', 'Route shows'), ...radios), layersBtn, { cls: 'menu-pop' });
	});
	const add = h('button.btn#add-waypoint', { title: 'Click the map to add a goto to this step', hidden: true }, glyph('pin-add'), 'Add waypoint');
	add.addEventListener('click', () => setAdding(!S.adding));
	head.append(dropdown(sel, 'quiet'), follow, layersBtn, h('span.spacer'), add);

	const wrap = $('#map-wrap');
	wrap.append(
		h('div.map-zoom',
			h('button', { title: 'Zoom in', 'aria-label': 'Zoom in', onclick: () => map && map.zoomBy(2) }, glyph('plus')),
			h('button', { title: 'Zoom out', 'aria-label': 'Zoom out', onclick: () => map && map.zoomBy(0.5) }, glyph('minus')),
			h('button', { title: 'Frame the step (F)', 'aria-label': 'Frame the step', onclick: () => mc && mc.fitStep(S.step, S.t) }, glyph('fit'))),
		h('div.map-legend',
			h('div', glyph('route'), h('i', { style: { background: 'var(--route)' } }), 'Walk'),
			h('div', { style: { color: 'var(--route-fly)' } }, glyph('icon-fly'), h('i.dash'), h('span.c-textDim', 'Flight')),
			h('div', { style: { color: 'var(--route-boat)' } }, glyph('icon-boat'), h('i.long'), h('span.c-textDim', 'Boat')),
			S.info.nav && S.info.nav.available ? [
				h('div', { style: { color: 'var(--route-swim)' } }, glyph('route'), h('i.short'), h('span.c-textDim', 'Swim')),
				h('div', { style: { color: 'var(--route-climb)' } }, glyph('route'), h('i', { style: { background: 'currentColor' } }), h('span.c-textDim', 'Climb')),
			] : null,
			h('div.map-open', { hidden: true })));
}

let openKey = '';
// The arrow aids' open borders (zone pairs walkable along their border) on
// the continent in view, under the route legend while the Arrow aids layer is on.
function showOpenBorders() {
	const el = $('.map-open');
	if (!el) return;
	const c = map && map.view ? map.view.c : null;
	const key = `${c}|${S.layers.aids}|${S.aids ? S.aids.open.length : -1}`;
	if (key === openKey) return;
	openKey = key;
	const open = S.aids && S.layers.aids ? S.aids.open.filter((o) => o.c === c) : [];
	el.hidden = !open.length;
	if (!open.length) return;
	const MAX = 8;
	clear(el).append(h('div.map-open-head', `Open borders · ${open.length}`),
		...open.slice(0, MAX).map((o) => h('div', `${o.aName || o.a} ${o.oneWay ? '→' : '–'} ${o.bName || o.b}`)),
		open.length > MAX ? h('div.c-textMuted', `${open.length - MAX} more`) : '');
}

// The navigation grid's overlays: the Walkable tiles, the Roads tiles, the Hubs and the arrow aids.
async function loadNav() {
	if (!map) return;
	try {
		const res = await fetch('/nav/roads/index.json');
		if (res.ok) {
			S.roads = (await res.json()).continents;
			map.setRoads({ tiles: S.roads });
		}
	} catch (e) {
		console.warn('roads tiles:', e);
	}
	try {
		const res = await fetch('/nav/hubs.json');
		if (res.ok) {
			S.hubs = await res.json();
			map.setHubs(S.hubs);
		}
	} catch (e) {
		console.warn('hubs:', e);
	}
	const nav = S.info.nav;
	if (!nav || !nav.available) return;
	try {
		const res = await fetch('/nav/index.json');
		if (res.ok) map.setNav({ tiles: (await res.json()).continents });
	} catch (e) {
		console.warn('nav tiles:', e);
	}
	if (!nav.aids) return;
	try {
		const res = await fetch('/nav/aids.json');
		if (!res.ok) return;
		S.aids = await res.json();
		map.setAids(S.aids);
		showOpenBorders();
	} catch (e) {
		console.warn('arrow aids:', e);
	}
}

function showMapNote(text, kind = '') {
	if (!mapNote) {
		mapNote = h('div.map-note');
		$('#map-wrap').after(mapNote);
	}
	mapNote.className = `map-note ${kind}`;
	clear(mapNote).append(glyph(kind === 'err' ? 'warning' : kind === 'hint' ? 'pin-add' : 'info'), h('span', text));
	mapNote.hidden = !text;
}

async function initMap() {
	const canvas = $('#map');
	try {
		// Labels keep clear of the controls floating over the map.
		const reserved = () => [...document.querySelectorAll('.map-head > *, .map-zoom, .map-legend, .map-banner, .map-note')]
			.filter((el) => !el.hidden && el.offsetParent).map((el) => el.getBoundingClientRect());
		map = new MapView(canvas, { artBase: '/art', reserved });
		await map.init();
	} catch (e) {
		console.warn('map unavailable:', e);
		map = null;
		showMapNote(`Map unavailable: ${e.message}`, 'err');
		return;
	}
	if (!S.info.art || !S.info.art.available) showMapNote('No map art yet: run node tools/polestar.js planner art. The route still draws on the grid.', 'warn');
	for (const [k] of LAYERS) map.setLayer(k, !!S.layers[k]);
	mc = mapController(map);
	loadNav();
	map.on('view', (v) => {
		const sel = $('#map-select');
		if (sel) sel.value = v.mode === 'world' ? 'world' : String(v.c);
		showOpenBorders();
		sendView();
	});
	map.on('marker', (d) => {
		if (d && d.step != null && d.step !== S.step) selectStep(d.step, { seek: true, fit: false });
	});
	map.on('pick', (d) => {
		if (S.mode !== 'edit' || !S.adding || !d || d.c == null) return;
		if (d.hit) return;
		setAdding(false);
		const vstep = editVStep();
		if (!vstep) return;
		const index = vstep.goals.findIndex((g) => g.line === S.goal);
		insertLocated('goto', vstep.index, index >= 0 ? index + 1 : vstep.goals.length, { c: d.c, wx: d.wx, wy: d.wy }).catch((e) => toast(e.message, 'error'));
	});
	map.on('handle', onHandle);
	map.on('leg', (d) => bendLeg(d).catch((e) => {
		map.releaseLeg();
		toast(e.message, 'error');
	}));
}

// ---------------------------------------------------------------- timeline

const refetchTimeline = debounce(() => loadTimeline({ keep: true }), 350);

// A timeline that arrives with its walks still being routed: when no routing
// event for it follows within ROUTING_WATCH ms (missed while the event
// stream reconnected, or done before the page listened), ask again once.
const ROUTING_WATCH = 10000;
let routingHeard = false;
let routingTimer = 0;
function watchRouting() {
	clearTimeout(routingTimer);
	routingHeard = false;
	if (!S.routing || !(S.routing.pending > 0)) return;
	routingTimer = setTimeout(() => {
		if (!routingHeard && S.routing) refetchTimeline();
	}, ROUTING_WATCH);
}

async function loadTimeline({ keep }) {
	if (!S.start) return;
	const seq = ++tlSeq;
	S.loading = true;
	setBanner('Playing the route…');
	if (!keep || !S.timeline) list.loading();
	// The selection survives a reload as (guide, source line).
	let keepSel = null;
	if (keep && S.timeline && S.step >= 0) {
		const g = guideOfStep(S.step);
		const vstep = S.mode === 'edit' ? editVStep() : null;
		keepSel = vstep ? { id: editTarget.id, line: vstep.line } : g ? { id: g.id, line: S.timeline.steps[S.step].line } : null;
	}
	let tl;
	try {
		tl = await cmd('timeline_get', { start: S.start, character: S.character, choices: S.choices, startLevel: S.startLevel, optional: S.optional, view: 'full' });
	} catch (e) {
		if (seq !== tlSeq) return;
		S.loading = false;
		setBanner(`Cannot play this route: ${e.message}`);
		toast(e.message, 'error', 8000);
		return;
	}
	if (seq !== tlSeq) return;
	S.loading = false;
	S.timeline = tl;
	S.routing = tl.routing || null;
	watchRouting();
	indexTimeline(tl);
	list.reset();
	tp.setTimeline();
	if (mc) mc.setTimeline(tl);
	bannerKey = '';
	panelKey = '';
	const total = tl.totals.seconds;
	if (!keep) S.t = 0;
	S.t = Math.max(0, Math.min(S.t, total));
	let i = keepSel ? stepOfLine(keepSel.id, keepSel.line) : -1;
	if (i < 0) i = stepAt(S.t);
	S.step = -1;
	selectStep(i, { seek: !keep || !stepHolds(i, S.t), fit: !keep, reveal: true, force: true });
	bar.update();
}

function setStart(id) {
	S.start = id;
	S.t = 0;
	setPlaying(false);
	savePrefs();
	bar.update();
	loadTimeline({ keep: false });
}

// A Library pick the character cannot follow (another faction, race or class)
// plays with the guide's first fitting race (and class) instead.
function pickGuide(id) {
	const g = S.guideById.get(id);
	const ch = g ? characterFor(g, S.character) : S.character;
	if (ch && ch !== S.character) {
		S.character = ch;
		toast(`Playing as ${raceName(ch.race)} ${className(ch.cls)}: ${g.title} is for ${guideAudience(g)}`, 'info', 6000);
	}
	setStart(id);
}

// ---------------------------------------------------------------- selection & playback

function selectStep(i, { seek: doSeek = false, fit = false, reveal = true, force = false } = {}) {
	const tl = S.timeline;
	if (!tl || !tl.steps.length) return;
	i = Math.max(0, Math.min(tl.steps.length - 1, i));
	const prev = S.step;
	S.step = i;
	if (doSeek) S.t = tl.steps[i].start;
	if (prev !== i) list.select(prev, i);
	if (mc) mc.setStep(i);
	if (fit && mc) mc.fitStep(i, S.t);
	if (reveal) list.reveal(i, force || !S.playing);
	panelKey = '';
	bannerKey = '';
	if (S.mode === 'edit' && prev !== i) {
		const g = guideOfStep(i);
		const view = g && S.views.get(g.id);
		const vi = view ? view.steps.findIndex((s) => s.line === tl.steps[i].line) : -1;
		const next = g ? { id: g.id, index: vi >= 0 ? vi : tl.steps[i].si } : null;
		// A timeline reload landing on the step being edited keeps it (and its goal).
		if (!(editTarget && next && editTarget.id === next.id && editTarget.index === next.index)) {
			editTarget = next;
			S.goal = null;
		}
		refreshEditor();
	}
	bar.update();
	sendView();
}

function seek(t, { fit = false } = {}) {
	if (!S.timeline) return;
	S.t = Math.max(0, Math.min(S.timeline.totals.seconds, t));
	if (!stepHolds(S.step, S.t)) {
		const i = stepAt(S.t);
		if (i !== S.step) selectStep(i, { fit, reveal: true });
	} else if (fit && mc) mc.fitStep(S.step, S.t);
	sendView();
}

function stepBy(d) {
	if (!S.timeline) return;
	selectStep(S.step + d, { seek: true, fit: true, force: true });
}

function setPlaying(on) {
	if (on && S.mode === 'edit') setMode('playback');
	if (on && S.timeline && S.t >= S.timeline.totals.seconds) S.t = 0;
	S.playing = !!on && !!S.timeline;
	if (S.playing && S.follow && mc) mc.closeIn();
	tp.setPlaying(S.playing);
	sendView();
}

function setSpeed(s) {
	S.speed = s;
	tp.setSpeed(s);
	savePrefs();
	sendView();
}

let last = 0;
function tick(now) {
	const dt = last ? Math.min(0.25, (now - last) / 1000) : 0;
	last = now;
	const tl = S.timeline;
	if (tl) {
		if (S.playing) {
			S.t += dt * S.speed;
			if (S.t >= tl.totals.seconds) {
				S.t = tl.totals.seconds;
				setPlaying(false);
			}
		}
		if (!stepHolds(S.step, S.t)) {
			const i = stepAt(S.t);
			if (i !== S.step) selectStep(i, { reveal: true });
		}
		if (mc) mc.frame(S.t, S.step, { follow: S.follow && S.mode === 'playback' && S.playing });
		tp.setTime(S.t);
		if (now - lastPanelAt > 100) {
			lastPanelAt = now;
			updatePanel();
			updateBanner();
		}
		if (S.playing) sendView();
	}
	requestAnimationFrame(tick);
}

// The character panel at most 10 times a second, and only when its inputs changed.
function updatePanel() {
	if (S.mode !== 'playback' || S.step < 0) return;
	const step = S.timeline.steps[S.step];
	if (!step) return;
	const k = eventsBy(S.step, S.t);
	const key = `${S.step}|${k}|${Math.floor(S.t)}`;
	if (key === panelKey) return;
	panelKey = key;
	panel.update(stateAt(S.step, S.t), S.t, S.step);
}

// ---------------------------------------------------------------- banner

function setBanner(text, action) {
	const b = $('#map-banner');
	clear(b).append(h('span.bt', glyph('clock'), h('span', text)));
	if (action) b.append(action);
}

function updateBanner() {
	const tl = S.timeline;
	if (!tl || S.step < 0) return;
	const step = tl.steps[S.step];
	const g = goalAt(S.step, S.t);
	const travelling = g && g.at && S.t < g.start + ((g.split && g.split.travel) || 0) && S.mode === 'playback';
	const key = `${S.mode}|${S.step}|${g ? g.line : ''}|${travelling}`;
	if (key === bannerKey) return;
	bannerKey = key;
	const b = $('#map-banner');
	const text = h('span.bt');
	const title = step.title || step.label || '';
	if (S.mode === 'edit') {
		text.append(glyph('edit'), h('span', h('em', 'Editing '), `step ${S.step + 1}: ${title}`));
	} else if (!step.applies) {
		text.append(glyph('skip'), h('span', h('em', 'Skipped '), `${title} (not for this character)`));
	} else if (g) {
		const sub = h('span', { class: `c-${nameColor(g.verb)}` }, goalText(g));
		if (travelling) text.append(glyph('route'), h('span', h('em', 'Traveling to '), sub));
		else text.append(goalIconEl(g, S.character, 's18'), h('span', h('em', `${verbMeta(g.verb).label} `), sub));
		if (g.quest && g.verb !== 'accept' && g.verb !== 'turnin' && g.verb !== 'complete') text.lastChild.append(h('span.for', ' for '), h('span.c-quest', g.quest.title));
	} else {
		text.append(glyph('list'), h('span', title));
	}
	const btn = S.mode === 'edit'
		? h('button.btn.small', { onclick: () => setMode('playback') }, glyph('play'), 'Back to playback')
		: h('button.btn.small', { onclick: () => setMode('edit') }, glyph('edit'), 'Edit this step');
	clear(b).append(text, btn);
}

// ---------------------------------------------------------------- edit mode

function setMode(mode) {
	if (mode === S.mode) return;
	S.mode = mode;
	document.body.classList.toggle('editing', mode === 'edit');
	panel.el.hidden = mode === 'edit';
	editor.el.hidden = mode !== 'edit';
	$('#add-waypoint').hidden = mode !== 'edit';
	if (mode === 'edit') {
		setPlaying(false);
		const g = guideOfStep(S.step);
		editTarget = g ? { id: g.id, index: S.timeline.steps[S.step].si } : null;
		const view = g && S.views.get(g.id);
		if (view) {
			const vi = view.steps.findIndex((s) => s.line === S.timeline.steps[S.step].line);
			if (vi >= 0) editTarget.index = vi;
		}
		refreshEditor(true);
		if (mc) mc.editLegs(true);
	} else {
		setAdding(false);
		if (mc) mc.editLegs(false);
		if (mc) map.setHandles([]);
		panelKey = '';
	}
	bannerKey = '';
	updateBanner();
	bar.update();
	sendView();
}

function editVStep() {
	if (!editTarget) return null;
	const view = S.views.get(editTarget.id);
	return view ? view.steps[editTarget.index] || null : null;
}

// Shows the edit target in the editor (loading its GuideView when needed)
// and its goals as map handles.
async function refreshEditor(fetch = false) {
	if (S.mode !== 'edit') return;
	if (!editTarget) {
		editor.show(null, null, null);
		if (mc) map.setHandles([]);
		return;
	}
	let view = S.views.get(editTarget.id);
	if (!view || fetch) {
		try {
			view = await edits.loadGuide(editTarget.id);
			// loadGuide emitted 'guide', which rendered already.
			return;
		} catch (e) {
			toast(e.message, 'error');
			return;
		}
	}
	renderEditor(view);
}

function renderEditor(view) {
	const vstep = view.steps[editTarget.index] || null;
	const tlStep = vstep ? stepOfLine(view.id, vstep.line) : null;
	editor.show(view, vstep, tlStep != null && tlStep >= 0 ? tlStep : null);
	if (mc) mc.setHandles(vstep);
}

function onGuideView(view) {
	list.refresh();
	if (S.mode === 'edit' && editTarget && editTarget.id === view.id) {
		// The timeline index of this step may have moved; the GuideView step is the truth.
		if (editTarget.line != null) {
			const vi = view.steps.findIndex((s) => s.line === editTarget.line);
			if (vi >= 0) editTarget.index = vi;
			delete editTarget.line;
		}
		if (editTarget.index >= view.steps.length) editTarget.index = Math.max(0, view.steps.length - 1);
		renderEditor(view);
	}
}

// After an edit: keep the step the edit names selected, refetch the timeline.
function onEdited({ id, select }) {
	if (select && editTarget && editTarget.id === id) {
		const view = S.views.get(id);
		const vi = view ? view.steps.findIndex((s) => select.line >= s.line && select.line <= s.end) : -1;
		if (vi >= 0 && vi !== editTarget.index) {
			editTarget.index = vi;
			renderEditor(view);
		}
		if (view && view.steps[vi] && view.steps[vi].goals.some((g) => g.line === select.line)) editor.selectGoal(select.line);
	}
	refetchTimeline();
	drawer.refresh();
}

function focusEditLine(id, line) {
	const view = S.views.get(id);
	if (!view) return;
	const vi = view.steps.findIndex((s) => line >= s.line && line <= s.end);
	if (vi < 0) return;
	editTarget = { id, index: vi };
	renderEditor(view);
	const i = stepOfLine(id, view.steps[vi].line);
	if (i >= 0) selectStep(i, { seek: true, fit: true, force: true });
}

// The map centre as a world point (where new goals land without a click).
function mapCentre() {
	const v = map && map.view;
	if (!v || v.mode !== 'continent') throw new Error('Show a continent on the map first');
	return { c: v.c, wx: v.wx, wy: v.wy };
}

// Inserts a goto/explore at a world point (the map centre by default), one edit.
async function insertLocated(verb, stepIndex, index, at) {
	const id = editTarget.id;
	const r = await edits.insertWorld(id, { step: stepIndex, index, verb, ...(at || mapCentre()) });
	const goal = r.guide.steps[stepIndex] && r.guide.steps[stepIndex].goals[index];
	if (goal) editor.selectGoal(goal.line);
}

// Inserts a step holding one goto at the map centre, one edit.
async function insertStep(index, title) {
	const id = editTarget.id;
	await edits.insertWorld(id, { step: index, title, ...mapCentre() });
	editTarget = { id, index };
	renderEditor(S.views.get(id));
}

// A leg of the selected step was bent (or clicked) at a world point. The
// waypoint's label ("Cross the bridge") is asked for at the point first, so
// the goto lands as ONE edit (one undo): right before the goal the leg leads
// to. Enter writes it with the label; Escape, "No label" or a press
// elsewhere writes it unlabelled.
async function bendLeg({ leg, c, wx, wy }) {
	if (S.mode !== 'edit' || !editTarget) return map.releaseLeg();
	const id = editTarget.id;
	const view = S.views.get(id) || (await edits.loadGuide(id));
	const si = view.steps.findIndex((s) => s.goals.some((g) => g.line === leg.goal.line));
	if (si < 0) throw new Error('That goal is not in the guide source any more');
	const index = view.steps[si].goals.findIndex((g) => g.line === leg.goal.line);
	let done = false;
	const insert = async (text) => {
		if (done) return;
		done = true;
		const r = await edits.insertWorld(id, { step: si, index, verb: 'goto', text: text || undefined, c, wx, wy });
		const goal = r.guide.steps[si] && r.guide.steps[si].goals[index];
		if (goal) editor.selectGoal(goal.line);
	};
	const fail = (e) => {
		map.releaseLeg();
		toast(e.message, 'error');
	};
	const p = map.toScreen(c, wx, wy);
	if (!p) return insert('').catch(fail);
	const cr = $('#map').getBoundingClientRect();
	const anchor = h('div', { style: { position: 'fixed', left: `${cr.left + p.x - 8}px`, top: `${cr.top + p.y + 6}px`, width: '16px', height: '4px' } });
	document.body.append(anchor);
	const input = h('input', { type: 'text', placeholder: 'Label, e.g. Cross the bridge', 'aria-label': 'Waypoint label', style: { width: '260px' } });
	const save = () => {
		const text = input.value.trim();
		insert(text).catch(fail);
		closePopover();
	};
	input.addEventListener('keydown', (e) => {
		if (e.key === 'Enter') save();
		else if (e.key === 'Escape') {
			e.stopPropagation();
			closePopover();
		}
	});
	popover(h('div', h('div.pop-title', 'New waypoint'), input,
		h('div.pop-foot', h('button.btn.ghost', { onclick: () => closePopover() }, 'No label'), h('button.btn.primary', { onclick: save }, 'Add waypoint'))),
	anchor, {
		onClose() {
			anchor.remove();
			insert('').catch(fail);
		},
	});
	input.focus();
}

function onHandle(d) {
	if (S.mode !== 'edit' || !d || d.phase !== 'end' || !editTarget) return;
	const id = editTarget.id;
	editor.selectGoal(d.id);
	const p = d.part === 'ring'
		? edits.apply(id, [{ op: 'setRadius', line: d.id, r: Math.max(1, Math.round(d.r)) }], 'Set radius')
		: edits.moveWorld(id, d.id, d.c, d.wx, d.wy);
	p.catch((e) => {
		toast(e.message, 'error');
		if (mc) mc.setHandles(editVStep());
	});
}

function setAdding(on) {
	S.adding = !!on && S.mode === 'edit';
	const btn = $('#add-waypoint');
	if (btn) btn.classList.toggle('on', S.adding);
	$('#map-wrap').classList.toggle('adding', S.adding);
	if (S.adding) {
		if (mapNote && !mapNote.hidden && !mapNote.classList.contains('hint')) keptNote = [mapNote.textContent, mapNote.classList.contains('err') ? 'err' : 'warn'];
		showMapNote('Click the map to add a goto here (Esc cancels).', 'hint');
	} else if (mapNote && mapNote.classList.contains('hint')) {
		showMapNote(...(keptNote || ['']));
		keptNote = null;
	}
}

// drop: remove the top undo (redo) entry without applying it, for an entry
// that conflicts with the file on disk and would block every older one.
async function doUndo(redo, drop = false) {
	try {
		const r = redo ? await edits.redo(drop) : await edits.undo(drop);
		const what = `${r && r.label ? ` “${r.label}”` : ''}${r && r.file ? ` in ${r.file.split('/').pop()}` : ''}`;
		if (r && r.dropped) toast(`Dropped${what} from the ${redo ? 'redo' : 'undo'} history`, 'ok', 3000);
		else toast(`${redo ? 'Redid' : 'Undid'}${what}`, 'ok', 2500);
	} catch (e) {
		if (e.code !== 'conflict') return toast(e.message, 'error');
		const t = toast([h('span', e.message), ' ', h('button.btn.small', {
			onclick: (ev) => {
				ev.stopPropagation();
				t.remove();
				doUndo(redo, true);
			},
		}, 'Drop it')], 'warn', 10000);
	}
}

async function compile() {
	const pack = S.guideById.get(S.start) ? S.guideById.get(S.start).pack : null;
	const t = toast(`Compiling ${pack || 'the pack'}…`, 'info', 60000);
	try {
		const r = await cmd('pack_compile', { pack });
		t.remove();
		const msg = r.ok
			? `Compiled ${r.guides != null ? `${r.guides} guides ` : ''}into ${r.outDir}: ${r.warnings} warnings`
			: `Compile failed: ${r.errors} errors, ${r.warnings} warnings (nothing written)`;
		toast(msg, r.ok ? (r.warnings ? 'warn' : 'ok') : 'error', 8000);
		if (Array.isArray(r.diagnostics)) {
			S.lint = r.diagnostics;
			emit('lint', S.lint);
		}
	} catch (e) {
		t.remove();
		toast(e.message, 'error');
	}
}

// ---------------------------------------------------------------- server events

function routeHas(id) {
	return !!(S.timeline && S.timeline.guides.some((g) => g.id === id));
}

async function onChanged(d) {
	// Walks routed: a page whose timeline is still being routed asks again
	// (cheap when its own timeline is not done yet: the server's cache answers).
	if (d.timeline) {
		if (S.routing) refetchTimeline();
		return;
	}
	const ids = d.guides || [];
	for (const id of ids) {
		if (!S.views.has(id)) continue;
		try {
			await edits.loadGuide(id);
		} catch (e) {
			S.views.delete(id);
		}
	}
	if (ids.some(routeHas) || !ids.length) refetchTimeline();
	if (d.external) {
		const names = (d.files || []).map((f) => f.split('/').pop()).join(', ');
		if (names) toast(`Changed on disk: ${names}`, 'info', 3000);
	}
	drawer.refresh();
}

async function resync() {
	for (const id of [...S.views.keys()]) {
		try {
			await edits.loadGuide(id);
		} catch (e) {
			S.views.delete(id);
		}
	}
	refetchTimeline();
}

async function onDiagnostics(d) {
	for (const [id, view] of S.views) {
		if (d.pack && view.pack !== d.pack) continue;
		try {
			await edits.loadGuide(id);
		} catch (e) {
			S.views.delete(id);
		}
	}
	list.refresh();
}

// An agent asks the page to show a guide line or step.
async function onFocus(d) {
	if (!d || !d.id) return;
	if (!routeHas(d.id)) {
		S.start = d.id;
		savePrefs();
		await loadTimeline({ keep: false });
	}
	const tl = S.timeline;
	if (!tl) return;
	let i = -1;
	if (d.line != null) i = stepOfLine(d.id, d.line);
	else if (d.step != null) {
		const gi = tl.guides.findIndex((g) => g.id === d.id);
		if (gi >= 0) i = tl.steps.findIndex((s) => s.gi === gi && s.si === d.step);
	} else {
		const g = tl.guides.find((x) => x.id === d.id);
		if (g) i = g.s0;
	}
	if (i < 0) return;
	selectStep(i, { seek: true, fit: true, force: true });
	if (S.mode === 'edit' && d.line != null) {
		await refreshEditor(!S.views.has(d.id));
		editor.selectGoal(d.line);
	}
}

function focusFileLine(file, line) {
	const g = S.guides.find((x) => x.file === file || file.endsWith(x.file) || x.file.endsWith(file));
	if (!g) return;
	drawer.close();
	onFocus({ id: g.id, line });
}

function sendView() {
	const g = guideOfStep(S.step);
	const step = S.timeline && S.timeline.steps[S.step];
	reportView({
		guide: g ? g.id : null,
		step: S.step,
		line: step ? step.line : null,
		t: Math.round(S.t * 10) / 10,
		mode: S.mode,
		playing: S.playing,
		speed: S.speed,
		start: S.start,
		character: S.character,
		startLevel: S.startLevel,
		optional: S.optional,
		camera: map ? map.view : null,
		goal: S.mode === 'edit' ? S.goal : null,
	});
}

// ---------------------------------------------------------------- keyboard

function onKey(e) {
	const tag = e.target && e.target.tagName;
	const typing = tag === 'INPUT' || tag === 'TEXTAREA' || tag === 'SELECT' || (e.target && e.target.isContentEditable);
	const mod = e.ctrlKey || e.metaKey;
	if (e.key === 'Escape') {
		if (closePopover() || closeLibrary() || drawer.close()) return e.preventDefault();
		if (S.adding) return setAdding(false);
		if (typing) return e.target.blur();
		return;
	}
	if (mod && (e.key === 'z' || e.key === 'Z')) {
		if (typing) return;
		e.preventDefault();
		doUndo(e.shiftKey);
		return;
	}
	if (mod && (e.key === 'y' || e.key === 'Y')) {
		if (typing) return;
		e.preventDefault();
		doUndo(true);
		return;
	}
	if (typing || mod || e.altKey || popoverOpen()) return;
	switch (e.key) {
		case ' ':
			e.preventDefault();
			setPlaying(!S.playing);
			break;
		case 'ArrowRight':
		case 'ArrowDown':
			e.preventDefault();
			stepBy(1);
			break;
		case 'ArrowLeft':
		case 'ArrowUp':
			e.preventDefault();
			stepBy(-1);
			break;
		case 'e':
		case 'E':
			setMode(S.mode === 'edit' ? 'playback' : 'edit');
			break;
		case 'f':
		case 'F':
			if (mc) mc.fitStep(S.step, S.t);
			break;
		default:
			break;
	}
}

main().catch((e) => {
	console.error(e);
	const boot = $('#boot');
	if (boot) {
		boot.classList.add('err');
		boot.textContent = `The planner could not start:\n${e.message}`;
	}
});
