'use strict';
// The layer hop window (addon/Polestar/UI/LayerHop.lua): built only while
// qol.layerHop is on, moved and resized within its bounds and the screen,
// still while the windows are locked, its rows following QoL.Layer.Known
// and its buttons the module's state. Against the real Core, Theme, UI and
// QoL with the fakes of tests/lua/stub_ui.lua and tests/lua/stub_qol.lua
// (stub.layer).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const G = (layer) => `Creature-0-4372-0-${layer}-1234-0000ABCDEF`;

function run(script, { on = true, before = '' } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua', 'stub_qol.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml', 'QoL/QoL.xml'] }],
		script: `uistub.install()\nstub.login()
		local LH, Ly, lay = Polestar.UI.LayerHop, Polestar.QoL.Layer, stub.layer
		local function set(k, v) Polestar.Set(k, v); stub.runTimers() end
		local function hear(sender, msg) stub.fire("CHAT_MSG_ADDON", "PolestarLayer", msg, "GUILD", sender) end
		local function sentQ() local n = 0; for _, s in ipairs(lay.sent) do if s[2]:sub(2, 2) == "Q" then n = n + 1 end end; return n end
		lay.guild = true
		lay.guids.target = "${G(2)}"
		${before}
		${on ? 'set("qol.layerHop", true)' : ''}
		${script}`,
	}).emitted;
}

test('layer hop window: never built while the opt-in is off, and a chat line says where to turn it on', () => {
	const [out] = run(`
		local opened = LH.Toggle()
		local line = stub.messages[#stub.messages]
		Polestar.Fire("TOGGLE_LAYER_HOP")
		emit({ opened = opened, line = line, frame = LH.view.frame == nil, global = PolestarLayerHop == nil, q = sentQ() })
	`, { on: false });
	assert.equal(out.opened, false);
	assert.match(out.line, /Layer hop is off: turn it on in the options, Quality of Life, Layers\./);
	assert.deepEqual([out.frame, out.global, out.q], [true, true, 0]);
});

test('layer hop window: TOGGLE_LAYER_HOP opens and closes it, Esc closes it, and turning the opt-in off hides it', () => {
	const [out] = run(`
		Polestar.Fire("TOGGLE_LAYER_HOP")
		local F = LH.view.frame
		local opened = F:IsShown()
		local esc = false
		for _, name in ipairs(UISpecialFrames) do if name == "PolestarLayerHop" then esc = true end end
		Polestar.Fire("TOGGLE_LAYER_HOP")
		local closed = not F:IsShown()
		Polestar.RunCommand("layer")
		local again = F:IsShown()
		set("qol.layerHop", false)
		emit({ global = PolestarLayerHop == F, opened = opened, esc = esc, closed = closed, again = again,
			hidden = not F:IsShown(), q = sentQ(), title = F.Title:GetText() })
	`);
	assert.deepEqual(out, { global: true, opened: true, esc: true, closed: true, again: true, hidden: true, q: 1, title: 'Layer hop' });
});

test('layer hop window: position and size are saved on drag and size stop, and restored inside the bounds and the screen', () => {
	const [clamped] = run(`
		LH.Open()
		local F = LH.view.frame
		local p, _, rp, x, y = F:GetPoint(1)
		local first = { F:GetWidth(), F:GetHeight(), p, rp, x, y }
		F.x, F.y = 100, 200
		stub.RunScript(F.Head, "OnDragStart")
		local moving = F.moving == true
		stub.RunScript(F.Head, "OnDragStop")
		local s = Polestar.DB().layerHopWindow
		local dragged = { s.x, s.y, s.w, s.h }
		stub.RunScript(F.Grip, "OnMouseDown")
		local sizing = F.sizing == true
		F:SetSize(400, 300)
		stub.RunScript(F.Grip, "OnMouseUp")
		s = Polestar.DB().layerHopWindow
		emit({ first = first, bounds = F.resizeBounds, moving = moving, dragged = dragged, sizing = sizing,
			sized = { s.x, s.y, s.w, s.h }, stopped = not F.moving and not F.sizing })
	`, { before: 'Polestar.DB().layerHopWindow = { x = 5000, y = 9000, w = 100, h = 2000 }' });
	assert.deepEqual(clamped.first, [280, 640, 'TOPLEFT', 'BOTTOMLEFT', 1920 - 280, 1080], 'kept inside the bounds and the 1920x1080 screen');
	assert.deepEqual(clamped.bounds, [280, 220, 560, 640]);
	assert.equal(clamped.moving, true);
	assert.deepEqual(clamped.dragged, [100, 200 + 640, 280, 640]);
	assert.equal(clamped.sizing, true);
	assert.deepEqual(clamped.sized, [100, 500, 400, 300]);
	assert.equal(clamped.stopped, true);
	const [restored] = run(`
		LH.Open()
		local F = LH.view.frame
		local p, _, rp, x, y = F:GetPoint(1)
		emit({ F:GetWidth(), F:GetHeight(), p, rp, x, y })
	`, { before: 'Polestar.DB().layerHopWindow = { x = 100, y = 500, w = 400, h = 300 }' });
	assert.deepEqual(restored, [400, 300, 'TOPLEFT', 'BOTTOMLEFT', 100, 500]);
});

test('layer hop window: ui.locked hides the grip, stops a resize in progress and refuses drags', () => {
	const [out] = run(`
		LH.Open()
		local F = LH.view.frame
		local grip = F.Grip:IsShown()
		stub.RunScript(F.Grip, "OnMouseDown")
		local sizing = F.sizing == true
		set("ui.locked", true)
		local lockedState = { F.Grip:IsShown(), F.sizing == true, Polestar.DB().layerHopWindow ~= nil }
		stub.RunScript(F.Head, "OnDragStart")
		stub.RunScript(F.Grip, "OnMouseDown")
		local refused = { F.moving == true, F.sizing == true }
		set("ui.locked", false)
		emit({ grip, sizing, lockedState, refused, F.Grip:IsShown() })
	`);
	assert.deepEqual(out, [true, true, [false, false, true], [false, false], true]);
});

test('layer hop window: rows follow Layer.Known, the buttons and checkboxes follow the state, the countdown ticks', () => {
	const [out] = run(`
		LH.Open()
		local F = LH.view.frame
		local function rows()
			local list = {}
			for _, r in ipairs(LH.view.rows) do
				if r:IsShown() then list[#list + 1] = { r.Label:GetText(), r.Info:GetText(), r.Ask:IsShown(), r.Ask:IsEnabled() } end
			end
			return list
		end
		local function buttons() return { F.Hop:IsEnabled(), F.Now:IsEnabled(), F.Leave:IsEnabled(), F.List:IsEnabled() } end
		local function checks() return { F.Checks[1]:GetChecked(), F.Checks[2]:GetChecked(), F.Checks[3]:GetChecked() } end
		emit({ rows(), F.Current:GetText(), F.None:IsShown(), buttons(), F.Status:GetText() })
		hear("Peerone", "1H1429:10:1")
		hear("Peertwo", "1H1429:10:0")
		hear("Peerthree", "1H1429:7:0")
		emit({ rows(), F.Current:GetText(), F.None:IsShown() })
		F.Checks[1]:SetChecked(true)
		F.Checks[1]:Click()
		set("qol.layerLeaveAfter", true)
		emit({ Polestar.Get("qol.layerHost"), checks() })
		LH.view.rows[3].Ask:Click()
		local r = lay.sent[#lay.sent][2]
		emit({ r, buttons(), rows()[2][4], F.Status:GetText() })
		hear("Hostone", "1ITestchar")
		stub.fire("PARTY_INVITE_REQUEST", "Hostone")
		lay.group = 2
		stub.fire("GROUP_JOINED")
		emit({ buttons(), F.Status:GetText() })
		lay.eviction = 90
		stub.fire("SHARD_TRANSFER_IMMINENT")
		local offered = { buttons(), F.Status:GetText() }
		stub.advance(1.05)
		emit({ offered, F.Status:GetText() })
	`);
	assert.deepEqual(out[0], [[['Layer 1', '0 peers · you', false, true]], 'Layer 1', false, [true, false, false, true], 'No hop in progress.']);
	assert.deepEqual(out[1], [[
		['Layer 1', '0 peers · you', false, true],
		['Layer 2', '1 peer', true, true],
		['Layer 3', '2 peers · host', true, true],
	], 'Layer 1', false]);
	assert.deepEqual(out[2], [true, [true, false, true]]);
	assert.equal(out[3][0], '1R1429:2:10');
	assert.deepEqual(out[3].slice(1), [[false, false, false, true], false, 'Asked for a hop: 120 s left.']);
	assert.deepEqual(out[4], [[false, false, true, true], 'In the host\'s group, waiting for the offer.']);
	assert.deepEqual(out[5], [[[false, true, true, true], 'World refresh in 1:30'], 'World refresh in 1:29']);
});
