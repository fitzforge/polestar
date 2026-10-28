// The Quest marks layer: at the selected step, the hub_view command
// (tools/planner/hubview.js) drawn on the map (MapView.setHubView) and summed
// up in a panel over the map's right edge: the marks the game shows the
// character there, the walk's stops, what it walked past or left ready, the
// hub's other visits and the ideal loop. Step numbers are the steps list's.
//
//   const hv = hubViewPanel(wrap, { map, selectStep });
//   hv.refresh(force)   // after a step or timeline change (or the layer toggled)
//   hv.pick(mark)       // a mark clicked on the map: its row
import { cmd } from '../api.js';
import { S, savePrefs } from './state.js';
import { h, clear, glyph, iconUrl } from './dom.js';

const n1 = (i) => (i == null ? '–' : String(i + 1));

export function hubViewPanel(wrap, { map, selectStep }) {
	const el = h('div.hv-panel', { hidden: true });
	wrap.append(el);
	let seq = 0;
	let timer = 0;
	let lastTl = null;
	let lastStep = -1;
	let framed = '';         // the visit last framed: a new one is framed left of the panel
	let picked = null;

	function hide() {
		el.hidden = true;
		framed = '';
		S.hubView = null;
		if (map) map.setHubView(null);
	}

	function refresh(force = false) {
		if (!S.layers.quests || !S.timeline || S.step < 0) {
			lastTl = null;
			hide();
			return;
		}
		if (!force && S.timeline === lastTl && S.step === lastStep) return;
		lastTl = S.timeline;
		lastStep = S.step;
		clearTimeout(timer);
		timer = setTimeout(load, 60);
	}

	async function load() {
		const my = ++seq;
		const step = S.step;
		let v;
		try {
			v = await cmd('hub_view', { start: S.start, character: S.character, choices: S.choices, startLevel: S.startLevel, optional: S.optional, step });
		} catch (e) {
			if (my !== seq || S.review) return;
			el.hidden = false;
			clear(el).append(h('div.hv-head', glyph('warning'), h('b', 'Quest marks'), h('span.c-textDim', e.message)));
			if (map) map.setHubView(null);
			return;
		}
		if (my !== seq || !S.layers.quests || S.review) return;
		S.hubView = v;
		if (map) map.setHubView(v, { loop: S.hubLoop });
		render(v);
		frame(v);
	}

	// A visit not framed yet: its places, stops and marks, left of the panel.
	function frame(v) {
		if (!map || !v.hub) return;
		const key = `${S.start}|${v.hub.c}|${v.hub.steps[0]}`;
		if (key === framed) return;
		framed = key;
		const pts = [...v.hub.places, ...v.stops.map((s) => [s.wx, s.wy]), ...v.marks.map((m) => [m.wx, m.wy])];
		map.fitWorld(v.hub.c, pts, { padding: 56, right: el.offsetWidth + 48, maxZoom: 4 });
	}

	const go = (i, text) => (i == null ? h('span.hv-mute', text || 'never') : h('button.hv-go', { title: `Go to step ${i + 1}`, onclick: () => selectStep(i) }, text || `step ${i + 1}`));
	// The game's mark (as the map draws it, map/mapview.js MARK_ICON).
	const MARK_ICON = { '!ready': 'mark-available', '?ready': 'mark-turnin', '!grey': 'mark-low', '?grey': 'quest-incomplete', '!locked': 'mark-low' };
	const markGl = (mark, tone) => h('img', { class: `hv-mi ${tone}`, src: iconUrl({ kind: 'ui', key: MARK_ICON[mark + tone] }), alt: mark });
	const section = (title, cls, rows) => (rows.length ? h('details.hv-sec', { class: `hv-sec ${cls}`, open: true }, h('summary', title, h('span.count', String(rows.length))), ...rows) : null);
	const problem = (w, tail) => h('div.hv-row', { 'data-key': w.key }, markGl(w.mark, 'ready'), h('div.hv-txt', h('b', w.name), h('span', w.title), h('span.hv-meta', ...tail)));

	function render(v) {
		el.hidden = false;
		const hub = v.hub;
		const cnt = (mark, tone, title) => h('span', { class: `hv-chip ${tone}`, title }, markGl(mark, tone), String(v.counts[tone][mark]));
		const head = h('div.hv-head',
			markGl('!', 'ready'),
			h('b', hub ? hub.name || 'Hub' : 'Around the step'),
			h('span.spacer'),
			v.loop ? h('button', { class: `btn ghost small${S.hubLoop ? ' on' : ''}`, title: 'Draw the ideal loop: the shortest walk from where we arrive through the stops and the marks left ready to where we go on, clockwise preferred', 'aria-pressed': String(S.hubLoop), onclick: toggleLoop }, glyph('route'), 'Ideal loop') : null);
		const sub = h('div.hv-sub',
			`Step ${v.step + 1} · level ${v.level}`,
			hub ? [` · visit ${hub.visit} of ${hub.visits.length} · steps ${hub.steps[0] + 1}–${hub.steps[1] + 1}`] : ' · not at a hub');
		const counts = h('div.hv-counts', cnt('!', 'ready', 'Quests to take now'), cnt('?', 'ready', 'Hand-ins ready'), cnt('!', 'grey', `Quests up to ${v.rules.greyLevels} levels away`), cnt('?', 'grey', 'Hand-ins in progress'), cnt('!', 'locked', 'Quests waiting on a prerequisite'));
		const parts = [head, sub, counts];
		if (hub) {
			const crossed = hub.visits.length > 1;
			parts.push(h('div.hv-sum',
				h('span', { class: v.walkedPast.length ? 'bad' : 'ok' }, `Walked past ${v.walkedPast.length}`),
				h('span', { class: v.leftReady.length ? 'warn' : 'ok' }, `Left ready ${v.leftReady.length}`),
				h('span', { class: crossed ? 'warn' : 'ok' }, `Visits ${hub.visits.length}`)));
			if (v.loop) {
				const save = v.loop.ours > 0 ? Math.round((1 - v.loop.yards / v.loop.ours) * 100) : 0;
				parts.push(h('div.hv-loop', h('i.hv-dash'), `Ours ${v.loop.ours} yd · ideal loop ${v.loop.yards} yd`, save > 0 ? h('span.c-textDim', ` (${save}% shorter)`) : null));
			}
			parts.push(section('Walked past', 'bad', v.walkedPast.map((w) => problem(w, [`${w.yd} yd at `, go(w.passStep), ' → ', go(w.doneStep)]))));
			parts.push(section('Left ready', 'warn', v.leftReady.map((w) => problem(w, ['done at ', go(w.doneStep)]))));
			parts.push(section('Passed, not in the route', 'muted', v.passedSkipped.map((w) => problem(w, [`${w.yd} yd at `, go(w.passStep)]))));
			parts.push(section('Left, not in the route', 'muted', v.leftSkipped.map((w) => problem(w, []))));
			parts.push(h('div.hv-visits', h('span.hv-mute', crossed ? 'Visits ' : 'Visit '), ...hub.visits.map((x) => h('button', { class: `hv-go${x.current ? ' cur' : ''}`, title: `Steps ${x.s0 + 1}–${x.s1 + 1}${x.leave != null ? `, left at step ${x.leave + 1}` : ''}`, onclick: () => selectStep(x.s0) }, x.s0 === x.s1 ? n1(x.s0) : `${n1(x.s0)}–${n1(x.s1)}`))));
			parts.push(section('Our stops', 'stops', v.stops.map((s) => h('div.hv-row', h('span.hv-n', String(s.n)), h('div.hv-txt', h('span', s.goals.join(' · ')), h('span.hv-meta', go(s.step)))))));
			if (v.loop && S.hubLoop) parts.push(section('Ideal loop', 'loop', v.loop.stops.map((s, i) => h('div.hv-row', h('span.hv-n.loop', String(i + 1)), h('div.hv-txt', h('span', { class: s.extra ? 'hv-warn' : '' }, s.label))))));
		}
		const rank = (m) => (m.tone === 'ready' ? 0 : m.tone === 'grey' ? 2 : 4) + (m.inRoute ? 0 : 1);
		const marks = [...v.marks].sort((a, b) => rank(a) - rank(b) || a.name.localeCompare(b.name));
		const where = (q) => (q.route === 'never' ? h('span.hv-mute', 'not in the route') : q.route === 'past' ? 'done' : go(q.step, q.route === 'here' ? 'this step' : `step ${q.step + 1}`));
		const note = (q) => (q.after ? ` · after ${q.after}` : q.tone === 'grey' && q.mark === '!' && q.level ? ` · level ${q.level}` : '');
		const questRow = (q) => h('span', { class: `hv-q${q.tone === 'locked' ? ' locked' : ''}` }, markGl(q.mark, q.tone), q.title, ' ', h('span.hv-meta', where(q), note(q)));
		const markRow = (m) => h('div', { class: `hv-row${m.inRoute && m.tone !== 'locked' ? '' : ' faint'}${picked === m.key ? ' picked' : ''}`, 'data-key': m.key, title: m.tip },
			markGl(m.mark, m.tone),
			h('div.hv-txt', h('b', m.name), ...m.quests.map(questRow)));
		parts.push(section('Marks', 'marks', marks.map(markRow)));
		const r = v.rules;
		parts.push(h('div.hv-rules', `Hub: quest NPCs within ${r.hubYd} yd · left at ${r.leaveYd} yd · passed within ${r.pastYd} yd · accepts count from the quest level −${r.readyUnder} · grey ! up to ${r.greyLevels} levels away · marks within ${r.areaYd} yd`));
		clear(el).append(...parts.filter(Boolean));
		if (picked) reveal(picked);
	}

	function reveal(key) {
		const row = [...el.querySelectorAll('.hv-sec.marks .hv-row')].find((x) => x.dataset.key === key);
		if (!row) return;
		for (const x of el.querySelectorAll('.hv-row.picked')) x.classList.remove('picked');
		row.classList.add('picked');
		row.closest('details').open = true;
		row.scrollIntoView({ block: 'nearest' });
	}

	function toggleLoop() {
		S.hubLoop = !S.hubLoop;
		savePrefs();
		if (S.hubView) {
			if (map) map.setHubView(S.hubView, { loop: S.hubLoop });
			render(S.hubView);
		}
	}

	return {
		refresh,
		pick(mark) {
			picked = mark.key;
			reveal(mark.key);
		},
	};
}
