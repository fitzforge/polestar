'use strict';
// Quality of Life (addon/Polestar/QoL): action buttons and their combat
// deferral, XP pace and splits, merchant, quest rewards, flight masters,
// Hearthstone, death helper, questing toggles and the options page.
// Runs the real Core/Init.lua + Compat + Theme + QoL against tests/lua/stub_qol.lua
// (fake Engine, Nav and Pins; secure frames refuse changes in combat).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };

const PRELUDE = `
local q = stub.qol
local QoL = Polestar.QoL
local function set(k, v) Polestar.Set("qol." .. k, v); stub.runTimers() end
local function calls(name)
	local out = {}
	for _, c in ipairs(q.calls) do if c[1] == name then out[#out + 1] = c[2] or true end end
	return out
end
local function printed(pattern)
	for _, m in ipairs(stub.messages) do if m:find(pattern) then return true end end
	return false
end
`;

function run(script, opts = {}) {
	return runAddon({
		stubs: ['stub_qol.lua'],
		addons: [FILES],
		before: opts.before,
		saved: opts.saved,
		login: true,
		script: PRELUDE + script,
	}).emitted;
}

// ---------------------------------------------------------------------------
// Options
// ---------------------------------------------------------------------------

test('options: every qol setting is registered, on Questing or Quality of Life, with label and help', () => {
	const [specs, defaults] = run(`
		local out = {}
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			if spec.page == "Quality of Life" or spec.page == "Questing" then
				for _, c in ipairs(spec.controls) do
					out[#out + 1] = { key = c.key, kind = c.kind, command = c.command, label = c.label, help = c.help, page = spec.page, tab = spec.tab, section = spec.section }
				end
			end
		end
		emit(out)
		local keys = {}
		for _, k in ipairs({ "itemButton", "targetButton", "hearthButton", "buttonScale", "xpTracker", "sellJunk", "autoRepair",
			"rewardHighlight", "rewardAutoPick", "flightAutoOpen", "flightHighlight", "deathHelper", "instantQuestText",
			"skipGossip", "fastLoot", "declineDuels", "repairGuild", "hideErrors", "autoReleasePvP", "declineGuildInvites",
			"declinePartyStrangers", "acceptPartyFriends", "acceptSummon", "acceptResurrect" }) do keys[k] = Polestar.GetDefault("qol." .. k) end
		emit(keys)
	`);
	const registered = new Set(specs.filter((c) => c.key).map((c) => c.key.replace(/^qol\./, '')));
	for (const key of Object.keys(defaults)) assert.ok(registered.has(key), `qol.${key} registered`);
	for (const c of specs) {
		assert.ok(c.label && c.help, `${c.key || c.label} has label and help`);
		assert.ok(c.page === 'Questing' || c.page === 'Quality of Life');
		assert.ok(c.tab && c.section);
	}
	// The key binding rows set the buttons' own bindings (Bindings.xml).
	const xml = fs.readFileSync(path.join(__dirname, '..', 'addon', 'Polestar', 'Bindings.xml'), 'utf8');
	const binds = specs.filter((c) => c.kind === 'keybind');
	assert.equal(binds.length, 3);
	for (const c of binds) assert.ok(xml.includes(`<Binding name="${c.command}"`), `${c.command} is in Bindings.xml`);
	assert.equal(defaults.rewardAutoPick, false, 'auto-pick is off by default');
	assert.equal(defaults.sellJunk, true);
});

// ---------------------------------------------------------------------------
// Quest item, Hearthstone and target buttons
// ---------------------------------------------------------------------------

test('quest item button: the current use goal item, else a quest log item, else a usable quest item in the bags', () => {
	const out = run(`
		local b = PolestarQuestItemButton
		q.items[900] = { name = "Torch", classID = 12, spell = 11 }
		q.items[901] = { name = "Quest Wand", classID = 12 }
		q.items[902] = { name = "Bag Quest Thing", classID = 12, spell = 12 }
		q.addItem(0, 1, 900, 2)
		q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 }, { t = "use", item = 900, quest = 7, oi = 1 } })
		emit({ b:GetAttribute("type"), b:GetAttribute("item"), b:IsShown(), b.Count:GetText() })

		-- the use goal is done: the step's other quest has a log item
		q.specialItems[5] = 901
		q.addItem(0, 2, 901, 1)
		q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 }, { t = "use", item = 900, quest = 7, status = "done" } })
		emit({ b:GetAttribute("item") or "nil", b:IsShown() })

		-- no log item: a usable quest item in the bags
		q.specialItems[5] = nil
		q.bags[0].slots[1] = nil
		q.addItem(0, 3, 902, 1)
		q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 } })
		emit({ b:GetAttribute("item") or "nil", b:IsShown() })

		-- a step without open quest goals: hidden
		q.step({ { t = "goto", map = 9000, x = 1, y = 1 } })
		emit({ b:GetAttribute("item") or "nil", b:IsShown() })

		-- setting off: nothing shown even for a use goal
		q.addItem(0, 1, 900, 2)
		set("itemButton", false)
		q.step({ { t = "use", item = 900, quest = 7, oi = 1 } })
		emit({ b:GetAttribute("item") or "nil", b:IsShown() })
	`);
	assert.deepEqual(out[0], ['item', 'item:900', true, '2']);
	assert.deepEqual(out[1], ['item:901', true]);
	assert.deepEqual(out[2], ['item:902', true]);
	assert.deepEqual(out[3], ['nil', false]);
	assert.deepEqual(out[4], ['nil', false]);
});

test('secure buttons: changes during combat wait for PLAYER_REGEN_ENABLED; display still updates', () => {
	const out = run(`
		local b, t = PolestarQuestItemButton, PolestarTargetButton
		q.items[900] = { name = "Torch" }
		q.items[903] = { name = "Bomb" }
		q.addItem(0, 1, 900, 1)
		q.addItem(0, 2, 903, 4)
		q.step({ { t = "use", item = 900, quest = 7 }, { t = "kill", target = "Murloc" } })
		q.combat(true)
		-- The step moves on mid-fight: these would be protected calls.
		q.step({ { t = "use", item = 903, quest = 8 }, { t = "kill", target = "Gnoll" } })
		set("buttonScale", 1.4)
		q.cooldowns[900] = { 100, 30 }
		stub.fire("BAG_UPDATE_COOLDOWN")
		emit({ b:GetAttribute("item"), t:GetAttribute("macrotext"), b:GetScale(), b.itemID })
		q.combat(false)
		emit({ b:GetAttribute("item"), t:GetAttribute("macrotext"), b:GetScale(), b.itemID, b.Count:GetText() })
	`);
	assert.deepEqual(out[0], ['item:900', '/targetexact Murloc', 1, 900]);
	assert.deepEqual(out[1], ['item:903', '/targetexact Gnoll', 1.4, 903, '4']);
});

test('secure buttons: a login under combat lockdown (/reload mid-fight) defers every protected call', () => {
	const out = run(`
		q.items[900] = { name = "Torch" }
		q.addItem(0, 1, 900, 1)
		q.step({ { t = "use", item = 900, quest = 7 } })
		emit({ PolestarQuestItemButton:GetAttribute("item") or "nil", QoL.HasQueued("item:PolestarQuestItemButton") })
		q.combat(false)
		emit({ PolestarQuestItemButton:GetAttribute("item"), PolestarQuestItemButton:IsShown(), PolestarTargetButton:IsShown() })
	`, { before: 'stub.inCombat = true' });
	assert.deepEqual(out[0], ['nil', true]);
	assert.deepEqual(out[1], ['item:900', true, false]);
});

test('quest item button: range tint and cooldown follow the item', () => {
	const [far, near, cd] = run(`
		local b = PolestarQuestItemButton
		q.items[900] = { name = "Torch" }
		q.addItem(0, 1, 900, 1)
		q.cooldowns[900] = { 50, 10 }
		q.step({ { t = "use", item = 900, quest = 7 } })
		q.target = true
		q.inRange = false
		stub.advance(0.3)
		emit({ b.Icon:GetVertexColor() })
		q.inRange = true
		stub.advance(0.3)
		emit({ b.Icon:GetVertexColor() })
		emit(b.Cooldown.cooldownSet or "n/a")
	`, {
		before: `local M = stub.Methods; function M.SetCooldown(self, s, d) self.cooldownSet = { s, d } end`,
	});
	assert.ok(far[0] > 0.9 && far[1] < 0.6, 'red when out of range');
	assert.deepEqual(near, [1, 1, 1, 1]);
	assert.deepEqual(cd, [50, 10]);
});

test('target button: kill targets and QuestDB droppers, preferred name last, each click cycles', () => {
	const out = run(`
		local t = PolestarTargetButton
		q.step({
			{ t = "kill", target = "Kobold Vermin", quest = 7, oi = 1 },
			{ t = "collect", item = 950, itemName = "Candle", quest = 7, oi = 2 },
			{ t = "kill", target = "Done Mob", status = "done" },
		})
		-- no QuestDB yet: kill targets only
		emit(t:GetAttribute("macrotext"))
		Polestar.QuestDB = {
			IsLoaded = function() return true end,
			GetObjectiveMobs = function(quest, oi) if quest == 7 and oi == 2 then return { "Kobold Laborer", "Kobold Vermin" } end end,
		}
		Polestar.Fire("QUESTDB_LOADED")
		stub.runTimers()
		emit({ t:GetAttribute("type"), t:GetAttribute("macrotext"), t.Label:GetText() })
		q.click(t, true)   -- key down: no change
		emit(t:GetAttribute("macrotext"))
		q.click(t, false)  -- release: next name
		emit({ t:GetAttribute("macrotext"), t.Label:GetText() })
		q.combat(true)
		q.click(t, false)
		emit(t:GetAttribute("macrotext"))
		q.combat(false)
		emit(t:GetAttribute("macrotext"))
		q.step({ { t = "goto", map = 9000, x = 1, y = 1 } })
		emit({ t:GetAttribute("macrotext") or "nil", t:IsShown() })
	`);
	assert.equal(out[0], '/targetexact Kobold Vermin');
	assert.deepEqual(out[1], ['macro', '/targetexact Kobold Laborer\n/targetexact Kobold Vermin', 'Kobold Vermin']);
	assert.equal(out[2], out[1][1]);
	assert.deepEqual(out[3], ['/targetexact Kobold Vermin\n/targetexact Kobold Laborer', 'Kobold Laborer']);
	assert.equal(out[4], out[3][0], 'no macro change in combat');
	assert.equal(out[5], '/targetexact Kobold Laborer\n/targetexact Kobold Vermin', 'cycled once combat ended');
	assert.deepEqual(out[6], ['nil', false]);
});

test('hearth: button while a hearth goal is open; GetHearth reports bind and cooldown', () => {
	const out = run(`
		local h = PolestarHearthButton
		q.items[6948] = { name = "Hearthstone" }
		q.addItem(0, 1, 6948, 1)
		q.step({ { t = "kill", target = "Wolf" } })
		emit(h:IsShown())
		q.step({ { t = "hearth", location = "Goldshire" } })
		emit({ h:IsShown(), h:GetAttribute("item") })
		stub.now = 1000
		q.cooldowns[6948] = { 900, 3600 }
		local info = QoL.GetHearth()
		emit({ info.have, info.bind, info.ready, info.remaining })
		q.cooldowns[6948] = { 999, 1.5 } -- global cooldown only
		info = QoL.GetHearth()
		emit({ info.ready, info.remaining })
		set("hearthButton", false)
		emit(h:IsShown())
	`);
	assert.equal(out[0], false);
	assert.deepEqual(out[1], [true, 'item:6948']);
	assert.deepEqual(out[2], [true, 'Goldshire', false, 3500]);
	assert.deepEqual(out[3], [true, 0]);
	assert.equal(out[4], false);
});

// The client's choice in SecureActionButton_OnClick (SecureTemplates.lua) for
// an addon button: act on the press when useOnKeyDown (nil: the
// ActionButtonUseKeyDown CVar) says so, else on the release.
const ACTS = `
local acted = 0
local function secureClick(self, _, down)
	local use = self:GetAttribute("useOnKeyDown")
	if use == nil then use = GetCVarBool("ActionButtonUseKeyDown") end
	if (down and use) or (not down and not use) then acted = acted + 1 end
end
local item, hearth, target = PolestarQuestItemButton, PolestarHearthButton, PolestarTargetButton
for _, b in ipairs({ item, hearth, target }) do b:SetScript("OnClick", secureClick) end
local holder = select(2, item:GetPoint(1))
local R = stub.RunScript
for _, b in ipairs({ item, hearth, target }) do b.IsMouseOver = function(self) return self.over == true end end
local function hover(b) b.over = true; R(b, "OnEnter") end
local function leave(b) b.over = false; R(b, "OnLeave") end
local function attr(b) return tostring(b:GetAttribute("useOnKeyDown")) end
-- The client's order of OnMouseDown and the down-click is not documented:
-- try both.
local function press(b, downFirst)
	if downFirst then q.click(b, true); R(b, "OnMouseDown", "LeftButton")
	else R(b, "OnMouseDown", "LeftButton"); q.click(b, true) end
end
local function mouseClick(b, downFirst)
	acted = 0
	hover(b)
	press(b, downFirst)
	R(b, "OnMouseUp", "LeftButton")
	q.click(b, false)
	stub.runTimers()
	leave(b)
	return acted
end
local function keyPress(b) acted = 0; q.click(b, true); local onDown = acted; q.click(b, false); stub.runTimers(); return { onDown, acted } end
-- Hover, press, drag (the user carries the holder to x, y), release: no
-- OnMouseUp after a drag; the release's click is sent anyway in case the
-- client does. Reports whether the set moved, the actions fired and the
-- attribute while the cursor is still on the button; then leaves.
local function drag(b, x, y)
	acted = 0
	hover(b)
	press(b)
	R(b, "OnDragStart", "LeftButton")
	local started = holder.moving
	if started then holder:ClearAllPoints(); holder:SetPoint("CENTER", UIParent, "CENTER", x, y) end
	R(b, "OnDragStop", "LeftButton")
	q.click(b, false)
	stub.runTimers()
	local a = attr(b)
	leave(b)
	return { started == true, acted, a }
end
local function slot(b) local _, rel, _, x, y = b:GetPoint(1); return { rel == holder, x, y } end
local function spot() local p, _, rp, x, y = holder:GetPoint(1); return { p, rp, x, y } end
`;

test('action buttons: a left-drag moves the whole set and never uses the item; clicks and keys act once', () => {
	const out = run(`${ACTS}
		q.items[900] = { name = "Torch" }
		q.items[6948] = { name = "Hearthstone" }
		q.addItem(0, 1, 900, 1)
		q.addItem(0, 2, 6948, 1)
		q.step({ { t = "use", item = 900, quest = 7 }, { t = "kill", target = "Wolf" } })
		for _, cvar in ipairs({ "1", "0" }) do
			stub.cvars.ActionButtonUseKeyDown = cvar
			emit({ drag(item, -300, 50), drag(target, -300, 50), mouseClick(item, false), mouseClick(item, true), keyPress(item), attr(item) })
		end
		emit({ spot(), PolestarCharDB.qol.buttonPos, slot(item), slot(target) })

		-- a hearth goal: the Hearthstone button shows above the item, where the set now is
		q.step({ { t = "hearth", location = "Goldshire" }, { t = "use", item = 900, quest = 7 } })
		emit({ hearth:IsShown(), slot(hearth) })

		-- in combat: no move, nothing protected touched
		q.combat(true)
		stub.cvars.ActionButtonUseKeyDown = "1"
		emit(drag(item, 0, 0))
		emit(spot())
		q.combat(false)

		QoL.Buttons.ResetPositions()
		emit({ spot(), PolestarCharDB.qol.buttonPos or false })
	`);
	assert.deepEqual(out[0], [[true, 0, 'false'], [true, 0, 'false'], 1, 1, [1, 1], 'nil'],
		'ActionButtonUseKeyDown on: drags act never; clicks once in either order; a key acts on the press; leaving restores nil');
	assert.deepEqual(out[1], [[true, 0, 'false'], [true, 0, 'false'], 1, 1, [0, 1], 'nil'],
		'ActionButtonUseKeyDown off: a key acts on the release');
	assert.deepEqual(out[2], [['CENTER', 'CENTER', -300, 50], ['CENTER', 'CENTER', -300, 50], [true, 0, 0], [true, 0, -44]]);
	assert.deepEqual(out[3], [true, [true, 0, 44]]);
	assert.deepEqual(out[4], [false, 1, 'nil'], 'in combat: no drag, no attribute change; the press acts as before');
	assert.deepEqual(out[5], ['CENTER', 'CENTER', -300, 50]);
	assert.deepEqual(out[6], [['CENTER', 'CENTER', 260, -140], false]);
});

test('action buttons: the set comes back where it was left after a reload', () => {
	const [s] = run(`${ACTS} emit(spot())`, {
		saved: { Polestar: 'PolestarCharDB = { qol = { buttonPos = { "TOPLEFT", "TOPLEFT", 40, -60 } } }' },
	});
	assert.deepEqual(s, ['TOPLEFT', 'TOPLEFT', 40, -60]);
});

// ---------------------------------------------------------------------------
// XP and pace
// ---------------------------------------------------------------------------

test('xp: session and rolling rate, time to level, kills and quests to level, rested', () => {
	const [s] = run(`
		q.rested = 600
		-- 10 kills of 50 XP over 10 minutes, kill message before the gain
		for i = 1, 10 do
			stub.advance(60)
			stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "secret")
			q.gainXP(50)
		end
		-- one quest of 200 XP, turn-in event before the gain
		stub.fire("QUEST_TURNED_IN", 7, 200, 0)
		q.gainXP(200)
		local st = QoL.GetXPStats()
		emit({ xp = st.xp, remaining = st.remaining, sessionXP = st.sessionXP, sessionRate = st.sessionRate,
			rollingRate = st.rollingRate, ttl = st.timeToLevel, kills = st.sessionKills, quests = st.sessionQuests,
			avgKill = st.avgKillXP, avgQuest = st.avgQuestXP, k2l = st.killsToLevel, q2l = st.questsToLevel,
			rested = st.rested, restedPct = st.restedPercent, rate = st.rate })
	`);
	assert.equal(s.xp, 700);
	assert.equal(s.remaining, 300);
	assert.equal(s.sessionXP, 700);
	near(s.sessionRate, (700 / 600) * 3600, 1e-6);
	assert.equal(s.rollingRate, s.sessionRate, 'within the rolling window both agree');
	near(s.ttl, (300 / s.rate) * 3600, 1e-6);
	assert.equal(s.kills, 10);
	assert.equal(s.quests, 1);
	assert.equal(s.avgKill, 50);
	assert.equal(s.avgQuest, 200);
	assert.equal(s.k2l, 6);
	assert.equal(s.q2l, 2);
	assert.equal(s.rested, 600);
	assert.equal(s.restedPct, 60);
});

test('xp: gains are attributed in either event order; the rolling rate forgets old XP', () => {
	const [a, b] = run(`
		q.gainXP(80)                                 -- gain first, kill message after
		stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "x")
		stub.advance(5)
		q.gainXP(300)                                -- quest gain first, turn-in after
		stub.fire("QUEST_TURNED_IN", 9, 300, 0)
		stub.advance(5)
		stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "x")    -- kill message and quest gain coincide
		q.gainXP(150)
		stub.fire("QUEST_TURNED_IN", 10, 150, 0)
		stub.advance(5)
		q.gainXP(40)                                 -- exploration: no explanation, not a kill
		stub.advance(2)
		local st = QoL.GetXPStats()
		emit({ kills = st.sessionKills, quests = st.sessionQuests, avgKill = st.avgKillXP, avgQuest = st.avgQuestXP })
		stub.advance(1200)
		q.gainXP(10)
		st = QoL.GetXPStats()
		emit({ rolling = st.rollingRate, session = st.sessionRate, rate = st.rate, seconds = st.sessionSeconds })
	`);
	assert.deepEqual(a, { kills: 1, quests: 2, avgKill: 80, avgQuest: 225 });
	near(b.rolling, (10 / 900) * 3600, 1e-6);
	near(b.session, ((80 + 300 + 150 + 40 + 10) / b.seconds) * 3600, 1e-6);
	assert.equal(b.rate, b.rolling);
});

function near(a, b, eps = 1e-9) {
	assert.ok(Math.abs(a - b) <= eps, `expected ${b}, got ${a}`);
}

test('xp: level-ups close a split per level in CharState', () => {
	const [splits, st, again] = run(`
		stub.advance(100)
		stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "x")
		q.gainXP(400)
		stub.advance(200)
		stub.fire("QUEST_TURNED_IN", 3, 700, 0)
		q.gainXP(700)                                -- 1100 of 1000: level 11, 100 into it
		stub.advance(50)
		local splits = PolestarCharDB.qol.xp.splits
		emit({ s10 = splits[10], level = PolestarCharDB.qol.xp.level })
		local st = QoL.GetXPStats()
		emit({ level = st.level, xp = st.xp, levelSeconds = math.floor(st.levelSeconds * 1000 + 0.5) / 1000 })
		-- UnitLevel lagging one event: XP dropped at the same level still closes the level
		q.xp = 1150
		stub.fire("PLAYER_XP_UPDATE", "player")
		q.xp = 20
		q.xpMax = 1200
		stub.fire("PLAYER_XP_UPDATE", "player")
		emit({ s11 = PolestarCharDB.qol.xp.splits[11] ~= nil, level = PolestarCharDB.qol.xp.level })
	`);
	assert.equal(splits.level, 11);
	assert.equal(splits.s10.seconds, 300);
	assert.equal(splits.s10.xp, 1000);
	assert.equal(splits.s10.kills, 1);
	assert.equal(splits.s10.quests, 1);
	assert.equal(splits.s10.partial, undefined, 'tracked from 0 XP: a full level');
	assert.ok(splits.s10.at > 0);
	assert.deepEqual(st, { level: 11, xp: 100, levelSeconds: 50 });
	assert.deepEqual(again, { s11: true, level: 12 });
});

test('xp: tracker off returns nil and prints nothing', () => {
	const [stats, cmd] = run(`
		set("xpTracker", false)
		q.gainXP(100)
		emit(QoL.GetXPStats() == nil)
		SlashCmdList.POLESTAR("xp")
		emit(printed("tracker is off"))
	`);
	assert.equal(stats, true);
	assert.equal(cmd, true);
});

// ---------------------------------------------------------------------------
// Merchant
// ---------------------------------------------------------------------------

const BAGS = `
	q.items[1] = { name = "Broken Fang", quality = 0, price = 7 }
	q.items[2] = { name = "Linen Cloth", quality = 1, price = 13 }
	q.items[3] = { name = "Green Sword", quality = 2, price = 500 }
	q.items[4] = { name = "Grey Quest Thing", quality = 0, noValue = true }
	q.items[5] = { name = "Ruined Pelt", quality = 0, price = 25 }
	q.items[6] = { name = "Epic Ring", quality = 4, price = 9000 }
	q.items[7] = { name = "Uncached Grey", quality = 0, uncached = true }
	q.items[8] = { name = "Unknown quality" }
	q.bags[1].size = 8
	q.addItem(0, 1, 1, 3)
	q.addItem(0, 2, 2, 20)
	q.addItem(0, 3, 3, 1)
	q.addItem(0, 4, 4, 1)
	q.addItem(1, 1, 5, 2)
	q.addItem(1, 2, 6, 1)
	q.addItem(1, 3, 7, 1)
	q.addItem(1, 4, 8, 1)
	for i = 5, 8 do q.addItem(1, i, 1, 1) end
`;

test('merchant: sells only grey items with a vendor price and prints the total', () => {
	const [sold, money, left, msg] = run(`${BAGS}
		q.openMerchant()
		stub.advance(2)
		emit(q.sold)
		emit(q.money)
		local left = {}
		for bag = 0, 1 do for slot, s in pairs(q.bags[bag].slots) do left[#left + 1] = s.itemID end end
		table.sort(left)
		emit(left)
		emit(printed("Sold 9 grey items for 99c"))
	`);
	assert.deepEqual([...sold].sort(), [1, 1, 1, 1, 1, 5]);
	assert.equal(money, 3 * 7 + 2 * 25 + 4 * 7);
	assert.deepEqual(left, [2, 3, 4, 6, 7, 8]);
	assert.equal(msg, true);
});

test('merchant: a slot changed between ticks is re-checked and never sold', () => {
	const [used, ids] = run(`${BAGS}
		q.bags[1].size = 12
		for i = 9, 12 do q.addItem(1, i, 1, 1) end
		q.openMerchant()                 -- the first tick sells 6 of the 10 queued slots
		-- swap a still-queued grey slot for the epic ring
		q.bags[1].slots[12] = { itemID = 6, stackCount = 1 }
		stub.advance(1)
		local used = {}
		for _, c in ipairs(q.calls) do if c[1] == "UseContainerItem" then used[#used + 1] = c[2] .. ":" .. c[3] end end
		emit(used)
		emit(q.sold)
	`);
	assert.ok(!used.includes('1:12'), 'the swapped slot is never used');
	assert.ok(!ids.includes(6));
	assert.equal(ids.length, 9);
});

test('merchant: repairs after selling, if affordable; Shift and settings off do nothing', () => {
	const out = run(`${BAGS}
		q.repair = { can = true, cost = 50 }
		q.money = 0
		q.openMerchant()
		stub.advance(2)
		emit({ repaired = #calls("RepairAllItems"), money = q.money })   -- 66 earned, 50 paid
		q.closeMerchant()

		q.repair = { can = true, cost = 5000 }
		q.openMerchant()
		emit({ repaired = #calls("RepairAllItems"), poor = printed("Not enough money") })
		q.closeMerchant()

		q.calls = {}
		q.addItem(0, 1, 1, 3)
		stub.keys.shift = true
		q.openMerchant()
		stub.advance(2)
		emit(#q.calls)
		q.closeMerchant()
		stub.keys.shift = false

		set("sellJunk", false)
		set("autoRepair", false)
		q.openMerchant()
		stub.advance(2)
		emit(#q.calls)
	`);
	assert.deepEqual(out[0], { repaired: 1, money: 49 });
	assert.deepEqual(out[1], { repaired: 1, poor: true });
	assert.equal(out[2], 0, 'Shift: nothing');
	assert.equal(out[3], 0, 'off: nothing');
});

// ---------------------------------------------------------------------------
// Quest rewards
// ---------------------------------------------------------------------------

test('rewards: ranking by gear upgrade, else vendor value (stack included)', () => {
	const out = run(`
		local R = QoL.Rewards
		emit({ R.Rank({ { index = 1, value = 100 }, { index = 2, value = 300 }, { index = 3, value = 300 }, { index = 4, value = 50 } }) })
		emit({ R.Rank({
			{ index = 1, value = 900, upgrade = false, delta = -2 },
			{ index = 2, value = 10, upgrade = true, delta = 4 },
			{ index = 3, value = 20, upgrade = true, delta = 12 },
			{ index = 4, value = 5000 },
		}) })
		emit({ R.Rank({ { index = 1, value = 10, upgrade = false, delta = -1 }, { index = 2, value = 20, upgrade = true, delta = 0 } }) })
	`);
	assert.deepEqual(out[0], [[2, 3, 1, 4], 'value']);
	assert.deepEqual(out[1], [[3, 2, 4, 1], 'upgrade']);
	assert.deepEqual(out[2], [[2, 1], 'value'], 'a zero-delta "upgrade" is no upgrade');
});

// The marks on the reward panel, per choice: the corner badge ("qol-upgrade",
// "qol-coin" or false) and its tint, whether the best's hairline is drawn, and
// whether the mark hangs off the item icon (never over the name).
const MARKS = `
local T = Polestar.Theme
local function tint(t)
	local r, g, b = t:GetVertexColor()
	local sr, sg, sb = T.Color("success")
	local ar, ag, ab = T.Accent()
	if r == sr and g == sg and b == sb then return "success" end
	if r == ar and g == ag and b == ab then return "accent" end
	return "other"
end
local function marks()
	local out = {}
	for _, b in ipairs(QuestInfoRewardsFrame.RewardButtons) do
		if b:IsShown() then
			local seen = { badge = false, best = false }
			for _, c in ipairs(b.children) do
				if c.Badge and c:IsShown() then
					if c.Badge:IsShown() then
						seen.badge = c.Badge:GetTexture():match("([%w-]+)$")
						seen.tint = tint(c.Badge)
					end
					seen.best = c.Ring[1]:IsShown()
					seen.onIcon = select(2, c:GetPoint(1)) == b.Icon
				end
			end
			out[b:GetID()] = seen
		end
	end
	return out
end`;

test('rewards: a green arrow on every upgrade, the best framed, on the icon; no upgrade: the coin on the most valuable; no pick by default', () => {
	const [vendor, vendorMarks, upgrades, upgradeMarks, finished] = run(`${MARKS}
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Potion", price = 50 }
		q.items[13] = { name = "Boots", price = 90 }
		q.choices = { { id = 11 }, { id = 12, count = 5 }, { id = 13 } }
		q.questComplete()
		stub.runTimers()
		emit({ best = QoL.Rewards.best, reason = QoL.Rewards.reason, picks = #calls("GetQuestReward") })
		emit(marks())

		Polestar.Gear = {
			IsEnabled = function() return true end,
			IsUpgrade = function(link)
				if link:find("item:13") then return true, 8 end
				if link:find("item:11") then return true, 3 end
				return false, -1
			end,
		}
		q.questComplete()
		stub.runTimers()
		emit({ best = QoL.Rewards.best, reason = QoL.Rewards.reason })
		emit(marks())
		stub.fire("QUEST_FINISHED")
		emit(marks())
	`);
	assert.deepEqual(vendor, { best: 2, reason: 'value', picks: 0 }, 'five potions sell for most');
	assert.deepEqual(vendorMarks, [
		{ badge: false, best: false },
		{ badge: 'qol-coin', tint: 'accent', best: true, onIcon: true },
		{ badge: false, best: false },
	]);
	assert.deepEqual(upgrades, { best: 3, reason: 'upgrade' });
	assert.deepEqual(upgradeMarks, [
		{ badge: 'qol-upgrade', tint: 'success', best: false, onIcon: true },
		{ badge: false, best: false },
		{ badge: 'qol-upgrade', tint: 'success', best: true, onIcon: true },
	], 'both upgrades get the arrow; the bigger one is framed; no coin');
	assert.deepEqual(finished, [{ badge: false, best: false }, { badge: false, best: false }, { badge: false, best: false }]);
});

test('rewards: a disabled Gear module marks no upgrades; a single choice gets its arrow but no frame', () => {
	const [disabled, single] = run(`${MARKS}
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring", price = 400 }
		q.choices = { { id = 11 }, { id = 12 } }
		local on = false
		Polestar.Gear = { IsEnabled = function() return on end, IsUpgrade = function(link) return link:find("item:11") ~= nil, 5 end }
		q.questComplete(); stub.runTimers()
		emit(marks())
		on = true
		q.choices = { { id = 11 } }
		q.questComplete(); stub.runTimers()
		emit(marks())
	`);
	assert.deepEqual(disabled, [{ badge: false, best: false }, { badge: 'qol-coin', tint: 'accent', best: true, onIcon: true }]);
	assert.deepEqual(single, [{ badge: 'qol-upgrade', tint: 'success', best: false, onIcon: true }]);
});

test('rewards: auto-pick takes the best when on; Shift, quest cost and a disabled Gear module are respected', () => {
	const out = run(`
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring", price = 400 }
		q.choices = { { id = 11 }, { id = 12 } }
		Polestar.Gear = { IsEnabled = function() return false end, IsUpgrade = function() return true, 50 end }
		set("rewardAutoPick", true)
		q.questComplete(); stub.runTimers()
		emit(calls("GetQuestReward"))
		q.calls = {}
		stub.keys.shift = true
		q.questComplete(); stub.runTimers()
		stub.keys.shift = false
		emit(#calls("GetQuestReward"))
		q.questMoney = 100
		q.questComplete(); stub.runTimers()
		emit(#calls("GetQuestReward"))
	`);
	assert.deepEqual(out[0], [2], 'disabled Gear: vendor value decides');
	assert.equal(out[1], 0);
	assert.equal(out[2], 0);
});

test('rewards: waits for uncached item data before ranking; an upgrade is marked from its item ID meanwhile, the frame once it settles', () => {
	const out = run(`${MARKS}
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring", price = 400, uncached = true }
		q.choices = { { id = 11 }, { id = 12 } }
		Polestar.Gear = { IsEnabled = function() return true end, IsUpgrade = function(link) return link:find("item:12") ~= nil, 4 end }
		q.questComplete()
		stub.runTimers()
		emit(QoL.Rewards.best or "pending")
		emit(marks())
		q.items[12].uncached = nil
		stub.advance(0.35)
		emit(QoL.Rewards.best)
		emit(marks())
	`);
	assert.equal(out[0], 'pending');
	assert.deepEqual(out[1], [{ badge: false, best: false }, { badge: 'qol-upgrade', tint: 'success', best: false, onIcon: true }]);
	assert.equal(out[2], 2);
	assert.deepEqual(out[3][1], { badge: 'qol-upgrade', tint: 'success', best: true, onIcon: true });
});

test('rewards: marking off clears an open panel; both settings off do nothing', () => {
	const [before, cleared, best, after, msgs] = run(`${MARKS}
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring", price = 400 }
		q.choices = { { id = 11 }, { id = 12 } }
		q.questComplete(); stub.runTimers()
		emit(marks())
		set("rewardHighlight", false)
		emit(marks())
		local n0 = #stub.messages
		q.questComplete(); stub.runTimers()
		emit(QoL.Rewards.best or "none")
		emit(marks())
		emit(#stub.messages - n0)
	`);
	assert.deepEqual(before[1], { badge: 'qol-coin', tint: 'accent', best: true, onIcon: true });
	assert.deepEqual(cleared, [{ badge: false, best: false }, { badge: false, best: false }]);
	assert.equal(best, 'none');
	assert.deepEqual(after, cleared);
	assert.equal(msgs, 0);
});

// ---------------------------------------------------------------------------
// Flight masters
// ---------------------------------------------------------------------------

test('flight: gossip opens the flight map (taxi icon or known flight master); Shift and quests suppress', () => {
	const out = run(`
		QoL.SetData({ spiritHealers = {}, flightMasters = { 352 } })
		local TAXI = { gossipOptionID = 77, name = "Show me where I can fly.", icon = 132057, orderIndex = 0 }
		local TALK = { gossipOptionID = 78, name = "Tell me about the gryphons.", icon = 132053, orderIndex = 1 }
		q.openGossip(1, { options = { TALK, TAXI } })
		emit(calls("SelectOption"))
		q.calls = {}
		q.openGossip(352, { options = { { gossipOptionID = 80, name = "?", icon = 0, orderIndex = 0 } } })
		emit(calls("SelectOption"))
		q.calls = {}
		stub.keys.shift = true
		q.openGossip(1, { options = { TAXI } })
		stub.keys.shift = false
		emit(#q.calls)
		q.openGossip(1, { options = { TAXI }, available = 1 })
		emit(#q.calls)
		q.openGossip(1, { options = { TAXI }, active = { { questID = 4, isComplete = true } } })
		emit(#q.calls)
		set("flightAutoOpen", false)
		set("skipGossip", false)
		q.openGossip(1, { options = { TAXI } })
		emit(#q.calls)
	`);
	assert.deepEqual(out[0], [77]);
	assert.deepEqual(out[1], [80]);
	assert.equal(out[2], 0);
	assert.equal(out[3], 0);
	assert.equal(out[4], 0);
	assert.equal(out[5], 0);
});

test("flight: marks the route's next flight destination, else the fly goal; never takes the flight", () => {
	const out = run(`
		q.nav.route = {
			{ kind = "walk", to = { name = "Stormwind" } },
			{ kind = "fly", to = { name = "Sentinel Hill, Westfall" } },
		}
		q.nav.ci = 1
		q.openTaxi({ "Stormwind, Elwynn", "Lakeshire, Redridge", "Sentinel Hill, Westfall" })
		local function marked()
			for i = 1, 3 do
				local tb = _G["TaxiButton" .. i]
				for _, c in ipairs(tb.children) do if c:IsShown() and c.Label and c:GetParent() == tb then return i end end
			end
		end
		emit({ QoL.Flight.node, QoL.Flight.destination, marked() })
		stub.fire("TAXIMAP_CLOSED")
		q.nav.route = nil
		q.step({ { t = "fly", location = "Lakeshire" } })
		q.openTaxi({ "Stormwind, Elwynn", "Lakeshire, Redridge", "Sentinel Hill, Westfall" })
		emit({ QoL.Flight.node, marked() })
		emit(#calls("TakeTaxiNode"))
		stub.fire("TAXIMAP_CLOSED")
		set("flightHighlight", false)
		q.openTaxi({ "Stormwind, Elwynn", "Lakeshire, Redridge" })
		emit(QoL.Flight.node or "none")
	`);
	assert.deepEqual(out[0], [3, 'Sentinel Hill, Westfall', 3]);
	assert.deepEqual(out[1], [2, 2]);
	assert.equal(out[2], 0);
	assert.equal(out[3], 'none');
});

// ---------------------------------------------------------------------------
// Death helper
// ---------------------------------------------------------------------------

test('death: decision weighs the run against resurrection sickness', () => {
	const out = run(`
		local D = QoL.Death
		emit({ D.Sickness(5), D.Sickness(10), D.Sickness(14), D.Sickness(20), D.Sickness(60) })
		emit({ D.Decide(700, 20, 7, 8) })            -- level 8: no sickness, healer is close
		emit({ D.Decide(700, 20, 7, 30) })           -- level 30: 100 s run beats 600 s sickness
		emit({ (D.Decide(nil, 20, 7, 30)) })         -- corpse elsewhere: healer
		emit({ D.Decide(70, 40, 7, 8, "corpse") })   -- healer wins by under 5 s: keep the corpse
	`);
	assert.deepEqual(out[0], [0, 0, 240, 600, 600]);
	assert.deepEqual(out[1].slice(0, 1), ['healer']);
	assert.deepEqual(out[2].slice(0, 2), ['corpse', 100]);
	assert.equal(out[3][0], 'healer');
	assert.equal(out[4][0], 'corpse');
});

test('death: as a ghost the arrow points at the faster choice; resurrection releases it', () => {
	const out = run(`
		-- healer 20 yd north of the player; corpse 400 yd east
		QoL.SetData({ spiritHealers = { { 0, 20, 0, 9000, 50, 49 }, { 1, 0, 0, 9001, 50, 50 } }, flightMasters = {} })
		q.player = { c = 0, wx = 0, wy = 0 }
		local _, cx, cy = q.mapPoint(0, -400)
		q.corpse = { cx, cy }
		q.level = 30
		q.ghost = true
		stub.fire("PLAYER_ALIVE")
		local t = q.nav.target
		emit({ label = t.label, x = t.x, y = t.y, choice = QoL.GetDeathAdvice().choice, pins = #q.pins["qol.death"] })
		-- level 8: no sickness, the healer wins
		q.level = 8
		stub.advance(1.1)
		t = q.nav.target
		emit({ label = t.label, x = t.x, y = t.y, note = QoL.GetDeathAdvice().note })
		-- the step changed and Nav dropped our target: it comes back on the next tick
		q.nav.target = nil
		stub.advance(1)
		emit(q.nav.target and q.nav.target.label)
		q.ghost = false
		stub.fire("PLAYER_UNGHOST")
		emit({ releases = q.nav.releases, target = q.nav.target == nil, pins = q.pins["qol.death"] == nil, advice = QoL.GetDeathAdvice() == nil })
		local sets = #q.nav.sets
		stub.advance(3)
		emit(#q.nav.sets == sets)
	`);
	assert.equal(out[0].label, 'Your corpse');
	assert.ok(Math.abs(out[0].x - 70) < 1e-9 && Math.abs(out[0].y - 50) < 1e-9);
	assert.equal(out[0].choice, 'corpse');
	assert.equal(out[0].pins, 2);
	assert.equal(out[1].label, 'Spirit Healer');
	assert.ok(Math.abs(out[1].x - 50) < 1e-9 && Math.abs(out[1].y - 49) < 1e-9);
	assert.match(out[1].note, /no resurrection sickness/);
	assert.equal(out[2], 'Spirit Healer');
	assert.deepEqual(out[3], { releases: 1, target: true, pins: true, advice: true });
	assert.equal(out[4], true, 'no more targets after resurrection');
});

test('death: in metres the advice gives the distances in metres', () => {
	const [note] = run(`
		Polestar.Set("nav.distanceUnit", "metres")
		QoL.SetData({ spiritHealers = { { 0, 20, 0, 9000, 50, 49 } }, flightMasters = {} })
		q.player = { c = 0, wx = 0, wy = 0 }
		local _, cx, cy = q.mapPoint(0, -400)
		q.corpse = { cx, cy }
		q.level = 8
		q.ghost = true
		stub.fire("PLAYER_ALIVE")
		emit(QoL.GetDeathAdvice().note)
	`);
	assert.equal(note, 'Resurrect at the Spirit Healer (18 m): no resurrection sickness at your level.');
});

test('death: helper off does nothing', () => {
	const [sets, pins] = run(`
		set("deathHelper", false)
		QoL.SetData({ spiritHealers = { { 0, 20, 0, 9000, 50, 49 } }, flightMasters = {} })
		q.ghost = true
		stub.fire("PLAYER_ALIVE")
		stub.advance(3)
		emit(#q.nav.sets)
		emit(q.pins["qol.death"] == nil)
	`);
	assert.equal(sets, 0);
	assert.equal(pins, true);
});

// ---------------------------------------------------------------------------
// Questing toggles
// ---------------------------------------------------------------------------

test('instant quest text: sets the CVar, restores the player value when turned off; absent CVar left alone', () => {
	const out = run(`
		emit(stub.cvars.instantQuestText)
		set("instantQuestText", false)
		emit(stub.cvars.instantQuestText)
		set("instantQuestText", true)
		emit(stub.cvars.instantQuestText)
	`, { before: 'stub.cvars.instantQuestText = "0"' });
	assert.deepEqual(out, ['1', '0', '1']);
	const [absent] = run(`emit(stub.cvars.instantQuestText == nil)`);
	assert.equal(absent, true);
	const [untouched] = run(`emit(stub.cvars.instantQuestText)`, {
		before: 'stub.cvars.instantQuestText = "0"',
		saved: { Polestar: 'PolestarDB = { schema = 1, settings = { qol = { instantQuestText = false } } }' },
	});
	assert.equal(untouched, '0', 'off: the CVar is never touched');
});

test('skip gossip: picks the only option of an NPC without quests; never otherwise', () => {
	const out = run(`
		local ONE = { { gossipOptionID = 5, name = "I want to browse your goods.", icon = 132060, orderIndex = 0, status = 0 } }
		q.openGossip(9, { options = ONE })
		emit(calls("SelectOptionByIndex"))
		q.calls = {}
		q.openGossip(9, { options = { ONE[1], { gossipOptionID = 6, icon = 0, orderIndex = 1 } } })
		q.openGossip(9, { options = ONE, available = 1 })
		q.openGossip(9, { options = ONE, active = { { questID = 2, isComplete = false } } })
		q.openGossip(9, { options = ONE, force = true })
		q.openGossip(9, { options = { { gossipOptionID = 7, icon = 0, orderIndex = 0, selectOptionWhenOnlyOption = true } } })
		stub.keys.shift = true
		q.openGossip(9, { options = ONE })
		stub.keys.shift = false
		emit(#q.calls)
		set("skipGossip", false)
		q.openGossip(9, { options = ONE })
		emit(#q.calls)
	`);
	assert.deepEqual(out[0], [0]);
	assert.equal(out[1], 0);
	assert.equal(out[2], 0);
});

test('fast loot: takes every slot when auto-loot applies; off or manual looting does nothing', () => {
	const out = run(`
		q.loot = 3
		stub.fire("LOOT_READY", true)
		emit(calls("LootSlot"))
		q.calls = {}
		stub.fire("LOOT_READY", true)        -- repeat for the same corpse
		stub.advance(1)
		stub.fire("LOOT_READY", false)       -- auto-loot not active
		emit(#q.calls)
		set("fastLoot", false)
		stub.advance(1)
		stub.fire("LOOT_READY", true)
		emit(#q.calls)
	`);
	assert.deepEqual(out[0], [3, 2, 1]);
	assert.equal(out[1], 0);
	assert.equal(out[2], 0);
});

test('hide combat errors: turns the spam types off through UIErrorsFrame, and back on; others untouched', () => {
	const out = run(`
		local B = BLACK_LISTED_MESSAGE_TYPES
		local function state() return { rage = B[LE_GAME_ERR_OUT_OF_RAGE] or false, range = B[LE_GAME_ERR_OUT_OF_RANGE] or false,
			cd = B[LE_GAME_ERR_SPELL_COOLDOWN] or false, busy = B[LE_GAME_ERR_SPELL_FAILED_ANOTHER_IN_PROGRESS] or false,
			full = B[LE_GAME_ERR_INV_FULL] or false } end
		emit(state())
		set("hideErrors", true)
		emit(state())
		set("hideErrors", false)
		emit(state())
	`);
	assert.deepEqual(out[0], { rage: false, range: false, cd: false, busy: true, full: false }, 'off by default: nothing changed');
	assert.deepEqual(out[1], { rage: true, range: true, cd: true, busy: true, full: false }, 'inventory full still shows');
	assert.deepEqual(out[2], { rage: false, range: false, cd: false, busy: true, full: false }, 'Blizzard\'s own blacklist entry is kept');
});

test('release in battlegrounds: only in a battleground, never with a self-res, an offer, Hardcore or Shift', () => {
	const out = run(`
		local s = q.social
		local function die() q.calls = {}; stub.fire("PLAYER_DEAD"); return #calls("RepopMe") end
		s.battleground = true
		emit({ off = die(), watching = QoL.Watching("PLAYER_DEAD") })
		set("autoReleasePvP", true)
		local r = { bg = die() }
		s.battleground = false; r.world = die(); s.battleground = true
		s.selfRes = 1; r.soulstone = die(); s.selfRes = 0
		s.offerer = "Priest"; r.offer = die(); s.offerer = nil
		s.hardcore = true; r.hardcore = die(); s.hardcore = false
		stub.keys.shift = true; r.shift = die(); stub.keys.shift = false
		emit(r)
	`);
	assert.equal(out[0].off, 0);
	assert.deepEqual(out[1], { bg: 1, world: 0, soulstone: 0, offer: 0, hardcore: 0, shift: 0 });
});

// ---------------------------------------------------------------------------
// Requests from other players
// ---------------------------------------------------------------------------

test('requests: no event is registered while every request setting is off', () => {
	const [off, on, again] = run(`
		local EVENTS = { "CONFIRM_SUMMON", "RESURRECT_REQUEST", "PARTY_INVITE_REQUEST", "GUILD_INVITE_REQUEST", "DUEL_REQUESTED", "PLAYER_DEAD" }
		local function watching() local o = {}; for _, e in ipairs(EVENTS) do o[e] = QoL.Watching(e) end; return o end
		emit(watching())
		for _, k in ipairs({ "acceptSummon", "acceptResurrect", "declinePartyStrangers", "declineGuildInvites", "declineDuels", "autoReleasePvP" }) do set(k, true) end
		emit(watching())
		for _, k in ipairs({ "acceptSummon", "acceptResurrect", "declinePartyStrangers", "declineGuildInvites", "declineDuels", "autoReleasePvP" }) do set(k, false) end
		emit(watching())
	`);
	for (const v of Object.values(off)) assert.equal(v, false);
	for (const v of Object.values(on)) assert.equal(v, true);
	assert.deepEqual(again, off);
});

test('friends: friend list, Battle.net character and guild, by GUID or name (realm suffix dropped)', () => {
	const [r] = run(`
		local s = q.social
		s.friends["Player-1-A"] = true; s.friends["Ann"] = true
		s.bnet["Player-1-B"] = true
		s.guild["Player-1-C"] = true; s.guild["Cid"] = true
		local F = QoL.Social.IsFriend
		emit({ guid = F(nil, "Player-1-A"), bnet = F("x", "Player-1-B"), guildGuid = F(nil, "Player-1-C"), name = F("Ann"),
			realm = F("Ann-Stormrage"), guildName = F("Cid"), stranger = F("Rando", "Player-1-Z"), none = F(nil, nil) })
	`);
	assert.deepEqual(r, { guid: true, bnet: true, guildGuid: true, name: true, realm: true, guildName: true, stranger: false, none: false });
});

test('summons: accepted out of combat when able to teleport; the dialog closes; Shift, combat and off ask', () => {
	const out = run(`
		local s = q.social
		local function summon() q.calls = {}; q.showPopup("CONFIRM_SUMMON"); stub.fire("CONFIRM_SUMMON", 0, false); stub.runTimers(); return #calls("ConfirmSummon") end
		emit(summon())
		set("acceptSummon", true)
		emit({ n = summon(), closed = #calls("StaticPopup_Hide"), msg = printed("Accepted a summon from Mage to Ironforge") })
		s.combat.player = true; local combat = summon(); s.combat.player = false
		s.canTeleport = false; local cannot = summon(); s.canTeleport = true
		stub.keys.shift = true; local shift = summon(); stub.keys.shift = false
		s.gamepad = true; local pad = summon(); local padClosed = #calls("StaticPopup_Hide"); s.gamepad = false
		emit({ combat = combat, cannot = cannot, shift = shift, pad = pad, padClosed = padClosed })
	`);
	assert.equal(out[0], 0, 'off by default');
	assert.deepEqual(out[1], { n: 1, closed: 1, msg: true });
	assert.deepEqual(out[2], { combat: 0, cannot: 0, shift: 0, pad: 1, padClosed: 0 }, 'Gamepad style: dialogs left alone');
});

test('resurrections: accepted after the corpse delay while still offered; never from a caster in combat or in Hardcore', () => {
	const out = run(`
		local s = q.social
		local function offer(caster) q.calls = {}; s.offerer = caster; stub.fire("RESURRECT_REQUEST", caster); stub.runTimers(); return #calls("AcceptResurrect") end
		emit(offer("Priest"))
		set("acceptResurrect", true)
		local r = { now = offer("Priest"), msg = printed("Accepted a resurrection from Priest") }
		s.combat.Druid = true; r.combat = offer("Druid"); s.combat.Druid = nil
		s.hardcore = true; r.hardcore = offer("Priest"); s.hardcore = false
		stub.keys.shift = true; r.shift = offer("Priest"); stub.keys.shift = false
		s.corpseDelay = 5
		r.early = offer("Priest")
		stub.advance(6)
		r.late = #calls("AcceptResurrect")
		q.calls = {}
		offer("Priest")
		s.offerer = nil          -- declined or timed out meanwhile
		stub.advance(6)
		r.withdrawn = #calls("AcceptResurrect")
		emit(r)
	`);
	assert.equal(out[0], 0, 'off by default');
	assert.deepEqual(out[1], { now: 1, msg: true, combat: 0, hardcore: 0, shift: 0, early: 0, late: 1, withdrawn: 0 });
});

test('party invitations: friends joined (dialog marked accepted), strangers declined when asked; role checks, queues and Shift ask', () => {
	const out = run(`
		local s = q.social
		s.friends["Player-1-F"] = true
		s.guild["Player-1-G"] = true
		local function invite(name, guid, tank)
			q.calls = {}; q.showPopup("PARTY_INVITE")
			stub.fire("PARTY_INVITE_REQUEST", name, tank or false, false, false, true, false, guid, false)
			stub.runTimers()
			local marked
			for _, c in ipairs(q.calls) do if c[1] == "StaticPopup_Hide" then marked = c[3] end end
			return { accept = #calls("AcceptGroup"), decline = #calls("DeclineGroup"), marked = marked }
		end
		emit(invite("Fay", "Player-1-F"))
		set("acceptPartyFriends", true)
		local r = { friend = invite("Fay", "Player-1-F"), guild = invite("Gus", "Player-1-G"), stranger = invite("Rando", "Player-1-Z") }
		r.role = invite("Fay", "Player-1-F", true)
		s.queued = true; r.queued = invite("Fay", "Player-1-F"); s.queued = false
		stub.keys.shift = true; r.shift = invite("Fay", "Player-1-F"); stub.keys.shift = false
		set("declinePartyStrangers", true)
		r.declined = invite("Rando", "Player-1-Z")
		r.friendStill = invite("Fay", "Player-1-F")
		emit(r)
	`);
	assert.deepEqual(out[0], { accept: 0, decline: 0 }, 'off by default');
	const r = out[1];
	assert.deepEqual(r.friend, { accept: 1, decline: 0, marked: 1 }, 'inviteAccepted set so its OnHide does not decline');
	assert.deepEqual(r.guild, { accept: 1, decline: 0, marked: 1 });
	assert.deepEqual(r.stranger, { accept: 0, decline: 0 });
	assert.deepEqual(r.role, { accept: 0, decline: 0 });
	assert.deepEqual(r.queued, { accept: 0, decline: 0 });
	assert.deepEqual(r.shift, { accept: 0, decline: 0 });
	assert.deepEqual(r.declined, { accept: 0, decline: 1, marked: false });
	assert.deepEqual(r.friendStill, { accept: 1, decline: 0, marked: 1 });
});

test('guild invitations: declined except from friends, and the invite window closes', () => {
	const out = run(`
		local s = q.social
		s.friends["Fay"] = true
		local function invite(who) q.calls = {}; GuildInviteFrame:Show(); stub.fire("GUILD_INVITE_REQUEST", who, "Spam Guild", 0, nil, false); stub.runTimers(); return { n = #calls("DeclineGuild"), shown = GuildInviteFrame:IsShown() } end
		emit(invite("Rando"))
		set("declineGuildInvites", true)
		emit({ stranger = invite("Rando"), friend = invite("Fay"), msg = printed("Declined an invitation to Spam Guild") })
	`);
	assert.deepEqual(out[0], { n: 0, shown: true }, 'off by default');
	assert.deepEqual(out[1], { stranger: { n: 1, shown: false }, friend: { n: 0, shown: true }, msg: true });
});

test('duels: declined only when the setting is on, never from friends or guild', () => {
	const out = run(`
		q.social.guild["Gus"] = true
		stub.fire("DUEL_REQUESTED", "Rando")
		emit(#calls("CancelDuel"))
		set("declineDuels", true)
		stub.fire("DUEL_REQUESTED", "Rando")
		emit({ #calls("CancelDuel"), printed("Declined a duel from Rando") })
		stub.fire("DUEL_REQUESTED", "Gus")
		emit(#calls("CancelDuel"))
	`);
	assert.equal(out[0], 0);
	assert.deepEqual(out[1], [1, true]);
	assert.equal(out[2], 1, 'a guild member may duel');
});

// ---------------------------------------------------------------------------
// EllesmereUI
// ---------------------------------------------------------------------------

const COVERED_KEYS = ['sellJunk', 'autoRepair', 'repairGuild', 'fastLoot', 'skipGossip', 'hideErrors', 'acceptPartyFriends'];

function coveredDefaults(before, saved) {
	return run(`
		local o = {}
		for _, k in ipairs({ ${COVERED_KEYS.map((k) => `"${k}"`).join(', ')} }) do o[k] = QoL.On(k) end
		o.instantQuestText = QoL.On("instantQuestText")
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			for _, c in ipairs(spec.controls) do if c.key == "qol.sellJunk" then o.help = c.help end end
		end
		emit(o)
	`, { before, saved })[0];
}

test('EllesmereUI: overlapping toggles start off while its module is installed and enabled; your own choice wins', () => {
	const none = coveredDefaults();
	assert.deepEqual([none.sellJunk, none.autoRepair, none.fastLoot, none.skipGossip, none.instantQuestText], [true, true, true, true, true]);
	assert.ok(!/EllesmereUI/.test(none.help));

	const loaded = coveredDefaults('stub.addonsLoaded.EllesmereUI = true; stub.addonsLoaded.EllesmereUIQoL = true');
	for (const k of COVERED_KEYS) assert.equal(loaded[k], false, `${k} off with EllesmereUI QoL`);
	assert.equal(loaded.instantQuestText, true, 'what EllesmereUI does not do stays on');
	assert.match(loaded.help, /Off by default: EllesmereUI QoL does this too\./);

	const later = coveredDefaults('stub.qol.installed.EllesmereUIQoL = true');
	assert.equal(later.sellJunk, false, 'enabled but loading after Polestar counts');
	const disabled = coveredDefaults('stub.qol.installed.EllesmereUIQoL = false');
	assert.equal(disabled.sellJunk, true, 'installed but disabled does not');

	const mine = coveredDefaults('stub.addonsLoaded.EllesmereUIQoL = true',
		{ Polestar: 'PolestarDB = { schema = 1, settings = { qol = { sellJunk = true } } }' });
	assert.equal(mine.sellJunk, true);
});

test('merchant: guild bank first when allowed (no affordability gate, as Blizzard\'s button); else your own money', () => {
	const out = run(`
		local function visit() q.calls = {}; q.openMerchant(); stub.advance(1); local c = calls("RepairAllItems"); q.closeMerchant(); return c[1] or "none" end
		q.money = 0
		q.repair = { can = true, cost = 500, guild = true }
		local r = { off = visit() }
		set("repairGuild", true)
		q.repair.cost = 500
		r.guild = visit()
		r.msg = printed("Repaired for 5s 0c, guild bank first")
		q.repair = { can = true, cost = 500, guild = false }
		q.money = 1000
		r.rank = visit()
		emit(r)
	`);
	assert.deepEqual(out[0], { off: 'none', guild: 'guild', msg: true, rank: 'own' });
});

// ---------------------------------------------------------------------------
// The whole addon
// ---------------------------------------------------------------------------

test('full addon: QoL loads with every module and creates its buttons at login', () => {
	const [r] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		login: true,
		script: `
			local st = Polestar.QoL.GetXPStats()
			emit({ qol = Polestar.QoL ~= nil, item = PolestarQuestItemButton ~= nil, target = PolestarTargetButton ~= nil,
				hearth = PolestarHearthButton ~= nil, xp = st ~= nil and st.level ~= nil, healers = #Polestar.QoL.data.spiritHealers })
		`,
	}).emitted;
	assert.deepEqual(r, { qol: true, item: true, target: true, hearth: true, xp: true, healers: r.healers });
	assert.ok(r.healers > 50, 'generated Spirit Healer data loaded');
});
