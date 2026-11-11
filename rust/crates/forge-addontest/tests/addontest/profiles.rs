//! Settings profiles (addon/Polestar/Core/Profiles.lua) and their page (UI/Profiles.lua): settings saved before
//! profiles become the profile Default with nothing lost; switch, copy, rename and delete; a character's own
//! choice across a reload; migrations run once over every profile; profile strings round-trip exactly, refuse
//! anything malformed and drop what this Polestar has no setting for.

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
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
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
	let saved = format!("{}\n{}", text(&db), char.map(|c| text(c).to_string()).unwrap_or_default());
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
			compressed = compressed, compressedAfter = stub.compressed, plainSame = P.Same(pv2.settings, mine), areas = pv.areas,
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
	assert_eq!(out["areas"], json!({ "look": 2, "guiding": 3, "positions": 3 }));
	assert_eq!(out["otherScreen"], false, "same screen, same scale");
	assert_eq!(out["accent"], json!([0.2, 0.4, 0.6, 0.9]));
	assert_eq!(out["arrow"], json!({ "point": "TOP", "relPoint": "TOP", "x": -35.211196899414, "y": -20.12544631958 }));
}

#[test]
fn a_look_only_or_positions_only_string_holds_that_part_and_an_import_applies_only_the_parts_ticked() {
	let out = run(&format!(
		r#"{SETUP}
		local look = P.Import((P.Export(nil, {{ look = true }})))
		local pos = P.Import((P.Export(nil, {{ areas = {{ positions = true }} }})))
		local all = P.Import((P.Export()))
		P.New("Fresh")
		P.Switch("Fresh")
		local none = select(2, P.Apply(all, P.Active(), {{}}))
		P.Apply(all, P.Active(), {{ look = true }})
		emit({{ look = look.keys, isLook = look.look, pos = pos.keys, posIsLook = pos.look, none = none,
			scale = Polestar.Get("ui.scale"), compact = Polestar.Get("ui.compact"), placed = Polestar.Get("ui.pos") or false }})"#
	));
	assert_eq!(out["look"], json!(["ui.accent", "ui.scale"]));
	assert_eq!(out["isLook"], true);
	assert_eq!(out["pos"], json!(["nav.arrowPos", "rares.toastPoint", "ui.pos"]));
	assert_eq!(out["posIsLook"], false);
	assert_eq!(out["none"], "Nothing to apply: every part of the string is unticked.");
	assert_eq!(out["scale"], 1.1, "the look applied");
	assert_eq!(out["compact"], false, "guiding left as it was");
	assert_eq!(out["placed"], false, "positions left as they were");
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

// The page in the settings window.
const UI_FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

#[test]
fn the_profiles_page_lists_switches_creates_deletes_after_asking_exports_and_imports() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_encoding.lua"],
		addons: vec![Addon::files("Polestar", &UI_FILES)],
		script: r#"uistub.install()
		stub.login()
		local P, UI = Polestar.Profiles, Polestar.UI
		UI.LoadOptions()
		local PV = UI.Profiles
		local function row(name) for _, r in ipairs(PV.view.Rows) do if r:IsShown() and r.psName == name then return r end end end
		UI.ShowOptions("profiles")
		local first = PV.Shown()
		local v = PV.view
		-- Settings window v2: cards by subject, 36px one-line rows, help in the tooltip only.
		local layout = { cards = { v.ListCard.Title:GetText(), v.ShareCard.Title:GetText() }, newRow = v.NewRow:IsShown() and v.NewRow.psCompact == true,
			heights = { v.Profile:GetHeight(), v.ForChar:GetHeight(), v.ExportAreas.look:GetHeight() },
			help = (rawget(v.ForChar, "Help") ~= nil and v.ForChar.Help:IsShown()) or (rawget(v.Profile, "Help") ~= nil and v.Profile.Help:IsShown()),
			tip = v.ForChar.psTipFn(v.ForChar)[1], compact = v.ForChar.psCompact == true and v.Profile.psCompact == true }
		v.NewButton:Click()
		v.NameBox:SetText("Raid")
		v.NameOK:Click()
		local made = PV.Shown()
		Polestar.Set("ui.scale", 1.2)
		v.ExportButton:Click()
		local exported = PV.Shown()
		v.NewButton:Click()
		v.NameBox:SetText(" Raid ")
		v.NameOK:Click()
		local clash = PV.Shown().editorError
		PV.CancelEdit()
		row("Default").Use:Click()
		local back = { PV.Shown().inUse, Polestar.Get("ui.scale") }
		row("Raid").Delete:Click()
		local asked = { Polestar.Widgets.ModalShown(), #P.List() }
		PolestarModal.Box.Action:Click()
		local afterDelete = PV.Shown().rows
		PV.Check(exported.exported)
		local previewed = PV.Shown()
		v.ImportName:SetText("Shared")
		v.ImportNew:Click()
		local imported = PV.Shown()
		local importedScale = Polestar.Get("ui.scale")
		PV.Check("not a profile")
		local refused = PV.Shown().refusal
		v.Profile.psSet("Default")
		local viaMenu = { PV.Shown().inUse, Polestar.Get("ui.scale") }
		local page
		for _, p in ipairs(UI.Options.Pages()) do if p.key == "profiles" then page = p.name end end
		emit({ first = first, made = made, exported = exported.exported:sub(1, 6), copyNote = exported.copyNote, clash = clash, back = back,
			asked = asked, afterDelete = afterDelete, previewed = previewed, imported = imported, refused = refused, viaMenu = viaMenu,
			scale = importedScale, page = page, layout = layout })"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["page"], "Profiles");
	assert_eq!(out["layout"]["cards"], json!(["Profiles", "Share"]), "no one-row cards: who uses it sits with the list, import with export");
	assert_eq!(out["layout"]["newRow"], true, "New profile is a row beside the switches");
	assert_eq!(out["layout"]["heights"], json!([36, 36, 36]));
	assert_eq!(out["layout"]["help"], false, "no description lines on the page");
	assert_eq!(out["layout"]["tip"], "This character keeps its own choice of profile. Off: it follows its class's profile, else the account's.");
	assert_eq!(out["layout"]["compact"], true, "the window's compact rows");
	assert_eq!(out["viaMenu"], json!(["Default", 1]), "the Profile menu switches");
	assert_eq!(out["first"]["inUse"], "Default");
	assert_eq!(out["first"]["source"], "Every character on this account uses it, unless one has its own.");
	assert_eq!(out["first"]["rows"], json!([{ "name": "Default", "inUse": true, "actions": ["Copy"] }]));
	assert_eq!(out["made"]["inUse"], "Raid", "a new profile is switched to");
	assert_eq!(out["made"]["rows"], json!([{ "name": "Default", "inUse": false, "actions": ["Use", "Copy"] }, { "name": "Raid", "inUse": true, "actions": ["Copy", "Rename"] }]));
	assert_eq!(out["exported"], "!PSS1!");
	assert_eq!(out["copyNote"], "1 setting of Raid. Selected for you: copy it with Ctrl+C, then share it anywhere.");
	assert_eq!(out["clash"], "A profile called Raid already exists.");
	assert_eq!(out["back"], json!(["Default", 1]));
	assert_eq!(out["asked"], json!([true, 2]), "Delete asks first");
	assert_eq!(out["afterDelete"], json!([{ "name": "Default", "inUse": true, "actions": ["Copy"] }]));
	assert_eq!(out["previewed"]["importName"], "Raid", "the string's own name, free again");
	assert_eq!(out["previewed"]["preview"], "Raid  \u{b7}  1 setting  \u{b7}  1 differs from Default");
	assert_eq!(out["imported"]["inUse"], "Shared");
	assert_eq!(out["imported"]["done"], "Imported as Shared, now in use.");
	assert_eq!(out["scale"], 1.2);
	assert_eq!(out["refused"], "This is not a Polestar profile string.");
}
