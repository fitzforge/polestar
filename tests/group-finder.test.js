'use strict';
// The group finder (Polestar/Quests/GroupFinder.lua, the folder Polestar_GroupFinder; docs/ARCHITECTURE.md,
// "Group Finder") on the whole addon in Elwynn Forest: you on Kobold Camp Cleanup (0/10), Ana and Bo who run
// Polestar on it too, their messages arriving on the finder's hidden channel (tests/lua/stub_groupfinder.lua).
// What leaves the client (addon messages, chat lines, invitations) is read from the stubs, never the settings.

const test = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const SETUP = `
w, p, g = stub.world, stub.party, stub.groupfinder
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48.5, 42.5)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
stub.advance(1)
GF = Polestar.GroupFinder
-- A search (S) from a player who runs it: their quest 7 at 3/10, the same language and faction as you.
function heard(name, flags, size, quests)
	g.search(name .. "-TestRealm", "S|" .. (name == "Ana" and "a1b2c3" or "d4e5f6") .. "|1429|490|430|5|MAGE|" .. (size or 0) .. "|" .. (flags or "A") .. "|e|" .. (quests or "7:k@3/10"))
	stub.advance(3)
end
function sent(chatType, kind)
	local n = 0
	for _, m in ipairs(p.sent) do
		if m.prefix == "PSGF" and m.chatType == chatType and (not kind or m.text:sub(1, 1) == kind) then n = n + 1 end
	end
	return n
end
function said(chatType)
	local out = {}
	for _, c in ipairs(p.chat) do if c.chatType == chatType then out[#out + 1] = c.text end end
	return out
end
`;

function run(script, opts = {}) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_party.lua', 'stub_groupfinder.lua'],
		addons: ['Polestar'],
		login: true,
		saved: opts.saved,
		script: `${SETUP}\n${script}`,
	}).emitted;
}

test('off by default: nothing loaded, joined or sent, no guide menu row; turned on, the row', () => {
	const [loaded, joined, sentAny, rows, row] = run(`
emit(GF.loaded == true)
emit(g.channels.PSGroupFinder ~= nil)
emit(#p.sent)
emit(#GF.MenuItems())
Polestar.Set("groupFinder.enabled", true)
emit(GF.MenuItems()[1].text)
`);
	assert.equal(loaded, false);
	assert.equal(joined, false);
	assert.equal(sentAny, 0);
	assert.equal(rows, 0);
	assert.equal(row, 'Group Finder');
});

test('the message box switch is the messages\' too: off, no whisper on Invite and no Announce button', () => {
	const [whispers, announce] = run(`
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
heard("Ana")
Polestar.Set("groupFinder.partyBox", false)
GF.Private.Widgets.Invite(GF.Private.Matcher.Get("Ana-TestRealm"))
emit(#said("WHISPER"))
GF.Show()
GF.Private.UI.Refresh()
emit(GF.Private.UI.AnnounceButton():IsShown())
`);
	assert.equal(whispers, 0);
	assert.equal(announce, false);
});

test('turned on: the folder loads and joins its hidden channel, and still sends nothing on its own', () => {
	const [loaded, joined, sentAny] = run(`
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
emit(GF.loaded == true)
emit(g.channels.PSGroupFinder ~= nil)
emit(#p.sent)
`);
	assert.equal(loaded, true);
	assert.equal(joined, true);
	assert.equal(sentAny, 0);
});

test('on at login: loaded with Polestar, as the player left it', () => {
	const [loaded] = run('emit(GF.loaded == true)', { saved: { Polestar: 'PolestarDB = { schema = 1, settings = { groupFinder = { enabled = true } } }' } });
	assert.equal(loaded, true);
});

test('a player searching for your quest is listed; answered only with "Let others find me" on', () => {
	const [found, quiet, answered] = run(`
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
heard("Ana")
emit(GF.Found())
emit(sent("WHISPER", "R"))
Polestar.Set("groupFinder.autoReply", true)
heard("Bo")
emit(sent("WHISPER", "R"))
`);
	assert.deepEqual(found, ['Ana-TestRealm']);
	assert.equal(quiet, 0);
	assert.equal(answered, 1);
});

test('Find a group sends your quests on the hidden channel, only on the click', () => {
	const [before, after, text] = run(`
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
emit(sent("CHANNEL", "S"))
GF.Search()
emit(sent("CHANNEL", "S"))
local last
for _, m in ipairs(p.sent) do if m.text:sub(1, 1) == "S" then last = m.text end end
emit(last:match("|([^|]*)$"))
`);
	assert.equal(before, 0);
	assert.equal(after, 1);
	assert.equal(text, '7:k@0/10');
});

test('Invite: the invitation and its whisper; the group forms, the box offers hello, and Say hello says it', () => {
	const [invited, whisper, mode, hello] = run(`
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
GF.Search()
heard("Ana")
local W = GF.Private.Widgets
W.Invite(GF.Private.Matcher.Get("Ana-TestRealm"))
emit(g.invited)
emit(said("WHISPER")[1])
p.join("Ana", "TestRealm")
p.onQuest.Ana = { [7] = true }
stub.advance(2)
emit(GF.Private.PartyBox.Mode())
GF.Hello()
emit(said("PARTY")[1])
`);
	assert.deepEqual(invited, ['Ana-TestRealm']);
	assert.match(whisper, /^Hi! I'm on .*Kobold Camp Cleanup.* too, I've sent you an invite\.$/);
	assert.equal(mode, 'hello');
	assert.match(hello, /^Hi all! I'm on .*Kobold Camp Cleanup.* 0\/10 Kobold Vermin slain\.$/);
});

test('a message turned off, or its text emptied, is never said', () => {
	const [off, empty] = run(`
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
heard("Ana")
local W, M = GF.Private.Widgets, GF.Private.Matcher
Polestar.Set("groupFinder.inviteOn", false)
W.Invite(M.Get("Ana-TestRealm"))
emit(#said("WHISPER"))
Polestar.Set("groupFinder.inviteOn", true)
Polestar.Set("groupFinder.inviteMsg", "")
W.Invite(M.Get("Ana-TestRealm"))
emit(#said("WHISPER"))
`);
	assert.equal(off, 0);
	assert.equal(empty, 0);
});

test('a player of another language is left out, unless All languages', () => {
	const [left, all] = run(`
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
g.search("Cy-TestRealm", "S|aaaaaa|1429|490|430|5|MAGE|0|A|f|7:k@3/10")
stub.advance(3)
emit(#GF.Found())
Polestar.Set("groupFinder.acceptAll", true)
g.search("Cy-TestRealm", "S|aaaaaa|1429|490|430|5|MAGE|0|A|f|7:k@3/10")
stub.advance(3)
emit(#GF.Found())
`);
	assert.equal(left, 0);
	assert.equal(all, 1);
});

test('in a group led by someone else, Invite is greyed with the reason', () => {
	const [why] = run(`
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
heard("Ana")
p.join("Bo", "TestRealm")
UnitIsGroupLeader = function() return false end
C_PartyInfo.CanInvite = function() return false end
emit(GF.Private.Widgets.InviteBlocked(GF.Private.Matcher.Get("Ana-TestRealm")))
`);
	assert.equal(why, 'Only your group leader can invite.');
});

test('the Group Finder page: the text control saves a message on Enter, a right-click puts the default back', () => {
	const [kinds, savedText, back] = run(`
assert(Polestar.UI.LoadOptions())
local kinds = {}
for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
	if spec.key == "groupfinder" then for _, c in ipairs(spec.controls or {}) do kinds[c.kind] = (kinds[c.kind] or 0) + 1 end end
end
emit(kinds)
local row = Polestar.UI.Options.Control(UIParent, { kind = "text", key = "groupFinder.helloMsg", label = "Hello message" })
row.Box:SetText("Yo {quests}!")
row.Box:GetScript("OnEditFocusLost")(row.Box)
emit(Polestar.Get("groupFinder.helloMsg"))
row:GetScript("OnClick")(row, "RightButton")
emit(Polestar.Get("groupFinder.helloMsg"))
`);
	assert.equal(kinds.text, 5);
	assert.equal(kinds.cards, 1);
	assert.equal(savedText, 'Yo {quests}!');
	assert.equal(back, "Hi all! I'm on {progress}.");
});

test('the guide window: a "players on this quest" button on the kill goal while the finder is on, gone while off', () => {
	const [off, on, panel, searched, backOff] = run(`
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide({ id = "test/kobolds", pack = "test", title = "Kobolds", minLevel = 1, maxLevel = 10, steps = {
	{ title = "Kobolds", goals = { { t = "kill", quest = 7, oi = 1, target = "Kobold Vermin", count = 10, map = 1429, x = 47, y = 35 } } },
	{ goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
} })
Polestar.Engine.SetGuide("test/kobolds")
stub.advance(1)
local function button()
	for _, r in ipairs(Polestar.Theme.GuideParts().rows or {}) do
		if r:IsShown() and r.psGoal and r.psGoal.quest == 7 and r.psGoal.t == "kill" then return r.Finder end
	end
end
emit(button() ~= nil and button():IsShown())
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
emit(button() ~= nil and button():IsShown())
button():GetScript("OnClick")(button())
stub.advance(1)
emit(GF.Private.UI.IsShown())
emit(sent("CHANNEL", "S"))
Polestar.Set("groupFinder.enabled", false)
stub.advance(1)
emit(button() ~= nil and button():IsShown())
`);
	assert.equal(off, false);
	assert.equal(on, true);
	assert.equal(panel, true);
	assert.equal(searched, 1);
	assert.equal(backOff, false);
});

test('a quest menu\'s row: any quest of the log, while the finder is on, searched alone', () => {
	const [off, on, notInLog, list] = run(`
w.accept(40, { { text = "Mining Tools: 0/4", type = "item", required = 4 } }, "Good Steel")
stub.advance(1)
emit(GF.QuestMenuWanted(40))
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
emit(GF.QuestMenuWanted(40))
emit(GF.QuestMenuWanted(999))
GF.FindFor(40)
local last
for _, m in ipairs(p.sent) do if m.text:sub(1, 1) == "S" then last = m.text end end
emit(last:match("|([^|]*)$"))
`);
	assert.equal(off, false);
	assert.equal(on, true);
	assert.equal(notInLog, false);
	assert.equal(list, '40:l@0/4');
});

test('the panel opens on Find a group; its cog opens the quick settings, without the finder\'s own switch', () => {
	const [search, keys, shown] = run(`
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
GF.Show()
local UI = GF.Private.UI
emit(UI.SearchButton():IsShown())
UI.ToggleSettings()
local keys = {}
for k in pairs(Polestar.UI.QuickSettings.New and _G.PolestarGroupFinderQuick and _G.PolestarGroupFinderQuick.rows or {}) do keys[#keys + 1] = k end
table.sort(keys)
emit(keys)
emit(UI.SettingsShown())
`);
	assert.equal(search, true);
	assert.deepEqual(keys, ['groupFinder.autoGroup', 'groupFinder.autoReply', 'groupFinder.autoRetry', 'groupFinder.openNear', 'groupFinder.partyBox']);
	assert.equal(shown, true);
});

test('the quick settings show no reset to default, even off their defaults', () => {
	const [reset] = run(`
Polestar.Set("groupFinder.enabled", true)
Polestar.Set("groupFinder.autoReply", true)
stub.advance(8)
GF.Show()
GF.Private.UI.ToggleSettings()
local row = _G.PolestarGroupFinderQuick.rows["groupFinder.autoReply"]
local b = rawget(row, "ResetB")
emit(b ~= nil and b:IsShown() or row.ModDot:IsShown())
`);
	assert.equal(reset, false);
});

test('the panel stands on its own: anchored to the screen, its width from its grip, its buttons following it', () => {
	const [anchor, before, after, saved] = run(`
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
GF.Show()
local UI = GF.Private.UI
local f = PSGroupFinderPanel
local _, rel = f:GetPoint(1)
emit(rel == UIParent or rel == nil)
emit(math.floor(UI.SearchButton():GetWidth()))
f.psSizing = true
f:SetWidth(500)
UI.Refresh()
emit(math.floor(UI.SearchButton():GetWidth()))
f.psSizing = nil
Polestar.Set("groupFinder.panelWidth", 500)
emit(Polestar.Get("groupFinder.panelWidth"))
`);
	assert.equal(anchor, true);
	assert.equal(before, 316);
	assert.equal(after, 476);
	assert.equal(saved, 500);
});

test('a search for one quest: the panel names it, and the quest done ends the search at once', () => {
	const [named, label, stops, over] = run(`
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
GF.FindFor(7)
local UI = GF.Private.UI
UI.Refresh()
emit(UI.ForQuest():IsShown())
emit(UI.ForQuest():GetText():find("Kobold Camp Cleanup", 1, true) ~= nil)
w.progress(7, 1, 10)
stub.advance(3)
local x = 0
for _, m in ipairs(p.sent) do if m.text:sub(1, 1) == "X" then x = x + 1 end end
emit(x)
UI.Refresh()
emit(not GF.Private.Session.Active() and not UI.ForQuest():IsShown())
`);
	assert.equal(named, true);
	assert.equal(label, true);
	assert.ok(stops >= 1, 'the end is told on the channel');
	assert.equal(over, true);
});

test('Stop ends everything at once: no Stop, no wait, Find a group back', () => {
	const [stop, enabled, label] = run(`
Polestar.Set("groupFinder.enabled", true)
stub.advance(8)
GF.Show()
local UI = GF.Private.UI
GF.Search()
UI.Refresh()
GF.Private.Comm.StopSearch()
UI.Refresh()
emit(UI.StopShown())
emit(UI.SearchButton():IsEnabled())
emit(UI.SearchButton():GetText())
`);
	assert.equal(stop, false);
	assert.equal(enabled, true);
	assert.equal(label, 'Find a group');
});
