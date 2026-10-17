'use strict';
// Talent plans (addon/Polestar/Talents): the plans in Builds.lua replayed
// under the snapshot's rules, plan progress (T.State: points from the
// tree's currency, the level only as a fallback), the snapshot checked
// against the live tree (moved IDs found by name, a missing talent makes the
// plan out of date), the marks on the talent frame (next ring while a point
// waits, pick numbers, off-plan flags, the tooltip line; no levels; nothing
// while inspecting, for another loadout or in combat until it ends), the
// reminder and the hub section (client names on every tab). The client is tests/lua/stub_talents.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const CORE = ['Core/Core.xml', 'Theme/Theme.xml', 'Talents/Talents.xml'];
const WITH_UI = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml', 'Talents/Talents.xml'];

const PRELUDE = `
local T, TS = Polestar.Talents, stub.talents
local data = T.Data("PALADIN")
TS.useSnapshot(data)
local function plan(key) return T.BuildByKey(data, key) end
`;

function run(script, { files = CORE, stubs = [] } = {}) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_talents.lua', ...stubs],
		addons: [{ name: 'Polestar', files }],
		script: `${PRELUDE}\n${script}`,
	}).emitted;
}

// ------------------------------------------------------------ the plans

test('Builds.lua: three Paladin plans, 51 picks each, every one legal under the snapshot', () => {
	const [out] = run(`
local o = { prereq = data.prereq, tree = data.tree, specs = data.specs, plans = {} }
for _, b in ipairs(data.builds) do
	o.plans[#o.plans + 1] = { key = b.key, spec = b.specName, picks = #b.picks, first = b.picks[1].order, last = b.picks[#b.picks].order, level = b.picks[1].level, errors = T.Replay(data, b) }
end
emit(o)`);
	assert.equal(out.tree, 1100);
	assert.equal(out.prereq, 'full', 'arrows need full rank until checked in game');
	assert.deepEqual(out.specs, ['Holy', 'Protection', 'Retribution']);
	for (const p of out.plans) {
		assert.equal(p.picks, 51, p.key);
		assert.equal(p.first, 1);
		assert.equal(p.last, 51);
		assert.equal(p.level, undefined, 'picks carry an order, not a level');
		assert.equal(Object.keys(p.errors).length, 0, `${p.key}: ${JSON.stringify(p.errors)}`);
	}
});

test('Replay: of several arrows into one talent, any one opens it', () => {
	const [ok, none] = run(`
local d = { prereq = "full", groups = {}, gates = {}, edges = { { 1, 3 }, { 2, 3 } }, nodes = {
	[1] = { name = "Bestial Swiftness", max = 1 }, [2] = { name = "Bestial Wrath", max = 1 }, [3] = { name = "Intimidation", max = 1 } } }
emit(#T.Replay(d, { key = "k", picks = { { order = 1, node = 1, rank = 1 }, { order = 2, node = 3, rank = 1 } } }))
emit(T.Replay(d, { key = "k", picks = { { order = 1, node = 3, rank = 1 } } })[1])`);
	assert.equal(ok, 0);
	assert.match(none, /needs Bestial Swiftness or Bestial Wrath/);
});

// Every class's plans in Builds.lua: three specs, 51 picks each, legal under the snapshot.
const CLASS_SPECS = {
	DRUID: ['Balance', 'Feral Combat', 'Restoration'],
	MAGE: ['Arcane', 'Fire', 'Frost'],
	PALADIN: ['Holy', 'Protection', 'Retribution'],
	ROGUE: ['Assassination', 'Combat', 'Subtlety'],
	SHAMAN: ['Elemental', 'Enhancement', 'Restoration'],
	WARLOCK: ['Affliction', 'Demonology', 'Destruction'],
	WARRIOR: ['Arms', 'Fury', 'Protection'],
};

test('Builds.lua: every class has a plan per spec, 51 picks each, every one legal under the snapshot', () => {
	const [out] = run(`
local o = {}
for _, cls in ipairs({ ${Object.keys(CLASS_SPECS).map((c) => `"${c}"`).join(', ')} }) do
	local d = T.Data(cls)
	local c = { specs = d and d.specs, plans = {} }
	for _, b in ipairs(d and d.builds or {}) do
		c.plans[#c.plans + 1] = { key = b.key, spec = b.specName, picks = #b.picks, errors = T.Replay(d, b) }
	end
	o[cls] = c
end
emit(o)`);
	for (const [cls, specs] of Object.entries(CLASS_SPECS)) {
		assert.deepEqual(out[cls].specs, specs, cls);
		assert.deepEqual(out[cls].plans.map((p) => p.spec), specs, `${cls}: one plan per spec, in order`);
		for (const p of out[cls].plans) {
			assert.equal(p.picks, 51, `${cls} ${p.key}`);
			assert.equal(Object.keys(p.errors).length, 0, `${cls} ${p.key}: ${JSON.stringify(p.errors)}`);
		}
	}
});

test('Replay: a skipped arrow, an early tier and a skipped rank are caught; "started" relaxes arrows', () => {
	const [out, started] = run(`
local ret = plan("retribution")
local function copy(b, edit)
	local c = { key = b.key, picks = {} }
	for i, p in ipairs(b.picks) do c.picks[i] = { order = p.order, node = p.node, rank = p.rank } end
	edit(c.picks)
	return c
end
-- Vengeance needs Sanctified Judgement (an arrow): drop that pick's ranks.
local arrow
for _, e in ipairs(data.edges) do if data.nodes[e[2]].name == "Vengeance" then arrow = e end end
local fromNode = arrow[1]
local broken = copy(ret, function(p)
	local first
	for i, x in ipairs(p) do if x.node == fromNode and x.rank == data.nodes[fromNode].max then first = i end end
	p[first] = { order = p[first].order, node = p[1].node, rank = 99 }
end)
local early = copy(ret, function(p) p[1], p[25] = p[25], p[1]; p[1].order, p[25].order = 1, 25 end)
local errs = T.Replay(data, broken)
local arrowErr = false
for _, e in ipairs(errs) do if e:find("needs " .. data.nodes[fromNode].name, 1, true) then arrowErr = true end end
emit({ arrowErr = arrowErr, rankErr = errs[1] ~= nil, early = #T.Replay(data, early) > 0 })
data.prereq = "started"
emit(#T.Replay(data, ret))`);
	assert.ok(out.rankErr);
	assert.ok(out.arrowErr, 'the arrow into Vengeance');
	assert.ok(out.early, 'a deep talent first');
	assert.equal(started, 0, 'the plans also hold if one rank opens an arrow');
});

// ------------------------------------------------------------ progress

test('State: next pick, unspent points, off-plan ranks, complete; the level is only a fallback', () => {
	const outs = run(`
local b = plan("retribution")
local function at(n, level, granted, extra)
	local ranks = {}
	for i = 1, n do ranks[b.picks[i].node] = b.picks[i].rank end
	for id, r in pairs(extra or {}) do ranks[id] = r end
	local s = T.State(b, ranks, level, granted)
	return { status = s.status, done = s.done, unspent = s.unspent, nextOrder = s.next and s.next.order, source = s.source, off = next(s.offPlan) ~= nil }
end
emit(at(0, 5))
emit(at(10, 20))
emit(at(11, 20))
emit(at(21, 31))
local holy = plan("holy").picks[1].node
emit(at(11, 20, nil, { [holy] = 5 }))
emit(at(51, 60))
emit(at(0, 5, 1))
emit(at(10, 15, 20))
emit(at(21, 30, 22))
emit(at(21, 30, 21))`);
	assert.equal(outs[0].status, 'early');
	assert.deepEqual([outs[1].status, outs[1].unspent, outs[1].nextOrder, outs[1].source], ['behind', 1, 11, 'level']);
	assert.deepEqual([outs[2].status, outs[2].unspent, outs[2].nextOrder], ['onplan', 0, 12]);
	assert.deepEqual([outs[3].status, outs[3].unspent], ['behind', 1]);
	assert.equal(outs[4].status, 'offplan');
	assert.equal(outs[5].status, 'complete');
	assert.deepEqual([outs[6].status, outs[6].unspent, outs[6].source], ['behind', 1, 'currency'], 'a point at level 5 (Talented): no longer "early"');
	assert.deepEqual([outs[7].status, outs[7].unspent, outs[7].nextOrder], ['behind', 10, 11], 'granted points, not the level, give the unspent count');
	assert.deepEqual([outs[8].status, outs[8].unspent, outs[8].nextOrder], ['behind', 1, 22], 'at the level cap a granted point is still a point');
	assert.deepEqual([outs[9].status, outs[9].unspent], ['onplan', 0]);
});

test('Current: unspent points come from the tree currency (early points), else from the level', () => {
	const outs = run(`
local b = plan("retribution")
local function state()
	local c = T.Refresh()
	local s = c.state
	return { status = s.status, unspent = s.unspent, points = s.points, source = s.source, staged = c.staged.unspent }
end
-- Talented (Adventure): level 14 with 11 points granted, 10 spent.
TS.level = 14
TS.learn(b, 10)
TS.currency = { quantity = 1, spent = 10 }
stub.login()
emit(state())
-- A point staged in the frame uses it up.
TS.staged[b.picks[11].node] = b.picks[11].rank
emit(state())
TS.staged = {}
-- No currency from the client: one point a level from 10.
TS.currency = nil
emit(state())
TS.level = 20
emit(state())
-- No API at all.
local api = C_Traits.GetTreeCurrencyInfo
C_Traits.GetTreeCurrencyInfo = nil
emit(state())
C_Traits.GetTreeCurrencyInfo = api`);
	assert.deepEqual(outs[0], { status: 'behind', unspent: 1, points: 11, source: 'currency', staged: 1 });
	assert.deepEqual([outs[1].unspent, outs[1].staged], [1, 0]);
	assert.deepEqual(outs[2], { status: 'onplan', unspent: 0, points: 10, source: 'level', staged: 0 }, 'fallback: level 14 is 5 points, all spent');
	assert.deepEqual(outs[3], { status: 'behind', unspent: 1, points: 11, source: 'level', staged: 1 });
	assert.deepEqual(outs[4], outs[3], 'missing API falls back the same way');
});

// ------------------------------------------------------------ the live tree

test('Validate: a moved node is found by spell and rank count; a missing one makes the plan out of date', () => {
	const outs = run(`
local soc
for id, n in pairs(data.nodes) do if n.name == "Seal of Command" then soc = id end end
TS.nodes[soc + 90000], TS.nodes[soc] = TS.nodes[soc], nil
local v = T.Validate(data, T.Read(data))
emit({ ok = v.ok, moved = v.moved, to = v.map[soc] == soc + 90000 })
TS.nodes[soc + 90000] = nil
v = T.Validate(data, T.Read(data))
emit({ ok = v.ok, missing = v.missing })
stub.login()
local c, why = T.Current()
emit({ why = why, state = c.state ~= nil })`);
	assert.deepEqual(outs[0], { ok: true, moved: 1, to: true });
	assert.deepEqual(outs[1], { ok: false, missing: ['Seal of Command'] });
	assert.deepEqual(outs[2], { why: 'stale', state: false }, 'no guessing: no state, no marks');
});

test('Validate: a non-English client matches by spell ID and shows its own names', () => {
	const outs = run(`
for id, n in pairs(TS.nodes) do n.name = "es:" .. n.name end
local soc
for id, n in pairs(data.nodes) do if n.name == "Seal of Command" then soc = id end end
TS.nodes[soc + 90000], TS.nodes[soc] = TS.nodes[soc], nil
local b = plan("retribution")
TS.learn(b, 20)
stub.login()
local c, why = T.Current()
emit({ why = why, ok = c.valid.ok, moved = c.valid.moved, missing = #c.valid.missing, next = T.PickText(c.data, c.state.next, c.valid), soc = T.NodeName(c.data, soc, c.valid) })`);
	assert.deepEqual(outs[0], { ok: true, moved: 1, missing: 0, next: 'es:Seal of Command 1/1', soc: 'es:Seal of Command' });
});

test('ActiveBuild: the chosen plan, else the spec with the most points; Choose("auto") follows again', () => {
	const outs = run(`
TS.learn(plan("protection"), 12)
stub.login()
emit(T.Current().build.key)
T.Choose("holy")
emit({ key = T.Current().build.key, choice = T.Choice() })
T.Choose("auto")
emit(T.Current().build.key)`);
	assert.equal(outs[0], 'protection');
	assert.deepEqual(outs[1], { key: 'holy', choice: 'holy' });
	assert.equal(outs[2], 'protection');
});

// ------------------------------------------------------------ the talent frame

const FRAME = `
local b = plan("retribution")
TS.learn(b, 20) -- level 30 with one point unspent: next is pick 21 (level 30)
stub.login()
local f = TS.openFrame()
stub.addonLoaded("Blizzard_PlayerSpells")
stub.runTimers()
local O = T.Overlay
local function markOf(id) return O.marks[TS.button(id)] end
local function view()
	local s = T.Current().staged
	local nxt = s.next.node
	local m = markOf(nxt)
	local shownMarks = 0
	for _, x in pairs(O.marks) do if x:IsShown() then shownMarks = shownMarks + 1 end end
	return { ring = m and m:IsShown() and m.Ring:IsShown() or false, badge = m and m.Badge.Text:GetText(), marks = shownMarks }
end
`;

test('Overlay: a ring on the next pick while a point waits, its pick number as a badge, a flag off the plan; staged ranks move the ring', () => {
	const outs = run(`${FRAME}
emit(view())
TS.currency = { quantity = 2, spent = 20 }
T.Refresh()
stub.runTimers()
local nxt = T.Current().staged.next
-- Stage the next pick in the frame (not applied yet).
TS.staged[nxt.node] = nxt.rank
EventRegistry:TriggerEvent("TalentFrameBase.ButtonsUpdated")
stub.fire("TRAIT_NODE_CHANGED", nxt.node)
stub.runTimers()
stub.runTimers()
local after = view()
after.moved = T.Current().staged.next ~= nxt
emit(after)
-- Both points staged: nothing left to spend, no ring.
local second = T.Current().staged.next
TS.staged[second.node] = second.rank
T.Refresh()
stub.runTimers()
emit(view())
-- A point outside the plan.
local holy = plan("holy").picks[1].node
TS.ranks[holy] = 1
stub.fire("TRAIT_CONFIG_UPDATED", 7)
stub.runTimers()
stub.runTimers()
local m = markOf(holy)
emit({ flag = m and m:IsShown() and m.Flag:IsShown() or false })`, { stubs: [] });
	assert.equal(outs[0].ring, true);
	assert.equal(outs[0].badge, '21', 'pick #21, not level 30');
	assert.ok(outs[0].marks > 1, 'every planned talent with a rank to come has a badge');
	assert.equal(outs[1].moved, true);
	assert.equal(outs[1].ring, true, 'the ring is on the new next pick');
	assert.equal(outs[2].ring, false, 'no point left: no ring');
	assert.equal(outs[3].flag, true);
});

// The gamepad interface hooks CreateFrame and, for a parent inside the open
// talent frame, rebuilds its buttons in the caller's code: from Polestar's,
// the talent frame's next gamepad action is blocked. wow_stub.lua's
// CreateFrame lists those calls in stub.underGameFrames.
test('Overlay: a mark and its ring and badge are made with no parent, then set under the talent button, so the gamepad interface never rebuilds the talent frame\'s buttons in Polestar\'s code', () => {
	const [out] = run(`${FRAME}
local on = 0
for button, m in pairs(O.marks) do
	if m:GetParent() == button and m.Ring:GetParent() == m and m.Badge:GetParent() == m then on = on + 1 end
end
emit({ marks = view().marks, on = on, under = table.concat(stub.underGameFrames, "; ") })`);
	assert.ok(out.marks > 1, 'the planned talents are marked');
	assert.ok(out.on >= out.marks, 'every mark hangs off its button, its ring and badge off the mark');
	assert.equal(out.under, '', 'no CreateFrame names a game frame as parent');
});

test('Overlay: no level labels and nothing muted at the level cap; badges and tooltips give pick numbers', () => {
	const outs = run(`${FRAME}
-- Early points: level 30 is the cap, yet the game has given a 22nd point.
TS.learn(b, 21)
TS.currency = { quantity = 1, spent = 21 }
T.Refresh()
stub.runTimers()
local s = T.Current().staged
local nxt = markOf(s.next.node)
local later
for _, p in ipairs(b.picks) do if p.order > s.next.order and s.nodeNext[p.node] == p then later = p break end end
local badges, muted = {}, 0
local mr, mg, mb = Polestar.Theme.Color("textMuted")
for id, m in pairs(O.marks) do
	if m:IsShown() and m.Badge:IsShown() then
		badges[#badges + 1] = m.Badge.Text:GetText()
		local r, g, bl = m.Badge.Text:GetTextColor()
		if r == mr and g == mg and bl == mb then muted = muted + 1 end
	end
end
emit({ ring = nxt:IsShown() and nxt.Ring:IsShown(), badge = nxt.Badge.Text:GetText(), badges = badges, muted = muted, projected = T.Projected ~= nil, status = s.status })
local btn = TS.button(s.next.node)
GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
stub.RunScript(btn, "OnEnter")
emit(GameTooltip.lines)
local other = TS.button(later.node)
GameTooltip:SetOwner(other, "ANCHOR_RIGHT")
stub.RunScript(other, "OnEnter")
emit({ lines = GameTooltip.lines, order = later.order })
Polestar.Set("talents.tooltip", false)
GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
stub.RunScript(btn, "OnEnter")
emit(#GameTooltip.lines)`);
	assert.deepEqual([outs[0].ring, outs[0].badge, outs[0].status, outs[0].projected], [true, '22', 'behind', false], 'the point at the cap is highlighted');
	for (const t of outs[0].badges) assert.match(t, /^\d+$/);
	assert.equal(outs[0].muted, 0, 'no badge muted as "past the cap"');
	assert.equal(outs[1].length, 1);
	assert.match(outs[1][0], /^Polestar: pick #22, rank \d\/\d \(Retribution plan\)  next$/);
	assert.equal(outs[2].lines[0], outs[2].lines[0].replace(/level|cap/gi, ''), 'no level or cap wording');
	assert.match(outs[2].lines[0], new RegExp(`^Polestar: pick #${outs[2].order}, rank \\d/\\d \\(Retribution plan\\)$`));
	assert.equal(outs[3], 0);
});

test('Overlay: nothing while inspecting or for another loadout; combat defers the redraw', () => {
	const outs = run(`${FRAME}
TS.inspecting = true
EventRegistry:TriggerEvent("TalentFrameBase.ConfigUpdated")
stub.runTimers()
emit(view().marks)
TS.inspecting = nil
TS.frameConfig = 99
EventRegistry:TriggerEvent("TalentFrameBase.ConfigUpdated")
stub.runTimers()
emit(view().marks)
TS.frameConfig = nil
stub.inCombat = true
EventRegistry:TriggerEvent("TalentFrameBase.ConfigUpdated")
stub.runTimers()
emit(view().marks)
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
stub.runTimers()
emit(view().marks)
-- Marks up, then inspecting someone mid-fight.
stub.inCombat = true
TS.inspecting = true
EventRegistry:TriggerEvent("TalentFrameBase.ConfigUpdated")
stub.runTimers()
emit(view().marks)
TS.inspecting = nil
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
stub.runTimers()
emit(view().marks)`);
	assert.equal(outs[0], 0, 'inspecting');
	assert.equal(outs[1], 0, 'another loadout');
	assert.equal(outs[2], 0, 'still hidden: the redraw waits for combat to end');
	assert.ok(outs[3] > 0, 'drawn after combat');
	assert.equal(outs[4], 0, 'marks come down when the frame changes in combat');
	assert.ok(outs[5] > 0, 'and come back after combat');
});

// ------------------------------------------------------------ reminder

test('Reminder: a chat line when a point waits, from the currency even below the old schedule; none when switched off', () => {
	const outs = run(`
local b = plan("retribution")
TS.learn(b, 10)
TS.level = 20
stub.login()
stub.messages = {}
stub.fire("PLAYER_LEVEL_UP", 20)
stub.advance(2)
emit(stub.messages)
-- Talented: level 14, 11 points granted, 10 spent.
TS.level = 14
TS.currency = { quantity = 1, spent = 10 }
stub.messages = {}
stub.fire("PLAYER_LEVEL_UP", 14)
stub.advance(2)
emit(stub.messages)
-- At the level cap with a point granted.
TS.learn(b, 21)
TS.level, TS.cap = 30, 30
TS.currency = { quantity = 1, spent = 21 }
stub.messages = {}
stub.fire("PLAYER_LEVEL_UP", 30)
stub.advance(2)
emit(#stub.messages)
-- Nothing granted: nothing to say.
TS.currency = { quantity = 0, spent = 21 }
stub.messages = {}
stub.fire("PLAYER_LEVEL_UP", 30)
stub.advance(2)
emit(#stub.messages)
TS.currency = { quantity = 1, spent = 21 }
Polestar.Set("talents.reminder", false)
stub.messages = {}
stub.fire("PLAYER_LEVEL_UP", 30)
stub.advance(2)
emit(#stub.messages)`);
	assert.equal(outs[0].length, 1);
	assert.match(outs[0][0], /Talent point: Seal of Command 1\/1 \(Retribution plan\)\./);
	assert.equal(outs[1].length, 1, 'an early point is reminded');
	assert.match(outs[1][0], /Talent point: Seal of Command 1\/1/);
	assert.equal(outs[2], 1, 'not muted at the level cap');
	assert.equal(outs[3], 0);
	assert.equal(outs[4], 0);
});

// ------------------------------------------------------------ the hub section

test('View: the Talents section lists the followed plan with its status, tabs per spec, follow buttons', () => {
	const outs = run(`
local b = plan("retribution")
TS.learn(b, 20)
uistub = uistub
stub.login()
local TV = Polestar.UI.TalentsSection
TV.Show()
local s = TV.Shown()
local approx, exact = 0, 0
for _, n in ipairs(s.notes) do
	if n:find("^Around level %d+: ") then approx = approx + 1 end
	if n:find("^Level %d+") or n:find("[Bb]y %d%d ") or n:find(" at %d%d ") then exact = exact + 1 end
end
emit({ rows = s.rows, spec = s.spec, mine = s.mine, status = s.status, follow = s.follow, auto = s.auto, notes = #s.notes, first = s.notes[1], noteLevels = approx, exactLevels = exact })
local nav, active = TV.Nav()
local labels = {}
for _, n in ipairs(nav) do labels[#labels + 1] = n.label end
emit({ labels = labels, active = active })
TV.SetTab("1")
s = TV.Shown()
emit({ spec = s.spec, mine = s.mine, status = s.status, follow = s.follow })
TV.Follow()
emit({ choice = T.Choice(), followed = TV.Shown().followed })
TV.FollowSpec()
emit(T.Choice())`, { files: WITH_UI, stubs: ['stub_ui.lua'] });
	assert.deepEqual(outs[0], { rows: 51, spec: 'Retribution', mine: true, status: 'behind', follow: true, auto: false, notes: outs[0].notes, first: outs[0].first, noteLevels: outs[0].noteLevels, exactLevels: outs[0].exactLevels });
	assert.match(outs[0].first, /^1 point to spend\. Next: Vengeance 1\/3\.$/, 'one point: the talent, not the count');
	assert.ok(outs[0].notes >= 10, 'status, summary, the plan notes and the source');
	assert.ok(outs[0].noteLevels > 0, 'plan notes give approximate levels');
	assert.equal(outs[0].exactLevels, 0, 'no exact "Level N:" labels');
	assert.deepEqual(outs[1], { labels: ['Holy', 'Protection', 'Retribution'], active: '3' });
	assert.deepEqual(outs[2], { spec: 'Holy', mine: false, status: 'other', follow: true });
	assert.deepEqual(outs[3], { choice: 'holy', followed: 'Holy' });
	assert.equal(outs[4], 'auto');
});

test('View: every spec tab shows the client\'s talent names, not only the followed plan', () => {
	const outs = run(`
for id, n in pairs(TS.nodes) do n.name = "es:" .. n.name end
TS.learn(plan("retribution"), 20)
stub.login()
local TV = Polestar.UI.TalentsSection
TV.Show()
local function english()
	local n = 0
	for _, t in ipairs(TV.Shown().titles) do if not t:find("^es:") then n = n + 1 end end
	return { rows = TV.Shown().rows, mine = TV.Shown().mine, english = n }
end
emit(english())
TV.SetTab("1")
emit(english())
TV.SetTab("2")
emit(english())`, { files: WITH_UI, stubs: ['stub_ui.lua'] });
	assert.deepEqual(outs[0], { rows: 51, mine: true, english: 0 });
	assert.deepEqual(outs[1], { rows: 51, mine: false, english: 0 }, 'Holy tab');
	assert.deepEqual(outs[2], { rows: 51, mine: false, english: 0 }, 'Protection tab');
});

test('View: another class sees why there is no plan', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua', 'stub_talents.lua', 'stub_ui.lua'],
		before: 'stub.talents.class, stub.talents.className = "DEATHKNIGHT", "Death Knight"',
		addons: [{ name: 'Polestar', files: WITH_UI }],
		login: true,
		script: 'Polestar.UI.TalentsSection.Show(); emit(Polestar.UI.TalentsSection.Shown().empty)',
	}).emitted;
	assert.equal(out, 'class');
});
