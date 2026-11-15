//! The other faction's guides (#2462: a Human Warrior loaded the Horde Warrior's armor chain from the guide menu
//! and was sent to Camp Taurajo). Nothing offers a character a guide of the other faction: the guide menu (no faction
//! filter: Browse, Recent, Favourites, Home), search and Lookup's curated guides list the character's side only. One
//! opened anyway (an import, an old saved tab) says whose it is in the window's banner and the arrow stays off. The
//! whole addon, the stub world, synthetic guides.

use forge_addontest::{emitted, RunAddon};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 1000, right = -4000, top = 1500, bottom = -4000 })
w.addMap(1433, { name = "Redridge Mountains", c = 0, left = -1000, right = -4000, top = -9000, bottom = -11000 })
w.moveTo(1433, 30, 45)
w.zone, w.subzone = "Redridge Mountains", "Lakeshire"
w.race, w.raceName, w.raceID, w.faction = "Human", "Human", 1, "Alliance"
w.class, w.className, w.level = "WARRIOR", "Warrior", 22
"#;

// The two Warrior armor chains, one per faction, as the shipped headers have them (faction, class, Class folder),
// in Polestar's own pack (its Class category; the suggestion source Lookup reads).
const GUIDES: &str = r#"
assert(Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar Guides", author = "Polestar", version = "0.1.0", license = "GPL-3.0" }))
local function armor(id, title, faction, map, x, y, quest, item)
	assert(Polestar.RegisterGuide({ id = id, pack = "guides", title = title, faction = faction, classes = { "WARRIOR" }, category = "Class", folder = "Warrior",
		minLevel = 20, maxLevel = 32, zone = map, zoneName = title, keywords = { "Warrior", "class armor" }, collects = { item }, steps = {
		{ title = "The trainer", goals = { { t = "accept", quest = quest, title = title, npc = 3000 + quest, npcName = "Trainer", map = map, x = x, y = y } } },
	} }))
end
armor("forever/class/warrior/brutal-armor", "Brutal Armor", "Horde", 1413, 45, 58, 1823, 7133)
armor("forever/class/warrior/fire-hardened-armor", "Fire Hardened Armor", "Alliance", 1433, 31, 46, 1698, 6972)
"#;

const HELPERS: &str = r#"
E, w, GF = Polestar.Engine, stub.world, Polestar.UI.GuideFrame
stub.login()
stub.fire("QUEST_LOG_UPDATE")
P = Polestar.UI.Picker
function titles(entries)
	local out = {}
	for _, e in ipairs(entries) do if e.kind == "guide" then out[#out + 1] = e.guide.title end end
	return out
end
function banner()
	local B = GF.parts.banner
	return B:IsShown() and B.Text:GetText() or false
end
"#;

fn run(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec!["Polestar".into()],
		script: [GUIDES, HELPERS, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

// The reporter's path: the guide menu's Class list (its filter on "All", account-wide), then Recently loaded.
#[test]
fn the_guide_menu_lists_the_character_s_own_side_only_whatever_was_saved_and_has_no_faction_filter() {
	let out = run(
		"",
		r#"
		-- A filter saved by an older version (account-wide "All") is gone and changes nothing.
		Polestar.Set("ui.pickerFaction", "All")
		Polestar.UI.ShowPicker()
		local r = { class = titles(P.Entries("", "Class")), all = titles(P.Entries("", "All")), filter = PolestarPicker.factionButtons ~= nil }
		-- Loaded once (an old tab), closed: Recent never offers it again.
		E.SetGuide("forever/class/warrior/brutal-armor"); stub.advance(0.6)
		E.SetGuide("forever/class/warrior/fire-hardened-armor"); stub.advance(0.6)
		P.SetView("recent")
		local recent = {}
		for _, f in ipairs(stub.frames) do
			if f.psGuide and rawget(f, "Range") and f:IsShown() and f:GetParent() == PolestarPicker.Scroll.Child then recent[#recent + 1] = f.psGuide.title end
		end
		table.sort(recent)
		r.recent = recent
		-- A favourite of it (starred while it was listed) is no favourite here.
		Polestar.CharState().ui.favoriteGuides["forever/class/warrior/brutal-armor"] = true
		r.favorites = #titles(P.Entries("", "Favorites"))
		emit(r)"#,
	);
	assert_eq!(out["class"], json!(["Fire Hardened Armor"]));
	assert!(!out["all"].as_array().unwrap().iter().any(|t| t == "Brutal Armor"), "{}", out["all"]);
	assert_eq!(out["filter"], false, "no faction filter in the menu");
	assert_eq!(out["recent"], json!(["Fire Hardened Armor"]));
	assert_eq!(out["favorites"], 0);
}

// Main's check for the report's "naturally selected" All: a fresh character opening the menu straight on Recent or
// Class sees its own side's guides only.
#[test]
fn a_fresh_character_opening_the_menu_on_recent_or_class_sees_no_other_faction_guide() {
	let out = run(
		"",
		r#"
		Polestar.UI.ShowPicker()
		P.SetView("recent")
		local r = { recent = #P.Recent() }
		P.SetView("browse"); P.SetCategory("Class")
		local rows = {}
		for _, f in ipairs(stub.frames) do
			if f.psGuide and rawget(f, "Range") and f:IsShown() and f:GetParent() == PolestarPicker.Scroll.Child then rows[#rows + 1] = f.psGuide.title end
		end
		r.class = rows
		r.subtitle = PolestarPicker.Subtitle:GetText()
		emit(r)"#,
	);
	assert_eq!(out, json!({ "recent": 0, "class": ["Fire Hardened Armor"], "subtitle": "Alliance  \u{b7}  1 guide" }));
}

#[test]
fn search_and_lookup_s_curated_guides_never_offer_the_other_faction_s() {
	let out = run(
		"",
		r#"
		local guides = {}
		for _, r in ipairs(Polestar.Search.Query("armor", { kinds = { guide = true }, subtitles = false })) do
			if r.kind == "guide" then guides[#guides + 1] = r.id end
		end
		emit({ search = guides, horde = Polestar.Lookup.CuratedGuide("item", 7133) or false, alliance = Polestar.Lookup.CuratedGuide("item", 6972) or false })"#,
	);
	assert_eq!(out, json!({ "search": ["forever/class/warrior/fire-hardened-armor"], "horde": false, "alliance": "forever/class/warrior/fire-hardened-armor" }));
}

// Opened anyway: the banner says whose guide it is and the arrow points nowhere; the character's own side's guide
// routes as ever.
#[test]
fn an_other_faction_guide_opened_anyway_says_whose_it_is_and_is_not_routed() {
	let out = run(
		"",
		r#"
		E.SetGuide("forever/class/warrior/brutal-armor"); stub.advance(0.6); GF.Layout()
		local wp = E.GetWaypoint()
		local r = { horde = { side = E.OtherFaction("forever/class/warrior/brutal-armor") or false, wp = wp ~= nil, banner = banner() } }
		E.SetGuide("forever/class/warrior/fire-hardened-armor"); stub.advance(0.6); GF.Layout()
		r.alliance = { side = E.OtherFaction("forever/class/warrior/fire-hardened-armor") or false, wp = E.GetWaypoint() ~= nil, banner = banner() }
		emit(r)"#,
	);
	assert_eq!(
		out["horde"],
		json!({ "side": "Horde", "wp": false, "banner": "This guide is for Horde characters. Polestar won't guide you through it." })
	);
	assert_eq!(out["alliance"], json!({ "side": false, "wp": true, "banner": false }));
}
