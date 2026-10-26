// Small DOM helpers, formatting and the verb table the page shares.

export const $ = (sel, el = document) => el.querySelector(sel);
export const $$ = (sel, el = document) => [...el.querySelectorAll(sel)];

// h('div.a.b#id', { onclick, style, ...attrs }, ...children): one element.
export function h(spec, attrs, ...children) {
	const m = /^([a-z0-9]+)?((?:[.#][\w-]+)*)$/i.exec(spec);
	const el = document.createElement((m && m[1]) || 'div');
	if (m && m[2]) {
		for (const part of m[2].match(/[.#][\w-]+/g)) {
			if (part[0] === '.') el.classList.add(part.slice(1));
			else el.id = part.slice(1);
		}
	}
	if (attrs && (typeof attrs !== 'object' || attrs instanceof Node || Array.isArray(attrs))) {
		children.unshift(attrs);
		attrs = null;
	}
	for (const [k, v] of Object.entries(attrs || {})) {
		if (v == null || v === false) continue;
		if (k.startsWith('on')) el.addEventListener(k.slice(2), v);
		else if (k === 'style' && typeof v === 'object') Object.assign(el.style, v);
		else if (k === 'class') el.className = v;
		else if (k === 'html') el.innerHTML = v;
		else if (k in el && typeof v !== 'string') el[k] = v;
		else el.setAttribute(k, v === true ? '' : v);
	}
	append(el, children);
	return el;
}

function append(el, children) {
	for (const c of children) {
		if (c == null || c === false) continue;
		if (Array.isArray(c)) append(el, c);
		else el.append(c instanceof Node ? c : String(c));
	}
}

export function clear(el) {
	while (el.firstChild) el.firstChild.remove();
	return el;
}

// 1:04:00 / 53:21 / 0:09
export function fmtClock(sec) {
	sec = Math.max(0, Math.floor(sec || 0));
	const hh = Math.floor(sec / 3600);
	const mm = Math.floor((sec % 3600) / 60);
	const ss = sec % 60;
	const s2 = String(ss).padStart(2, '0');
	return hh ? `${hh}:${String(mm).padStart(2, '0')}:${s2}` : `${mm}:${s2}`;
}

export function fmtInt(n) {
	return Math.round(n || 0).toLocaleString('en-US');
}

export function debounce(fn, ms) {
	let timer = null;
	const d = (...args) => {
		clearTimeout(timer);
		timer = setTimeout(() => fn(...args), ms);
	};
	d.cancel = () => clearTimeout(timer);
	return d;
}

// The goal verbs: label, Polestar glyph and subject colour (a CSS token:
// the glyph's tint and the colour of the subject's name).
export const VERBS = {
	accept: { label: 'Accept', glyph: 'icon-accept', subj: 'quest' },
	turnin: { label: 'Turn in', glyph: 'icon-turnin', subj: 'quest' },
	complete: { label: 'Complete', glyph: 'icon-complete', subj: 'quest' },
	kill: { label: 'Kill', glyph: 'icon-kill', subj: 'danger', name: 'npc' },
	collect: { label: 'Collect', glyph: 'icon-collect', subj: 'item' },
	goto: { label: 'Go to', glyph: 'icon-goto', subj: 'place' },
	explore: { label: 'Explore', glyph: 'icon-explore', subj: 'place' },
	talk: { label: 'Talk', glyph: 'icon-talk', subj: 'npc' },
	interact: { label: 'Interact', glyph: 'icon-interact', subj: 'place', name: 'object' },
	use: { label: 'Use', glyph: 'icon-use', subj: 'item' },
	sethome: { label: 'Set home', glyph: 'icon-sethome', subj: 'place' },
	hearth: { label: 'Hearth', glyph: 'icon-hearth', subj: 'place' },
	getfp: { label: 'Get FP', glyph: 'icon-getfp', subj: 'spell', name: 'place' },
	fly: { label: 'Fly', glyph: 'icon-fly', subj: 'spell', name: 'place' },
	train: { label: 'Train', glyph: 'icon-train', subj: 'skill' },
	buy: { label: 'Buy', glyph: 'icon-buy', subj: 'item' },
	vendor: { label: 'Vendor', glyph: 'icon-vendor', subj: 'item', name: 'npc' },
	level: { label: 'Level', glyph: 'icon-level', subj: 'level' },
	note: { label: 'Note', glyph: 'icon-note', subj: 'textDim' },
	skill: { label: 'Skill', glyph: 'icon-skill', subj: 'skill' },
	learn: { label: 'Learn', glyph: 'icon-learn', subj: 'spell' },
	craft: { label: 'Craft', glyph: 'icon-craft', subj: 'item' },
	rep: { label: 'Rep', glyph: 'icon-rep', subj: 'faction' },
	achieve: { label: 'Achieve', glyph: 'icon-achieve', subj: 'achievement' },
};
export const verbMeta = (v) => VERBS[v] || { label: v, glyph: 'icon-note', subj: 'textDim' };
// The colour token of a goal's subject name (the person, quest, item, place).
export const nameColor = (v) => {
	const m = verbMeta(v);
	return m.name || (m.subj === 'textDim' ? 'text' : m.subj);
};

// A label for display: counts as "×5", not the source's "x5".
export const pretty = (text) => String(text || '').replace(/(^|\s)x(\d+)\b/g, '$1×$2');

// A goal label without its leading verb phrase ("Accept Frostmane Hold" -> "Frostmane Hold").
export function goalText(goal) {
	if (goal.quest && goal.quest.title && /^(accept|turnin|complete)$/.test(goal.verb)) return goal.quest.title;
	const label = pretty(goal.label);
	const meta = VERBS[goal.verb];
	const prefixes = meta ? [meta.label, goal.verb] : [goal.verb];
	for (const p of prefixes) {
		if (label.toLowerCase().startsWith(p.toLowerCase() + ' ')) return label.slice(p.length + 1);
	}
	return label;
}

// ---------------------------------------------------------------- icons
// Two families: the Polestar glyphs (white masks tinted by CSS, for every
// control) and the game's own icons (full colour, for content).

export const glyphUrl = (name, px = 96) => `/glyph/${name}.png?px=${px}`;
// The key as the icon files name it (a skill by name: lower case, dashed), so a static copy serves it too.
export const iconKey = (spec) => (spec.kind === 'skill' && !/^\d+$/.test(String(spec.key)) ? String(spec.key).toLowerCase().replace(/[^a-z]+/g, '-') : String(spec.key));
export const iconUrl = (spec) => `/icon/${spec.kind}/${encodeURIComponent(iconKey(spec))}.png`;

// A Polestar glyph: <i class="gl"> masked by the glyph, painted in currentColor.
export function glyph(name, cls = '') {
	const el = document.createElement('i');
	el.className = cls ? `gl ${cls}` : 'gl';
	el.style.setProperty('--g', `url("${glyphUrl(name)}")`);
	el.setAttribute('aria-hidden', 'true');
	return el;
}

// The game's icon for a goal, by meaning ({ kind, key } or null: the verb's glyph).
// ch: the character ({ cls }) for "train class".
export function goalIcon(goal, ch) {
	const ref = goal.ref || {};
	switch (goal.verb) {
		case 'accept': return { kind: 'ui', key: 'quest-available' };
		case 'turnin': return { kind: 'ui', key: 'quest-turnin' };
		case 'complete':
		case 'collect':
		case 'use':
		case 'buy':
			return ref.item != null ? { kind: 'item', key: String(ref.item) } : null;
		case 'train':
			if (ref.cls && ch && ch.cls) return { kind: 'class', key: ch.cls };
			if (ref.skill) return { kind: 'skill', key: String(ref.skill) };
			if (ref.spell != null) return { kind: 'spell', key: String(ref.spell) };
			return ch && ch.cls ? { kind: 'class', key: ch.cls } : null;
		case 'skill':
			return ref.skill ? { kind: 'skill', key: String(ref.skill) } : null;
		case 'learn':
		case 'craft':
			return ref.spell != null ? { kind: 'spell', key: String(ref.spell) } : ref.item != null ? { kind: 'item', key: String(ref.item) } : null;
		case 'fly':
		case 'getfp':
			return { kind: 'ui', key: 'flightmaster' };
		case 'sethome': return { kind: 'ui', key: 'innkeeper' };
		case 'hearth': return { kind: 'ui', key: 'hearthstone' };
		case 'vendor': return { kind: 'ui', key: 'repair' };
		case 'talk': return { kind: 'ui', key: 'talk' };
		default: return null;
	}
}

// Game icon URLs that answered 404 (never asked twice; their glyph shows).
const missing = new Set();

// A game icon in a square hairline frame (size class: s16, s18, s20, s24, ...),
// falling back to glyph `fallback` tinted by token `tint` when it is missing.
export function gameIcon(spec, fallback, { size = 's16', tint = 'textDim', title } = {}) {
	const fb = () => {
		const g = glyph(fallback || 'icon-note', size);
		g.style.color = `var(--${tint})`;
		if (title) g.title = title;
		return g;
	};
	if (!spec) return fb();
	const url = iconUrl(spec);
	if (missing.has(url)) return fb();
	const img = document.createElement('img');
	img.className = `gi ${size}`;
	img.alt = '';
	img.decoding = 'async';
	img.draggable = false;
	if (title) img.title = title;
	img.addEventListener('error', () => {
		missing.add(url);
		if (img.isConnected || img.parentNode) img.replaceWith(fb());
	}, { once: true });
	img.src = url;
	return img;
}

// A goal's icon: its game icon by meaning, else the verb's glyph in its subject colour.
export function goalIconEl(goal, ch, size = 's16') {
	const m = verbMeta(goal.verb);
	return gameIcon(goalIcon(goal, ch), m.glyph, { size, tint: m.subj });
}

// A <select> in the dropdown frame (the chevron glyph at its right edge).
export function dropdown(sel, cls = '') {
	return h('span', { class: cls ? `dd ${cls}` : 'dd' }, sel, glyph('chevron-down', 'dd-chev'));
}

// Positions a fixed popover under (or above) an anchor element, inside the window.
export function placeUnder(pop, anchor, { align = 'left', gap = 6 } = {}) {
	const r = anchor.getBoundingClientRect();
	pop.style.visibility = 'hidden';
	document.body.append(pop);
	const pw = pop.offsetWidth;
	const ph = pop.offsetHeight;
	let left = align === 'right' ? r.right - pw : r.left;
	left = Math.max(8, Math.min(left, innerWidth - pw - 8));
	let top = r.bottom + gap;
	if (top + ph > innerHeight - 8) top = Math.max(8, r.top - gap - ph);
	pop.style.left = `${left}px`;
	pop.style.top = `${top}px`;
	pop.style.visibility = '';
}

// Popovers stack: one opened from inside the open one (Find in a form)
// nests above it, any other replaces them all. A press outside closes every
// popover it is not inside; Escape or close() closes the top one.
const stack = [];   // [{ pop, anchor, onClose }], innermost last
document.addEventListener('pointerdown', (e) => {
	let keep = 0;
	for (let k = stack.length - 1; k >= 0; k--) {
		if (stack[k].pop.contains(e.target) || stack[k].anchor.contains(e.target)) {
			keep = k + 1;
			break;
		}
	}
	while (stack.length > keep) closePopover();
}, true);
export function popover(content, anchor, opts = {}) {
	while (stack.length && !stack[stack.length - 1].pop.contains(anchor)) closePopover();
	const pop = h('div.popover', { class: `popover ${opts.cls || ''}` }, content);
	placeUnder(pop, anchor, opts);
	stack.push({ pop, anchor, onClose: opts.onClose });
	return pop;
}
export function closePopover() {
	const top = stack.pop();
	if (!top) return false;
	top.pop.remove();
	if (top.onClose) top.onClose();
	return true;
}
export const popoverOpen = () => stack.length > 0;
