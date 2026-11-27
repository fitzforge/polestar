'use strict';
// The new settings page's sidebar (addon/Polestar_Options/UI/Grouped.lua,
// W.ShellNav and its parts in addon/Polestar/Theme/Widgets.lua): its groups
// fold accordion-style, one open at a time, or all open while Expand all is
// on (PolestarDB.optionsNavAll); it folds to an icon rail
// (PolestarDB.optionsRail) whose group icons open their pages as a fly-out;
// the settings pinned at its foot carry live controls acting on the home
// setting, and follow its row's disabled state; the profile card names the
// profile in use with a Switch action. Against the real addon's modules and
// the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

function run(script, saved) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: saved || 'PolestarDB = { settings = {}, optionsSeen = { ["*"] = true }, optionsLayout = "grouped" }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local G = O.Grouped
			local W = Polestar.Widgets
			local function open()
				local out = {}
				for _, it in ipairs(G.NavItems()) do if it.open then out[#out + 1] = it.key end end
				return out
			end
			local function navRow(key)
				for _, b in ipairs(O.frame.navButtons) do if b:IsShown() and b.psKey == key then return b end end
			end
			local function pinKeys()
				local out = {}
				for _, it in ipairs(G.NavItems()) do if it.pin then out[#out + 1] = it.pin end end
				return out
			end
			${script}`,
	}).emitted;
}

test('groups fold accordion-style, one open at a time; Expand all is remembered', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("guidewindow")
		local first = open()
		G.SetNavAll(true)
		local allOpen = open()
		local pages = 0
		for _, it in ipairs(G.NavItems()) do if it.indent then pages = pages + 1 end end
		local head = G._navHead()
		emit({ open = first, allOpen = allOpen, saved = PolestarDB.optionsNavAll == true, pages = pages,
			head = head ~= nil and head.Expand:IsShown() and head.Expand:GetParent() == O.frame.Sidebar })`);
	assert.deepEqual(out.open, ['b:look'], 'one group open: the page shown');
	assert.deepEqual(out.allOpen, ['b:guiding', 'b:qol', 'b:look', 'b:setup', 'b:addons'], 'Expand all opens every group');
	assert.equal(out.saved, true, 'and is remembered for the account');
	assert.ok(out.pages > 15, `every group lists its pages (${out.pages})`);
	assert.equal(out.head, true, 'the toggle sits in the sidebar head');
});

test('the head\'s Expand all and fold stand in a toolbar row above the hairline; on the rail the fold sits centred in it', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("guide")
		local f, head = O.frame, G._navHead()
		local function pt(b) local p, rel, rp, x, y = b:GetPoint(1); return { p = p, rel = rel == f.Sidebar and "side" or "other", rp = rp, x = x, y = y } end
		local _, _, _, tx, ty = f.Tagline:GetPoint(1)
		local wide = { rail = pt(head.Rail), expand = pt(head.Expand), tagTop = -ty, tagH = f.Tagline:GetStringHeight(),
			sideW = f.Sidebar:GetWidth(), w = head.Rail:GetWidth(), ew = head.Expand:GetWidth(), label = head.Expand.Label:GetText(),
			framed = head.Rail.psFramed }
		G.SetNavAll(true)
		local all = head.Expand.Label:GetText()
		G.SetNavAll(false)
		G.SetRail(true)
		local rail = { rail = pt(head.Rail), expand = head.Expand:IsShown() }
		G.SetRail(false)
		emit({ wide = wide, rail = rail, band = W.SHELL.header + W.SHELL.tabs, all = all })`);
	const { wide, rail, band } = out;
	assert.equal(band, 152, 'the hairline');
	assert.deepEqual([wide.rail.p, wide.rail.rel, wide.rail.rp, wide.rail.x], ['CENTER', 'side', 'TOPRIGHT', -31], 'the fold plate on the sidebar\'s right');
	assert.equal(wide.rail.y, -136, 'in the row above the hairline');
	assert.ok(-wide.rail.y + wide.w / 2 < band, 'clear of the hairline');
	assert.equal(wide.framed, 'icon', 'a visible plate');
	assert.deepEqual([wide.expand.p, wide.expand.rel, wide.expand.rp, wide.expand.x, wide.expand.y], ['LEFT', 'side', 'TOPLEFT', 16, -136], 'Expand all on the 24 edge, same line');
	assert.equal(wide.label, 'Expand all');
	assert.equal(out.all, 'Collapse all', 'it flips');
	assert.ok(-wide.rail.y - wide.w / 2 > wide.tagTop + Math.ceil(wide.tagH), 'the tagline\'s line is clear');
	assert.deepEqual([rail.rail.p, rail.rail.rel, rail.rail.rp, rail.rail.x, rail.rail.y], ['CENTER', 'side', 'TOP', 0, -136], 'on the rail: centred in the row');
	assert.equal(rail.expand, false, 'Expand all away');
});

test('open group\'s sub-pages are a tree: no icon, a guide line, an accent bar on the active one; the rail has 20px icons and a square emblem', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("guidewindow")
		local rows = {}
		-- The tree's guide line and accent segment are made for the first sub-page row.
		local function on(b, k) local r = rawget(b, k) return r ~= nil and r:IsShown() end
		for _, b in ipairs(O.frame.navButtons) do
			if b:IsShown() and b.psItem then
				rows[#rows + 1] = { key = b.psKey, indent = b.psItem.indent or false, icon = b.Icon:IsShown(), guide = on(b, "Guide"),
					tick = on(b, "Tick"), h = b:GetHeight(), foot = b.psItem.indent == nil and b.psKey ~= nil and b.psItem.rowH == nil }
			end
		end
		local E = O.frame.Emblem
		local wideGlow = E.Glow:GetWidth()
		G.SetRail(true)
		local rail = {}
		for _, b in ipairs(O.frame.navButtons) do
			if b:IsShown() and b.psItem then rail[#rail + 1] = { w = b.Icon:GetWidth(), h = b:GetHeight(), icon = b.Icon:IsShown(), tick = on(b, "Tick") } end
		end
		local em = { w = E:GetWidth(), h = E:GetHeight(), gw = E.Glow:GetWidth(), gh = E.Glow:GetHeight(), side = O.frame.Sidebar:GetWidth() }
		G.SetRail(false)
		emit({ rows = rows, rail = rail, em = em, wideGlow = wideGlow, active = O.frame.psActiveKey })`);
	const subs = out.rows.filter((r) => r.indent);
	assert.ok(subs.length >= 3, 'sub-pages listed');
	for (const r of subs) {
		assert.equal(r.icon, false, `${r.key}: no icon`);
		assert.equal(r.guide, true, `${r.key}: the guide line`);
		assert.equal(r.h, 36, `${r.key}: shorter than a group row`);
	}
	assert.equal(subs.filter((r) => r.tick).length, 1, 'the accent bar on the active sub-page alone');
	for (const r of out.rows.filter((x) => !x.indent)) {
		assert.equal(r.guide, false, `${r.key}: no line`);
		assert.equal(r.tick, false);
	}
	const groups = out.rows.filter((r) => /^b:/.test(r.key));
	assert.ok(groups.every((r) => r.icon && r.h === 44), 'group rows keep their icon, 44 tall');
	const foot = out.rows.filter((r) => r.key === 'about');
	assert.ok(foot.length === 1 && foot[0].icon, 'foot rows keep their icons');
	assert.ok(out.rail.length > 0 && out.rail.every((r) => r.w === 20 && r.h === 48 && r.icon && !r.tick), 'rail: 20px icons on 48px rows');
	assert.equal(out.em.w, out.em.h, 'the emblem is square');
	assert.equal(out.em.gw, out.em.gh, 'its glow is square');
	assert.ok(out.em.gw <= out.em.side, 'and fits the rail');
	assert.equal(out.wideGlow, 88, 'the full sidebar keeps the 88 glow');
});

test('the sidebar folds to an icon rail and a hovered icon opens its pages as a fly-out', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("guide")
		local wide = O.frame.Sidebar:GetWidth()
		local mainW = O.frame.psMainW
		G.SetRail(true)
		local saved = PolestarDB.optionsRail == true
		local row = navRow("b:guiding")
		stub.RunScript(row, "OnEnter")
		local fly = G._flyout()
		local labels = {}
		for _, b in ipairs(fly and fly.rows or {}) do
			if b:IsShown() and not b.psHeading then labels[#labels + 1] = b.Label:GetText() end
		end
		-- A page picked in the fly-out is shown, the fly-out gone.
		local pick
		for _, b in ipairs(fly.rows) do if b:IsShown() and b.psKey == "map" then pick = b end end
		stub.RunScript(pick, "OnClick")
		local p = G.Current()
		local items = {}
		for _, it in ipairs(G.NavItems()) do items[#items + 1] = it.key or "-" end
		local railW, railMain = O.frame.Sidebar:GetWidth(), O.frame.psMainW
		local label = row.Label:IsShown()
		G.SetRail(false)
		emit({ rail = saved, flyout = labels, shown = p.key, flyGone = not fly:IsShown(),
			wide = wide, railW = railW, grew = railMain - mainW, label = label, items = items,
			back = O.frame.Sidebar:GetWidth(), savedOff = PolestarDB.optionsRail == nil })`);
	assert.equal(out.rail, true, 'the rail is remembered for the account');
	assert.deepEqual(out.flyout.slice(0, 3), ['Guide', 'Questing', 'Map'], "the hovered group's pages, in order");
	assert.equal(out.shown, 'map', 'a page picked in the fly-out is shown');
	assert.equal(out.flyGone, true);
	assert.equal(out.railW, 24 * 2 + 24, 'the rail is as wide as its icons');
	assert.equal(out.grew, out.wide - out.railW, 'the page takes the room the sidebar gave up');
	assert.equal(out.label, false, 'icons only');
	assert.deepEqual(out.items, ['b:guiding', 'b:qol', 'b:look', 'b:setup', 'b:addons', 'b:about'], 'the rail holds the groups');
	assert.equal(out.back, out.wide, 'unfolded, the sidebar is back at its width');
	assert.equal(out.savedOff, true);
});

test('pinned settings sit at the foot with live controls acting on the home setting', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("arrow")
		G.Pin("nav.arrowScale", true)
		G.Pin("ui.locked", true)
		local kinds = {}
		for _, key in ipairs(pinKeys()) do kinds[#kinds + 1] = O.frame.navPins[key].psKind end
		local pc = O.frame.navPins["nav.arrowScale"]
		pc.Slider.value = 1.2
		stub.RunScript(pc.Slider, "OnValueChanged", 1.2, true)
		local value = Polestar.Get("nav.arrowScale")
		-- The home row follows.
		local row = O.JumpTo("nav.arrowScale")
		local rowValue = row.Slider:GetValue()
		-- The switch flips the home setting.
		local sw = O.frame.navPins["ui.locked"]
		local was = Polestar.Get("ui.locked") and true or false
		stub.RunScript(sw.Sw, "OnClick")
		local flipped = (Polestar.Get("ui.locked") and true or false) ~= was
		-- Changed elsewhere, the pinned control repaints.
		Polestar.Set("nav.arrowScale", 1.5)
		local repainted = pc.Slider:GetValue()
		-- At most eight.
		for _, c in ipairs(O.AllControls()) do
			if c.key and (c.kind == "toggle" or c.kind == "slider") then G.Pin(c.key, true) end
		end
		emit({ kinds = kinds, value = value, rowValue = rowValue, flipped = flipped, repainted = repainted,
			max = #PolestarDB.optionsPins, shown = #pinKeys() })`);
	assert.deepEqual(out.kinds, ['slider', 'toggle']);
	assert.equal(out.value, 1.2, 'the sidebar slider sets the home setting');
	assert.equal(out.rowValue, 1.2, 'and its home row shows it');
	assert.equal(out.flipped, true, 'the sidebar switch flips the home setting');
	assert.equal(out.repainted, 1.5, 'a change elsewhere repaints the pinned control');
	assert.equal(out.max, 8, 'the sidebar holds eight pins at most');
	assert.equal(out.shown, 8);
});

test('a pinned setting whose home row is gone is not drawn, and stays saved', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("arrow")
		local pins = pinKeys()
		local saved = {}
		for i, k in ipairs(PolestarDB.optionsPins) do saved[i] = k end
		emit({ pins = pins, saved = saved })`,
	'PolestarDB = { settings = {}, optionsSeen = { ["*"] = true }, optionsLayout = "grouped", optionsPins = { "gone.key", "nav.arrowScale" } }');
	assert.deepEqual(out.pins, ['nav.arrowScale']);
	assert.deepEqual(out.saved, ['gone.key', 'nav.arrowScale'], 'kept for a session where its row is there');
});

test('a pinned setting unavailable now draws nothing and stays saved', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("arrow")
		G.Pin("nav.arrowScale", true)
		G.Pin("ui.locked", true)
		local c = O.ControlByKey("nav.arrowScale")
		c.needs = function() return false end
		G.Render({ keep = true })
		local hidden = pinKeys()
		local pc = O.frame.navPins["nav.arrowScale"]
		local controlShown = pc:IsShown()
		local saved = {}
		for i, k in ipairs(PolestarDB.optionsPins) do saved[i] = k end
		c.needs = nil
		G.Render({ keep = true })
		emit({ hidden = hidden, controlShown = controlShown, saved = saved, back = pinKeys() })`);
	assert.deepEqual(out.hidden, ['ui.locked'], 'not drawn while unavailable');
	assert.equal(out.controlShown, false);
	assert.deepEqual(out.saved, ['nav.arrowScale', 'ui.locked'], 'still saved');
	assert.deepEqual(out.back, ['nav.arrowScale', 'ui.locked'], 'and drawn again once it is available');
});

test('a pinned slider with release writes when the drag ends; a pinned list opens its home row\'s menu', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("arrow")
		local rel, font
		for _, c in ipairs(O.AllControls()) do
			if not rel and c.kind == "slider" and c.release and c.key and O.Kit.available(c) and not O.Kit.disabledOf(c)() then rel = c end
			if not font and c.kind == "font" and c.key and O.Kit.available(c) and not O.Kit.disabledOf(c)() then font = c end
		end
		local res = { rel = rel and rel.key or false, font = font and font.key or false }
		if rel then
			G.Pin(rel.key, true)
			local pc = O.frame.navPins[rel.key]
			local before = Polestar.Get(rel.key)
			local lo, hi = pc.Slider:GetMinMaxValues()
			local v = (before == hi) and lo or hi
			stub.RunScript(pc.Slider, "OnMouseDown")
			pc.Slider.value = v
			stub.RunScript(pc.Slider, "OnValueChanged", v, true)
			res.during = Polestar.Get(rel.key) == before
			stub.RunScript(pc.Slider, "OnMouseUp")
			res.after = Polestar.Get(rel.key) == v
		end
		if font then
			G.Pin(font.key, true)
			local pc = O.frame.navPins[font.key]
			local got
			local show = W.ShowMenu
			W.ShowMenu = function(anchor, items, opts) got = items return show(anchor, items, opts) end
			stub.RunScript(pc.Face, "OnClick")
			W.ShowMenu = show
			res.faces = got ~= nil and got[1] ~= nil and got[1].font ~= nil
		end
		emit(res)`);
	assert.ok(out.rel, 'a slider that writes on release');
	assert.equal(out.during, true, 'nothing written during the drag');
	assert.equal(out.after, true, 'written when it ends');
	assert.ok(out.font, 'a font list');
	assert.equal(out.faces, true, 'its menu draws each face, as the home row does');
});

test('the fly-out closes with the window', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("guide")
		G.SetRail(true)
		stub.RunScript(navRow("b:look"), "OnEnter")
		local fly = G._flyout()
		local was = fly:IsShown()
		O.frame:Hide()
		emit({ was = was, now = fly:IsShown() })`);
	assert.equal(out.was, true);
	assert.equal(out.now, false);
});

test('the profile card shows the profile name and a Switch action', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("guide")
		local card = O.frame.NavProfile
		local item
		for _, it in ipairs(G.NavItems()) do if it.profile then item = it end end
		local shown = false
		local show = W.ShowMenu
		W.ShowMenu = function(anchor, items, opts) shown = anchor == card.Action return show(anchor, items, opts) end
		stub.RunScript(card.Action, "OnClick")
		W.ShowMenu = show
		emit({ card = { name = card.Name:GetText(), action = card.Action.Label:GetText() }, item = item and item.profile or false,
			visible = card:IsShown(), menu = shown })`);
	assert.deepEqual(out.card, { name: 'Default', action: 'Switch' });
	assert.equal(out.item, 'Default', 'the profile item carries its name');
	assert.equal(out.visible, true);
	assert.equal(out.menu, true, 'Switch opens the profile menu under it');
});

test('sidebar marks: New on new pages and groups, no changed dot', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("guide")
		Polestar.Set("nav.arrowScale", 1.4)
		Polestar.Set("ui.locked", true)
		G.SetNavAll(true)
		local anyChanged, newKeys = false, {}
		for _, it in ipairs(G.NavItems()) do
			if it.changed then anyChanged = true end
			if it.new then newKeys[#newKeys + 1] = it.key end
		end
		local look = navRow("b:look")
		emit({ anyChanged = anyChanged, newKeys = newKeys,
			marked = (look.Changed:IsShown() or look.Dot:IsShown()) and true or false })`,
	'PolestarDB = { settings = {}, optionsLayout = "grouped" }');
	assert.equal(out.anyChanged, false);
	assert.ok(out.newKeys.includes('b:look'), `a group with new settings is marked (${out.newKeys})`);
	assert.ok(out.newKeys.includes('guidewindow'), 'and so is its page');
	assert.equal(out.marked, true, 'the group row carries a mark');
});

test("a pinned control follows its home row's disabled state", () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("arrow")
		-- A slider whose card's module switch is off.
		local pick
		for _, c in ipairs(O.AllControls()) do
			local s = c.psSection
			local t = s and s.toggle
			if not pick and c.kind == "slider" and c.key and t and t ~= c and t.key and t.kind == "toggle" and O.Kit.available(t) then pick = c end
		end
		local t = pick.psSection.toggle
		Polestar.Set(t.key, false)
		G.Pin(pick.key, true)
		local pc = O.frame.navPins[pick.key]
		local before = Polestar.Get(pick.key)
		local lo, hi = pc.Slider:GetMinMaxValues()
		local v = (before == hi) and lo or hi
		pc.Slider.value = v
		stub.RunScript(pc.Slider, "OnValueChanged", v, true)
		local enabled = W.Enabled(pc)
		local unchanged = Polestar.Get(pick.key) == before
		Polestar.Set(t.key, true)
		emit({ key = pick.key, enabled = enabled, unchanged = unchanged, after = W.Enabled(pc) })`);
	assert.equal(out.enabled, false, `${out.key} is off while its module is`);
	assert.equal(out.unchanged, true, 'and the sidebar cannot set it');
	assert.equal(out.after, true, 'its module on, it is live again');
});

test('the classic page keeps its sidebar: no rail, no pins, no profile card', () => {
	const [out] = run(`
		PolestarDB.optionsRail = true
		Polestar.UI.ShowOptions()
		O.Select("guide")
		local railW = O.frame.Sidebar:GetWidth()
		G.SetOn(false)
		local card = rawget(O.frame, "NavProfile")
		local head = G._navHead()
		emit({ railW = railW, width = O.frame.Sidebar:GetWidth(), card = card ~= nil and card:IsShown() or false,
			head = head ~= nil and head.Expand:IsShown() or false, wordmark = O.frame.Wordmark:IsShown() })`);
	assert.equal(out.railW, 72, 'the saved rail applies on the new page');
	assert.equal(out.width, 240, 'the classic page has the full sidebar');
	assert.equal(out.card, false);
	assert.equal(out.head, false);
	assert.equal(out.wordmark, true);
});

// Every pin saved and none available here: a line that says so, not the
// hint, and a Clear that asks first and takes off only those.
test('pins saved but unavailable here: a line with Clear, which asks and takes off only those', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("arrow")
		local L = Polestar.L
		local function labels()
			local out = {}
			for _, it in ipairs(G.NavItems()) do if it.heading or it.key == "pins:clear" then out[#out + 1] = it.label end end
			return out
		end
		local before = labels()
		local modal
		local realModal = W.Modal
		W.Modal = function(spec) modal = spec return realModal(spec) end
		G.NavSelect("pins:clear")
		local asked = modal ~= nil and modal.title
		local kept = #PolestarDB.optionsPins
		modal.onAccept()
		local saved = {}
		for i, k in ipairs(PolestarDB.optionsPins) do saved[i] = k end
		emit({ before = before, asked = asked, kept = kept, saved = saved, after = labels() })`,
	'PolestarDB = { settings = {}, optionsSeen = { ["*"] = true }, optionsLayout = "grouped", optionsPins = { "gone.key", "other.gone" } }');
	assert.ok(out.before.includes('Pinned, not available here: 2'), out.before.join(' | '));
	assert.ok(out.before.includes('Clear'));
	assert.ok(!out.before.includes('Pin a setting with the flag on its row.'), 'not the hint while pins are saved');
	assert.equal(out.asked, 'Clear the pins not available here?');
	assert.equal(out.kept, 2, 'nothing goes before the player says so');
	assert.equal(Object.keys(out.saved).length, 0, 'the unavailable pins are off the list');
	assert.ok(out.after.includes('Pin a setting with the flag on its row.'), 'then the hint');
});

test('Clear takes off the unavailable pins only, keeping the ones drawn', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("arrow")
		local any = false
		for _, it in ipairs(G.NavItems()) do if it.key == "pins:clear" then any = true end end
		local modal
		local realModal = W.Modal
		W.Modal = function(spec) modal = spec return realModal(spec) end
		G.NavSelect("pins:clear")
		if modal then modal.onAccept() end
		local saved = {}
		for i, k in ipairs(PolestarDB.optionsPins) do saved[i] = k end
		emit({ any = any, saved = saved, shown = pinKeys() })`,
	'PolestarDB = { settings = {}, optionsSeen = { ["*"] = true }, optionsLayout = "grouped", optionsPins = { "gone.key", "nav.arrowScale" } }');
	assert.equal(out.any, false, 'no Clear line while a pin is drawn');
	assert.deepEqual(out.saved, ['nav.arrowScale'], 'asked from elsewhere, only the unavailable one goes');
	assert.deepEqual(out.shown, ['nav.arrowScale']);
});

test('a group with one page lists its tabs as rows: no page row, no folder tabs, crumb names the tab', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("qualityoflife")
		local names = {}
		for _, t in ipairs(G.Tabs((G.Current()))) do names[#names + 1] = t.name end
		local rows, pageRow, openQol = {}, false, false
		for _, it in ipairs(G.NavItems()) do
			if it.indent then rows[#rows + 1] = { key = it.key, label = it.label } end
			if it.key == "qualityoflife" then pageRow = true end
			if it.key == "b:qol" and it.open then openQol = true end
		end
		local ft = rawget(O.frame, "FolderTabs")
		local strip = 0
		for _, b in ipairs(ft and ft.buttons or {}) do if b:IsShown() then strip = strip + 1 end end
		local first = G.NavKey()
		local crumb = O.frame.Title:GetText()
		-- A guide-pages group keeps its pages as rows and tabs on the page.
		O.Select("guide")
		local guideRows = {}
		for _, it in ipairs(G.NavItems()) do if it.indent then guideRows[#guideRows + 1] = it.key end end
		emit({ names = names, rows = rows, pageRow = pageRow, openQol = openQol, strip = strip, first = first, crumb = crumb,
			guideRows = guideRows })`);
	assert.ok(out.openQol, 'the group is open');
	assert.ok(out.names.length > 1);
	assert.deepEqual(out.rows.map((r) => r.label), out.names, 'the rows are the page\'s tabs, in order');
	assert.ok(out.rows.every((r) => r.key.startsWith('t:qualityoflife\t')));
	assert.equal(out.pageRow, false, 'the doubled page row is not drawn');
	assert.equal(out.strip, 0, 'no folder tabs on the page');
	assert.equal(out.first, out.rows[0].key, 'the row of the tab shown is lit');
	assert.equal(out.crumb, `Quality of Life \u203a ${out.names[0]}`);
	assert.ok(out.guideRows.includes('guide') && !out.guideRows.some((k) => k.startsWith('t:')), 'a group of several pages keeps its pages');
});

test('the group header opens the first tab; a row opens its tab; a search jump lights its row; LB/RB step the rows', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("guide")
		local first = select(2, G.Current())
		stub.RunScript(navRow("b:qol"), "OnClick")
		local p, t = G.Current()
		local head = { page = p.key, tab = t.name, key = G.NavKey() }
		local tabs = {}
		for _, x in ipairs(G.Tabs(p)) do tabs[#tabs + 1] = x.name end
		local last = tabs[#tabs]
		stub.RunScript(navRow("t:qualityoflife\t" .. last), "OnClick")
		local _, t2 = G.Current()
		local picked = { tab = t2.name, key = G.NavKey() }
		O.Select("guide")
		local w = O.JumpTo("qol.sellJunk")
		local jp, jt = G.Current()
		local jumped = { page = jp.key, tab = jt.name, key = G.NavKey(), shown = w ~= nil and w:IsShown() }
		O.Select("qualityoflife", tabs[1])
		O.StepTab(1)
		local _, st = G.Current()
		emit({ head = head, tabs = tabs, picked = picked, jumped = jumped, stepped = st.name })`);
	assert.equal(out.head.page, 'qualityoflife');
	assert.equal(out.head.tab, out.tabs[0], 'the header opens the first tab');
	assert.equal(out.head.key, `t:qualityoflife\t${out.tabs[0]}`);
	assert.equal(out.picked.tab, out.tabs[out.tabs.length - 1]);
	assert.equal(out.picked.key, `t:qualityoflife\t${out.tabs[out.tabs.length - 1]}`);
	assert.equal(out.jumped.page, 'qualityoflife');
	assert.equal(out.jumped.key, `t:qualityoflife\t${out.jumped.tab}`, 'a jump to a setting lights the row of its tab');
	assert.equal(out.stepped, out.tabs[1], 'RB steps to the next row');
});

test('the rail\'s fly-out for such a group lists the same rows', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("qualityoflife")
		local p = G.Current()
		local tabs = {}
		for _, x in ipairs(G.Tabs(p)) do tabs[#tabs + 1] = x.name end
		G.SetRail(true)
		stub.RunScript(navRow("b:qol"), "OnEnter")
		local fly = G._flyout()
		local labels, pick = {}, nil
		for _, b in ipairs(fly and fly.rows or {}) do
			if b:IsShown() and not b.psHeading then
				labels[#labels + 1] = b.Label:GetText()
				if #labels == 2 then pick = b end
			end
		end
		stub.RunScript(pick, "OnClick")
		local _, t = G.Current()
		G.SetRail(false)
		emit({ tabs = tabs, labels = labels, tab = t.name })`);
	assert.deepEqual(out.labels, out.tabs);
	assert.equal(out.tab, out.tabs[1], 'a fly-out row opens its tab');
});
