'use strict';
// Translated text that does not fit. Every scene of `preview` and every
// Options page and tab is laid out in each shipped locale (and English), in
// the game font and in Inter, and every visible string is checked the way
// the client draws it:
//
//   cut      a one-line string wider than its box (the client ends it with
//            an ellipsis)
//   lines    a wrapping string with more lines than its maximum, or than
//            its fixed height holds (cut after the last line that fits)
//   word     a single word wider than its wrapping box
//   window   a string crossing its window's edge or a frame that clips it
//
// The preview's fonts have no CJK or Hangul glyphs; those are measured 1em
// wide, about what the client's CJK fonts set. `slack` measures every glyph
// that many times wider (tests/text-fit.test.js uses 1.15: the client's
// font runs about 13% wider than Inter). `i18n fit` (docs/TRANSLATING.md)
// runs it for every language; tests/text-fit.test.js checks English's
// windows with its audit.

const fs = require('node:fs');
const path = require('node:path');
const P = require('../commands/preview');
const { runAddon } = require('../../tests/helpers/lua');
const { resolve, wrap, measure } = require('./render');
const { LOCALES } = require('../lib/i18n/locales');
const { ROOT } = require('../lib/paths');

const H = { LEFT: 0, CENTER: 0.5, RIGHT: 1, TOPLEFT: 0, TOP: 0.5, TOPRIGHT: 1, BOTTOMLEFT: 0, BOTTOM: 0.5, BOTTOMRIGHT: 1 };
const V = { TOP: 0, CENTER: 0.5, BOTTOM: 1, TOPLEFT: 0, LEFT: 0.5, TOPRIGHT: 0, RIGHT: 0.5, BOTTOMLEFT: 1, BOTTOMRIGHT: 1 };
const PASSES = [['game font', ''], ['Inter', 'Polestar.Set("ui.font", "inter")\n']];
const LOCALE_DIR = path.join(ROOT, 'addon', 'Polestar', 'Locales');

const wide = (cp) => (cp >= 0x1100 && cp <= 0x11ff) || (cp >= 0x2e80 && cp <= 0xa4cf) || (cp >= 0xa960 && cp <= 0xa97f) || (cp >= 0xac00 && cp <= 0xd7ff) || (cp >= 0xf900 && cp <= 0xfaff) || (cp >= 0xfe30 && cp <= 0xfe4f) || (cp >= 0xff00 && cp <= 0xff60) || (cp >= 0xffe0 && cp <= 0xffe6);

// The preview's fonts with CJK at 1em, every advance `slack` times wider.
function fontsFor(slack = 1) {
	const base = P.loadFonts();
	const cache = new Map();
	return new Proxy({}, {
		get(_, k) {
			if (!cache.has(k)) {
				const f = base[k];
				const adv = (c) => (wide(c) && !f.glyphId(c) ? 1 : f.advanceEm(c)) * slack;
				cache.set(k, Object.create(f, { advanceEm: { value: adv } }));
			}
			return cache.get(k);
		},
	});
}

// Every code point the locale files use, for the Lua side's widths.
function localeCodepoints(files) {
	const cps = new Set();
	for (const f of files) for (const ch of fs.readFileSync(f, 'utf8')) cps.add(ch.codePointAt(0));
	return [...cps].filter((c) => c >= 0x180);
}

// Lua run first: the client's locale, the file that stands for it, and
// string.format's positional arguments (%1$s), which the client has and
// Lua 5.1 does not.
function localeLua(locale, file) {
	const lines = [`function GetLocale() return ${JSON.stringify(locale)} end`,
		`do
	local fmt = string.format
	string.format = function(f, ...)
		if type(f) == "string" and f:find("%%%d+%$") then
			local args, seq = { ... }, {}
			f = f:gsub("%%(%d+)%$", function(n) seq[#seq + 1] = args[tonumber(n)]; return "%" end)
			return fmt(f, unpack(seq))
		end
		return fmt(f, ...)
	end
	format = string.format
end`];
	if (file) {
		lines.push(`do
	local load = loadfile
	function loadfile(f)
		if f:match("[/\\\\]Polestar[/\\\\]Locales[/\\\\]${locale}%.lua$") then return load(${JSON.stringify(file)}) end
		return load(f)
	end
end`);
	}
	return lines.join('\n');
}

const intersect = (a, r) => ({ x0: Math.max(a.x0, r.x), y0: Math.max(a.y0, r.y), x1: Math.min(a.x1, r.x + r.w), y1: Math.min(a.y1, r.y + r.h) });
const px = (v) => Math.round(v * 10) / 10;

// -> the strings of one dump that do not fit: { text, kind, over, box, what }.
// `kinds` limits the checks (the text-fit test checks only "window").
function audit(dump, roots, fonts, kinds = ['cut', 'lines', 'word', 'window']) {
	const want = new Set(kinds);
	const objects = dump.objects;
	const { byId, rects, scaleOf } = resolve(objects, fonts);
	const parentOf = (o) => (o.parent != null ? byId.get(o.parent) : null);
	const rootOf = (o) => {
		for (let cur = o; cur; cur = parentOf(cur)) if (roots.includes(cur.name)) return cur;
		return null;
	};
	const shown = (o) => {
		for (let cur = o; cur; cur = parentOf(cur)) if (!cur.shown || (cur.alpha ?? 1) <= 0.001) return false;
		return true;
	};
	const out = [];
	for (const o of objects) {
		if (o.kind !== 'FontString' || !o.plain || !o.plain.trim() || !shown(o)) continue;
		const root = rootOf(o);
		if (!root) continue;
		const r = rects.get(o.id);
		const s = scaleOf(o);
		const rr = rects.get(root.id);
		const text = o.plain.replace(/\s+/g, ' ').trim();
		const report = (kind, what, over, box) => {
			if (want.has(kind)) out.push({ text, kind, what, over: px(over), box: box == null ? null : px(box) });
		};
		const pts = o.points;
		const bound = o.anchoredW || (o.w != null && o.w > 0);
		const hasTop = pts.some((p) => V[p.point] === 0), hasBottom = pts.some((p) => V[p.point] === 1);
		const lineH = (n) => (n * o.font[1] + (n - 1) * (o.spacing || 0)) * s;
		// What the client cuts inside the string's own box.
		if (bound && r.w > 0) {
			if (!o.wrap) {
				for (const l of o.plain.split('\n')) {
					const w = measure(fonts, o.font, l) * s;
					if (w - r.w > 0.5) report('cut', 'its width', w - r.w, r.w / s);
				}
			} else {
				const lines = wrap(fonts, o.font, o.plain, r.w / s);
				for (const l of lines) {
					const w = measure(fonts, o.font, l) * s;
					if (w - r.w > 0.5) report('word', 'its width', w - r.w, r.w / s);
				}
				if (o.maxLines && lines.length > o.maxLines) report('lines', `${o.maxLines} lines`, lines.length - o.maxLines, null);
				else if ((o.h != null || (hasTop && hasBottom)) && lineH(lines.length) - r.h > 0.5) report('lines', `its height (${px(r.h / s)})`, lineH(lines.length) - r.h, null);
			}
		}
		// The window, cut down by every clipping frame above the string; the
		// same without the scroll areas, for height (a scroll area scrolls).
		let box = { x0: rr.x, y0: rr.y, x1: rr.x + rr.w, y1: rr.y + rr.h };
		let fixed = { ...box };
		let scrolls = false;
		for (let cur = parentOf(o); cur && cur !== root; cur = parentOf(cur)) {
			if (!cur.clips) continue;
			const cr = rects.get(cur.id);
			box = intersect(box, cr);
			if (cur.kind === 'ScrollFrame') scrolls = true;
			else fixed = intersect(fixed, cr);
		}
		if (!bound) {
			// Unbound: as wide as its text, grown from its anchor.
			const w = Math.max(...o.plain.split('\n').map((l) => measure(fonts, o.font, l))) * s;
			const hx = pts.length ? H[pts[0].point] ?? 0 : 0;
			const x0 = r.x + r.w * hx - w * hx, x1 = x0 + w;
			if (box.x0 - x0 > 0.5) report('window', `the left edge (${box.x0 === rr.x ? 'window' : 'clip'})`, box.x0 - x0);
			if (x1 - box.x1 > 0.5) report('window', `the right edge (${box.x1 === rr.x + rr.w ? 'window' : 'clip'})`, x1 - box.x1);
			continue;
		}
		if (box.x0 - r.x > 0.5) report('window', 'the left edge (its box)', box.x0 - r.x);
		if (r.x + r.w - box.x1 > 0.5) report('window', 'the right edge (its box)', r.x + r.w - box.x1);
		// Wrapping, its height free: the lines it takes.
		if (!o.wrap || scrolls || (hasTop && hasBottom) || o.h != null || r.w <= 0) continue;
		const h = lineH(wrap(fonts, o.font, o.plain, r.w / s).length);
		const vy = hasTop ? 0 : hasBottom ? 1 : 0.5;
		const y0 = r.y + r.h * vy - h * vy, y1 = y0 + h;
		if (fixed.y0 - y0 > 0.5) report('window', 'the top edge', fixed.y0 - y0);
		if (y1 - fixed.y1 > 0.5) report('window', 'the bottom edge', y1 - fixed.y1);
	}
	return out;
}

const describe = (f) => `"${f.text.length > 70 ? f.text.slice(0, 67) + '...' : f.text}" ${f.kind === 'window' ? 'crosses' : 'is cut at'} ${f.what} by ${f.over}${f.kind === 'lines' && f.what.includes('lines') ? ' line(s)' : 'px'}${f.box != null ? ` (box ${f.box})` : ''}`;

// The panels to lay out: every preview scene's, then Options on every page
// and tab (with every module's pages and the Recorder) in this locale.
function panelsOf(before) {
	const panels = [];
	for (const scene of P.SCENES) scene.panels.forEach((p, i) => panels.push({ ...p, label: `${scene.file} #${i + 1}` }));
	const recorder = P.SCENES.find((s) => s.file === 'options-more.svg').panels[0].before;
	const pages = runAddon({
		stubs: ['stub_ui.lua'],
		before: `${before}\n${recorder}`,
		addons: [{ name: 'Polestar', files: P.MODULE_FILES }],
		script: 'uistub.install()\nstub.login()\nemit(Polestar.UI.Options.Pages())',
	}).emitted[0];
	for (const p of pages) {
		const tabs = Array.isArray(p.tabs) && p.tabs.length ? p.tabs : [null];
		for (const t of tabs) {
			const select = t ? `; Polestar.UI.Options.Select(${JSON.stringify(p.key)}, ${JSON.stringify(t)})` : '';
			panels.push({ files: P.MODULE_FILES, before: recorder, roots: ['PolestarOptions'], label: `Options ${p.key}${t ? ' > ' + t : ''}`, script: `Polestar.UI.ShowOptions(${JSON.stringify(p.key)})${select}` });
		}
	}
	return panels;
}

// -> every finding in one locale ("enUS" for English), file = the locale
// file to load instead of the shipped one.
function auditLocale(locale, { file = null, slack = 1, extraFiles = [] } = {}) {
	const fonts = fontsFor(slack);
	const shipped = Object.keys(LOCALES).map((l) => path.join(LOCALE_DIR, `${l}.lua`));
	const prelude = `${P.metricsLua(fonts, localeCodepoints([...shipped, ...extraFiles]))}\n${localeLua(locale, file)}`;
	const found = [];
	try {
		for (const p of panelsOf(prelude)) {
			for (const [font, prefix] of PASSES) {
				const dump = P.dumpPanel({ ...p, script: prefix + p.script }, prelude);
				for (const f of audit(dump, p.roots, fonts)) found.push({ ...f, where: `${p.label} (${font})` });
			}
			P.cleanupPacks();
		}
	} finally {
		P.cleanupPacks();
	}
	return found;
}

// One entry per string and check, with the places it shows.
function summarize(found) {
	const by = new Map();
	for (const f of found) {
		const key = `${f.kind}\u0000${f.text}\u0000${f.what}`;
		const cur = by.get(key);
		if (!cur) by.set(key, { ...f, places: [f.where] });
		else {
			if (f.over > cur.over) Object.assign(cur, { over: f.over, box: f.box });
			cur.places.push(f.where);
		}
	}
	return [...by.values()].sort((a, b) => b.over - a.over);
}

// English and each of `targets` ({ locale, file }), one process each, side
// by side. -> [{ locale, file, found, translated }]: `found` every string
// that does not fit, `translated` those not cut the same way in English (a
// long guide or item name is cut in every language alike).
function fitLocales(targets, { slack = 1 } = {}) {
	const { spawn } = require('node:child_process');
	const all = [{ locale: 'enUS', file: null }, ...targets.filter((t) => t.locale !== 'enUS')];
	const runs = all.map(({ locale, file }) => new Promise((ok, fail) => {
		const child = spawn(process.execPath, [__filename, file ? `${locale}=${file}` : locale, String(slack)], { stdio: ['ignore', 'pipe', 'pipe'] });
		let out = '', err = '';
		child.stdout.on('data', (d) => (out += d));
		child.stderr.on('data', (d) => (err += d));
		child.on('close', (code) => (code === 0 ? ok({ locale, file, found: JSON.parse(out) }) : fail(new Error(`${locale}: ${err.trim() || `exit ${code}`}`))));
	}));
	return Promise.all(runs).then((results) => {
		const english = new Set(results[0].found.map((f) => `${f.kind}\u0000${f.text}`));
		for (const r of results) r.translated = r.locale === 'enUS' ? [] : r.found.filter((f) => !english.has(`${f.kind}\u0000${f.text}`));
		return results;
	});
}

module.exports = { PASSES, audit, auditLocale, summarize, describe, fontsFor, fitLocales };

// One locale's findings as JSON, for fitLocales: node fit.js <locale>[=<file>] <slack>
if (require.main === module) {
	const [target, slack] = process.argv.slice(2);
	const [locale, file] = target.split('=');
	process.stdout.write(JSON.stringify(summarize(auditLocale(locale, { file: file || null, slack: Number(slack) || 1, extraFiles: file ? [file] : [] }))));
}
