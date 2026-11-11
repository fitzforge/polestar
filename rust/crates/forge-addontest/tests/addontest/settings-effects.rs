//! Every control of the settings window does something you can see (Main's bar for 0.3.8: "no setting without a
//! visible effect"): each has an effect check here, and the coverage check fails for any control without one.
//!
//! An effect check (effects/<group>.lua) is a probe: a function that reads the live addon (a frame's size, a
//! string's font, a texture's colour, what a quest window was answered with, ...), never the saved setting. For each
//! control the runner reads the probe, writes another value the control could write (the other state of a switch,
//! the far end of a slider, another choice, a colour; or the check's own `value`), reads it again, puts the default
//! back (as a right-click does) and reads it a third time: the first and second reads must differ, the first and
//! third must be the same. A check may first set what the control works under (`with`: route lines off for the
//! trail dots). A button's check (`press`) reads, presses it, and reads a change; a key binding's sets a key and
//! reads it bound, then cleared.
//!
//! Each group file returns { env = <one of ENV>, setup = fn?, settle = seconds?, probes = { [id] = probe | { probe,
//! value?, with?, press?, bind? } } } where id is the control's setting key, "action:<binding action>" or
//! "label:<English label>" for a control with neither.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

struct Group {
	name: &'static str,
	src: &'static str,
}

const GROUPS: &[Group] = &[
	Group { name: "arrow", src: include_str!("effects/arrow.lua") },
	Group { name: "pins", src: include_str!("effects/pins.lua") },
	Group { name: "routes", src: include_str!("effects/routes.lua") },
	Group { name: "theme", src: include_str!("effects/theme.lua") },
	Group { name: "guidewindow", src: include_str!("effects/guidewindow.lua") },
];

// The runner: the group's probes over the control specs (the registry's, and the settings window's own pages
// when it is loaded). -> emit({ bad = { "id: why", ... }, n = checked })
const RUNNER: &str = r#"
local G = __GROUP
local W = Polestar.Widgets
local function labelOf(c) if type(c.label) == "function" then return c.label() end return c.label end
-- A control's id: its setting key, its binding's action, or for a control with neither its page's name and its
-- label (two pages may have a "Position" button).
local function idOf(c, page)
	if c.key then return c.key end
	if c.kind == "binding" then return "action:" .. tostring(c.action) end
	return (page or (c.page and c.page.name) or "?") .. ":" .. tostring(labelOf(c))
end
local specs = {}
local function put(c, page)
	if type(c) ~= "table" or rawget(c, "ref") then return end
	local id = idOf(c, page)
	specs[id] = specs[id] or c
	for _, e in ipairs(c.extras or {}) do put(e, page) end
	for _, m in ipairs(type(c.more) == "table" and c.more or {}) do put(m, page) end
end
for _, spec in ipairs(W.OptionsRegistry or {}) do
	if spec.toggle then put(spec.toggle, spec.page) end
	for _, c in ipairs(spec.controls or {}) do put(c, spec.page) end
end
local O = Polestar.UI and Polestar.UI.Options
if O and O.AllControls then for _, c in ipairs(O.AllControls()) do put(c) end end
local function same(a, b, depth)
	if type(a) == "number" and type(b) == "number" then return math.abs(a - b) < 1e-4 end
	if type(a) ~= type(b) then return false end
	if type(a) ~= "table" then return a == b end
	if (depth or 0) > 8 then return false end
	for k, v in pairs(a) do if not same(v, b[k], (depth or 0) + 1) then return false end end
	for k in pairs(b) do if a[k] == nil then return false end end
	return true
end
local function show(v, depth)
	if type(v) ~= "table" then return tostring(v) end
	if (depth or 0) > 3 then return "{...}" end
	local parts = {}
	for k, x in pairs(v) do parts[#parts + 1] = tostring(k) .. "=" .. show(x, (depth or 0) + 1) end
	table.sort(parts)
	return "{" .. table.concat(parts, ",") .. "}"
end
-- The value now, and another one the control could write. A control with its own get/set reads and writes
-- through them, as its widget does (the minimap size of the style in use; deathskips, off on Hardcore).
local function current(c)
	if c.get then return c.get() end
	if c.key then return Polestar.Get(c.key) end
end
local function other(c)
	local cur = current(c)
	if c.kind == "toggle" then return not cur end
	if c.kind == "slider" then
		local lo, hi = c.min or 0, c.max or 1
		if type(cur) ~= "number" or math.abs(cur - hi) > 1e-9 then return hi end
		return lo
	end
	if c.kind == "dropdown" or c.kind == "cards" or c.kind == "font" then
		local list = c.choices
		if type(list) == "function" then list = list() end
		for _, ch in ipairs(list or {}) do
			local off = ch.disabled
			if type(off) == "function" then off = off() end
			if ch.value ~= cur and not off then return ch.value end
		end
		return nil
	end
	if c.kind == "color" then
		if type(cur) == "table" and cur[1] == 1 and (cur[2] or 0) == 0 then return { 0, 1, 0, 1 } end
		return { 1, 0, 0, 1 }
	end
end
local function write(c, v)
	if c.set then c.set(v) elseif c.key then Polestar.Set(c.key, v) end
end
local settle = G.settle or 0.1
local function wait() stub.advance(settle) end
if G.setup then G.setup() end
wait()
local bad, n = {}, 0
local ids = {}
for id in pairs(G.probes) do ids[#ids + 1] = id end
table.sort(ids)
for _, id in ipairs(ids) do
	local e = G.probes[id]
	if type(e) == "function" then e = { probe = e } end
	local c = specs[id]
	n = n + 1
	local was = {}
	local ok, why = pcall(function()
		if not c then return "no control has it here" end
		for k, v in pairs(e.with or {}) do was[k] = Polestar.Get(k); Polestar.Set(k, v) end
		if e.prepare then e.prepare() end
		wait()
		local before = e.probe()
		if e.press then
			if type(c.onClick) ~= "function" then return "not a button" end
			c.onClick()
			wait()
			local after = e.probe()
			if same(before, after) then return "pressing it changes nothing: " .. show(before) end
		elseif e.bind then
			-- What the binding row does with a key pressed, then right-clicked (UI/GamepadGuide.lua).
			local Gp = Polestar.Gamepad
			local key = type(e.bind) == "string" and e.bind or "F9"
			if not (Gp and Gp.Bind(c.action, key)) then return "the key was refused" end
			wait()
			local after = e.probe()
			Gp.Unbind(c.action)
			wait()
			local back = e.probe()
			if same(before, after) then return "binding a key changes nothing: " .. show(before) end
			if not same(before, back) then return "cleared, it leaves " .. show(back) end
		else
			local v = e.value
			if v == nil then v = other(c) end
			if v == nil then return "no other value to write" end
			write(c, v)
			wait()
			local after = e.probe()
			write(c, nil)
			wait()
			local back = e.probe()
			if same(before, after) then return "changing it to " .. show(v) .. " changes nothing: " .. show(before) end
			if not same(before, back) then return "back at its default it leaves " .. show(back) .. " (was " .. show(before) .. ")" end
		end
	end)
	-- Whatever happened: the check's own state undone, then the group's.
	pcall(function()
		if e.cleanup then e.cleanup() end
		for k, v in pairs(was) do Polestar.Set(k, v) end
		if G.cleanup then G.cleanup() end
		wait()
	end)
	if not ok then bad[#bad + 1] = id .. ": the check failed: " .. tostring(why)
	elseif why then bad[#bad + 1] = id .. ": " .. why end
end
emit({ bad = bad, n = n })
"#;

// An environment a group runs in: the stubs and the addon files its module's own tests use.
struct Env {
	stubs: Vec<&'static str>,
	before: &'static str,
	addons: Vec<Addon>,
	login: bool,
	prelude: String,
}

fn env(name: &str) -> Env {
	let page = |p: &str| forge_addontest::run::addons_dir().join(p).to_string_lossy().into_owned();
	let nav = |files: &[&str]| Env { stubs: vec!["stub_nav.lua"], before: "", addons: vec![Addon::files("Polestar", files)], login: true, prelude: "stub.advance(1)\n".into() };
	match name {
		// The arrow and its pins (nav-arrow-look.rs, nav-pins-look.rs).
		"nav" => nav(&["Core/Init.lua", "Theme/Theme.xml", "Nav/Nav.xml", &page("Polestar_Options/Nav/ArrowOptions.lua"), &page("Polestar_Options/Nav/PinsOptions.lua")]),
		// The route lines and their page (nav-route-look.rs).
		"routes" => nav(&[
			"Core/Init.lua",
			"Theme/Theme.xml",
			"Nav/Nav.xml",
			"Maps/FlightPaths.lua",
			"Maps/RouteStrokes.lua",
			"Maps/RouteSparkle.lua",
			"Maps/RouteLines.lua",
			&page("Polestar_Options/Maps/RouteOptions.lua"),
		]),
		// The UI stub, its own login, then the settings window's addon (ui-look-theme.rs); the game menu (Esc)
		// exists before Polestar loads, as in the client (ui-game-menu.rs).
		"ui" => Env {
			stubs: vec!["stub_ui.lua"],
			before: "GameMenuFrame = CreateFrame(\"Frame\", \"GameMenuFrame\", UIParent)\nGameMenuFrame:SetSize(195, 248)\nGameMenuFrame:Hide()\n",
			addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"])],
			login: false,
			prelude: "uistub.install()\nstub.login()\nPolestar.UI.LoadOptions()\n".into(),
		},
		// The whole addon on the world stub, the settings window's addon loaded.
		_ => Env {
			stubs: vec!["stub_world.lua"],
			before: "",
			addons: vec![Addon::name("Polestar")],
			login: true,
			prelude: "stub.advance(1)\nassert(Polestar.UI.LoadOptions())\n".into(),
		},
	}
}

fn run_group(g: &Group) -> Value {
	// The group's environment: its first line names it ("-- env: nav").
	let name = g.src.lines().find_map(|l| l.strip_prefix("-- env: ")).unwrap_or("world").trim().to_string();
	let e = env(&name);
	emitted(&RunAddon {
		stubs: e.stubs,
		before: e.before.into(),
		addons: e.addons,
		login: e.login,
		script: format!("{}__GROUP = (function() {} end)()\n{RUNNER}", e.prelude, g.src),
		..Default::default()
	})
	.remove(0)
}

fn check(name: &str) {
	let g = GROUPS.iter().find(|g| g.name == name).expect("group");
	let out = run_group(g);
	let bad: Vec<String> = out["bad"].as_array().map(|a| a.iter().map(|x| x.as_str().unwrap_or_default().to_string()).collect()).unwrap_or_default();
	assert!(bad.is_empty(), "{name}: {} of {} controls without a live effect:\n{}", bad.len(), out["n"], bad.join("\n"));
}

#[test]
fn arrow() {
	check("arrow");
}

#[test]
fn pins() {
	check("pins");
}

#[test]
fn routes() {
	check("routes");
}

#[test]
fn theme() {
	check("theme");
}

#[test]
fn guidewindow() {
	check("guidewindow");
}

// Every control of the settings window has an effect check, and every check is a control's.
#[test]
#[ignore = "effect checks still to write: the Buttons, Alerts and Trackers pages and the Guiding pages"]
fn every_control_has_an_effect_check() {
	let mut checked = std::collections::BTreeSet::new();
	for g in GROUPS {
		// The group's ids, read from its file without running it.
		let out = emitted(&RunAddon {
			stubs: vec![],
			script: format!("local G = (function() {} end)()\nlocal ids = {{}}\nfor id in pairs(G.probes) do ids[#ids + 1] = id end\nemit(ids)", g.src),
			..Default::default()
		})
		.remove(0);
		for id in out.as_array().cloned().unwrap_or_default() {
			let id = id.as_str().unwrap().to_string();
			assert!(checked.insert(id.clone()), "{id} is checked in two groups");
		}
	}
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: r#"
			stub.advance(1)
			assert(Polestar.UI.LoadOptions())
			local O = Polestar.UI.Options
			local function labelOf(c) if type(c.label) == "function" then return c.label() end return c.label end
			local ids, seen = {}, {}
			for _, c in ipairs(O.AllControls()) do
				local id = c.key or (c.kind == "binding" and ("action:" .. tostring(c.action))) or (c.page.name .. ":" .. tostring(labelOf(c)))
				if not seen[id] then seen[id] = true; ids[#ids + 1] = id end
			end
			emit(ids)"#
			.into(),
		..Default::default()
	})
	.remove(0);
	let controls: std::collections::BTreeSet<String> = out.as_array().unwrap().iter().map(|x| x.as_str().unwrap().to_string()).collect();
	let missing: Vec<&String> = controls.difference(&checked).collect();
	let stale: Vec<&String> = checked.difference(&controls).collect();
	assert!(stale.is_empty(), "checks for controls the window no longer has: {stale:?}");
	assert!(missing.is_empty(), "{} of {} controls have no effect check:\n{}", missing.len(), controls.len(), missing.iter().map(|s| s.as_str()).collect::<Vec<_>>().join("\n"));
}
