//! Quest names in quote marks (#1368, Havi's suggestion): a quest named in running text reads in the client's
//! own marks (ns.Quoted, the translation of "quote marks: “%s”"): the step's goal lines, a goal's "for
//! <quest>" detail and the arrow's label. NPC and item names stay as they are, and a name that holds quote
//! marks of its own is not quoted again. Real Core, Theme and Nav manifests on the stub world, an English and a
//! German client.

use forge_addontest::{emitted, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::Value;

fn addon() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml"])
}

const WORLD: &str = r#"
function GetLocale() return "__LOCALE__" end
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
"#;

// One step: take A Threat Within from Deputy Willem (the arrow's goal), kill Kobold Vermin for Kobold Camp
// Cleanup, hand in Wanted: "Hogger" (its name already quoted).
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/quoted", pack = "test", title = "Quoted", minLevel = 1, maxLevel = 6,
	steps = {
		{ title = "Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
			{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, title = "Kobold Camp Cleanup", map = 1429, x = 47.6, y = 35.1 },
			{ t = "turnin", quest = 176, title = 'Wanted: "Hogger"', npc = 240, npcName = "Marshal Dughan", map = 1429, x = 42.1, y = 65.9 },
		} },
		{ title = "End", goals = { { t = "level", level = 6 } } },
	},
})
"#;

const SCRIPT: &str = r#"
local E = Polestar.Engine
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
local v = E.GetStepView(1)
local wp = E.GetWaypoint()
stub.advance(0.5)
emit({
	accept = v.goals[1].text, kill = v.goals[2].text, killFor = v.goals[2].detail, hogger = v.goals[3].text,
	subject = v.goals[1].subject, npc = v.goals[2].subject,
	waypoint = wp and wp.label or false, arrow = Polestar.Nav.arrow.labelText:GetText() or false,
})
"#;

fn run(locale: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.replace("__LOCALE__", locale),
		addons: vec![addon()],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/quoted" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, SCRIPT].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn t_1368_an_english_client_quotes_the_quest_in_the_step_line_its_for_detail_and_the_arrow_label() {
	let out = run("enUS");
	assert_eq!(text(&out["accept"]), "Accept \u{201c}A Threat Within\u{201d}");
	assert_eq!(text(&out["killFor"]), "for \u{201c}Kobold Camp Cleanup\u{201d}");
	assert_eq!(text(&out["kill"]), "Kill Kobold Vermin", "an NPC's name stays bare");
	assert_eq!(text(&out["hogger"]), "Turn in Wanted: \"Hogger\"", "a name with quote marks of its own is not quoted again");
	assert_eq!(text(&out["subject"]), "A Threat Within", "the view's subject stays the bare name (the class card's title, comparisons)");
	assert_eq!(text(&out["waypoint"]), "Accept \u{201c}A Threat Within\u{201d}", "the waypoint the arrow and TomTom get");
	assert_eq!(text(&out["arrow"]), "Accept \u{201c}A Threat Within\u{201d}", "the arrow's label");
}

#[test]
fn t_1368_a_german_client_quotes_the_quest_in_german_marks() {
	let out = run("deDE");
	let quoted = "\u{201e}A Threat Within\u{201c}";
	for key in ["accept", "waypoint", "arrow"] {
		let t = text(&out[key]);
		assert!(t.ends_with(&format!(" {quoted}")), "{key}: {t} ends with {quoted}");
		assert!(!t.starts_with("Accept"), "{key}: {t} reads in German");
	}
	let kill_for = text(&out["killFor"]);
	assert!(kill_for.ends_with(" \u{201e}Kobold Camp Cleanup\u{201c}"), "{kill_for}");
	assert!(!kill_for.contains('\u{201d}'), "no English closing mark: {kill_for}");
	assert!(text(&out["hogger"]).ends_with(" Wanted: \"Hogger\""), "{}", text(&out["hogger"]));
	assert!(text(&out["kill"]).contains("Kobold Vermin") && !text(&out["kill"]).contains('\u{201e}'), "an NPC's name stays bare");
}

#[test]
fn t_1368_each_client_language_has_its_own_quote_marks_and_names_with_marks_of_their_own_keep_them() {
	let cases = [
		("enUS", "\u{201c}X\u{201d}"),
		("deDE", "\u{201e}X\u{201c}"),
		("frFR", "\u{ab}\u{a0}X\u{a0}\u{bb}"),
		("esES", "\u{ab}X\u{bb}"),
		("esMX", "\u{201c}X\u{201d}"),
		("ptBR", "\u{201c}X\u{201d}"),
		("ruRU", "\u{ab}X\u{bb}"),
		("koKR", "\u{2018}X\u{2019}"),
		("zhCN", "\u{201c}X\u{201d}"),
		("zhTW", "\u{300c}X\u{300d}"),
	];
	for (locale, want) in cases {
		let out = emitted(&RunAddon {
			stubs: vec!["stub_world.lua"],
			before: format!("function GetLocale() return \"{locale}\" end"),
			addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
			script: r#"emit({ Polestar.Quoted("X"), Polestar.Quoted('Sie nennen mich "den Schleifer"'), Polestar.Quoted("\194\171Vieux\194\187"), Polestar.Quoted("100%"), Polestar.Quoted(""), Polestar.Quoted(nil) == nil })"#.into(),
			..Default::default()
		})
		.remove(0);
		assert_eq!(text(&out[0]), want, "{locale}");
		assert_eq!(text(&out[1]), "Sie nennen mich \"den Schleifer\"", "{locale}: already quoted");
		assert_eq!(text(&out[2]), "\u{ab}Vieux\u{bb}", "{locale}: guillemets of its own");
		assert!(text(&out[3]).contains("100%"), "{locale}: a % in the name is no pattern");
		assert_eq!(text(&out[4]), "", "{locale}: an empty name stays empty");
		assert_eq!(out[5], Value::Bool(true), "{locale}: nil stays nil");
	}
}
