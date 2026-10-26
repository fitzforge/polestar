//! A pinned goal whose item's droppers have no known drop chance (the data's `null`) gets the other
//! places the droppers at its point spawn (Stolen Books from Northshire's kobolds), not the places of
//! droppers far from it (the Savannah Lion Hide's Matriarchs by Ratchet, #273).

use forge_guide::data::Data;
use forge_guide::diag::Diagnostics;
use forge_guide::js::V;
use forge_guide::project::{resolve_sources, Source};
use rustc_hash::FxHashMap;

fn data(chance: &str) -> Data {
	let mut t: FxHashMap<String, String> = FxHashMap::default();
	t.insert("zones".into(), r#"{"1429":{"id":1429,"name":"Elwynn Forest","areaId":12,"type":3}}"#.into());
	t.insert("map-frames".into(), r#"{"era":{"1429":{"c":0,"left":1535.417,"right":-1935.417,"top":-7939.583,"bottom":-10254.166}}}"#.into());
	t.insert(
		"quests".into(),
		r#"{"5":{"id":5,"title":"Books","level":2,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[{"type":"item","id":99,"count":8}]}}"#.into(),
	);
	t.insert(
		"npcs".into(),
		r#"{"6":{"id":6,"name":"Vermin","level":1,"spawns":{"1429":{"f":"e","pts":[[46.9,35.7],[47.6,36.4],[48.1,37.0]]}}},
		"80":{"id":80,"name":"Laborer","level":2,"spawns":{"1429":{"f":"e","pts":[[47.4,30.1],[47.8,31.6]]}}},
		"82":{"id":82,"name":"Far One","level":2,"spawns":{"1429":{"f":"e","pts":[[20.0,80.0],[20.5,80.5]]}}}}"#
			.into(),
	);
	t.insert("objects".into(), "{}".into());
	t.insert("items".into(), format!(r#"{{"99":{{"id":99,"name":"Book","drops":{{"npc":{{"6":{chance},"80":{chance},"82":{chance}}},"object":{{}}}},"questItem":true}}}}"#));
	t.insert("meta".into(), "{}".into());
	Data::from_texts(&t, V::Null, V::Null, None).unwrap()
}

/// The compiled spots of the guide's one collect, pinned at the first vermin.
fn spots(d: &Data, pin: &str) -> Vec<V> {
	let text = format!("guide forever/t\ntitle T\nfaction Alliance\nlevels 1-5\nzone Elwynn Forest\n\nstep A\n  accept 5 \"Books\"\n  collect 99 quest 5{pin}\n  turnin 5\n");
	let src = Source { source: "t.guide".into(), file: "t.guide".into(), text };
	let g = &resolve_sources(&[src], d, &mut Diagnostics::new(), Some("guides"), None)[0];
	let goal = g.get("steps").items()[0].get("goals").items().into_iter().find(|x| x.get("t").as_str() == Some("collect")).unwrap();
	goal.get("spots").items()
}

#[test]
fn a_pinned_goal_shows_the_other_places_its_unknown_chance_sources_spawn() {
	let d = data("null");
	// Unpinned, the compiler finds the kobolds' camps already.
	assert!(spots(&d, "").len() >= 2);
	// Pinned: the pin's camp first, the other camp as an alternative.
	let s = spots(&d, " @46.9,35.7");
	assert!(s.len() >= 2, "{s:?}");
	assert!(!s[0].get("alt").truthy() && s[1..].iter().all(|x| x.get("alt").truthy()), "{s:?}");
	// The dropper far from the pin is not marked.
	assert!(s.iter().all(|x| x.get("x").num() > 40.0), "{s:?}");
}
