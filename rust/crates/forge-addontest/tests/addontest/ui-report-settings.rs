//! The report's Settings section (addon/Polestar/UI/Report.lua, settingsSection): the settings the player changed
//! from their defaults in the profile in use, so a report tells a setting they turned from a bug of ours. "all
//! defaults" when nothing changed; each setting by its key, ranked, the looks in one line; past R.SETTINGS_MAX
//! characters "+N more #hash" and the packed line that unfolds to every one; never a character's name or realm;
//! the whole report still inside one Discord message. The Discord bot's side is in tests/discord-bot.test.js.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 4] = ["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml", "UI/UI.xml"];

// Defaults of modules these files leave out, as those modules register them (Nav/Walk.lua, Nav/Travel.lua,
// QoL/QoL.lua).
const MORE_DEFAULTS: &str = r#"
Polestar.RegisterDefaults("nav", { routeStyle = "balanced", travel = true })
Polestar.RegisterDefaults("qol", { sellJunk = true, stepGossip = true, markMob = "8" })
"#;

const HELPERS: &str = r#"
local UI, R, P = Polestar.UI, Polestar.UI.Report, Polestar.Profiles
-- A setting straight into the profile in use, as the SavedVariables hold it.
local function set(path, v)
	local node = Polestar.DB().settings
	local keys = {}
	for k in path:gmatch("[^.]+") do keys[#keys + 1] = k end
	for i = 1, #keys - 1 do
		node[keys[i]] = node[keys[i]] or {}
		node = node[keys[i]]
	end
	node[keys[#keys]] = v
end
-- The Settings section of a report's details: its lines and their kinds.
local function section(d)
	local lines, kinds = {}, {}
	for i, l in ipairs(d.lines) do
		if d.kinds[i]:find("^setting") then
			lines[#lines + 1] = l
			kinds[#kinds + 1] = d.kinds[i]
		end
	end
	return { lines = lines, kinds = kinds }
end
-- Every setting registered with these files turned from its default: a switch to the other side, a number up
-- one, a choice to another word, records walked into. -> how many
local function changeAll()
	local n = 0
	local function turn(def, into, depth)
		for k, v in pairs(def) do
			if type(v) == "boolean" then
				into[k], n = not v, n + 1
			elseif type(v) == "number" then
				into[k], n = v + 1, n + 1
			elseif type(v) == "string" then
				into[k], n = v .. "2", n + 1
			elseif type(v) == "table" and v[1] == nil and depth < 3 then
				into[k] = into[k] or {}
				turn(v, into[k], depth + 1)
			end
		end
	end
	local s = Polestar.DB().settings
	for _, sec in ipairs({ "behavior", "update", "ui", "guideWindow", "toasts", "trackers", "movers", "routePlan", "gear", "gamepad", "nav", "qol" }) do
		local def = Polestar.GetDefault(sec)
		if type(def) == "table" then
			s[sec] = s[sec] or {}
			turn(def, s[sec], 1)
		end
	end
	return n
end
-- The packed line's settings, unfolded with the client's decoders (tests/lua/stub_encoding.lua).
local function unfold(line)
	local sum, body = line:match("^!PSR1!(%x+)!(.+)$")
	local raw = C_EncodingUtil.DecompressString(C_EncodingUtil.DecodeBase64(body), Enum.CompressionMethod.Zlib)
	local out = {}
	for l in (raw .. "\n"):gmatch("([^\n]*)\n") do out[#out + 1] = l end
	return { sum = sum, check = Polestar.Import.Adler32(raw), settings = out }
end
"#;

fn run_in(before: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_encoding.lua"],
		before: before.into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install()\nstub.login()\n{MORE_DEFAULTS}\n{HELPERS}\n{script}"),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_in("", script)
}

fn strs(v: &Value) -> Vec<String> {
	v.as_array().map(|a| a.iter().map(|s| s.as_str().unwrap_or_default().to_string()).collect()).unwrap_or_default()
}

/// Characters as Discord counts them: UTF-16 units, as JavaScript does.
fn discord_len(s: &str) -> usize {
	s.encode_utf16().count()
}

/// The looks a looks line stands for: "looks: skin=x scheme=y · 3 positions moved · 200 other looks" is the picks
/// named, then the counts.
fn looks_in(line: &str) -> usize {
	let body = line.strip_prefix("looks: ").expect("looks: ...");
	let mut n = 0;
	for part in body.split(" \u{b7} ") {
		if part.ends_with(" moved") || part.ends_with(" looks") || part.ends_with(" look") {
			n += part.split(' ').next().unwrap().parse::<usize>().unwrap();
		} else {
			n += part.split(' ').count();
		}
	}
	n
}

/// "+N more #hash" -> (N, hash).
fn more_of(line: &str) -> (usize, String) {
	let (count, hash) = line.strip_prefix('+').and_then(|r| r.split_once(" more #")).unwrap_or_else(|| panic!("+N more #hash: {line}"));
	(count.parse().unwrap(), hash.to_string())
}

#[test]
fn a_player_on_the_defaults_gets_one_settings_line_that_says_all_defaults() {
	let out = run(
		r#"
uistub.setGuide(uistub.elwynn, 3)
emit(section(R.Details()))"#,
	);
	assert_eq!(out[0], json!({ "lines": ["Settings: all defaults"], "kinds": ["settings"] }), "the account's Default profile, nothing changed: no more to say");
}

#[test]
fn a_few_changes_read_as_compact_lines_ranked_by_what_they_change_with_the_looks_in_one_line() {
	let out = run(
		r#"
set("behavior.autoAccept", false)
set("behavior.whileHereRadius", 400)
set("nav.routeStyle", "fastest")
set("gear.minUpgrade", 5)
set("qol.sellJunk", false)
set("update.card", false)
set("ui.skin", "hearth")
set("ui.scheme", "night")
set("ui.pos", { 100, 200 })
set("nav.arrowPos", { point = "CENTER", relPoint = "CENTER", x = 140.2, y = -90 })
set("ui.accent", { 0.25, 0.5, 0.75 })
set("guideWindow.titleSize", 1.2)
uistub.setGuide(uistub.elwynn, 3)
local d = R.Details()
emit(section(d))
emit({ text = R.Text("The vermin were all by the tents.", d) })"#,
	);
	assert_eq!(
		strs(&out[0]["lines"]),
		[
			"Settings: profile Default (account) \u{b7} 12 changed",
			"behavior.autoAccept=off behavior.whileHereRadius=180->400 nav.routeStyle=balanced->fastest",
			"gear.minUpgrade=1->5 qol.sellJunk=off update.card=off",
			"looks: skin=hearth scheme=night \u{b7} 2 positions moved \u{b7} 2 other looks",
		],
		"the guide and automation first, then navigation, gear, quality of life and the rest; a switch as on/off, anything else as default->value; the looks summed up"
	);
	assert_eq!(strs(&out[0]["kinds"]), ["settings", "settinglist", "settinglist", "settinglooks"]);
	let text = out[1]["text"].as_str().unwrap();
	let lines: Vec<&str> = text.lines().collect();
	let at = lines.iter().position(|l| l.starts_with("Settings: ")).expect("the Settings line");
	assert_eq!(lines[at + 3], "looks: skin=hearth scheme=night \u{b7} 2 positions moved \u{b7} 2 other looks");
	assert!(lines[at + 4] == "```" || lines[at + 4] == "Log:", "the section ends the details: {text}");
	assert!(!text.contains("!PSR1!") && !text.contains(" more #"), "all of it in view: nothing packed: {text}");
}

#[test]
fn many_changes_stop_the_list_at_its_cap_count_the_rest_and_pack_it_in_a_line_that_with_the_list_unfolds_to_them_all() {
	let out = run(
		r#"
local n = changeAll()
uistub.setGuide(uistub.elwynn, 3)
local d = R.Details()
local s = section(d)
local packed, listed = nil, {}
for i, k in ipairs(s.kinds) do
	if k == "settingcode" then packed = unfold(s.lines[i]) end
	if k == "settinglist" then for e in s.lines[i]:gmatch("%S+") do listed[#listed + 1] = e end end
end
local all = {}
for _, e in ipairs(listed) do all[#all + 1] = e end
for _, e in ipairs(packed.settings) do all[#all + 1] = e end
emit({ n = n, max = R.SETTINGS_MAX, section = s, packed = packed, hashOfAll = Polestar.Import.Adler32(table.concat(all, "\n")) })"#,
	);
	let o = &out[0];
	let n = o["n"].as_u64().unwrap() as usize;
	assert!(n > 200, "every setting these files register turned: {n}");
	let lines = strs(&o["section"]["lines"]);
	let kinds = strs(&o["section"]["kinds"]);
	let line_of = |kind: &str| lines[kinds.iter().position(|k| k == kind).unwrap_or_else(|| panic!("a {kind} line: {lines:?}"))].clone();
	assert_eq!(lines[0], format!("Settings: profile Default (account) \u{b7} {n} changed"));
	assert_eq!(kinds.iter().filter(|k| *k == "settingmore").count(), 1, "{lines:?}");
	assert_eq!(kinds.last().map(String::as_str), Some("settingcode"), "the packed line last: {kinds:?}");
	// The lines a reader sees: the first, the list, the looks and "+N more", at most R.SETTINGS_MAX characters.
	let shown: usize = lines.iter().zip(&kinds).filter(|(_, k)| *k != "settingcode").map(|(l, _)| l.chars().count() + 1).sum();
	let max = o["max"].as_u64().unwrap() as usize;
	assert!(shown <= max && shown > max - 120, "the visible section fills its cap: {shown} of {max}");
	let list: Vec<&String> = lines.iter().zip(&kinds).filter(|(_, k)| *k == "settinglist").map(|(l, _)| l).collect();
	for l in &list {
		assert!(l.chars().count() <= 100, "a list line of 100 characters at most: {l}");
	}
	let listed: Vec<String> = list.iter().flat_map(|l| l.split(' ').map(String::from)).collect();
	assert!(listed[0].starts_with("behavior."), "the guide's own settings lead: {listed:?}");
	assert!(listed.iter().all(|e| !e.starts_with("guideWindow.") && !e.starts_with("ui.skin=")), "no look in the list: {listed:?}");
	let (count, hash) = more_of(&line_of("settingmore"));
	let packed = &o["packed"];
	let rest = strs(&packed["settings"]);
	assert_eq!(listed.len() + rest.len(), n, "the packed line holds every setting the list leaves out: with it, all of them");
	assert!(rest.iter().all(|e| !listed.contains(e)), "nothing twice");
	let looks = looks_in(&line_of("settinglooks"));
	assert!(looks > 50, "the looks line counts the looks: {looks}");
	assert_eq!(count, rest.len() - looks, "+N counts the settings the list leaves out, the looks apart");
	assert!(rest[count..].iter().any(|e| e.starts_with("guideWindow.") && e.contains("->")), "the looks follow, each with its value");
	assert!(rest[..count].iter().all(|e| !e.starts_with("guideWindow.")), "first the settings the list had no room for");
	assert_eq!(packed["sum"], packed["check"], "the envelope's checksum is its payload's Adler-32");
	assert_eq!(o["hashOfAll"].as_str().unwrap(), hash, "the hash after +N is of every setting, the list's then the packed line's");
	for e in listed.iter().chain(&rest) {
		let (key, value) = e.split_once('=').unwrap_or_else(|| panic!("key=value: {e}"));
		assert!(key.contains('.') && !value.is_empty(), "{e}");
	}
}

#[test]
fn a_report_trimmed_to_fit_drops_the_packed_line_first_and_counts_any_list_line_it_drops_in_plus_n_more() {
	let out = run(
		r#"
changeAll()
uistub.setGuide(uistub.elwynn, 3)
local d = R.Details()
local roomy = R.Text("x", d)
R.TEXT_MAX = 1000
local tight = R.Text("x", d)
emit({ roomy = roomy, tight = tight, lines = section(d).lines, kinds = section(d).kinds })"#,
	);
	let lines = strs(&out[0]["lines"]);
	let kinds = strs(&out[0]["kinds"]);
	let more = &lines[kinds.iter().position(|k| k == "settingmore").unwrap()];
	let (count, hash) = more_of(more);
	let roomy = out[0]["roomy"].as_str().unwrap();
	assert!(!roomy.contains("!PSR1!"), "at 2000 characters the packed line of every setting is the first to go");
	assert!(roomy.lines().any(|l| l == more), "{roomy}");
	let tight = out[0]["tight"].as_str().unwrap();
	assert!(tight.chars().count() <= 1000, "{}", tight.chars().count());
	let is_list = |l: &str| lines.iter().zip(&kinds).any(|(s, k)| k == "settinglist" && s == l);
	let listed: usize = lines.iter().zip(&kinds).filter(|(_, k)| *k == "settinglist").map(|(l, _)| l.split(' ').count()).sum();
	let kept: usize = tight.lines().filter(|l| is_list(l)).map(|l| l.split(' ').count()).sum();
	assert!(kept < listed, "the tight report gave up list lines: {tight}");
	let want = format!("+{} more #{hash}", count + listed - kept);
	assert!(tight.lines().any(|l| l == want), "the settings it gave up are counted with the rest: {want} in {tight}");
	assert!(tight.lines().any(|l| l.starts_with("Settings: ")), "the Settings line stays: {tight}");
}

#[test]
fn looks_alone_make_the_looks_line_naming_the_skins_picks_and_counting_the_rest_and_nothing_else() {
	let out = run(
		r#"
set("ui.scheme", "night")
set("ui.font", "inter")
set("ui.scale", 0.9)
set("nav.arrowPos", { point = "TOP", relPoint = "TOP", x = 230.0016327, y = -37.00004959 })
set("rares.toastPoint", { "TOP", -282, -290 })
set("ui.pos", { 2940, 13 })
set("guideWindow.goalSize", 1.2)
set("ui.accent", { 0.25, 0.5, 0.75 })
set("nav.arrowColor", { 1, 0.5, 0 })
uistub.setGuide(uistub.elwynn, 3)
emit(section(R.Details()))"#,
	);
	assert_eq!(
		out[0],
		json!({
			"lines": [
				"Settings: profile Default (account) \u{b7} 9 changed",
				"looks: scheme=night font=inter scale=0.9 \u{b7} 3 positions moved \u{b7} 3 other looks",
			],
			"kinds": ["settings", "settinglooks"],
		}),
		"positions, sizes, colours, fonts and the skin's picks make one line; nothing packed, nothing listed"
	);
}

#[test]
fn values_read_compactly_and_a_setting_no_module_registers_is_left_out() {
	let out = run(
		r#"
set("behavior.whileHereTurninSeconds", 33.3333)
set("behavior.trainReminder", "off")
set("behavior.closeSkipped", false)
set("behavior.noSuchSetting", true)
set("gear.spec", { WARRIOR = "arms" })
emit(section(R.Details()).lines)"#,
	);
	assert_eq!(
		strs(&out[0]),
		[
			"Settings: profile Default (account) \u{b7} 4 changed",
			"behavior.closeSkipped=off behavior.trainReminder=2->off behavior.whileHereTurninSeconds=20->33.33",
			"gear.spec.WARRIOR=auto->arms",
		],
		"numbers to two places, a choice's id, a record's own key; a key no module registers (an old or a newer Polestar's) is no setting"
	);
}

#[test]
fn the_profile_is_named_with_whose_choice_it_is_but_never_by_a_name_that_holds_a_characters_or_realms() {
	let out = run(
		r#"
local function settingsLine()
	for _, l in ipairs(R.Details().lines) do if l:find("^Settings: ") then return l end end
end
P.New("Raid")
P.Switch("Raid")
local account = settingsLine()
P.UseForCharacter(true)
local character = settingsLine()
P.UseForCharacter(false)
P.New("Testchar main")
P.Switch("Testchar main")
local named = settingsLine()
P.New("test realm farm")
P.Switch("test realm farm")
local realm = settingsLine()
Polestar.DB().alts = { chars = { ["Altname-Other Realm"] = { name = "Altname", realm = "Other Realm" } } }
P.New("Altname's")
P.Switch("Altname's")
local alt = settingsLine()
emit({ account = account, character = character, named = named, realm = realm, alt = alt })"#,
	);
	let o = &out[0];
	assert_eq!(o["account"], "Settings: profile Raid (account) \u{b7} all defaults");
	assert_eq!(o["character"], "Settings: profile Raid (character) \u{b7} all defaults");
	assert_eq!(o["named"], "Settings: profile custom (account) \u{b7} all defaults", "the character's name never goes in");
	assert_eq!(o["realm"], "Settings: profile custom (account) \u{b7} all defaults", "nor the realm's, in any case");
	assert_eq!(o["alt"], "Settings: profile custom (account) \u{b7} all defaults", "nor another character's on the account");
}

#[test]
fn the_window_says_what_the_reports_settings_hold_until_the_report_shows_and_the_copy_hint_takes_its_place() {
	let out = run(
		r#"
uistub.setGuide(uistub.elwynn, 3)
UI.ShowReport()
local F = PolestarReport
local before = { note = F.SettingsNote:IsShown() and F.SettingsNote:GetText() or false, hint = F.CopyHint:IsShown() }
F.Desc:SetText("The vermin were all by the tents.")
stub.RunScript(F.Desc, "OnTextChanged", true)
F.Copy:Click()
emit({ before = before, after = { note = F.SettingsNote:IsShown(), hint = F.CopyHint:IsShown(), box = F.Box:IsShown() }, height = F:GetHeight() })"#,
	);
	assert_eq!(
		out[0]["before"],
		json!({ "note": "The report lists the settings you changed and your profile's name: no character names, chat, account or realm.", "hint": false })
	);
	assert_eq!(out[0]["after"], json!({ "note": false, "hint": true, "box": true }));
	assert!(out[0]["height"].as_f64().unwrap() <= 720.0, "{}", out[0]["height"]);
}

// The longest report a player can send (tests/ui-report.test.js `longest`): every detail line at its cap in
// `word`'s script, the description at DESC letters, a marked spot, 40 other addons, six errors and four blocked
// calls, and every setting turned from its default.
const LONGEST: &str = r#"
local word, letter = WORD, LETTER
local long = string.rep(word, 12)
local goals = {}
for i = 1, 9 do
	goals[i] = { t = "kill", verb = word, subject = long, subjectKind = "npc", npc = 1000000 + i, quest = 2000000 + i, item = 3000000 + i,
		progress = { cur = 99, max = 100 }, map = 1429, x = 47.123, y = 35.456, status = "active" }
end
local id = "test/a-long-guide"
uistub.guides[id] = { id = id, pack = "guides", title = word, faction = "Alliance", minLevel = 1, maxLevel = 60, steps = { { title = long, goals = goals } } }
for i = 1, 6 do Polestar.NoteError("Interface/AddOns/Polestar/UI/" .. string.rep("Long", 12) .. i .. ".lua:1: " .. long) end
for i = 1, 40 do
	local name = ("QuestAndMapHelperWithALongName%02d"):format(i)
	stub.addons[#stub.addons + 1] = { name = name, loaded = true }
	stub.addonMeta[name] = { Version = "v12.34.56-" .. word }
end
uistub.player = { level = 59, xp = 1, xpMax = 3, race = long, class = "WARRIOR", faction = word }
Polestar.Compat.GetZoneText = function() return word, "Goldshire Inn" end
Polestar.Guides.Pack = function() return { title = long, version = word } end
Polestar.Guides.Packs = function() return { { title = long, version = word, status = "on" }, { title = long, status = "on" } } end
Polestar.Compat.GetPlayerMapPosition = function() return 1429, 51.234, 40.5 end
stub.addonMeta["Polestar_" .. string.rep("Long", 10)] = { Author = "Polestar" }
for i = 1, 4 do stub.fire("ADDON_ACTION_BLOCKED", "Polestar_" .. string.rep("Long", 10), string.rep("Protected", 8) .. i .. "()") end
local changed = changeAll()
uistub.setGuide(id, 1)
UI.ShowReport()
local F = PolestarReport
F.Desc:SetText(string.rep(letter, DESC))
stub.RunScript(F.Desc, "OnTextChanged", true)
F.Mark:Click()
PolestarMark.Here:Click()
F.Copy:Click()
local s = section(F.details)
local visible, packed = 0, 0
for i, k in ipairs(s.kinds) do
	if k == "settingcode" then packed = #s.lines[i] else visible = visible + #s.lines[i] + 1 end
end
emit({ text = F.Box:GetText(), changed = changed, visible = visible, packed = packed })"#;

const SCRIPTS: [(&str, &str, &str); 3] = [
	("enUS", "Overlook of the Brightwater Lake ", "w"),
	("ruRU", "\u{421}\u{43c}\u{43e}\u{442}\u{440}\u{43e}\u{432}\u{430}\u{44f} \u{43f}\u{43b}\u{43e}\u{449}\u{430}\u{434}\u{43a}\u{430} ", "\u{436}"),
	("zhCN", "\u{5e03}\u{83b1}\u{7279}\u{6c83}\u{7279}\u{6e56}\u{7684}\u{77ad}\u{671b}\u{53f0}", "\u{6e56}"),
];

fn longest(locale: &str, word: &str, letter: &str, desc: usize) -> Value {
	let script = LONGEST
		.replace("WORD", &serde_json::to_string(word).unwrap())
		.replace("LETTER", &serde_json::to_string(letter).unwrap())
		.replace("DESC", &desc.to_string());
	run_in(&format!("function GetLocale() return \"{locale}\" end"), &script).remove(0)
}

#[test]
fn at_its_worst_every_setting_changed_on_the_longest_report_the_whole_report_still_fits_one_discord_message() {
	for (locale, word, letter) in SCRIPTS {
		for desc in [1000, 250, 20] {
			let o = longest(locale, word, letter, desc);
			let text = o["text"].as_str().unwrap();
			let n = discord_len(text);
			println!(
				"{locale}, a {desc}-letter description: report {n} characters ({} bytes); {} settings changed: section {} bytes in view, packed line {} bytes",
				text.len(),
				o["changed"],
				o["visible"],
				o["packed"]
			);
			assert!(n <= 2000, "{locale}, a {desc}-letter description: {n} characters");
			assert!(text.lines().next().unwrap().ends_with(&letter.repeat(desc)), "{locale}: the description is kept whole");
			assert!(text.ends_with("\n```"), "{locale}: the code block closed");
			if desc <= 250 {
				assert!(text.lines().any(|l| l.contains(" changed") && l.contains("profile Default (account)")), "{locale}, {desc}: the Settings line stays: {text}");
			}
		}
	}
}
