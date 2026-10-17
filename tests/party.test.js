'use strict';
// Quests/Party.lua: quest progress shared with the party through hidden addon
// messages, against the fake client (tests/lua/stub_world.lua for the quest
// log, tests/lua/stub_party.lua for the group and the addon channel). Quest
// IDs and counts only, so players on other guides or other languages agree.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Quests/Party.lua'];

// Both switches start off; most tests play a player who turned them on.
const ON = 'PolestarDB = { schema = 1, settings = { party = { share = true, show = true } } }';

function run(script, { stubs = ['stub_world.lua'], files = FILES, login = false, before = '', saved = ON } = {}) {
	return runAddon({
		stubs,
		before,
		saved: saved ? { Polestar: saved } : undefined,
		addons: [{ name: 'Polestar', files }],
		login,
		script: `local P, w = Polestar.Party, stub.world\n${script}`,
	}).emitted;
}

test('party: a message round-trips quests, counts, a dropped quest and the snapshot mark', () => {
	const [msgs, snap, entries] = run(`
local msgs = P.Encode({ { q = 33, counts = { { 5, 8 }, { 0, 1 } } }, { q = 60, counts = false } }, true)
local snap, entries = P.Decode(msgs[1])
emit(msgs); emit(snap); emit(entries)`);
	assert.deepEqual(msgs, ['1S|33:5/8,0/1;60:-']);
	assert.equal(snap, true);
	assert.deepEqual(entries, [{ q: 33, counts: [[5, 8], [0, 1]] }, { q: 60, counts: false }]);
});

test('party: a full log splits into messages under 255 bytes, each one parsing alone', () => {
	const [out] = run(`
local entries = {}
for q = 1001, 1025 do
	local counts = {}
	for i = 1, 10 do counts[i] = { 999, 999 } end
	entries[#entries + 1] = { q = q, counts = counts }
end
local msgs = P.Encode(entries, true)
local res = { lengths = {}, snaps = {}, quests = {} }
for i, m in ipairs(msgs) do
	res.lengths[i] = #m
	local snap, got = P.Decode(m)
	res.snaps[i] = snap
	for _, e in ipairs(got) do res.quests[#res.quests + 1] = e.q end
end
emit(res)`);
	assert.ok(out.lengths.length > 1);
	for (const n of out.lengths) assert.ok(n <= 255, `message of ${n} bytes`);
	assert.deepEqual(out.snaps, out.lengths.map((_, i) => i === 0));
	assert.deepEqual(out.quests, Array.from({ length: 25 }, (_, i) => 1001 + i));
});

test('party: malformed text, another version and out-of-range counts are refused', () => {
	const eleven = Array.from({ length: 11 }, () => '1/2').join(',');
	const many = Array.from({ length: 41 }, (_, i) => `${i + 1}:1/2`).join(';');
	const bad = ['x', '', '2|33:1/2', '1|33:1000/2', '1|abc:1/2', '1|33:1/', '1|33', `1|33:${eleven}`, `1|${many}`];
	const out = run(bad.map((t) => `emit(P.Decode(${JSON.stringify(t)}) == nil)`).join('\n'));
	assert.deepEqual(out, bad.map(() => true));
});

test('party: a quest with no objectives is sent and read as an empty list', () => {
	const [msgs, n, q] = run(`
local msgs = P.Encode({ { q = 33, counts = {} } })
local _, entries = P.Decode(msgs[1])
emit(msgs); emit(#entries[1].counts); emit(entries[1].q)`);
	assert.deepEqual(msgs, ['1|33:']);
	assert.equal(n, 0);
	assert.equal(q, 33);
});

test('party: the log is read as quest id to counts', () => {
	const [log] = run(`
w.onQuest(33, { 8, 1 })
w.onQuest(60, {})
w.progress(33, 1, 5)
local out = {}
for q, s in pairs(P.ReadLog()) do out[tostring(q)] = s end
emit(out)`);
	assert.deepEqual(log, { 33: '5/8,0/1', 60: '' });
});

// Sending and receiving run with the party stub, logged in.
const LIVE = { stubs: ['stub_world.lua', 'stub_party.lua'], login: true };
const SENT = `
local p = stub.party
local function texts()
	local out = {}
	for i, m in ipairs(p.sent) do out[i] = m.text end
	return out
end`;

test('party: progress goes to the party 2 seconds after the log changes, once per burst', () => {
	const [before, after, chat] = run(`${SENT}
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
emit(texts())
w.progress(33, 1, 1); stub.advance(0.3)
w.progress(33, 1, 2); stub.advance(0.3)
w.progress(33, 1, 3)
stub.advance(2)
emit(texts())
emit(p.sent[#p.sent].chatType .. " " .. p.sent[#p.sent].prefix)`, LIVE);
	// Solo before, so we knew nobody's progress: the snapshot asks for theirs.
	assert.deepEqual(before, ['1R|33:0/8']);
	assert.deepEqual(after, ['1R|33:0/8', '1|33:3/8']);
	assert.equal(chat, 'PARTY Polestar');
});

test('party: unchanged quests are not sent again', () => {
	const [n] = run(`${SENT}
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
stub.fire("QUEST_LOG_UPDATE")
stub.advance(3)
emit(#p.sent)`, LIVE);
	assert.equal(n, 1);
});

test('party: a quest that leaves the log is sent as dropped', () => {
	const [last] = run(`${SENT}
w.onQuest(33, { 8 })
w.onQuest(60, { 2 })
p.join("Ana")
stub.advance(6)
w.abandon(33)
stub.advance(2)
emit(p.sent[#p.sent].text)`, LIVE);
	assert.equal(last, '1|33:-');
});

test('party: a member joining gets a snapshot within 6 seconds', () => {
	const [early, late] = run(`${SENT}
w.onQuest(33, { 8 })
w.onQuest(60, {})
p.join("Ana")
stub.advance(2.9)
emit(#p.sent)
stub.advance(3.2)
emit(texts())`, LIVE);
	assert.equal(early, 0);
	assert.deepEqual(late, ['1R|33:0/8;60:']);
});

test('party: a change while a snapshot is on its way goes out in the snapshot, not before it', () => {
	const [out] = run(`${SENT}
w.onQuest(33, { 8 })
w.onQuest(60, { 2 })
p.join("Ana")
stub.advance(0.5)
w.progress(33, 1, 1)
stub.advance(6)
emit(texts())`, LIVE);
	assert.deepEqual(out, ['1R|33:1/8;60:0/2']);
});

test('party: solo, in a raid, or with sharing off, none of your progress is sent', () => {
	const [solo, raid, off] = run(`${SENT}
w.onQuest(33, { 8 })
w.progress(33, 1, 2)
stub.advance(10)
emit(#p.sent)
p.join("Ana"); p.raid(true)
w.progress(33, 1, 3)
stub.advance(10)
emit(#p.sent)
p.disband()
Polestar.Set("party.share", false)
p.join("Ben")
w.progress(33, 1, 4)
stub.advance(10)
emit(texts())`, LIVE);
	assert.deepEqual([solo, raid], [0, 0]);
	assert.deepEqual(off, ['1Q|'], 'with showing on, only the request for theirs');
});

test('party: a refused send keeps the change for the next one, without retrying on its own', () => {
	const [attempts, last] = run(`${SENT}
w.onQuest(33, { 8 })
w.onQuest(60, { 4 })
p.join("Ana")
stub.advance(6)
p.result = Enum.SendAddonMessageResult.AddonMessageThrottle
w.progress(33, 1, 5)
stub.advance(10)
emit(#p.sent)
p.result = 0
w.progress(60, 1, 1)
stub.advance(2)
emit(p.sent[#p.sent].text)`, LIVE);
	assert.equal(attempts, 2);
	assert.equal(last, '1|33:5/8;60:1/4');
});

test('party: both settings off registers no events', () => {
	const [on, off] = run(`${SENT}
local EVENTS = { "GROUP_ROSTER_UPDATE", "GROUP_LEFT", "QUEST_LOG_UPDATE", "CHAT_MSG_ADDON" }
local function registered()
	local out = {}
	for _, ev in ipairs(EVENTS) do
		for _, f in ipairs(stub.frames) do
			if f.events and f.events[ev] then out[#out + 1] = ev break end
		end
	end
	return out
end
emit(registered())
Polestar.Set("party.share", false)
Polestar.Set("party.show", false)
emit(registered())`, LIVE);
	assert.ok(on.includes('CHAT_MSG_ADDON') && on.includes('GROUP_ROSTER_UPDATE'));
	assert.deepEqual(off.filter((e) => e !== 'QUEST_LOG_UPDATE'), []);
});

const MEMBERS = `
local function members()
	local out = {}
	for _, m in ipairs(P.Members()) do
		local qs = {}
		for q, counts in pairs(m.quests) do
			local parts = {}
			for i, c in ipairs(counts) do parts[i] = c[1] .. "/" .. c[2] end
			qs[#qs + 1] = q .. ":" .. table.concat(parts, ",")
		end
		table.sort(qs)
		out[#out + 1] = m.name .. " " .. table.concat(qs, ";")
	end
	return out
end`;

test('party: progress from a party member is kept by quest', () => {
	const [got] = run(`${SENT}${MEMBERS}
p.join("Ana")
p.receive("Ana-TestRealm", "1|33:5/8,0/1")
emit(members())`, LIVE);
	assert.deepEqual(got, ['Ana 33:5/8,0/1']);
});

test('party: a member on another realm is matched by name and realm', () => {
	const [got] = run(`${SENT}${MEMBERS}
p.join("Ben", "Other")
p.receive("Ben-Other", "1|60:2/4")
emit(members())`, LIVE);
	assert.deepEqual(got, ['Ben 60:2/4']);
});

test('party: messages from outside the party, from yourself, on another channel or prefix are ignored', () => {
	const [got] = run(`${SENT}${MEMBERS}
p.join("Ana")
p.receive("Zed-TestRealm", "1|33:5/8")
p.receive("Testchar-TestRealm", "1|33:5/8")
p.receive("Ana-TestRealm", "1|33:5/8", "GUILD")
p.receive("Ana-TestRealm", "1|33:5/8", "PARTY", "Other")
p.receive("Ana-TestRealm", "garbage")
emit(#P.Members())`, LIVE);
	assert.equal(got, 0);
});

test('party: a snapshot replaces what was known; a plain message merges', () => {
	const [merged, replaced] = run(`${SENT}${MEMBERS}
p.join("Ana")
p.receive("Ana-TestRealm", "1S|33:1/8")
p.receive("Ana-TestRealm", "1|60:2/4")
emit(members())
p.receive("Ana-TestRealm", "1S|60:3/4")
emit(members())`, LIVE);
	assert.deepEqual(merged, ['Ana 33:1/8;60:2/4']);
	assert.deepEqual(replaced, ['Ana 60:3/4']);
});

test('party: a dropped quest disappears', () => {
	const [got] = run(`${SENT}${MEMBERS}
p.join("Ana")
p.receive("Ana-TestRealm", "1|33:1/8;60:2/4")
p.receive("Ana-TestRealm", "1|33:-")
emit(members())`, LIVE);
	assert.deepEqual(got, ['Ana 60:2/4']);
});

test('party: a member who leaves is forgotten, and everyone when the group ends', () => {
	const [left, ended, again] = run(`${SENT}${MEMBERS}
p.join("Ana"); p.join("Ben")
p.receive("Ana-TestRealm", "1|33:1/8")
p.receive("Ben-TestRealm", "1|33:2/8")
p.leave("Ana")
emit(members())
p.disband()
emit(#P.Members())
p.join("Ana")
p.receive("Ana-TestRealm", "1|60:1/4")
emit(members())`, LIVE);
	assert.deepEqual(left, ['Ben 33:2/8']);
	assert.equal(ended, 0);
	assert.deepEqual(again, ['Ana 60:1/4']);
});

test('party: with showing off, incoming progress is ignored', () => {
	const [got] = run(`${SENT}
Polestar.Set("party.show", false)
p.join("Ana")
p.receive("Ana-TestRealm", "1|33:1/8")
emit(#P.Members())`, LIVE);
	assert.equal(got, 0);
});

test('party: a burst of messages refreshes the guide once', () => {
	const [fires] = run(`${SENT}
local fires = 0
Polestar.On("PARTY_PROGRESS", function() fires = fires + 1 end)
p.join("Ana")
for i = 1, 5 do p.receive("Ana-TestRealm", "1|33:" .. i .. "/8"); stub.advance(0.02) end
stub.advance(1)
emit(fires)`, LIVE);
	assert.equal(fires, 1);
});

test('party: after a reload in a party, the others are asked for their progress once', () => {
	const [mine, replies] = run(`${SENT}
p.members = { { name = "Ana", online = true } }
w.onQuest(33, { 8 })
stub.login()
stub.advance(6)
emit(texts())
p.sent = {}
stub.advance(10)
p.receive("Ana-TestRealm", "1R|60:1/4")
p.receive("Ana-TestRealm", "1R|60:1/4")
stub.advance(6)
emit(texts())`, { stubs: LIVE.stubs, login: false });
	assert.deepEqual(mine, ['1R|33:0/8']);
	assert.deepEqual(replies, ['1S|33:0/8']);
});

// What the guide shows, with the guide window's own files loaded.
const SHOWN = { stubs: LIVE.stubs, login: true, files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml', 'Quests/Party.lua'] };
const DOT = '  ·  ';

test('party: an objective goal lists party members\' counts', () => {
	const [line] = run(`${SENT}
p.join("Ben"); p.join("Ana")
p.receive("Ana-TestRealm", "1|33:5/8")
p.receive("Ben-TestRealm", "1|33:8/8")
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }))`, SHOWN);
	assert.equal(line, `Ana 5/8${DOT}Ben done`);
});

test('party: a member\'s count is read from the quest-log line the goal reads, not its compiled position (#335)', () => {
	// Slimy Menace in the game's order, Murloc first; the guide compiled Murloc as objective 2.
	const [murloc, streamrunner] = run(`${SENT}
w.onQuest(99128, { { text = "Murloc slain: 0/7", required = 7, type = "monster" }, { text = "Murloc Streamrunner slain: 0/4", required = 4, type = "monster" } })
p.join("Ana")
p.receive("Ana-TestRealm", "1|99128:3/7,1/4")
emit(P.Line({ t = "kill", quest = 99128, target = "Murloc", npc = 285, oi = 2, status = "active" }))
emit(P.Line({ t = "kill", quest = 99128, target = "Murloc Streamrunner", npc = 735, oi = 1, status = "active" }))`, SHOWN);
	assert.equal(murloc, 'Ana 3/7');
	assert.equal(streamrunner, 'Ana 1/4');
});

test('party: members without the quest, or showing off, add nothing', () => {
	const [other, off] = run(`${SENT}
p.join("Ana")
p.receive("Ana-TestRealm", "1|60:1/4")
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }) == nil)
p.receive("Ana-TestRealm", "1|33:1/8")
Polestar.Set("party.show", false)
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }) == nil)`, SHOWN);
	assert.deepEqual([other, off], [true, true]);
});

test('party: on a quest you have, its objective names party members who lack it, after their counts', () => {
	const [line, again, accept] = run(`${SENT}
w.onQuest(33, { 8 })
p.join("Ana"); p.join("Ben")
p.onQuest.Ana = { [33] = true }
p.onQuest.Ben = { [33] = false }
p.receive("Ana-TestRealm", "1|33:5/8")
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }))
emit(P.Line({ t = "kill", quest = 33, oi = 2, status = "active" }, true))
emit(P.Line({ t = "accept", quest = 33, status = "done" }) == nil)`, SHOWN);
	assert.equal(line, `Ana 5/8${DOT}Not on this quest: Ben`);
	assert.equal(again, null, 'a row above already names them');
	// Taking the quest moves the window past its accept.
	assert.equal(accept, true, 'not on the accept');
});

test('party: without the client\'s party check, synced members still count; unknown ones are not guessed', () => {
	const [line] = run(`${SENT}
p.noUnitQuestAPI()
w.onQuest(33, { 8 })
p.join("Ana"); p.join("Ben")
p.receive("Ana-TestRealm", "1|60:1/4")
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }))`, SHOWN);
	assert.equal(line, 'Not on this quest: Ana');
});

test('party: before you have the quest, no nudge', () => {
	const [none] = run(`${SENT}
p.join("Ben")
p.onQuest.Ben = { [33] = false }
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }) == nil)`, SHOWN);
	assert.equal(none, true);
});

test('party: the goal\'s grey line carries the party part', () => {
	const [sub] = run(`${SENT}
p.join("Ana")
p.receive("Ana-TestRealm", "1|33:5/8")
emit(Polestar.UI.GoalSubline({ t = "kill", quest = 33, oi = 1, status = "active" }))`, SHOWN);
	assert.equal(sub, 'Ana 5/8');
});

test('party: the Questing page has the two party switches, both off until turned on', () => {
	const [keys, share, show] = run(`
local keys = {}
Polestar.Widgets.OnOptionsRegistered(function(spec)
	for _, c in ipairs(spec.controls) do
		if c.key and c.key:sub(1, 6) == "party." then keys[#keys + 1] = spec.page .. "/" .. c.key end
	end
end)
emit(keys); emit(Polestar.Get("party.share")); emit(Polestar.Get("party.show"))`, { ...SHOWN, saved: null });
	assert.deepEqual(keys, ['Questing/party.share', 'Questing/party.show']);
	assert.deepEqual([share, show], [false, false]);
});

// Found by the final review (Codex and a fresh reviewer).

test('party: a 40-quest log reaches the party whole, at most 40 quests a message', () => {
	const [one, many] = run(`
local function entries(n)
	local out = {}
	for q = 1, n do out[q] = { q = q, counts = { { 1, 2 } } } end
	return out
end
local function decoded(msgs)
	local total, ok = 0, true
	for _, m in ipairs(msgs) do
		local snap, got = P.Decode(m)
		if snap == nil then ok = false else total = total + #got end
	end
	return { n = #msgs, total = total, ok = ok }
end
emit(decoded(P.Encode(entries(30), true)))
emit(decoded(P.Encode(entries(45), true)))`);
	assert.deepEqual(one, { n: 1, total: 30, ok: true });
	assert.deepEqual(many, { n: 2, total: 45, ok: true });
});

test('party: a refused snapshot is owed, and the next send is a full one', () => {
	const [last] = run(`${SENT}
w.onQuest(33, { 8 })
w.onQuest(60, { 4 })
p.result = Enum.SendAddonMessageResult.AddOnMessageLockdown
p.join("Ana")
stub.advance(6)
p.result = 0
w.progress(60, 1, 1)
stub.advance(2)
emit(p.sent[#p.sent].text)`, LIVE);
	assert.equal(last, '1R|33:0/8;60:1/4');
});

test('party: a member who goes offline leaves the line, and gets a snapshot when back', () => {
	const [gone, back] = run(`${SENT}${MEMBERS}
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
p.receive("Ana-TestRealm", "1|33:3/8")
p.connect("Ana", false)
emit(#P.Members())
p.sent = {}
p.connect("Ana", true)
stub.advance(6)
emit(texts())`, LIVE);
	assert.equal(gone, 0);
	// Back online with nobody else known: the snapshot asks for hers too.
	assert.deepEqual(back, ['1R|33:0/8']);
});

test('party: a member whose name is not known yet is not on the roster', () => {
	const [n] = run(`${SENT}
p.join("Unknown")
p.receive("Unknown-TestRealm", "1|33:3/8")
emit(#P.Members())`, LIVE);
	assert.equal(n, 0);
});

test('party: while the client keeps party names secret, the roster and what members sent stay as they were', () => {
	const [during, missing, after] = run(`${SENT}${MEMBERS}
p.join("Ana")
p.join("Ben")
p.receive("Ana-TestRealm", "1|33:5/8")
p.secretNames = true
stub.fire("GROUP_ROSTER_UPDATE")
p.receive("Ana-TestRealm", "1|33:6/8")
emit(members())
emit(#P.Missing(33))
p.secretNames = false
p.leave("Ben")
emit(members())`, LIVE);
	assert.deepEqual(during, ['Ana 33:6/8']);
	assert.equal(missing, 0, 'a member whose name is secret is not named');
	assert.deepEqual(after, ['Ana 33:6/8']);
});

test('party: turning sharing off tells the party to forget your counts; on again, it resyncs', () => {
	const [off, on, showOn] = run(`${SENT}
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
p.sent = {}
Polestar.Set("party.share", false)
w.progress(33, 1, 2)
stub.advance(10)
emit(texts())
p.sent = {}
Polestar.Set("party.share", true)
stub.advance(6)
emit(texts())
p.sent = {}
Polestar.Set("party.show", false)
Polestar.Set("party.show", true)
stub.advance(6)
emit(texts())`, LIVE);
	assert.deepEqual(off, ['1S|']);
	assert.deepEqual(on, ['1R|33:2/8']);
	assert.deepEqual(showOn, ['1R|33:2/8']);
});

test('party: turning sharing off before anything went out sends nothing', () => {
	const [sent] = run(`${SENT}
w.onQuest(33, { 8 })
p.join("Ana")
Polestar.Set("party.share", false)
stub.advance(10)
emit(texts())`, LIVE);
	// No empty snapshot: the party has nothing of ours to forget.
	assert.deepEqual(sent, ['1Q|']);
});

test('party: sharing turned off while a resync is on its way still clears what the party has', () => {
	const [sent] = run(`${SENT}
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
p.sent = {}
Polestar.Set("party.show", false)
Polestar.Set("party.show", true)
Polestar.Set("party.share", false)
stub.advance(10)
emit(texts())`, LIVE);
	assert.deepEqual(sent, ['1S|', '1Q|']);
});

test('party: sharing turned off right after a reload in a party clears what the party had from before it', () => {
	const [sent] = run(`${SENT}
p.members = { { name = "Ana", online = true } }
w.onQuest(33, { 8 })
stub.login()
Polestar.Set("party.share", false)
stub.advance(10)
emit(texts())`, { stubs: LIVE.stubs, login: false });
	assert.deepEqual(sent, ['1S|', '1Q|']);
});

test('party: showing without sharing asks for the party\'s progress and sends none of yours', () => {
	const [asked, kept, answered] = run(`${SENT}${MEMBERS}
Polestar.Set("party.share", false)
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
emit(texts())
p.receive("Ana-TestRealm", "1R|33:4/8")
w.progress(33, 1, 1)
stub.advance(3)
emit({ texts(), members() })
p.sent = {}
Polestar.Set("party.share", true)
stub.advance(6)
p.sent = {}
stub.advance(5)
p.receive("Ana-TestRealm", "1Q|")
stub.advance(6)
emit({ texts(), members() })`, LIVE);
	// After a reload or a join from solo: a bare request, nothing of ours.
	assert.deepEqual(asked, ['1Q|']);
	assert.deepEqual(kept, [['1Q|'], ['Ana 33:4/8']]);
	// A sharer answers a bare request; it changes nothing of the asker's counts.
	assert.deepEqual(answered, [['1S|33:1/8'], ['Ana 33:4/8']]);
});

test('party: a refused bare request is asked again when a member\'s quest log changes', () => {
	const [refused, again, once] = run(`${SENT}
Polestar.Set("party.share", false)
p.result = Enum.SendAddonMessageResult.AddonMessageThrottle
p.join("Ana")
stub.advance(6)
emit(texts())
p.result = 0
p.sent = {}
p.questLogChanged("Ana")
stub.advance(6)
emit(texts())
p.sent = {}
p.questLogChanged("Ana")
stub.advance(6)
emit(#p.sent)`, LIVE);
	assert.deepEqual(refused, ['1Q|']);
	assert.deepEqual(again, ['1Q|']);
	assert.equal(once, 0, 'once it went out, a log change asks nothing');
});

test('party: a bare request carries nothing', () => {
	const [ok, bad] = run(`
local snap, entries, asks = P.Decode("1Q|")
emit({ snap, #entries, asks })
emit(P.Decode("1Q|33:1/2") == nil)`);
	assert.deepEqual(ok, [false, 0, true]);
	assert.equal(bad, true);
});

test('party: a request soon after a snapshot the requester may have missed is answered', () => {
	const [replies] = run(`${SENT}
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
p.sent = {}
stub.advance(5)
p.receive("Ana-TestRealm", "1R|")
stub.advance(6)
emit(texts())`, LIVE);
	assert.deepEqual(replies, ['1S|33:0/8']);
});

test('party: a member on a realm whose name has a space is matched', () => {
	const [got] = run(`${SENT}${MEMBERS}
p.join("Ben", "Other Realm")
p.receive("Ben-OtherRealm", "1|60:2/4")
emit(members())`, LIVE);
	assert.deepEqual(got, ['Ben 60:2/4']);
});

test('party: a member who sent the quest is never listed as lacking it', () => {
	const [none] = run(`${SENT}
w.onQuest(33, { 8 })
p.join("Ben")
p.onQuest.Ben = { [33] = false }
p.receive("Ben-TestRealm", "1|33:0/8")
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }))`, SHOWN);
	assert.equal(none, 'Ben 0/8');
});

test('party: a member\'s quest log changing, or someone joining, refreshes the guide', () => {
	const [fires] = run(`${SENT}
local fires = 0
Polestar.On("PARTY_PROGRESS", function() fires = fires + 1 end)
p.join("Ben")
stub.advance(1)
p.questLogChanged("Ben")
stub.advance(1)
emit(fires)`, LIVE);
	assert.equal(fires, 2);
});
