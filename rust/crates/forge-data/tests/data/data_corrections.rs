//! Corrections without Forever's quest data: applied to whatever the build has; an absent record is
//! created when the correction can stand alone, else reported as unused (rust/tests/golden/data-corrections).

use crate::common;

use forge_data::{run, Options};
use forge_guide::js::{parse_json, stringify, Obj, V};

#[test]
fn corrections_apply_without_questie() {
	let g = common::golden("data");
	let input = g.join("input");
	let here = common::golden("data-corrections");
	let mut o = Options::new(&input);
	o.sources = input.join("sources");
	o.recordings = input.join("recordings");
	o.pfquest = Some(input.join("pfQuest"));
	o.questie = None;
	o.web_xp = false;
	o.web_zones = false;
	o.corrections = here.join("corrections.json");
	o.built_at = "2026-10-22T00:00:00.000Z".into();
	let out = run(&o, &|_| {}).unwrap();
	let file = |name: &str| parse_json(&out.files.iter().find(|(n, _)| n == name).unwrap_or_else(|| panic!("no {name}")).1).unwrap();
	let (quests, npcs, objects, items, meta) = (file("quests"), file("npcs"), file("objects"), file("items"), file("meta"));

	// The rules, stated directly.
	assert_eq!(quests.get("15").get("minLevel").num(), 2.0);
	assert_eq!(quests.get("990001").get("title").as_str(), Some("A Quest Only We Know"));
	assert!(quests.get("990001").get("source").items().iter().any(|s| s.as_str() == Some("polestar-correction")));
	assert!(quests.get("990002").is_undef());
	assert_eq!(npcs.get("990101").get("name").as_str(), Some("Test Quartermaster"));
	assert!(npcs.get("990102").is_undef());
	assert!(objects.get("990201").is_undef());
	assert!(items.get("990301").is_undef());
	let warnings: Vec<V> = meta.get("warnings").items().into_iter().filter(|w| w.to_js_string().starts_with("correction not applied")).collect();
	assert_eq!(warnings.len(), 4, "{warnings:?}");

	// And byte for byte.
	let doc = Obj::new();
	let pick = Obj::new();
	pick.set("quests/15", quests.get("15"));
	pick.set("quests/990001", quests.get("990001"));
	pick.set("npcs/990101", npcs.get("990101"));
	pick.set("items/159", items.get("159"));
	doc.set("records", pick);
	let counts = Obj::new();
	counts.set("corrections", meta.get("counts").get("corrections"));
	counts.set("correctionsCreated", meta.get("counts").get("correctionsCreated"));
	doc.set("counts", counts);
	doc.set("warnings", forge_data::jsv::arr(warnings));
	let mut check = common::Check::new();
	check.file("expected.json", &(stringify(&V::Obj(doc), Some("\t")) + "\n"), &here.join("expected.json"));
	check.finish("data corrections");
}
