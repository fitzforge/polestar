'use strict';
// Layer hop (QoL/Layer.lua): the layer id from creature GUIDs, presence and
// hop requests over addon messages, hosting, and the game's world refresh.
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
		local function hear(sender, msg) stub.fire("CHAT_MSG_ADDON", "PolestarLayer", msg, "GUILD", sender) end
		local function sent(kind)
			local out = {}
			for _, s in ipairs(lay.sent) do if not kind or s[2]:sub(2, 2) == kind then out[#out + 1] = s[2] .. "@" .. s[3] end end
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
		lay.guild = true
		lay.guids.target = "${G(2)}"
		${on ? 'set("layerHop", true)' : ''}
		${script}` }).emitted;
}

test('layer hop: off by default; while off nothing is watched, joined, registered or sent, and the command refuses', () => {
	const out = run(`
		local function d(k) return Polestar.GetDefault("qol." .. k) end
		emit({ d("layerHop"), d("layerHost"), d("layerAutoRefresh"), d("layerRefreshDelay"), d("layerLeaveAfter") })
		-- events only the layer hop watches (others, like PLAYER_TARGET_CHANGED, other QoL features share;
		-- the fires below show the layer hop ignores them)
		local watched = 0
		for _, e in ipairs({ "UPDATE_MOUSEOVER_UNIT", "NAME_PLATE_UNIT_ADDED", "SHARD_TRANSFER_IMMINENT", "SHARD_TRANSFER",
			"SHARD_TRANSFER_CANCELLED", "CHAT_MSG_ADDON", "PARTY_INVITE_REQUEST", "GROUP_JOINED" }) do
			if QoL.Watching(e) then watched = watched + 1 end
		end
		local toggles = 0
		Polestar.On("TOGGLE_LAYER_HOP", function() toggles = toggles + 1 end)
		stub.fire("PLAYER_TARGET_CHANGED")
		hear("Peerone", "1H1429:2:0")
		lay.eviction = 60
		stub.fire("SHARD_TRANSFER_IMMINENT")
		local ok, why = Ly.Request("*")
		Polestar.RunCommand("layer")
		emit({ watched, #lay.sent, #lay.prefixes, #calls("JoinChannelByName"), Ly.Current() == nil, #Ly.Known(1429),
			ok, why, Ly.Status().on, Ly.Status().transfer, toggles, stub.messages[#stub.messages] })
	`, { on: false });
	assert.deepEqual(out[0], [false, false, false, 5, false]);
	assert.deepEqual(out[1].slice(0, 11), [0, 0, 0, 0, true, 0, false, 'Layer hop is off.', false, 'none', 0]);
	assert.match(out[1][11], /Layer hop is off: turn it on/);
});

test('layer hop: turning on joins the channel, registers the prefix and sends presence; turning off leaves and stops', () => {
	const out = run(`
		emit({ calls("JoinChannelByName"), lay.prefixes, sent(), QoL.Watching("CHAT_MSG_ADDON"), QoL.Watching("SHARD_TRANSFER_IMMINENT"), Ly.Status().on })
		set("layerHop", false)
		local before = #lay.sent
		lay.guids.target = "${G(10)}"
		stub.fire("PLAYER_TARGET_CHANGED")
		hear("Peerone", "1Q1429")
		wait(4)
		emit({ calls("LeaveChannelByName"), #lay.sent - before, QoL.Watching("CHAT_MSG_ADDON"), Ly.Status().on, Ly.Current() == nil })
	`);
	assert.deepEqual(out[0], [['PolestarLayer'], ['PolestarLayer'], ['1H1429:2:0@GUILD', '1H1429:2:0@CHANNEL'], true, true, true]);
	assert.deepEqual(out[1], [['PolestarLayer'], 0, false, false, true]);
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

test('layer hop: presence lists peers and hosts; echo, other realm, bad version, oversize, secret and flood dropped; Q answered once; stale peers dropped', () => {
	const out = run(`
		hear("Peerone", "1H1429:10:0")
		hear("Hostone", "1H1429:10:1")
		hear("Peertwo", "1H1429:2:0")
		hear("Testchar", "1H1429:30:0")
		hear("Farone-OtherRealm", "1H1429:31:0")
		hear("Peerthree", "2H1429:32:0")
		hear("Peerfour", "1H1429:" .. string.rep("3", 120) .. ":0")
		lay.secret["1H1429:34:0"] = true
		hear("Peerfive", "1H1429:34:0")
		hear("Peersix", "1H1429:35:0")
		hear("Peersix", "1H1429:36:0")
		emit(rows(1429))
		lay.sent = {}
		hear("Asker", "1Q1429")
		hear("Askertwo", "1Q1429")
		hear("Askerthree", "1Q1430")
		local early = #lay.sent
		wait(3.1)
		emit({ early, sent() })
		hear("Peersix", "1H1429:36:0")
		stub.now = stub.now + 500
		hear("Peerone", "1H1429:10:0")
		stub.now = stub.now + 200
		emit(rows(1429))
	`);
	assert.deepEqual(out[0], [['2', 1, 1, 0, true], ['10', 2, 2, 1, false], ['35', 3, 1, 0, false]]);
	assert.deepEqual(out[1], [0, ['1H1429:2:0@GUILD', '1H1429:2:0@CHANNEL']]);
	assert.deepEqual(out[2], [['2', 1, 0, 0, true], ['10', 2, 1, 0, false], ['35', 3, 0, 0, false], ['36', 4, 0, 0, false]]);
});

test('layer hop: a host claims then invites a request from another layer, and stands down when it may not', () => {
	const out = run(`
		set("layerHost", true)
		hear("Reqone", "1R1429:10:*")
		wait(2.6)
		emit(order())
		lay.order = {}
		hear("Reqtwo", "1R1429:2:*")
		hear("Reqthree", "1R1429:10:7")
		hear("Reqfour", "1R1430:10:*")
		q.social.combat.player = true
		hear("Reqfive", "1R1429:10:*")
		wait(2.6)
		q.social.combat.player = nil
		lay.group = 5
		hear("Reqsix", "1R1429:10:*")
		lay.group, lay.leader = 2, false
		hear("Reqseven", "1R1429:10:*")
		wait(2.6)
		lay.group = 0
		hear("Reqone", "1R1429:10:*")
		hear("Reqeight", "1R1429:10:*")
		hear("Hosttwo", "1IReqeight")
		hear("Reqnine", "1R1429::2")
		wait(2.6)
		emit({ order(), calls("InviteUnit") })
	`);
	assert.deepEqual(out[0], ['1IReqone@GUILD', '1IReqone@CHANNEL', 'invite:Reqone']);
	assert.deepEqual(out[1], [['1IReqnine@GUILD', '1IReqnine@CHANNEL', 'invite:Reqnine'], ['Reqone', 'Reqnine']]);
});

test('layer hop: a request is sent or refused; only the claimed host or a known peer is accepted; the same shard is reported', () => {
	const out = run(`
		local ok1 = Ly.Request("*")
		local ok2, why2 = Ly.Request("*")
		emit({ ok1, sent("R"), ok2, why2, Ly.Status().asked.want })
		Ly.CancelRequest()
		lay.lockdown = true
		local ok3, why3 = Ly.Request("*")
		lay.lockdown, lay.group = false, 2
		local ok4, why4 = Ly.Request("*")
		lay.group = 0
		emit({ ok3, why3, ok4, why4 })
		Ly.Request("10")
		q.showPopup("PARTY_INVITE")
		stub.fire("PARTY_INVITE_REQUEST", "Stranger")
		stub.runTimers()
		local strangers = #calls("AcceptGroup")
		hear("Hostone", "1ITestchar")
		stub.fire("PARTY_INVITE_REQUEST", "Hostone")
		stub.runTimers()
		local hidden = {}
		for _, c in ipairs(q.calls) do if c[1] == "StaticPopup_Hide" then hidden[#hidden + 1] = c[2] .. ":" .. tostring(c[3]) end end
		emit({ strangers, #calls("AcceptGroup"), hidden })
		lay.group, lay.inShard.party1 = 2, true
		set("layerLeaveAfter", true)
		stub.fire("GROUP_JOINED")
		local mid = Ly.Status().hopGroup
		wait(2.1)
		emit({ mid, stub.messages[#stub.messages], #calls("LeaveParty"), Ly.Status().asked == nil, Ly.Status().hopGroup })
	`);
	assert.deepEqual(out[0], [true, ['1R1429:2:*@GUILD', '1R1429:2:*@CHANNEL'], false, 'A hop request is already waiting.', '*']);
	assert.deepEqual(out[1], [false, 'Chat is locked down; try again shortly.', false, 'You are already in a group.']);
	assert.deepEqual(out[2], [0, 1, ['PARTY_INVITE:1']]);
	assert.equal(out[3][0], true);
	assert.match(out[3][1], /Same layer as the host; nothing to refresh\./);
	assert.deepEqual(out[3].slice(2), [1, true, false]);
	const peer = run(`
		hear("Peerone", "1H1429:10:1")
		stub.fire("PARTY_INVITE_REQUEST", "Peerone")
		local before = #calls("AcceptGroup")
		Ly.Request("*")
		stub.fire("PARTY_INVITE_REQUEST", "Peerone")
		emit({ before, #calls("AcceptGroup") })
	`);
	assert.deepEqual(peer[0], [0, 1], 'a peer heard on the map is the fallback, and only while a request waits');
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
