// What the browser build adds to the planner page (tools/planner/public): the loading progress, the
// guide set (?set=), the simulator's hours for the route on show (live after every edit: forge-sim's
// evaluator in forge-wasm, `forge judge report`'s numbers), and the export of this browser's edits.

import { onBackend, cmd, SET } from './api.js';
import { h, glyph } from './ui/dom.js';

const boot = document.getElementById('boot');
let info = null;
let base = null; // the first hours of a start (set, start, character): the reference the delta reads
let last = null;

const fmt = (v) => (v == null ? '—' : v.toFixed(2));

const chip = h('button.btn.ghost.sim-hours', { title: 'The simulator\'s hours for this route (forge-sim, as forge judge report counts them), updated after every edit' }, glyph('clock'), h('span.sim-text', 'Sim …'));
const setSel = h('select.set-pick', { title: 'Guide set (reloads the page)' });
const exportBtn = h('button.btn.ghost', { title: 'Download the guide files changed in this browser (zip)', onclick: () => cmd('changes_export').catch((e) => alert(e.message)) }, glyph('download'), 'Export edits');

setSel.addEventListener('change', () => {
	const q = new URLSearchParams(location.search);
	q.set('set', setSel.value);
	location.search = q.toString();
});

function mount() {
	const bar = document.getElementById('topbar');
	const conn = bar && bar.querySelector('.conn');
	if (!conn || bar.contains(chip)) return;
	conn.before(setSel, chip);
	const changes = [...bar.querySelectorAll('button')].find((b) => b.textContent.trim().startsWith('Changes'));
	(changes || conn).after(exportBtn);
}
new MutationObserver(mount).observe(document.getElementById('topbar'), { childList: true });

function showHours(d) {
	const text = chip.querySelector('.sim-text');
	if (d.error) {
		text.textContent = 'Sim: —';
		chip.title = `The simulator's hours: ${d.error}`;
		return;
	}
	const key = JSON.stringify([SET, d.play.start, d.play.character]);
	if (!base || base.key !== key) base = { key, h: d };
	last = d;
	const delta = d.hours60 - base.h.hours60;
	text.textContent = `Sim ${fmt(d.hours60)} h${Math.abs(delta) >= 0.005 ? ` (${delta > 0 ? '+' : '−'}${fmt(Math.abs(delta))})` : ''}`;
	chip.classList.toggle('worse', delta >= 0.005);
	chip.classList.toggle('better', delta <= -0.005);
	chip.title = [
		`Simulator (forge-sim, forge judge report): ${d.character.race}, ${d.chain.length} guides`,
		`to level 30: ${fmt(d.hours30)} h · to ${Math.floor(d.endLevel)}: ${fmt(d.hours60)} h`,
		`since this start was first played here: ${delta >= 0 ? '+' : '−'}${fmt(Math.abs(delta))} h`,
		`quests ${d.questsDone} · zone changes ${d.zoneChanges} · walked in ${d.ms} ms`,
	].join('\n');
}

chip.addEventListener('click', () => {
	if (!last) return;
	const rows = last.guides.map((g) => `${g.id}\n   ${fmt(g.start / 3600)} – ${fmt(g.end / 3600)} h, level ${g.levelStart.toFixed(1)} → ${g.levelEnd.toFixed(1)}`);
	alert(`${chip.title}\n\n${rows.join('\n')}`);
});

onBackend((name, d) => {
	if (name === 'progress' && boot) {
		if (d.text) boot.lastChild.textContent = d.text;
	} else if (name === 'failed' && boot) {
		boot.lastChild.textContent = `The planner could not load: ${d.error.split('\n')[0]}`;
	} else if (name === 'ready') {
		info = d;
		setSel.textContent = '';
		for (const s of d.sets) setSel.append(h('option', { value: s.name, selected: s.name === SET }, s.title && s.name !== 'v1' ? `${s.name}` : s.name));
		console.log('[planner] bundle', d.timings, d.bytes);
		window.__planner = { info: d };
	} else if (name === 'hours') {
		showHours(d);
		window.__planner = { ...(window.__planner || {}), hours: d };
	}
});
mount();
