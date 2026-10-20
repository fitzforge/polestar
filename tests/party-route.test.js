'use strict';
// Quests/PartyRoute.lua: the party leader's route choices (answers at group
// quests, dungeons for leveling guides), shared through hidden addon messages
// so the party takes one route; and the guide window's banner that offers them.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Quests/Party.lua', 'Quests/PartyRoute.lua'];

function run(script, { saved, files = FILES } = {}) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_party.lua'],
		saved: saved ? { Polestar: saved } : undefined,
		addons: [{ name: 'Polestar', files }],
		login: true,
		script: `local PR, p, E = Polestar.PartyRoute, stub.party, Polestar.Engine
local function texts()
	local out = {}
	for _, s in ipairs(p.sent) do if s.text:sub(1, 2) == "R2" then out[#out + 1] = s.text end end
	return out
end
local routes = {}
Polestar.On("PARTY_ROUTE", function(r) routes[#routes + 1] = r end)
local function answers()
	local out = {}
	for q, a in pairs(PR.Mine().answers) do out[#out + 1] = q .. a end
	table.sort(out)
	return out
end
${script}`,
	}).emitted;
}

const SHARE = 'PolestarDB = { schema = 1, settings = { party = { routeShare = true } } }';

test('party route: messages round-trip the answers and dungeons; each fits a message; malformed text is refused', () => {
	const [small, back, big, bad] = run(`
		local t = PR.Encode({ answers = { [7] = "do", [91752] = "skip" }, maps = { 33, 36 } }, 5)
		emit(t)
		local k1, s1, n, maps = PR.Decode(t[1])
		local k2, s2, i, a = PR.Decode(t[2])
		emit({ k1 = k1, s1 = s1, n = n, maps = maps, k2 = k2, s2 = s2, i = i, a7 = a[7], a91752 = a[91752] })
		local many = {}
		for q = 100000, 100099 do many[q] = "do" end
		local bt, longest = PR.Encode({ answers = many, maps = {} }, 999), 0
		for _, x in ipairs(bt) do longest = math.max(longest, #x) end
		local got = 0
		for j = 2, #bt do local _, _, _, ans = PR.Decode(bt[j]); for _ in pairs(ans) do got = got + 1 end end
		emit({ n = #bt, longest = longest, got = got })
		emit({ PR.Decode("R2|1|1|33,x") == nil, PR.Decode("R2|1|11|") == nil, PR.Decode("R2A|1|1|7x") == nil,
			PR.Decode("R1|group|33") == nil, PR.Decode(PR.ASK) == nil, PR.Decode("1S|33:1/2") == nil })`);
	assert.deepEqual(small, ['R2|5|1|33,36', 'R2A|5|1|7d,91752s']);
	assert.deepEqual(back, { k1: 'route', s1: 5, n: 1, maps: [33, 36], k2: 'answers', s2: 5, i: 1, a7: 'do', a91752: 'skip' });
	assert.ok(big.n > 2, 'a hundred answers take more than one part');
	assert.ok(big.longest <= 255, `every message fits (${big.longest})`);
	assert.equal(big.got, 100);
	assert.deepEqual(bad, [true, true, true, true, true, true]);
});

test('party route: the leader sends the choices when they change and when asked; not while off, not when not leading', () => {
	const [changed, asked, notLeading, off] = run(`
		p.join("Ana")
		stub.advance(5)
		p.sent = {}
		E.AnswerGroup(7, "do")
		E.ChooseDungeon(33, true)
		stub.advance(2)
		emit(texts())
		p.sent = {}
		p.receive("Ana-TestRealm", PR.ASK)
		stub.advance(2)
		emit(texts())
		p.lead("Ana")
		p.sent = {}
		E.AnswerGroup(7, "skip")
		stub.advance(2)
		emit(texts())
		p.lead()
		Polestar.Set("party.routeShare", false)
		p.sent = {}
		E.AnswerGroup(8, "do")
		stub.advance(2)
		emit(texts())`, { saved: SHARE });
	assert.deepEqual(changed, ['R2|2|1|33', 'R2A|2|1|7d'], 'one route for both changes (route 1 went out at the join)');
	assert.deepEqual(asked, ['R2|3|1|33', 'R2A|3|1|7d']);
	assert.deepEqual(notLeading, ['R2Q|'], 'a member asks the new leader instead');
	assert.equal(Object.keys(off).length, 0);
});

test('party route: the answer for all group quests counts as an answer at each; a quest answered one by one keeps its own', () => {
	const [mine] = run(`
		E.GroupQuests = function() return { { quest = 7 }, { quest = 8 } } end
		E.AnswerGroup(8, "skip")
		Polestar.Set("behavior.groupQuests", "do")
		emit(answers())`);
	assert.deepEqual(mine, ['7do', '8skip']);
});

test('party route: a member asks after joining; the leader\'s differing route is offered once it has every part; a member\'s is ignored', () => {
	const [askedOnJoin, partial, offered, again, fromMember, same] = run(`
		p.join("Ana")
		p.lead("Ana")
		p.sent = {}
		stub.advance(5)
		p.join("Ben")
		stub.advance(5)
		emit(#texts() > 0 and texts()[1] or false)
		p.receive("Ana-TestRealm", "R2|4|2|33")
		p.receive("Ana-TestRealm", "R2A|4|1|7d")
		emit(#routes)
		p.receive("Ana-TestRealm", "R2A|4|2|8s")
		emit({ n = #routes, leader = routes[1].leader, a7 = routes[1].answers[7], a8 = routes[1].answers[8], maps = routes[1].maps })
		p.receive("Ana-TestRealm", "R2|5|2|33")
		p.receive("Ana-TestRealm", "R2A|5|1|7d")
		p.receive("Ana-TestRealm", "R2A|5|2|8s")
		emit(#routes)
		p.receive("Ben-TestRealm", "R2|9|0|36")
		emit(#routes)
		E.AnswerGroup(7, "do")
		p.receive("Ana-TestRealm", "R2|6|1|")
		p.receive("Ana-TestRealm", "R2A|6|1|7d")
		emit(#routes)`);
	assert.equal(askedOnJoin, 'R2Q|');
	assert.equal(partial, 0, 'nothing until every part has come');
	assert.deepEqual(offered, { n: 1, leader: 'Ana', a7: 'do', a8: 'skip', maps: [33] });
	assert.equal(again, 1, 'the same route, sent again, is offered once');
	assert.equal(fromMember, 1, 'only the leader sets the route');
	assert.equal(same, 1, 'a route that changes nothing is not offered');
});

test('party route: taking it sets the leader\'s answers and dungeons; "Take it" does so at once; "Ignore it" never', () => {
	const [taken, followed, ignored] = run(`
		p.join("Ana")
		p.lead("Ana")
		E.ChooseDungeon(36, true)
		E.AnswerGroup(9, "do")
		PR.Take({ answers = { [7] = "do", [8] = "skip" }, maps = { 33 } })
		emit({ a = answers(), m = PR.Mine().maps })
		Polestar.Set("party.routeFollow", "follow")
		p.receive("Ana-TestRealm", "R2|1|1|48")
		p.receive("Ana-TestRealm", "R2A|1|1|8d")
		emit({ a = answers(), m = PR.Mine().maps, offers = #routes })
		Polestar.Set("party.routeFollow", "off")
		p.receive("Ana-TestRealm", "R2|2|1|")
		p.receive("Ana-TestRealm", "R2A|2|1|7s")
		emit({ a = answers(), offers = #routes })`);
	assert.deepEqual(taken, { a: ['7do', '8skip', '9do'], m: [33] }, 'Deadmines (36) off, Shadowfang Keep (33) on; 9 is kept');
	assert.deepEqual(followed, { a: ['7do', '8do', '9do'], m: [48], offers: 0 });
	assert.deepEqual(ignored, { a: ['7do', '8do', '9do'], offers: 0 });
});

test('party route: the banner names the leader and the route, and takes it', () => {
	const [out] = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: `uistub.install()\nstub.login()\nlocal B = Polestar.UI.GuideFrame.parts.banner\nuistub.openTabs({ { uistub.elwynn, 3 } }, 1)
local took
Polestar.PartyRoute = { Take = function(r) took = r.leader end }
Polestar.Fire("PARTY_ROUTE", { leader = "Ana", answers = { [7] = "do", [8] = "do", [9] = "skip" }, maps = {} })
local text, jump = B.Text:GetText(), B.Jump.Label:GetText()
B.Jump:Click()
Polestar.Fire("PARTY_ROUTE", { leader = "Ana", answers = {}, maps = {} })
emit({ text = text, jump = jump, took = took, plain = B.Text:GetText() })`,
	}).emitted;
	assert.equal(out.text, 'Ana leads the party.\nGroup quests: 2 with the group, 1 skipped.\nTake the same route?');
	assert.equal(out.jump, 'Take it');
	assert.equal(out.took, 'Ana');
	assert.equal(out.plain, 'Ana leads the party.\nNo group quests or dungeons.\nTake the same route?');
});
