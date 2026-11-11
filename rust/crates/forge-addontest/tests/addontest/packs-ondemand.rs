//! Packs whose addon the client loads only on demand (Core/Guides.lua, Own.loadDemand; UI/Packs.lua), and
//! Polestar's own one, Polestar_Experimental: listed from its TOC and off until the player switches it on on the
//! Community guides page, then loaded (never in a fight: once it ends) and again at every login while it stays
//! on; switched off, its guides hide. The experimental guides are never suggested, never where suggestions
//! come from and never a route choice. Installed and off, the pack costs a login only its scan record. Its id
//! is reserved: no other addon or import string can take it.
//!
//! The behaviour is tested on a fixture pack built as `forge guide compile experimental` builds the real one
//! (forge-guide's build_pack_files with the extra pack's id and folder: Polestar's TOC, LoadOnDemand). The
//! checkout's own build, addon/Polestar_Experimental from experimental/, is checked against its sources when
//! the checkout has them.

use forge_addontest::dsl::{self, TestPack};
use forge_addontest::run::{addons_dir, dir_files, lua_string, root};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};
use std::path::Path;

const EXP: &str = "Polestar_Experimental";
const ID: &str = "polestar-experimental";

/// The fixture pack's pack.json, as experimental/pack.json gives it (the build names the folder).
const MANIFEST: &str = r#"{ "id": "polestar-experimental", "title": "Polestar Experimental", "author": "Polestar", "version": "1.0.0",
	"license": "GPL-3.0-only", "notes": "Part of Polestar: experimental guides for Forever's new zones (alpha). Off until you switch it on under Options, Community guides.",
	"folder": "Polestar_Experimental" }"#;

/// Two leveling guides the fixture data knows, the first handing over to the second.
const GUIDES: [(&str, &str); 2] = [
	(
		"elwynn-1.guide",
		"guide polestar-experimental/elwynn-1\ntitle Elwynn 1 (experimental)\nfaction Alliance\nlevels 10-20\nzone Elwynn Forest\nnext polestar-experimental/elwynn-2\n\nstep Kobold camp\n  goto 47.6,35.1 \"Kobold camp\"\n",
	),
	("elwynn-2.guide", "guide polestar-experimental/elwynn-2\ntitle Elwynn 2 (experimental)\nfaction Alliance\nlevels 12-20\nzone Elwynn Forest\n\nstep Goldshire\n  goto 42.9,65.6 \"Goldshire\"\n"),
];

/// The fixture pack built into a temp folder (removed with the returned value).
fn pack() -> TestPack {
	let data = dsl::fixture_data();
	let c = dsl::compile_with(&GUIDES, &data, Some(ID));
	assert!(c.errors.is_empty(), "{:?}", c.errors);
	let manifest = forge_guide::js::parse_json(MANIFEST).unwrap();
	dsl::write_test_pack(&c.guides, &data, &manifest)
}

/// A built pack folder's TOC fields, as the client's GetAddOnMetadata reads them.
fn toc(dir: &Path) -> Vec<(String, String)> {
	let text = std::fs::read_to_string(dir.join(format!("{EXP}.toc"))).unwrap_or_else(|e| panic!("{}: {e}", dir.display()));
	text.lines().filter_map(|l| l.strip_prefix("## ")?.split_once(':')).map(|(k, v)| (k.trim().to_string(), v.trim().to_string())).collect()
}

fn field(dir: &Path, key: &str) -> String {
	toc(dir).into_iter().find(|(k, _)| k == key).map(|(_, v)| v).unwrap_or_else(|| panic!("{EXP}.toc has no {key}"))
}

/// The guide ids a built pack folder registers, in its Guides.lua's order.
fn guide_ids(dir: &Path) -> Vec<String> {
	let text = std::fs::read_to_string(dir.join("Guides.lua")).unwrap();
	let re = regex::Regex::new(r#"\n\t\t\tid = "([^"]+)",\n"#).unwrap();
	re.captures_iter(&text).map(|c| c[1].to_string()).collect()
}

/// The AddOns list: Polestar (its version the pack's, as in one release zip), and when given the experimental
/// pack built in `pack`, which the client loads only on demand: its TOC's fields, and its files for
/// stub_packs.lua, which runs them when the client is asked to load it.
fn addons(pack: Option<&Path>) -> String {
	let version = lua_string(&pack.map_or_else(|| "1.0.0".to_string(), |d| field(d, "Version")));
	let mut s = format!("stub.addonMeta.Polestar = {{ Version = {version} }}\nstub.addons = {{ {{ name = \"Polestar\", loaded = true }}");
	let Some(dir) = pack else { return s + " }\n" };
	s.push_str(&format!(", {{ name = {} , reason = \"DEMAND_LOADED\" }} }}\n", lua_string(EXP)));
	let meta: Vec<String> = toc(dir).iter().map(|(k, v)| format!("[{}] = {}", lua_string(k), lua_string(v))).collect();
	let files: Vec<String> = dir_files(dir).unwrap_or_else(|e| panic!("{e}")).iter().map(|f| lua_string(&f.to_string_lossy())).collect();
	s.push_str(&format!("stub.addonMeta[{n}] = {{ {} }}\nstub.packs[{n}] = {{ {} }}\n", meta.join(", "), files.join(", "), n = lua_string(EXP)));
	s
}

const SAVED_ON: &str = r#"PolestarDB = { schema = 1, packs = { ["polestar-experimental"] = { on = true } } }"#;

/// The core with the pack built in `dir` installed, logged in unless `script` logs in itself.
fn core(dir: &Path, saved: &[(&str, String)], login: bool, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: addons(Some(dir)),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: saved.iter().map(|(a, lua)| (a.to_string(), lua.clone())).collect(),
		login,
		script: format!("G = Polestar.Guides\nID = \"{ID}\"\n{script}"),
	})
	.remove(0)
}

#[test]
fn the_extra_pack_builds_as_polestar_s_loads_on_demand_and_registers_its_guides() {
	let p = pack();
	let f = |k: &str| field(&p.dir, k);
	assert_eq!(f("Title"), "Polestar Experimental", "Polestar's own title, no \"Polestar Community: \"");
	assert_eq!(f("Author"), "Polestar");
	assert_eq!(f("LoadOnDemand"), "1");
	assert_eq!(f("Dependencies"), "Polestar");
	assert_eq!(f("X-Polestar-Pack"), ID);
	assert!(f("X-Polestar-Format").parse::<u32>().is_ok());
	assert_eq!(f("Version"), "1.0.0", "pack.json's version");
	assert_eq!(guide_ids(&p.dir), ["polestar-experimental/elwynn-1", "polestar-experimental/elwynn-2"]);
}

// The checkout's own experimental pack, when it has one (experimental/ with its pack.json): its build in
// addon/Polestar_Experimental (`forge guide compile experimental`, or `forge release pack`) is there, is Polestar's
// and loads on demand, carries experimental/pack.json's version and registers exactly the guides experimental/'s
// .guide files give. Without experimental/pack.json no build may be left behind.
#[test]
fn the_checkout_s_experimental_build_matches_experimental() {
	let src = root().join("experimental");
	let build = addons_dir().join(EXP);
	if !src.join("pack.json").exists() {
		assert!(!build.exists(), "addon/{EXP} is left without experimental/pack.json");
		return;
	}
	assert!(build.join(format!("{EXP}.toc")).exists(), "experimental/ is not built: run `forge guide compile experimental`");
	let manifest: Value = serde_json::from_str(&std::fs::read_to_string(src.join("pack.json")).unwrap()).unwrap();
	let f = |k: &str| field(&build, k);
	assert_eq!((f("Author"), f("LoadOnDemand"), f("X-Polestar-Pack")), ("Polestar".into(), "1".into(), ID.into()));
	assert_eq!(f("Version"), manifest["version"].as_str().unwrap(), "built from experimental/pack.json's version");
	let mut built = guide_ids(&build);
	built.sort();
	let mut sources: Vec<String> = forge_guide::project::find_guide_files(&src, false)
		.iter()
		.filter_map(|rel| std::fs::read_to_string(src.join(rel)).ok()?.lines().find_map(|l| l.trim().strip_prefix("guide ").map(|id| id.trim().to_string())))
		.collect();
	sources.sort();
	assert_eq!(built, sources, "addon/{EXP} registers the guides experimental/ gives: rebuild it with `forge guide compile experimental`");
}

#[test]
fn off_until_switched_on_then_loaded_once_its_guides_shown_and_hidden_with_the_switch() {
	let p = pack();
	let out = core(
		&p.dir,
		&[],
		true,
		r#"
local function mine()
	local out = {}
	for _, h in ipairs(G.List()) do if h.pack == ID then out[#out + 1] = h.id end end
	return out
end
local function rows()
	local n = 0
	for _, r in ipairs(G.Packs()) do if r.id == ID then n = n + 1 end end
	return n
end
local r = G.Pack(ID)
local out = { listed = { status = r.status, addon = r.addon, title = r.title, author = r.author, tocOnly = r.tocOnly or false,
	shown = G.PackShown(ID), guides = #mine(), loads = stub.packLoads.Polestar_Experimental or 0, rows = rows() } }
local fired = {}
Polestar.On("GUIDES_REGISTERED", function() fired[#fired + 1] = "guides" end)
Polestar.On("PACKS_CHANGED", function(id) fired[#fired + 1] = "packs " .. tostring(id) end)
G.SetPackShown(ID, true)
r = G.Pack(ID)
out.on = { status = r.status, tocOnly = r.tocOnly or false, guides = #mine(), count = r.guideCount, rows = rows(),
	loads = stub.packLoads.Polestar_Experimental or 0, saved = PolestarDB.packs[ID].on, fired = table.concat(fired, ", ") }
local first = mine()[1]
G.SetPackShown(ID, false)
out.off = { status = G.Pack(ID).status, guides = #mine(), get = G.Get(first) ~= nil, saved = PolestarDB.packs[ID] ~= nil }
G.SetPackShown(ID, true)
out.again = { status = G.Pack(ID).status, guides = #mine(), loads = stub.packLoads.Polestar_Experimental }
emit(out)"#,
	);
	assert_eq!(
		out["listed"],
		json!({ "status": "off", "addon": EXP, "title": "Polestar Experimental", "author": "Polestar", "tocOnly": true, "shown": false,
			"guides": 0, "loads": 0, "rows": 1 }),
		"listed from its TOC, switched off, nothing of it loaded"
	);
	let n = guide_ids(&p.dir).len();
	assert_eq!(
		out["on"],
		json!({ "status": "on", "tocOnly": false, "guides": n, "count": n, "rows": 1, "loads": 1, "saved": true,
			"fired": "guides, packs polestar-experimental" }),
		"switched on: loaded, registered in place of its TOC's record, every guide shown"
	);
	assert_eq!(out["off"], json!({ "status": "off", "guides": 0, "get": false, "saved": false }), "switched off: hidden, nothing kept");
	assert_eq!(out["again"], json!({ "status": "on", "guides": n, "loads": 1 }), "on again: shown, never loaded twice");
}

#[test]
fn left_on_it_loads_at_login_before_the_saved_tabs_reopen_left_off_its_tab_waits_for_the_switch() {
	let p = pack();
	let first = guide_ids(&p.dir).remove(0);
	let tabs = format!("PolestarCharDB = {{ schema = 1, tabs = {{ \"{first}\" }}, activeTab = 1 }}");
	let script = r#"
local function open() local g = Polestar.Engine.GetGuide(); return g and g.id or false end
local out = { loads = stub.packLoads.Polestar_Experimental or 0, status = G.Pack(ID).status, guide = open() }
if out.loads == 0 then
	G.SetPackShown(ID, true)
	out.switched = { loads = stub.packLoads.Polestar_Experimental or 0, guide = open() }
end
emit(out)"#;
	let on = core(&p.dir, &[("Polestar", format!("{SAVED_ON}\n{tabs}"))], true, script);
	assert_eq!(on, json!({ "loads": 1, "status": "on", "guide": first }), "loaded at login, its saved tab back");
	let off = core(&p.dir, &[("Polestar", tabs.clone())], true, script);
	assert_eq!(
		off,
		json!({ "loads": 0, "status": "off", "guide": false, "switched": { "loads": 1, "guide": first } }),
		"off: not loaded at login, its tab kept for when it comes back"
	);
}

#[test]
fn switched_on_in_a_fight_it_loads_once_the_fight_ends() {
	let p = pack();
	let out = core(
		&p.dir,
		&[],
		true,
		r#"
stub.inCombat = true
G.SetPackShown(ID, true)
local during = { loads = stub.packLoads.Polestar_Experimental or 0, status = G.Pack(ID).status, guides = #G.Pack(ID).guides }
local fired = {}
Polestar.On("PACKS_CHANGED", function(id) fired[#fired + 1] = id end)
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
emit({ during = during, after = { loads = stub.packLoads.Polestar_Experimental or 0, status = G.Pack(ID).status,
	guides = #G.Pack(ID).guides, fired = fired } })"#,
	);
	assert_eq!(out["during"], json!({ "loads": 0, "status": "on", "guides": 0 }));
	assert_eq!(out["after"], json!({ "loads": 1, "status": "on", "guides": guide_ids(&p.dir).len(), "fired": ["polestar-experimental"] }));
}

// The experimental guides are never suggested: not with Polestar's own guides as the source (which have
// nothing for the character), not when the setting names the experimental pack, not at level 1 (FirstGuide);
// Suggest guides from never offers the pack, and a route choice of one of its guides is never offered. A
// community pack in the same place is (the control).
#[test]
fn its_guides_are_never_suggested_never_a_suggestion_source_never_a_route_choice() {
	let p = pack();
	let out = core(
		&p.dir,
		&[],
		false,
		r#"
local function meta(addon, id, title) return { addon = addon, id = id, format = 1, title = title, author = "A", version = "1", license = "MIT" } end
local function guide(def)
	def.title = def.title or def.id
	def.steps = { { goals = { { t = "level", level = 60 } } } }
	assert(Polestar.RegisterGuide(def))
end
assert(Polestar.RegisterPack(meta("Polestar_Guides", "guides", "Polestar Guides")))
guide({ id = "forever/low", pack = "guides", minLevel = 1, maxLevel = 5 })
assert(Polestar.RegisterPack(meta("JoeAddon", "joe", "Joe's Routes")))
stub.login()
G.SetPackShown(ID, true)
local exp = G.Get(G.Pack(ID).guides[1])
-- The character fits the experimental guide: its level and its side.
local w = stub.world
w.level = exp.minLevel or 1
if exp.faction then w.faction = exp.faction end
local lo, hi = exp.minLevel or 1, exp.maxLevel or exp.minLevel or 1
guide({ id = "joe/fits", pack = "joe", minLevel = lo, maxLevel = hi, faction = exp.faction, nextChoices = { "forever/low", "joe/other" } })
guide({ id = "joe/other", pack = "joe", minLevel = lo, maxLevel = hi, faction = exp.faction })
guide({ id = "polestar-experimental/test-choice", pack = ID, minLevel = lo, maxLevel = hi, faction = exp.faction, nextChoices = { "forever/low", "joe/other" } })
local out = { fits = G.GuideMatches(exp, Polestar.Compat.GetPlayerInfo()) }
out.default = { source = G.SuggestSource(), suggestions = G.Suggestions(), first = G.FirstGuide() or false }
Polestar.Set("behavior.suggestFrom", ID)
out.picked = { source = G.SuggestSource(), suggestions = G.Suggestions(), suggest = G.Suggest() or false, first = G.FirstGuide() or false }
out.sources = G.SuggestSources()
local offered = {}
for _, g in ipairs(G.OfferedBy("forever/low")) do offered[#offered + 1] = g.id end
out.offered = offered
Polestar.Set("behavior.suggestFrom", "joe")
out.joe = { source = G.SuggestSource(), suggest = G.Suggest() or false }
emit(out)"#,
	);
	assert_eq!(out["fits"], true, "the character fits the experimental guide");
	assert_eq!(out["default"], json!({ "source": "guides", "suggestions": ["forever/low"], "first": "forever/low" }));
	assert_eq!(
		out["picked"],
		json!({ "source": "guides", "suggestions": ["forever/low"], "suggest": "forever/low", "first": "forever/low" }),
		"the setting naming the experimental pack counts for nothing"
	);
	assert_eq!(out["sources"], json!(["guides", "joe"]), "Suggest guides from never offers it");
	assert_eq!(out["offered"], json!(["joe/fits"]), "its route choices are never offered");
	assert_eq!(out["joe"], json!({ "source": "joe", "suggest": "joe/fits" }), "a community pack in its place is");
}

// No other addon can take the experimental pack's id: one registering it with the game is refused whole (its
// guides dropped), one that loads on demand is never loaded for it, and Polestar_Experimental still loads when
// switched on; an imported guide cannot live under it either.
#[test]
fn no_other_addon_can_take_the_experimental_pack_s_id() {
	let p = pack();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: format!(
			r#"{}
table.insert(stub.addons, {{ name = "Impostor", loaded = true }})
table.insert(stub.addons, {{ name = "LazyImpostor", reason = "DEMAND_LOADED" }})
stub.addonMeta.Impostor = {{ ["X-Polestar-Pack"] = "polestar-experimental", ["X-Polestar-Format"] = "1", Title = "Polestar Community: Impostor" }}
stub.addonMeta.LazyImpostor = {{ ["X-Polestar-Pack"] = "polestar-experimental", ["X-Polestar-Format"] = "1", Title = "Polestar Community: Lazy" }}"#,
			addons(Some(&p.dir))
		),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: r#"
local G, ID = Polestar.Guides, "polestar-experimental"
-- Impostor's files, loading with the game.
local ok, err = Polestar.RegisterPack({ addon = "Impostor", id = ID, format = 1, title = "Impostor", author = "I", version = "1", license = "MIT" })
Polestar.RegisterGuide({ id = "polestar-experimental/fake", pack = ID, title = "Fake", minLevel = 1, maxLevel = 60, steps = { { goals = { { t = "level", level = 60 } } } } })
stub.addonLoaded("Impostor")
stub.login()
local function row(addon)
	for _, r in ipairs(G.Packs()) do
		if r.addon == addon then
			local problems = {}
			for i, p in ipairs(r.problems) do problems[i] = p.message end
			return { status = r.status, problems = table.concat(problems, " | ") }
		end
	end
	return false
end
local out = { ok = ok, err = err, impostor = row("Impostor"), lazy = row("LazyImpostor"), ours = row("Polestar_Experimental"),
	imported = G.OwnsId("imported", "polestar-experimental/riverglades") }
G.SetPackShown(ID, true)
out.on = { ours = row("Polestar_Experimental"), fake = G.Get("polestar-experimental/fake") ~= nil,
	loads = stub.packLoads.Polestar_Experimental or 0, lazyLoaded = stub.addonsLoaded.LazyImpostor or false }
emit(out)"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["ok"], false);
	assert_eq!(out["err"], "Pack id polestar-experimental is reserved for Polestar.");
	assert_eq!(out["impostor"], json!({ "status": "refused", "problems": "Pack id polestar-experimental is reserved for Polestar. 1 guide dropped." }));
	assert_eq!(out["lazy"]["status"], "not-loaded", "never loaded for the reserved id");
	assert_eq!(out["ours"], json!({ "status": "off", "problems": "" }));
	assert_eq!(out["imported"], false);
	assert_eq!(out["on"], json!({ "ours": { "status": "on", "problems": "" }, "fake": false, "loads": 1, "lazyLoaded": false }));
}

// Lint (forge's RESERVED_IDS), the JS tools (tools/lib/pack/format.js) and the runtime (Guides.RESERVED) reserve
// the same pack ids, the experimental pack's among them.
#[test]
fn lint_the_js_tools_and_the_runtime_reserve_the_same_pack_ids() {
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Core/Data.lua", "Core/LuaChunks.lua", "Core/Names.lua", "Core/GuideTexts.lua", "Core/Guides.lua"])],
		script: "local out = {} for k in pairs(Polestar.Guides.RESERVED) do out[#out + 1] = k end table.sort(out) emit(out)".into(),
		..Default::default()
	});
	let ids = |v: &Value| -> Vec<String> { v.as_array().unwrap().iter().map(|s| s.as_str().unwrap().to_string()).collect() };
	let mut forge: Vec<String> = forge_guide::format::RESERVED_IDS.iter().map(|s| s.to_string()).collect();
	forge.sort();
	assert!(forge.iter().any(|i| i == ID));
	assert_eq!(ids(&out[0]), forge, "the runtime's");
	let js = std::fs::read_to_string(root().join("tools/lib/pack/format.js")).unwrap();
	let set = regex::Regex::new(r"const RESERVED_IDS = new Set\(\[([^\]]*)\]\)").unwrap().captures(&js).expect("RESERVED_IDS in format.js")[1].to_string();
	let mut js_ids: Vec<String> = regex::Regex::new(r"'([^']+)'").unwrap().captures_iter(&set).map(|c| c[1].to_string()).collect();
	js_ids.sort();
	assert_eq!(js_ids, forge, "the JS tools'");
}

// Any pack whose addon loads on demand: off until switched on, then loaded; one that can be a suggestion
// source once on; one whose addon the client cannot load says why, with no switch.
#[test]
fn a_community_pack_that_loads_on_demand_is_switched_on_the_same_way_and_one_that_fails_says_why() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: r#"
ADDON_MISSING = "Missing"
stub.addons = { { name = "Polestar", loaded = true }, { name = "LodAddon", reason = "DEMAND_LOADED" }, { name = "GoneAddon", reason = "DEMAND_LOADED" } }
stub.addonMeta.LodAddon = { ["X-Polestar-Pack"] = "lod", ["X-Polestar-Format"] = "1", Title = "Polestar Community: Lod Routes", Author = "Lod", Version = "1.0" }
stub.addonMeta.GoneAddon = { ["X-Polestar-Pack"] = "gone", ["X-Polestar-Format"] = "1", Title = "Gone" }
loads = {}
local load = C_AddOns.LoadAddOn
function C_AddOns.LoadAddOn(name)
	if name == "LodAddon" and not stub.addonsLoaded[name] then
		loads[#loads + 1] = name
		Polestar.RegisterPack({ addon = name, id = "lod", format = 1, title = "Lod Routes", author = "Lod", version = "1.0", license = "MIT" })
		Polestar.RegisterGuide({ id = "lod/a", pack = "lod", title = "Lod A", minLevel = 10, maxLevel = 20, steps = { { goals = { { t = "level", level = 20 } } } } })
		stub.addonLoaded(name)
		return true
	end
	return load(name)
end"#
			.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		login: true,
		script: r#"
local G = Polestar.Guides
local out = { lod = G.Pack("lod").status, title = G.Pack("lod").title, gone = G.Pack("gone").status, loads = #loads }
G.SetPackShown("lod", true)
out.on = { status = G.Pack("lod").status, loads = table.concat(loads, ","), get = G.Get("lod/a") ~= nil, sources = G.SuggestSources() }
G.SetPackShown("gone", true)
local g = G.Pack("gone")
out.failed = { status = g.status, reason = g.reason or false }
emit(out)"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["lod"], "off");
	assert_eq!(out["title"], "Lod Routes");
	assert_eq!(out["gone"], "off");
	assert_eq!(out["loads"], 0);
	assert_eq!(out["on"], json!({ "status": "on", "loads": "LodAddon", "get": true, "sources": ["guides", "lod"] }));
	assert_eq!(out["failed"], json!({ "status": "not-loaded", "reason": "Missing" }));
}

// The Community guides page: the row is there from the TOC, its switch off and no guide count (none is known
// until the pack loads); switching it on loads the pack, the count shows and the guide menu lists its guides
// under its own entry; switching it off takes them out again.
#[test]
fn the_community_guides_switch_loads_it_and_its_guides_appear_and_go_with_the_switch() {
	let p = pack();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_packs.lua"],
		before: addons(Some(&p.dir)),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"])],
		script: r#"
uistub.install()
Polestar.Guides = uistub.realGuides
local G = uistub.realGuides
local ID = "polestar-experimental"
stub.login()
local UI, P, Picker = Polestar.UI, Polestar.UI.Packs, Polestar.UI.Picker
local function rowOf(addon)
	for _, r in ipairs(P.view.rows) do if r:IsShown() and r.psRecord.addon == addon then return r end end
end
local function shownText(fs) return fs:IsShown() and fs:GetText() or false end
local function row()
	local r = rowOf("Polestar_Experimental")
	return { title = r.Title:GetText(), credits = r.Credits:GetText(), switch = r.Switch:IsShown(), checked = r.Switch.checked or false,
		count = shownText(r.Count), status = shownText(r.Status), enable = r.Enable:IsShown() }
end
-- The guide menu's entry for the pack: its guides' ids, sorted, comma-joined.
local function menu()
	local out = {}
	for _, e in ipairs(Picker.Entries("All", "", "pack:" .. ID)) do if e.kind == "guide" then out[#out + 1] = e.guide.id end end
	table.sort(out)
	return table.concat(out, ",")
end
UI.ShowOptions("guidepacks")
local out = { before = row(), menuBefore = menu() }
rowOf("Polestar_Experimental").Switch:Click()
local n = #G.Pack(ID).guides
out.after = row()
out.count = n == 1 and "1 guide" or (n .. " guides")
out.loads = stub.packLoads.Polestar_Experimental or 0
out.menu = menu()
rowOf("Polestar_Experimental").Switch:Click()
out.off = row()
out.menuOff = menu()
emit(out)"#
			.into(),
		..Default::default()
	})
	.remove(0);
	let credits = format!("Polestar  ·  {}  ·  {}", field(&p.dir, "Version"), field(&p.dir, "X-License"));
	assert_eq!(
		out["before"],
		json!({ "title": "Polestar Experimental", "credits": credits, "switch": true, "checked": false, "count": false, "status": false, "enable": false })
	);
	assert_eq!(out["menuBefore"], "");
	assert_eq!(out["loads"], 1);
	assert_eq!(out["after"]["checked"], true);
	assert_eq!(out["after"]["count"], out["count"]);
	let mut ids = guide_ids(&p.dir);
	ids.sort();
	assert_eq!(out["menu"], ids.join(","), "the guide menu lists every guide of it");
	assert_eq!(out["off"]["checked"], false);
	assert_eq!(out["off"]["count"], out["count"], "its guides are known now");
	assert_eq!(out["menuOff"], "");
}

/// The heap a login adds (KiB, Lua 5.1, after two full collects) with the whole of Polestar loaded: with the pack
/// built in `pack` in the AddOns list, switched off as it ships or switched on (`on`), or without it; the whole
/// heap after the login (the stubs' tables included); and how often its files loaded.
fn login_kib(pack: Option<&Path>, on: bool) -> (f64, f64, i64) {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: addons(pack),
		addons: vec![Addon::name("Polestar")],
		saved: if on { vec![("Polestar".into(), SAVED_ON.into())] } else { Vec::new() },
		script: r#"
local function full() collectgarbage("collect"); collectgarbage("collect"); return collectgarbage("count") end
local base = full()
stub.login()
local after = full()
emit({ login = after - base, heap = after, loads = stub.packLoads.Polestar_Experimental or 0 })"#
			.into(),
		..Default::default()
	})
	.remove(0);
	(out["login"].as_f64().unwrap(), out["heap"].as_f64().unwrap(), out["loads"].as_i64().unwrap())
}

/// What having the folder installed and off may add to a login: its scan record (the Community guides page's
/// row) and the entries naming it, whatever its guides. The stub's TOC strings are shared with the test's own
/// tables, so the client also pays for its title, author, version, licence and format strings (about 0.3 KiB).
/// Measured 2026-11-11 (Lua 5.1) with the shipped Riverglades build: +1.11 KiB installed and off.
const INSTALLED_OFF_BUDGET_KIB: f64 = 2.0;

#[test]
fn installed_and_off_it_costs_a_login_only_its_scan_record() {
	let p = pack();
	let measure = |dir: &Path, what: &str| {
		let (absent, heap, a) = login_kib(None, false);
		let (off, _, o) = login_kib(Some(dir), false);
		let (on, _, n) = login_kib(Some(dir), true);
		eprintln!(
			"login heap ({what}): without {EXP} {absent:.2} KiB (whole heap {heap:.0} KiB); installed and off {off:.2} KiB (+{:.2}); switched on {on:.2} KiB (+{:.2})",
			off - absent,
			on - absent
		);
		assert_eq!((a, o, n), (0, 0, 1), "{what}: off, never loaded; on, loaded at login once");
		assert!(off - absent < INSTALLED_OFF_BUDGET_KIB, "{what}: installed and off adds {:.2} KiB to a login (budget {INSTALLED_OFF_BUDGET_KIB})", off - absent);
		assert!(on > off, "{what}: switched on, its guides are in");
	};
	measure(&p.dir, "fixture pack");
	// The checkout's own build too, when it has one.
	let shipped = addons_dir().join(EXP);
	if shipped.join(format!("{EXP}.toc")).exists() {
		measure(&shipped, "addon/Polestar_Experimental");
	}
}
