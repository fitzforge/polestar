'use strict';
// Layer hop (QoL/Layer.lua): the layer id from creature GUIDs, hop requests as a
// channel line on click plus addon whispers, hosting, and the game's world refresh.
// Everything is inert while qol.layerHop is off.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };
const G = (layer) => `Creature-0-4372-0-${layer}-1234-0000ABCDEF`;

function run(script, { on = true } = {}) {
	return runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], login: true,
		script: `local Ly, lay, q, QoL = Polestar.QoL.Layer, stub.layer, stub.qol, Polestar.QoL
		local function set(k, v) Polestar.Set("qol." .. k, v); stub.runTimers() end
		local function wait(s) stub.advance(s) end
		local function hear(sender, msg) stub.fire("CHAT_MSG_ADDON", "PolestarLayer", msg, "WHISPER", sender) end
		local function line(sender, text, base) stub.channelLine(sender, text, base) end
		local function chat()
			local out = {}
			for _, c in ipairs(lay.chat) do out[#out + 1] = c[1] .. "@" .. c[2] .. ":" .. tostring(c[4]) end
			return out
		end
		local function sent(kind)
			local out = {}
			for _, s in ipairs(lay.sent) do if not kind or s[2]:sub(2, 2) == kind then out[#out + 1] = s[2] .. "@" .. s[3] .. ">" .. tostring(s[4]) end end
			return out
		end
		local function order()
			local out = {}
			for _, o in ipairs(lay.order) do if o:sub(1, 2) ~= "1H" then out[#out + 1] = o end end
			return out
		end
		local function calls(name)
			local out = {}
			for _, c in ipairs(q.calls) do if c[1] == name then out[#out + 1] = c[2] == nil and true or c[2] end end
			return out
		end
		local function rows(map)
			local out = {}
			for _, r in ipairs(Ly.Known(map)) do out[#out + 1] = { r.id, r.n, r.peers, r.hosts, r.mine } end
			return out
		end
		lay.guids.target = "${G(2)}"
		${on ? 'set("layerHop", true)' : ''}
		${script}` }).emitted;
}

test('layer hop: off by default, nothing joined, registered, filtered or sent; on joins, registers, filters, hides the channel and sends nothing; off leaves and unfilters', () => {
	const out = run(`
		local function d(k) return Polestar.GetDefault("qol." .. k) end
		emit({ d("layerHop"), d("layerHost"), d("layerAutoRefresh"), d("layerRefreshDelay"), d("layerLeaveAfter") })
		local watched = 0
		for _, e in ipairs({ "UPDATE_MOUSEOVER_UNIT", "NAME_PLATE_UNIT_ADDED", "SHARD_TRANSFER_IMMINENT", "SHARD_TRANSFER",
			"SHARD_TRANSFER_CANCELLED", "CHAT_MSG_ADDON", "CHAT_MSG_CHANNEL", "PARTY_INVITE_REQUEST", "GROUP_JOINED", "GROUP_LEFT" }) do
			if QoL.Watching(e) then watched = watched + 1 end
		end
		local toggles = 0
		Polestar.On("TOGGLE_LAYER_HOP", function() toggles = toggles + 1 end)
		stub.fire("PLAYER_TARGET_CHANGED")
		hear("Peerone", "1H1429:2:0")
		line("Reqone", "PLH1 Q 1429")
		lay.eviction = 60
		stub.fire("SHARD_TRANSFER_IMMINENT")
		local ok, why = Ly.Request("*")
		local okA, whyA = Ly.Ask()
		Polestar.RunCommand("layer")
		emit({ stub.messages[#stub.messages] })
		wait(4)
		emit({ watched, #lay.sent, #lay.chat, #lay.prefixes, #calls("JoinChannelByName"), lay.filters.CHAT_MSG_CHANNEL == nil,
			#calls("SendWho"), Ly.Current() == nil, #Ly.Known(1429), ok, why, okA, whyA, Ly.Status().on, Ly.Status().transfer, toggles })
		lay.eviction = nil
		set("layerHop", true)
		emit({ calls("JoinChannelByName"), lay.prefixes, type(lay.filters.CHAT_MSG_CHANNEL), calls("RemoveChannel"), #lay.sent, #lay.chat,
			QoL.Watching("CHAT_MSG_ADDON"), QoL.Watching("CHAT_MSG_CHANNEL"), Ly.Status().on })
		set("layerHop", false)
		line("Reqone", "PLH1 Q 1429")
		wait(4)
		emit({ calls("LeaveChannelByName"), lay.filters.CHAT_MSG_CHANNEL == nil, #lay.sent, #lay.chat, QoL.Watching("CHAT_MSG_CHANNEL"), Ly.Status().on })
	`, { on: false });
	assert.deepEqual(out[0], [false, false, false, 5, false]);
	assert.match(out[1][0], /Layer hop is off: turn it on/);
	assert.deepEqual(out[2], [0, 0, 0, 0, 0, true, 0, true, 0, false, 'Layer hop is off.', false, 'Layer hop is off.', false, 'none', 0]);
	assert.deepEqual(out[3], [['PolestarLayer'], ['PolestarLayer'], 'function', ['PolestarLayer'], 0, 0, true, true, true]);
	assert.deepEqual(out[4], [['PolestarLayer'], true, 0, 0, false, false]);
});

test('layer hop: a request sends one channel line inside the call, whispers the known hosts, then the zone /who names five a second', () => {
	const out = run(`
		hear("Hostone", "1H1429:10:1")
		hear("Peerone", "1H1429:10:0")
		lay.whoResults = { "Testchar", "Hostone", "Who One", "Who Two", "Who Three", "Who Four", "Who Five", "Who Six",
			"Who Seven", "Who Eight", "Who Nine", "Who Ten", "Who Two", "Who Secret" }
		lay.secret["Who Secret"] = true
		lay.sendResult["Who Three"] = 3
		local ok = Ly.Request("*")
		emit({ ok, chat(), sent(), lay.who, lay.whoToUi, Ly.Status().asked.reach, Ly.Status().asked.channel })
		wait(1.1)
		stub.whoAnswer()
		local first = sent()
		lay.sendResult["Who Three"] = nil
		wait(1.05)
		local second = #sent()
		wait(1.05)
		emit({ first, second, #sent(), Ly.Status().asked.reach, #lay.chat, lay.whoToUi })
		Ly.CancelRequest()
		local again = Ly.Request("*")
		emit({ again, #calls("SendWho"), #lay.chat })
	`);
	const R = (n) => `1R1429:2:*@WHISPER>${n}`;
	assert.deepEqual(out[0], [true, ['PLH1 R 1429:2:*@CHANNEL:5'], [R('Hostone')], ['z-"Durotar"', 1], true, 1, true]);
	assert.deepEqual(out[1], [[R('Hostone'), R('Who One'), R('Who Two'), R('Who Three')], 9, 12, 11, 1, false],
		'the throttled name ends the burst and goes first next second; itself, a known host, a repeat and a secret name are skipped; the /who goes back to chat');
	assert.deepEqual(out[2], [true, 1, 2], 'a /who within 10 s of the last is not sent');
	const group = run(`
		lay.whoResults = { "Who One", "Who Two", "Who Three", "Who Four", "Who Five", "Who Six", "Who Seven" }
		Ly.Request("*")
		stub.whoAnswer()
		local first = #lay.sent
		lay.group = 2
		stub.fire("GROUP_JOINED")
		wait(3)
		emit({ first, #lay.sent, Ly.Status().asked.reach })
	`);
	assert.deepEqual(group[0], [5, 5, 5], 'a group join stops the burst');
});

test('layer hop: with the channel index unknown a request joins, says so, still asks the zone, and the next click sends its line', () => {
	const out = run(`
		lay.channels, lay.joinPending = {}, true
		local ok, why = Ly.Request("*")
		local s = Ly.Status().asked
		emit({ ok, why, #calls("JoinChannelByName"), #lay.chat, #calls("SendWho"), s ~= nil and s.channel })
		lay.joinPending = false
		lay.channels.PolestarLayer = 5
		local ok2 = Ly.Request("*")
		emit({ ok2, chat(), Ly.Status().asked.channel, #calls("SendWho"), select(2, Ly.Request("*")) })
	`);
	assert.deepEqual(out[0], [false, 'Joining the layer channel; try again in a moment.', 2, 0, 1, false]);
	assert.deepEqual(out[1], [true, ['PLH1 R 1429:2:*@CHANNEL:5'], true, 1, 'A hop request is already waiting.']);
});

test('layer hop: a request is refused in a group, in a chat lockdown and while one waits', () => {
	const out = run(`
		lay.group = 2
		local _, w1 = Ly.Request("*")
		lay.group, lay.lockdown = 0, true
		local _, w2 = Ly.Request("*")
		lay.lockdown = false
		Ly.Request("*")
		local _, w3 = Ly.Request("*")
		emit({ w1, w2, w3, #lay.chat })
	`);
	assert.deepEqual(out[0], ['You are already in a group.', 'Chat is locked down; try again shortly.', 'A hop request is already waiting.', 1]);
});

test('layer hop: a host answers a channel or whispered request with a claim whisper and an invite; drops the rest; whispers its layer once per asker', () => {
	const out = run(`
		set("layerHost", true)
		line("Reqone", "PLH1 R 1429:10:*")
		hear("Reqone", "1R1429:10:*")
		wait(2.6)
		emit(order())
		lay.order = {}
		hear("Reqtwo", "1R1429:10:*")
		wait(2.6)
		emit(order())
		lay.order = {}
		line("Testchar", "PLH1 R 1429:10:*")
		line("Farone-OtherRealm", "PLH1 R 1429:10:*")
		line("Reqfour", "PLH1 R 1429:10:" .. string.rep("1", 120))
		for i = 1, 4 do line("Reqfive", "PLH1 Q 143" .. i) end
		line("Reqfive", "PLH1 R 1429:10:*")
		line("Reqsix", "PLH2 R 1429:10:*")
		line("Reqseven", "PLH1 X 1429:10:*")
		line("Reqeight", "PLH1 R 1429:10:*", "General")
		line("Reqnine", "PLH1 R 1429:2:*")
		q.social.combat.player = true
		line("Reqten", "PLH1 R 1429:10:*")
		wait(2.6)
		q.social.combat.player = nil
		lay.group, lay.leader = 2, false
		line("Reqeleven", "PLH1 R 1429:10:*")
		wait(2.6)
		lay.group = 0
		emit(order())
		lay.sent = {}
		line("Asker", "PLH1 Q 1429")
		line("Askertwo", "PLH1 Q 1430")
		wait(3)
		line("Asker", "PLH1 Q 1429")
		wait(3)
		local once = sent("H")
		stub.now = stub.now + 61
		line("Asker", "PLH1 Q 1429")
		wait(3)
		emit({ once, #sent("H") })
	`);
	assert.deepEqual(out[0], ['1IReqone@WHISPER>Reqone', 'invite:Reqone'], 'the line and the whisper of one request: one claim, one invite');
	assert.deepEqual(out[1], ['1IReqtwo@WHISPER>Reqtwo', 'invite:Reqtwo']);
	assert.deepEqual(out[2], {}, 'echo, other realm, oversize, flood, bad version, unknown kind, other channel, same layer, combat, not leader');
	assert.deepEqual(out[3], [['1H1429:2:1@WHISPER>Asker'], 2]);
});

test('layer hop: an asker accepts the invite of a host whose claim whisper names it; H whispers list peers; GUILD and CHANNEL addon messages are ignored', () => {
	const out = run(`
		Ly.Request("*")
		q.showPopup("PARTY_INVITE")
		stub.fire("PARTY_INVITE_REQUEST", "Stranger")
		stub.runTimers()
		local strangers = #calls("AcceptGroup")
		hear("Hostone", "1ITestchar")
		stub.fire("PARTY_INVITE_REQUEST", "Hostone")
		stub.runTimers()
		emit({ strangers, #calls("AcceptGroup") })
		hear("Peerone", "1H1429:10:0")
		hear("Hosttwo", "1H1429:10:1")
		hear("Peertwo", "1H1429:7:0")
		stub.fire("CHAT_MSG_ADDON", "PolestarLayer", "1H1429:8:0", "GUILD", "Guildy")
		stub.fire("CHAT_MSG_ADDON", "PolestarLayer", "1H1429:9:0", "CHANNEL", "Chanly")
		stub.fire("CHAT_MSG_ADDON", "PolestarLayer", "1ITestchar", "GUILD", "Hostthree")
		emit({ rows(1429), Ly.Expects("Hostthree") })
	`);
	assert.deepEqual(out[0], [0, 1]);
	assert.deepEqual(out[1], [[['2', 1, 0, 0, true], ['7', 2, 1, 0, false], ['10', 3, 2, 1, false]], false]);
});

test('layer hop: the chat filter hides PLH lines on the layer channel only', () => {
	const out = run(`
		local f = lay.filters.CHAT_MSG_CHANNEL
		local function try(text, base) return f(nil, "CHAT_MSG_CHANNEL", text, "Someone", "", "", "", "", 0, 1, base) end
		emit({ try("PLH1 R 1429::*", "PolestarLayer"), try("hello", "PolestarLayer"), try("PLH1 Q 1429", "General") })
	`);
	assert.deepEqual(out[0], [true, false, false]);
});

test('layer hop: names with a space are whispered to, invited and matched in a claim whole', () => {
	const out = run(`
		set("layerHost", true)
		line("Leffe Loo", "PLH1 R 1429:10:*")
		wait(2.6)
		local hosted = order()
		lay.whoResults = { "Anna Bell" }
		Ly.Request("*")
		stub.whoAnswer()
		local asked = sent("R")
		hear("Hosta Loo", "1ITestchar")
		local host = Ly.Expects("Hosta Loo")
		UnitName = function(u) if u == "player" then return "Testchar Loo" end end
		hear("Hostb Loo", "1ITestchar Loo")
		emit({ hosted, asked, host, Ly.Expects("Hostb Loo") })
	`);
	assert.deepEqual(out[0], [['1ILeffe Loo@WHISPER>Leffe Loo', 'invite:Leffe Loo'], ['1R1429:2:*@WHISPER>Anna Bell'], true, true]);
});
test('layer hop: the id is field 5 of a creature or vehicle GUID; players are ignored; labels follow numeric order; a map change forgets', () => {
	const out = run(`
		emit({ Ly.LAYER_FIELD, Ly.IdFromGUID("${G(10)}"), Ly.IdFromGUID("Vehicle-0-4372-0-7-99-00AB"),
			Ly.IdFromGUID("Player-4372-00ABCDEF") or false, Ly.IdFromGUID("Pet-0-4372-0-3-1-00AB") or false })
		local changes = 0
		Polestar.On("LAYER_CHANGED", function() changes = changes + 1 end)
		lay.guids.mouseover = "Player-4372-00ABCDEF"
		stub.fire("UPDATE_MOUSEOVER_UNIT")
		emit({ select(2, Ly.Current()), changes })
		lay.guids.nameplate3 = "${G(10)}"
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate3")
		local map, id = Ly.Current()
		emit({ map, id, rows(1429), Ly.Label(1429, "10"), Ly.Label(1429, "2"), changes })
		stub.fire("ZONE_CHANGED_NEW_AREA")
		emit({ Ly.Current() == nil, #Ly.Known(1429) })
	`);
	assert.deepEqual(out[0], [5, '10', '7', false, false]);
	assert.deepEqual(out[1], ['2', 0]);
	assert.deepEqual(out[2], [1429, '10', [['2', 1, 0, 0, false], ['10', 2, 0, 0, true]], 'Layer 2', 'Layer 1', 1]);
	assert.deepEqual(out[3], [true, 2]);
});

test('layer hop: with Decline other party invitations on, the claimed host\'s invite is accepted, not declined; a stranger\'s still is', () => {
	const out = run(`
		set("declinePartyStrangers", true)
		Ly.Request("*")
		hear("Hostone", "1ITestchar")
		stub.fire("PARTY_INVITE_REQUEST", "Hostone")
		local host = { #calls("AcceptGroup"), #calls("DeclineGroup"), Ly.Expects("Hostone"), Ly.Expects("Stranger") }
		stub.fire("PARTY_INVITE_REQUEST", "Stranger")
		emit({ host, #calls("AcceptGroup"), #calls("DeclineGroup") })
	`);
	assert.deepEqual(out[0], [[1, 0, true, false], 1, 1]);
});

test('layer hop: the world refresh is offered, confirmed out of combat, auto-confirmed only for an asked hop, with the dialog as fallback', () => {
	const offer = run(`
		lay.eviction = 300
		set("layerAutoRefresh", true)
		set("layerHop", true)
		emit({ Ly.Status().transfer, Ly.Status().secondsLeft })
		wait(10)
		emit({ #calls("ShardTransferConfirm"), math.floor(Ly.Status().secondsLeft + 0.5) })
		lay.eviction = 180
		stub.fire("SHARD_TRANSFER_IMMINENT")
		emit({ Ly.Status().transfer, Ly.Status().secondsLeft })
		q.social.combat.player = true
		local ok1, why1 = Ly.RefreshNow()
		q.social.combat.player = nil
		local ok2 = Ly.RefreshNow()
		emit({ ok1, why1, ok2, #calls("ShardTransferConfirm"), Ly.Status().transfer })
		wait(10.1)
		local ok3, why3 = Ly.RefreshNow()
		emit({ Ly.Status().transfer, #calls("StaticPopup_Show"), ok3, why3 })
	`, { on: false });
	assert.deepEqual(offer[0], ['offered', 300]);
	assert.deepEqual(offer[1], [0, 290], 'an offer nobody asked for is shown, never auto-confirmed');
	assert.deepEqual(offer[2], ['offered', 180]);
	assert.deepEqual(offer[3], [false, 'You are in combat.', true, 1, 'done']);
	assert.deepEqual(offer[4], ['none', 0, false, 'No world refresh is offered.']);

	const auto = run(`
		Ly.Request("*")
		hear("Hostone", "1ITestchar")
		stub.fire("PARTY_INVITE_REQUEST", "Hostone")
		lay.group = 2
		stub.fire("GROUP_JOINED")
		lay.eviction = 120
		stub.fire("SHARD_TRANSFER_IMMINENT")
		wait(8)
		local settingOff = #calls("ShardTransferConfirm")
		stub.fire("SHARD_TRANSFER_CANCELLED")
		local cancelled = Ly.Status().transfer
		set("layerAutoRefresh", true)
		set("layerRefreshDelay", 3)
		stub.fire("SHARD_TRANSFER_IMMINENT")
		wait(2.9)
		local early = #calls("ShardTransferConfirm")
		q.social.combat.player = true
		wait(0.2)
		local fought = #calls("ShardTransferConfirm")
		q.social.combat.player = nil
		wait(1.1)
		emit({ settingOff, cancelled, early, fought, #calls("ShardTransferConfirm"), Ly.Status().transfer })
	`);
	assert.deepEqual(auto[0], [0, 'none', 0, 0, 1, 'done']);

	const fallback = run(`
		lay.confirmErrors = true
		lay.eviction = 60
		stub.fire("SHARD_TRANSFER_IMMINENT")
		local ok = Ly.RefreshNow()
		emit({ ok, calls("StaticPopup_Show"), Ly.Status().transfer })
		lay.confirmErrors, lay.confirmFires = false, false
		Ly.RefreshNow()
		local mid = Ly.Status().transfer
		wait(3.1)
		emit({ mid, #calls("StaticPopup_Show"), Ly.Status().transfer })
		set("layerLeaveAfter", true)
		hear("Hostone", "1H1429:10:1")
		Ly.Request("10")
		stub.fire("PARTY_INVITE_REQUEST", "Hostone")
		lay.group = 2
		stub.fire("GROUP_JOINED")
		wait(2.1)
		local stayed = #calls("LeaveParty")
		stub.fire("SHARD_TRANSFER")
		local s = Ly.Status()
		wait(2.1)
		emit({ stayed, s.transfer, s.asked == nil, Ly.Current() == nil, #calls("LeaveParty") })
	`);
	assert.deepEqual(fallback[0], [true, ['SHARD_TRANSFER_IMMEDIATE'], 'offered']);
	assert.deepEqual(fallback[1], ['refreshing', 2, 'offered']);
	assert.deepEqual(fallback[2], [0, 'done', true, true, 1]);
});

test('layer hop: leaving the hop group ends it; a group joined by hand next is never left, by the command or a timer armed in the hop group', () => {
	const join = `
		set("layerLeaveAfter", true)
		Ly.Request("*")
		hear("Hostone", "1ITestchar")
		stub.fire("PARTY_INVITE_REQUEST", "Hostone")
		lay.group = 2
		stub.fire("GROUP_JOINED")
		local joined = Ly.Status().hopGroup`;
	const command = run(`${join}
		lay.inShard.player, lay.inShard.party1 = true, true
		local lines = #stub.messages
		lay.group = 0
		stub.fire("GROUP_LEFT")
		lay.group = 3
		stub.fire("GROUP_JOINED")
		local ok, why = Ly.LeaveGroup()
		local left = #calls("LeaveParty")
		wait(2.1)
		emit({ joined, ok, why, left, #stub.messages - lines, #calls("LeaveParty"), lay.group, Ly.Status().hopGroup })
	`);
	assert.deepEqual(command[0], [true, false, 'Not in a group joined for a layer hop.', 0, 0, 0, 3, false],
		'the command refuses, and the same-shard check armed at the hop join neither prints nor leaves');
	const timer = run(`${join}
		stub.fire("SHARD_TRANSFER")
		lay.group = 0
		stub.fire("GROUP_LEFT")
		lay.group = 3
		stub.fire("GROUP_JOINED")
		wait(2.1)
		emit({ joined, #calls("LeaveParty"), lay.group, Ly.Status().hopGroup })
	`);
	assert.deepEqual(timer[0], [true, 0, 3, false], 'the leave armed by the refresh in the hop group does not leave the new group');
});

test('layer hop: the same layer needs both the player and the host on the party\'s shard; the host alone there means a refresh is coming', () => {
	const out = run(`
		set("layerLeaveAfter", true)
		Ly.Request("*")
		hear("Hostone", "1ITestchar")
		stub.fire("PARTY_INVITE_REQUEST", "Hostone")
		lay.group, lay.inShard.party1 = 2, true
		local lines = #stub.messages
		stub.fire("GROUP_JOINED")
		wait(2.1)
		emit({ Ly.Status().asked ~= nil, #stub.messages - lines, #calls("LeaveParty"), Ly.Status().hopGroup })
	`);
	assert.deepEqual(out[0], [true, 0, 0, true]);
});

test('layer hop: an offer before or after the join of the hop group is auto-confirmed once; a group joined by hand in either order never is', () => {
	const hop = (claimed, offerFirst) => run(`
		set("layerAutoRefresh", true)
		set("layerRefreshDelay", 3)
		Ly.Request("*")
		${claimed ? 'hear("Hostone", "1ITestchar"); stub.fire("PARTY_INVITE_REQUEST", "Hostone")' : ''}
		lay.eviction = 120
		${offerFirst ? 'stub.fire("SHARD_TRANSFER_IMMINENT")' : ''}
		lay.group = 2
		stub.fire("GROUP_JOINED")
		${offerFirst ? '' : 'stub.fire("SHARD_TRANSFER_IMMINENT")'}
		local hopGroup = Ly.Status().hopGroup
		wait(10)
		emit({ hopGroup, #calls("ShardTransferConfirm") })
	`)[0];
	assert.deepEqual(hop(true, true), [true, 1], 'offer, then the hop group');
	assert.deepEqual(hop(true, false), [true, 1], 'the hop group, then the offer');
	assert.deepEqual(hop(false, true), [false, 0], 'offer, then a group joined by hand');
	assert.deepEqual(hop(false, false), [false, 0], 'a group joined by hand, then the offer');
});

test('layer hop: a request is bound to its map and expires after 120 s whatever the refresh does; a stale one accepts no invite', () => {
	const out = run(`
		Ly.Request("*")
		lay.map = 1430
		hear("Hostone", "1ITestchar")
		stub.fire("PARTY_INVITE_REQUEST", "Hostone")
		emit({ #calls("AcceptGroup"), Ly.Status().asked == nil })
		lay.map = 1429
		local again = Ly.Request("*")
		lay.map = 1430
		stub.fire("ZONE_CHANGED_NEW_AREA")
		emit({ again, Ly.Status().asked == nil })
		lay.map = 1429
		local third = Ly.Request("*")
		lay.eviction = 60
		stub.fire("SHARD_TRANSFER_IMMINENT")
		wait(121)
		local expired = Ly.Status().asked == nil
		hear("Hosttwo", "1ITestchar")
		stub.fire("PARTY_INVITE_REQUEST", "Hosttwo")
		emit({ third, expired, #calls("AcceptGroup"), Ly.Status().transfer })
	`);
	assert.deepEqual(out[0], [0, true], 'requested on 1429, the invite on 1430 is not accepted');
	assert.deepEqual(out[1], [true, true], 'a zone change ends the request');
	assert.deepEqual(out[2], [true, true, 0, 'offered'], 'an unrelated refresh offer does not keep the request alive');
});

test('layer hop: a waiting request never auto-confirms the refresh of a group joined by hand', () => {
	const out = run(`
		set("layerAutoRefresh", true)
		Ly.Request("*")
		lay.group = 2
		stub.fire("GROUP_JOINED")
		lay.eviction = 60
		stub.fire("SHARD_TRANSFER_IMMINENT")
		wait(10)
		emit({ #calls("ShardTransferConfirm"), Ly.Status().hopGroup, Ly.Status().transfer, Ly.Status().asked ~= nil })
	`);
	assert.deepEqual(out[0], [0, false, 'offered', true]);
});
