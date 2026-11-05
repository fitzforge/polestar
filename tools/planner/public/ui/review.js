// Review mode (/?review=1&start=…&race=…&cls=…[&visit=N]): the route one
// screen at a time for Fitz, no editing UI. A screen is a visit to a town or
// the field work between two (commands review_screens, review_screen); the
// map shows only the game's quest marks, our walked path with its numbered
// stops and the ideal loop faint beside it; the panel lists the stops in plain
// words, three numbers and the problems. A click on a mark, a stop or the path
// (or a stop in the list) opens a one-sentence note, saved by
// review_note_add (data/local/route-feedback/review-notes.jsonl and the
// dashboard). "Advanced" shows the normal planner at the screen's first step.
//
//   const rv = reviewMode({ map, layers, onAdvanced(step) });
//   rv.enter(visit)   // 1-based screen, null: the one holding S.step
//   rv.reload()       // after a new timeline
import { cmd } from '../api.js';
import { S } from './state.js';
import { h, $, clear, glyph, iconUrl } from './dom.js';
import { toast } from './toasts.js';

const MARK_ICON = { '!ready': 'mark-available', '?ready': 'mark-turnin', '!grey': 'mark-low', '?grey': 'quest-incomplete', '!locked': 'mark-low' };
const NEAR = 5;        // screens listed either side of the current one
const STOP_PX = 18;    // a click this close to a stop is on it
const PATH_PX = 12;    // ... to the path, on it

const own = (name) => (/s$/.test(name) ? `${name}'` : `${name}'s`);

// A stop's goals in plain words: "Hand in Fields of Grief to Apothecary Johaan".
function plain(item, npc) {
	const who = npc ? npc.name : null;
	const t = item.title || item.label;
	switch (item.verb) {
		case 'turnin': return who ? `Hand in ${t} to ${who}` : `Hand in ${t}`;
		case 'accept': return who ? `Take ${t} from ${who}` : `Take ${t}`;
		case 'train': return who ? `Train at ${who}` : 'Train';
		case 'sethome': return who ? `Set your hearth at ${who}` : item.label;
		default: return item.label;
	}
}

export function reviewMode({ map, layers, onAdvanced }) {
	const panel = h('aside#review-panel.panel', { hidden: true });
	$('#main').append(panel);
	let screens = [];
	let cur = -1;
	let shown = null;      // { screen, view, notes }
	let target = null;     // the note being written: { kind, label, quest, npc, step, point }
	let seq = 0;
	// Only the screens with a problem (the default): a ready mark walked past or left, or the walk
	// more than OVER over the ideal loop; the current screen is always listed.
	let all = localStorage.getItem('polestar.review.all') === '1';
	const OVER = 0.15;
	const bad = (x) => x.problems && (x.problems.walked > 0 || x.problems.left > 0 || (x.problems.over != null && x.problems.over > OVER));
	const visible = () => screens.filter((x) => all || bad(x) || x.i === cur);
	const step = (d) => {
		const list = visible();
		const k = list.findIndex((x) => x.i === cur);
		const to = list[k + d];
		if (to) show(to.i);
	};
	const toggleAll = () => {
		all = !all;
		localStorage.setItem('polestar.review.all', all ? '1' : '0');
		render();
	};

	const args = () => ({ start: S.start, character: S.character, choices: S.choices, startLevel: S.startLevel, optional: S.optional });

	function mapForReview() {
		if (!map) return;
		for (const k of layers) map.setLayer(k, k === 'terrain' || k === 'zoneArt' ? !!S.layers[k] : k === 'quests');
		map.setRoute([]);
		map.setScene(null);
		map.setCharacter(null);
		map.setHandles([]);
	}

	async function enter(visit = null) {
		S.review = true;
		document.body.classList.add('review');
		panel.hidden = false;
		mapForReview();
		if (map) map.resize();
		await reload(visit);
	}

	function leave() {
		S.review = false;
		document.body.classList.remove('review');
		panel.hidden = true;
		const url = new URL(location.href);
		url.searchParams.delete('review');
		url.searchParams.delete('visit');
		history.replaceState(null, '', url);
		if (map) {
			for (const k of layers) map.setLayer(k, !!S.layers[k]);
			map.setHubView(null);
			map.setScene(null);
			map.resize();
		}
		onAdvanced(shown ? shown.screen.s0 : Math.max(0, S.step));
	}

	async function reload(visit = null) {
		if (!S.timeline) return;
		const my = ++seq;
		clear(panel).append(h('div.rv-head', h('b', 'Loading the route…')));
		try {
			screens = await cmd('review_screens', args());
		} catch (e) {
			clear(panel).append(h('div.rv-head', glyph('warning'), h('span', e.message)));
			return;
		}
		if (my !== seq) return;
		let i = visit != null ? visit - 1 : screens.findIndex((s) => s.s0 <= S.step && S.step <= s.s1);
		if (cur >= 0 && visit == null && screens[cur]) i = cur;
		if (i < 0) i = 0;
		if (visit == null && !all && screens[i] && !bad(screens[i])) i = (screens.find((x) => x.i >= i && bad(x)) || screens[i]).i;
		show(Math.max(0, Math.min(screens.length - 1, i)));
	}

	async function show(i, { fit = true } = {}) {
		if (!screens[i]) return;
		cur = i;
		target = null;
		const my = ++seq;
		let r;
		try {
			r = await cmd('review_screen', { ...args(), screen: i });
		} catch (e) {
			toast(e.message, 'error');
			return;
		}
		if (my !== seq) return;
		shown = r;
		S.step = r.screen.s0;
		const url = new URL(location.href);
		url.searchParams.set('review', '1');
		url.searchParams.set('visit', String(i + 1));
		history.replaceState(null, '', url);
		if (map) {
			map.setHubView(r.view, { loop: true, faintLoop: true });
			map.setScene(null);
			if (fit) {
				const v = r.view;
				const pts = [...v.stops.map((s) => [s.wx, s.wy]), ...v.marks.map((m) => [m.wx, m.wy]), ...(v.hub ? v.hub.places : [])];
				for (const run of v.path) for (let k = 0; k + 1 < run.pts.length; k += 2) pts.push([run.pts[k], run.pts[k + 1]]);
				const c = v.stops.length ? v.stops[0].c : v.c;
				if (pts.length) map.fitWorld(c, pts, { padding: 72, maxZoom: 4 });
			}
		}
		render();
	}

	const markImg = (mark, tone) => h('img', { class: `hv-mi ${tone}`, src: iconUrl({ kind: 'ui', key: MARK_ICON[mark + tone] }), alt: mark });
	const title = (s) => (s.kind === 'hub' ? `${s.name} · visit ${s.n} of ${s.of}` : `Out: ${s.name}`);

	function render() {
		const { screen: s, view: v, notes } = shown;
		const parts = [];
		parts.push(h('div.rv-head',
			h('span.rv-brand', glyph('route'), 'Route review'),
			h('span.spacer'),
			h('button.btn.ghost.small', { title: 'Show the full planner at this point', onclick: leave }, glyph('sliders'), 'Advanced')));
		const g = S.guideById.get(s.guide);
		parts.push(h('div.rv-route', `${g ? g.title : s.guide} · ${S.character.race === 'Scourge' ? 'Undead' : S.character.race} ${S.character.cls[0]}${S.character.cls.slice(1).toLowerCase()} · level ${s.level}`));
		const list = visible();
		const k = list.findIndex((x) => x.i === cur);
		const nBad = screens.filter(bad).length;
		parts.push(h('div.rv-nav',
			h('button.btn.rv-big', { disabled: k <= 0, title: 'Previous (←)', onclick: () => step(-1) }, glyph('chevron-left'), 'Prev'),
			h('div.rv-title', h('b', title(s)), h('span', `${all ? `screen ${cur + 1} of ${screens.length}` : `problem ${bad(screens[cur]) ? screens.filter(bad).findIndex((x) => x.i === cur) + 1 : '–'} of ${nBad}`} · steps ${s.s0 + 1}–${s.s1 + 1}`)),
			h('button.btn.rv-big', { disabled: k >= list.length - 1, title: 'Next (→)', onclick: () => step(1) }, 'Next', glyph('chevron-right'))));
		parts.push(h('label.rv-filter', h('input', { type: 'checkbox', checked: !all, onchange: toggleAll }), `Only screens with problems (${nBad} of ${screens.length})`));
		const lo = Math.max(0, k - NEAR), hi = Math.min(list.length, k + NEAR + 1);
		parts.push(h('div.rv-list', ...list.slice(lo, hi).map((x) => h('button', { class: `rv-item ${x.kind}${x.i === cur ? ' cur' : ''}${bad(x) ? ' bad' : ''}`, onclick: () => show(x.i) }, h('span', x.kind === 'hub' ? `${x.name} ${x.n}/${x.of}` : `out · ${x.name}`), h('span.rv-st', `${x.s0 + 1}`)))));
		if (v.hub) {
			const over = v.loop && v.loop.yards > 0 ? Math.max(0, Math.round((v.loop.ours / v.loop.yards - 1) * 100)) : null;
			parts.push(h('div.rv-nums',
				h('div', { class: v.walkedPast.length ? 'bad' : 'ok' }, h('b', String(v.walkedPast.length)), h('span', 'walked past')),
				h('div', { class: v.leftReady.length ? 'warn' : 'ok' }, h('b', String(v.leftReady.length)), h('span', 'left ready')),
				h('div', { class: over == null ? '' : over > 20 ? 'bad' : over > 5 ? 'warn' : 'ok' }, h('b', over == null ? '–' : `${over}%`), h('span', 'over the ideal loop'))));
		}
		const when = (st) => (st <= s.s1 ? `later in this visit (step ${st + 1})` : `at step ${st + 1}`);
		const problems = [
			...v.walkedPast.map((w) => `Walked past ${own(w.name)} ready ${w.mark === '?' ? 'hand-in' : 'quest'} (${w.title}); the route ${w.mark === '?' ? 'hands it in' : 'takes it'} ${when(w.doneStep)}.`),
			...v.leftReady.map((w) => `Left ${own(w.name)} ${w.mark === '?' ? 'hand-in' : 'quest'} (${w.title}) ready; back for it at step ${w.doneStep + 1}.`),
		];
		if (problems.length) parts.push(h('div.rv-sec', h('div.rv-h', 'Problems'), ...problems.map((p) => h('div.rv-prob', p))));
		parts.push(h('div.rv-sec', h('div.rv-h', 'Stops', h('span.rv-hint', 'click one, a mark or the path to leave a note')),
			...v.stops.map((st) => h('button.rv-stop', { onclick: () => compose({ kind: 'stop', label: `stop ${st.n}${st.npc ? ` (${st.npc.name})` : ''}`, npc: st.npc ? st.npc.id : null, quest: st.items[0].quest, step: st.step, point: { c: st.c, wx: st.wx, wy: st.wy } }) },
				h('span.hv-n', String(st.n)), h('span', st.items.map((it) => plain(it, st.npc)).join('; '))))));
		if (target) parts.push(composer());
		if (notes.length) parts.push(h('div.rv-sec', h('div.rv-h', 'Your notes here'), ...notes.map((n) => h('div.rv-note', h('span', h('b', n.target && n.target.label ? `${n.target.label}: ` : ''), n.text), h('button.btn.ghost.small', { title: 'Delete this note', onclick: () => del(n.id) }, glyph('close'))))));
		parts.push(h('div.rv-legend', markImg('!', 'ready'), 'take now ', markImg('?', 'ready'), 'hand in ', markImg('!', 'grey'), 'soon ', markImg('?', 'grey'), 'in progress ', h('i.hv-dash'), 'ideal loop'));
		clear(panel).append(...parts);
		const ta = panel.querySelector('textarea');
		if (ta) ta.focus();
	}

	function composer() {
		const ta = h('textarea.rv-text', { rows: 3, placeholder: 'What is wrong here, in a sentence…' });
		const save = async () => {
			const text = ta.value.trim();
			if (!text) return ta.focus();
			try {
				await cmd('review_note_add', { ...args(), screen: cur, step: target.step, target: { kind: target.kind, quest: target.quest ?? null, npc: target.npc ?? null, label: target.label }, point: target.point || undefined, text, url: location.href });
				toast('Note saved', 'ok');
				await show(cur, { fit: false });
			} catch (e) {
				toast(e.message, 'error');
			}
		};
		ta.addEventListener('keydown', (e) => {
			if (e.key === 'Enter' && (e.ctrlKey || e.metaKey)) save();
			if (e.key === 'Escape') cancel();
		});
		return h('div.rv-sec.rv-compose', h('div.rv-h', `Note on ${target.label}`), ta,
			h('div.rv-actions', h('button.btn.ghost', { onclick: cancel }, 'Cancel'), h('button.btn.primary', { onclick: save }, 'Save')));
	}

	function cancel() {
		target = null;
		if (map) map.setScene(null);
		render();
	}

	function compose(t) {
		target = t;
		if (map && t.point) map.setScene({ rings: [{ c: t.point.c, wx: t.point.wx, wy: t.point.wy, r: 8 }] });
		render();
	}

	async function del(id) {
		try {
			await cmd('review_note_delete', { id });
			await show(cur, { fit: false });
		} catch (e) {
			toast(e.message, 'error');
		}
	}

	// A map click: a mark, else the nearest stop, else the walked path, else nothing.
	function pick(d) {
		if (!S.review || !shown || !d) return;
		const v = shown.view;
		if (d.hit && d.hit.type === 'mark') {
			const m = d.hit.mark;
			const q = m.quests[0];
			return compose({ kind: 'mark', label: `${m.name} (${q.mark} ${q.title})`, npc: m.kind === 'npc' ? m.id : null, quest: q.id, step: q.step != null && q.route !== 'past' ? q.step : shown.screen.s0, point: { c: m.c, wx: m.wx, wy: m.wy } });
		}
		let best = null;
		let bd = STOP_PX;
		for (const st of v.stops) {
			const p = map.toScreen(st.c, st.wx, st.wy);
			const dd = p ? Math.hypot(p.x - d.sx, p.y - d.sy) : Infinity;
			if (dd < bd) {
				bd = dd;
				best = st;
			}
		}
		if (best) return compose({ kind: 'stop', label: `stop ${best.n}${best.npc ? ` (${best.npc.name})` : ''}`, npc: best.npc ? best.npc.id : null, quest: best.items[0].quest, step: best.step, point: { c: best.c, wx: best.wx, wy: best.wy } });
		let run = null;
		bd = PATH_PX;
		for (const r of v.path) {
			for (let k = 0; k + 1 < r.pts.length; k += 2) {
				const p = map.toScreen(r.c, r.pts[k], r.pts[k + 1]);
				const dd = p ? Math.hypot(p.x - d.sx, p.y - d.sy) : Infinity;
				if (dd < bd) {
					bd = dd;
					run = r;
				}
			}
		}
		if (run) compose({ kind: 'path', label: `the path at step ${run.step + 1}`, step: run.step, point: { c: d.c, wx: Math.round(d.wx * 10) / 10, wy: Math.round(d.wy * 10) / 10 } });
	}

	if (map) map.on('pick', pick);
	document.addEventListener('keydown', (e) => {
		if (!S.review) return;
		const tag = e.target && e.target.tagName;
		if (tag === 'TEXTAREA' || tag === 'INPUT') return;
		if (e.key === 'ArrowLeft') step(-1);
		else if (e.key === 'ArrowRight') step(1);
		else return;
		e.preventDefault();
		e.stopImmediatePropagation();
	}, true);

	return { enter, reload: () => S.review && reload() };
}
