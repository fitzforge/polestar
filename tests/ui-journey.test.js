'use strict';
// The journey panel (addon/Polestar/UI/JourneyPanel.lua) in the guide window,
// against the real Core + Theme + UI manifests, the fake Engine of
// tests/lua/stub_ui.lua and a fake route: Nav.GetRoute, Nav.travel (Active,
// Progress), Nav.prompts (the skip menu) and ns.Transit (departures).
// Ids in test names are the rows of docs/NAV_QA.md.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ROOT } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

// SPF's own example: 36:48 and 8.0k yd over a walk to the Great Lift, the
// lift, and the walk to Silithus.
const ROUTE = `
local Nav = Polestar.Nav
Polestar.RegisterDefaults("nav", { distanceUnit = "yards", journeySteps = true, journeyOpen = true })
R = { ci = 1, ps = 670, py = 3000, timed = false, wait = 15, ride = 10, active = true }
R.legs = {
	{ kind = "walk", step = "lift", label = "Walk to The Great Lift, Top", seconds = 670, yards = 3000, to = { name = "The Great Lift, Top" } },
	{ kind = "lift", lift = 7, side = "top", label = "Take The Great Lift", seconds = 25, yards = 60, to = { name = "The Great Lift, Bottom" } },
	{ kind = "walk", label = "Walk to Silithus", seconds = 1513, yards = 4940, to = { name = "Silithus", map = 1451 } },
}
Nav.travel = {
	Active = function() return R.active and R.legs ~= nil and #R.legs > 1 end,
	Progress = function() return R.ps, R.py end,
}
function Nav.GetRoute() return R.legs, R.legs and R.ci end
MENU = 0
Nav.prompts = { MenuItems = function() return { { text = "Mark this leg done" } } end, OpenMenu = function() MENU = MENU + 1 end }
Polestar.Transit = {
	Now = function() return 1000 + GetTime() end,
	NextDeparture = function(kind, id, at, side) DEP = { kind, id, side }; return R.wait, R.ride, R.timed end,
}
uistub.target = { label = "Silithus" }
JP = Polestar.UI.JourneyPanel
GF = Polestar.UI.GuideFrame
LAYOUTS = 0
local layout = GF.Layout
GF.Layout = function(...) LAYOUTS = LAYOUTS + 1; return layout(...) end
function shot()
	local rows = {}
	for i, r in ipairs(JP.rows) do
		if r:IsShown() then
			rows[#rows + 1] = { num = r.Num:GetText(), text = r.Text:GetText(), time = r.Time:GetText(), bar = r.Bar:IsShown(),
				sub = r.Sub:IsShown() and r.Sub:GetText() or false, icon = r.Icon:GetTexture(), h = r:GetHeight() }
		end
	end
	local f = JP.frame
	return { has = f.psHas or false, shown = f:IsShown(), time = JP.head.Time:GetText(),
		dist = JP.head.Dist:IsShown() and JP.head.Dist:GetText() or false, dest = JP.dest:GetText(), rows = rows,
		more = JP.more:IsShown() and JP.more:GetText() or false, list = f.List:IsShown(), height = f:GetHeight() }
end
`;

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\n${ROUTE}\nuistub.setGuide(uistub.elwynn, 3)\nPolestar.Fire("ROUTE_CHANGED", R.legs)\n${script}`,
	}).emitted;
}

test('header, destination and numbered steps: 36:48 · 8.0k yd, the lift with its departure, the current step in the accent', () => {
	const [s] = run('emit(shot())');
	assert.equal(s.has, true);
	assert.equal(s.shown, true);
	assert.equal(s.time, '36:48');
	assert.equal(s.dist, '8.0k yd');
	assert.match(s.dest, /^To \|c[0-9a-f]{8}Silithus\|r$/);
	assert.deepEqual(s.rows.map((r) => [r.num, r.text, r.time]), [
		['1', 'Walk to The Great Lift, Top', '11:10'],
		['2', 'Take The Great Lift', '0:25'],
		['3', 'Walk to Silithus', '25:13'],
	]);
	assert.deepEqual(s.rows.map((r) => r.bar), [true, false, false]);
	assert.equal(s.rows[1].sub, 'leaves in about 0:15 \u00b7 ride 0:10');
	assert.equal(s.rows[0].sub, false);
	assert.match(s.rows[0].icon, /icon-lift$/);
	assert.match(s.rows[2].icon, /icon-goto$/);
	assert.ok(s.rows[1].h > s.rows[0].h, 'the departure line has its own room');
});

test('times read 0:15, 11:10, 1:02:03; nothing unreadable reaches the screen', () => {
	const [t] = run(`emit({ JP.FormatTime(15), JP.FormatTime(670), JP.FormatTime(3723), JP.FormatTime(0), JP.FormatTime(0.2),
		JP.FormatTime(0/0), JP.FormatTime(math.huge), JP.FormatTime(-4), JP.FormatTime(nil) })`);
	assert.deepEqual(t, ['0:15', '11:10', '1:02:03', '0:00', '0:01', '0:00', '0:00', '0:00', '0:00']);
});

test('16: distances follow nav.distanceUnit: 8.0k yd, or 7.3 km in metres', () => {
	const [s] = run('Polestar.Set("nav.distanceUnit", "metres"); emit(shot())');
	assert.equal(s.dist, '7.3 km');
});

test('countdown: the current step and the total tick down once a second from Travel.Progress', () => {
	const [a, b] = run(`
		R.ps = 669; stub.advance(1); emit(shot())
		R.ps = 600; stub.advance(1); emit(shot())`);
	assert.equal(a.rows[0].time, '11:09');
	assert.equal(a.time, '36:47');
	assert.equal(b.rows[0].time, '10:00');
	assert.equal(b.time, '35:38');
});

test('countdown without Travel.Progress: the planned time less the time since the step began', () => {
	const [s] = run('Polestar.Nav.travel.Progress = nil; R.legs = { R.legs[1], R.legs[2], R.legs[3] }; Polestar.Fire("ROUTE_CHANGED", R.legs); stub.advance(3); emit(shot())');
	assert.equal(s.rows[0].time, '11:07');
});

test('the current step advances: the finished step drops off, numbers keep their place in the route', () => {
	const [s] = run('R.ci = 2; R.ps = 25; Polestar.Fire("ROUTE_ADVANCED", R.legs, 2); emit(shot())');
	assert.deepEqual(s.rows.map((r) => [r.num, r.text, r.bar]), [['2', 'Take The Great Lift', true], ['3', 'Walk to Silithus', false]]);
	assert.equal(s.time, '25:38');
});

test('5: hidden with no route, a lone walk, the setting off or compact mode; back when the route returns', () => {
	const out = run(`
		R.legs = { R.legs[3] }; R.ci = 1; Polestar.Fire("ROUTE_CHANGED", R.legs); emit(shot())
		R.legs = nil; Polestar.Fire("ROUTE_CHANGED", nil); emit(shot())
		R.legs = { { kind = "walk", label = "a", seconds = 5 }, { kind = "walk", label = "b", seconds = 5 } }; Polestar.Fire("ROUTE_CHANGED", R.legs); emit(shot())
		Polestar.Set("nav.journeySteps", false); emit(shot())
		Polestar.Set("nav.journeySteps", true); Polestar.Set("ui.compact", true); emit(shot())
		Polestar.Set("ui.compact", false); emit(shot())`);
	assert.deepEqual(out.map((s) => [s.has, s.shown]), [
		[false, false], [false, false], [true, true], [false, false], [true, false], [true, true],
	]);
});

test('collapses with a click on the header: the totals stay, the steps go', () => {
	const [open, shut, again] = run(`
		emit(shot()); JP.head:Click(); emit(shot()); JP.head:Click(); emit(shot())`);
	assert.equal(open.list, true);
	assert.equal(shut.list, false);
	assert.equal(shut.time, '36:48');
	assert.equal(shut.height, 30);
	assert.equal(again.list, true);
	assert.equal(again.height, open.height);
});

test('clicking the current step opens the skip menu; a later step does not', () => {
	const [n] = run('JP.rows[2]:Click(); JP.rows[1]:Click(); emit(MENU)');
	assert.equal(n, 1);
});

test('more than eight steps: eight rows and a count of the rest', () => {
	const [s] = run(`
		local legs = {}
		for i = 1, 11 do legs[i] = { kind = "walk", label = "Step " .. i, seconds = 10, yards = 10 } end
		R.legs = legs; R.ps = 10; R.py = 10; Polestar.Fire("ROUTE_CHANGED", legs); emit(shot())`);
	assert.equal(s.rows.length, 8);
	assert.equal(s.more, '3 more steps');
	assert.equal(s.time, '1:50');
});

test('K1/C9: a step without a caption reads its kind and place, never "Unknown"', () => {
	const [s] = run(`
		R.legs = {
			{ kind = "walk", seconds = 10, to = {} },
			{ kind = "tram", seconds = 60, transport = { id = 3 }, to = { map = 1451 } },
			{ kind = "fly", seconds = 90, to = { name = "Ironforge" } },
		}
		Polestar.Fire("ROUTE_CHANGED", R.legs); emit(shot())`);
	const texts = s.rows.map((r) => r.text);
	for (const t of texts) {
		assert.ok(t && t.trim().length > 0);
		assert.doesNotMatch(t, /unknown/i);
	}
	assert.equal(texts[0], 'Walk to the next stop');
	assert.equal(texts[2], 'Fly to Ironforge');
	assert.equal(s.rows[2].sub, false, 'a flight leaves at once: no wait');
});

test('K3: a lift says "leaves in about" until timed, then "leaves in"; walks, gates and bridges carry no wait', () => {
	const [about, timed] = run(`
		R.legs[1].step = "gate"; R.legs[3].step = "bridge"; Polestar.Fire("ROUTE_CHANGED", R.legs); emit(shot())
		R.timed = true; Polestar.Fire("NAV_TRANSIT"); emit(shot())`);
	assert.equal(about.rows[1].sub, 'leaves in about 0:15 \u00b7 ride 0:10');
	assert.equal(timed.rows[1].sub, 'leaves in 0:15 \u00b7 ride 0:10');
	assert.equal(about.rows[0].sub, false);
	assert.equal(about.rows[2].sub, false);
	assert.match(about.rows[0].icon, /icon-gate$/);
	assert.match(about.rows[2].icon, /icon-bridge$/);
});

test('K3: the lift is asked for the side the route boards at, and at the time the route gets there', () => {
	const [d] = run('emit({ DEP[1], DEP[2], DEP[3] })');
	assert.deepEqual(d, ['lift', 7, 'top']);
});

test('K2 and 1.9.0 shaking: ten position updates along a leg change only the times, never the rows or the layout', () => {
	const [before, after, layouts] = run(`
		local first = shot(); LAYOUTS = 0
		for i = 1, 10 do R.ps = 670 - i * 7; R.py = 3000 - i * 30; stub.advance(1) end
		emit(first); emit(shot()); emit(LAYOUTS)`);
	assert.equal(layouts, 0);
	assert.deepEqual(after.rows.map((r) => [r.num, r.text, r.h, r.sub]), before.rows.map((r) => [r.num, r.text, r.h, r.sub]));
	assert.equal(after.rows[0].time, '10:00');
});

test('1/K7: zero-yard, zero-second and NaN legs keep every time and distance finite', () => {
	const [s] = run(`
		R.legs = {
			{ kind = "walk", label = "a", seconds = 0/0, yards = 0 },
			{ kind = "walk", label = "b", seconds = 0, yards = 0/0 },
			{ kind = "walk", label = "c", seconds = math.huge, yards = -5 },
		}
		R.ps, R.py = 0/0, 0/0
		Polestar.Fire("ROUTE_CHANGED", R.legs); stub.advance(1); emit(shot())`);
	assert.equal(s.time, '0:00');
	assert.equal(s.dist, false);
	for (const r of s.rows) assert.equal(r.time, '0:00');
});

test('the countdown stops while the guide window is hidden and resumes with it', () => {
	const [hidden, shown] = run(`
		PolestarGuideFrame:Hide(); stub.advance(2); emit(JP.Ticking())
		PolestarGuideFrame:Show(); stub.advance(1); emit(JP.Ticking())`);
	assert.equal(hidden, false);
	assert.equal(shown, true);
});

test('6: the panel makes no protected calls (no secure templates, SuperTrack or gamepad focus)', () => {
	const src = fs.readFileSync(path.join(ROOT, 'addon', 'Polestar', 'UI', 'JourneyPanel.lua'), 'utf8');
	assert.doesNotMatch(src, /Secure|C_SuperTrack|Gamepad|SetBinding|InCombatLockdown/);
});

test('review P2-4: the current flight counts down, and the header with it, even when Travel.Progress gives the planned time', () => {
	const [a, b, c] = run(`
		R.legs = { { kind = "fly", label = "Fly to Ironforge", seconds = 300, yards = 2000, to = { name = "Ironforge" } },
			{ kind = "walk", label = "Walk to the bank", seconds = 100, yards = 300 } }
		R.ci = 1; R.ps, R.py = 300, 2000 -- a Progress that never moves for non-walk legs
		Polestar.Fire("ROUTE_CHANGED", R.legs); emit(shot())
		stub.advance(5); emit(shot())
		PolestarGuideFrame:Hide(); stub.advance(10); PolestarGuideFrame:Show(); stub.advance(0.05); emit(shot())`);
	assert.equal(a.rows[0].time, '5:00');
	assert.equal(a.time, '6:40');
	assert.equal(b.rows[0].time, '4:55');
	assert.equal(b.time, '6:35');
	assert.equal(c.rows[0].time, '4:45', 'the countdown keeps running while the window is closed');
});

test('review P3-11: no empty second line when the departure is unknown', () => {
	const [s] = run('R.wait = nil; Polestar.Fire("NAV_TRANSIT"); emit(shot())');
	assert.equal(s.rows[1].sub, false);
	assert.equal(s.rows[1].h, s.rows[0].h);
	assert.equal(s.rows[1].time, '0:25', 'the planned time stands in');
});

test('review P3-11: at the dock, a boat leaving within the boarding window shows its own wait, not a full loop', () => {
	const [docked, away] = run(`
		R.legs = { { kind = "boat", transport = { id = 4 }, side = "a", label = "Boat to Auberdine", seconds = 180, yards = 1500,
				from = { c = 0, wx = 100, wy = 200 }, to = { name = "Auberdine" } },
			{ kind = "walk", label = "Walk to the inn", seconds = 60, yards = 200 } }
		R.ci = 1; R.timed = true; R.wait = 600; R.ride = 120
		Polestar.Transit.NextArrival = function() return 0, 8, true end
		local here = { 0, 110, 205 }
		Polestar.Compat.GetPlayerWorldPosition = function() return here[1], here[2], here[3] end
		Polestar.Fire("ROUTE_CHANGED", R.legs); emit(shot())
		here = { 0, 400, 205 }; Polestar.Fire("NAV_TRANSIT"); emit(shot())`);
	assert.equal(docked.rows[0].sub, 'leaves in 0:08 \u00b7 ride 2:00');
	assert.equal(docked.rows[0].time, '2:08');
	assert.equal(away.rows[0].sub, 'leaves in 10:00 \u00b7 ride 2:00');
});

test('a walk that enters a hostile town says so under its step: "Hostile town: Southshore"', () => {
	const [s] = run(`
		-- Travel.HubText's wording (the panel asks Nav.travel for it).
		Polestar.Nav.travel.HubText = function(leg)
			local names = {}
			for _, h in ipairs(leg.hubs or {}) do names[#names + 1] = h.name end
			return #names > 0 and ("Hostile town: " .. table.concat(names, ", ")) or nil
		end
		R.legs[3].hubs = { { id = 12, name = "Southshore" } }
		R.legs[1].hubs = { { id = 13, name = "Tarren Mill" }, { id = 14, name = "Hammerfall" } }
		Polestar.Fire("ROUTE_CHANGED", R.legs)
		emit(shot())`);
	assert.equal(s.rows[2].sub, 'Hostile town: Southshore');
	assert.equal(s.rows[0].sub, 'Hostile town: Tarren Mill, Hammerfall');
	assert.equal(s.rows[1].sub, 'leaves in about 0:15 \u00b7 ride 0:10', 'a ride keeps its departure line');
	assert.ok(s.rows[2].h > 24, 'the warning has its own line');
});
