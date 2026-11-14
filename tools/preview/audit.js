'use strict';
// The skin audit (the "every look, every time" rule): every bundled look on
// every surface of Polestar's UI, at UI scales 0.64, 1 and 1.5, laid out by
// the preview harness (tools/preview/render.js, fit.js) from the real addon
// on the test client stub, with the playground driver's geometry
// (tools/play/driver.lua) so the addon places its frames from real
// positions. Each run logs in with the look saved (PolestarDB) and the UI
// scale set, as a player does, and checks the surface as built, then again
// after a repaint (as a change of scale or of a setting makes): a first
// paint that differs from a later one shows either way (#1802). For each
// surface, scale and state:
//
//   clickable   every shown button, check box, edit box and slider of the
//               surface's windows takes the mouse over its whole rect: no
//               other frame that takes the mouse (but its own children) is
//               over any part of it; a settings preview's copies of cards and
//               its hotspots are not checked (they still cover others)
//   overlap     no string's text drawn over another's in the same window
//               (fit.js `overlap`)
//   clipped     no string crossing its window's edge or a frame that clips
//               it, no word wider than its wrapping box (fit.js `window`,
//               `word`; an ellipsis by design is not clipped)
//   contrast    every string reads at MIN_CONTRAST against the ground drawn
//               under it (solid fills and Polestar's own textures; a string
//               over client art or the world is not judged)
//   close       a close button's drawn mark stays inside its window and off
//               its text; in a game look (a kit) a guide window, card, banner
//               or toast close is never larger than the card's (the window's
//               icon buttons and 2, in the kit's ink), a tab's inside its tab
//   frame       no frame painted as the guide window or a toast wears a big
//               window's title bar, drag strip or metal (#1802)
//   error       no Lua error while the surface was built and laid out, and
//               the look itself drew it (a skin refused falls back unseen)
//   shown       the surface's windows are on screen
//
//   const { audit, LOOKS, SURFACES, SCALES } = require('./audit');
//   const { findings, runs } = await audit({ looks, surfaces, scales, jobs });
//   findings: [{ look, surface, check, where, detail, scales: [..],
//                states: ['login', 'repaint'] (where it shows) }]

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { spawn } = require('node:child_process');
const P = require('../commands/preview');
const fit = require('./fit');
const { resolve, readTGA } = require('./render');
const { buildProgram, parseEmitted } = require('../../tests/helpers/lua');
const { findLua } = require('../lib/lua');
const { ROOT } = require('../lib/paths');
// The Share tab's profile in use and a friend's string, as the studio draws them.
const SHARE = require('../studio/scenarios/profile-share');

const DRIVER = path.join(ROOT, 'tools', 'play', 'driver.lua');
const AUDIT_LUA = path.join(__dirname, 'audit.lua');
const MEDIA = path.join(ROOT, 'addon', 'Polestar', 'Media');

// The bundled looks: Polestar's own and its built-in ones, the game's looks
// (Polestar_Looks), and the skins in the download (addon/Polestar_Skin_*).
const LOOKS = [
	{ id: 'polestar', name: 'Polestar' },
	{ id: 'halo', name: 'Halo' },
	{ id: 'hearth', name: 'Hearth' },
	{ id: 'forever', name: 'WoW Forever' },
	{ id: 'blizzard', name: 'Blizzard' },
	{ id: 'classic', name: 'Classic' },
	{ id: 'vellum', name: 'Vellum', addon: 'Polestar_Skin_Vellum' },
	{ id: 'lumen', name: 'Lumen', addon: 'Polestar_Skin_Lumen' },
	{ id: 'beacon', name: 'Beacon', addon: 'Polestar_Skin_Beacon' },
	{ id: 'aurora', name: 'Aurora', addon: 'Polestar_Skin_Aurora' },
	{ id: 'hairline', name: 'Hairline', addon: 'Polestar_Skin_Hairline' },
	{ id: 'umbra', name: 'Umbra', addon: 'Polestar_Skin_Umbra' },
	{ id: 'waymark', name: 'Waymark', addon: 'Polestar_Skin_Waymark' },
	{ id: 'lanterns', name: 'Lanterns', addon: 'Polestar_Skin_Lanterns' },
	{ id: 'sheen', name: 'Sheen', addon: 'Polestar_Skin_Sheen' },
];

// The game's UI scale (UIParent's): the rule's three.
const SCALES = [0.64, 1, 1.5];

// The lowest contrast a string may read at against its ground (WCAG's for
// large text and interface parts; the palettes hold their text to 4.5-7 on
// their own grounds, Theme.LEGIBLE).
const MIN_CONTRAST = 3;

const GUIDE = ['PolestarGuideFrame'];
const CARD = [...GUIDE, 'PolestarClassToast'];
const TABS = 'uistub.openTabs({ { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }, 1)';

// A preview scene's panel, reused as a surface (tools/commands/preview.js
// SCENES): never one that picks a look itself.
function scene(file, index) {
	const s = P.SCENES.find((x) => x.file === file);
	if (!s || !s.panels[index]) throw new Error(`audit: no preview panel ${file}#${index}`);
	const p = s.panels[index];
	if (/ui\.skin/.test(p.script || '')) throw new Error(`audit: ${file}#${index} picks a look itself`);
	return p;
}

// The surfaces. `family: 'guide'`: the guide window and what sits on it or
// stands for it (cards, banners, toasts), where a game look's closes are the
// card's size. `needs`: the Lua module the surface is built from (missing:
// the surface fails, it is never skipped).
const SURFACES = [
	{ key: 'card-class', title: 'the class quest card above the guide window', family: 'guide', ...scene('guide-class-toast.svg', 0) },
	{ key: 'card-dungeon', title: 'the dungeon heads-up above the guide window', family: 'guide', ...scene('guide-dungeon-toast.svg', 0) },
	{
		// The cards as the game raises them: QoL/Spells.lua's LEVELUP_SPELLS and
		// OLD_RANKS, with their notices' fields (UI/SpellCards.lua shows them).
		key: 'card-levelup', title: "the level-up spells card above the guide window (0.3.7)", family: 'guide', roots: CARD, needs: 'Polestar.UI.SpellCards',
		script: `${TABS}
Polestar.Fire("LEVELUP_SPELLS", { level = 18, cost = 6400, money = 5230, spells = { { id = 13550, rank = 3, cost = 1800 }, { id = 14318, rank = 2, cost = 1800 }, { id = 2643, rank = 1, cost = 1800 }, { id = 19884, cost = 1000 } } })
assert(Polestar.UI.ClassToast.current, "no level-up spells card")`,
	},
	{
		key: 'card-ranks', title: 'the old ranks card above the guide window (0.3.7)', family: 'guide', roots: CARD, needs: 'Polestar.UI.SpellCards',
		script: `${TABS}
Polestar.Fire("OLD_RANKS", { slots = 3, spells = { { id = 13549, bestId = 13550, name = "Serpent Sting", have = 2, best = 3, slots = { 3 } }, { id = 14260, bestId = 14261, name = "Raptor Strike", have = 2, best = 3, slots = { 2 } } } })
assert(Polestar.UI.ClassToast.current, "no old ranks card")`,
	},
	{
		key: 'card-update', title: 'the update card above the guide window and its banner line (0.3.7)', family: 'guide', roots: CARD, needs: 'Polestar.UI.UpdateCard',
		script: `${TABS}
assert(Polestar.UI.UpdateCard, "no update card")
Polestar.version = "0.3.8"
PolestarClientInfo = { latest = "0.3.9", checked = time(), releases = { "0.3.9", "0.3.8" } }
Polestar.UI.UpdateCard.Show(true)`,
	},
	{ key: 'guide', title: 'the guide window: three tabs and their closes, the step', family: 'guide', ...scene('guide.svg', 0) },
	{ key: 'guide-hub', title: 'the guide window on a hub step', family: 'guide', ...scene('guide.svg', 1) },
	{ key: 'guide-card', title: "a class quest's card in the guide window", family: 'guide', ...scene('guide-class-card.svg', 0) },
	{
		key: 'banner-closed', title: 'the closed tab banner (Reopen) on the guide window', family: 'guide', roots: GUIDE,
		script: `${TABS}
Polestar.Fire("TAB_CLOSED", uistub.tailoring)`,
	},
	{ key: 'banner-outlevel', title: 'the out-levelled banner on the guide window', family: 'guide', ...scene('guide-states.svg', 2) },
	{ key: 'guide-menu', title: "the guide window's menu", family: 'guide', ...scene('guide-states.svg', 3), targets: ['PolestarMenu'] },
	{ key: 'transparent', title: 'transparent: the bar kept shown, While you are here, the tip open', family: 'guide', ...scene('guide-transparent.svg', 2) },
	{ key: 'compact', title: 'compact', family: 'guide', ...scene('guide-compact.svg', 0) },
	{ key: 'compact-transparent', title: 'compact and transparent', family: 'guide', ...scene('guide-compact.svg', 1) },
	{ key: 'toast-rare', title: 'the rare alert', family: 'guide', ...scene('rares-toast.svg', 0) },
	{ key: 'toast-alert', title: 'the notice alert', family: 'guide', ...scene('instance-hint.svg', 0) },
	{
		key: 'toast-whilehere', title: "the While you're here toast", family: 'guide', roots: ['PolestarWhileHereToast'], needs: 'Polestar.UI.WhileHereToast',
		script: `local T = Polestar.UI.WhileHereToast
assert(T and T.Show, "no While you're here toast")
T.Show({ t = "kill", here = "goal", verb = "Kill", subject = "Kobold Vermin", yards = 60, step = 7, index = 1 })`,
	},
	{
		key: 'hud-timer', title: 'the flight timer', family: 'guide', roots: ['PolestarFlightTimer'], files: P.MODULE_FILES,
		script: 'local f = PolestarFlightTimer; f.Dest:SetText("Stormwind"); f.Time:SetText("1:42"); Polestar.Widgets.SetProgress(f.Progress, 0.4); f:Show()',
	},
	{
		key: 'dialog-confirm', title: 'the confirm dialog', roots: ['PolestarModal'],
		script: `${TABS}
Polestar.Widgets.Modal({ title = "Reset this guide?", text = "Your check-offs in this guide are cleared.", action = "Reset", danger = true, onAccept = function() end })`,
	},
	{ key: 'route-choice', title: 'the route choice window', ...scene('route-choice.svg', 0) },
	{ key: 'welcome', title: 'the welcome window', ...scene('welcome.svg', 0) },
	{ key: 'whats-new', title: "What's new", ...scene('whats-new.svg', 0) },
	{ key: 'report', title: 'the report window', ...scene('report.svg', 0) },
	{ key: 'copy', title: 'the copy window', ...scene('report.svg', 1) },
	{ key: 'picker', title: 'the guide list', ...scene('picker.svg', 0) },
	{ key: 'settings-guide', title: 'the settings window: Guide', ...scene('options.svg', 0) },
	{ key: 'settings-theme', title: 'the settings window: Colour', ...scene('settings-theme.svg', 0) },
	{ key: 'settings-guidewindow', title: 'the settings window: Window', ...scene('settings-guidewindow.svg', 0) },
	{ key: 'settings-alerts', title: 'the settings window: Alerts', ...scene('settings-alerts.svg', 0) },
	// The Profiles page's Share tab: Make a string's checklist with the Guide
	// window's list open (the string made is left out: one long word in a
	// copy box, which fit.js measures unbroken); a friend's string pasted, its
	// changes open (yours, theirs).
	{
		key: 'settings-share', title: "the settings window: Profiles, Share (Make a string's checklist, a category's list open)", roots: ['PolestarOptions'],
		script: `${SHARE.MINE}
Polestar.UI.ShowOptions("profiles")
Polestar.UI.Options.Select("profiles", Polestar.L["Share"])
Polestar.UI.Profiles.Open("export", "window")`,
	},
	{
		key: 'settings-share-import', title: "the settings window: Profiles, Share (a friend's string pasted, a category's changes open)", roots: ['PolestarOptions'],
		script: `${SHARE.MINE}
Polestar.UI.ShowOptions("profiles")
Polestar.UI.Options.Select("profiles", Polestar.L["Share"])
local PV = Polestar.UI.Profiles
PV.Check(Polestar.Profiles.Pack(${JSON.stringify(SHARE.FRIEND)}))
PV.Open("import", "window")
Polestar.Widgets.ScrollTo(PolestarOptions.Scroll, math.max(0, (PV.views[Polestar.L["Share"]].ImportCard.psTop or 0) - 16))`,
	},
];

const q = (s) => JSON.stringify(String(s));

// PolestarDB as a player who picked `look` has it: the look, the welcome and
// this version's notes seen.
function savedFor(look) {
	return `PolestarDB = { schema = 1, welcomeSeen = 99, settings = { ui = { skin = ${q(look.id)} } } }
do local WN = Polestar.UI and Polestar.UI.WhatsNew; if WN and WN.LATEST then PolestarDB.whatsNewSeen = WN.LATEST end end`;
}

// A skin addon's look registers only where Polestar holds every setting its
// layout preset names (the Skin API refuses a preset naming one it lacks):
// the arrow's, the pins' and the route lines' come along with a surface's
// own files for those looks (after the theme, as the TOC orders them).
// Without them most concept skins were refused and the surface was checked
// in Polestar's own look. A surface that loads some of them itself (the route
// choice loads Nav for its cards' map marks) gets the rest after those, so
// Nav still comes before the route lines.
const SKIN_FILES = ['Nav/Nav.xml', 'Maps/FlightPaths.lua', 'Maps/RouteStrokes.lua', 'Maps/RouteSparkle.lua', 'Maps/RouteLines.lua'];
function filesFor(look, surface) {
	const files = surface.files || P.FILES;
	if (!look.addon) return files;
	const extra = SKIN_FILES.filter((f) => !files.includes(f));
	const at = Math.max(files.indexOf('Theme/Theme.xml'), ...SKIN_FILES.map((f) => files.indexOf(f))) + 1;
	return extra.length && files.includes('Theme/Theme.xml') ? [...files.slice(0, at), ...extra, ...files.slice(at)] : files;
}

// The Lua run of one look on one surface at UI scale `scale`, set before
// login: the addon builds and places everything at that scale, as at a
// player's login (a later change of scale repaints, and would hide a first
// paint's mistakes).
function program(look, surface, prelude, scale) {
	const missing = surface.needs ? `do local v = _G; for k in (${q(surface.needs)}):gmatch("[^.]+") do v = type(v) == "table" and v[k] or nil end; if v == nil then error(${q(`missing ${surface.needs}`)}, 0) end end\n` : '';
	return buildProgram({
		stubs: surface.stubs || ['stub_ui.lua'],
		before: [P.panelBefore(surface, prelude), `dofile(${q(DRIVER)})`, `dofile(${q(AUDIT_LUA)})`].join('\n'),
		addons: [{ name: 'Polestar', files: filesFor(look, surface) }, ...(surface.addons || []), ...(look.addon ? [look.addon] : [])],
		saved: { Polestar: savedFor(look) },
		script: `UIParent:SetScale(${scale})\n${surface.stubs ? '' : 'uistub.install()\n'}stub.login()\nstub.advance(1)\n${missing}${surface.script}\nstub.advance(1)\naudit.dump(${q(surface.key)}, ${scale})`,
	});
}

// One look on one surface at one scale: its dumps (at login, after a
// repaint), or its error.
function run(look, surface, prelude, scale) {
	return new Promise((done) => {
		const file = path.join(os.tmpdir(), `polestar-audit-${process.pid}-${look.id}-${surface.key}-${scale}-${Math.random().toString(36).slice(2)}.lua`);
		fs.writeFileSync(file, program(look, surface, prelude, scale));
		const child = spawn(findLua(), [file], { cwd: ROOT, stdio: ['ignore', 'pipe', 'pipe'] });
		const out = [];
		let err = '';
		child.stdout.on('data', (d) => out.push(d));
		child.stderr.on('data', (d) => (err += d));
		child.on('close', (code) => {
			fs.rmSync(file, { force: true });
			const stdout = Buffer.concat(out).toString('utf8');
			if (code !== 0) {
				// The error, without the interpreter's name, the traceback or the
				// generated script's own path.
				const why = (err.trim() || stdout.trim().split('\n').slice(-3).join(' ')).split(/\s*stack traceback:/)[0];
				return done({ error: why.replace(/^\S*lua\S*: /, '').replace(/\S*polestar-audit-[^\s:]*\.lua:\d+: /g, '').split('\n').slice(0, 2).join(' | ') });
			}
			const dumps = parseEmitted(stdout).filter((e) => e && e.objects);
			done(dumps.length ? { dumps } : { error: 'no dump emitted' });
		});
	});
}

// ---------------------------------------------------------------------------
// Colour

const lin = (c) => (c <= 0.04045 ? c / 12.92 : ((c + 0.055) / 1.055) ** 2.4);
const lum = (c) => 0.2126 * lin(c[0]) + 0.7152 * lin(c[1]) + 0.0722 * lin(c[2]);
const ratio = (a, b) => {
	const x = lum(a), y = lum(b);
	return (Math.max(x, y) + 0.05) / (Math.min(x, y) + 0.05);
};
// c (with alpha) over an opaque ground.
const over = (c, g) => [0, 1, 2].map((i) => c[i] * c[3] + g[i] * (1 - c[3]));

const tgas = new Map();
function tga(name) {
	if (!tgas.has(name)) {
		let file = null;
		const other = /^addon:([\w-]+)\/(.+)$/.exec(name);
		const sub = /^(Nav|Map)\/([\w-]+)$/.exec(name);
		if (other) file = path.join(ROOT, 'addon', other[1], other[2] + '.tga');
		else if (sub) file = path.join(MEDIA, sub[1], sub[2] + '.tga');
		else if (!/^fid:/.test(name)) file = path.join(MEDIA, 'UI', name + '.tga');
		tgas.set(name, file && fs.existsSync(file) ? readTGA(file) : null);
	}
	return tgas.get(name);
}
// The texture's name as the preview loads it (render.js textureName), or null
// for art the repository does not hold (client files, atlases).
function textureName(p) {
	if (p === null || p === undefined) return null;
	if (typeof p === 'number' || /^\d+$/.test(String(p))) return null;
	const m = /Polestar\\Media\\UI\\([\w-]+)$/.exec(p);
	if (m) return m[1];
	const sub = /Polestar\\Media\\(Nav|Map)\\([\w-]+)$/.exec(p);
	if (sub) return `${sub[1]}/${sub[2]}`;
	const own = /AddOns\\((?!Polestar\\)[\w-]+)\\([\w\\-]+)$/.exec(p);
	if (own) return `addon:${own[1]}/${own[2].replace(/\\/g, '/')}`;
	if (/WHITE8X8/i.test(p)) return 'white';
	return null;
}

// ---------------------------------------------------------------------------
// One dump's findings

const REGION = new Set(['Texture', 'FontString', 'MaskTexture', 'Line']);
const CONTROL = new Set(['Button', 'CheckButton', 'EditBox', 'Slider']);
const STRATA = { BACKGROUND: 0, LOW: 1, MEDIUM: 2, HIGH: 3, DIALOG: 4, FULLSCREEN: 5, FULLSCREEN_DIALOG: 6, TOOLTIP: 7 };
const LAYER = { BACKGROUND: 0, BORDER: 1, ARTWORK: 2, OVERLAY: 3, HIGHLIGHT: 4 };
// The world behind the UI where a surface lets it through: a mid-dark scene.
const WORLD = [0.22, 0.22, 0.2];

function analyze(dump, surface, fonts) {
	const found = [];
	const add = (check, where, detail) => found.push({ check, where, detail });
	const objects = dump.objects;
	const { byId, rects, scaleOf } = resolve(objects, fonts);
	const parentOf = (o) => (o.parent != null ? byId.get(o.parent) : null);
	const visible = (o) => {
		for (let c = o; c; c = parentOf(c)) if (!c.shown) return false;
		return true;
	};
	const alphaOf = (o) => {
		let a = 1;
		for (let c = o; c; c = parentOf(c)) a *= c.alpha ?? 1;
		return a;
	};
	const levels = new Map();
	const levelOf = (o) => {
		if (levels.has(o.id)) return levels.get(o.id);
		const p = parentOf(o);
		const l = o.level != null ? o.level : p ? levelOf(p) + 1 : 0;
		levels.set(o.id, l);
		return l;
	};
	const strataOf = (o) => {
		for (let c = o; c; c = parentOf(c)) if (c.strata) return STRATA[c.strata] ?? 2;
		return 2;
	};
	const within = (o, anc) => {
		for (let c = o; c; c = parentOf(c)) if (c === anc) return true;
		return false;
	};
	const rootOf = (o) => {
		for (let c = o; c; c = parentOf(c)) if (surface.roots.includes(c.name)) return c;
		return null;
	};
	// A rect cut to every frame above `o` that clips it.
	const clipped = (o, r) => {
		let x0 = r.x, y0 = r.y, x1 = r.x + r.w, y1 = r.y + r.h;
		for (let c = parentOf(o); c; c = parentOf(c)) {
			if (!(c.clips || c.kind === 'ScrollFrame')) continue;
			const cr = rects.get(c.id);
			x0 = Math.max(x0, cr.x); y0 = Math.max(y0, cr.y); x1 = Math.min(x1, cr.x + cr.w); y1 = Math.min(y1, cr.y + cr.h);
		}
		return { x: x0, y: y0, w: Math.max(0, x1 - x0), h: Math.max(0, y1 - y0) };
	};
	const named = (o) => {
		for (let c = o; c; c = parentOf(c)) if (c.name) return c.name;
		return '?';
	};
	const labelOf = (o) => {
		const texts = objects.filter((x) => x.kind === 'FontString' && x.parent === o.id && x.plain && x.plain.trim() && x.shown !== false);
		if (texts.length) return texts[0].plain.trim().slice(0, 40);
		return o.icon ? `(${o.icon})` : o.role ? `(${o.role})` : o.tip ? `(${o.tip.slice(0, 40)})` : '';
	};
	const describe = (o) => {
		if (o.kitKey) return `${named(o)} kit ${o.kitKey}`;
		const label = labelOf(o);
		return `${o.name && o.name !== named(parentOf(o) || o) ? o.name : named(o)} ${o.kind}${label ? ` "${label}"` : ''}`;
	};

	// Shown: the surface's windows are on screen.
	const roots = objects.filter((o) => surface.roots.includes(o.name) && visible(o) && alphaOf(o) > 0.01);
	if (!roots.length) add('shown', surface.roots.join(', '), 'not on screen');
	// Lua's empty tables arrive as {}.
	const list = (v) => (Array.isArray(v) ? v : []);
	for (const e of list(dump.extra.errors)) add('error', 'Lua', String(e).split('\n')[0].slice(0, 200));
	for (const b of list(dump.extra.big)) {
		const name = b.split(':')[0];
		if (surface.roots.some((r) => name === r || name.startsWith(`${r}>`))) add('frame', name, `a big window's pieces on it:${b.split(':').slice(1).join(':')}`);
	}

	const frames = objects.filter((o) => !REGION.has(o.kind) && visible(o));
	frames.sort((a, b) => strataOf(a) - strataOf(b) || levelOf(a) - levelOf(b) || a.seq - b.seq);
	const order = new Map(frames.map((f, i) => [f.id, i]));

	// Clickable.
	const takesMouse = (o) => o.mouse === true || (o.mouse !== false && CONTROL.has(o.kind));
	const hitRect = (o) => {
		const r = clipped(o, rects.get(o.id));
		const s = scaleOf(o);
		const h = o.hitInsets || [0, 0, 0, 0];
		return { x: r.x + (h[0] || 0) * s, y: r.y + (h[2] || 0) * s, w: r.w - ((h[0] || 0) + (h[1] || 0)) * s, h: r.h - ((h[2] || 0) + (h[3] || 0)) * s };
	};
	const blockers = frames.filter(takesMouse).map((o) => ({ o, r: hitRect(o), i: order.get(o.id) }));
	// The controls checked: those of the surface's own windows (`targets`, else
	// its roots; a menu's, not the window behind its click catcher), never a
	// settings preview's copies (their buttons do nothing) or its hotspots
	// (layered by design, a part's over the whole); both still cover others.
	const targets = surface.targets || surface.roots;
	const inTargets = (o) => {
		for (let c = o; c; c = parentOf(c)) if (targets.includes(c.name)) return true;
		return false;
	};
	const sandboxed = (o) => {
		for (let c = o; c; c = parentOf(c)) if (c.sandbox) return true;
		return false;
	};
	for (const t of frames) {
		if (!CONTROL.has(t.kind) || t.mouse === false || t.disabled || t.hotspot || !inTargets(t) || sandboxed(t) || alphaOf(t) < 0.05) continue;
		const r = hitRect(t);
		if (r.w < 3 || r.h < 3) continue;
		const nx = Math.max(2, Math.min(12, Math.round(r.w / 6))), ny = Math.max(2, Math.min(6, Math.round(r.h / 6)));
		let covered = 0;
		const by = new Set();
		for (let ix = 0; ix < nx; ix++) {
			for (let iy = 0; iy < ny; iy++) {
				const x = r.x + 1 + ((r.w - 2) * (ix + 0.5)) / nx, y = r.y + 1 + ((r.h - 2) * (iy + 0.5)) / ny;
				let top = null;
				for (const b of blockers) {
					if (x >= b.r.x && x < b.r.x + b.r.w && y >= b.r.y && y < b.r.y + b.r.h && (!top || b.i > top.i)) top = b;
				}
				if (!top || !within(top.o, t)) {
					covered++;
					by.add(top ? describe(top.o) : 'nothing');
				}
			}
		}
		if (covered) add('clickable', describe(t), `${Math.round((covered / (nx * ny)) * 100)}% covered by ${[...by].sort().join(', ')}`);
	}

	// Text: clipped and overlapping strings (the preview harness's audit).
	for (const f of fit.audit(dump, surface.roots, fonts, ['window', 'word', 'overlap'])) {
		add(f.kind === 'overlap' ? 'overlap' : 'clipped', f.text.slice(0, 60), fit.describe(f));
	}

	// Contrast: each string against what is drawn under its middle.
	const regionsOf = new Map();
	for (const o of objects) {
		if (!REGION.has(o.kind) || o.shown === false) continue;
		if (!regionsOf.has(o.parent)) regionsOf.set(o.parent, []);
		regionsOf.get(o.parent).push(o);
	}
	const drawn = [];
	for (const f of frames) {
		if (alphaOf(f) <= 0.001) continue;
		const regs = (regionsOf.get(f.id) || []).slice().sort((x, y) => (LAYER[x.layer] ?? 2) - (LAYER[y.layer] ?? 2) || (x.sublayer || 0) - (y.sublayer || 0) || x.seq - y.seq);
		for (const g of regs) drawn.push(g);
	}
	const colourAt = (t, x, y) => {
		const r = rects.get(t.id);
		const vc = t.vertexColor || [1, 1, 1, 1];
		const a = alphaOf(t) * (t.alpha ?? 1);
		if (t.color) return [t.color[0] * vc[0], t.color[1] * vc[1], t.color[2] * vc[2], (t.color[3] ?? 1) * (vc[3] ?? 1) * a];
		const name = textureName(t.texture);
		if (!name) return null;
		const u = r.w > 0 ? (x - r.x) / r.w : 0.5, v = r.h > 0 ? (y - r.y) / r.h : 0.5;
		if (t.gradient) {
			const g = t.gradient, k = g.orientation === 'VERTICAL' ? 1 - v : u;
			const c = [0, 1, 2, 3].map((i) => (g.min[i] ?? 1) + ((g.max[i] ?? 1) - (g.min[i] ?? 1)) * k);
			if (name === 'white') return [c[0], c[1], c[2], c[3] * a];
		}
		if (name === 'white') return [vc[0], vc[1], vc[2], (vc[3] ?? 1) * a];
		const img = tga(name);
		if (!img) return null;
		const tc = t.texCoord && t.texCoord.length === 4 ? t.texCoord : [0, 1, 0, 1];
		const tu = tc[0] + (tc[1] - tc[0]) * u, tv = tc[2] + (tc[3] - tc[2]) * v;
		const px = Math.min(img.w - 1, Math.max(0, Math.floor(tu * img.w))), py = Math.min(img.h - 1, Math.max(0, Math.floor(tv * img.h)));
		const d = (py * img.w + px) * 4;
		return [(img.px[d] / 255) * vc[0], (img.px[d + 1] / 255) * vc[1], (img.px[d + 2] / 255) * vc[2], (img.px[d + 3] / 255) * (vc[3] ?? 1) * a];
	};
	// A disabled control's text is exempt (an inactive control, as WCAG has it).
	const inDisabled = (o) => {
		for (let c = parentOf(o); c; c = parentOf(c)) if (c.disabled) return true;
		return false;
	};
	drawn.forEach((s, at) => {
		if (s.kind !== 'FontString' || !s.plain || !s.plain.trim() || !rootOf(s) || inDisabled(s)) return;
		const tcol = s.textColor || [1, 1, 1, 1];
		const ta = (tcol[3] ?? 1) * alphaOf(s);
		if (ta <= 0.01) return;
		const r = clipped(s, rects.get(s.id));
		if (r.w <= 0 || r.h <= 0) return;
		const x = r.x + r.w / 2, y = r.y + r.h / 2;
		// Back to front: art the repository does not hold (client files and
		// atlases) leaves the ground unknown until an opaque fill covers it.
		let ground = WORLD, own = 0, unknown = false;
		for (let i = 0; i < at; i++) {
			const t = drawn[i];
			if (t.kind !== 'Texture') continue;
			if (t.layer === 'HIGHLIGHT' && !(parentOf(t) || {}).hover) continue;
			const tr = clipped(t, rects.get(t.id));
			if (!(x >= tr.x && x < tr.x + tr.w && y >= tr.y && y < tr.y + tr.h)) continue;
			const c = colourAt(t, x, y);
			if (!c) {
				if (alphaOf(t) * (t.alpha ?? 1) >= 0.5) unknown = true;
				continue;
			}
			if (c[3] <= 0.001 || t.blend === 'ADD') continue;
			if (c[3] >= 0.95) unknown = false;
			ground = over(c, ground);
			own = own + c[3] * (1 - own);
		}
		if (unknown) return; // client art under it: not judged
		if (own < 0.6) return; // on the world: the outline and shades carry it
		const text = over([tcol[0], tcol[1], tcol[2], Math.min(1, ta)], ground);
		// An outlined string carries its own ground: its black outline.
		const outlined = /OUTLINE/.test((s.font && s.font[2]) || '');
		const cr = Math.max(ratio(text, ground), outlined ? ratio(text, [0, 0, 0]) : 0);
		if (cr < MIN_CONTRAST) add('contrast', s.plain.trim().slice(0, 60), `${cr.toFixed(2)}:1 on its ground (${named(s)})`);
	});

	// Closes.
	const look = dump.extra.look || {};
	const kit = look.kit || null;
	const inkOf = (o) => {
		const regs = (regionsOf.get(o.id) || []).filter((g) => g.kind === 'Texture' && g.shown !== false && alphaOf(g) * (g.alpha ?? 1) > 0.05 && g.layer !== 'HIGHLIGHT');
		const art = regs.find((g) => g.kitKey === 'closeN');
		const glyph = regs.find((g) => !g.kitKey);
		const t = art || glyph;
		if (!t) return null;
		const r = rects.get(t.id), s = scaleOf(o);
		const ink = art && kit ? kit.ink || 1 : 1;
		return { art: !!art, rect: r, size: (Math.max(r.w, r.h) / s) * ink, inkRect: { x: r.x + (r.w * (1 - ink)) / 2, y: r.y + (r.h * (1 - ink)) / 2, w: r.w * ink, h: r.h * ink } };
	};
	const texts = objects.filter((o) => o.kind === 'FontString' && o.plain && o.plain.trim() && visible(o) && alphaOf(o) > 0.05);
	for (const b of frames) {
		if (b.icon !== 'close' || b.kitKey === 'closeButton' || !rootOf(b) || alphaOf(b) < 0.05) continue;
		const ink = inkOf(b);
		if (!ink) continue;
		const root = rootOf(b);
		const rr = clipped(b, rects.get(root.id));
		const ir = ink.inkRect;
		if (ir.x < rr.x - 0.5 || ir.y < rr.y - 0.5 || ir.x + ir.w > rr.x + rr.w + 0.5 || ir.y + ir.h > rr.y + rr.h + 0.5) add('close', describe(b), "its mark crosses its window's edge");
		for (const s of texts) {
			if (within(s, b) || rootOf(s) !== root) continue;
			const t = fit.textInk(s, rects.get(s.id), scaleOf(s), fonts);
			const w = Math.min(t.x1, ir.x + ir.w) - Math.max(t.x0, ir.x);
			const h = Math.min(t.y1, ir.y + ir.h) - Math.max(t.y0, ir.y);
			if (w > 0.5 && h > 0.5) add('close', describe(b), `its mark lies over "${s.plain.trim().slice(0, 30)}"`);
		}
		if (!kit || surface.family !== 'guide') continue;
		const s = scaleOf(b);
		const target = b.tabClose ? rects.get(b.id).w / s : ink.art ? look.iconBtn + 2 : look.guideIcon;
		if (ink.size > target + 0.5) add('close', describe(b), `${ink.size.toFixed(1)} units drawn, the ${b.tabClose ? 'tab close target' : ink.art ? "card's close" : "window's icon glyph"} is ${target}`);
	}
	return found;
}

// ---------------------------------------------------------------------------
// The audit

// When a surface is checked: as built at login, and after a repaint.
const STATES = ['login', 'repaint'];

// Findings across scales and states of one look and surface, merged: one
// entry with the scales and states it shows at.
function merge(look, surface, perScale) {
	const by = new Map();
	for (const [scale, list] of perScale) {
		for (const { state, ...f } of list) {
			const key = `${f.check}\u0000${f.where}\u0000${f.detail.replace(/\d+(\.\d+)?/g, '#')}`;
			let cur = by.get(key);
			if (!cur) {
				cur = { look: look.id, surface: surface.key, ...f, scales: [], states: [] };
				by.set(key, cur);
			}
			if (!cur.scales.includes(scale)) cur.scales.push(scale);
			for (const s of state ? [state] : STATES) if (!cur.states.includes(s)) cur.states.push(s);
		}
	}
	return [...by.values()];
}

async function audit({ looks = LOOKS, surfaces = SURFACES, scales = SCALES, jobs = Math.max(1, Math.min(4, os.cpus().length - 1)), slack = 1.15, onRun = null } = {}) {
	const fonts = fit.fontsFor(slack);
	const prelude = P.metricsLua(fonts);
	const tasks = [];
	for (const look of looks) for (const surface of surfaces) for (const scale of scales) tasks.push({ look, surface, scale, found: null });
	const runs = [];
	let next = 0;
	const worker = async () => {
		while (next < tasks.length) {
			const task = tasks[next++];
			const { look, surface, scale } = task;
			const t0 = Date.now();
			const r = await run(look, surface, prelude, scale);
			task.found = r.error ? [{ check: 'shown', where: surface.roots.join(', '), detail: `could not be built: ${r.error}` }] : r.dumps.flatMap((d) => analyze(d, surface, fonts).map((f) => ({ ...f, state: d.extra.state })));
			// The look itself in use: a look the run fell back from is not checked at all.
			for (const d of r.dumps || []) {
				const drawn = d.extra.look && d.extra.look.skin;
				if (drawn && drawn !== look.id) task.found.push({ check: 'error', where: 'the look', detail: `${look.id} did not apply: ${drawn} drew the surface`, state: d.extra.state });
			}
			const ms = Date.now() - t0;
			runs.push({ look: look.id, surface: surface.key, scale, ms });
			if (onRun) onRun(look, surface, scale, ms);
		}
	};
	try {
		await Promise.all(Array.from({ length: Math.min(jobs, tasks.length) }, worker));
	} finally {
		P.cleanupPacks();
	}
	// In the looks' and surfaces' order, each one's scales merged.
	const findings = [];
	for (let i = 0; i < tasks.length; i += scales.length) {
		const group = tasks.slice(i, i + scales.length);
		findings.push(...merge(group[0].look, group[0].surface, group.map((t) => [t.scale, t.found])));
	}
	return { findings, runs };
}

const line = (f) => `${f.look} · ${f.surface} · ${f.check} · ${f.where}: ${f.detail}${f.scales.length < SCALES.length ? ` (at ${f.scales.join(', ')})` : ''}${f.states.length < STATES.length ? ` (${f.states[0] === 'login' ? 'at login' : 'after a repaint'})` : ''}`;

module.exports = { audit, analyze, program, run, LOOKS, SURFACES, SCALES, MIN_CONTRAST, line };

// node tools/preview/audit.js [look ...] [--surface key,...] [--scale s,...] [--jobs n]: the findings, one per line.
if (require.main === module) {
	const args = process.argv.slice(2);
	const opt = (k) => {
		const i = args.indexOf(k);
		return i >= 0 ? args.splice(i, 2)[1] : null;
	};
	const only = opt('--surface');
	const at = opt('--scale');
	const jobs = Number(opt('--jobs')) || undefined;
	const looks = args.length ? LOOKS.filter((l) => args.includes(l.id)) : LOOKS;
	const surfaces = only ? SURFACES.filter((s) => only.split(',').includes(s.key)) : SURFACES;
	const scales = at ? at.split(',').map(Number) : SCALES;
	audit({ looks, surfaces, scales, jobs, onRun: (l, s, scale, ms) => process.stderr.write(`${l.id}/${s.key}@${scale} ${ms} ms\n`) }).then(({ findings }) => {
		for (const f of findings) console.log(line(f));
		console.log(`${findings.length} findings`);
	});
}
