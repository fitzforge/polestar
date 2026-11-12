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
//! reads it bound, then cleared. A setting read only at login (`login`: the guide opened when no tab is saved) is
//! checked across logins, in three fresh sessions of the group's environment: in each the check's `with` and
//! `prepare` (there, what the login reads) and the setting are written once the addon has loaded, before the login,
//! the setting at its default, the value the runner picks, its default again; the environment up (no `setup`), the
//! probe reads once, and the three reads are compared as above.
//!
//! Each group file starts with the environment it runs in, `-- env: <name> [stub file...]` (one of env()'s, with
//! more of tests/lua's stubs after its own: `-- env: world stub_rares.lua`), optionally a Codex pack the client
//! loads when asked (`-- codex: sample.json`, a tests/fixtures/codex file) and the quest database built from
//! tests/fixtures/questdb (`-- questdb: fixture`, with stub_quests.lua), and returns { setup = fn?, settle =
//! seconds?, probes = { [id] = probe | { probe, value?, with?, prepare?, cleanup?, press?, bind?, login?, restore? } } }
//! where id is the control's setting key, "action:<binding action>" or "<page>:<English label>" for a control with
//! neither. `restore`: a control of the game's own state that no reset touches (its set(nil) does nothing: the game's
//! image sharpening) is put back by writing the value it had, not nil.

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::questdb::{build_db, fixture_dir as questdb_fixture, QuestDb};
use forge_addontest::run::{lua_string, lua_value};
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
	Group { name: "integrations", src: include_str!("effects/integrations.lua") },
	Group { name: "discovery", src: include_str!("effects/discovery.lua") },
	Group { name: "discovery_lookup", src: include_str!("effects/discovery-lookup.lua") },
	Group { name: "discovery_dungeons", src: include_str!("effects/discovery-dungeons.lua") },
	Group { name: "gamepad", src: include_str!("effects/gamepad.lua") },
	Group { name: "qol", src: include_str!("effects/qol.lua") },
	Group { name: "qol_spells", src: include_str!("effects/qol-spells.lua") },
	Group { name: "qol_maps", src: include_str!("effects/qol-maps.lua") },
	Group { name: "buttons", src: include_str!("effects/buttons.lua") },
	Group { name: "buttons_world", src: include_str!("effects/buttons-world.lua") },
	Group { name: "map_quests", src: include_str!("effects/map-quests.lua") },
	Group { name: "map_travel", src: include_str!("effects/map-travel.lua") },
	Group { name: "map_codex", src: include_str!("effects/map-codex.lua") },
	Group { name: "questing_qol", src: include_str!("effects/questing-qol.lua") },
	Group { name: "questing_world", src: include_str!("effects/questing-world.lua") },
	Group { name: "questing_quests", src: include_str!("effects/questing-quests.lua") },
	Group { name: "questing_party", src: include_str!("effects/questing-party.lua") },
	Group { name: "questing_gear", src: include_str!("effects/questing-gear.lua") },
	Group { name: "questing_bagmarks", src: include_str!("effects/questing-bagmarks.lua") },
	Group { name: "guide_window", src: include_str!("effects/guide-window.lua") },
	Group { name: "guide_hud", src: include_str!("effects/guide-hud.lua") },
	Group { name: "guide_nav", src: include_str!("effects/guide-nav.lua") },
	Group { name: "guide_whilehere", src: include_str!("effects/guide-whilehere.lua") },
	Group { name: "guide_whilehere_turnins", src: include_str!("effects/guide-whilehere-turnins.lua") },
	Group { name: "guide_automation", src: include_str!("effects/guide-automation.lua") },
	Group { name: "guide_route", src: include_str!("effects/guide-route.lua") },
	Group { name: "guide_ends", src: include_str!("effects/guide-ends.lua") },
	Group { name: "guide_class", src: include_str!("effects/guide-class.lua") },
	Group { name: "alerts_rare", src: include_str!("effects/alerts-rare.lua") },
	Group { name: "alerts_cards", src: include_str!("effects/alerts-cards.lua") },
	Group { name: "alerts_classcard", src: include_str!("effects/alerts-classcard.lua") },
	Group { name: "trackers_travel", src: include_str!("effects/trackers-travel.lua") },
	Group { name: "trackers_instances", src: include_str!("effects/trackers-instances.lua") },
	Group { name: "trackers_party", src: include_str!("effects/trackers-party.lua") },
	Group { name: "pins_world", src: include_str!("effects/pins-world.lua") },
];

// Two reads compared (numbers within 1e-4, tables by their keys) and shown in a message: the runner's, and a login
// check's verdict (login_check).
const COMPARE: &str = r#"
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
"#;

// The runner: the group's probes over the control specs (the registry's, and the settings window's own pages
// when it is loaded); a login check is left to login_check, with the default and the value it logs in with.
// -> emit({ bad = { "id: why", ... }, n = checked, logins = { { id, key, default, value }, ... } })
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
-- The value now, and another one the control could write (than `cur`, when given: a login check's default). A
-- control with its own get/set reads and writes through them, as its widget does (the minimap size of the style in
-- use; deathskips, off on Hardcore).
local function current(c)
	if c.get then return c.get() end
	if c.key then return Polestar.Get(c.key) end
end
local function other(c, cur)
	if cur == nil then cur = current(c) end
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
local bad, n, logins = {}, 0, {}
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
		if e.login then
			if not c.key then return "a login check needs a setting key" end
			local default, v = Polestar.GetDefault(c.key), e.value
			if v == nil then v = other(c, default) end
			if v == nil then return "no other value to write" end
			logins[#logins + 1] = { id = id, key = c.key, default = default, value = v }
			return
		end
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
			local had = current(c)
			write(c, v)
			wait()
			local after = e.probe()
			if e.restore then write(c, had) else write(c, nil) end
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
emit({ bad = bad, n = n, logins = logins })
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
		// The whole addon with EllesmereUI installed before it loads (theme.rs).
		"eui" => Env { before: "stub.withEllesmere()\n", ..env("world") },
		// The real QoL against tests/lua/stub_qol.lua's client and its fake Engine, Nav and Pins (qol.rs,
		// qol-items.rs, ui-look-buttons.rs), with its rows (the settings' addon's QoL/Options.lua) and the Buttons
		// page that sets the action buttons' looks. The whole addon's guide window can't draw the fake Engine's
		// steps, so not the world environment.
		"qol" => Env {
			stubs: vec!["stub_qol.lua"],
			before: "",
			addons: vec![Addon::files(
				"Polestar",
				&["Core/Init.lua", "Core/Compat.lua", "Core/Hooks.lua", "Theme/Theme.xml", "QoL/QoL.xml", &page("Polestar_Options/QoL/Options.lua"), &page("Polestar_Options/QoL/ButtonsOptions.lua")],
			)],
			login: true,
			prelude: "stub.advance(1)\n".into(),
		},
		// The whole addon on the world stub, the settings window's addon loaded.
		_ => Env { stubs: vec!["stub_world.lua"], before: "", addons: vec![Addon::name("Polestar")], login: true, prelude: "stub.advance(1)\nassert(Polestar.UI.LoadOptions())\n".into() },
	}
}

// A group's environment, ready to run: its first line names it ("-- env: nav"), and may add stubs to it ("-- env:
// world stub_rares.lua"); `before` loads the Codex pack and quest database the group names, held until the run ends.
struct Ready {
	e: Env,
	before: String,
	_codex: Option<CodexPack>,
	_questdb: Option<QuestDb>,
}

fn ready(g: &Group) -> Ready {
	let mut words = g.src.lines().find_map(|l| l.strip_prefix("-- env: ")).unwrap_or("world").split_whitespace();
	let mut e = env(words.next().unwrap_or("world"));
	for s in words {
		if !e.stubs.contains(&s) {
			e.stubs.push(s);
		}
	}
	// A Codex pack from a tests/fixtures/codex file the group names ("-- codex: sample.json"), loaded when the
	// addon asks for it, as the client does (rares.rs, lookup.rs).
	let codex = g.src.lines().find_map(|l| l.strip_prefix("-- codex: ")).map(|f| write_codex_pack(&fixture(f.trim()), &CodexOpts::default()));
	let mut before = match &codex {
		Some(pack) => format!("{}\n{}", pack.stub_lua, e.before),
		None => e.before.into(),
	};
	// The quest database `forge data questdb` builds from tests/fixtures/questdb, there when the addon asks for it
	// at login, as quests.rs has it ("-- questdb: fixture", with stub_quests.lua on the env line).
	let questdb = g.src.lines().any(|l| l.trim_end() == "-- questdb: fixture").then(|| build_db(&questdb_fixture()));
	if let Some(db) = &questdb {
		before = format!("stub.quests.dbFiles = {}\n{before}", db.lua_files());
	}
	Ready { e, before, _codex: codex, _questdb: questdb }
}

fn run_group(g: &Group) -> Value {
	let r = ready(g);
	emitted(&RunAddon {
		stubs: r.e.stubs,
		before: r.before,
		addons: r.e.addons,
		login: r.e.login,
		script: format!("{}{COMPARE}__GROUP = (function() {} end)()\n{RUNNER}", r.e.prelude, g.src),
		..Default::default()
	})
	.remove(0)
}

// One session of a login check: the check's `with` and `prepare` and the setting at `value`, written once the addon
// has loaded and before the login; the environment up, the probe's one read (null for nil).
fn login_read(g: &Group, id: &str, key: &str, value: &Value) -> Value {
	let r = ready(g);
	let pre = format!(
		"__GROUP = (function() {} end)()\nlocal __e = __GROUP.probes[{}]\nfor k, v in pairs(__e.with or {{}}) do Polestar.Set(k, v) end\nif __e.prepare then __e.prepare() end\nPolestar.Set({}, {})\n",
		g.src,
		lua_string(id),
		lua_string(key),
		lua_value(value)
	);
	let login = if r.e.login { "stub.login()\n" } else { "" };
	let out = emitted(&RunAddon {
		stubs: r.e.stubs,
		before: r.before,
		addons: r.e.addons,
		login: false,
		script: format!("{pre}{login}{}stub.advance(__GROUP.settle or 0.1)\nemit({{ read = __e.probe() }})", r.e.prelude),
		..Default::default()
	})
	.remove(0);
	out.get("read").cloned().unwrap_or(Value::Null)
}

// A login check (the runner's `logins`): read after a login with the setting at its default, at the value, at its
// default again, each a fresh session, and compared as the runner compares. -> why it fails
fn login_check(g: &Group, l: &Value) -> Option<String> {
	let (id, key) = (l["id"].as_str().unwrap_or_default(), l["key"].as_str().unwrap_or_default());
	let (default, value) = (&l["default"], &l["value"]);
	let reads: Vec<String> = [default, value, default].iter().map(|v| lua_value(&login_read(g, id, key, v))).collect();
	let verdict = emitted(&RunAddon {
		script: format!(
			"{COMPARE}local v, before, after, back = {}, {}, {}, {}
if same(before, after) then emit(\"changing it to \" .. show(v) .. \" changes nothing at the next login: \" .. show(before))
elseif not same(before, back) then emit(\"back at its default it leaves \" .. show(back) .. \" at the next login (was \" .. show(before) .. \")\")
else emit(false) end",
			lua_value(value),
			reads[0],
			reads[1],
			reads[2]
		),
		..Default::default()
	})
	.remove(0);
	verdict.as_str().map(|why| format!("{id}: {why}"))
}

fn check(name: &str) {
	let g = GROUPS.iter().find(|g| g.name == name).expect("group");
	let out = run_group(g);
	let mut bad: Vec<String> = out["bad"].as_array().map(|a| a.iter().map(|x| x.as_str().unwrap_or_default().to_string()).collect()).unwrap_or_default();
	bad.extend(out["logins"].as_array().into_iter().flatten().filter_map(|l| login_check(g, l)));
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

#[test]
fn integrations() {
	check("integrations");
}

#[test]
fn discovery() {
	check("discovery");
}

#[test]
fn discovery_lookup() {
	check("discovery_lookup");
}

#[test]
fn discovery_dungeons() {
	check("discovery_dungeons");
}

#[test]
fn gamepad() {
	check("gamepad");
}

#[test]
fn qol() {
	check("qol");
}

#[test]
fn qol_spells() {
	check("qol_spells");
}

#[test]
fn qol_maps() {
	check("qol_maps");
}

#[test]
fn buttons() {
	check("buttons");
}

#[test]
fn buttons_world() {
	check("buttons_world");
}

#[test]
fn map_quests() {
	check("map_quests");
}

#[test]
fn map_travel() {
	check("map_travel");
}

#[test]
fn map_codex() {
	check("map_codex");
}

#[test]
fn questing_qol() {
	check("questing_qol");
}

#[test]
fn questing_world() {
	check("questing_world");
}

#[test]
fn questing_quests() {
	check("questing_quests");
}

#[test]
fn questing_party() {
	check("questing_party");
}

#[test]
fn questing_gear() {
	check("questing_gear");
}

#[test]
fn questing_bagmarks() {
	check("questing_bagmarks");
}

#[test]
fn guide_window() {
	check("guide_window");
}

#[test]
fn guide_hud() {
	check("guide_hud");
}

#[test]
fn guide_nav() {
	check("guide_nav");
}

#[test]
fn guide_whilehere() {
	check("guide_whilehere");
}

#[test]
fn guide_whilehere_turnins() {
	check("guide_whilehere_turnins");
}

#[test]
fn guide_automation() {
	check("guide_automation");
}

#[test]
fn guide_route() {
	check("guide_route");
}

#[test]
fn guide_ends() {
	check("guide_ends");
}

#[test]
fn guide_class() {
	check("guide_class");
}

#[test]
fn alerts_rare() {
	check("alerts_rare");
}

#[test]
fn alerts_cards() {
	check("alerts_cards");
}

#[test]
fn alerts_classcard() {
	check("alerts_classcard");
}

#[test]
fn trackers_travel() {
	check("trackers_travel");
}

#[test]
fn trackers_instances() {
	check("trackers_instances");
}

#[test]
fn trackers_party() {
	check("trackers_party");
}

#[test]
fn pins_world() {
	check("pins_world");
}

// Every control of the settings window has an effect check, and every check is a registered control's. A later
// release's control whose setting this build does not register yet (settings-coverage.rs pending_lua: its row placed
// in the window ahead of the setting it needs) needs its check once this build is that release.
#[test]
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
		script: format!(
			r#"
			stub.advance(1)
			assert(Polestar.UI.LoadOptions())
			{pending}
			local O = Polestar.UI.Options
			local function labelOf(c) if type(c.label) == "function" then return c.label() end return c.label end
			-- An id is due a check unless every control with it is pending.
			local ids, seen, owes = {{}}, {{}}, {{}}
			for _, c in ipairs(O.AllControls()) do
				local id = c.key or (c.kind == "binding" and ("action:" .. tostring(c.action))) or (c.page.name .. ":" .. tostring(labelOf(c)))
				if not seen[id] then
					seen[id] = true
					ids[#ids + 1] = id
				end
				if not pending(c) then owes[id] = true end
			end
			local due, waiting = {{}}, {{}}
			for _, id in ipairs(ids) do
				if owes[id] then due[#due + 1] = id else waiting[#waiting + 1] = id end
			end
			table.sort(waiting)
			emit({{ ids = ids, due = due, pending = waiting }})"#,
			pending = crate::settings_coverage::pending_lua()
		),
		..Default::default()
	})
	.remove(0);
	let set = |v: &Value| -> std::collections::BTreeSet<String> { v.as_array().unwrap().iter().map(|x| x.as_str().unwrap().to_string()).collect() };
	let (controls, due) = (set(&out["ids"]), set(&out["due"]));
	let pending: Vec<String> = out["pending"].as_array().cloned().unwrap_or_default().iter().map(|x| x.as_str().unwrap_or_default().to_string()).collect();
	let missing: Vec<&String> = due.difference(&checked).collect();
	let retired = crate::settings_coverage::retired();
	let stale: Vec<&String> = checked.difference(&controls).filter(|id| !retired.contains(*id)).collect();
	assert!(stale.is_empty(), "checks for controls the window no longer has: {stale:?}");
	assert!(
		missing.is_empty(),
		"{} of {} controls have no effect check:\n{}\n(a later release's, pending until this build is that release: {})",
		missing.len(),
		due.len(),
		missing.iter().map(|s| s.as_str()).collect::<Vec<_>>().join("\n"),
		pending.join(", ")
	);
	eprintln!("a later release's controls, pending until this build is that release: {}", pending.join(", "));
}
