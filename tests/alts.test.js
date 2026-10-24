'use strict';
// The Characters page (addon/Polestar/Alts): the per-character snapshot
// (what it holds, when it is written, how often), the account list and its
// orders, Forget, the rested projection, and the hub section.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const CORE = ['Core/Core.xml', 'Theme/Theme.xml', 'Alts/Alts.xml'];
const WITH_UI = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml', 'Alts/Alts.xml'];

// A level 18 Night Elf Mage resting in Darkshore, one guide tab open.
const WORLD = `
local w = stub.world
w.class, w.className, w.race, w.raceName = "MAGE", "Mage", "NightElf", "Night Elf"
w.level, w.xp, w.xpMax = 18, 1000, 4000
w.zone, w.subzone = "Darkshore", ""
w.bindLocation = "Auberdine"
w.money = 12 * 10000 + 40 * 100
w.skills[197] = { name = "Tailoring", rank = 112, maxRank = 150 }
w.skills[762] = { name = "Riding", rank = 75, maxRank = 75 }
local rested = 1840
GetXPExhaustion = function() return rested end
IsResting = function() return true end
`;

function run(script, { files = CORE, stubs = [], before = '', saved } = {}) {
	return runAddon({
		stubs: ['stub_world.lua', ...stubs],
		before: `${WORLD}\n${before}`,
		addons: [{ name: 'Polestar', files }],
		saved: saved ? { Polestar: saved } : undefined,
		login: true,
		script: `local Alts = Polestar.Alts
Polestar.Engine.GetTabs = function() return { { guideId = "g1", title = "Darkshore (16-21)", stepIndex = 16, stepCount = 43 } }, 1 end
${script}`,
	}).emitted;
}

test('login writes the entry under Name-Realm once the tabs exist', () => {
	const [before, out] = run(`
local first = PolestarDB.alts and PolestarDB.alts.chars["Testchar-Test Realm"]
stub.advance(6)
emit(first ~= nil)
emit(PolestarDB.alts.chars["Testchar-Test Realm"])`);
	assert.equal(before, false);
	assert.equal(out.name, 'Testchar');
	assert.equal(out.realm, 'Test Realm');
	assert.equal(out.class, 'MAGE');
	assert.equal(out.race, 'NightElf');
	assert.equal(out.level, 18);
	assert.equal(out.xp, 1000);
	assert.equal(out.xpMax, 4000);
	assert.equal(out.rested, 1840);
	assert.equal(out.resting, true);
	assert.equal(out.zone, 'Darkshore');
	assert.equal(out.bind, 'Auberdine');
	assert.equal(out.money, 124000);
	assert.deepEqual(out.profs, { 197: 112 }, 'riding is left out');
	assert.deepEqual(out.tabs, [{ id: 'g1', title: 'Darkshore (16-21)', step: 16, count: 43 }]);
	assert.equal(out.active, 1);
	assert.equal(typeof out.seen, 'number');
});

test('frequent events coalesce into one write after the delay; asking to leave writes at once', () => {
	const [out] = run(`
IsResting = function() return false end
stub.advance(6)
local writes = 0
local write = Alts.Write
Alts.Write = function() writes = writes + 1; return write() end
local c = function() return PolestarDB.alts.chars["Testchar-Test Realm"] end
stub.world.setLevel(19)
stub.world.setMoney(5)
stub.world.setXP(2000, 4200)
stub.fire("ZONE_CHANGED_NEW_AREA")
local immediate = { writes, c().level }
stub.advance(9)
local early = { writes, c().level }
stub.advance(2)
local late = { writes, c().level, c().money, c().xp }
stub.world.setMoney(9)
stub.fire("PLAYER_CAMPING")
emit({ immediate = immediate, early = early, late = late, logout = { writes, c().money } })`);
	assert.deepEqual(out.immediate, [0, 18]);
	assert.deepEqual(out.early, [0, 18]);
	assert.deepEqual(out.late, [1, 19, 5, 2000]);
	assert.deepEqual(out.logout, [2, 9]);
});

test('List: the current character first, then by last played, level or rested; a second character is kept', () => {
	const [out] = run(`
stub.advance(6)
local function as(name, class, level, xp, rested, resting, ago)
	UnitName = function() return name end
	stub.world.level, stub.world.xp, stub.world.xpMax = level, xp, 4000
	GetXPExhaustion = function() return rested end
	IsResting = function() return resting end
	Alts.Write()
	local e = PolestarDB.alts.chars[name .. "-Test Realm"]
	e.class = class
	e.seen = Polestar.Compat.Now() - ago
end
as("Alt1", "WARRIOR", 30, 0, 0, true, 3600)
as("Alt2", "PRIEST", 12, 0, 2000, false, 7200)
as("Alt3", "ROGUE", 25, 0, 100, true, 100)
UnitName = function() return "Testchar" end
stub.world.level, stub.world.xp, stub.world.xpMax = 18, 1000, 4000
GetXPExhaustion = function() return 1840 end
IsResting = function() return true end
Alts.Write()
local function names(sort) local o = {} for i, e in ipairs(Alts.List(sort)) do o[i] = e.name end return o end
emit({ seen = names(), level = names("level"), rested = names("rested") })`);
	assert.deepEqual(out.seen, ['Testchar', 'Alt3', 'Alt1', 'Alt2']);
	assert.deepEqual(out.level, ['Testchar', 'Alt1', 'Alt3', 'Alt2']);
	// Alt2 holds 2000 (+ a little, away); Alt3 100 (+ resting); Alt1 resting from 0.
	assert.deepEqual(out.rested, ['Testchar', 'Alt2', 'Alt3', 'Alt1']);
});

test('Forget removes another character and refuses the current one', () => {
	const [out] = run(`
stub.advance(6)
PolestarDB.alts.chars["Old-Test Realm"] = { key = "Old-Test Realm", name = "Old", realm = "Test Realm", level = 5, seen = 1 }
emit({ other = Alts.Forget("Old-Test Realm"), gone = PolestarDB.alts.chars["Old-Test Realm"] == nil,
	mine = Alts.Forget(Alts.Key()), kept = PolestarDB.alts.chars["Testchar-Test Realm"] ~= nil })`);
	assert.deepEqual(out, { other: true, gone: true, mine: false, kept: true });
});

test('ProjectRested: the classic rates, the cap and the level cap', () => {
	const [out] = run(`
local e = { level = 20, xp = 0, xpMax = 4000, rested = 0, seen = 1000, resting = true }
local H = 3600
local function away(t) local c = {} for k, v in pairs(e) do c[k] = v end c.resting = false return Alts.ProjectRested(c, 1000 + t) end
emit({
	rest8 = Alts.ProjectRested(e, 1000 + 8 * H),
	away8 = away(8 * H),
	added = Alts.ProjectRested({ level = 20, xpMax = 4000, rested = 1000, seen = 1000, resting = true }, 1000 + 8 * H),
	capped = Alts.ProjectRested(e, 1000 + 400 * 24 * H),
	maxed = Alts.ProjectRested({ level = 60, xpMax = 4000, rested = 0, seen = 1000, resting = true }, 1000 + 8 * H),
})`);
	assert.equal(out.rest8, 200, '5% of the level in 8 h resting');
	assert.equal(out.away8, 50, 'a quarter of that away from an inn');
	assert.equal(out.added, 1200);
	assert.equal(out.capped, 6000, '1.5 levels at most');
	assert.equal(out.maxed, undefined, 'nil at the level cap');
});

test('the section: one Button row per character, with an OnClick; Forget is disabled on the current character', () => {
	const [out] = run(`
stub.advance(6)
PolestarDB.alts.chars["Alt-Test Realm"] = { key = "Alt-Test Realm", name = "Alt", realm = "Test Realm", class = "WARRIOR", race = "Orc",
	level = 30, xp = 100, xpMax = 5000, zone = "Barrens", bind = "Crossroads", seen = Polestar.Compat.Now() - 7200, profs = { [186] = 80 } }
Polestar.Fire("SHOW_ALTS")
local V = Polestar.UI.AltsSection
local s = V.Shown()
local rows = {}
for i = 1, s.rows do
	local r = V.rows[i]
	rows[i] = { r:GetObjectType(), r:GetScript("OnClick") ~= nil, r.Name:GetText(), r:IsShown() }
end
local mine = { V.forgetButton():IsEnabled() }
local mineLabel = V.forgetButton().Label:GetText()
stub.RunScript(V.rows[2], "OnClick")
local after = { s.selected, V.forgetButton():IsEnabled(), V.forgetButton().Label:GetText() }
emit({ mineLabel = mineLabel, rows = rows, shownRows = s.rows, mine = mine, after = after, subtitle = s.subtitle, section = Polestar.UI.Picker.Section() })`, { files: WITH_UI, stubs: ['stub_ui.lua'] });
	assert.equal(out.shownRows, 2);
	assert.deepEqual(out.rows.map((r) => r.slice(0, 2)), [['Button', true], ['Button', true]]);
	assert.deepEqual(out.rows.map((r) => r[2]), ['Testchar', 'Alt']);
	assert.deepEqual(out.mine, [false]);
	assert.deepEqual(out.after, ['Alt-Test Realm', true, 'Forget Alt']);
	assert.deepEqual(out.mineLabel, 'Forget', 'the playing character reads just Forget');
	assert.equal(out.section, 'Characters');
	assert.match(out.subtitle, /^2 characters on Test Realm/);
});

test('Rested is live for the current character, projected for another', () => {
	const [out] = run(`
local now = Polestar.Compat.Now()
local mine = { key = Alts.Key(), level = 18, xpMax = 4000, rested = 1, seen = now - 8 * 3600, resting = true }
local other = { key = "Other-Test Realm", level = 18, xpMax = 4000, rested = 1, seen = now - 8 * 3600, resting = true }
emit({ mine = Alts.Rested(mine, now), other = Alts.Rested(other, now) })`);
	assert.equal(out.mine, 1840, 'GetXPExhaustion, not the stored figure');
	assert.equal(out.other, 201);
});

test('PLAYER_CAMPING writes at once', () => {
	const [out] = run(`
stub.advance(6)
stub.world.setMoney(77)
stub.fire("PLAYER_CAMPING")
emit(PolestarDB.alts.chars["Testchar-Test Realm"].money)`);
	assert.equal(out, 77);
});

test('SetSort persists alts.sort and the order follows it', () => {
	const [out] = run(`
stub.advance(6)
local now = Polestar.Compat.Now()
PolestarDB.alts.chars["Hi-Test Realm"] = { key = "Hi-Test Realm", name = "Hi", realm = "Test Realm", class = "ROGUE", race = "Human", level = 50, xp = 0, xpMax = 9000, seen = now - 9000 }
PolestarDB.alts.chars["Lo-Test Realm"] = { key = "Lo-Test Realm", name = "Lo", realm = "Test Realm", class = "ROGUE", race = "Human", level = 5, xp = 0, xpMax = 900, seen = now - 100 }
Polestar.Fire("SHOW_ALTS")
local V = Polestar.UI.AltsSection
local function order() local o = {} for i, k in ipairs(V.Shown().keys) do o[i] = k:match("^[^-]+") end return o end
local out = { seen = order() }
V.SetSort("level")
out.level = order()
out.saved = PolestarDB.settings.alts and PolestarDB.settings.alts.sort
out.setting = Polestar.Get("alts.sort")
V.SetSort("seen")
out.back = order()
out.cleared = PolestarDB.settings.alts == nil or PolestarDB.settings.alts.sort == nil
emit(out)`, { files: WITH_UI, stubs: ['stub_ui.lua'] });
	assert.deepEqual(out.seen, ['Testchar', 'Lo', 'Hi']);
	assert.deepEqual(out.level, ['Testchar', 'Hi', 'Lo']);
	assert.equal(out.saved, 'level');
	assert.equal(out.setting, 'level');
	assert.deepEqual(out.back, ['Testchar', 'Lo', 'Hi']);
	assert.equal(out.cleared, true, 'the default is not stored');
});

test('the row text: slower away from an inn, fully rested, Max level, nothing for xpMax 0 below the cap', () => {
	const [out] = run(`
stub.advance(6)
local now = Polestar.Compat.Now()
local function add(name, e)
	e.key, e.name, e.realm, e.class, e.race, e.seen = name .. "-Test Realm", name, "Test Realm", "ROGUE", "Human", e.seen or now - 3600
	PolestarDB.alts.chars[e.key] = e
end
add("Away", { level = 20, xp = 100, xpMax = 4000, rested = 1000 })
add("Full", { level = 20, xp = 100, xpMax = 4000, rested = 6000, resting = true })
add("Cap", { level = 60, xp = 0, xpMax = 0 })
add("Zero", { level = 20, xp = 0, xpMax = 0 })
Polestar.Fire("SHOW_ALTS")
local V = Polestar.UI.AltsSection
local by = {}
for i, key in ipairs(V.Shown().keys) do by[key] = { rest = V.Shown().rested[i], pct = V.rows[i].Pct:GetText() } end
emit(by)`, { files: WITH_UI, stubs: ['stub_ui.lua'] });
	assert.match(out['Away-Test Realm'].rest, /^\+\d+% .* slower$/);
	assert.match(out['Away-Test Realm'].pct, /^\d+% to 21$/);
	assert.equal(out['Full-Test Realm'].rest, 'Fully rested (1.5 levels)');
	assert.equal(out['Cap-Test Realm'].pct, 'Max level');
	assert.equal(out['Zero-Test Realm'].pct, '', 'no percentage below the cap without a level size');
	assert.equal(out['Zero-Test Realm'].rest, '');
});

test('Forget through the page takes two clicks: the first arms it', () => {
	const [out] = run(`
stub.advance(6)
PolestarDB.alts.chars["Alt-Test Realm"] = { key = "Alt-Test Realm", name = "Alt", realm = "Test Realm", class = "WARRIOR", race = "Orc", level = 30, xp = 1, xpMax = 5000, seen = 5 }
Polestar.Fire("SHOW_ALTS")
local V = Polestar.UI.AltsSection
stub.RunScript(V.rows[2], "OnClick")
local b = V.forgetButton()
stub.RunScript(b, "OnClick")
local armed = { PolestarDB.alts.chars["Alt-Test Realm"] ~= nil, b.Label:GetText() }
stub.RunScript(b, "OnClick")
emit({ armed = armed, gone = PolestarDB.alts.chars["Alt-Test Realm"] == nil })`, { files: WITH_UI, stubs: ['stub_ui.lua'] });
	assert.equal(out.armed[0], true, 'still there after one click');
	assert.equal(out.armed[1], 'Click again to confirm');
	assert.equal(out.gone, true);
});

test('alts.enabled off: nothing is written, saved characters are still listed and can be forgotten', () => {
	const [out, again] = run(`
stub.advance(6)
PolestarDB.alts.chars["Alt-Test Realm"] = { key = "Alt-Test Realm", name = "Alt", realm = "Test Realm", class = "WARRIOR", race = "Orc", level = 30, xp = 1, xpMax = 5000, seen = 5 }
local before = PolestarDB.alts.chars["Testchar-Test Realm"].money
Polestar.Set("alts.enabled", false)
stub.world.setMoney(5)
stub.advance(12)
stub.fire("PLAYER_LOGOUT")
local after = PolestarDB.alts.chars["Testchar-Test Realm"].money
Polestar.Fire("SHOW_ALTS")
local V = Polestar.UI.AltsSection
local s = V.Shown()
local o = { before = before, after = after, off = s.off, rows = s.rows, subtitle = s.subtitle }
V.Select("Alt-Test Realm")
o.canForget = V.forgetButton():IsEnabled()
stub.RunScript(V.forgetButton(), "OnClick")
stub.RunScript(V.forgetButton(), "OnClick")
o.gone = PolestarDB.alts.chars["Alt-Test Realm"] == nil
emit(o)
Polestar.Set("alts.enabled", true)
emit(PolestarDB.alts.chars["Testchar-Test Realm"].money)`, { files: WITH_UI, stubs: ['stub_ui.lua'] });
	assert.equal(out.before, 124000);
	assert.equal(out.after, 124000, 'unchanged while off');
	assert.equal(out.off, true);
	assert.equal(out.rows, 2, 'what was saved is listed');
	assert.doesNotMatch(out.subtitle, /\d characters|1 character/, 'no count claimed while off');
	assert.equal(out.canForget, true);
	assert.equal(out.gone, true);
	assert.equal(again, 5, 'turning it on writes again');
});

test('the playing character alone: no "as of their last logout"; the instance count is in the subtitle', () => {
	const [out] = run(`
Polestar.Fire("SHOW_ALTS")
local first = Polestar.UI.AltsSection.Shown().subtitle
Polestar.Set("maps.instances", true)
Polestar.Maps = { GetInstanceStatus = function() return { inHour = 3, perHour = 5 } end }
Polestar.UI.AltsSection.Select(Polestar.Alts.Key())
local on = Polestar.UI.AltsSection.Shown().subtitle
Polestar.Set("maps.instances", false)
Polestar.UI.AltsSection.Select(Polestar.Alts.Key())
emit({ first = first, on = on, off = Polestar.UI.AltsSection.Shown().subtitle })`, { files: WITH_UI, stubs: ['stub_ui.lua'] });
	assert.equal(out.first, '1 character on Test Realm');
	assert.match(out.on, /3\/5$/);
	assert.equal(out.off, '1 character on Test Realm', 'hidden with the instance tracker off');
});

test('the hub: the sorts are tabs and the sidebar lists the characters, a pick selecting its row', () => {
	const [out] = run(`
stub.advance(6)
PolestarDB.alts.chars["Alt-Test Realm"] = { key = "Alt-Test Realm", name = "Alt", realm = "Test Realm", class = "WARRIOR", race = "Orc", level = 30, xp = 1, xpMax = 5000, seen = 5 }
Polestar.Fire("SHOW_ALTS")
local win = PolestarPicker
local function labels(list) local o = {} for _, b in ipairs(list) do if b:IsShown() then o[#o + 1] = b.psKey end end return o end
local tabs, nav = labels(win.tabButtons), labels(win.navButtons)
local V = Polestar.UI.AltsSection
V.OnNav("Alt-Test Realm")
emit({ tabs = tabs, nav = nav, selected = V.Shown().selected })`, { files: WITH_UI, stubs: ['stub_ui.lua'] });
	assert.deepEqual(out.tabs, ['seen', 'rested', 'level']);
	assert.deepEqual(out.nav, ['Testchar-Test Realm', 'Alt-Test Realm']);
	assert.equal(out.selected, 'Alt-Test Realm');
});

test('a finished guide reads complete in the snapshot', () => {
	const [out] = run(`
Polestar.Engine.GetTabs = function() return { { guideId = "g1", title = "Done", stepIndex = 43, stepCount = 43, complete = true } }, 1 end
Alts.Write()
emit(PolestarDB.alts.chars["Testchar-Test Realm"].tabs[1].complete)`);
	assert.equal(out, true);
});

test('one pending write at most: the login timer and the event timer never stack', () => {
	const [out] = run(`
IsResting = function() return false end
local writes = 0
local write = Alts.Write
Alts.Write = function(...) writes = writes + 1; return write(...) end
stub.world.setMoney(1)
stub.world.setMoney(2)
stub.fire("PLAYER_CAMPING")
local atOnce = writes
stub.world.setMoney(3)
stub.advance(30)
emit({ atOnce = atOnce, total = writes })`);
	assert.deepEqual(out, { atOnce: 1, total: 2 }, 'the retired login timer does nothing; one timer wrote the later change');
});

test('Theme.ClassColor: a class file, and nil for the player\'s class', () => {
	const [out] = run(`
RAID_CLASS_COLORS = { MAGE = { r = 0.25, g = 0.78, b = 0.92 }, ROGUE = { r = 1, g = 0.96, b = 0.41 } }
local T = Polestar.Theme
emit({ rogue = { T.ClassColor("ROGUE") }, player = { T.ClassColor() }, unknown = { T.ClassColor("NOPE") } })`);
	assert.deepEqual(out.rogue, [1, 0.96, 0.41]);
	assert.deepEqual(out.player, [0.25, 0.78, 0.92], 'the world stub plays a Mage');
	assert.equal(Object.keys(out.unknown).length, 0);
});

test('opening the page before the login write still lists the playing character', () => {
	const [out] = run(`
local s0 = PolestarDB.alts
Polestar.Fire("SHOW_ALTS")
local s = Polestar.UI.AltsSection.Shown()
emit({ had = s0 ~= nil, rows = s.rows, key = s.keys[1], subtitle = s.subtitle })`, { files: WITH_UI, stubs: ['stub_ui.lua'] });
	assert.equal(out.had, false);
	assert.equal(out.rows, 1);
	assert.equal(out.key, 'Testchar-Test Realm');
	assert.match(out.subtitle, /^1 character on Test Realm/);
});

// What the client answers while the world goes: plausible and wrong.
const WRONG = `
IsResting = function() return false end
GetMoney = function() return 0 end
UnitLevel = function() return 1 end
UnitXP = function() return 0 end
UnitXPMax = function() return 0 end
GetXPExhaustion = function() return nil end
C_Map.GetBestMapForUnit = function() return nil end
GetRealZoneText = function() return "Lion's Pride Inn" end
GetZoneText = function() return "Lion's Pride Inn" end
stub.world.skills = {}
Polestar.Engine.GetTabs = function() return {}, 0 end`;

test('leaving the world and logout read nothing: the entry changes only in seen', () => {
	const [out] = run(`
stub.advance(6)
local c = function() return PolestarDB.alts.chars["Testchar-Test Realm"] end
local function snap() local t = {} for k, v in pairs(c()) do if k ~= "seen" then t[k] = type(v) == "table" and #v or v end end return t end
local before = snap()
local seen = c().seen
stub.advance(30)
${WRONG}
stub.fire("PLAYER_LEAVING_WORLD")
stub.fire("PLAYER_LOGOUT")
emit({ before = before, after = snap(), bumped = c().seen > seen })`);
	assert.deepEqual(out.after, out.before);
	assert.equal(out.before.money, 124000);
	assert.equal(out.before.resting, true);
	assert.equal(out.before.zone, 'Darkshore');
	assert.equal(out.bumped, true);
});

test('leaving the world and logout leave a pending write alone', () => {
	const [out] = run(`
IsResting = function() return false end
stub.advance(6)
stub.world.setMoney(321)
stub.fire("PLAYER_LEAVING_WORLD")
stub.fire("PLAYER_LOGOUT")
emit(PolestarDB.alts.chars["Testchar-Test Realm"].money)`);
	assert.equal(out, 124000, 'the pending write would read the same bad values');
});

test('with no entry yet, logout makes none', () => {
	const [out] = run(`
PolestarDB.alts = nil
stub.fire("PLAYER_LOGOUT")
emit(PolestarDB.alts == nil or next(PolestarDB.alts.chars) == nil)`);
	assert.equal(out, true);
});

test('PLAYER_QUITING and PLAYER_CAMPING each write the in-world values at once and retire the pending timer', () => {
	const [out] = run(`
IsResting = function() return false end
local writes = 0
local write = Alts.Write
Alts.Write = function(...) writes = writes + 1; return write(...) end
stub.advance(6)
writes = 0
local c = function() return PolestarDB.alts.chars["Testchar-Test Realm"] end
local got = {}
stub.world.setMoney(33)
stub.fire("PLAYER_QUITING")
got.quiting = { c().money, writes }
stub.world.setMoney(44)
stub.fire("PLAYER_CAMPING")
got.camping = { c().money, writes }
stub.advance(30)
got.after = writes
emit(got)`);
	assert.deepEqual(out.quiting, [33, 1]);
	assert.deepEqual(out.camping, [44, 2]);
	assert.equal(out.after, 2, 'no timer fires after them');
});

test('resting: a money and an XP change write at once (no timer)', () => {
	const [out] = run(`
stub.advance(6)
local writes = 0
local write = Alts.Write
Alts.Write = function(...) writes = writes + 1; return write(...) end
local c = function() return PolestarDB.alts.chars["Testchar-Test Realm"] end
stub.world.setMoney(77)
local a = { writes, c().money }
stub.world.setXP(2500, 4000)
local b = { writes, c().xp }
stub.advance(30)
emit({ a = a, b = b, after = writes })`);
	assert.deepEqual(out.a, [1, 77]);
	assert.deepEqual(out.b, [2, 2500]);
	assert.equal(out.after, 2, 'no timer');
});

test('not resting: they coalesce', () => {
	const [out] = run(`
IsResting = function() return false end
stub.advance(6)
local writes = 0
local write = Alts.Write
Alts.Write = function(...) writes = writes + 1; return write(...) end
local c = function() return PolestarDB.alts.chars["Testchar-Test Realm"] end
stub.world.setMoney(77)
stub.world.setXP(2500, 4000)
local early = { writes, c().money }
stub.advance(11)
emit({ early = early, late = { writes, c().money, c().xp } })`);
	assert.deepEqual(out.early, [0, 124000]);
	assert.deepEqual(out.late, [1, 77, 2500]);
});

test('PLAYER_UPDATE_RESTING writes resting at once', () => {
	const [out] = run(`
stub.advance(6)
IsResting = function() return false end
stub.fire("PLAYER_UPDATE_RESTING")
local off = PolestarDB.alts.chars["Testchar-Test Realm"].resting
IsResting = function() return true end
stub.fire("PLAYER_UPDATE_RESTING")
emit({ off = off == nil, on = PolestarDB.alts.chars["Testchar-Test Realm"].resting })`);
	assert.deepEqual(out, { off: true, on: true });
});

test('indoors the zone is the zone, not the inn\'s name', () => {
	const [out] = run(`
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 0, right = 1, top = 0, bottom = 1 })
w.moveTo(1429, 50, 50)
GetZoneText = function() return "Lion's Pride Inn" end
GetRealZoneText = function() return "Elwynn Forest" end
Alts.Write()
local mapBased = PolestarDB.alts.chars["Testchar-Test Realm"].zone
C_Map.GetBestMapForUnit = function() return nil end
Alts.Write()
emit({ mapBased = mapBased, fallback = PolestarDB.alts.chars["Testchar-Test Realm"].zone })`);
	assert.equal(out.mapBased, 'Elwynn Forest');
	assert.equal(out.fallback, 'Elwynn Forest', 'GetRealZoneText before GetZoneText');
});

test('a readable 0 copper is stored as 0', () => {
	const [out] = run(`
stub.advance(6)
stub.world.money = 0
Alts.Write()
emit(PolestarDB.alts.chars["Testchar-Test Realm"].money)`);
	assert.equal(out, 0);
});
