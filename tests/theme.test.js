'use strict';
// Polestar.Theme (colour schemes, custom colours, legibility, the
// EllesmereUI path), Polestar.Anim, and the textures the UI shows.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ADDONS } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script, { before = '' } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		before,
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\nlocal T, W = Polestar.Theme, Polestar.Widgets\n${script}`,
	}).emitted;
}

const round = (list) => list.map((v) => Math.round(v * 1000) / 1000);

// WCAG 2 contrast, computed here independently of Theme.Contrast.
const lin = (c) => (c <= 0.04045 ? c / 12.92 : ((c + 0.055) / 1.055) ** 2.4);
const lum = ([r, g, b]) => 0.2126 * lin(r) + 0.7152 * lin(g) + 0.0722 * lin(b);
const contrast = (a, b) => {
	const [x, y] = [lum(a), lum(b)].sort((p, q) => q - p);
	return (x + 0.05) / (y + 0.05);
};
const GROUNDS = ['bg', 'panel', 'panelAlt', 'sidebar', 'footer', 'sky'];
const SUBJECTS = ['quest', 'npc', 'item', 'place', 'object', 'level', 'skill', 'spell', 'faction', 'area', 'achievement', 'dungeon', 'rare', 'success', 'warning', 'danger'];

// Every ground must carry primary text at 7:1 and the secondary and muted
// text at 4.5:1; the subject and status colours need 4.5:1 on every ground
// but the header sky (only titles sit on the band).
function assertLegible(name, pal) {
	for (const g of GROUNDS) {
		assert.ok(contrast(pal.text, pal[g]) >= 7, `${name}: text on ${g} is ${contrast(pal.text, pal[g]).toFixed(2)}:1`);
		for (const role of ['textDim', 'textMuted', ...(g === 'sky' ? [] : SUBJECTS)]) {
			const c = contrast(pal[role], pal[g]);
			assert.ok(c >= 4.5, `${name}: ${role} on ${g} is ${c.toFixed(2)}:1`);
		}
	}
}

test('every colour scheme keeps the text ladder legible on every ground (7:1 primary, 4.5:1 the rest)', () => {
	const [out] = run(`
		local out = {}
		for _, key in ipairs(T.SCHEME_ORDER) do
			Polestar.Set("ui.scheme", key)
			out[key] = T.Palette()
		end
		emit(out)`);
	assert.deepEqual(Object.keys(out).sort(), ['dusk', 'graphite', 'night']);
	for (const [key, pal] of Object.entries(out)) assertLegible(key, pal);
});

// Colours from outside the palette go through Theme.Legible: the client's
// item qualities (Poor..Artifact) and quest difficulty colours. A dimmed name
// keeps that colour (its chip says why), so each must read at 4.5:1 on the
// lightest place a name sits, a selected row on the panel.
test('item quality and quest difficulty colours, lifted, read at 4.5:1 on a selected row in every scheme', () => {
	const [out] = run(`
		local OUTSIDE = {
			{ 0.62, 0.62, 0.62 }, { 1, 1, 1 }, { 0.12, 1, 0 }, { 0, 0.44, 0.87 }, { 0.64, 0.21, 0.93 }, { 1, 0.5, 0 }, { 0.9, 0.8, 0.5 },
			{ 1, 0.1, 0.1 }, { 1, 0.5, 0.25 }, { 1, 0.82, 0 }, { 0.25, 0.75, 0.25 }, { 0.5, 0.5, 0.5 },
		}
		local out = {}
		for _, key in ipairs(T.SCHEME_ORDER) do
			Polestar.Set("ui.scheme", key)
			local o = { ground = T.LightestGround(), panel = T.Palette().panel, lifted = {}, epic = { Polestar.UI.Lookup.QualityColor(4) } }
			for i, c in ipairs(OUTSIDE) do o.lifted[i] = { T.Legible(c[1], c[2], c[3]) } end
			out[key] = o
		end
		emit(out)`);
	for (const [key, o] of Object.entries(out)) {
		assert.ok(lum(o.ground) > lum(o.panel), `${key}: a selected row is lighter than the panel`);
		o.lifted.forEach((c, i) => {
			const r = contrast(c, o.ground);
			assert.ok(r >= 4.5, `${key}: outside colour ${i + 1} reads ${r.toFixed(2)}:1 on a selected row`);
		});
		const epic = contrast(o.epic, o.ground);
		assert.ok(epic >= 4.5, `${key}: an epic name (the retired Reins of the Frostsaber) reads ${epic.toFixed(2)}:1`);
	}
});

test('Dusk is the default and visibly lighter than Night; Night keeps the original palette exactly', () => {
	const [out] = run(`
		local dusk = T.Palette()
		Polestar.Set("ui.scheme", "night")
		emit({ key = dusk.scheme, dusk = dusk, night = T.Palette() })`);
	assert.equal(out.key, 'dusk');
	for (const g of ['bg', 'panel', 'panelAlt', 'sidebar', 'footer', 'sky']) {
		assert.ok(lum(out.dusk[g]) > lum(out.night[g]) * 2, `Dusk ${g} is clearly lighter`);
		assert.ok(out.dusk[g][2] > out.dusk[g][0], `Dusk ${g} stays navy, not grey`);
	}
	assert.deepEqual(round(out.night.bg), [0.039, 0.051, 0.086, 0.97]);
	assert.deepEqual(round(out.night.panel), [0.051, 0.066, 0.11, 0.98]);
	assert.deepEqual(round(out.night.panelAlt), [0.075, 0.094, 0.149, 1]);
	assert.deepEqual(round(out.night.sidebar), [0.027, 0.035, 0.063, 1]);
	assert.deepEqual(round(out.night.footer), [0.031, 0.04, 0.071, 1]);
	assert.deepEqual(round(out.night.text), [0.96, 0.97, 0.99, 1]);
	assert.deepEqual(round(out.night.textDim), [0.69, 0.72, 0.8, 1]);
	assert.deepEqual(round(out.night.textMuted), [0.5, 0.54, 0.63, 1]);
});

test('custom ground colour and brightness repaint live and can never make text illegible', () => {
	const [out] = run(`
		local tex = W.Tex(UIParent, "ARTWORK", "white", "bg")
		local sky = T.Band(UIParent)
		local before = { tex:GetVertexColor() }
		local skyBefore = { sky:GetVertexColor() }
		Polestar.Set("ui.bgColor", { 0.2, 0.05, 0.1 })
		local custom = { tex:GetVertexColor() }
		local skyCustom = { sky:GetVertexColor() }
		Polestar.Set("ui.brightness", 0.5)
		local lifted = T.Palette()
		Polestar.Set("ui.bgColor", { 1, 1, 1 })
		Polestar.Set("ui.brightness", 1)
		local white = T.Palette()
		Polestar.Set("ui.bgColor", nil)
		Polestar.Set("ui.brightness", -1)
		local low = T.Palette()
		Polestar.Set("ui.brightness", nil)
		emit({ before = before, custom = custom, skyBefore = skyBefore, skyCustom = skyCustom, lifted = lifted, white = white, low = low,
			back = { tex:GetVertexColor() }, legible = T.Legibility(white) })`);
	assert.notDeepEqual(out.custom, out.before);
	assert.ok(out.custom[0] > out.custom[2], 'the ground takes the custom hue');
	assert.notDeepEqual(out.skyCustom, out.skyBefore, 'the band follows the ground');
	assert.ok(lum(out.lifted.bg) > lum(out.custom), 'brightness lifts the ground');
	assertLegible('custom + lifted', out.lifted);
	assertLegible('white ground at full brightness', out.white);
	assertLegible('darkest', out.low);
	assert.ok(out.legible >= 1);
	assert.deepEqual(out.back.slice(0, 3), out.before.slice(0, 3), 'right-click reset (nil) returns to the scheme');
});

test('house style: the game\'s font by default and Inter on request, Polestar gold, a user accent that repaints what follows it', () => {
	const [out] = run(`
		local fs = UIParent:CreateFontString()
		T.Font(fs, "title")
		local before = { fs:GetFont() }
		local tex = W.Tex(UIParent, "ARTWORK", "white", "accent")
		local fired = 0
		T.OnChanged(function() fired = fired + 1 end)
		local d = { T.Accent() }
		Polestar.Set("ui.accent", { 1, 0.5, 0 })
		local tr, tg, tb = tex:GetVertexColor()
		Polestar.Set("ui.font", "inter")
		local inter = { fs:GetFont() }
		Polestar.Set("ui.bgOpacity", 0.5)
		local bgAlpha = select(4, PolestarGuideFrame.psSkin.bg:GetVertexColor())
		T.SetOutline(fs, true)
		local outlined = select(3, fs:GetFont())
		emit({ before = before, inter = inter, default = d, tex = { tr, tg, tb }, fired = fired, eui = T.IsEllesmere(),
			border = PolestarGuideFrame.psBorder ~= nil, shadow = PolestarGuideFrame.psShadow:IsShown(), bgAlpha = bgAlpha,
			outlined = outlined, media = T.Media("check"), verb = T.VerbIcon("kill"),
			band = { T.BandCoords(720, 112) }, schemes = T.SchemeChoices() })`);
	assert.deepEqual(out.before, ['Fonts\\FRIZQT__.TTF', 15, ''], 'the game\'s own font by default');
	assert.deepEqual(out.inter, ['Interface\\AddOns\\Polestar\\Media\\Fonts\\Inter-SemiBold.ttf', 15, ''], 'ui.font = inter re-fonts live');
	assert.deepEqual(round(out.default), [0.9, 0.73, 0.4], 'Polestar gold');
	assert.deepEqual(out.tex, [1, 0.5, 0]);
	assert.ok(out.fired >= 1);
	assert.equal(out.eui, false);
	assert.equal(out.border, true);
	assert.equal(out.shadow, true);
	assert.equal(out.bgAlpha, 0.5);
	assert.equal(out.outlined, 'OUTLINE');
	assert.equal(out.media, 'Interface\\AddOns\\Polestar\\Media\\UI\\check');
	assert.equal(out.verb, 'Interface\\AddOns\\Polestar\\Media\\UI\\icon-kill');
	assert.deepEqual(round(out.band), [0, 0.703, 0, 0.875], 'the band is cropped to the header, never stretched');
	assert.deepEqual(out.schemes.map((c) => c.value), ['dusk', 'night', 'graphite'], 'EllesmereUI is offered only when installed');
});

// The ruRU game font has no middle dot, so the skin's face becomes Fira Sans
// there; a face the player picked, and the other locales, are left alone.
test('fonts: ruRU swaps the skin\'s game font for Fira Sans; an explicit pick and other locales keep theirs', () => {
	const GAME = 'Fonts\\FRIZQT__.TTF';
	const FIRA = 'Interface\\AddOns\\Polestar\\Media\\Fonts\\FiraSans-SemiBold.ttf';
	const INTER = 'Interface\\AddOns\\Polestar\\Media\\Fonts\\Inter-SemiBold.ttf';
	const faces = (locale) => run(`
		local out = {}
		out.default = (T.FontSpec("title"))
		for _, skin in ipairs({ "hearth", "forever", "blizzard", "classic" }) do
			Polestar.Set("ui.skin", skin)
			out[skin] = (T.FontSpec("title"))
		end
		Polestar.Set("ui.skin", "polestar")
		Polestar.Set("ui.font", "skin")
		out.skinChoice = (T.FontSpec("title"))
		Polestar.Set("ui.font", "game")
		out.game = (T.FontSpec("title"))
		Polestar.Set("ui.skin", "blizzard")
		out.gameBlizzard = (T.FontSpec("title"))
		Polestar.Set("ui.skin", "polestar")
		Polestar.Set("ui.font", "inter")
		out.inter = (T.FontSpec("title"))
		emit(out)`, { before: `function GetLocale() return "${locale}" end` })[0];

	const ru = faces('ruRU');
	assert.equal(ru.default, FIRA, 'ruRU default');
	assert.equal(ru.skinChoice, FIRA, 'ruRU with the skin\'s own font');
	for (const skin of ['hearth', 'forever', 'blizzard', 'classic']) assert.equal(ru[skin], FIRA, `ruRU ${skin} by default`);
	assert.equal(ru.game, GAME, 'ruRU with "the game\'s" font picked');
	assert.equal(ru.gameBlizzard, GAME, 'ruRU with "the game\'s" font picked on a game skin');
	assert.equal(ru.inter, INTER, 'ruRU with Inter picked');

	for (const locale of ['zhCN', 'koKR']) {
		const cjk = faces(locale);
		assert.equal(cjk.default, GAME, `${locale} default`);
		assert.equal(cjk.inter, GAME, `${locale} with Inter picked`);
	}

	const en = faces('enUS');
	assert.equal(en.default, GAME, 'enUS default');
	assert.equal(en.game, GAME, 'enUS with the game font picked');
	assert.equal(en.inter, INTER, 'enUS with Inter picked');
});

test('settings from before schemes: a stored gold accent was the old default; any other stays the user\'s own', () => {
	const ui = (accent) => `PolestarDB = { schema = 1, settings = { ui = { accent = ${accent} } } }`;
	const [gold] = run(`emit({ accent = Polestar.Get("ui.accent"), live = { T.Accent() } })`, { before: ui('{ 0.9, 0.73, 0.4 }') });
	assert.equal(gold.accent, false);
	assert.deepEqual(round(gold.live), [0.9, 0.73, 0.4]);
	const [own] = run(`emit({ accent = Polestar.Get("ui.accent"), live = { T.Accent() } })`, { before: ui('{ 0.2, 0.6, 1 }') });
	assert.deepEqual(own.accent, [0.2, 0.6, 1]);
	assert.deepEqual(round(own.live), [0.2, 0.6, 1]);
});

test('EllesmereUI: an optional scheme and follow toggles, never a lock', () => {
	const [out] = run(`
		local fs = UIParent:CreateFontString()
		T.Font(fs, "body")
		local GF = Polestar.UI.GuideFrame
		uistub.setGuide(uistub.elwynn, 3)
		local function fill() local r, g, b = GF.parts.line.Fill:GetVertexColor() return { r, g, b } end
		local before = fill()
		local fired = 0
		T.OnChanged(function() fired = fired + 1 end)
		stub.setAccent(0.6, 0.48, 1)
		local after = fill()
		local followFont = { fs:GetFont() }
		local schemes = T.SchemeChoices()
		Polestar.Set("ui.scheme", "ellesmere")
		local euiGround = { T.Color("bg") }
		local euiPal = T.Palette()
		Polestar.UI.ShowOptions("appearance")
		local look = Polestar.UI.Options.Controls("appearance")
		local swatch = look["ui.accent"]
		local note = swatch.Note:GetText()
		swatch:Click("LeftButton")
		local opened = ColorPickerFrame.info ~= nil
		ColorPickerFrame.GetColorRGB = function() return 0.1, 0.8, 0.3 end
		ColorPickerFrame.info.swatchFunc()
		local picked = { accent = { T.Accent() }, match = Polestar.Get("ui.matchAccent"), fill = fill() }
		ColorPickerFrame.info.cancelFunc()
		local cancelled = { accent = Polestar.Get("ui.accent"), match = Polestar.Get("ui.matchAccent") }
		Polestar.Set("ui.accent", { 1, 0, 0 })
		local own = Polestar.Get("ui.matchAccent")
		Polestar.UI.ShowOptions("integrations")
		Polestar.UI.Options.Controls("integrations")["ui.matchAccent"]:Click()
		local rematched = { accent = Polestar.Get("ui.accent"), live = { T.Accent() } }
		Polestar.UI.ShowOptions("appearance")
		look = Polestar.UI.Options.Controls("appearance")
		local font = look["ui.font"]
		local fontLabel = font.Button.Label:GetText()
		font.Button:Click()
		local items = {}
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then items[#items + 1] = r.Text:GetText() end end
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Inter" then r:Click() end end
		local inter = { match = Polestar.Get("ui.matchFont"), font = { fs:GetFont() }, label = font.Button.Label:GetText() }
		Polestar.UI.ShowOptions("integrations")
		Polestar.UI.Options.Controls("integrations")["ui.matchFont"]:Click()
		emit({ registered = stub.skinRegistered, eui = T.IsEllesmere(), skinned = #stub.skinned,
			shellArt = PolestarGuideFrame.euiSkin or false, houseBg = PolestarGuideFrame.psSkin.bg:IsShown(),
			band = GF.parts.band:IsShown(), followFont = followFont, before = before, after = after, fired = fired,
			schemes = schemes, euiGround = euiGround, euiPal = euiPal, note = note, opened = opened, enabled = swatch:IsEnabled(),
			picked = picked, cancelled = cancelled, own = own, rematched = rematched, fontLabel = fontLabel, items = items, inter = inter,
			refollow = { fs:GetFont() } })`, { before: 'stub.withEllesmere()' });
	assert.equal(out.registered, 'Polestar');
	assert.equal(out.eui, true);
	assert.equal(out.skinned, 0, 'no EllesmereUI primitive replaces Polestar art');
	assert.equal(out.shellArt, false);
	assert.equal(out.houseBg, true);
	assert.equal(out.band, true);
	assert.deepEqual(out.followFont, ['Fonts\\FRIZQT__.TTF', 13, ''], 'the game\'s font by default, even with EllesmereUI');
	assert.deepEqual(round(out.before), [0.05, 0.82, 0.62], 'follows its accent by default');
	assert.deepEqual(round(out.after), [0.6, 0.48, 1], 'S.OnLooksChanged repaints accent-coloured elements');
	assert.ok(out.fired >= 1);
	assert.deepEqual(out.schemes.map((c) => c.value), ['dusk', 'night', 'graphite', 'ellesmere']);
	assert.ok(Math.abs(out.euiGround[0] - out.euiGround[2]) < 0.03, 'the EllesmereUI scheme takes its neutral panel colour');
	assert.equal(out.euiGround[3], 0.95, 'and its opacity');
	assertLegible('ellesmere', out.euiPal);
	assert.equal(out.note, 'EllesmereUI', 'the swatch says where the accent comes from');
	assert.equal(out.enabled, true, 'the accent is always editable');
	assert.equal(out.opened, true);
	assert.deepEqual(round(out.picked.accent), [0.1, 0.8, 0.3]);
	assert.equal(out.picked.match, false, 'picking your own accent turns following off');
	assert.deepEqual(round(out.picked.fill), [0.1, 0.8, 0.3]);
	assert.deepEqual(out.cancelled, { accent: false, match: true }, 'cancel restores both');
	assert.equal(out.own, false);
	assert.equal(out.rematched.accent, false, 'following again drops your own accent');
	assert.deepEqual(round(out.rematched.live), [0.6, 0.48, 1]);
	assert.equal(out.fontLabel, "The skin's font", "the skin picks the font by default: the game's in the house style");
	assert.deepEqual(out.items, ["The skin's font", 'Game font', 'Inter', 'Fira Sans', 'EllesmereUI']);
	assert.equal(out.inter.match, false, 'choosing another font turns following off');
	assert.deepEqual(out.inter.font, ['Interface\\AddOns\\Polestar\\Media\\Fonts\\Inter-Medium.ttf', 13, '']);
	assert.equal(out.inter.label, 'Inter');
	assert.deepEqual(out.refollow, ['Interface\\AddOns\\EllesmereUI\\media\\fonts\\Expressway.ttf', 13, '']);
});

test('EllesmereUI font: a refresh sets the text again a frame later, so a string drawn at login is not left blank', () => {
	const [out] = run(`
		local fs = UIParent:CreateFontString()
		T.Font(fs, "body")
		fs:SetText("Innkeeper Heather")
		local sets = 0
		local set = fs.SetText
		fs.SetText = function(self, ...) sets = sets + 1 return set(self, ...) end
		T.Refresh()
		stub.advance(0.1)
		local ownFont = sets
		Polestar.Set("ui.matchFont", true)
		stub.advance(0.1)
		sets = 0
		T.Refresh()
		local sameFrame = sets
		stub.advance(0.1)
		local later = sets - sameFrame
		sets = 0
		T.Refresh()
		T.Refresh()
		local syncTwo = sets
		stub.advance(0.1)
		emit({ ownFont = ownFont, sameFrame = sameFrame, later = later, twiceLater = sets - syncTwo, text = fs:GetText() })`, { before: 'stub.withEllesmere()' });
	assert.equal(out.ownFont, 2, 'without EllesmereUI\'s font the one re-set stands, nothing is queued');
	assert.equal(out.sameFrame, 2, 'the refresh sets the text again at once');
	assert.equal(out.later, 2, 'and once more a frame later');
	assert.equal(out.twiceLater, 2, 'refreshes in one frame share one later pass');
	assert.equal(out.text, 'Innkeeper Heather');
});

// The class colour as the accent: it follows the player's class, lifted until
// it reads as text (shaman blue is too dark on the night grounds as it is),
// and it is one source among three: your own colour, your class's,
// EllesmereUI's; choosing one turns the others off.
test('class colour accent: follows the class, lifted to read, and takes turns with your own accent and EllesmereUI\'s', () => {
	const [out] = run(`
		UnitClass = function() return "Shaman", "SHAMAN", 7 end
		local raw = RAID_CLASS_COLORS.SHAMAN
		Polestar.Set("ui.classAccent", true)
		local shaman = { T.Accent() }
		local pal = T.Palette()
		local panel = pal.panel
		local follows = { class = T.FollowsClassAccent(), eui = T.FollowsEllesmereAccent(), match = Polestar.Get("ui.matchAccent") }
		Polestar.Set("ui.accent", { 1, 0.5, 0 })
		local own = { class = Polestar.Get("ui.classAccent"), accent = { T.Accent() } }
		Polestar.Set("ui.classAccent", true)
		local back = { accent = Polestar.Get("ui.accent"), live = { T.Accent() } }
		emit({ raw = { raw.r, raw.g, raw.b }, shaman = shaman, panel = { panel[1], panel[2], panel[3] }, follows = follows, own = own, back = back })`,
		{ before: 'stub.withEllesmere()' });
	assert.ok(contrast(out.raw, out.panel) < 4.5, 'raw shaman blue does not read on the panel');
	assert.ok(contrast(out.shaman, out.panel) >= 4.5, `lifted to ${contrast(out.shaman, out.panel).toFixed(2)}:1`);
	assert.ok(out.shaman[2] > out.shaman[0], 'still blue');
	assert.deepEqual(out.follows, { class: true, eui: false, match: false }, 'turning it on stops following EllesmereUI');
	assert.deepEqual(out.own, { class: false, accent: [1, 0.5, 0] }, 'your own accent turns it off');
	assert.equal(out.back.accent, false, 'turning it on again drops your own accent');
	assert.deepEqual(round(out.back.live), round(out.shaman));
});

test('Anim: OnUpdate exists only while a tween runs; retargeting reuses the record', () => {
	const [out] = run(`
		local A = Polestar.Anim
		local f = CreateFrame("Frame")
		A.To(f, "alpha", 0, 1, 0.2, "out")
		local running = A.Active()
		stub.advance(0.1)
		local mid = f:GetAlpha()
		local rec = f.psTweens.alpha
		A.To(f, "alpha", f:GetAlpha(), 0.5, 0.2)
		local reused = f.psTweens.alpha == rec and A.Active() == 1
		local done = false
		A.To(f, "width", 10, 100, 0.2, "out", function() done = true end)
		stub.advance(0.5)
		Polestar.Set("ui.reduceMotion", true)
		A.To(f, "width", 0, 50, 0.2)
		local snapped = f:GetWidth()
		emit({ running = running, mid = mid, reused = reused, done = done, final = f:GetAlpha(), width = snapped, active = A.Active() })`);
	assert.equal(out.running, 1);
	assert.ok(out.mid > 0.5 && out.mid < 1, `ease-out is past halfway at half time (${out.mid})`);
	assert.equal(out.reused, true);
	assert.equal(out.done, true);
	assert.equal(out.final, 0.5);
	assert.equal(out.width, 50, 'reduced motion: movement lands at once');
	assert.equal(out.active, 0);
});

// Every texture the UI sets must exist on disk, or the client draws a green box.
test('every texture the UI shows, and every goal verb icon, exists as a valid TGA', () => {
	const verbs = ['accept', 'turnin', 'complete', 'kill', 'collect', 'goto', 'talk', 'interact', 'use', 'sethome', 'hearth', 'getfp', 'fly', 'train', 'buy', 'vendor', 'level', 'note', 'skill', 'learn', 'craft', 'rep', 'explore', 'achieve'];
	const [paths] = run(`
		local GF, UI = Polestar.UI.GuideFrame, Polestar.UI
		local seen = {}
		local function collect()
			for _, f in ipairs(stub.frames) do
				for _, r in ipairs(f.regions) do
					if type(r.texture) == "string" then seen[r.texture] = true end
				end
			end
		end
		collect()
		uistub.openTabs({ { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }, 1); collect()
		uistub.setStep(4); collect()
		uistub.setStep(8); collect()
		Polestar.Fire("GUIDE_OUTLEVELED", uistub.elwynn, "forever/alliance/02-westfall"); collect()
		GF.menuButton:Click(); collect()
		Polestar.Set("ui.compact", true); collect()
		Polestar.Set("ui.style", "transparent"); collect()
		uistub.complete(); collect()
		Polestar.Engine.SetGuide(nil); collect()
		UI.ShowPicker(); collect()
		for _, p in ipairs(UI.Options.Pages()) do
			UI.ShowOptions(p.key); collect()
			for _, t in ipairs(p.tabs) do UI.Options.Select(p.key, t); collect() end
		end
		for _, v in ipairs({ ${verbs.map((v) => `"${v}"`).join(', ')} }) do seen[T.VerbIcon(v)] = true end
		local out = {}
		for p in pairs(seen) do out[#out + 1] = p end
		table.sort(out)
		emit(out)`);
	const prefix = 'Interface\\AddOns\\Polestar\\Media\\UI\\';
	const ours = paths.filter((p) => p.startsWith(prefix)).map((p) => p.slice(prefix.length));
	assert.deepEqual(paths.filter((p) => !p.startsWith(prefix)), [], 'the UI only uses its own textures');
	for (const v of verbs) assert.ok(ours.includes(`icon-${v}`));
	for (const n of ['emblem', 'wordmark', 'band', 'watermark']) assert.ok(ours.includes(n), `${n} is used`);
	const missing = [];
	for (const n of ours) {
		const file = path.join(ADDONS, 'Polestar', 'Media', 'UI', `${n}.tga`);
		if (!fs.existsSync(file)) {
			missing.push(n);
			continue;
		}
		const b = fs.readFileSync(file);
		const w = b.readUInt16LE(12), h = b.readUInt16LE(14);
		assert.equal(b[2], 2, `${n}: uncompressed true-colour`);
		assert.ok((w & (w - 1)) === 0 && (h & (h - 1)) === 0, `${n} is ${w}x${h}`);
		let opaque = 0;
		for (let i = 18 + 3; i < b.length; i += 4) if (b[i] > 0) opaque++;
		assert.ok(opaque > 0, `${n} is empty`);
	}
	assert.deepEqual(missing, []);
	assert.ok(ours.length > 40, `the UI uses ${ours.length} textures`);
});

// Dark ink on the accent fill smears under a drop shadow; light text on the
// night ground keeps its shadow. Both must survive a scheme change (every
// string's font is repainted) and a button switching between the two looks.
test('a primary button label has no drop shadow, a secondary one keeps it, across scheme changes and toggles', () => {
	const [out] = run(`
		local parent = UIParent
		local primary = W.Button(parent, "Open in new tab", nil, { primary = true, icon = "plus" })
		local secondary = W.Button(parent, "Load guide")
		local function alpha(b) local _, _, _, a = b.Label:GetShadowColor() return a end
		local out = { primary = alpha(primary), secondary = alpha(secondary) }
		Polestar.Set("ui.scheme", "night")
		out.primaryAfterScheme, out.secondaryAfterScheme = alpha(primary), alpha(secondary)
		primary.psPrimary, secondary.psPrimary = false, true
		W.RepaintButton(primary); W.RepaintButton(secondary)
		out.demoted, out.promoted = alpha(primary), alpha(secondary)
		emit(out)`);
	assert.equal(out.primary, 0);
	assert.equal(out.primaryAfterScheme, 0);
	assert.equal(out.promoted, 0);
	for (const k of ['secondary', 'secondaryAfterScheme', 'demoted']) assert.ok(out[k] > 0.5, `${k}: ${out[k]}`);
});

test('W.Link: an address in the accent with no box; under the cursor the text colour, an accent underline and "Click to copy"; a click runs its action', () => {
	const [out] = run(`
		local parent = UIParent
		local clicked = 0
		local link = W.Link(parent, "discord.gg/example", function() clicked = clicked + 1 end, { role = "note" })
		local function rgb(r, g, b) return { r, g, b } end
		local out = { text = link.Label:GetText(), width = link:GetWidth() > 0, height = link:GetHeight(),
			atRest = rgb(link.Label:GetTextColor()), accent = rgb(T.Color("accent")), line = link.Line:IsShown(),
			skinned = link.psSkin ~= nil }
		stub.RunScript(link, "OnEnter")
		out.hover = { color = rgb(link.Label:GetTextColor()), textColor = rgb(T.Color("text")), line = link.Line:IsShown(),
			lineColor = rgb(link.Line:GetVertexColor()), tip = GameTooltip.owner == link and GameTooltip:IsShown() }
		stub.RunScript(link, "OnLeave")
		out.left = { color = rgb(link.Label:GetTextColor()), line = link.Line:IsShown() }
		link:Click()
		out.clicked = clicked
		W.SetLinkText(link, "a much longer address than before")
		out.grew = link:GetWidth() > 0 and link.Label:GetText()
		emit(out)`);
	assert.equal(out.text, 'discord.gg/example');
	assert.equal(out.width, true);
	assert.equal(out.height, 20);
	assert.deepEqual(out.atRest, out.accent, 'the accent at rest');
	assert.equal(out.line, false);
	assert.equal(out.skinned, false, 'no box');
	assert.deepEqual(out.hover.color, out.hover.textColor, 'the text colour under the cursor');
	assert.equal(out.hover.line, true);
	assert.deepEqual(out.hover.lineColor, out.accent, 'an accent underline');
	assert.equal(out.hover.tip, true);
	assert.deepEqual(out.left, { color: out.accent, line: false });
	assert.equal(out.clicked, 1);
	assert.equal(out.grew, 'a much longer address than before');
});

// The skins (Theme.lua, "Skins"): the handoff's tokens as given, their fonts,
// sizes and glyphs, and a window repainted from one skin to the next and back.
test('skins: Polestar by default; Halo and Hearth bring their tokens, fonts, sizes and glyphs; your own accent still wins', () => {
	const [out] = run(`
		local function c(name) return { T.Color(name) } end
		local out = { key = T.SkinKey(), choices = {} }
		for i, ch in ipairs(T.SkinChoices()) do out.choices[i] = ch.value end
		out.houseRow, out.houseHero = T.Metric("row", 40), select(2, T.FontSpec("hero"))
		Polestar.Set("ui.skin", "halo")
		out.halo = { key = T.SkinKey(), accent = c("accent"), text = c("text"), textDim = c("textDim"), npc = c("npc"), quest = c("quest"),
			veil = c("veil"), veilWindow = c("veilWindow"), menuBg = c("menuBg"), accentLine = c("accentLine"), manual = c("manual"),
			skipped = c("skipped"), success = c("success"), row = T.Metric("row", 40), font = { T.FontSpec("hero") }, icon = T.Icon("bug") }
		Polestar.Set("ui.accent", { 0.2, 0.6, 1 })
		out.ownAccent = c("accent")
		Polestar.Set("ui.accent", nil)
		Polestar.Set("ui.font", "inter")
		out.haloInter = (T.FontSpec("body"))
		Polestar.Set("ui.font", nil)
		Polestar.Set("ui.skin", "hearth")
		out.bliz = { key = T.SkinKey(), title = c("title"), text = c("text"), success = c("success"), arrive = c("arrive"),
			selected = c("selected"), row = T.Metric("row", 40), font = (T.FontSpec("body")), menuRow = T.Metric("menuRow", 26) }
		Polestar.Set("ui.skin", "nonsense")
		out.unknown = T.SkinKey()
		emit(out)`);
	const r = (cs) => round(cs);
	assert.equal(out.key, 'polestar');
	assert.deepEqual(out.choices, ['polestar', 'halo', 'hearth', 'forever', 'blizzard', 'classic']);
	assert.equal(out.houseRow, 40);
	assert.equal(out.houseHero, 26, 'the house ladder is unchanged');
	const h = out.halo;
	assert.equal(h.key, 'halo');
	assert.deepEqual(r(h.accent), [1, 0.82, 0, 1], '#FFD100');
	assert.deepEqual(r(h.text), [0.957, 0.937, 0.902, 1], '#F4EFE6');
	assert.deepEqual(r(h.textDim), [0.761, 0.725, 0.663, 1], '#C2B9A9');
	assert.deepEqual(r(h.npc), [0.549, 0.796, 1, 1], '#8CCBFF');
	assert.deepEqual(r(h.quest), [1, 0.878, 0.478, 1], '#FFE07A');
	assert.deepEqual(r(h.veil), [0.031, 0.024, 0.016, 0.6], '#080604 at 60 %');
	assert.equal(r(h.veilWindow)[3], 0.84);
	assert.equal(r(h.menuBg)[3], 0.97);
	assert.deepEqual(r(h.accentLine), [1, 0.82, 0, 0.35]);
	assert.deepEqual(r(h.manual), [0.706, 0.612, 1, 1], '#B49CFF');
	assert.deepEqual(r(h.skipped), [0.361, 0.784, 0.839, 1], '#5CC8D6');
	assert.deepEqual(r(h.success), [0.373, 0.816, 0.408, 1], '#5FD068');
	assert.equal(h.row, 34);
	assert.deepEqual(h.font, ['Interface\\AddOns\\Polestar\\Media\\Fonts\\FiraSans-SemiBold.ttf', 24, ''], 'Fira Sans, Hero 24');
	assert.equal(h.icon, 'flag', 'the report flag');
	assert.deepEqual(round(out.ownAccent).slice(0, 3), [0.2, 0.6, 1], 'your own accent wins in a skin');
	assert.equal(out.haloInter, 'Interface\\AddOns\\Polestar\\Media\\Fonts\\Inter-Medium.ttf', 'a font picked by hand wins');
	const b = out.bliz;
	assert.equal(b.key, 'hearth');
	assert.deepEqual(r(b.title), [1, 0.82, 0, 1], 'NORMAL_FONT_COLOR');
	assert.deepEqual(r(b.text), [1, 1, 1, 1], 'HIGHLIGHT_FONT_COLOR');
	assert.deepEqual(r(b.success), [0.118, 1, 0, 1], '#1EFF00');
	assert.deepEqual(r(b.arrive), [0.345, 0.753, 0.29, 1], '#58C04A');
	assert.deepEqual(r(b.selected), [0.431, 0.588, 1, 0.28], "the options list's blue selection");
	assert.equal(b.row, 28);
	assert.equal(b.menuRow, 22);
	assert.equal(b.font, 'Fonts\\FRIZQT__.TTF', "the game's font");
	assert.equal(out.unknown, 'polestar', 'an unknown skin is the house style');
});

test('skins: a window repaints from the house style to Halo (veil, no fill) to Hearth (gradient) and back, live', () => {
	const [out] = run(`
		-- A window of Polestar's own (frames a test makes stand for the game's).
		Polestar.UI.ShowOptions()
		local f = PolestarOptions
		local function state()
			local d = f.psSkin
			return { bg = d.bg ~= nil and d.bg:IsShown(), veil = d.veil ~= nil and d.veil:IsShown(),
				border = f.psBorder ~= nil and f.psBorder[1]:IsShown(), shadow = f.psShadow ~= nil and f.psShadow:IsShown() }
		end
		local out = { house = state() }
		Polestar.Set("ui.skin", "halo")
		out.halo = state()
		local v = f.psSkin.veil
		local _, _, _, a = v.parts[5]:GetVertexColor()
		out.veilAlpha = a
		Polestar.Set("ui.skin", "hearth")
		out.bliz = state()
		Polestar.Set("ui.skin", "polestar")
		out.back = state()
		emit(out)`);
	assert.deepEqual(out.house, { bg: true, veil: false, border: true, shadow: true });
	assert.deepEqual(out.halo, { bg: false, veil: true, border: false, shadow: false }, 'Halo: the soft veil alone');
	assert.equal(Math.round(out.veilAlpha * 100) / 100, 0.84, 'the big windows\' veil');
	assert.deepEqual({ bg: out.bliz.bg, veil: out.bliz.veil }, { bg: true, veil: false });
	assert.deepEqual(out.back, out.house, 'back to the house style, as it was');
});

// #353: Polestar's faces have no Chinese or Hangul; text with them takes the
// client's font for that script, unless the client's locale already draws it.
test("fonts: a Chinese or Korean name takes the client's font for its script, and back when the text changes (#353)", () => {
	const [out] = run(`
		local GF = Polestar.UI.GuideFrame
		local fs = W.Text(GF.parts.nav, "hero", "text")
		local function face() return (fs:GetFont()) end
		local out = { latin = face() }
		fs:SetText("Hello, 张伟"); out.han = face()
		fs:SetText("Hello, 김민준"); out.hangul = face()
		fs:SetFormattedText("%s, %s", "Hello", "Tom — Привет"); out.back = face()
		Polestar.Set("ui.skin", "halo"); fs:SetText("Hello, 张伟"); Polestar.Set("ui.skin", "polestar"); out.repaint = face()
		GetLocale = function() return "zhCN" end
		fs:SetText("A"); fs:SetText("Hello, 张伟"); out.zhCN = face()
		fs:SetText("Hello, 김민준"); out.zhCNHangul = face()
		GetLocale = function() return "enUS" end
		uistub.player.name = "张伟"
		Polestar.UI.Welcome.Show("welcome")
		for _, f in ipairs(stub.frames) do
			for _, r in ipairs(f.regions) do
				if r.text == "Hello, 张伟" or (r.GetText and r:GetText() == "Hello, 张伟" and r ~= fs) then out.welcome = (r:GetFont()) end
			end
		end
		emit(out)`);
	assert.doesNotMatch(out.latin, /ARKai|2002/);
	assert.equal(out.han, 'Fonts\\ARKai_T.ttf');
	assert.equal(out.hangul, 'Fonts\\2002.TTF');
	assert.equal(out.back, out.latin, 'Latin and Cyrillic go back to the face');
	assert.equal(out.repaint, 'Fonts\\ARKai_T.ttf', 'a skin change keeps it');
	assert.doesNotMatch(out.zhCN, /ARKai_T/, 'a Chinese client draws it in its own font');
	assert.equal(out.zhCNHangul, 'Fonts\\2002.TTF');
	assert.equal(out.welcome, 'Fonts\\ARKai_T.ttf', "the welcome page's greeting");
});

// The game's looks (Theme/GameSkins.lua): each draws its own art source, and
// a window taken through all three comes back to the house style as it was.
test("skins: WoW Forever draws the client's atlas, Blizzard the retail sheet, Classic the vanilla dialog; a window goes through them and back", () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		local f = PolestarOptions
		local function state()
			local d = f.psSkin
			return { bg = d.bg ~= nil and d.bg:IsShown(), veil = d.veil ~= nil and d.veil:IsShown(),
				border = f.psBorder ~= nil and f.psBorder[1]:IsShown(), shadow = f.psShadow ~= nil and f.psShadow:IsShown(),
				metal = d.kit ~= nil and d.kit.metalArt ~= nil and d.kit.metal:IsShown() and d.kit.metalArt[1]:IsShown() or false,
				dialog = d.kit ~= nil and d.kit.dialog ~= nil and d.kit.dialog:IsShown() or false }
		end
		local out = { house = state() }
		Polestar.Set("ui.skin", "forever")
		out.forever = state()
		out.foreverCorner = f.psSkin.kit.metalArt[1].texture
		out.title = f.psSkin.kit.title:GetText()
		out.game = T.GameSkin()
		-- The frame's own close button and drag strip; the shell's close steps aside.
		out.close = { frame = f.psSkin.kit.closeButton:IsShown(), shell = f.Close:IsShown() }
		out.drag = f.psSkin.kit.drag:IsShown()
		Polestar.Set("ui.skin", "blizzard")
		out.blizzard = state()
		out.blizzardCorner = f.psSkin.kit.metalArt[1].texture
		Polestar.Set("ui.skin", "classic")
		out.classic = state()
		out.classicEdge = f.psSkin.kit.dialog.backdrop and f.psSkin.kit.dialog.backdrop.edgeFile
		Polestar.Set("ui.skin", "polestar")
		out.back = state()
		out.houseGame = T.GameSkin()
		emit(out)`, {
		before: `C_Texture = { GetAtlasInfo = function(name)
			return { file = "atlas:" .. name, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0, bottomTexCoord = 1, width = 95, height = 95 }
		end }`,
	});
	assert.equal(out.foreverCorner, 'atlas:UI-Frame-Metal-CornerTopLeft', "Forever: the client's own art for the atlas");
	assert.equal(out.title, 'Polestar', 'the title on the metal bar');
	assert.equal(out.game, true);
	assert.deepEqual(out.close, { frame: true, shell: false }, 'the close button sits on the frame corner');
	assert.equal(out.drag, true, 'the title bar drags the window');
	assert.equal(out.blizzardCorner, 2406979, 'Blizzard: the retail sheet by file ID (Theme/GameArt.lua)');
	assert.equal(out.forever.metal, true);
	assert.equal(out.blizzard.metal, true);
	assert.deepEqual({ metal: out.classic.metal, dialog: out.classic.dialog }, { metal: false, dialog: true }, 'Classic: the dialog box, no metal');
	assert.equal(out.classicEdge, 'Interface\\DialogFrame\\UI-DialogBox-Border');
	assert.deepEqual(out.back, out.house, 'back to the house style, as it was');
	assert.equal(out.houseGame, false);
});

// #312: Forever's tab art is an outline. On the guide window's strip its top
// and left run along the window's edge, which left the active tab's right
// side as a lone line; there the active tab is the Settings list's selected
// row, the resting tabs keep their art, and the Options tabs keep theirs.
test('skins: on Forever the guide strip marks the active tab with the selected-row art, not a half-drawn outline (#312)', () => {
	const [out] = run(`
		local GF = Polestar.UI.GuideFrame
		Polestar.Set("ui.skin", "forever")
		uistub.openTabs({ { uistub.elwynn, 3 }, { uistub.tailoring, 2 } }, 1)
		local function art(b)
			local k = b.psSkin and b.psSkin.kit or {}
			local lit, three = k.tabLit, k.tabArt
			return { lit = lit ~= nil and lit:IsShown() and lit.atlas or lit and lit:IsShown() and lit.texture or false,
				outline = three ~= nil and three[2]:IsShown() and three[2].texture or false }
		end
		local out = { active = art(GF.tabs[1]), rest = art(GF.tabs[2]) }
		uistub.openTabs({ { uistub.elwynn, 3 }, { uistub.tailoring, 2 } }, 2)
		out.moved = { first = art(GF.tabs[1]), second = art(GF.tabs[2]) }
		-- the Options tabs are not on the window's edge: the tab outline as the client draws it
		Polestar.UI.ShowOptions("guide")
		out.options = {}
		for _, t in ipairs(PolestarOptions.tabButtons) do
			if t:IsShown() then out.options[#out.options + 1] = art(t) end
		end
		emit(out)`, {
		before: `C_Texture = { GetAtlasInfo = function(name)
			return { file = "atlas:" .. name, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0, bottomTexCoord = 1, width = 7, height = 26 }
		end }`,
	});
	assert.deepEqual(out.active, { lit: 'atlas:Options_List_Active', outline: false });
	assert.deepEqual(out.rest, { lit: false, outline: 'atlas:Options_Tab_Middle' });
	assert.deepEqual(out.moved, { first: { lit: false, outline: 'atlas:Options_Tab_Middle' }, second: { lit: 'atlas:Options_List_Active', outline: false } });
	assert.ok(out.options.length > 1);
	assert.ok(out.options.every((t) => t.lit === false && t.outline), 'outline tabs');
	assert.ok(out.options.some((t) => t.outline === 'atlas:Options_Tab_Active_Middle'), 'the active one in the active outline');
});
// #306: three Forever-skin guide-window bugs confirmed in game by Fitz (rc1).
// (a) Inner border / tab-strip strip: sliced(UI-HUD-ActionBar-Frame) margins
//     {16,20,16,20} with out={3,3,3,3} bleed 13-17 px inside the window.
//     Body raised to BORDER 1 covers the bleed; the bronze line (3 px above
//     f.top, outside the body) is unaffected.
// (b) Progress bar no fill: Legacy-Progressbar-Frame margins {33,11,33,13}
//     placed with old offsets (+6/-7) left only ~1 px of ARTWORK-free centre;
//     new offsets (+11/-13) match the margins so the full bar height is centre.
// (c) Hover plates covering button content: plateLit, cardLit, navHover were
//     HIGHLIGHT BLEND (opaque); changed to ADD so hover brightens without hiding.
test('skins: Forever guide window body is above the slim, status-art surrounds the bar, hover plates use ADD (#306)', () => {
	const [out] = run(`
		local GF = Polestar.UI.GuideFrame
		Polestar.Set("ui.skin", "forever")
		uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
		GF.PaintProgress(true)

		-- (a) body draw layer above slim
		local f = PolestarGuideFrame
		local bg = f.psSkin and f.psSkin.bg
		local bgLayer = bg and bg.layer or false
		local bgSub   = bg and bg.sublayer or false

		-- (b) status-art host frame offsets
		local foot = GF.parts.foot
		local b = rawget(foot, "Status")
		local o = b and b.psSkin and b.psSkin.kit and b.psSkin.kit.statusFrame
		local oTop = o and select(5, o:GetPoint(1)) or false   -- y offset of TOPLEFT
		local oBot = o and select(5, o:GetPoint(2)) or false   -- y offset of BOTTOMRIGHT

		-- (c) hover blend mode
		local cardBtn = CreateFrame("Button")
		T.SKIN_PAINT.forever.button(cardBtn)
		local cl = cardBtn.psSkin and cardBtn.psSkin.kit and cardBtn.psSkin.kit.cardLit
		local navRow = CreateFrame("Button")
		T.KitRowLit(navRow, true, "navLit", 0)
		local hv = navRow.psSkin and navRow.psSkin.kit and navRow.psSkin.kit.navLitHover
		local pl = GF.parts.nav.Prev.psSkin and GF.parts.nav.Prev.psSkin.kit and GF.parts.nav.Prev.psSkin.kit.plateLit

		emit({ bgLayer = bgLayer, bgSub = bgSub,
			oTop = oTop, oBot = oBot,
			cardBlend = cl and cl[2] and cl[2].blend or false,
			navBlend  = hv and hv.blend or false,
			platBlend = pl and pl.blend or false })`, {
		before: `C_Texture = { GetAtlasInfo = function(name)
			return { file = "atlas:" .. name, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0, bottomTexCoord = 1, width = 110, height = 110 }
		end }`,
	});
	// (a)
	assert.equal(out.bgLayer, 'BORDER', 'body is in BORDER layer');
	assert.equal(out.bgSub,   1,        'body sub-level 1 > slim sub-level 0');
	// (b) Legacy-Progressbar-Frame margins top=11, bottom=13
	assert.equal(out.oTop,  11, 'statusArt top margin outside bar');
	assert.equal(out.oBot, -13, 'statusArt bottom margin outside bar');
	// (c)
	assert.equal(out.cardBlend, 'ADD', 'cardLit ADD');
	assert.equal(out.navBlend,  'ADD', 'navHover ADD');
	assert.equal(out.platBlend, 'ADD', 'plateLit ADD');
});
