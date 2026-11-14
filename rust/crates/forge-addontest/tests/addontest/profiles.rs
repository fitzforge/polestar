//! Settings profiles (addon/Polestar/Core/Profiles.lua) and their page (UI/Profiles.lua): settings saved before
//! profiles become the profile Default with nothing lost; switch, copy, rename and delete; a character's own
//! choice across a reload; migrations run once over every profile; profile strings round-trip exactly, refuse
//! anything malformed and drop what this Polestar has no setting for; every setting has a category, a string
//! holds the categories ticked and an import takes the ones picked, each alone (a string from before
//! categories too), and its Undo takes it back.

use forge_addontest::{emitted, text, Addon, RunAddon};
use serde_json::{json, Value};

// Lua that writes a value back as a Lua constructor (the SavedVariables file), for a reload.
const SER: &str = r#"
P = Polestar.Profiles
function ser(v)
	local t = type(v)
	if t == "string" then return string.format("%q", v) end
	if t == "number" then return string.format("%.17g", v) end
	if t ~= "table" then return tostring(v) end
	local out = {}
	for k, x in pairs(v) do
		local key = type(k) == "number" and ("[" .. string.format("%.17g", k) .. "]") or ("[" .. string.format("%q", k) .. "]")
		out[#out + 1] = key .. " = " .. ser(x)
	end
	return "{ " .. table.concat(out, ", ") .. " }"
end
function saved() return { db = "PolestarDB = " .. ser(PolestarDB), char = "PolestarCharDB = " .. ser(PolestarCharDB) } end
"#;

// Defaults as the modules register them, and controls on a Look page and a Guide page (the Options registry).
const DEFAULTS: &str = r#"
Polestar.RegisterDefaults("ui", { scale = 1, accent = false, font = "inter", compact = false, shown = true })
Polestar.RegisterDefaults("maps", { serviceFilters = { inn = true, bank = true } })
Polestar.RegisterDefaults("nav", { arrowColor = false, arrowScale = 1 })
Polestar.RegisterDefaults("rares", { toastPoint = false })
Polestar.Widgets = Polestar.Widgets or {}
Polestar.Widgets.OptionsRegistry = {
	{ page = "Theme", order = 20, controls = {
		{ kind = "color", key = "ui.accent", label = "Accent colour" },
		{ kind = "slider", key = "ui.scale", label = "Window scale", min = 0.5, max = 2 },
		{ kind = "color", key = "nav.arrowColor", label = "Arrow colour" },
	} },
	{ page = "Guide", order = 10, controls = {
		{ kind = "toggle", key = "ui.compact", label = "Compact" },
		{ kind = "dropdown", key = "ui.font", label = "Font", choices = { { value = "inter" }, { value = "mono" } } },
	} },
}
"#;

fn run_with(saved: Option<String>, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua"],
		// The profile strings are the settings' addon's (Polestar_Options/Core/ProfileStrings.lua).
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "../Polestar_Options/Core/ProfileStrings.lua"])],
		saved: saved.map(|s| ("Polestar".to_string(), s)).into_iter().collect(),
		login: true,
		script: format!("{SER}\n{DEFAULTS}\n{script}"),
		..Default::default()
	})
}

fn run(script: &str) -> Value {
	run_with(None, script).remove(0)
}

#[test]
fn settings_saved_before_profiles_become_the_profile_default_with_nothing_lost() {
	let before = r#"PolestarDB = { schema = 1, welcomeSeen = 1, settings = {
		ui = { scale = 1.25, pos = { 3190, 57 }, pickerCollapsed = { ["Leveling/Horde/40"] = true } },
		nav = { arrowStyle = "3d", arrowPos = { point = "TOP", relPoint = "TOP", x = -35.21119689941406, y = -20.12544631958008 } },
		rares = { toastPoint = { "CENTER", -520, 130 } }, qol = { markTarget = true } } }
		PolestarCharDB = { schema = 1 }"#;
	let out = run_with(
		Some(before.into()),
		r#"emit({ active = P.Active(), list = P.List(), account = P.AccountProfile(), source = P.Source(), settings = PolestarDB.settings,
			profiles = PolestarDB.profiles, scale = Polestar.Get("ui.scale"), welcome = PolestarDB.welcomeSeen })"#,
	)
	.remove(0);
	assert_eq!(out["active"], "Default");
	assert_eq!(out["list"], json!(["Default"]));
	assert_eq!(out["account"], "Default");
	assert_eq!(out["source"], "account");
	assert_eq!(
		out["settings"],
		json!({
			"ui": { "scale": 1.25, "pos": [3190, 57], "pickerCollapsed": { "Leveling/Horde/40": true } },
			"nav": { "arrowStyle": "3d", "arrowPos": { "point": "TOP", "relPoint": "TOP", "x": -35.211196899414, "y": -20.12544631958 } },
			"rares": { "toastPoint": ["CENTER", -520, 130] },
			"qol": { "markTarget": true },
		}),
		"every saved setting stays where it was"
	);
	assert_eq!(out["profiles"], json!({}), "nothing copied: the settings in use are Default's");
	assert_eq!(out["scale"], 1.25);
	assert_eq!(out["welcome"], 1);
}

#[test]
fn switch_copy_rename_and_delete_keep_each_profile_s_own_values_and_repaint_on_a_switch() {
	let out = run(r#"
		local fired = {}
		Polestar.On("SETTING_CHANGED", function(p) fired[#fired + 1] = p end)
		Polestar.Set("ui.scale", 1.2)
		local made = P.New("Raid", "Default")
		fired = {}
		P.Switch("Raid")
		local switched = { active = P.Active(), scale = Polestar.Get("ui.scale"), fired = { unpack(fired) } }
		Polestar.Set("ui.scale", 0.8)
		P.Switch("Default")
		local back = Polestar.Get("ui.scale")
		P.Copy("Raid", "Default")
		local copied = Polestar.Get("ui.scale")
		P.New("Empty")
		P.Switch("Empty")
		local empty = Polestar.Get("ui.scale")
		local deleteInUse = select(2, P.Delete("Empty"))
		local deleteDefault = select(2, P.Delete("Default"))
		local renameDefault = select(2, P.Rename("Default", "Main"))
		local taken = { made = P.New("raid") ~= nil, why = select(2, P.New("Raid")) }
		P.Switch("Default")
		local deleted = P.Delete("Empty")
		local renamed = P.Rename("Raid", "Dungeons")
		P.Switch("Dungeons")
		local shared = false
		for _, t in pairs(PolestarDB.profiles) do if t == PolestarDB.settings then shared = true end end
		emit({ made = made, switched = switched, back = back, copied = copied, empty = empty, deleteInUse = deleteInUse,
			deleteDefault = deleteDefault, renameDefault = renameDefault, taken = taken, deleted = deleted, renamed = renamed,
			list = P.List(), active = P.Active(), scale = Polestar.Get("ui.scale"), account = PolestarDB.profile, shared = shared,
			stored = PolestarDB.profiles })"#);
	assert_eq!(out["made"], "Raid");
	assert_eq!(out["switched"], json!({ "active": "Raid", "scale": 1.2, "fired": [""] }), "a copy, then one repaint of everything");
	assert_eq!(out["back"], 1.2, "Default kept its own value");
	assert_eq!(out["copied"], 0.8, "Copy into the profile in use applies at once");
	assert_eq!(out["empty"], 1, "a new profile starts at the defaults");
	assert_eq!(out["deleteInUse"], "This profile is in use. Switch to another one first.");
	assert_eq!(out["deleteDefault"], "Default stays: it is the profile every character falls back to.");
	assert_eq!(out["renameDefault"], "Default stays: it is the profile every character falls back to.");
	assert_eq!(out["taken"], json!({ "made": true, "why": "A profile called Raid already exists." }), "names differ by case");
	assert_eq!(out["deleted"], true);
	assert_eq!(out["renamed"], true);
	assert_eq!(out["list"], json!(["Default", "Dungeons", "raid"]));
	assert_eq!(out["active"], "Dungeons");
	assert_eq!(out["scale"], 0.8);
	assert_eq!(out["account"], "Dungeons", "a character following the account's profile switches the account's");
	assert_eq!(out["shared"], false, "the profile in use is never stored twice");
	assert_eq!(out["stored"]["Default"]["ui"]["scale"], 0.8);
}

fn reload(db: &Value, char: Option<&Value>, script: &str) -> Value {
	let saved = format!("{}\n{}", text(db), char.map(|c| text(c).to_string()).unwrap_or_default());
	run_with(Some(saved), &format!("{script}\nemit(saved())")).into_iter().collect::<Value>()
}

#[test]
fn a_character_s_own_profile_survives_a_reload_others_keep_the_account_s_and_follow_a_rename() {
	// Character A: its own profile "Alt".
	let first = run(r#"
		P.UseForCharacter(true)
		P.New("Alt")
		P.Switch("Alt")
		Polestar.Set("ui.scale", 1.5)
		emit(saved())"#);
	// A again after /reload.
	let again = reload(&first["db"], Some(&first["char"]), r#"emit({ active = P.Active(), source = P.Source(), scale = Polestar.Get("ui.scale") })"#);
	assert_eq!(again[0], json!({ "active": "Alt", "source": "character", "scale": 1.5 }));
	// Character B (no saved PolestarCharDB): the account's profile; then it renames Alt.
	let other = reload(
		&again[1]["db"],
		None,
		r#"emit({ active = P.Active(), source = P.Source(), scale = Polestar.Get("ui.scale"), alt = PolestarDB.profiles.Alt.ui.scale })
		P.Rename("Alt", "Main")"#,
	);
	assert_eq!(other[0], json!({ "active": "Default", "source": "account", "scale": 1, "alt": 1.5 }));
	// A logs in again: its choice follows the rename.
	let back = reload(&other[1]["db"], Some(&again[1]["char"]), r#"emit({ active = P.Active(), own = PolestarCharDB.profile, scale = Polestar.Get("ui.scale") })"#);
	assert_eq!(back[0], json!({ "active": "Main", "own": "Main", "scale": 1.5 }));
}

#[test]
fn a_class_profile_is_used_by_every_character_of_the_class_without_its_own() {
	// A warrior (stub_world's class): the class follows Default, then switches to Warriors; the account stays.
	let first = run_with(
		None,
		r#"
		P.New("Warriors")
		P.UseForClass(true)
		P.Switch("Warriors")
		Polestar.Set("ui.compact", true)
		emit({ source = P.Source(), class = P.ClassProfile(), active = P.Active(), account = P.AccountProfile() })
		emit(saved())"#,
	);
	assert_eq!(first[0], json!({ "source": "class", "class": "Warriors", "active": "Warriors", "account": "Default" }), "a switch while following the class changes the class's profile");
	let db = text(&first[1]["db"]).to_string();
	let mage = run_with(Some(format!("{db}\nstub.world.class = 'MAGE'")), r#"emit({ active = P.Active(), source = P.Source(), compact = Polestar.Get("ui.compact") })"#).remove(0);
	assert_eq!(mage, json!({ "active": "Default", "source": "account", "compact": false }));
	let warrior = run_with(Some(db), r#"emit({ active = P.Active(), source = P.Source(), compact = Polestar.Get("ui.compact") })"#).remove(0);
	assert_eq!(warrior, json!({ "active": "Warriors", "source": "class", "compact": true }));
}

#[test]
fn a_migration_runs_once_over_every_profile_before_init_and_over_a_string_from_before_it() {
	let register = r#"
		migrated = 0
		Polestar.RegisterDefaults("new", { size = 1 })
		Polestar.RegisterMigration("move-size", function(s)
			migrated = migrated + 1
			if type(s.old) == "table" and s.old.size ~= nil then
				s.new = s.new or {}
				s.new.size, s.old.size = s.old.size, nil
			end
		end)
		Polestar.OnInit(function() atInit = Polestar.Get("new.size") end)"#;
	let saved = format!("PolestarDB = {{ settings = {{ old = {{ size = 2 }} }}, profiles = {{ Raid = {{ old = {{ size = 3 }} }} }}, profileActive = 'Default' }}\n{register}");
	let out = run_with(
		Some(saved),
		r#"
		local before = P.Import(P.Pack('{"format":1,"migrations":[],"settings":{"old.size":4}}'))
		local after = P.Import(P.Pack('{"format":1,"migrations":["move-size"],"settings":{"old.size":4}}'))
		local fired = {}
		Polestar.On("SETTING_CHANGED", function(p) fired[#fired + 1] = p end)
		local late = 0
		Polestar.RegisterMigration("late", function() late = late + 1 end)
		emit({ calls = migrated, atInit = atInit, now = Polestar.Get("new.size"), raid = PolestarDB.profiles.Raid, marks = PolestarDB.migrations,
			before = before.settings, beforeDropped = before.dropped, after = after.settings, afterDropped = after.dropped, late = late, fired = fired })
		emit(saved())"#,
	);
	let first = &out[0];
	assert_eq!(first["calls"], 2 + 1, "Default and Raid at load, then the old string");
	assert_eq!(first["atInit"], 2, "moved before any OnInit handler reads it");
	assert_eq!(first["now"], 2);
	assert_eq!(first["raid"], json!({ "new": { "size": 3 }, "old": {} }));
	assert_eq!(first["marks"], json!({ "move-size": true, "late": true }));
	assert_eq!(first["before"], json!({ "new.size": 4 }), "a string from before the migration is migrated");
	assert_eq!(first["after"], json!({}));
	assert_eq!(first["afterDropped"], json!(["old.size"]));
	assert_eq!(first["late"], 2, "registered after load: runs at once over both");
	assert_eq!(first["fired"], json!([""]));
	let again = run_with(Some(format!("{}\n{register}", text(&out[1]["db"]))), r#"emit({ calls = migrated, now = Polestar.Get("new.size") })"#).remove(0);
	assert_eq!(again, json!({ "calls": 0, "now": 2 }), "once per id, never again");
}

const SETUP: &str = r#"
	Polestar.Set("ui.scale", 1.1)
	Polestar.Set("ui.accent", { 0.2, 0.4, 0.6, 0.9 })
	Polestar.Set("ui.font", "mono")
	Polestar.Set("ui.compact", true)
	Polestar.Set("ui.shown", false)
	Polestar.Set("ui.pickerCollapsed", { a = true })
	Polestar.Set("maps.serviceFilters.bank", false)
	Polestar.Set("nav.arrowPos", { point = "TOP", relPoint = "TOP", x = -35.21119689941406, y = -20.12544631958008 })
	Polestar.Set("ui.pos", { 3190, 57 })
	Polestar.Set("rares.toastPoint", { "CENTER", -520, 130 })
"#;

#[test]
fn export_then_import_round_trips_exactly_with_and_without_the_client_s_encoder() {
	let out = run(&format!(
		r#"{SETUP}
		local mine = P.Portable()
		local s, n = P.Export()
		local pv = P.Import(s)
		local compressed = stub.compressed
		P.Apply(pv, "Copy")
		local again = P.Import(P.Export("Copy"))
		C_EncodingUtil.CompressString = nil
		local plain = P.Export()
		local pv2 = P.Import(plain)
		emit({{ prefix = s:sub(1, 6), n = n, keys = pv.keys, count = pv.count, changes = #pv.changes, name = pv.name,
			same = P.Same(pv.settings, mine), copySame = P.Same(P.Portable("Copy"), mine), againSame = P.Same(again.settings, mine),
			compressed = compressed, compressedAfter = stub.compressed, plainSame = P.Same(pv2.settings, mine), held = pv.held,
			otherScreen = pv.otherScreen, accent = pv.settings["ui.accent"], arrow = pv.settings["nav.arrowPos"] }})"#
	));
	assert_eq!(out["prefix"], "!PSS1!");
	assert_eq!(out["n"], 8);
	assert_eq!(out["count"], 8);
	// By label (the Options registry's), else by path.
	assert_eq!(
		out["keys"],
		json!(["ui.accent", "ui.compact", "ui.font", "ui.scale", "maps.serviceFilters.bank", "nav.arrowPos", "rares.toastPoint", "ui.pos"]),
		"no ui.shown (a friend's string must not hide your guide), no state without a default"
	);
	assert_eq!(out["changes"], 0, "read over the same settings: nothing differs");
	assert_eq!(out["name"], "Default");
	assert_eq!(out["same"], true, "every value read back exactly");
	assert_eq!(out["copySame"], true, "imported as a new profile, it holds the same settings");
	assert_eq!(out["againSame"], true, "and exports them again unchanged");
	assert_eq!(out["compressed"], 1, "the client's encoder wrote it");
	assert_eq!(out["compressedAfter"], 2, "without the client's encoder, plain Lua writes it");
	assert_eq!(out["plainSame"], true);
	assert_eq!(out["held"], json!({ "skin": 2, "window": 2, "arrow": 1, "positions": 3 }), "by the page each is on, else the start of its key");
	assert_eq!(out["otherScreen"], false, "same screen, same scale");
	assert_eq!(out["accent"], json!([0.2, 0.4, 0.6, 0.9]));
	assert_eq!(out["arrow"], json!({ "point": "TOP", "relPoint": "TOP", "x": -35.211196899414, "y": -20.12544631958 }));
}

#[test]
fn a_string_holds_the_categories_ticked_and_an_import_takes_only_the_ones_picked() {
	let out = run(&format!(
		r#"{SETUP}
		local skin = P.Import((P.Export(nil, {{ categories = {{ skin = true }} }})))
		local pos = P.Import((P.Export(nil, {{ categories = {{ positions = true }} }})))
		local none = select(2, P.Export(nil, {{ categories = {{}} }}))
		local all = P.Import((P.Export()))
		P.New("Fresh")
		P.Switch("Fresh")
		local unticked = select(2, P.Apply(all, P.Active(), {{}}))
		local ok, undo = P.Apply(all, P.Active(), {{ skin = true }})
		local same = select(2, P.Apply(all, P.Active(), {{ skin = true }}))
		emit({{ skin = skin.keys, skinOrder = skin.order, exact = skin.exact, pos = pos.keys, posOrder = pos.order, none = none,
			allOrder = all.order, unticked = unticked, ok = ok, undoFor = undo.profile, same = same,
			scale = Polestar.Get("ui.scale"), compact = Polestar.Get("ui.compact"), placed = Polestar.Get("ui.pos") or false }})"#
	));
	assert_eq!(out["skin"], json!(["ui.accent", "ui.scale"]));
	assert_eq!(out["skinOrder"], json!(["skin"]));
	assert_eq!(out["exact"], true, "it names the categories it holds");
	assert_eq!(out["pos"], json!(["nav.arrowPos", "rares.toastPoint", "ui.pos"]));
	assert_eq!(out["posOrder"], json!(["positions"]));
	assert_eq!(out["none"], "Tick at least one part to put in the string.");
	assert_eq!(out["allOrder"], json!(["skin", "fonts", "window", "arrow", "routes", "quests", "hud", "gear", "dungeons", "positions"]), "every category, settings in it or not");
	assert_eq!(out["unticked"], "Nothing to apply: every part of the string is unticked.");
	assert_eq!(out["ok"], true);
	assert_eq!(out["undoFor"], "Fresh");
	assert_eq!(out["same"], "Nothing to apply: the parts ticked are the same as yours.");
	assert_eq!(out["scale"], 1.1, "the skin taken");
	assert_eq!(out["compact"], false, "the guide window left as it was");
	assert_eq!(out["placed"], false, "the positions left as they were");
}

#[test]
fn a_category_a_string_names_becomes_the_sender_s_and_a_string_from_before_categories_changes_only_what_it_carries() {
	let out = run(r#"
		-- The sender changed Compact (the guide window) alone; its skin is at its defaults.
		P.New("Sender")
		P.Switch("Sender")
		Polestar.Set("ui.compact", true)
		local new = P.Export(nil, { categories = { skin = true, window = true } })
		-- 0.3.x's string: areas and the look's scope, the scale alone.
		local old = P.Pack('{"format":1,"name":"Old","scope":"look","areas":["look"],"screen":{"w":0,"h":0,"scale":1},"migrations":[],"settings":{"ui.scale":1.2}}')
		-- A category it does not know and a number are passed over; a word is no list.
		local odd = P.Import(P.Pack('{"format":1,"categories":["skin","later",5],"settings":{"ui.compact":true}}'))
		local word = P.Import(P.Pack('{"format":1,"categories":"skin","settings":{"ui.compact":true}}'))
		-- The receiver has a skin of its own.
		P.Switch("Default")
		Polestar.Set("ui.accent", { 0.2, 0.4, 0.6 })
		Polestar.Set("ui.scale", 1.3)
		local pv = P.Import(new)
		local changes = {}
		for i, ch in ipairs(P.Changes(pv)) do changes[i] = { ch.path, ch.category, ch.reset or false } end
		local skinOnly = #P.Changes(pv, { skin = true })
		P.Apply(pv, P.Active())
		local afterNew = { accent = Polestar.Get("ui.accent"), scale = Polestar.Get("ui.scale"), compact = Polestar.Get("ui.compact") }
		Polestar.Set("ui.accent", { 0.2, 0.4, 0.6 })
		local opv = P.Import(old)
		P.Apply(opv, P.Active())
		emit({ changes = changes, skinOnly = skinOnly, afterNew = afterNew, oldOrder = opv.order, oldExact = opv.exact or false,
			afterOld = { accent = Polestar.Get("ui.accent"), scale = Polestar.Get("ui.scale") },
			odd = { odd.order, odd.exact or false }, word = { word.order, word.exact or false } })"#);
	assert_eq!(
		out["changes"],
		json!([["ui.accent", "skin", true], ["ui.scale", "skin", true], ["ui.compact", "window", false]]),
		"the receiver's own skin goes back to the defaults the sender has; the guide window takes the sender's"
	);
	assert_eq!(out["skinOnly"], 2);
	assert_eq!(out["afterNew"], json!({ "accent": false, "scale": 1, "compact": true }));
	assert_eq!(out["oldOrder"], json!(["skin"]), "an older string holds the categories its settings are in");
	assert_eq!(out["oldExact"], false);
	assert_eq!(out["afterOld"], json!({ "accent": [0.2, 0.4, 0.6], "scale": 1.2 }), "and changes only what it carries");
	assert_eq!(out["odd"], json!([["skin", "window"], true]));
	assert_eq!(out["word"], json!([["window"], false]));
}

#[test]
fn an_apply_s_undo_puts_the_profile_back_or_takes_the_new_profile_away() {
	let out = run(&format!(
		r#"{SETUP}
		local s = P.Export()
		P.New("Fresh")
		P.Switch("Fresh")
		Polestar.Set("ui.scale", 1.4)
		Polestar.Set("ui.pos", {{ 10, 20 }})
		local before = P.Portable("Fresh")
		local pv = P.Import(s)
		local ok, undo = P.Apply(pv, P.Active())
		local applied = {{ Polestar.Get("ui.scale"), Polestar.Get("ui.pos") }}
		local undone = P.Undo(undo)
		local back = {{ P.Same(P.Portable("Fresh"), before), Polestar.Get("ui.scale"), Polestar.Get("ui.pos"), Polestar.Get("ui.accent") }}
		-- Taken back after a switch: into the profile's own table.
		local _, undo2 = P.Apply(pv, P.Active())
		P.Switch("Default")
		local stored = {{ P.Undo(undo2), P.Same(P.Portable("Fresh"), before) }}
		-- As a new profile: its Undo switches back and deletes it.
		local _, undo3 = P.Apply(pv, "Made")
		P.Switch("Made")
		local made = {{ P.Active(), Polestar.Get("ui.scale"), undo3.from }}
		local undoneNew = P.Undo(undo3)
		emit({{ ok = ok, applied = applied, undone = undone, back = back, stored = stored, made = made, undoneNew = undoneNew,
			active = P.Active(), list = P.List(), again = select(2, P.Undo(undo3)) }})"#
	));
	assert_eq!(out["ok"], true);
	assert_eq!(out["applied"], json!([1.1, [3190, 57]]));
	assert_eq!(out["undone"], true);
	assert_eq!(out["back"], json!([true, 1.4, [10, 20], false]), "every setting as it was, the string's accent gone");
	assert_eq!(out["stored"], json!([true, true]));
	assert_eq!(out["made"], json!(["Made", 1.1, "Default"]));
	assert_eq!(out["undoneNew"], true);
	assert_eq!(out["active"], "Default");
	assert_eq!(out["list"], json!(["Default", "Fresh"]));
	assert_eq!(out["again"], "There is no profile called Made.");
}

#[test]
fn a_malformed_or_hostile_string_is_refused_and_changes_nothing() {
	let out = run(r#"
		Polestar.Set("ui.scale", 1.3)
		local s = P.Export()
		local sum = s:match("^!PSS1!(%x+)!")
		local flipped = s:gsub("^!PSS1!%x%x", "!PSS1!" .. (sum:sub(1, 2) == "00" and "11" or "00"))
		local deep = '{"format":1,"settings":{"ui.scale":' .. ("["):rep(40) .. "1" .. ("]"):rep(40) .. "}}"
		local many = {}
		for i = 1, P.LIMITS.settings + 1 do many[i] = '"ui.k' .. i .. '":1' end
		local before = PolestarDB.settings.ui.scale
		local cases = {
			empty = "", words = "hello there", guide = "!PS1!00000000!AAAA", newer = "!PSS2!00000000!AAAA",
			checksum = flipped, cut = s:sub(1, #s - 8), long = "!PSS1!00000000!" .. ("A"):rep(P.LIMITS.length),
			notJson = P.Pack("os.exit()"), noSettings = P.Pack('{"format":1}'), newerFormat = P.Pack('{"format":2,"settings":{}}'),
			deep = P.Pack(deep), many = P.Pack('{"format":1,"settings":{' .. table.concat(many, ",") .. '}}'),
			code = "!PSS1!00000000!" .. "return os.exit()",
		}
		local why = {}
		for k, text in pairs(cases) do
			local pv, reason = P.Import(text)
			why[k] = pv == nil and reason or "accepted"
		end
		emit({ why = why, kept = PolestarDB.settings.ui.scale == before, list = P.List() })"#);
	let why = &out["why"];
	assert_eq!(why["empty"], "Paste a profile string.");
	assert_eq!(why["words"], "This is not a Polestar profile string.");
	assert_eq!(why["guide"], "This is a guide import string: paste it on the Import page.");
	assert_eq!(why["newer"], "This profile string needs a newer Polestar.");
	assert_eq!(why["newerFormat"], "This profile string needs a newer Polestar.");
	for k in ["checksum", "cut", "notJson", "noSettings", "deep", "code"] {
		assert_eq!(why[k], "This profile string is damaged or incomplete. Copy the whole string again.", "{k}");
	}
	for k in ["long", "many"] {
		assert_eq!(why[k], "This profile string holds too much to be a Polestar profile.", "{k}");
	}
	assert_eq!(out["kept"], true);
	assert_eq!(out["list"], json!(["Default"]));
}

#[test]
fn keys_without_a_default_and_values_that_do_not_fit_are_dropped_and_named() {
	let out = run(r#"
		local pv = P.Import(P.Pack([[{"format":1,"name":"Evil|cff","settings":{
			"ui.compact":true, "maps.serviceFilters.bank":false,
			"ui.scale":5, "ui.font":"comic", "ui.accent":[2,0,0], "nav.arrowColor":true, "rares.toastPoint":true,
			"ui.pos":["x",1], "nav.arrowPos":{"point":"TOP","x":1,"y":2,"evil":1}, "ui.shown":false,
			"evil.code":"os.exit()", "ui.nope":true, "maps.serviceFilters.inn":"yes", "1.2":3, "ui.scale.deeper":1
		}}]]))
		emit({ settings = pv.settings, dropped = pv.dropped, name = pv.name, changes = pv.changes })"#);
	assert_eq!(out["settings"], json!({ "ui.compact": true, "maps.serviceFilters.bank": false }));
	let mut dropped: Vec<String> = out["dropped"].as_array().unwrap().iter().map(|d| d.as_str().unwrap().to_string()).collect();
	// ui.scale and ui.scale.deeper clash: whichever came second is named on its own.
	dropped.retain(|d| d != "ui.scale.deeper");
	dropped.sort();
	dropped.dedup();
	let mut want = vec!["1.2", "evil.code", "maps.serviceFilters.inn", "nav.arrowColor", "nav.arrowPos", "rares.toastPoint", "ui.accent", "ui.font", "ui.nope", "ui.pos", "ui.scale", "ui.shown"];
	want.sort_unstable();
	assert_eq!(dropped, want);
	assert_eq!(out["name"], "Evilcff", "no escape codes in a name");
	assert_eq!(out["changes"], json!(["ui.compact", "maps.serviceFilters.bank"]));
}

// The whole addon on the world stub, logged in, its settings window's addon loaded; then `script`.
fn run_full(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua"],
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: format!("stub.advance(1)\nassert(Polestar.UI.LoadOptions())\nP, O = Polestar.Profiles, Polestar.UI.Options\n{script}"),
		..Default::default()
	})
	.remove(0)
}

const CATEGORIES: [&str; 10] = ["skin", "fonts", "window", "arrow", "routes", "quests", "hud", "gear", "dungeons", "positions"];

#[test]
fn every_setting_has_a_category_and_every_control_takes_its_page_s() {
	let out = run_full(
		r#"
		local function upvalue(fn, name)
			for i = 1, 200 do
				local n, v = debug.getupvalue(fn, i)
				if not n then return nil end
				if n == name then return v end
			end
		end
		-- Every registered default as a profile holds it: a record walked into, a colour or a list whole.
		local paths = {}
		local function walk(prefix, t, depth)
			for k, v in pairs(t) do
				local path = prefix and (prefix .. "." .. tostring(k)) or tostring(k)
				if type(v) == "table" and depth < 4 and type(next(v)) == "string" then
					walk(path, v, depth + 1)
				elseif prefix then
					paths[#paths + 1] = path
				end
			end
		end
		walk(nil, upvalue(Polestar.GetDefault, "defaults"), 0)
		local missing, fromNoPage, counts, ids = {}, {}, {}, {}
		for _, c in ipairs(P.CATEGORIES) do ids[#ids + 1] = c.id end
		for _, path in ipairs(paths) do
			local id, how = P.CategoryOf(path)
			if how == "fallback" then missing[#missing + 1] = path else counts[id] = (counts[id] or 0) + 1 end
		end
		-- Every control on the pages (a key binding is the game's, never a profile's).
		local controls = 0
		for _, c in ipairs(O.AllControls()) do
			if c.key and c.kind ~= "button" and c.kind ~= "binding" then
				controls = controls + 1
				local _, how = P.CategoryOf(c.key)
				if how == "fallback" then
					missing[#missing + 1] = c.key
				elseif how == "hidden" then
					fromNoPage[#fromNoPage + 1] = c.key .. " (" .. tostring(c.page and c.page.key) .. ")"
				end
			end
		end
		table.sort(missing)
		table.sort(fromNoPage)
		-- A setting added to a page falls in with it; one on a page no rule names takes no page's,
		-- and one no page shows under a start of key no rule knows goes to the fallback: each fails above.
		Polestar.RegisterDefaults("ui", { profileTestSwitch = true, profileTestPage = true })
		Polestar.RegisterDefaults("profileTest", { thing = true })
		assert(Polestar.RegisterOptions({ page = Polestar.L["Guide"], tab = Polestar.L["Window"], section = Polestar.L["What it shows"],
			controls = { { kind = "toggle", key = "ui.profileTestSwitch", label = "Test" } } }))
		assert(Polestar.RegisterOptions({ page = "Profile test", key = "profiletest", controls = { { kind = "toggle", key = "ui.profileTestPage", label = "Test" } } }))
		emit({ settings = #paths, controls = controls, missing = table.concat(missing, ", "), fromNoPage = table.concat(fromNoPage, ", "),
			counts = counts, ids = ids, added = { P.CategoryOf("ui.profileTestSwitch") }, newPage = { P.CategoryOf("ui.profileTestPage") },
			unknown = { P.CategoryOf("profileTest.thing") } })"#,
	);
	assert!(out["settings"].as_u64().unwrap_or(0) > 400, "{}", out["settings"]);
	assert!(out["controls"].as_u64().unwrap_or(0) > 400, "{}", out["controls"]);
	assert_eq!(out["missing"], "", "a rule names every registered setting's and every control's category (else it falls back)");
	assert_eq!(out["fromNoPage"], "", "every control's category comes from its page (PAGES in ProfileStrings.lua)");
	assert_eq!(out["ids"], json!(CATEGORIES));
	for id in CATEGORIES {
		assert!(out["counts"][id].as_u64().unwrap_or(0) > 0, "{id} holds settings: {}", out["counts"]);
	}
	assert_eq!(out["added"], json!(["window", "page"]), "a setting added to a page falls in with it");
	assert_eq!(out["newPage"], json!(["window", "hidden"]), "a page no rule names: caught above");
	assert_eq!(out["unknown"], json!(["quests", "fallback"]), "a start of key no rule knows: carried, caught above");
}

// Two settings of each category off their defaults, the first controls in the pages' order that take a plain
// value; the sender has every first value, the receiver every second (or the default).
const PICKS: &str = r#"
	local function copy(v) if type(v) ~= "table" then return v end local t = {} for k, x in pairs(v) do t[k] = copy(x) end return t end
	-- The sender's value and the receiver's (nil: its default), each off the default and apart.
	local function pair(c)
		local d = Polestar.GetDefault(c.key)
		if c.kind == "toggle" and type(d) == "boolean" then return not d, nil end
		if c.kind == "slider" and type(d) == "number" and type(c.min) == "number" and type(c.max) == "number" then
			local sender = d == c.max and c.min or c.max
			for _, v in ipairs({ c.min, c.max, (c.min + c.max) / 2 }) do
				if v ~= d and v ~= sender then return sender, v end
			end
			return sender, nil
		end
		if (c.kind == "dropdown" or c.kind == "cards") and d ~= nil then
			local list = c.choices
			if type(list) == "function" then list = list() end
			local other = {}
			for _, ch in ipairs(list or {}) do
				if ch.value ~= d and type(ch.value) == type(d) then other[#other + 1] = ch.value end
			end
			return other[1], other[2]
		end
		return nil
	end
	picks = {}
	local seen = {}
	for _, c in ipairs(O.AllControls()) do
		local id = c.key and P.CategoryOf(c.key)
		if id and not seen[c.key] and c.key ~= "ui.shown" and c.key ~= "ui.skin" and (picks[id] == nil or #picks[id] < 2) then
			local sender, receiver = pair(c)
			if sender ~= nil then
				seen[c.key] = true
				picks[id] = picks[id] or {}
				picks[id][#picks[id] + 1] = { c.key, sender, receiver }
			end
		end
	end
	picks.positions = picks.positions or {}
	table.insert(picks.positions, { "ui.pos", { 300, 500 }, { 120, 900 } })
	table.insert(picks.positions, { "nav.arrowPos", { point = "TOP", relPoint = "TOP", x = 10, y = -200 }, { point = "CENTER", relPoint = "CENTER", x = -40, y = 60 } })
	P.New("Sender")
	P.Switch("Sender")
	for _, list in pairs(picks) do for _, p in ipairs(list) do Polestar.Set(p[1], copy(p[2])) end end
	P.Switch("Default")
	for _, list in pairs(picks) do for _, p in ipairs(list) do if p[3] ~= nil then Polestar.Set(p[1], copy(p[3])) end end end
"#;

#[test]
fn a_string_of_one_category_round_trips_and_taking_it_changes_that_category_alone_skin_only_included() {
	let out = run_full(&format!(
		r#"{PICKS}
		local sent = {{}}
		for _, c in ipairs(P.CATEGORIES) do sent[c.id] = P.Portable("Sender", {{ categories = {{ [c.id] = true }} }}) end
		local everything = P.Import(P.Export("Sender"))
		local results = {{}}
		for _, c in ipairs(P.CATEGORIES) do
			local id = c.id
			local pv = P.Import(P.Export("Sender", {{ categories = {{ [id] = true }} }}))
			-- As a new profile: exactly the category's settings, the rest at their defaults.
			P.Apply(pv, "R " .. id)
			local asNew = P.Same(P.Portable("R " .. id), sent[id])
			-- Into the profile in use: the category becomes the sender's and nothing else changes.
			local before = P.Portable(P.Active())
			local differed = #P.Changes(everything, {{ [id] = true }})
			local ok, undo = P.Apply(pv, P.Active())
			local after = P.Portable(P.Active())
			local exact = P.Same(P.Portable(P.Active(), {{ categories = {{ [id] = true }} }}), sent[id])
			local others = {{}}
			for path, v in pairs(before) do
				if P.CategoryOf(path) ~= id and not P.Same(v, after[path]) then others[#others + 1] = path end
			end
			for path in pairs(after) do
				if P.CategoryOf(path) ~= id and before[path] == nil then others[#others + 1] = path end
			end
			table.sort(others)
			P.Undo(undo)
			results[id] = {{ picks = picks[id] and #picks[id] or 0, differed = differed, order = pv.order, asNew = asNew, applied = ok == true,
				exact = exact, others = table.concat(others, ", "), undone = P.Same(P.Portable(P.Active()), before) }}
		end
		emit(results)"#
	));
	for id in CATEGORIES {
		let r = &out[id];
		assert!(r["picks"].as_u64().unwrap_or(0) >= 2, "{id}: {r}");
		assert!(r["differed"].as_u64().unwrap_or(0) > 0, "{id}: the receiver's differs from the sender's: {r}");
		assert_eq!(r["order"], json!([id]), "{id}: the string holds it alone");
		assert_eq!(r["asNew"], true, "{id}: a new profile holds exactly the category's settings");
		assert_eq!(r["applied"], true, "{id}");
		assert_eq!(r["exact"], true, "{id}: taken into the profile in use, the category is the sender's");
		assert_eq!(r["others"], "", "{id}: nothing outside it changes");
		assert_eq!(r["undone"], true, "{id}: Undo puts it all back");
	}
}

// The page in the settings window.
const UI_FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// The UI stub, its login and the settings window's addon, the Profiles page open; then `script`.
fn run_page(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_encoding.lua"],
		addons: vec![Addon::files("Polestar", &UI_FILES)],
		script: format!(
			r#"uistub.install()
		stub.login()
		P, UI = Polestar.Profiles, Polestar.UI
		UI.LoadOptions()
		PV, O = UI.Profiles, UI.Options
		UI.ShowOptions("profiles")
		v = PV.views["Profiles"]
		function card(name) return v.CardRow.psCardBy[name] end
		{script}"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_profiles_tab_shows_a_card_per_profile_a_click_selects_and_use_switches_new_copy_rename_and_a_second_click_deletes() {
	let out = run_page(
		r#"local first = PV.Shown()
		local tabs = {}
		for _, b in ipairs(PolestarOptions.tabButtons) do if b:IsShown() then tabs[#tabs + 1] = b.Label:GetText() end end
		-- Settings window v2: section cards, 36px one-line rows, help in the tooltip only.
		local layout = { tabs = tabs, cards = { v.ListCard.Title:GetText(), v.CharCard.Title:GetText(), v.SelCard.Title:GetText() },
			heights = { v.Profile:GetHeight(), v.ForChar:GetHeight(), v.UsedBy:GetHeight(), v.Changed:GetHeight() },
			help = (rawget(v.ForChar, "Help") ~= nil and v.ForChar.Help:IsShown()) or (rawget(v.Profile, "Help") ~= nil and v.Profile.Help:IsShown()),
			tip = v.ForChar.psTipFn(v.ForChar)[1], compact = v.ForChar.psCompact == true and v.Profile.psCompact == true }
		-- The last card names a new profile; Create makes it and switches to it.
		card("\0new"):Click()
		local naming = PV.Shown()
		v.NameBox:SetText("Raid")
		v.NameOK:Click()
		local made = PV.Shown()
		Polestar.Set("ui.scale", 1.2)
		local changed = PV.Shown().changed
		-- Picking a card is not switching: Use is.
		card("Default"):Click()
		local picked = PV.Shown()
		local stillRaid = P.Active()
		v.Use:Click()
		local back = { PV.Shown().inUse, Polestar.Get("ui.scale") }
		-- Right-click on a card goes back to the profile in use.
		card("Raid"):Click()
		card("Raid"):GetScript("OnClick")(card("Raid"), "RightButton")
		local rightClick = PV.Shown().selected
		-- Copy and Rename name it in the section; a name taken is refused there.
		card("Raid"):Click()
		v.Copy:Click()
		local copying = { PV.Shown().editing, v.NameBox:GetText() }
		v.NameOK:Click()
		local copied = { PV.Shown().inUse, Polestar.Get("ui.scale") }
		v.Rename:Click()
		v.NameBox:SetText(" Raid ")
		v.NameOK:Click()
		local clash = PV.Shown().editorError
		v.NameBox:SetText("Raid two")
		v.NameOK:Click()
		local renamed = { PV.Shown().selected, P.Active() }
		-- Delete: the first click arms it, another profile disarms it, the second click deletes.
		v.Profile.psSet("Default")
		card("Raid"):Click()
		v.Delete:Click()
		local armed = { PV.Shown().delete, #P.List() }
		card("Raid two"):Click()
		local disarmed = PV.Shown().delete
		card("Raid"):Click()
		v.Delete:Click()
		v.Delete:Click()
		local afterDelete = PV.Shown()
		emit({ first = first, layout = layout, naming = naming, made = made, changed = changed, picked = picked, stillRaid = stillRaid,
			back = back, rightClick = rightClick, copying = copying, copied = copied, clash = clash, renamed = renamed, armed = armed,
			disarmed = disarmed, afterDelete = afterDelete })"#,
	);
	assert_eq!(out["layout"]["tabs"], json!(["Profiles", "Share"]), "two tabs of equal standing, no Essentials");
	assert_eq!(out["layout"]["cards"], json!(["Profiles", "This character", "Default"]));
	assert_eq!(out["layout"]["heights"], json!([36, 36, 36, 36]));
	assert_eq!(out["layout"]["help"], false, "no description lines on the page");
	assert_eq!(out["layout"]["tip"], "This character keeps its own choice of profile. Off: it follows its class's profile, else the account's.");
	assert_eq!(out["layout"]["compact"], true, "the window's compact rows");
	assert_eq!(out["first"]["cards"], json!([{ "name": "Default", "inUse": true, "lit": true }]));
	assert_eq!(out["first"]["newCard"], true, "the last card makes a new profile");
	assert_eq!(out["first"]["actions"], json!(["Copy"]), "Default stays and the profile in use is not deleted");
	assert_eq!(out["first"]["selectedInUse"], true);
	assert_eq!(out["first"]["usedBy"], "This character, Whole account");
	assert_eq!(out["first"]["changed"], "None");
	assert_eq!(out["first"]["source"], "Every character on this account uses it, unless one has its own.");
	assert_eq!(out["naming"]["editing"], "new");
	assert_eq!(out["naming"]["newLit"], true, "the new card is lit while it is named");
	assert_eq!(out["naming"]["selected"], "New profile");
	assert_eq!(out["made"]["inUse"], "Raid", "a new profile is switched to");
	assert_eq!(out["made"]["cards"], json!([{ "name": "Default", "inUse": false, "lit": false }, { "name": "Raid", "inUse": true, "lit": true }]));
	assert_eq!(out["made"]["actions"], json!(["Copy", "Rename"]));
	assert_eq!(out["changed"], "1", "the section counts the settings off their defaults");
	assert_eq!(out["picked"]["selected"], "Default");
	assert_eq!(out["picked"]["actions"], json!(["Use", "Copy"]));
	assert_eq!(out["stillRaid"], "Raid", "picking a card does not switch");
	assert_eq!(out["back"], json!(["Default", 1]), "Use switches, with the profile's own values");
	assert_eq!(out["rightClick"], "Default", "right-click goes back to the profile in use");
	assert_eq!(out["copying"], json!(["copy", "Raid (copy)"]));
	assert_eq!(out["copied"], json!(["Raid (copy)", 1.2]), "a copy is switched to, with the values copied");
	assert_eq!(out["clash"], "A profile called Raid already exists.");
	assert_eq!(out["renamed"], json!(["Raid two", "Raid two"]));
	assert_eq!(out["armed"], json!(["Click again to confirm", 3]), "the first click only arms Delete");
	assert_eq!(out["disarmed"], "Delete", "another profile's section starts unarmed");
	assert_eq!(out["afterDelete"]["cards"].as_array().map(|c| c.len()), Some(2));
	assert_eq!(out["afterDelete"]["selected"], "Default", "the profile in use once the selected one is gone");
}

#[test]
fn a_card_s_picture_is_drawn_from_its_profile_s_own_values_and_says_who_else_uses_it() {
	let out = run_page(
		r#"local function rgb(r, g, b) return { math.floor(r * 100 + 0.5), math.floor(g * 100 + 0.5), math.floor(b * 100 + 0.5) } end
		local live = rgb(Polestar.Theme.Accent())
		P.New("Violet")
		P.Switch("Violet")
		Polestar.Set("ui.accent", { 0.6, 0.4, 1 })
		P.Switch("Default")
		-- Every Mage uses Violet.
		PolestarDB.classProfiles = { MAGE = "Violet" }
		O.Select("profiles", "Profiles")
		-- The accent on the card's guide window: its tab's bar.
		local function accent(name)
			local parts = card(name).Art.psWin and card(name).Art.psWin.psSkinCard
			return parts and rgb(parts.tab.Bar:GetVertexColor()) or nil
		end
		local before = { accent("Violet"), accent("Default") }
		-- The profile in use follows its live settings.
		Polestar.Set("ui.accent", { 0.2, 0.8, 0.4 })
		local after = accent("Default")
		emit({ before = before, after = after, live = live, shown = PV.Shown(), tip = card("Violet").psTipLines })"#,
	);
	assert_eq!(out["before"][0], json!([60, 40, 100]), "Violet's card has Violet's accent while Default is in use");
	assert_eq!(out["before"][1], out["live"], "Default's card has the live accent");
	assert_eq!(out["after"], json!([20, 80, 40]), "the card of the profile in use follows a setting change");
	let violet = out["shown"]["cards"].as_array().unwrap().iter().find(|c| c["name"] == "Violet").cloned().unwrap();
	assert_eq!(violet["note"], "Every Mage", "a class's profile says so on its card");
	assert_eq!(violet["inUse"], false);
	assert!(out["tip"][0].as_str().unwrap().ends_with("off their defaults"), "{}", out["tip"]);
	assert_eq!(out["tip"][1], "Used by: Every Mage");
}

// A checklist as the tab shows it: "id:count", "x" when ticked, "(off)" when greyed, "(open)" when its list is.
fn parts(list: &Value) -> Vec<String> {
	list.as_array()
		.map(|a| {
			a.iter()
				.map(|p| {
					format!(
						"{}:{}{}{}{}",
						text(&p["id"]),
						text(&p["count"]),
						if p["ticked"] == true { " x" } else { "" },
						if p["enabled"] == false { " (off)" } else { "" },
						if p["open"] == true { " (open)" } else { "" }
					)
				})
				.collect()
		})
		.unwrap_or_default()
}

#[test]
fn the_share_tab_makes_a_string_of_the_parts_ticked_and_imports_the_parts_picked_with_an_undo() {
	let out = run_page(
		r#"local function tick(row) row.Box:SetChecked(not row.Box:GetChecked()) row.Box:Click() end
		P.New("Raid")
		P.Switch("Raid")
		Polestar.Set("ui.scale", 1.2)
		Polestar.Set("ui.accent", { 0.6, 0.4, 1 })
		Polestar.Set("ui.pos", { 300, 500 })
		P.Switch("Default")
		O.Select("profiles", "Profiles")
		-- The selected profile's Share opens the Share tab with that profile chosen.
		card("Raid"):Click()
		v.ShareLink:Click()
		local s = PV.views["Share"]
		local opened = PV.Shown()
		local onTab = O.view == s
		-- A category's row opens its list under it; again folds it.
		s.ExportRows.window:Click()
		local listed = PV.Shown().exportList
		s.ExportRows.window:Click()
		local folded = PV.Shown().exportList[1] or false
		s.ExportButton:Click()
		local made = PV.Shown()
		-- Skin only: made again at once.
		s.ExportPicks[3]:Click()
		local skinOnly = PV.Shown()
		-- Positions ticked by hand: the line saying why they stay out goes.
		tick(s.ExportRows.positions)
		local withPositions = { PV.Shown().note or false, PV.Shown().copyNote }
		s.ExportPicks[1]:Click()
		local all = PV.Shown().exported
		-- Pasted: a checklist of the parts it holds, what each changes.
		PV.Check(all)
		local pasted = PV.Shown()
		s.ImportRows.skin:Click()
		local open = PV.Shown().importList
		s.ImportPicks[3]:Click()
		local picked = PV.Shown().importParts
		-- Into the profile in use, after its dialog; then its Undo.
		s.ImportHere:Click()
		local asked = Polestar.Widgets.ModalShown()
		PolestarModal.Box.Action:Click()
		local applied = { PV.Shown().done, PV.Shown().undo, Polestar.Get("ui.accent"), Polestar.Get("ui.scale"), Polestar.Get("ui.pos") or false }
		s.UndoButton:Click()
		local undone = { PV.Shown().done, PV.Shown().undo, Polestar.Get("ui.accent") }
		-- As a new profile, every part it holds; then its Undo.
		PV.Check(all)
		local name = PV.Shown().importName
		s.ImportName:SetText("Shared")
		s.ImportNew:Click()
		local imported = { PV.Shown().done, P.Active(), Polestar.Get("ui.scale"), Polestar.Get("ui.pos") }
		s.UndoButton:Click()
		local undoneNew = { PV.Shown().done, P.Active(), P.Exists("Shared") }
		-- Nothing ticked: nothing to take.
		PV.Check(all)
		s.ImportPicks[2]:Click()
		s.ImportNew:Click()
		local none = { PV.Shown().importParts, s.ImportError:IsShown() and s.ImportError:GetText() or false }
		PV.Check("not a profile")
		local refused = { PV.Shown().refusal, s.ImportCancel:IsShown(), PV.Shown().picks, #PV.Shown().importParts }
		s.ImportCancel:Click()
		local cleared = { PV.Shown().refusal or false, s.PasteBox:GetText() }
		emit({ onTab = onTab, opened = opened, listed = listed, folded = folded, made = made, skinOnly = skinOnly, withPositions = withPositions,
			pasted = pasted, open = open, picked = picked, asked = asked, applied = applied, undone = undone, name = name, imported = imported,
			undoneNew = undoneNew, none = none, refused = refused, cleared = cleared })"#,
	);
	assert_eq!(out["onTab"], true);
	assert_eq!(out["opened"]["from"], "Raid");
	assert_eq!(out["opened"]["copyNote"], "Tick the parts to share and pick the profile, then make the string.");
	assert_eq!(
		parts(&out["opened"]["exportParts"]),
		[
			"skin:2 settings x",
			"fonts:At defaults x",
			"window:1 setting x",
			"arrow:At defaults x",
			"routes:At defaults x",
			"quests:At defaults x",
			"hud:At defaults x",
			"gear:At defaults x",
			"dungeons:At defaults x",
			"positions:1 setting"
		],
		"every category but Window positions ticked to start with"
	);
	assert_eq!(out["opened"]["note"], "Window positions stay out unless you tick them: on another screen, frames you dragged can land in odd places.");
	assert_eq!(out["listed"], json!(["Scale: 120%"]), "the Guide window's list: its setting and value");
	assert_eq!(out["folded"], false);
	assert_eq!(out["made"]["exported"].as_str().map(|s| &s[..6]), Some("!PSS1!"));
	assert_eq!(out["made"]["copyNote"], "3 settings of Raid. Selected for you: copy it with Ctrl+C, then share it anywhere.");
	// The accent is the player's own colour: EllesmereUI's accent turned itself off.
	assert_eq!(parts(&out["skinOnly"]["exportParts"])[0], "skin:2 settings x");
	assert_eq!(parts(&out["skinOnly"]["exportParts"])[2], "window:1 setting");
	assert_eq!(out["skinOnly"]["copyNote"], "2 settings of Raid. Selected for you: copy it with Ctrl+C, then share it anywhere.", "made again at once");
	assert_eq!(out["withPositions"], json!([false, "3 settings of Raid. Selected for you: copy it with Ctrl+C, then share it anywhere."]));
	assert_eq!(out["pasted"]["preview"], "Raid  \u{b7}  4 settings  \u{b7}  4 differ from Default");
	assert_eq!(out["pasted"]["picks"], true, "the quick picks in the card's header");
	assert_eq!(
		parts(&out["pasted"]["importParts"]),
		[
			"skin:2 changes x",
			"fonts:Same as yours (off)",
			"window:1 change x",
			"arrow:Same as yours (off)",
			"routes:Same as yours (off)",
			"quests:Same as yours (off)",
			"hud:Same as yours (off)",
			"gear:Same as yours (off)",
			"dungeons:Same as yours (off)",
			"positions:1 change x"
		],
		"the parts it holds; one that changes nothing and carries nothing is greyed"
	);
	assert_eq!(out["open"], json!(["Accent: From the look > #9966FF", "Match EllesmereUI accent: On > Off"]), "yours, then theirs");
	assert_eq!(parts(&out["picked"])[0], "skin:2 changes x (open)");
	assert_eq!(parts(&out["picked"])[2], "window:1 change", "Skin only");
	assert_eq!(out["asked"], true, "applying into the profile in use asks first");
	assert_eq!(out["applied"], json!(["Applied to Default: 2 settings changed.", true, [0.6, 0.4, 1], 1, false]), "the skin alone");
	assert_eq!(out["undone"], json!(["Undone: Default is as it was.", false, false]));
	assert_eq!(out["name"], "Raid 2", "the string's own name, made free");
	assert_eq!(out["imported"], json!(["Imported as Shared, now in use.", "Shared", 1.2, [300, 500]]));
	assert_eq!(out["undoneNew"], json!(["Undone: Shared is gone and Default is in use again.", "Default", false]));
	assert_eq!(out["none"][1], "Nothing to apply: every part of the string is unticked.");
	assert_eq!(out["refused"], json!(["This is not a Polestar profile string.", true, false, 0]));
	assert_eq!(out["cleared"], json!([false, ""]));
}
