//! Every setting a player could have saved before the settings window keeps its value. The fixture
//! (settings-0.3.6.lua) is every setting Polestar 0.3.6 registered (next before the settings window: 267
//! defaults; nav.minimapRouteSize is left out, 0.3.6 itself moves it into the per-style sizes at every
//! login) plus the four positions and states it saved with no default, each with a value its own controls
//! could have written (another choice, the far end of a slider, the other state of a switch, a colour, a
//! dragged position). Loaded into PolestarDB.settings as 0.3.6 left it, every one must read
//! back the same after login, still be a setting this Polestar knows, survive a round trip through a
//! second profile, and nothing may be rewritten under the player.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

const FIXTURE: &str = include_str!("settings-0.3.6.lua");

fn run(script: &str) -> Value {
	let saved = format!(
		r#"
local F = (function() {FIXTURE} end)()
PolestarDB = {{ schema = 1, settings = {{}} }}
for path, e in pairs(F) do
	local node, keys = PolestarDB.settings, {{}}
	for k in path:gmatch("[^.]+") do keys[#keys + 1] = k end
	for i = 1, #keys - 1 do
		node[keys[i]] = node[keys[i]] or {{}}
		node = node[keys[i]]
	end
	node[keys[#keys]] = e.value
end
__FIXTURE = F
"#
	);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), saved)],
		login: true,
		script: format!(
			r#"
local function same(a, b, depth)
	if type(a) ~= type(b) then return false end
	if type(a) ~= "table" then return a == b end
	if (depth or 0) > 8 then return false end
	for k, v in pairs(a) do if not same(v, b[k], (depth or 0) + 1) then return false end end
	for k in pairs(b) do if a[k] == nil then return false end end
	return true
end
local function show(v)
	if type(v) ~= "table" then return tostring(v) end
	local parts = {{}}
	for k, x in pairs(v) do parts[#parts + 1] = tostring(k) .. "=" .. show(x) end
	table.sort(parts)
	return "{{" .. table.concat(parts, ",") .. "}}"
end
local function check(label)
	local wrong = {{}}
	for path, e in pairs(__FIXTURE) do
		local v = Polestar.Get(path)
		if not same(v, e.value) then wrong[#wrong + 1] = path .. " " .. label .. ": " .. show(v) .. " (saved " .. show(e.value) .. ")" end
	end
	table.sort(wrong)
	return wrong
end
stub.advance(1)
{script}"#
		),
		..Default::default()
	})
	.remove(0)
}

// A Lua list as emitted: an empty one comes as {}.
fn list(v: &Value) -> Vec<String> {
	if v.as_object().is_some_and(|o| o.is_empty()) {
		return vec![];
	}
	v.as_array().unwrap_or_else(|| panic!("not a list: {v}")).iter().map(|x| x.as_str().unwrap_or_default().to_string()).collect()
}

#[test]
fn every_setting_saved_before_the_settings_window_reads_back_the_same_after_login() {
	let out = run(r#"
local unknown = {}
for path, e in pairs(__FIXTURE) do
	-- Still a setting of this Polestar: a default of its own (false counts), unless it never had one.
	if e.kind ~= "saved" and Polestar.GetDefault(path) == nil then unknown[#unknown + 1] = path end
end
table.sort(unknown)
local n = 0
for _ in pairs(__FIXTURE) do n = n + 1 end
emit({ count = n, wrong = check("after login"), unknown = unknown, profile = Polestar.Profiles and Polestar.Profiles.Active() or "none",
	moved = PolestarDB.profiles ~= nil and next(PolestarDB.profiles) ~= nil })"#);
	assert_eq!(out["count"], 271, "the fixture: 267 settings and 4 saved positions or states");
	let wrong = list(&out["wrong"]);
	assert!(wrong.is_empty(), "{} settings lost their saved value:\n{}", wrong.len(), wrong.join("\n"));
	let unknown = list(&out["unknown"]);
	assert!(unknown.is_empty(), "{} settings are no longer settings of this Polestar (retired without a migration):\n{}", unknown.len(), unknown.join("\n"));
	assert_eq!(out["profile"], "Default", "the settings saved before profiles are the profile Default, where they are");
	assert_eq!(out["moved"], false, "nothing moved into another profile");
}

#[test]
fn the_saved_settings_survive_a_round_trip_through_another_profile() {
	let out = run(r#"
local P = Polestar.Profiles
assert(P.New("Second"))
assert(P.Switch("Second"))
local fresh = Polestar.Get("ui.scale")
assert(P.Switch("Default"))
emit({ wrong = check("after a round trip"), fresh = fresh, active = P.Active() })"#);
	assert_eq!(out["active"], "Default");
	assert_eq!(out["fresh"], 1, "a new profile starts at the defaults");
	let wrong = list(&out["wrong"]);
	assert!(wrong.is_empty(), "{} settings changed on the way back to Default:\n{}", wrong.len(), wrong.join("\n"));
}
