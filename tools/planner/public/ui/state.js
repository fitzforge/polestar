// The page state every module reads, and a tiny event bus. Writers change S
// and emit; readers subscribe with on().

export const S = {
	info: null,              // planner_info
	commands: [],            // /api/commands
	verbs: null,             // verbs_schema().verbs
	guides: [],              // guides_list
	guideById: new Map(),
	start: null,             // start guide id
	character: { race: 'Dwarf', cls: 'SHAMAN', faction: 'Alliance' },
	startLevel: null,
	choices: {},             // guide id -> chosen next guide id
	optional: false,         // play optional goals (else they are skipped)
	timeline: null,
	loading: false,
	t: 0,
	playing: false,
	speed: 32,
	mode: 'playback',        // 'playback' | 'edit'
	step: -1,                // selected step index (timeline.steps)
	goal: null,              // selected goal line in edit mode
	follow: true,
	connected: false,
	views: new Map(),        // guide id -> GuideView
	changes: [],             // changes_list
	lint: null,              // lint diagnostics (last run)
	adding: false,           // the Add waypoint tool is armed
	layers: { terrain: true, zoneArt: false, route: true, labels: true, spawns: true, grid: false, walkable: false, roads: false, hubs: false, aids: false },
	routing: null,           // { pending, done } while the server routes the timeline's walks
	roads: null,             // { [c]: ['col_row'] } (GET /nav/roads/index.json) when the roads layer is built
	hubs: null,              // { [c]: [hub] } (GET /nav/hubs.json) when the hubs layer is built
	aids: null,              // GET /nav/aids.json when the planner has arrow aids
	extent: 'step',          // route drawn: 'step' (around the selected step) | 'guide' | 'route' (bird's-eye)
	stepIndex: null,         // derived per timeline: see indexTimeline()
};

const listeners = new Map();
export function on(ev, fn) {
	if (!listeners.has(ev)) listeners.set(ev, new Set());
	listeners.get(ev).add(fn);
	return () => listeners.get(ev).delete(fn);
}
export function emit(ev, data) {
	for (const fn of listeners.get(ev) || []) {
		try {
			fn(data);
		} catch (e) {
			console.error(`[${ev}]`, e);
		}
	}
}

// ---------------------------------------------------------------- persistence

const KEY = 'polestar.planner';
export function loadPrefs() {
	try {
		return JSON.parse(localStorage.getItem(KEY) || '{}') || {};
	} catch (e) {
		return {};
	}
}
export function savePrefs() {
	const prefs = {
		start: S.start,
		character: S.character,
		startLevel: S.startLevel,
		choices: S.choices,
		optional: S.optional,
		speed: S.speed,
		follow: S.follow,
		layers: S.layers,
		extent: S.extent,
	};
	try {
		localStorage.setItem(KEY, JSON.stringify(prefs));
	} catch (e) {
		// storage full or disabled: the choice is not remembered
	}
}

// ---------------------------------------------------------------- timeline lookups

// Per-timeline derived arrays: the first event of each step, the end line of
// each step in its source file and the playback warnings of each step.
export function indexTimeline(tl) {
	const n = tl.steps.length;
	const ev0 = new Int32Array(n + 1);
	let k = 0;
	for (let i = 0; i < n; i++) {
		while (k < tl.events.length && tl.events[k].s < i) k++;
		ev0[i] = k;
	}
	ev0[n] = tl.events.length;
	const endLine = new Array(n);
	for (let i = 0; i < n; i++) {
		const s = tl.steps[i];
		const nx = tl.steps[i + 1];
		endLine[i] = nx && nx.gi === s.gi ? nx.line - 1 : Infinity;
	}
	// Playback warnings by step (warning.guide is a guide id, line its source line).
	const warnings = new Map();
	for (const w of tl.warnings || []) {
		const i = stepOfLine(w.guide, w.line);
		if (i < 0) continue;
		if (!warnings.has(i)) warnings.set(i, []);
		warnings.get(i).push(w);
	}
	S.stepIndex = { ev0, endLine, warnings };
}

export function guideOfStep(i) {
	const tl = S.timeline;
	if (!tl || i < 0 || i >= tl.steps.length) return null;
	return tl.guides[tl.steps[i].gi] || null;
}

// The step playing at time t: the first applying step that has not ended
// (zero-length steps are passed over), else the last one.
export function stepAt(t) {
	const steps = S.timeline ? S.timeline.steps : [];
	if (!steps.length) return -1;
	let lo = 0;
	let hi = steps.length - 1;
	while (lo < hi) {
		const mid = (lo + hi) >> 1;
		if (steps[mid].end > t) hi = mid;
		else lo = mid + 1;
	}
	return lo;
}

// Whether time t lies in step i (both ends included).
export function stepHolds(i, t) {
	const s = S.timeline && S.timeline.steps[i];
	return !!s && t >= s.start && t <= s.end;
}

// The timeline step of guide `id` holding source line `line`.
export function stepOfLine(id, line) {
	const tl = S.timeline;
	if (!tl) return -1;
	const gi = tl.guides.findIndex((g) => g.id === id);
	if (gi < 0) return -1;
	const g = tl.guides[gi];
	let best = -1;
	for (let i = g.s0; i <= g.s1 && i < tl.steps.length; i++) {
		if (tl.steps[i].line <= line) best = i;
		else break;
	}
	return best;
}

export function currentPack() {
	const g = S.guideById.get(S.start);
	return g ? g.pack : null;
}
