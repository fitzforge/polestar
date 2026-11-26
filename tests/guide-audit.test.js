'use strict';
// The default guide window's audit fixes, in
// addon/Polestar/UI/GuideFrame*.lua. Against the real Core, Theme and UI and
// the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\nlocal GF = Polestar.UI.GuideFrame\n${script}`,
	}).emitted;
}

test('opening a "Then:" line brings it and its goals into sight', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 4)
		Polestar.Set("ui.wholeStep", false)
		Polestar.Set("ui.maxHeight", 0.01)
		GF.Render() GF.Layout()
		local goals = GF.parts.goals
		local line
		for _, o in ipairs(GF.CardItems()) do
			if o.psKey and o.psKey ~= "done" and o:IsShown() and o.psTitle == "Brother Neals" then line = o end
		end
		line:GetScript("OnClick")(line)
		stub.advance(1)
		local top, view = goals:GetVerticalScroll(), goals.psViewH
		local items, last = GF.CardItems(), nil
		for i, o in ipairs(items) do if o == line then last = items[i + 1] end end
		local y = GF.ItemTop(line)
		emit({ over = goals.psOver, top = top, view = view, y = y, rowY = last and GF.ItemTop(last), rowGoal = last and last.psGoal ~= nil })`);
	assert.equal(out.over, true, 'the goals area scrolls');
	assert.equal(out.rowGoal, true, 'the opened line has its goal under it');
	assert.ok(out.y >= out.top - 0.5, `the line is in sight: ${out.y} from ${out.top}`);
	assert.ok(out.rowY < out.top + out.view, `its goal is in sight: ${out.rowY} in ${out.top}+${out.view}`);
});

test("a banner's second action that would be cut takes its own line, and the banner grows for it", () => {
	const [narrow, wide] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local banner = GF.parts.banner
		local function lay(width)
			local h = GF.LayoutBanner(width, true, "lost", { title = "Kobold Camp Cleanup" })
			local later, jump = banner.Later, banner.Jump
			local _, _, _, x, y = later:GetPoint(1)
			local _, _, _, _, jy = jump:GetPoint(1)
			return { h = h, x = x, y = y, jy = jy, cut = later.Label:GetWidth() > 0
				and later.Label:GetWidth() < later.Label:GetUnboundedStringWidth() }
		end
		emit(lay(260))
		emit(lay(560))`);
	assert.equal(wide.x > 0, true, 'at 560 the second action sits beside the first');
	assert.equal(wide.y, wide.jy);
	assert.equal(narrow.x, 0, 'at 260 it starts its own line');
	assert.ok(narrow.y < narrow.jy, `under the first: ${narrow.y} below ${narrow.jy}`);
	assert.equal(narrow.cut, false, 'its label is whole');
	assert.equal(narrow.h - wide.h >= 22, true, `the banner grows by its line: ${narrow.h} vs ${wide.h}`);
});

// Two links never overlap, in either link mode, however long the first's label and however narrow the window
// (the Free mode banner's "Return to <guide>" + "Most XP a minute first", the gear offer's "Wear it" + "Not this one").
test("a banner's two links never overlap: right or under mode, long names, narrow widths", () => {
	const rows = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local banner = GF.parts.banner
		local function rect(link)
			local point, rel, relPoint, x, y = link:GetPoint(1)
			local w = link:GetWidth()
			if rel == banner.Text then
				local left = x
				if point == "TOPRIGHT" then left = banner.Text:GetWidth() + x - w end
				return { l = left, r = left + w, t = y, b = y - 18 }
			end
			return { l = -1e9, r = -1e9, t = 1e9, b = 1e9 } -- beside the text, by the x: no row under it
		end
		local cases = {
			{ "free", { xp = true, back = "Western Elwynn, Westfall and the Road to Darkshire" } },
			{ "free", { xp = true, back = "Kobold Camp" } },
			{ "wear", { link = "[Sword of the Crown]", pct = 12, slot = "MainHandSlot" } },
		}
		for _, mode in ipairs({ "right", "under" }) do
			Polestar.Set("guideWindow.bannerLinks", mode)
			for _, width in ipairs({ 220, 260, 400, 560 }) do
				for i, c in ipairs(cases) do
					banner.Later:Hide()
					GF.LayoutBanner(width, true, c[1], c[2])
					local a, b = rect(banner.Jump), rect(banner.Later)
					emit({ mode = mode, width = width, case = i, later = banner.Later:IsShown(),
						hit = a.l < b.r and b.l < a.r and a.b < b.t and b.b < a.t })
				end
			end
		end`);
	assert.ok(rows.length >= 24 && rows.every((r) => r.later), 'every case shows the second link');
	const hit = rows.filter((r) => r.hit);
	assert.deepEqual(hit, [], `links overlap: ${JSON.stringify(hit)}`);
});

test('the divider lines show in the opaque window only', () => {
	const [opaque, clear] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local p = GF.parts
		local function rules(style)
			Polestar.Set("ui.style", style)
			GF.ApplyStyle()
			return { nav = p.nav.Rule:IsShown(), xp = GF.xp.Rule:IsShown(), banner = p.banner.Rule:IsShown() }
		end
		emit(rules("standard"))
		emit(rules("transparent"))`);
	assert.deepEqual(opaque, { nav: true, xp: true, banner: true });
	assert.deepEqual(clear, { nav: false, xp: false, banner: false });
});

test('the foot line names a later step as "Next step:", this step\'s next person as "Then:"', () => {
	const [later, here] = run(`
		local function after(step, whole)
			uistub.setGuide(uistub.elwynn, step)
			Polestar.Set("ui.wholeStep", whole)
			GF.Render() GF.Layout()
			return GF.parts.after.Text:GetText()
		end
		emit(after(3, false))
		emit(after(4, true))`);
	assert.match(later, /^Next step: .*Marshal McBride/);
	assert.match(here, /^Then: .*Eagan Peltskinner/);
});

test("a finished guide's window offers the next guide as the guide-end window names it", () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		script: `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
local steps = { { goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } } }
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", minLevel = 1, maxLevel = 10, next = "test/b", steps = steps })
Polestar.RegisterGuide({ id = "test/b", pack = "test", title = "Westfall", minLevel = 10, maxLevel = 17, steps = steps })
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local E, GF = Polestar.Engine, Polestar.UI.GuideFrame
E.SetGuide("test/a")
E.Skip()
GF.Render(); GF.Layout(); stub.advance(1)
local empty = GF.parts.empty
local pn = Polestar.UI.GuideFrame.PlayNext
local card, other = pn.card(), pn.other()
local snap = { shown = empty:IsShown(), text = empty.Text:GetText(), go = empty.Primary:IsShown() and empty.Primary.Label:GetText(),
	card = card:IsShown(), title = card.Title:GetText(), why = card.Why:GetText(), steps = card.Steps:GetText(),
	start = card.Start.Label:GetText(), default = card.Start.psDefault, other = other:IsShown(), otherText = other.Label:GetText(),
	height = card:GetHeight(), secondary = empty.Secondary:IsShown() }
card.Start.psAction()
snap.now = E.GetGuide().id
emit(snap)`,
	}).emitted;
	assert.equal(out.shown, true, 'the complete page');
	assert.match(out.text, /^\|c[0-9a-f]{8}A \(1–10\)\|r is done\.$/);
	assert.equal(out.go, false, 'no Continue button: the card has the Start');
	assert.equal(out.secondary, false, 'no Browse guides button');
	assert.equal(out.card, true, 'the Play next card');
	assert.match(out.title, /^Westfall \|c[0-9a-f]{8}\(10–17\)\|r$/);
	assert.match(out.why, /^Next in your route · your level \d+$/);
	assert.equal(out.start, 'Start');
	assert.equal(out.default, true, 'a gamepad starts on Start');
	assert.equal(out.other, true, 'the quiet Other guides link');
	assert.equal(out.otherText, 'Other guides');
	assert.equal(out.now, 'test/b', 'Start goes on to the next guide');
});

test('banners tint by their kind and resting glyphs are dim; the accent stays the live goal\'s', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local T, banner = Polestar.Theme, GF.parts.banner
		local function same(tex, role)
			local r, g, b = tex:GetVertexColor()
			local R, G, B = T.Color(role)
			return math.abs(r - R) < 0.01 and math.abs(g - G) < 0.01 and math.abs(b - B) < 0.01
		end
		local out = {}
		GF.LayoutBanner(400, true, "bags", { free = 0, need = 2 })
		out.bagsIcon, out.bagsFill = same(banner.Icon, "warning"), same(banner.Fill, "warning")
		GF.LayoutBanner(400, true, "lost", { title = "Kobold Camp Cleanup" })
		out.lostIcon, out.lostFill = same(banner.Icon, "textDim"), same(banner.Fill, "textDim")
		out.lostLink = same(banner.Jump.Arrow, "accent")
		for _, r in ipairs(GF.rows) do
			if r:IsShown() and r.psGoal and r.psGoal.status ~= "done" then
				out[#out + 1] = { live = r.psRowInfo.current, accent = same(r.Icon, "accent"), dim = same(r.Icon, "textDim") }
			end
		end
		emit(out)`);
	assert.deepEqual([out.bagsIcon, out.bagsFill], [true, true], 'the bags banner in the warning colour');
	assert.deepEqual([out.lostIcon, out.lostFill], [true, true], 'another kind neutral');
	assert.equal(out.lostLink, true, 'its main action keeps the accent');
	const rows = Object.keys(out).filter((k) => /^\d+$/.test(k)).map((k) => out[k]);
	assert.ok(rows.length >= 2, 'open goals on the card');
	for (const r of rows) assert.deepEqual([r.accent, r.dim], r.live ? [true, false] : [false, true]);
});
