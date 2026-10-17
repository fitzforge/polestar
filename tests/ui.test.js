'use strict';
// The guide window (addon/Polestar/UI/GuideFrame.lua) against the real
// Core + Theme + UI manifests and a contract-faithful fake Engine (with
// tabs), Guides and Nav (tests/lua/stub_ui.lua).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { fakeLocale } = require('./helpers/locale');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

// Run `script` after the fakes are installed and the player logged in.
function run(script, { before = '', install = '' } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		before,
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install(${install})\nstub.login()\nlocal GF, UI, W = Polestar.UI.GuideFrame, Polestar.UI, Polestar.Widgets\nlocal F = PolestarGuideFrame\n${HELPERS}\n${script}`,
	}).emitted;
}

// Lua helpers shared by the scripts below.
const HELPERS = `
local function visibleRows()
	local out = {}
	for _, r in ipairs(GF.rows) do if r:IsShown() then out[#out + 1] = r end end
	return out
end
local function rowFor(subject)
	for _, r in ipairs(visibleRows()) do
		if r.psGoal and r.psGoal.subject == subject then return r end
	end
end
local function lastCall(name)
	for i = #uistub.calls, 1, -1 do
		if uistub.calls[i][1] == name then return uistub.calls[i] end
	end
end
local function shownTabs()
	local out = {}
	for _, b in ipairs(GF.tabs) do if b:IsShown() then out[#out + 1] = b end end
	return out
end
local function menuPick(text)
	GF.menuButton:Click()
	for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == text then r:Click() return r end end
end
local TABS = { { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }
`;

test('a field step reads as one focus: the step title, its few objectives with counters right after the text, the next person', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local rows = {}
		for _, r in ipairs(visibleRows()) do
			local tr, tg, tb = r.Icon:GetVertexColor()
			local cr, cg, cb = r.Text:GetTextColor()
			rows[#rows + 1] = {
				subject = r.psGoal.subject,
				icon = r.Icon:GetTexture():match("([%w-]+)$"),
				iconColor = { tr, tg, tb }, textColor = { cr, cg, cb },
				check = r.Check:IsShown(),
				text = r.Text:GetText(),
				size = select(2, r.Text:GetFont()),
			}
		end
		local P = GF.parts
		emit({ rows = rows, accent = { Polestar.Theme.Accent() }, success = { Polestar.Theme.Color("success") },
			text = { Polestar.Theme.Color("text") }, muted = { Polestar.Theme.Color("textMuted") }, dim = { Polestar.Theme.Color("textDim") },
			textHex = Polestar.Theme.Hex("text"), accentHex = Polestar.Theme.Hex("accent"),
			person = P.person.Name:GetText(), where = P.person.Where:GetText(),
			personIcon = P.person.Icon:GetTexture():match("([%w-]+)$"),
			tip = P.tip:IsShown() and P.tip.Text:GetText(), count = P.nav.Steps.Count:GetText(),
			after = P.after.Text:GetText(), persons = P.after.Count:GetText(),
			upnext = P.upnext:IsShown(), pct = P.foot.Pct:GetText(), footShown = P.foot:IsShown() })`);
	assert.equal(out.person, 'Kobold Camp', 'a field group is named by its step');
	assert.equal(out.where, 'Elwynn Forest');
	assert.equal(out.personIcon, 'icon-goto', 'a field group is a place');
	assert.equal(out.count, '3 / 8', 'the navigator says where you are');
	assert.deepEqual(out.rows.map((r) => r.subject), ['the Kobold Camp', 'Kobold Vermin', 'Tough Wolf Meat'],
		'only the focus group: the earlier quest-giver is not listed');
	const [go, kill, collect] = out.rows;
	assert.equal(go.icon, 'check');
	assert.deepEqual(go.iconColor, out.success.slice(0, 3));
	assert.deepEqual(go.textColor, out.muted.slice(0, 3), 'done goals dim');
	assert.equal(kill.icon, 'icon-kill');
	assert.deepEqual(kill.iconColor, out.accent.slice(0, 3), 'the current goal\'s glyph alone takes the accent');
	assert.deepEqual(collect.iconColor, out.dim.slice(0, 3), 'the other open goals\' glyphs sit in textDim');
	assert.deepEqual(kill.textColor, out.text.slice(0, 3), 'open goals are white');
	assert.match(kill.text, /^Kill \|c[0-9a-f]{8}Kobold Vermin\|r {2}\|c[0-9a-f]{8}7\/10\|r$/, 'the counter follows the text');
	assert.ok(kill.text.endsWith(`|c${out.textHex}7/10|r`), 'an open counter reads in the text colour, not the accent');
	assert.ok(!kill.text.includes(out.accentHex));
	assert.match(collect.text, /3\/8\|r$/);
	assert.equal(kill.size, 14, 'goal text is 14px');
	assert.match(out.tip, /^Kobolds wander/);
	assert.match(out.after, /^Then: \|c[0-9a-f]{8}Marshal McBride\|r$/, 'the next step\'s first person');
	assert.equal(out.persons, '', 'a field group is not a person');
	assert.equal(out.upnext, false, 'Up next is off by default');
	assert.equal(out.footShown, true);
	assert.equal(out.pct, '29%', '2 of the 7 steps that apply are done');
});

test('a hub reads one person at a time: name in NPC colour, only their goals, then the next person', () => {
	const [first, second, third] = run(`
		local function snap()
			local P = GF.parts
			local names = {}
			for _, r in ipairs(visibleRows()) do names[#names + 1] = r.psGoal.subject end
			local nr, ng, nb = P.person.Name:GetTextColor()
			return { person = P.person.Name:GetText(), color = { nr, ng, nb }, npc = { Polestar.Theme.Color("npc") },
				icon = P.person.Icon:GetTexture():match("([%w-]+)$"), goals = names,
				after = P.after.Text:GetText(), persons = P.after.Count:GetText(), mark = P.person.Mark:IsShown(),
				markW = P.person.Mark:GetWidth(), iconColor = { P.person.Icon:GetVertexColor() }, dim = { Polestar.Theme.Color("textDim") },
				sliding = Polestar.Anim.IsRunning(P.card, "offset") }
		end
		uistub.setGuide(uistub.elwynn, 4)
		stub.advance(1)
		emit(snap())
		uistub.goal(4, 1).status = "done"
		uistub.goal(4, 2).status = "done"
		uistub.update()
		emit(snap())
		uistub.goal(4, 3).status = "done"
		uistub.update()
		local s = snap()
		stub.RunScript(GF.parts.person, "OnClick", "LeftButton")
		s.target = lastCall("SetTarget")
		emit(s)`);
	assert.equal(first.person, 'Marshal McBride');
	assert.deepEqual(first.color, first.npc.slice(0, 3));
	assert.equal(first.icon, 'icon-talk');
	assert.deepEqual(first.goals, ['Kobold Camp Cleanup', 'Investigate Echo Ridge']);
	assert.match(first.after, /^Then: \|c[0-9a-f]{8}Eagan Peltskinner\|r$/);
	assert.equal(first.persons, 'Person 1 of 3');
	assert.equal(first.mark, true, 'the arrow points at this person');
	assert.equal(first.markW, 2, 'the 2px selection bar used across Polestar');
	assert.deepEqual(first.iconColor.slice(0, 3), first.dim.slice(0, 3), 'the person glyph steps back; the name carries the colour');
	assert.equal(second.person, 'Eagan Peltskinner');
	assert.deepEqual(second.goals, ['Wolves Across the Border']);
	assert.equal(second.persons, 'Person 2 of 3');
	assert.equal(second.sliding, true, 'the next person slides in');
	assert.equal(third.person, 'Brother Neals');
	assert.equal(third.persons, 'Person 3 of 3');
	assert.match(third.after, /^Then: \|c[0-9a-f]{8}Goldshire\|r$/, 'after the last person: the next step');
	assert.deepEqual(third.target, ['SetTarget', 1429, 49.6, 40.4, 'Brother Neals']);
});

test('a done step (viewed with Prev) lists all its goals under the step title, checked, with no arrow mark', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 4)
		for g = 1, 4 do uistub.goal(4, g).status = "done" end
		uistub.update()
		local names, marks = {}, 0
		for _, r in ipairs(visibleRows()) do
			names[#names + 1] = r.psGoal.subject .. ":" .. r.psGoal.status
			if r.Mark:IsShown() then marks = marks + 1 end
		end
		emit({ person = GF.parts.person.Name:GetText(), goals = names, marks = marks, personMark = GF.parts.person.Mark:IsShown() })`);
	assert.deepEqual(out, {
		person: 'Back to the Abbey',
		goals: ['Kobold Camp Cleanup:done', 'Investigate Echo Ridge:done', 'Wolves Across the Border:done', 'Brother Neals:done'],
		marks: 0,
		personMark: false,
	});
});

test('with Expand step tips off, the tip is one line until clicked', () => {
	const [out] = run(`
		Polestar.Set("ui.width", 300)
		Polestar.Set("ui.notesOpen", false)
		uistub.setGuide(uistub.elwynn, 3)
		local tip = GF.parts.tip
		local closed = { open = tip.psOpen, h = tip:GetHeight() }
		tip:Click()
		local open = { open = tip.psOpen, h = tip:GetHeight() }
		uistub.setStep(4)
		uistub.setStep(3)
		emit({ closed = closed, open = open, reset = { open = tip.psOpen, h = tip:GetHeight() } })`);
	assert.equal(out.closed.open, false);
	assert.equal(out.open.open, true);
	assert.ok(out.open.h > out.closed.h, 'opened, the tip shows in full');
	assert.deepEqual(out.reset, out.closed, 'a new step starts with the tip collapsed');
});

test('step tips start open by default; with Expand step tips off, on one line', () => {
	const [out] = run(`
		Polestar.Set("ui.width", 300)
		uistub.setGuide(uistub.elwynn, 3)
		local tip = GF.parts.tip
		local byDefault = tip.psOpen
		Polestar.Set("ui.notesOpen", false)
		local closedH = tip:GetHeight()
		local off = tip.psOpen
		Polestar.Set("ui.notesOpen", true)
		local now = tip.psOpen
		tip:Click()
		local clicked = tip.psOpen
		uistub.setStep(4)
		uistub.setStep(3)
		emit({ byDefault = byDefault, off = off, closedH = closedH, now = now, clicked = clicked, next = tip.psOpen, h = tip:GetHeight() })`);
	assert.equal(out.byDefault, true, 'a new player sees the tip in full');
	assert.equal(out.off, false, 'turning it off folds the tip on screen');
	assert.equal(out.now, true, 'turning it on opens the tip on screen');
	assert.equal(out.clicked, false, 'a click still folds it');
	assert.equal(out.next, true, 'the next step starts open again');
	assert.ok(out.h > out.closedH);
});

test('STEP_UPDATED refills the same rows in place, and a newly done goal pops', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		stub.advance(1)
		local frames = uistub.frameCount()
		local before = rowFor("Kobold Vermin")
		uistub.goal(3, 3).progress.cur = 8
		uistub.update()
		local text = rowFor("Kobold Vermin").Text:GetText()
		uistub.goal(3, 3).progress.cur = 10
		uistub.goal(3, 3).status = "done"
		uistub.update()
		local after = rowFor("Kobold Vermin")
		local popping = Polestar.Anim.IsRunning(after.Icon, "size")
		stub.advance(1)
		emit({ same = before == after, framesAdded = uistub.frameCount() - frames, text = text, doneText = after.Text:GetText(),
			icon = after.Icon:GetTexture():match("([%w-]+)$"), popping = popping, settled = Polestar.Anim.Active(),
			size = after.Icon:GetWidth(), successHex = Polestar.Theme.Hex("success") })`);
	assert.equal(out.same, true);
	assert.equal(out.framesAdded, 0, 'no frames are created for an update');
	assert.match(out.text, /8\/10\|r$/);
	assert.equal(out.doneText, `Kill Kobold Vermin  |c${out.successHex}10/10|r`, 'done: plain text, the count kept in success');
	assert.equal(out.icon, 'check');
	assert.equal(out.popping, true);
	assert.equal(out.settled, 0, 'the tween driver stops once settled');
	assert.equal(out.size, 15);
});

test('a hidden window does no work on step messages and shows the current step when opened', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		stub.advance(1)
		F:Hide()
		local calls = #uistub.calls
		uistub.setStep(4)
		uistub.update()
		local asked = #uistub.calls - calls
		local stale = rowFor("Kobold Vermin") ~= nil
		F:Show()
		emit({ asked = asked, stale = stale, shown = rowFor("Kobold Vermin") ~= nil, rows = #visibleRows() })`);
	assert.equal(out.asked, 0, 'no Engine reads while hidden');
	assert.equal(out.stale, true, 'the hidden window kept its old rows');
	assert.equal(out.shown, false, 'opening it renders the step the Engine is on now');
	assert.ok(out.rows > 0);
});

test('left-click on a goal of the step aims the arrow at it; right-click and the box tick any goal done and back', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local collect = rowFor("Tough Wolf Meat")
		stub.RunScript(collect, "OnClick", "LeftButton")
		local aimed = { lastCall("AimGoal"), lastCall("ReleaseTarget"), lastCall("SetTarget") or false }
		local target = Polestar.Nav.GetTarget()
		local marked = collect.Mark:IsShown()
		stub.RunScript(rowFor("Kobold Vermin"), "OnClick", "RightButton")
		local tickedKill = { lastCall("ToggleGoal"), rowFor("Kobold Vermin").Check:IsShown() }
		for g = 1, 3 do uistub.goal(4, g).status = "done" end
		uistub.setStep(4)
		stub.RunScript(rowFor("Brother Neals"), "OnClick", "RightButton")
		local toggled = lastCall("ToggleGoal")
		local checked = rowFor("Brother Neals").Check:GetChecked()
		rowFor("Brother Neals").Check:Click()
		emit({ aimed = aimed, target = { target.goalIndex, target.x }, marked = marked, tickedKill = tickedKill, toggled = toggled,
			checked = checked, after = rowFor("Brother Neals").Check:GetChecked() })`);
	assert.deepEqual(out.aimed, [['AimGoal', 3, 4], ['ReleaseTarget'], false], 'the Engine leads the arrow there; no point by hand');
	assert.deepEqual(out.target, [4, 46]);
	assert.equal(out.marked, true, 'the targeted row carries the accent mark');
	assert.deepEqual(out.tickedKill, [['ToggleGoal', 3, 3], true], 'a quest goal ticks too');
	assert.deepEqual(out.toggled, ['ToggleGoal', 4, 4]);
	assert.equal(out.checked, true);
	assert.equal(out.after, false, 'the box follows the engine, which flipped it back');
});

test('hovering a goal explains it: detail, quest, NPC, location and what clicks do', () => {
	const [lines] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		for g = 1, 3 do uistub.goal(4, g).status = "done" end
		uistub.setStep(4)
		stub.RunScript(rowFor("Brother Neals"), "OnEnter")
		emit(GameTooltip.lines)`);
	assert.equal(lines[0], 'Talk to Brother Neals');
	assert.ok(lines.includes('in the abbey bell tower'), 'the detail moved into the tooltip');
	assert.ok(lines.some((l) => /^NPC \| Brother Neals/.test(l)));
	assert.ok(lines.includes('Location | Elwynn Forest  49.6, 40.4'));
	assert.ok(lines.includes('Click to point the arrow here'));
	assert.ok(lines.includes('Right-click to tick it done'));
});

test('the step navigator and the Up next list drive the engine; a step change animates, then stops', () => {
	const [out] = run(`
		Polestar.Set("ui.upcoming", 3)
		uistub.setGuide(uistub.elwynn, 3)
		stub.advance(1)
		local N = GF.parts.nav
		N.Next:Click()
		local count = N.Steps.Count:GetText()
		local animating = Polestar.Anim.Active() > 0 and GF.parts.card:GetAlpha() < 1
		stub.advance(1)
		local settled = { Polestar.Anim.Active(), GF.parts.card:GetAlpha() }
		N.Prev:Click()
		local collapsed = GF.parts.upnext:IsShown() and GF.parts.upnext.Toggle.Label:GetText()
		GF.parts.upnext.Toggle:Click()
		local open = Polestar.Get("ui.upcomingOpen")
		local shown = {}
		for _, r in ipairs(GF.upRows) do if r:IsShown() then shown[#shown + 1] = r.psIndex end end
		GF.upRows[1]:Click()
		emit({ count = count, animating = animating, settled = settled, collapsed = collapsed, open = open, shown = shown,
			calls = uistub.calls })`);
	assert.equal(out.count, '4 / 8');
	assert.equal(out.animating, true);
	assert.deepEqual(out.settled, [0, 1]);
	assert.equal(out.collapsed, 'Up next \u00b7 3 steps', 'turned on, it starts collapsed');
	assert.equal(out.open, true);
	assert.deepEqual(out.shown, [4, 5, 7], 'the mage-only step 6 does not apply');
	assert.deepEqual(out.calls.map((c) => c[0]), ['Next', 'Prev', 'Goto']);
	assert.deepEqual(out.calls[2], ['Goto', 4]);
});

test('reduced motion: a step change lands without movement', () => {
	const [out] = run(`
		Polestar.Set("ui.reduceMotion", true)
		uistub.setGuide(uistub.elwynn, 3)
		stub.advance(1)
		GF.parts.nav.Next:Click()
		local p = GF.parts.card.points[#GF.parts.card.points]
		emit({ y = p.y, offsetRunning = Polestar.Anim.IsRunning(GF.parts.card, "offset") })`);
	assert.deepEqual(out, { y: 0, offsetRunning: false });
});

test('settings apply live: scale, opacity, lock, compact, upcoming, shown', () => {
	const [out] = run(`
		uistub.openTabs(TABS, 1)
		local h0 = F:GetHeight()
		Polestar.Set("ui.scale", 1.3)
		Polestar.Set("ui.opacity", 0.5)
		Polestar.Set("ui.locked", true)
		stub.RunScript(GF.parts.nav, "OnDragStart")
		local movedWhileLocked = F.moving == true
		Polestar.Set("ui.compact", true)
		local P = GF.parts
		local compact = { strip = P.strip:IsShown(), after = P.after:IsShown(), tip = P.tip:IsShown(), rows = #visibleRows(),
			foot = P.foot:IsShown(), h = F:GetHeight() }
		Polestar.Set("ui.compact", false)
		Polestar.Set("ui.upcoming", 4)
		Polestar.Set("ui.upcomingOpen", true)
		local upIdx = {}
		for _, r in ipairs(GF.upRows) do if r:IsShown() then upIdx[#upIdx + 1] = r.psIndex end end
		Polestar.Fire("TOGGLE_FRAME")
		local afterToggle = F:IsShown()
		Polestar.Fire("SHOW_FRAME")
		emit({ scale = F:GetScale(), alpha = F:GetAlpha(), grip = GF.grip:IsShown(), movedWhileLocked = movedWhileLocked,
			compact = compact, h0 = h0, upcoming = upIdx, afterToggle = afterToggle, shown = F:IsShown(), stored = Polestar.Get("ui.shown") })`);
	assert.equal(out.scale, 1.3);
	assert.equal(out.alpha, 0.5);
	assert.equal(out.grip, false, 'locked: no resize grip');
	assert.equal(out.movedWhileLocked, false);
	assert.deepEqual({ ...out.compact, h: undefined }, { strip: false, after: false, tip: false, rows: 3, foot: true, h: undefined },
		'compact keeps the navigator, the focus goals and the progress bar');
	assert.ok(out.compact.h < out.h0, 'compact mode is shorter');
	assert.deepEqual(out.upcoming, [4, 5, 7, 8]);
	assert.equal(out.afterToggle, false);
	assert.equal(out.shown, true);
	assert.equal(out.stored, true);
});

test('dragging saves the position; the grip resizes width within bounds', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		F.x, F.y = 1500, 300
		stub.RunScript(GF.parts.nav, "OnDragStart")
		local moving = F.moving
		local top = F:GetTop()
		stub.RunScript(GF.parts.nav, "OnDragStop")
		local pos = Polestar.Get("ui.pos")
		stub.cursor = { 100, 500 }
		stub.RunScript(GF.grip, "OnMouseDown", "LeftButton")
		stub.cursor = { 180, 500 }
		stub.advance(0.1)
		local live = F:GetWidth()
		stub.cursor = { 2000, 500 }
		stub.advance(0.1)
		stub.RunScript(GF.grip, "OnMouseUp", "LeftButton")
		emit({ moving = moving, pos = pos, top = top, live = live, width = Polestar.Get("ui.width"),
			polling = GF.grip:GetScript("OnUpdate") ~= nil, point = { F:GetPoint(1) } })`);
	assert.equal(out.moving, true);
	assert.deepEqual(out.pos, [1500, out.top], 'saved as the top-left corner');
	assert.equal(out.live, 420, 'width follows the cursor while dragging');
	assert.equal(out.width, 560, 'and is clamped to the maximum');
	assert.equal(out.polling, false, 'no OnUpdate once released');
	assert.equal(out.point[0], 'TOPLEFT');
});

test('grow upward pins the window by its bottom-left; turning it on or off keeps the window in place', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		F.x, F.y = 1500, 300
		Polestar.Set("ui.growUp", true)
		local on, onPoint = Polestar.Get("ui.pos"), { F:GetPoint(1) }
		F.x, F.y = 900, 120
		stub.RunScript(GF.parts.nav, "OnDragStart")
		stub.RunScript(GF.parts.nav, "OnDragStop")
		local dragged = Polestar.Get("ui.pos")
		stub.cursor = { 100, 500 }
		stub.RunScript(GF.grip, "OnMouseDown", "LeftButton")
		local resizePoint = { F:GetPoint(1) }
		stub.RunScript(GF.grip, "OnMouseUp", "LeftButton")
		Polestar.Set("ui.pos", nil)
		local resetPoint = { F:GetPoint(1) }
		F.x, F.y = 900, 120
		Polestar.Set("ui.growUp", false)
		emit({ on = on, onPoint = onPoint, dragged = dragged, resizePoint = resizePoint, resetPoint = resetPoint,
			off = Polestar.Get("ui.pos"), offPoint = { F:GetPoint(1) }, top = F:GetTop() })`);
	assert.deepEqual(out.on, [1500, 300], 'turning it on saves the bottom-left where the window stands');
	assert.equal(out.onPoint[0], 'BOTTOMLEFT');
	assert.deepEqual(out.dragged, [900, 120], 'dragging saves the bottom-left');
	assert.equal(out.resizePoint[0], 'BOTTOMLEFT', 'resizing the width keeps the bottom edge pinned');
	assert.equal(out.resetPoint[0], 'BOTTOMRIGHT', 'reset puts it in the bottom-right corner');
	assert.equal(out.resetPoint[2], 'BOTTOMRIGHT');
	assert.deepEqual(out.off, [900, out.top], 'turning it off saves the top-left where the window stands');
	assert.equal(out.offPoint[0], 'TOPLEFT');
});

test('combat: by default the window stays as it is; fade dims it, hide hides it, both restore afterwards', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.advance(1)
		local steady = F:GetAlpha()
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.advance(1)
		Polestar.Set("ui.combat", "fade")
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.advance(1)
		local faded = F:GetAlpha()
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.advance(1)
		local restored = F:GetAlpha()
		Polestar.Set("ui.combat", "hide")
		stub.fire("PLAYER_REGEN_DISABLED")
		local hidden = not F:IsShown()
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ steady = steady, faded = faded, restored = restored, hidden = hidden, shown = F:IsShown() })`);
	assert.equal(out.steady, 1, 'no fade on every pull unless the player asks for it');
	assert.ok(Math.abs(out.faded - 0.35) < 1e-9);
	assert.equal(out.restored, 1);
	assert.equal(out.hidden, true);
	assert.equal(out.shown, true);
});

test('empty states: no guides, no guide open (with suggestion), guide complete', () => {
	const [noGuides, noGuide, complete] = run(`
		local function state()
			local e = GF.parts.empty
			return { shown = e:IsShown(), title = e.Title:GetText(), text = e.Text:GetText(),
				primary = e.Primary:IsShown() and e.Primary.Label:GetText() or false,
				secondary = e.Secondary:IsShown() and e.Secondary.Label:GetText() or false, card = GF.parts.card:IsShown() }
		end
		local order = uistub.order
		uistub.order = {}
		Polestar.Fire("GUIDES_REGISTERED")
		emit(state())
		uistub.order = order
		Polestar.Fire("GUIDES_REGISTERED")
		emit(state())
		GF.parts.empty.Primary:Click()
		uistub.complete()
		local s = state()
		GF.parts.empty.Primary:Click()
		s.calls = uistub.calls
		emit(s)`);
	assert.equal(noGuides.title, 'No guides installed');
	assert.equal(noGuides.primary, false);
	assert.equal(noGuides.card, false);
	assert.equal(noGuide.title, 'No guide open');
	assert.match(noGuide.text, /Elwynn Forest/);
	assert.equal(noGuide.primary, 'Start guide');
	assert.equal(noGuide.secondary, 'Browse guides');
	assert.equal(complete.title, 'Guide complete');
	assert.match(complete.text, /Westfall/);
	assert.equal(complete.primary, 'Continue');
	assert.deepEqual(complete.calls.map((c) => c.slice(0, 2)), [
		['OpenTab', 'forever/alliance/human/01-elwynn-forest'],
		['SetGuide', 'forever/alliance/02-westfall'],
	], 'start opens a tab; continue replaces the guide in the same tab');
});

test('tab strip: one tab per open guide; select, close, move, and + opens the picker for a new tab', () => {
	const [out] = run(`
		uistub.openTabs(TABS, 1)
		local tabs = shownTabs()
		local titles, ranges, widths = {}, {}, {}
		for i, b in ipairs(tabs) do titles[i] = b.Label:GetText(); ranges[i] = b.Range:GetText(); widths[i] = b:GetWidth() end
		local activeBar = { tabs[1].Bar:IsShown(), tabs[2].Bar:IsShown() }
		local titleInNav = GF.parts.nav.Title:IsShown()
		tabs[2]:Click()
		local afterSelect = { title = GF.parts.nav.Title:GetText(), count = GF.parts.nav.Steps.Count:GetText(), bar = shownTabs()[2].Bar:IsShown() }
		-- Right-click: tab options.
		stub.RunScript(shownTabs()[1], "OnClick", "RightButton")
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Move right" then r:Click() end end
		local moved = lastCall("MoveTab")
		shownTabs()[3].Close:Click()
		local closed = { n = #shownTabs(), call = lastCall("CloseTab") }
		GF.parts.strip.Add:Click()
		local pickerNewTab = PolestarPicker:IsShown() and Polestar.UI.Picker.IsNewTabMode()
		emit({ titles = titles, ranges = ranges, widths = widths, activeBar = activeBar, titleInNav = titleInNav, afterSelect = afterSelect, moved = moved,
			closed = closed, pickerNewTab = pickerNewTab })`);
	assert.deepEqual(out.titles, ['Elwynn Forest', 'Tailoring 1-300', 'Stormwind Reputation']);
	assert.deepEqual(out.ranges, ['(1–13)', '(5–60)', '(12–60)'], 'each tab names its levels after the title, as the guide menu rows do');
	assert.ok(out.widths[0] > out.widths[1], 'the active tab gets the room to read its title');
	assert.deepEqual(out.activeBar, [true, false]);
	assert.equal(out.titleInNav, false, 'the tab names the guide; the navigator does not repeat it');
	assert.deepEqual(out.afterSelect, { title: 'Tailoring 1-300', count: '2 / 4', bar: true });
	assert.deepEqual(out.moved, ['MoveTab', 1, 2]);
	assert.deepEqual(out.closed, { n: 2, call: ['CloseTab', 3] });
	assert.equal(out.pickerNewTab, true);
});

test('a narrow tab truncates its title and keeps its level range whole, also with the close button shown', () => {
	const [out] = run(`
		Polestar.Set("ui.width", 300)
		uistub.openTabs(TABS, 1)
		local b = shownTabs()[1]
		local function measure()
			local _, _, _, x = b.Range:GetPoint(1)
			return { range = b.Range:IsShown() and b.Range:GetText(), rangeWhole = b.Range:GetStringWidth() == b.Range:GetUnboundedStringWidth(),
				titleCut = b.Label:IsShown() and b.Label:GetStringWidth() < b.Label:GetUnboundedStringWidth(),
				right = 9 + 12 + x + b.Range:GetStringWidth(), width = b:GetWidth() }
		end
		local rest = measure()
		stub.RunScript(b, "OnEnter")
		local hover = measure()
		stub.RunScript(b, "OnLeave")
		emit({ rest = rest, hover = hover, after = measure() })`);
	for (const [state, pad] of [['rest', 8], ['hover', 20], ['after', 8]]) {
		const m = out[state];
		assert.equal(m.range, '(1–13)', state);
		assert.equal(m.rangeWhole, true, `${state}: the range is not cut`);
		assert.equal(m.titleCut, true, `${state}: the title truncates instead`);
		assert.ok(m.right <= m.width - pad, `${state}: the range ends ${m.right} inside ${m.width - pad}`);
	}
});

test('without the Engine tabs API the strip stays hidden and the navigator names the guide', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		emit({ strip = GF.parts.strip:IsShown(), title = GF.parts.nav.Title:IsShown() and GF.parts.nav.Title:GetText(), rows = #visibleRows() })`, { install: '{ noTabs = true }' });
	assert.deepEqual(out, { strip: false, title: 'Elwynn Forest', rows: 3 });
});

test('transparent mode: no fills or borders, outlined text, chrome only while the cursor is over the window', () => {
	const [out] = run(`
		uistub.openTabs(TABS, 1)
		local function chromeAlpha()
			local a = {}
			for i, c in ipairs(GF.chrome) do a[i] = c:GetAlpha() end
			return a
		end
		Polestar.Set("ui.style", "transparent")
		local skin = F.psSkin
		local bare = { bg = skin.bg:IsShown(), border = F.psBorder[1]:IsShown(), shadow = F.psShadow:IsShown(), band = GF.parts.band:IsShown() }
		local _, _, flags = GF.parts.person.Name:GetFont()
		local _, _, goalFlags = visibleRows()[1].Text:GetFont()
		local rest = chromeAlpha()
		local steps = false
		for _, c in ipairs(GF.chrome) do if c == GF.parts.nav.Steps then steps = true end end
		local track = GF.parts.line.Track
		local clearTrack = { shown = track:IsShown(), a = select(4, track:GetVertexColor()) }
		F.IsMouseOver = function() return true end
		stub.RunScript(F, "OnEnter")
		stub.advance(0.5)
		local hover = chromeAlpha()
		local watching = GF.IsHovering()
		F.IsMouseOver = function() return false end
		stub.advance(0.5)
		local left = chromeAlpha()
		Polestar.Set("ui.style", "standard")
		local _, _, flagsAfter = GF.parts.person.Name:GetFont()
		emit({ bare = bare, flags = flags, goalFlags = goalFlags, rest = rest, hover = hover, watching = watching, left = left,
			hovering = GF.IsHovering(), restored = { bg = skin.bg:IsShown(), band = GF.parts.band:IsShown(), alpha = chromeAlpha() },
			flagsAfter = flagsAfter, count = #GF.chrome, steps = steps, clearTrack = clearTrack,
			track = select(4, track:GetVertexColor()), progressWash = select(4, Polestar.Theme.Wash("progress")) })`);
	const all = (v) => Array(out.count).fill(v);
	assert.deepEqual(out.bare, { bg: false, border: false, shadow: false, band: false });
	assert.equal(out.flags, 'OUTLINE');
	assert.equal(out.goalFlags, 'OUTLINE');
	assert.deepEqual(out.rest, all(0), 'tabs, the navigator, menu and grip are hidden at rest');
	assert.equal(out.steps, true, 'the step number fades with its chevrons, never alone');
	assert.deepEqual(out.clearTrack, { shown: true, a: 0.15 }, 'the progress track stays as a faint ink line');
	assert.equal(out.track, out.progressWash, 'standard style: the house wash');
	assert.deepEqual(out.hover, all(1));
	assert.equal(out.watching, true);
	assert.deepEqual(out.left, all(0), 'they fade once the cursor leaves');
	assert.equal(out.hovering, false);
	assert.deepEqual(out.restored, { bg: true, band: true, alpha: all(1) });
	assert.equal(out.flagsAfter, '');
});

test('a goal with alternative trainers shows where it is and cycles to the next', () => {
	const [out] = run(`
		uistub.openTabs({ { uistub.tailoring, 1 } }, 1)
		uistub.goal(1, 1).status = "active"
		uistub.update()
		local r = visibleRows()[1]
		local before = { sub = r.Sub:IsShown(), alt = r.Alt:IsShown(), person = GF.parts.person.Name:GetText(), where = GF.parts.person.Where:GetText() }
		stub.RunScript(r, "OnEnter")
		local tip = GameTooltip.lines
		r.Alt:Click()
		local after = visibleRows()[1]
		emit({ before = before, tip = tip, call = lastCall("CycleCandidate"), subject = after.psGoal.subject, sub = after.Sub:IsShown(),
			person = GF.parts.person.Name:GetText(), where = GF.parts.person.Where:GetText(),
			alone = Polestar.UI.GoalSubline(after.psGoal) })`);
	assert.deepEqual(out.before, { sub: false, alt: true, person: 'Georgio Bolero', where: 'Stormwind City' },
		'the person names the zone; the goal does not repeat it');
	assert.ok(out.tip.includes('2 others nearby; the arrow button switches to the next.'));
	assert.deepEqual(out.call, ['CycleCandidate', 1, 1]);
	assert.equal(out.subject, 'Eldrin');
	assert.equal(out.sub, false);
	assert.equal(out.person, 'Eldrin', 'the person follows the chosen trainer');
	assert.equal(out.where, 'Elwynn Forest');
	assert.equal(out.alone, 'Elwynn Forest', 'without a person above, the goal names its zone');
});

test('GUIDE_OUTLEVELED: a dismissible banner offers the better guide, in the same tab', () => {
	const [out] = run(`
		uistub.openTabs(TABS, 1)
		local B = GF.parts.banner
		local h0 = F:GetHeight()
		Polestar.Fire("GUIDE_OUTLEVELED", uistub.elwynn, "forever/alliance/02-westfall")
		local shown = { B:IsShown(), B.Jump.Label:GetText(), F:GetHeight() > h0 }
		shownTabs()[2]:Click()
		local otherTab = B:IsShown()
		shownTabs()[1]:Click()
		local back = B:IsShown()
		B.Close:Click()
		local dismissed = B:IsShown()
		Polestar.Fire("GUIDE_OUTLEVELED", uistub.elwynn, "forever/alliance/02-westfall")
		B.Jump:Click()
		emit({ shown = shown, otherTab = otherTab, back = back, dismissed = dismissed, jump = lastCall("SetGuide"),
			after = B:IsShown(), header = GF.parts.nav.Title:GetText(), tabs = #shownTabs() })`);
	assert.deepEqual(out.shown, [true, 'Jump to Westfall', true]);
	assert.equal(out.otherTab, false, 'only on the out-levelled guide');
	assert.equal(out.back, true);
	assert.equal(out.dismissed, false);
	assert.deepEqual(out.jump, ['SetGuide', 'forever/alliance/02-westfall']);
	assert.equal(out.after, false);
	assert.equal(out.header, 'Westfall');
	assert.equal(out.tabs, 3, 'the jump replaced the guide in its tab');
});

test('non-leveling guides name their category, and a place only when the guide has a faction', () => {
	const [out] = run(`
		uistub.openTabs({ { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 }, { "forever/professions/first-aid", 1 } }, 1)
		local metas = {}
		for i = 1, 3 do
			shownTabs()[i]:Click()
			metas[i] = GF.parts.nav.psMeta
		end
		emit(metas)`);
	assert.deepEqual(out, [
		'Professions  \u00b7  Levels 5\u201360',
		'Reputation  \u00b7  Stormwind City  \u00b7  Levels 12\u201360',
		'Professions  \u00b7  Levels 5\u201360',
	]);
});

test('the header menu: picker, new tab, compact, transparent, lock; destructive items ask twice', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		GF.menuButton:Click()
		local items = {}
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then items[#items + 1] = r.Text:GetText() end end
		GF.menuButton:Click()
		menuPick("Lock window")
		menuPick("Transparent")
		local style = Polestar.Get("ui.style")
		local reset = menuPick("Reset guide progress")
		local armed = { label = reset.Text:GetText(), open = PolestarMenu:IsShown() }
		reset:Click()
		menuPick("Choose guide")
		local picker = PolestarPicker:IsShown()
		menuPick("Options")
		emit({ items = items, locked = Polestar.Get("ui.locked"), style = style, armed = armed, reset = lastCall("ResetProgress"),
			picker = picker, options = PolestarOptions:IsShown(), pickerAfter = PolestarPicker:IsShown() })`);
	assert.deepEqual(out.items, ['Choose guide', 'Open in new tab', 'Skip this step', 'Do every step', 'Report a problem', 'Compact mode', 'Transparent', 'Lock window',
		'Reset guide progress', 'Options', 'Hide window']);
	assert.equal(out.locked, true);
	assert.equal(out.style, 'transparent');
	assert.deepEqual(out.armed, { label: 'Click again to confirm', open: true });
	assert.deepEqual(out.reset, ['ResetProgress']);
	assert.equal(out.picker, true);
	assert.equal(out.options, true);
	assert.equal(out.pickerAfter, false, 'one dialog at a time');
});

// The catch-up (GUIDE_PLACED): the window shows each step before the one
// placed in turn, in full, then that one, whenever a guide is placed (launch,
// /reload, a guide opened); not for a single step. The Engine's step never
// moves.
test('the catch-up shows every step up to the one placed, each time a guide is placed; Do every step in the menu', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 4)
		local nav, Count = GF.parts.nav, GF.parts.nav.Steps.Count
		Polestar.Fire("GUIDE_PLACED", uistub.elwynn, 4, {})
		local rolling = { GF.catchingUp, GF.ShownStep() }
		stub.advance(0.6)
		GF.Render()
		local mid = { count = Count:GetText(), shown = GF.ShownStep(), engine = Polestar.Engine.GetStepIndex() }
		stub.advance(3)
		local done = { GF.catchingUp or false, Count:GetText(), GF.parts.card:GetAlpha(), GF.ShownStep() }
		Polestar.Fire("GUIDE_PLACED", uistub.elwynn, 4, {})
		local again = GF.catchingUp ~= nil
		stub.advance(3)
		Polestar.Fire("GUIDE_PLACED", uistub.elwynn, 2, {})
		local single = GF.catchingUp ~= nil
		menuPick("Do every step")
		emit({ rolling = rolling, mid = mid, done = done, again = again, single = single, set = lastCall("SetEveryStep") })`);
	assert.deepEqual(out.rolling, ['steps', 1], 'it starts on step 1');
	assert.ok(out.mid.shown >= 1 && out.mid.shown <= 3, `a step gone over is shown in full (${out.mid.shown})`);
	assert.equal(out.mid.count, `${out.mid.shown} / ${out.done[1].split(' / ')[1]}`);
	assert.equal(out.mid.engine, 4, 'the Engine stays on the step placed');
	assert.equal(out.done[0], false);
	assert.match(out.done[1], /^4 \/ \d+$/);
	assert.equal(out.done[2], 1);
	assert.equal(out.done[3], 4);
	assert.equal(out.again, true, 'placed again (a reload, the guide opened again): it goes over the steps again');
	assert.equal(out.single, false, 'a single step passed: nothing rolls');
	assert.deepEqual(out.set, ['SetEveryStep', 'forever/alliance/human/01-elwynn-forest', true]);
});

test('profession, reputation and achievement goals: own colours, icons, progress bars', () => {
	const [prof, repRows, rep] = run(`
		local function snapshot()
			local out = {}
			for _, r in ipairs(visibleRows()) do
				local b = r.psBar
				local bar = b and b:IsShown() and {
					label = b.Label:IsShown() and b.Label:GetText() or false,
					frac = b.Fill:GetWidth() / b.Track:GetWidth(),
				} or false
				local text = r.Text:GetText()
				out[#out + 1] = { t = r.psGoal.t, icon = r.Icon:GetTexture():match("([%w-]+)$"), text = text,
					progress = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):match("(%d+/%d+)$") or false, bar = bar, h = r:GetHeight() }
			end
			return out
		end
		uistub.setGuide(uistub.tailoring, 2)
		emit(snapshot())
		uistub.setGuide(uistub.stormwindRep, 2)
		emit(snapshot())
		local s = {}
		local hex = {}
		for _, k in ipairs({ "skill", "spell", "faction", "area", "achievement" }) do hex[k] = Polestar.Theme.Hex(k) end
		s.hex = hex
		stub.RunScript(rowFor("Stormwind"), "OnEnter")
		s.tip = GameTooltip.lines
		emit(s)`);
	const byT = (rows, t) => rows.filter((r) => r.t === t);
	const [untilRank, counted] = byT(prof, 'craft');
	assert.equal(untilRank.icon, 'icon-craft');
	assert.equal(untilRank.progress, false, 'a skill rank reads as a bar, not a bare number');
	assert.equal(untilRank.bar.label, 'Tailoring  38/50');
	assert.ok(Math.abs(untilRank.bar.frac - 38 / 50) < 0.01);
	assert.ok(untilRank.h > counted.h, 'the bar adds a line');
	assert.equal(counted.progress, '1/3');
	assert.equal(counted.bar, false);
	const [skill] = byT(prof, 'skill');
	assert.equal(skill.icon, 'icon-skill');
	assert.equal(skill.bar.label, '38/75');
	assert.match(untilRank.text, new RegExp(`^Craft \\|c${rep.hex.spell}Bolt of Linen Cloth\\|r$`), 'ranks count on their bar only');
	const [standing] = byT(repRows, 'rep');
	assert.equal(standing.icon, 'icon-rep');
	assert.equal(standing.bar.label, 'Friendly  2150/6000');
	const [achieve] = byT(repRows, 'achieve');
	assert.equal(achieve.progress, '3/5');
	assert.ok(Math.abs(achieve.bar.frac - 0.6) < 0.01);
	assert.ok(new Set(Object.values(rep.hex)).size === 5, 'each new subject kind has its own colour');
	assert.ok(rep.tip.includes('Reputation | Friendly  2150/6000  \u203A  Honored'));
});

test('XP pace from the QoL tracker: rate and time to level, hidden when off or maxed', () => {
	const [out] = run(`
		local stats = { rate = 3400, timeToLevel = 3900, maxed = false }
		Polestar.QoL = {
			GetXPStats = function() return stats end,
			Duration = function(s) return string.format("%dh %02dm", math.floor(s / 3600), math.floor(s % 3600 / 60)) end,
			XP = { Short = function(n) return string.format("%.1fk", n / 1000) end, Summary = function() return "Level 12 45.3%" end },
		}
		uistub.setGuide(uistub.elwynn, 3)
		local h0 = F:GetHeight()
		Polestar.Fire("QOL_XP_UPDATED", stats)
		local xp = GF.xp
		local on = { shown = xp:IsShown(), text = xp.Text:GetText(), taller = F:GetHeight() > h0 }
		stub.RunScript(xp, "OnEnter")
		local tip = GameTooltip.lines
		Polestar.Set("ui.compact", true)
		local compact = xp:IsShown()
		Polestar.Set("ui.compact", false)
		local back = xp:IsShown()
		stats.maxed = true
		Polestar.Fire("QOL_XP_UPDATED", stats)
		local maxed = xp:IsShown()
		Polestar.Fire("QOL_XP_UPDATED", nil)
		Polestar.QoL.GetXPStats = function() return nil end
		Polestar.Fire("QOL_XP_UPDATED", nil)
		emit({ on = on, tip = tip, compact = compact, back = back, maxed = maxed, off = xp:IsShown(), h = F:GetHeight() == h0 })`);
	assert.deepEqual(out.on, { shown: true, text: '3.4k XP/h  \u00b7  1h 05m to level', taller: true });
	assert.deepEqual(out.tip, ['Experience', 'Level 12 45.3%']);
	assert.equal(out.compact, false);
	assert.equal(out.back, true);
	assert.equal(out.maxed, false);
	assert.equal(out.off, false);
	assert.equal(out.h, true);
});

test('goal lines render the Engine text: author overrides and counts survive, the subject keeps its colour', () => {
	const [out] = run(`
		local UI = Polestar.UI
		local hex = Polestar.Theme.Hex("npc")
		emit({
			override = UI.GoalText({ t = "train", verb = "Train at", subject = "your trainer", subjectKind = "text", text = "Learn Charge and Rend", status = "active" }),
			count = UI.GoalText({ t = "kill", verb = "Kill", subject = "Young Wolf", subjectKind = "npc", text = "Kill 5 Young Wolf", status = "active" }),
			note = UI.GoalText({ t = "note", verb = "", subject = "Watch for patrols", subjectKind = "text", text = "Watch for patrols", status = "pending" }),
			plain = UI.GoalText({ t = "talk", verb = "Talk to", subject = "Brother Neals", subjectKind = "npc", status = "active" }),
			done = UI.GoalText({ t = "kill", verb = "Kill", subject = "Young Wolf", subjectKind = "npc", text = "Kill 5 Young Wolf", status = "done" }),
			hex = hex })`);
	assert.equal(out.override, 'Learn Charge and Rend');
	assert.equal(out.count, `Kill 5 |c${out.hex}Young Wolf|r`);
	assert.equal(out.note, 'Watch for patrols', 'no leading space on notes');
	assert.equal(out.plain, `Talk to |c${out.hex}Brother Neals|r`);
	assert.equal(out.done, 'Kill 5 Young Wolf');
});

test('a dismissed Nav target marks no row (no fall back to the Engine waypoint)', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local function marked()
			local n = 0
			for _, r in ipairs(visibleRows()) do if r.Mark:IsShown() then n = n + 1 end end
			return n
		end
		local before = marked()
		Polestar.Nav.GetTarget = function() return nil end
		Polestar.Fire("WAYPOINT_CHANGED", nil)
		emit({ before = before, after = marked() })`);
	assert.deepEqual(out, { before: 1, after: 0 });
});

test('combat state is read at login, so a /reload mid-fight still fades or hides the window', () => {
	const [out] = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()
			stub.inCombat = true
			Polestar.Set("ui.combat", "hide")
			stub.login()
			local hidden = not PolestarGuideFrame:IsShown()
			stub.inCombat = false
			stub.fire("PLAYER_REGEN_ENABLED")
			emit({ hidden = hidden, shown = PolestarGuideFrame:IsShown() })`,
	}).emitted;
	assert.deepEqual(out, { hidden: true, shown: true });
});

test('an unavailable quest stays readable but muted, says why, and drops its counters and arrow mark', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local g = uistub.goal(3, 3)
		g.status, g.unavailable, g.unavailableText = "skipped", "pre", "Needs The Demon Seed first"
		uistub.update()
		local r = rowFor("Kobold Vermin")
		local _, _, _, a = r.Text:GetTextColor()
		emit({ text = r.Text:GetText(), detail = r.Sub:GetText(), progress = false, mark = r.Mark:IsShown(),
			color = { r.Text:GetTextColor() }, muted = { Polestar.Theme.Color("textMuted") }, alpha = a,
			fallback = Polestar.UI.GoalDetail({ unavailable = "offer" }) })`);
	assert.equal(out.text, 'Kill Kobold Vermin', 'plain, no subject colour');
	assert.equal(out.detail, 'Needs The Demon Seed first');
	assert.equal(out.progress, false);
	assert.equal(out.mark, false);
	assert.deepEqual(out.color.slice(0, 3), out.muted.slice(0, 3));
	assert.equal(out.alpha, 1, 'muted colour, full opacity: still readable');
	assert.equal(out.fallback, 'Not offered');
});

test('a grey accept "Skip grey quests" keeps says which quest it opens, on its row and in its tooltip', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 4)
		local g = uistub.goal(4, 2)
		g.keptGrey, g.keptGreyText = 18, "Grey, kept: opens Brotherhood of Thieves"
		uistub.update()
		local r = rowFor("Investigate Echo Ridge")
		emit({ sub = r and r.Sub:GetText() or false, line = Polestar.UI.GoalSubline(g), detail = Polestar.UI.GoalDetail(g),
			plain = Polestar.UI.GoalSubline(uistub.goal(4, 4)) or false })`);
	assert.equal(out.line, 'Grey, kept: opens Brotherhood of Thieves');
	assert.equal(out.sub, out.line, 'shown under the goal in the window');
	assert.match(out.detail, /Grey, kept: opens Brotherhood of Thieves/);
	assert.doesNotMatch(String(out.plain), /Grey, kept/);
});

test('a farm-spot collect goal names its mobs, their levels and zone, and cycles to the next spot', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local g = uistub.goal(3, 4)
		g.npcName, g.lvl, g.alternatives, g.detail = "Young Wolf", { min = 2, max = 4 }, 2, nil
		g.candidates = { { npcName = "Young Wolf", map = 1429, x = 46, y = 38.5 }, { npcName = "Timber Wolf", map = 1429, x = 40, y = 60 } }
		uistub.update()
		local r = rowFor("Tough Wolf Meat")
		local before = { detail = r.Sub:GetText(), alt = r.Alt:IsShown(), progress = r.Text:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):match("(%d+/%d+)$") }
		local elsewhere = Polestar.UI.GoalSubline(r.psGoal, 1453)
		r.Alt:Click()
		emit({ before = before, call = lastCall("CycleCandidate"), elsewhere = elsewhere })`);
	assert.deepEqual(out.before, { detail: 'from Young Wolf (lvl 2\u20134)', alt: true, progress: '3/8' },
		'the zone is already named above the goals');
	assert.equal(out.elsewhere, 'from Young Wolf (lvl 2\u20134)  \u00b7  Elwynn Forest', 'a spot in another zone names it');
	assert.deepEqual(out.call, ['CycleCandidate', 3, 4]);
});

test('an area objective says its mobs are all over the area, and its row button moves to the next spot', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local g = uistub.goal(3, 3)
		g.spots, g.spread = 12, true
		uistub.update()
		local r = rowFor("Kobold Vermin")
		local before = { sub = r.Sub:GetText(), alt = r.Alt:IsShown() }
		stub.RunScript(r.Alt, "OnEnter")
		local tip = GameTooltip.lines
		r.Alt:Click()
		local collect = Polestar.UI.GoalSubline({ t = "collect", spots = 5, spread = true, status = "active" })
		local camp = Polestar.UI.GoalSubline({ t = "kill", subject = "Kobold Vermin", spots = 3, status = "active" })
		emit({ before = before, tip = tip, call = lastCall("CycleSpot"), collect = collect, camp = camp or false })`);
	assert.deepEqual(out.before, { sub: 'Kobold Vermin all over this area: 12 spots', alt: true });
	assert.ok(out.tip.includes('Next spot'), JSON.stringify(out.tip));
	assert.deepEqual(out.call, ['CycleSpot', 3, 3]);
	assert.equal(out.collect, 'Found all over this area: 5 spots');
	assert.equal(out.camp, false, 'a camp (not spread) says nothing extra');
});

// The Engine flags a quest started by an item (the collect stands for it,
// `starterOf`; the accept is `folded`) and a "Go to" that names the step
// (`header`). The window shows one line, the quest, saying how the item is
// got; the header stands for the Go to and carries the arrow's mark.
test('a quest started by a dropped item reads as one line, the quest; the Go to naming the step is the header', () => {
	const [out] = run(`
		local scroll = { item = "Runed Scroll", note = "Aean Swiftriver", source = { name = "Aean Swiftriver", kind = "npc", rank = 2, enemy = true } }
		local fog = { id = "t/fog", pack = "guides", title = "Southern Barrens", minLevel = 20, maxLevel = 30, steps = {
			{ title = "Field of Giants", goals = {
				{ t = "goto", verb = "Go to", subject = "Field of Giants", subjectKind = "place", text = "Go to Field of Giants", header = true, map = 1429, x = 44.7, y = 70.7, status = "active" },
				{ t = "collect", verb = "Collect", subject = "Runed Scroll", subjectKind = "item", item = 10621, note = "Aean Swiftriver", map = 1429, x = 46, y = 70, status = "active",
					starter = scroll, starterOf = 3, source = scroll.source, optional = true },
				{ t = "accept", verb = "Accept", subject = "The Runed Scroll", subjectKind = "quest", quest = 3513, item = 10621, note = "Keep it: Kadrak", folded = true, status = "active", optional = true },
			} },
		} }
		uistub.guides[fog.id] = fog
		uistub.setGuide(fog.id, 1)
		Polestar.Nav.SetTarget(1429, 44.7, 70.7, "Field of Giants")
		uistub.update()
		local rows = {}
		for _, r in ipairs(visibleRows()) do
			rows[#rows + 1] = { text = r.Text:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""), sub = r.Sub:GetText(), icon = r.Icon:GetTexture():match("([%w-]+)$"), index = r.psGoal.index }
		end
		local P = GF.parts
		local headerMark = P.person.Mark:IsShown()
		-- With the scroll in the bags the accept stands alone and says to right-click it.
		local g2, g3 = uistub.goal(1, 2), uistub.goal(1, 3)
		g2.status, g2.starter, g2.starterOf, g2.folded = "done", nil, nil, true
		g3.folded, g3.starter = nil, { item = "Runed Scroll", held = true }
		uistub.update()
		local held = {}
		for _, r in ipairs(visibleRows()) do held[#held + 1] = r.Sub:GetText() end
		emit({ rows = rows, header = P.person.Name:GetText(), headerMark = headerMark, held = held })`);
	assert.deepEqual(out.rows, [{ text: 'Accept The Runed Scroll  optional', sub: 'Runed Scroll: kill Aean Swiftriver (rare elite)  \u00b7  Keep it: Kadrak', icon: 'icon-accept', index: 2 }],
		'one row: the quest, worded as the accept and tagged optional, acting as the collect (index 2)');
	assert.equal(out.header, 'Field of Giants');
	assert.equal(out.headerMark, true, 'the arrow on the Go to marks the header');
	assert.deepEqual(out.held, ['Runed Scroll: in your bags, right-click it  \u00b7  Keep it: Kadrak']);
});

test('TRAIN_DUE shows a training banner after the out-levelled offer; Show points the arrow, Later dismisses', () => {
	const [out] = run(`
		uistub.openTabs(TABS, 1)
		local B = GF.parts.banner
		local trainer = { npc = 914, npcName = "Ander Germaine", map = 1453, x = 79.6, y = 70.2, z = 96.5 }
		Polestar.Fire("GUIDE_OUTLEVELED", uistub.elwynn, "forever/alliance/02-westfall")
		Polestar.Fire("TRAIN_DUE", 12, trainer)
		local first = B.Jump.Label:GetText()
		B.Close:Click()
		local second = { text = B.Text:GetText(), show = B.Jump.Label:GetText(), later = B.Later:IsShown(), close = B.Close:IsShown() }
		B.Jump:Click()
		local target = lastCall("SetTarget")
		local afterShow, aimed = B:IsShown(), { uistub.target.stop, uistub.target.z }
		Polestar.Fire("TRAIN_DUE", 14, trainer)
		B.Later:Click()
		emit({ first = first, second = second, target = target, aimed = aimed, afterShow = afterShow, afterLater = B:IsShown() })`);
	assert.equal(out.first, 'Jump to Westfall', 'the out-levelled offer goes first');
	assert.deepEqual(out.second, {
		text: 'Level 12  \u00b7  new Warrior skills  \u00b7  Ander Germaine, Stormwind City',
		show: 'Show', later: true, close: false,
	});
	assert.deepEqual(out.target, ['SetTarget', 1453, 79.6, 70.2, 'Ander Germaine']);
	assert.deepEqual(out.aimed, ['trainer', 96.5], 'the trainer\'s stop kind and height (#180)');
	assert.equal(out.afterShow, false);
	assert.equal(out.afterLater, false);
});

// The player's own word (owner feedback): an optional goal says so in the
// warning colour and skips in one click; Skip in the navigator skips the step
// with an undo in the banner; a skipped step shown later offers to unskip it;
// looking at another step than the live one offers the way back.
test('an optional goal is tagged in the warning colour and skips in one click, then reads skipped with an Undo', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local g = uistub.goal(3, 4)
		g.optional = true
		uistub.update()
		local r = rowFor("Tough Wolf Meat")
		local before = { text = r.Text:GetText(), skip = r.Skip:IsShown() and r.Skip.Label:GetText(), check = r.Check:IsShown() }
		r.Skip:Click()
		local call = lastCall("SkipGoal")
		r = rowFor("Tough Wolf Meat")
		local after = { text = r.Text:GetText(), skip = r.Skip:IsShown() and r.Skip.Label:GetText(), check = r.Check:IsShown(),
			icon = r.Icon:GetTexture():match("([%w-]+)$") }
		r.Skip:Click()
		emit({ warning = Polestar.Theme.Hex("warning"), muted = Polestar.Theme.Hex("textMuted"), before = before, call = call, after = after,
			back = rowFor("Tough Wolf Meat").psGoal.status })`);
	assert.ok(out.before.text.endsWith(`|c${out.warning}optional|r`), out.before.text);
	assert.equal(out.before.skip, 'Skip');
	assert.equal(out.before.check, true, 'it ticks like any goal');
	assert.deepEqual(out.call, ['SkipGoal', 3, 4]);
	assert.ok(out.after.text.endsWith(`|c${out.muted}skipped|r`), out.after.text);
	assert.deepEqual([out.after.skip, out.after.check, out.after.icon], ['Undo', false, 'skip']);
	assert.equal(out.back, 'active', 'Undo brings it back');
});

test('the current goal is the one the Engine names: past the required goals, an optional one leads before the area\'s Go to', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local g2, g4 = uistub.goal(3, 2), uistub.goal(3, 4)
		g2.status, g2.header = "active", true
		g4.optional = true
		uistub.goal(3, 3).status = "done"
		uistub.update()
		local accent = Polestar.Theme.Hex("accent")
		local function hex(t) local r, g, b = t:GetVertexColor(); return string.format("ff%02x%02x%02x", r * 255 + 0.5, g * 255 + 0.5, b * 255 + 0.5) end
		emit({ accent = accent, wolf = hex(rowFor("Tough Wolf Meat").Icon), kobold = hex(rowFor("Kobold Vermin").Icon) })`);
	assert.equal(out.wolf, out.accent, 'the optional wolf meat is current');
	assert.notEqual(out.kobold, out.accent);
});

test('Skip in the navigator skips the step shown, and the banner undoes it', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local N, B = GF.parts.nav, GF.parts.banner
		local shown = { N.Skip:IsShown(), N.Skip.Label:GetText() }
		N.Skip:Click()
		local skipped = { lastCall("Skip"), Polestar.Engine.GetStepIndex(), B:IsShown(), B.Text:GetText(), B.Jump.Label:GetText() }
		B.Jump:Click()
		emit({ shown = shown, skipped = skipped, undo = lastCall("Unskip"), at = Polestar.Engine.GetStepIndex(), banner = B:IsShown() })`);
	assert.deepEqual(out.shown, [true, 'Skip']);
	assert.deepEqual(out.skipped, [['Skip'], 4, true, 'Skipped Step 3  \u00b7  Kobold Camp', 'Undo']);
	assert.deepEqual(out.undo, ['Unskip', 3]);
	assert.equal(out.at, 3);
	assert.equal(out.banner, false);
});

test('looking at another step than the live one offers the way back; a skipped step offers to unskip it', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local N, B = GF.parts.nav, GF.parts.banner
		uistub.live = 3
		N.Next:Click()
		local ahead = { B:IsShown(), B.Text:GetText(), B.Jump.Label:GetText() }
		B.Jump:Click()
		local back = lastCall("Goto")
		uistub.live = 4
		uistub.skipped[3] = true
		uistub.setStep(3)
		local skipped = { B.Text:GetText(), B.Jump.Label:GetText(), N.Skip:IsEnabled() }
		B.Jump:Click()
		emit({ ahead = ahead, back = back, skipped = skipped, unskip = lastCall("Unskip") })`);
	assert.deepEqual(out.ahead, [true, 'Looking ahead. The guide is at step 3.', 'Back to step 3']);
	assert.deepEqual(out.back, ['Goto', 3]);
	assert.deepEqual(out.skipped, ['You skipped this step.', 'Unskip it', false]);
	assert.deepEqual(out.unskip, ['Unskip', 3]);
});

test('the next spot of an area objective takes the arrow there, over a point picked by hand', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local g = uistub.goal(3, 3)
		g.spots, g.spread = 12, true
		uistub.update()
		Polestar.Nav.SetTarget(1429, 50, 50, "By hand")
		rowFor("Kobold Vermin").Alt:Click()
		emit({ cycle = lastCall("CycleSpot"), release = lastCall("ReleaseTarget"), target = Polestar.Nav.GetTarget().label })`);
	assert.deepEqual(out.cycle, ['CycleSpot', 3, 3]);
	assert.deepEqual(out.release, ['ReleaseTarget']);
	assert.notEqual(out.target, 'By hand');
});

test('labels kept in tables are in the client language: the group line and the guide menu\'s tabs', () => {
	const [out] = run(
		`
		UI.ShowPicker()
		local tabs = {}
		for _, b in ipairs(PolestarPicker.tabButtons) do if b:IsShown() then tabs[#tabs + 1] = b.Label:GetText() end end
		emit({ elite = UI.GroupLine({ party = { kind = "elite", rank = 2 } }), tabs = tabs, title = PolestarPicker.Title:GetText() })`,
		{ before: fakeLocale('itIT', { 'Rare elite: group advised': 'Rarer Elite: Gruppe empfohlen', Home: 'Start', Browse: 'Stöbern', Current: 'Aktuell', Recent: 'Zuletzt' }) },
	);
	assert.match(out.elite, /\|c\w+Rarer Elite: Gruppe empfohlen\|r/);
	assert.deepEqual(out.tabs, ['Start', 'Stöbern', 'Aktuell', 'Zuletzt']);
	assert.equal(out.title, 'Start');
});

test('a collect whose line already names its source has no source line under it; author text keeps it', () => {
	const [out] = run(`
		local src = { name = "Grell", also = "Grellkin", kind = "npc", enemy = true }
		local named = { t = "collect", text = "Kill Grell or Grellkin for Fel Moss", subject = "Fel Moss", status = "active", source = setmetatable({ inText = true }, { __index = src }) }
		local authored = { t = "collect", text = "Get the moss", subject = "Fel Moss", status = "active", source = src }
		emit({ named = UI.GoalSubline(named) or false, authored = UI.GoalSubline(authored) or false })`);
	assert.equal(out.named, false);
	assert.equal(out.authored, 'Kill Grell or Grellkin');
});

test('a quest to complete with several objectives lists the open ones under it, before its note', () => {
	const [out] = run(`
		local goal = { t = "complete", quest = 747, status = "active", progress = { cur = 3, max = 14, kind = "count" },
			objectives = { "Plainstrider Meat: 3/7", "Plainstrider Feathers: 0/7" }, note = "Plainstriders roam the grass" }
		emit({ sub = UI.GoalSubline(goal), count = UI.GoalProgress(goal) })`);
	assert.equal(out.sub, 'Plainstrider Meat: 3/7  \u00b7  Plainstrider Feathers: 0/7  \u00b7  Plainstriders roam the grass');
	assert.equal(out.count, '3/14');
});
