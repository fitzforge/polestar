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

// ---------------------------------------------------------------------------------------------------------------
// A player's real SavedVariables (settings-real-1..3.lua: three days of one account with two characters on 0.3.6,
// cut down to the settings and the per-character settings state). Each character logs in on this Polestar: every
// saved setting reads back the same (0.3.6's one move aside: the minimap route size, already split per style at
// every login), the saved positions place the guide window, the arrow and the action buttons where they were, the
// settings window shows each saved value on its control, and the profiles keep characters apart.
// ---------------------------------------------------------------------------------------------------------------

const REAL: [&str; 3] = [include_str!("settings-real-1.lua"), include_str!("settings-real-2.lua"), include_str!("settings-real-3.lua")];

// Lua: ser(v) writes a value back as Lua source (a session's SavedVariables for the next).
const SER: &str = r#"
local function ser(v)
	if type(v) == "table" then
		local parts = {}
		for k, x in pairs(v) do
			local key = type(k) == "number" and ("[" .. k .. "]") or ("[" .. string.format("%q", k) .. "]")
			parts[#parts + 1] = key .. " = " .. ser(x)
		end
		return "{ " .. table.concat(parts, ", ") .. " }"
	elseif type(v) == "string" then return string.format("%q", v)
	elseif type(v) == "number" then return string.format("%.17g", v) end
	return tostring(v)
end
"#;

// The fixtures' two characters, as the client knows them (their faction matters: the guide picker's faction
// filter, for one, goes back to "auto" on a character of the other faction).
const WHO: [&str; 2] = [
	r#"local w = stub.world; w.race, w.raceName, w.raceID, w.class, w.className, w.classID, w.faction = "Tauren", "Tauren", 6, "WARRIOR", "Warrior", 1, "Horde""#,
	r#"local w = stub.world; w.race, w.raceName, w.raceID, w.class, w.className, w.classID, w.faction = "Scourge", "Undead", 5, "WARLOCK", "Warlock", 9, "Horde""#,
];

// One character's session (`who`: 1 or 2) on fixture `real`: `account` and `char` are its SavedVariables (Lua
// expressions over F, the fixture), then the script.
fn session(real: &str, account: &str, char: &str, who: usize, script: &str) -> Value {
	let saved = format!(
		r#"
local F = (function() {real} end)()
local function copy(v) if type(v) ~= "table" then return v end local t = {{}} for k, x in pairs(v) do t[k] = copy(x) end return t end
__F = F
PolestarDB = copy({account})
PolestarCharDB = copy({char})
"#
	);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WHO[who - 1].into(),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), saved)],
		login: true,
		script: format!(
			r#"
local F = __F
local function same(a, b, depth)
	if type(a) == "number" and type(b) == "number" then return math.abs(a - b) < 1e-6 end
	if type(a) ~= type(b) then return false end
	if type(a) ~= "table" then return a == b end
	if (depth or 0) > 8 then return false end
	for k, v in pairs(a) do if not same(v, b[k], (depth or 0) + 1) then return false end end
	for k in pairs(b) do if a[k] == nil then return false end end
	return true
end
{SER}
-- Every saved setting of the fixture's account as path -> value (ui.colors' own colours one by one).
local function saved()
	local out = {{}}
	for section, t in pairs(F.account.settings or {{}}) do
		if type(t) == "table" then
			for k, v in pairs(t) do
				if section == "ui" and k == "colors" and type(v) == "table" then
					for name, c in pairs(v) do out["ui.colors." .. name] = c end
				else
					out[section .. "." .. k] = v
				end
			end
		end
	end
	return out
end
stub.advance(1)
{script}"#
		),
	})
	.remove(0)
}

#[test]
fn real_players_saved_settings_read_back_the_same_for_each_character_and_place_their_frames_where_they_were() {
	for (n, real) in REAL.iter().enumerate() {
		for char in 1..=2 {
			let out = session(
				real,
				"F.account",
				&format!("F.chars[{char}]"),
				char,
				r#"
				local wrong, n = {}, 0
				local moved = { ["nav.minimapRouteSize"] = true } -- 0.3.6 splits it per style at every login
				for path, v in pairs(saved()) do
					if not moved[path] then
						n = n + 1
						if not same(Polestar.Get(path), v) then wrong[#wrong + 1] = path .. " = " .. ser(Polestar.Get(path)) .. " (saved " .. ser(v) .. ")" end
					end
				end
				table.sort(wrong)
				local s = F.account.settings
				local route = s.nav and s.nav.minimapRouteSize
				local split = route == nil or (Polestar.Get("nav.minimapLineSize") == route and Polestar.Get("nav.minimapDotsSize") == route
					and Polestar.Get("nav.minimapSparkleSize") == route and Polestar.Get("nav.minimapRouteSize") == 1)
				-- The frames the saved positions place.
				local pos = s.ui and s.ui.pos
				local gp = { PolestarGuideFrame:GetPoint(1) }
				local guide = pos == nil or (gp[1] == (s.ui.growUp and "BOTTOMLEFT" or "TOPLEFT") and gp[3] == "BOTTOMLEFT" and gp[4] == pos[1] and gp[5] == pos[2])
				local ap = s.nav and s.nav.arrowPos
				local a = { PolestarNavArrow:GetPoint(1) }
				local arrow = ap == nil or (a[1] == ap.point and a[3] == (ap.relPoint or ap.point) and same(a[4], ap.x) and same(a[5], ap.y))
				local bp = PolestarCharDB.qol and PolestarCharDB.qol.buttonPos
				local mine = F.chars[CHAR].qol and F.chars[CHAR].qol.buttonPos
				emit({ n = n, wrong = wrong, split = split, guide = guide, arrow = arrow, buttons = same(bp, mine),
					profile = Polestar.Profiles.Active(), profiles = PolestarDB.profiles == nil or next(PolestarDB.profiles) == nil })"#
					.replace("CHAR", &char.to_string())
					.as_str(),
			);
			let what = format!("snapshot {} character {char}", n + 1);
			assert!(out["n"].as_f64().unwrap() >= 8.0, "{what}: the fixture's settings: {}", out["n"]);
			assert_eq!(out["wrong"], serde_json::json!({}), "{what}: settings that read back otherwise");
			assert_eq!(out["split"], true, "{what}: the saved minimap route size became each style's");
			assert_eq!(out["guide"], true, "{what}: the guide window where it was saved");
			assert_eq!(out["arrow"], true, "{what}: the arrow where it was saved");
			assert_eq!(out["buttons"], true, "{what}: the action buttons' place, this character's own");
			assert_eq!(out["profile"], "Default", "{what}: the settings are the profile Default");
			assert_eq!(out["profiles"], true, "{what}: nothing moved into another profile");
		}
	}
}

// The settings window shows each saved value on its control: a slider at the value (within half a step: a width
// dragged to 418 sits by the 420 mark), a switch on or off, a dropdown's choice, the picture card lit; the Menu
// scale in the window's header.
#[test]
fn real_players_saved_settings_show_on_their_controls_in_the_settings_window() {
	for (n, real) in REAL.iter().enumerate() {
		let out = session(
			real,
			"F.account",
			"F.chars[1]",
			1,
			r#"
			assert(Polestar.UI.LoadOptions())
			Polestar.UI.ShowOptions("guide")
			local O = Polestar.UI.Options
			local wrong, shown = {}, 0
			local homes = O.AllControls()
			local function textOf(c, v)
				local list = c.choices
				if type(list) == "function" then list = list() end
				for _, ch in ipairs(list or {}) do if ch.value == v then return ch.text or ch.label end end
			end
			for path, v in pairs(saved()) do
				local c
				for _, h in ipairs(homes) do if h.key == path and not h.psOwner then c = c or h end end
				if c and c.page then
					O.Select(c.page.key, c.tab or "")
					local w = O.view.cache[c] or O.view.extras[c]
					local ok
					if not w then ok = "no widget"
					elseif c.kind == "slider" then ok = math.abs(w.Slider:GetValue() - v) <= (c.step or 0) / 2 + 1e-6
					elseif c.kind == "toggle" then ok = (w.psOn and true or false) == (v and true or false)
					elseif c.kind == "dropdown" or c.kind == "font" then ok = w.Button.Label:GetText() == textOf(c, v)
					elseif c.kind == "cards" then ok = w.psCardBy[v] ~= nil and w.psCardBy[v].Check:IsShown()
					else ok = true end
					shown = shown + 1
					if ok ~= true then wrong[#wrong + 1] = path .. ": " .. tostring(ok) end
				end
			end
			local menu = F.account.settings.ui and F.account.settings.ui.menuScale
			local header = PolestarOptions.HeaderTools.Value:GetText()
			emit({ wrong = wrong, shown = shown, menu = menu == nil or header == (math.floor(menu * 100 + 0.5) .. "%") })"#,
		);
		let what = format!("snapshot {}", n + 1);
		assert!(out["shown"].as_f64().unwrap() >= 3.0, "{what}: saved settings with a control: {}", out["shown"]);
		assert_eq!(out["wrong"], serde_json::json!({}), "{what}: controls that show something else");
		assert_eq!(out["menu"], true, "{what}: the header's Menu scale shows the saved one");
	}
}

// Two characters on one account: the first makes a profile of its own and changes it; the second, logging in
// after, keeps the account's (Default) untouched; the first, back again, has its own.
#[test]
fn two_characters_keep_their_own_profile_apart_and_share_the_account_s() {
	let real = REAL[1];
	let first = session(
		real,
		"F.account",
		"F.chars[1]",
		1,
		r#"
		local P = Polestar.Profiles
		assert(P.New("Mine", "Default"))
		assert(P.UseForCharacter(true))
		assert(P.Switch("Mine"))
		Polestar.Set("ui.width", 300)
		Polestar.Set("nav.arrowScale", 1.5)
		stub.fire("PLAYER_LOGOUT")
		emit({ db = ser(PolestarDB), char = ser(PolestarCharDB), active = P.Active(), source = P.Source() })"#,
	);
	assert_eq!(first["active"], "Mine");
	assert_eq!(first["source"], "character");
	let db = first["db"].as_str().unwrap().to_string();
	let mine = first["char"].as_str().unwrap().to_string();
	let second = session(
		real,
		&db,
		"F.chars[2]",
		2,
		r#"
		stub.fire("PLAYER_LOGOUT")
		emit({ width = Polestar.Get("ui.width"), arrow = Polestar.Get("nav.arrowScale"), active = Polestar.Profiles.Active(),
			source = Polestar.Profiles.Source(), db = ser(PolestarDB) })"#,
	);
	assert_eq!(second["active"], "Default", "the second character follows the account's profile");
	assert_eq!(second["source"], "account");
	assert_eq!(second["width"], 418, "Default kept the saved width");
	assert_eq!(second["arrow"], 1, "and the default arrow");
	let db2 = second["db"].as_str().unwrap().to_string();
	let again = session(
		real,
		&db2,
		&mine,
		1,
		r#"
		emit({ width = Polestar.Get("ui.width"), arrow = Polestar.Get("nav.arrowScale"), active = Polestar.Profiles.Active() })"#,
	);
	assert_eq!(again, serde_json::json!({ "width": 300, "arrow": 1.5, "active": "Mine" }), "the first character's own profile");
}
