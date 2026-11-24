//! Packs whose addon the client loads only on demand (Core/Guides.lua, Own.loadDemand; UI/Packs.lua), and
//! Polestar's own extra pack, the experimental guides, inside Polestar since 0.4.3 (Polestar/Experimental, #3507):
//! shown unless the player switched its guides off (Options, Guide: Show experimental guides,
//! behavior.experimentalGuides; Guides.OWN_EXTRA), so its guides come in at every login (Polestar.DeferGuides;
//! never in a fight: once it ends) and are listed with ours; switched off, its guides hide and stay out, and that
//! choice is kept. It is not a community pack: the Community guides page leaves it out. A community pack that
//! loads on demand stays off until switched on there. The experimental guides are never suggested, never where
//! suggestions come from and never a route choice. Switched off, the pack costs a login only its registration;
//! on, its guides, within a measured budget. Its id is reserved: no other addon or import string can take it.
//!
//! The behaviour is tested on a fixture pack built as `forge guide compile experimental` builds the real one
//! (forge-guide's build_pack_files with the extra pack's id and folder: no TOC, its guides handed to
//! Polestar.DeferGuides), loaded with Polestar's files as its TOC lists the real one's. The checkout's own build,
//! addon/Polestar/Experimental from experimental/, is checked against its sources when the checkout has them.

use forge_addontest::dsl::{self, TestPack};
use forge_addontest::run::{addons_dir, lua_string, root, toc_entries};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};
use std::path::Path;

const ID: &str = "polestar-experimental";
/// The experimental pack's files, in the order Polestar's TOC lists them.
const FILES: [&str; 3] = ["Pack.lua", "MapFrames.lua", "Guides.lua"];

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

/// A field of a built pack's registration (its Pack.lua: `key = "value"`), as Polestar's pack list reads it.
fn field(dir: &Path, key: &str) -> String {
	let text = std::fs::read_to_string(dir.join("Pack.lua")).unwrap_or_else(|e| panic!("{}: {e}", dir.display()));
	let re = regex::Regex::new(&format!(r#"\b{key} = "([^"]*)""#)).unwrap();
	re.captures(&text).map(|c| c[1].to_string()).unwrap_or_else(|| panic!("{}/Pack.lua has no {key}", dir.display()))
}

/// The guide ids a built pack folder registers, in its Guides.lua's order.
fn guide_ids(dir: &Path) -> Vec<String> {
	let text = std::fs::read_to_string(dir.join("Guides.lua")).unwrap();
	let re = regex::Regex::new(r#"\n\t\t\tid = "([^"]+)",\n"#).unwrap();
	re.captures_iter(&text).map(|c| c[1].to_string()).collect()
}

/// The AddOns list: Polestar (its version the pack's, as in one release zip).
fn addons(pack: Option<&Path>) -> String {
	let version = lua_string(&pack.map_or_else(|| "1.0.0".to_string(), |d| field(d, "version")));
	format!("stub.addonMeta.Polestar = {{ Version = {version} }}\nstub.addons = {{ {{ name = \"Polestar\", loaded = true }} }}\n")
}

/// Polestar's files `files` (paths in addon/Polestar), then the experimental pack's built in `pack`, as Polestar's
/// TOC lists the real one's after its own.
fn polestar(files: &[&str], pack: Option<&Path>) -> Addon {
	let mut list: Vec<String> = files.iter().map(|f| f.to_string()).collect();
	if let Some(dir) = pack {
		list.extend(FILES.map(|f| dir.join(f).to_string_lossy().into_owned()));
	}
	Addon::Files("Polestar".into(), list)
}

/// Lua: 1 once the experimental pack's guides came in, else 0 (no pack, or its guides still wait).
const LOADS: &str = r#"function loads() local G = Polestar.Guides; return (G.Pack("polestar-experimental") and not G.Deferred("polestar-experimental")) and 1 or 0 end
"#;

/// The experimental guides switched off by the player (Options, Guide: Show experimental guides), saved. The
/// account has seen the 0.4.3 layout card (UI/LayoutCard.lua): one that has not waits a few seconds after login
/// to show it (+0.86 KiB at login, 2026-11-23, gone once it shows), which is not the folder's cost.
const SAVED_OFF: &str = r#"PolestarDB = { schema = 1, layoutCardSeen = "0.4.3", settings = { behavior = { experimentalGuides = false } } }"#;
/// Before 0.4.0: switched on, or switched off, on the Community guides page.
const LEGACY_ON: &str = r#"PolestarDB = { schema = 1, packs = { ["polestar-experimental"] = { on = true } } }"#;
const LEGACY_OFF: &str = r#"PolestarDB = { schema = 1, packs = { ["polestar-experimental"] = { off = true } } }"#;

/// The core with the pack built in `dir` inside it, logged in unless `script` logs in itself.
fn core(dir: &Path, saved: &[(&str, String)], login: bool, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: addons(Some(dir)),
		addons: vec![polestar(&["Core/Core.xml"], Some(dir))],
		saved: saved.iter().map(|(a, lua)| (a.to_string(), lua.clone())).collect(),
		login,
		script: format!("G = Polestar.Guides\nID = \"{ID}\"\n{LOADS}{script}"),
	})
	.remove(0)
}

#[test]
fn the_extra_pack_builds_inside_polestar_and_hands_its_guides_over_on_demand() {
	let p = pack();
	assert!(!p.dir.join("Polestar_Experimental.toc").exists(), "no TOC: Polestar's lists its files");
	let f = |k: &str| field(&p.dir, k);
	assert_eq!(f("title"), "Polestar Experimental", "Polestar's own title, no \"Polestar Community: \"");
	assert_eq!(f("author"), "Polestar");
	assert_eq!(f("version"), "1.0.0", "pack.json's version");
	assert_eq!(f("id"), ID);
	let guides = std::fs::read_to_string(p.dir.join("Guides.lua")).unwrap();
	assert!(guides.contains("\nPolestar.DeferGuides(\"polestar-experimental\", function()\n") && guides.ends_with("\nend)\n"), "its guides come in on demand");
	assert_eq!(guide_ids(&p.dir), ["polestar-experimental/elwynn-1", "polestar-experimental/elwynn-2"]);
}

// The checkout's own experimental pack, when it has one (experimental/ with its pack.json): its build in
// addon/Polestar/Experimental (`forge guide compile experimental`, or `forge release pack`) is there, listed by
// Polestar's TOC, is Polestar's, carries experimental/pack.json's version and registers exactly the guides
// experimental/'s .guide files give. Without experimental/pack.json no build may be left behind.
#[test]
fn the_checkout_s_experimental_build_matches_experimental() {
	let src = root().join("experimental");
	let build = addons_dir().join("Polestar/Experimental");
	let listed: Vec<String> = toc_entries(&addons_dir().join("Polestar")).unwrap().into_iter().filter(|l| l.starts_with("Experimental\\")).collect();
	if !src.join("pack.json").exists() {
		assert!(!build.exists() && listed.is_empty(), "addon/Polestar/Experimental is left without experimental/pack.json");
		return;
	}
	assert_eq!(listed, FILES.map(|f| format!("Experimental\\{f}")), "Polestar's TOC lists the experimental pack's files");
	assert!(build.join("Pack.lua").exists(), "experimental/ is not built: run `forge guide compile experimental`");
	let manifest: Value = serde_json::from_str(&std::fs::read_to_string(src.join("pack.json")).unwrap()).unwrap();
	let f = |k: &str| field(&build, k);
	assert_eq!((f("author"), f("id")), ("Polestar".into(), ID.into()));
	assert_eq!(f("version"), manifest["version"].as_str().unwrap(), "built from experimental/pack.json's version");
	let mut built = guide_ids(&build);
	built.sort();
	let mut sources: Vec<String> = forge_guide::project::find_guide_files(&src, false)
		.iter()
		.filter_map(|rel| std::fs::read_to_string(src.join(rel)).ok()?.lines().find_map(|l| l.trim().strip_prefix("guide ").map(|id| id.trim().to_string())))
		.collect();
	sources.sort();
	assert_eq!(built, sources, "addon/Polestar/Experimental registers the guides experimental/ gives: rebuild it with `forge guide compile experimental`");
}

#[test]
fn on_by_default_loaded_at_login_its_guides_shown_and_hidden_with_the_setting() {
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
	shown = G.PackShown(ID), guides = #mine(), count = r.guideCount, loads = loads(), rows = rows(),
	setting = Polestar.Get("behavior.experimentalGuides") } }
local fired = {}
Polestar.On("GUIDES_REGISTERED", function() fired[#fired + 1] = "guides" end)
Polestar.On("PACKS_CHANGED", function(id) fired[#fired + 1] = "packs " .. tostring(id) end)
local first = mine()[1]
G.SetPackShown(ID, false)
out.off = { status = G.Pack(ID).status, guides = #mine(), get = G.Get(first) ~= nil, saved = Polestar.GetStored("behavior.experimentalGuides"),
	fired = table.concat(fired, ", ") }
fired = {}
Polestar.Set("behavior.experimentalGuides", true)
out.again = { status = G.Pack(ID).status, guides = #mine(), loads = loads(), saved = Polestar.GetStored("behavior.experimentalGuides") or false,
	fired = table.concat(fired, ", ") }
emit(out)"#,
	);
	let n = guide_ids(&p.dir).len();
	assert_eq!(
		out["listed"],
		json!({ "status": "on", "addon": "Polestar", "title": "Polestar Experimental", "author": "Polestar", "tocOnly": false, "shown": true,
			"guides": n, "count": n, "loads": 1, "rows": 0, "setting": true }),
		"no saved choice: shown, its guides in at login; not on the Community guides page"
	);
	assert_eq!(out["off"], json!({ "status": "off", "guides": 0, "get": false, "saved": false, "fired": "packs polestar-experimental" }), "switched off: hidden, and the choice saved");
	assert_eq!(
		out["again"],
		json!({ "status": "on", "guides": n, "loads": 1, "saved": false, "fired": "packs polestar-experimental" }),
		"the Options toggle on again: shown, never brought in twice, back at the default"
	);
}

#[test]
fn shown_it_loads_at_login_before_the_saved_tabs_reopen_switched_off_its_tab_waits_and_the_choice_is_kept() {
	let p = pack();
	let first = guide_ids(&p.dir).remove(0);
	let tabs = format!("PolestarCharDB = {{ schema = 1, tabs = {{ \"{first}\" }}, activeTab = 1 }}");
	let script = r#"
local function open() local g = Polestar.Engine.GetGuide(); return g and g.id or false end
local out = { loads = loads(), status = G.Pack(ID).status, guide = open(),
	setting = Polestar.Get("behavior.experimentalGuides"), legacy = PolestarDB.packs and PolestarDB.packs[ID] ~= nil or false }
if out.loads == 0 then
	G.SetPackShown(ID, true)
	out.switched = { loads = loads(), guide = open() }
end
emit(out)"#;
	let shown = json!({ "loads": 1, "status": "on", "guide": first, "setting": true, "legacy": false });
	let kept_off = json!({ "loads": 0, "status": "off", "guide": false, "setting": false, "legacy": false, "switched": { "loads": 1, "guide": first } });
	let default = core(&p.dir, &[("Polestar", tabs.clone())], true, script);
	assert_eq!(default, shown, "a new install, no saved choice: its guides in at login, its saved tab back");
	let off = core(&p.dir, &[("Polestar", format!("{SAVED_OFF}\n{tabs}"))], true, script);
	assert_eq!(off, kept_off, "switched off: not in at login, its tab kept for when it comes back");
	let on = core(&p.dir, &[("Polestar", format!("{LEGACY_ON}\n{tabs}"))], true, script);
	assert_eq!(on, shown, "switched on before 0.4.0: on, the old entry gone");
	let off = core(&p.dir, &[("Polestar", format!("{LEGACY_OFF}\n{tabs}"))], true, script);
	assert_eq!(off, kept_off, "an explicit off saved before 0.4.0 stays off, as the setting");
}

#[test]
fn switched_on_in_a_fight_its_guides_come_in_once_the_fight_ends() {
	let p = pack();
	let out = core(
		&p.dir,
		&[("Polestar", SAVED_OFF.to_string())],
		true,
		r#"
stub.inCombat = true
G.SetPackShown(ID, true)
local during = { loads = loads(), status = G.Pack(ID).status, guides = #G.Pack(ID).guides }
local fired = {}
Polestar.On("PACKS_CHANGED", function(id) fired[#fired + 1] = id end)
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
emit({ during = during, after = { loads = loads(), status = G.Pack(ID).status,
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
// guides dropped), one that loads on demand is never loaded for it, and ours still comes in when switched on;
// an imported guide cannot live under it either.
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
		addons: vec![polestar(&["Core/Core.xml"], Some(&p.dir))],
		script: r#"
{LOADS}local G, ID = Polestar.Guides, "polestar-experimental"
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
local function ours()
	local r = G.Pack(ID)
	return r and r.addon == "Polestar" and { status = r.status, problems = #r.problems } or false
end
local out = { ok = ok, err = err, impostor = row("Impostor"), lazy = row("LazyImpostor"), listed = row("Polestar"), ours = ours(),
	loads = loads(), imported = G.OwnsId("imported", "polestar-experimental/riverglades") }
G.SetPackShown(ID, true)
out.on = { ours = ours(), fake = G.Get("polestar-experimental/fake") ~= nil,
	loads = loads(), lazyLoaded = stub.addonsLoaded.LazyImpostor or false }
emit(out)"#
			.replace("{LOADS}", LOADS),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["ok"], false);
	assert_eq!(out["err"], "Pack id polestar-experimental is reserved for Polestar.");
	assert_eq!(out["impostor"], json!({ "status": "refused", "problems": "Pack id polestar-experimental is reserved for Polestar. 1 guide dropped." }));
	assert_eq!(out["lazy"]["status"], "not-loaded", "never loaded for the reserved id");
	assert_eq!(out["listed"], false, "ours is not on the Community guides page");
	assert_eq!((out["ours"].clone(), out["loads"].clone()), (json!({ "status": "on", "problems": 0 }), json!(1)), "ours comes in at login, as it is on by default");
	assert_eq!(out["imported"], false);
	assert_eq!(out["on"], json!({ "ours": { "status": "on", "problems": 0 }, "fake": false, "loads": 1, "lazyLoaded": false }));
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

// Not a community pack: the Community guides page has no row for it; the guide menu lists its guides with ours,
// under Leveling in their faction's band (no "Community guides" entry), counted there, each "By Polestar ·
// Experimental"; Options' Show experimental guides takes them out and brings them back.
#[test]
fn the_community_guides_page_leaves_it_out_and_the_guide_menu_lists_its_guides_under_leveling() {
	let p = pack();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_packs.lua"],
		before: addons(Some(&p.dir)),
		addons: vec![polestar(&["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"], Some(&p.dir))],
		script: r#"
{LOADS}uistub.install()
Polestar.Guides = uistub.realGuides
local G = uistub.realGuides
local ID = "polestar-experimental"
stub.login()
local UI, P, Picker = Polestar.UI, Polestar.UI.Packs, Polestar.UI.Picker
local function rowOf(addon)
	for _, r in ipairs(P.view.rows) do if r:IsShown() and r.psRecord.addon == addon then return r end end
	return false
end
-- The guide menu's experimental guides under `cat`, sorted, comma-joined, each with its folder.
local function menu(cat)
	local out = {}
	for _, e in ipairs(Picker.Entries("", cat)) do
		if e.kind == "guide" and G.IsExperimental(e.guide) then out[#out + 1] = e.guide.id .. "@" .. e.folder.id end
	end
	table.sort(out)
	return table.concat(out, ",")
end
UI.ShowOptions("guidepacks")
local _, _, counts = Picker.Entries("", "All")
local first = G.Pack(ID).guides[1]
local out = { row = rowOf("Polestar") ~= false, loads = loads(), leveling = menu("Leveling"),
	packEntry = menu("pack:" .. ID), countLeveling = counts.Leveling or 0, countPack = counts["pack:" .. ID] or 0,
	credits = Picker.Credits(G.Get(first)) or false, packOf = Picker.PackOf(G.Get(first)) ~= nil }
Polestar.Set("behavior.experimentalGuides", false)
out.off = menu("Leveling")
Polestar.Set("behavior.experimentalGuides", true)
out.on = menu("Leveling")
emit(out)"#
			.replace("{LOADS}", LOADS),
		..Default::default()
	})
	.remove(0);
	let mut ids: Vec<String> = guide_ids(&p.dir).iter().map(|id| format!("{id}@Leveling/Alliance/1")).collect();
	ids.sort();
	let listed = ids.join(",");
	assert_eq!(out["row"], false, "no row on the Community guides page");
	assert_eq!(out["loads"], 1);
	assert_eq!(out["leveling"], listed, "under Leveling, in the Alliance's 1-30 band (the fixture's 10-20 guides)");
	assert_eq!((out["packEntry"].clone(), out["countPack"].clone()), (json!(""), json!(0)), "no entry of its own");
	assert_eq!(out["countLeveling"], json!(ids.len()), "counted in Leveling");
	assert_eq!(out["credits"], "By Polestar  ·  Experimental");
	assert_eq!(out["packOf"], false, "no pack line in the details");
	assert_eq!(out["off"], "", "switched off: out of the menu");
	assert_eq!(out["on"], listed, "and back");
}

/// The heap a login adds (KiB, Lua 5.1, after two full collects) with the whole of Polestar loaded: with the
/// experimental pack built in `pack` inside it (in place of the checkout's), shown as it ships or switched off
/// (`saved`), or without one; the whole heap after the login (the stubs' tables included); and whether its guides
/// came in.
fn login_kib(pack: Option<&Path>, saved: Option<&str>) -> (f64, f64, i64) {
	let own: Vec<String> = toc_entries(&addons_dir().join("Polestar")).unwrap().into_iter().filter(|l| !l.starts_with("Experimental\\")).collect();
	let own: Vec<&str> = own.iter().map(String::as_str).collect();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: addons(pack),
		addons: vec![polestar(&own, pack)],
		saved: saved.map(|s| vec![("Polestar".into(), s.into())]).unwrap_or_default(),
		script: format!(
			r#"{LOADS}
local function full() collectgarbage("collect"); collectgarbage("collect"); return collectgarbage("count") end
local base = full()
stub.login()
local after = full()
emit({{ login = after - base, heap = after, loads = loads() }})"#
		),
		..Default::default()
	})
	.remove(0);
	(out["login"].as_f64().unwrap(), out["heap"].as_f64().unwrap(), out["loads"].as_i64().unwrap())
}

/// What having the pack in Polestar and switched off may add to a login: its registration and the entries naming
/// it, whatever its guides. Measured 2026-11-11 (Lua 5.1) with the shipped Riverglades build, then in its own
/// folder: +1.11 KiB installed and off.
const INSTALLED_OFF_BUDGET_KIB: f64 = 2.0;

/// What the shipped experimental guides add to a login now that they are on by default (0.4.0: listed with our
/// guides, so loaded at login): measured 2026-11-15 (Lua 5.1) with Riverglades (Alliance and Horde), Shen'dralas
/// and Mount Hyjal, +2237.9 KiB; compiled on the QuestieDB 1.1.1 data the same day, +2351.1 KiB (size budgets may
/// grow for 0.4.0, Fitz). The budget is the last figure plus about 5 %.
const ON_MEASURED_KIB: f64 = 2351.1;
const ON_BUDGET_KIB: f64 = ON_MEASURED_KIB * 1.05;

#[test]
fn switched_off_it_costs_a_login_only_its_registration_and_on_its_guides_within_budget() {
	let p = pack();
	let measure = |dir: &Path, what: &str| -> f64 {
		let (absent, heap, a) = login_kib(None, None);
		let (off, _, o) = login_kib(Some(dir), Some(SAVED_OFF));
		let (on, _, n) = login_kib(Some(dir), None);
		eprintln!(
			"login heap ({what}): without the experimental pack {absent:.2} KiB (whole heap {heap:.0} KiB); switched off {off:.2} KiB (+{:.2}); on, as it ships, {on:.2} KiB (+{:.2})",
			off - absent,
			on - absent
		);
		assert_eq!((a, o, n), (0, 0, 1), "{what}: switched off, its guides never come in; on, at login once");
		assert!(off - absent < INSTALLED_OFF_BUDGET_KIB, "{what}: in Polestar and switched off adds {:.2} KiB to a login (budget {INSTALLED_OFF_BUDGET_KIB})", off - absent);
		assert!(on > off, "{what}: on, its guides are in");
		on - absent
	};
	measure(&p.dir, "fixture pack");
	// The checkout's own build too, when it has guides (0.4.3 ships it with none, only the retired ids): on by
	// default, within its budget.
	let shipped = addons_dir().join("Polestar/Experimental");
	if shipped.join("Pack.lua").exists() && !guide_ids(&shipped).is_empty() {
		let cost = measure(&shipped, "addon/Polestar/Experimental");
		assert!(cost <= ON_BUDGET_KIB, "the experimental guides add {cost:.1} KiB to a login (budget {ON_BUDGET_KIB:.1}: measured {ON_MEASURED_KIB} + 5 %)");
	} else {
		eprintln!("addon/Polestar/Experimental has no guides: only the fixture pack measured");
	}
}
