//! Nothing a player could set is lost: every control of every release's settings window
//! (settings-controls.json: 0.3.6's, then each later release's new ones; a release's list counts once this build is
//! that release or later) is reachable in this one, and so is every control registered now, references included. A
//! control is reachable when its page and tab are listed, its section shows (in one of its page's modes when it is
//! a mode's own: a choice of a control on the same page), and opening its page puts its widget on screen: its row,
//! its section's header switch, its inline extra, or its row in its cog's popup. The test client has every addon
//! Polestar works with installed, a skin with variants and a layout, a guide with group quests, and Shortest Path
//! Forever, so no control waits on something missing. A few live in the window's own chrome (the Menu scale in its
//! header): those are checked there.

use forge_addontest::run::{addons_dir, lua_value};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

const MANIFEST: &str = include_str!("settings-controls.json");

// Every addon the pages name is installed; a skin with variants and a layout; Shortest Path Forever; a guide with
// group quests. Then reach(c) -> nil | why, and reachId(id) -> nil | why over every control with that id.
const REACH: &str = r#"
_G.ShortestPathForever = { API = { version = 1, Cancel = function() end, Navigate = function() end, NavigateRoute = function() end } }
local T = Polestar.Theme
T.IsEllesmere = function() return true end
C_AddOns.IsAddOnLoaded = function() return true end
if T.RegisterSkin then
	assert(T.RegisterSkin("coverage", { name = "Coverage", addon = "Test_Coverage", preset = { ["ui.fontOutline"] = "thick" },
		variants = { { id = "a", name = "A" }, { id = "b", name = "B" } } }))
	Polestar.Set("ui.skin", "coverage")
end
local E = Polestar.Engine
if E then E.GroupQuests = function() return { { id = 1, title = "Coverage" } } end end
UI.ShowOptions("guide")
local function labelOf(c) if type(c.label) == "function" then return c.label() end return c.label end
local function idOf(c)
	if c.key then return c.key end
	if c.kind == "binding" then return "action:" .. tostring(c.action) end
	return "label:" .. tostring(labelOf(c))
end
local listed = {}
for _, p in ipairs(O.Pages()) do
	local tabs = {}
	for _, t in ipairs(p.tabs) do tabs[t] = true end
	listed[p.key] = { tabs = tabs, n = #p.tabs }
end
local homes = O.AllControls()
local controls = {}
for _, c in ipairs(homes) do controls[#controls + 1] = c end
for _, c in ipairs(O.References()) do controls[#controls + 1] = c end
-- A setting kept in the window's own chrome: -> nil | why.
local CHROME = {
	["ui.menuScale"] = function()
		local h = PolestarOptions.HeaderTools
		if not (h and h:IsShown()) then return "no Menu scale in the header" end
		Polestar.Set("ui.menuScale", 0.9)
		local text = h.Value:GetText()
		Polestar.Set("ui.menuScale", nil)
		if text ~= "90%" then return "the header's Menu scale shows " .. tostring(text) end
	end,
}
-- A setting or section that only shows in a mode: a choice of one of the window's controls, or the other state of
-- one of its switches, that brings it on (its own page's first: the route lines' style; then any page's: the trail
-- dots on Map pins show while Route lines are off). -> restore() | nil
local function modeFor(test, page)
	for pass = 1, 2 do
		for _, h in ipairs(homes) do
			if (pass == 1) == (h.page == page) and h.key and (h.kind == "dropdown" or h.kind == "cards" or h.kind == "toggle") then
				local was = Polestar.Get(h.key)
				local values = {}
				if h.kind == "toggle" then
					values = { not was }
				else
					local list = h.choices
					if type(list) == "function" then list = list() end
					for _, ch in ipairs(list or {}) do values[#values + 1] = ch.value end
				end
				for _, v in ipairs(values) do
					Polestar.Set(h.key, v)
					if test() then return function() Polestar.Set(h.key, was) end end
				end
				Polestar.Set(h.key, was)
			end
		end
	end
end
local function shownIn(s) local ok, v = pcall(s.shown); return ok and v and true or false end
function reach(c)
	local p = c.page
	local l = p and listed[p.key]
	if not l then return "its page is not listed" end
	if not (l.tabs[c.tab or ""] or (l.n == 0 and (c.tab or "") == "")) then return "its tab is not listed" end
	local s = c.psSection
	local restore
	if s and s.shown and not shownIn(s) then
		restore = modeFor(function() return shownIn(s) end, p)
		if not restore then return "its section shows in no mode of its page" end
	end
	local top = c
	while rawget(top, "psOwner") do top = top.psOwner end
	if c.needs and not c.needs() or top.needs and not top.needs() then
		local r2 = modeFor(function() return not (c.needs and not c.needs()) and not (top.needs and not top.needs()) end, p)
		if not r2 then
			if restore then restore() end
			return "it shows in no mode of its page"
		end
		local r1 = restore
		restore = function() r2(); if r1 then r1() end end
	end
	O.Select(p.key, c.tab or "")
	local v = O.view
	local w, why
	local owner = rawget(c, "psOwner")
	local inMore = false
	for _, m in ipairs(owner and owner.more or {}) do if m == c then inMore = true end end
	if inMore then
		-- Its row in its owner's cog popup, shown while the popup is open.
		local cog = v.cogs[owner]
		if cog and cog:IsShown() then
			O.ShowMore(cog, owner)
			w = O.MoreControls()[c.key]
			if not w then why = "no row for it in its cog's popup"
			elseif not w:IsShown() then why = "its row in the cog's popup is hidden" end
			O.HideMore()
		else
			why = "its cog is not on screen"
		end
	else
		if s and s.toggle == c then w = v.extras[c] elseif owner then w = v.extras[c] else w = v.cache[c] end
		if not w then why = "no widget for it on its page"
		elseif not w:IsShown() then why = "its widget is hidden" end
	end
	if restore then restore() end
	return why
end
-- Every control with this id: reachable when one is. -> nil | why, count
function reachId(id)
	if CHROME[id] then return CHROME[id](), 1 end
	local whys, n = {}, 0
	for _, c in ipairs(homes) do
		if idOf(c) == id then
			n = n + 1
			local why = reach(c)
			if not why then return nil, n end
			whys[#whys + 1] = (c.page and c.page.key or "?") .. ": " .. why
		end
	end
	if n == 0 then return "no control has it", 0 end
	return table.concat(whys, "; "), n
end
"#;

// The whole addon on the world stub, logged in, the settings window's addon loaded.
fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: format!("stub.advance(1)\nassert(Polestar.UI.LoadOptions())\nlocal UI, O = Polestar.UI, Polestar.UI.Options\n{REACH}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

// "0.3.10" > "0.3.7".
fn version(s: &str) -> Vec<u64> {
	s.split('.').map(|p| p.trim().parse().unwrap_or(0)).collect()
}

// This build's release, from Polestar's TOC.
fn build_version() -> Vec<u64> {
	let toc = std::fs::read_to_string(addons_dir().join("Polestar/Polestar.toc")).expect("Polestar.toc");
	let line = toc.lines().find(|l| l.starts_with("## Version:")).expect("## Version in Polestar.toc");
	version(line.trim_start_matches("## Version:"))
}

// The manifest's control ids, split: the releases up to this build's (due), and the later ones' (ahead: their rows
// may stand in the window before this build registers their settings). The effect checks' coverage uses it too.
pub(crate) fn due_and_ahead() -> (Vec<Value>, Vec<Value>) {
	let manifest: Value = serde_json::from_str(MANIFEST).expect("settings-controls.json");
	let build = build_version();
	let mut due = vec![];
	let mut ahead = vec![];
	for (release, entries) in manifest.as_object().unwrap() {
		if release.starts_with('_') {
			continue;
		}
		let ids: Vec<Value> = entries.as_array().unwrap().iter().map(|e| e["id"].clone()).collect();
		if version(release) <= build {
			due.extend(ids);
		} else {
			ahead.extend(ids);
		}
	}
	(due, ahead)
}

fn list(v: &Value) -> Vec<String> {
	if v.as_object().is_some_and(|o| o.is_empty()) {
		return vec![];
	}
	v.as_array().unwrap_or_else(|| panic!("not a list: {v}")).iter().map(|x| x.as_str().unwrap_or_default().to_string()).collect()
}

#[test]
fn every_control_of_every_release_s_settings_window_is_reachable_in_this_one() {
	let (due, ahead) = due_and_ahead();
	assert!(due.len() >= 277, "0.3.6's 277 controls at least: {}", due.len());
	let out = run(&format!(
		r#"
		local due, ahead = {due}, {ahead}
		local lost, pending = {{}}, {{}}
		for _, id in ipairs(due) do
			local why = reachId(id)
			if why then lost[#lost + 1] = id .. ": " .. why end
		end
		-- A later release's control: once it is in this build (anything has it), it must be reachable too.
		for _, id in ipairs(ahead) do
			local why, n = reachId(id)
			if n == 0 then pending[#pending + 1] = id elseif why then lost[#lost + 1] = id .. " (a later release's): " .. why end
		end
		table.sort(lost)
		emit({{ lost = lost, pending = pending, checked = #due + #ahead }})"#,
		due = lua_value(&Value::Array(due)),
		ahead = lua_value(&Value::Array(ahead))
	));
	let lost = list(&out["lost"]);
	assert!(lost.is_empty(), "{} controls of a release's settings window can no longer be reached:\n{}", lost.len(), lost.join("\n"));
	eprintln!("{} controls checked; not yet in this build: {}", out["checked"], list(&out["pending"]).join(", "));
}

#[test]
fn every_control_registered_now_is_reachable_on_its_page() {
	let out = run(r#"
		local lost, n = {}, 0
		for _, c in ipairs(controls) do
			n = n + 1
			local why = reach(c)
			if why then
				lost[#lost + 1] = (rawget(c, "ref") and "a reference to " or "") .. (c.key or c.action or tostring(c.label)) .. " ("
					.. (c.page and c.page.key or "?") .. " > " .. tostring(c.tab) .. " > " .. tostring(c.section) .. "): " .. why
			end
		end
		table.sort(lost)
		emit({ lost = lost, n = n })"#);
	assert!(out["n"].as_f64().unwrap() >= 600.0, "every control: {}", out["n"]);
	let lost = list(&out["lost"]);
	assert!(lost.is_empty(), "{} controls cannot be reached:\n{}", lost.len(), lost.join("\n"));
}
