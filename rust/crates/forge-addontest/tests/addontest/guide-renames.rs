//! Guides a pack renamed (its renamed.json, compiled into Polestar.RenameGuides; `forge guide renumber`) keep every
//! character's place (addon/Polestar/Core/Guides.lua, Own.moveRenamed): a save made under the old ids loads into
//! the new ones at login, the same tabs in the same order, each at the step on screen and the live step it had,
//! with its ticks and skips, the closed tabs, the picker's and the class card's marks, the account's alts' tabs;
//! no old id is left in the save. Another pack's and an imported guide's saved state is untouched, and another
//! pack's `next` to an old id leads to the new one. A compiled pack carries renamed.json as
//! Polestar.RenameGuides, and lint checks the file.

use forge_addontest::dsl::build_pack;
use forge_addontest::tmp::TempDir;
use forge_addontest::{emitted, is_match, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use forge_guide::project::FileContent;
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 20, 80)
"#;

// The test pack's two guides under `north` and `south`, another pack's guide that hands over to `north`, and an
// imported guide.
fn guides(north: &str, south: &str) -> String {
	format!(
		r#"
Polestar.RegisterGuide({{ id = "{north}", pack = "test", title = "North", category = "Exploration", minLevel = 1, maxLevel = 60, steps = {{
	{{ goals = {{ {{ t = "goto", map = 1429, x = 40, y = 60 }} }} }},
	{{ goals = {{ {{ t = "goto", map = 1429, x = 42, y = 62 }} }} }},
	{{ goals = {{ {{ t = "goto", map = 1429, x = 44, y = 64 }} }} }},
	{{ goals = {{ {{ t = "goto", map = 1429, x = 46, y = 66 }}, {{ t = "goto", map = 1429, x = 47, y = 67 }} }} }},
	{{ goals = {{ {{ t = "goto", map = 1429, x = 48, y = 68 }} }} }},
}} }})
Polestar.RegisterGuide({{ id = "{south}", pack = "test", title = "South", category = "Exploration", minLevel = 1, maxLevel = 60, steps = {{
	{{ goals = {{ {{ t = "goto", map = 1429, x = 60, y = 60 }} }} }},
	{{ goals = {{ {{ t = "goto", map = 1429, x = 62, y = 62 }} }} }},
	{{ goals = {{ {{ t = "goto", map = 1429, x = 64, y = 64 }} }} }},
}} }})
Polestar.RegisterPack({{ addon = "Polestar_Joe", id = "joe", format = 1, title = "Joe", author = "Joe", version = "1", license = "MIT" }})
Polestar.RegisterGuide({{ id = "joe/route", pack = "joe", title = "Joe's", category = "Exploration", minLevel = 1, maxLevel = 60,
	next = "test/03-north", nextChoices = {{ "test/03-north", "test/05-south" }}, nextWhen = {{ ["test/05-south"] = {{ {{ k = "level", op = ">=", n = 20 }} }} }}, steps = {{
	{{ goals = {{ {{ t = "goto", map = 1429, x = 30, y = 30 }} }} }},
	{{ goals = {{ {{ t = "goto", map = 1429, x = 32, y = 32 }} }} }},
}} }})
Polestar.RegisterGuide({{ id = "ann/cozy", pack = "imported", title = "Cozy", category = "Exploration", minLevel = 1, maxLevel = 60, steps = {{
	{{ goals = {{ {{ t = "goto", map = 1429, x = 70, y = 30 }} }} }},
	{{ goals = {{ {{ t = "goto", map = 1429, x = 72, y = 32 }} }} }},
}} }})
"#
	)
}

const OLD_NORTH: &str = "test/03-north";
const OLD_SOUTH: &str = "test/05-south";
const NEW_NORTH: &str = "test/01-north";
const NEW_SOUTH: &str = "test/02-south";

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
function at(id) for i, t in ipairs(E.GetTabs()) do if t.guideId == id then return i end end end
local function sorted(t)
	local out = {}
	for k in pairs(t or {}) do out[#out + 1] = tostring(k) end
	table.sort(out)
	return out
end
-- Every tab as the player sees it: the guide, the step on screen, the live step, its ticks and skips.
function view()
	local list, active = E.GetTabs()
	local out = {}
	for i, t in ipairs(list) do
		E.SelectTab(i); flush()
		out[i] = { guide = t.guideId, step = E.GetStepIndex() or false, live = E.GetLiveStep() or false,
			ticks = sorted((PolestarCharDB.manual or {})[t.guideId]), skips = sorted((PolestarCharDB.skipped or {})[t.guideId]) }
	end
	E.SelectTab(active); flush()
	return { tabs = out, active = active }
end
-- Every string of the saves, keys and values, that names one of `ids` (or "<id>:...").
function mentions(ids)
	local found, seen = {}, {}
	local function hit(v)
		if type(v) ~= "string" then return end
		for _, id in ipairs(ids) do
			if v == id or v:sub(1, #id + 1) == id .. ":" then found[#found + 1] = v end
		end
	end
	local function walk(t)
		if seen[t] then return end
		seen[t] = true
		for k, v in pairs(t) do
			hit(k)
			if type(v) == "table" then walk(v) else hit(v) end
		end
	end
	walk(PolestarCharDB or {})
	walk(PolestarDB or {})
	table.sort(found)
	return found
end
local function ser(v)
	if type(v) == "string" then return string.format("%q", v) end
	if type(v) ~= "table" then return tostring(v) end
	local parts = {}
	for k, x in pairs(v) do
		if type(x) ~= "function" then parts[#parts + 1] = "[" .. ser(k) .. "]=" .. ser(x) end
	end
	return "{" .. table.concat(parts, ",") .. "}"
end
function save() return "PolestarCharDB = " .. ser(PolestarCharDB) .. "\nPolestarDB = " .. ser(PolestarDB) end
"#;

fn run(saved: Option<String>, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: saved.map(|s| ("Polestar".to_string(), s)).into_iter().collect(),
		script: [TEST_PACK, TEST_SOURCE, script].join("\n"),
		..Default::default()
	})
}

/// The release before the renames: the player opens North, South, Joe's and the imported guide, works North (ticks
/// steps 1 and 2, skips 3, ticks 4, looks back at 3), ticks Joe's first step, closes South (it goes to the closed
/// tabs) and opens it again; the class card and the picker mark North and South; another character of the account
/// had South open. -> (what each tab showed, the save at logout).
fn played_before() -> (Value, String) {
	let mut out = run(
		None,
		&format!(
			r#"{}
{HELPERS}
stub.login(); flush()
E.OpenTab("{OLD_NORTH}"); flush()
E.ToggleGoal(1, 1); flush()
E.ToggleGoal(2, 1); flush()
E.Skip(); flush()
E.ToggleGoal(4, 1); flush()
E.Prev(); flush()
E.OpenTab("{OLD_SOUTH}", false); flush()
E.OpenTab("joe/route", false); flush()
E.OpenTab("ann/cozy", false); flush()
E.SelectTab(at("joe/route")); flush()
E.ToggleGoal(1, 1); flush()
E.SelectTab(at("ann/cozy")); flush()
E.Skip(); flush()
E.SelectTab(at("{OLD_NORTH}")); flush()
PolestarCharDB.classCardSeen = {{ ["{OLD_NORTH}:12"] = true, ["joe/route:3"] = true }}
PolestarCharDB.ui = {{ pickerSelected = "{OLD_SOUTH}", recentGuides = {{ "{OLD_NORTH}", "joe/route", "{OLD_SOUTH}" }} }}
PolestarDB.alts = {{ chars = {{ ["Ann-Realm"] = {{ tabs = {{ {{ id = "{OLD_SOUTH}", step = 2 }}, {{ id = "ann/cozy", step = 1 }} }} }} }} }}
emit(view())
stub.fire("PLAYER_LOGOUT")
emit({{ save = save() }})
"#,
			guides(OLD_NORTH, OLD_SOUTH)
		),
	);
	let save = out.remove(1)["save"].as_str().expect("the save").to_string();
	(out.remove(0), save)
}

/// `view` with the old ids written as the new ones.
fn renamed(v: &Value) -> Value {
	serde_json::from_str(&v.to_string().replace(OLD_NORTH, NEW_NORTH).replace(OLD_SOUTH, NEW_SOUTH)).unwrap()
}

#[test]
fn a_save_under_the_old_ids_loads_into_the_new_ones_at_the_same_steps_other_packs_untouched() {
	let (before, save) = played_before();
	assert_eq!(before["active"], 1, "{before}");
	assert_eq!(before["tabs"][0], json!({ "guide": OLD_NORTH, "step": 3, "live": 4, "ticks": ["1:1", "2:1", "4:1"], "skips": ["3"] }), "{before}");
	assert_eq!(before["tabs"].as_array().unwrap().len(), 4, "{before}");
	// The update: the same guides under new ids, the pack's renames registered as its Guides.lua does.
	let out = run(
		Some(save.clone()),
		&format!(
			r#"{}
Polestar.RenameGuides("test", {{ ["{OLD_NORTH}"] = "{NEW_NORTH}", ["{OLD_SOUTH}"] = "{NEW_SOUTH}" }})
{HELPERS}
local db = PolestarCharDB
local untouched = {{ joe = db.manual["joe/route"], ann = db.skipped["ann/cozy"], card = db.classCardSeen["joe/route:3"] }}
stub.login(); flush()
local joe = Polestar.Guides.Get("joe/route")
emit({{
	view = view(),
	old = mentions({{ "{OLD_NORTH}", "{OLD_SOUTH}" }}),
	new = mentions({{ "{NEW_NORTH}", "{NEW_SOUTH}" }}),
	card = db.classCardSeen, ui = db.ui, alts = PolestarDB.alts.chars["Ann-Realm"].tabs,
	same = untouched.joe == db.manual["joe/route"] and untouched.ann == db.skipped["ann/cozy"] and untouched.card == db.classCardSeen["joe/route:3"],
	joe = {{ next = joe.next, choices = joe.nextChoices, when = joe.nextWhen["{NEW_SOUTH}"] ~= nil, oldWhen = joe.nextWhen["{OLD_SOUTH}"] ~= nil }},
	successor = Polestar.Guides.Successor("{OLD_SOUTH}") or false,
	again = Polestar.Guides.Get("{OLD_NORTH}") ~= nil,
}})
"#,
			guides(NEW_NORTH, NEW_SOUTH)
		),
	)
	.remove(0);
	// Every tab back in its place, at the step on screen and the live step it had, with its ticks and skips.
	assert_eq!(out["view"], renamed(&before), "{out}");
	assert_eq!(out["old"], json!({}), "no old id is left in the save: {out}");
	assert!(out["new"].as_array().unwrap().len() > 8, "{out}");
	assert_eq!(out["card"], json!({ "test/01-north:12": true, "joe/route:3": true }), "{out}");
	assert_eq!(out["ui"], json!({ "pickerSelected": NEW_SOUTH, "recentGuides": [NEW_NORTH, "joe/route", NEW_SOUTH] }), "{out}");
	assert_eq!(out["alts"], json!([{ "id": NEW_SOUTH, "step": 2 }, { "id": "ann/cozy", "step": 1 }]), "the account's alts' tabs: {out}");
	assert_eq!(out["same"], true, "another pack's and the imported guide's saved state is the same tables, untouched: {out}");
	// Another pack's hand-over to an old id leads to the new one.
	assert_eq!(out["joe"], json!({ "next": NEW_NORTH, "choices": [NEW_NORTH, NEW_SOUTH], "when": true, "oldWhen": false }), "{out}");
	assert_eq!(out["successor"], NEW_SOUTH);
	assert_eq!(out["again"], false);
}

#[test]
fn a_second_login_changes_nothing_and_a_guide_still_registered_under_an_old_id_keeps_its_save() {
	let (before, save) = played_before();
	let login = |extra: &str, ids: (&str, &str)| {
		run(
			Some(save.clone()),
			&format!(
				r#"{}
{extra}
{HELPERS}
stub.login(); flush()
emit({{ view = view(), save = save() }})
"#,
				guides(ids.0, ids.1)
			),
		)
		.remove(0)
	};
	let rename = format!(r#"Polestar.RenameGuides("test", {{ ["{OLD_NORTH}"] = "{NEW_NORTH}", ["{OLD_SOUTH}"] = "{NEW_SOUTH}" }})"#);
	let first = login(&rename, (NEW_NORTH, NEW_SOUTH));
	let second = run(
		Some(first["save"].as_str().unwrap().to_string()),
		&format!("{}\n{rename}\n{HELPERS}\nstub.login(); flush()\nemit({{ view = view() }})", guides(NEW_NORTH, NEW_SOUTH)),
	)
	.remove(0);
	assert_eq!(second["view"], first["view"], "a second login under the renames finds nothing to move");
	assert_eq!(first["view"], renamed(&before));
	// A pack that still registers the old ids (an older pack beside a newer core): nothing moves.
	let kept = login(&rename, (OLD_NORTH, OLD_SOUTH));
	assert_eq!(kept["view"], before, "{kept}");
	// A pack's rename of ids another pack owns is ignored.
	let foreign = login(r#"Polestar.RenameGuides("joe", { ["test/03-north"] = "joe/north" })"#, (OLD_NORTH, OLD_SOUTH));
	assert_eq!(foreign["view"], before, "{foreign}");
}

// A pack folder with two guides (`trail/01-north`, `trail/02-south`) and `renamed` as its renamed.json.
fn pack_dir(renamed: &str) -> TempDir {
	let tmp = TempDir::new("polestar-renamed-");
	let dir = tmp.path();
	let write = |rel: &str, text: &str| std::fs::write(dir.join(rel), text).unwrap();
	write("pack.json", r#"{"id":"trail","title":"Trail Pack","author":"Ann","version":"1.0.0","license":"CC0-1.0","folder":"PolestarPack_Trail"}"#);
	std::fs::create_dir(dir.join("guides")).unwrap();
	for (id, title) in [("trail/01-north", "Elwynn Forest"), ("trail/02-south", "Westfall")] {
		write(&format!("guides/{}.guide", id.trim_start_matches("trail/")), &format!("guide {id}\ntitle {title}\nfaction Alliance\nlevels 1-10\nzone Elwynn Forest\n\nstep Marshal McBride\n  accept 7\n  turnin 7\n"));
	}
	write("renamed.json", renamed);
	tmp
}

fn guides_lua(dir: &TempDir) -> String {
	let r = build_pack(dir.path());
	assert_eq!(r.project.diag.errors().iter().map(|d| d.message.as_str()).collect::<Vec<_>>(), Vec::<&str>::new());
	match r.files.as_ref().unwrap().iter().find(|(n, _)| n == "Guides.lua") {
		Some((_, FileContent::Text(t))) => t.clone(),
		_ => panic!("no Guides.lua"),
	}
}

#[test]
fn a_pack_s_renamed_json_compiles_into_polestar_rename_guides_and_lint_checks_it() {
	let ok = pack_dir(r#"{"trail/05-south": "trail/02-south", "trail/03-north": "trail/01-north"}"#);
	assert!(is_match(&guides_lua(&ok), r#"\nPolestar\.RenameGuides\("trail", \{\n\t\["trail/03-north"\] = "trail/01-north",\n\t\["trail/05-south"\] = "trail/02-south",\n\}\)\n$"#));
	let bad = pack_dir(r#"["trail/03-north"]"#);
	assert!(build_pack(bad.path()).project.diag.errors().iter().any(|d| is_match(&d.message, "renamed.json must map old guide ids to new ones")));
	let warn = |text: &str| -> Vec<String> {
		let dir = pack_dir(text);
		build_pack(dir.path()).project.diag.list.iter().filter(|d| d.severity == "warning" && d.message.contains("renamed")).map(|d| d.message.clone()).collect()
	};
	assert_eq!(warn(r#"{"trail/01-north": "trail/02-south"}"#), [r#"renamed guide id "trail/01-north" is still a guide of the pack: Polestar keeps opening it"#]);
	assert_eq!(warn(r#"{"trail/03-north": "trail/09-north"}"#), [r#"guide id "trail/03-north" is renamed to "trail/09-north", which is no guide of the pack"#]);
}
