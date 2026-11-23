//! `data build` (release pipeline, no QuestieDB, web XP or web zone lists) against the JavaScript's output on
//! the committed slice: rust/tests/golden/data (README there).

use crate::common;

use forge_data::{run, Options};

fn build(input: &std::path::Path) -> forge_data::Output {
	let mut o = Options::new(input);
	o.sources = input.join("sources");
	o.recordings = input.join("recordings");
	o.pfquest = Some(input.join("pfQuest"));
	o.questie = None;
	o.forever = true;
	o.web_xp = false;
	o.web_zones = false;
	o.built_at = "2026-10-22T00:00:00.000Z".into();
	run(&o, &|_| {}).unwrap()
}

#[test]
fn data_build_matches_golden() {
	let g = common::golden("data");
	let input = g.join("input");
	let out = build(&input);
	let want = g.join("expected");
	let mut check = common::Check::new();
	let mut names = Vec::new();
	for (name, text) in &out.files {
		let file = format!("{name}.json");
		check.file(&file, &common::unroot(text, &input), &want.join(&file));
		names.push(file);
	}
	check.all_of(&want, &names);
	check.finish("data build");
}

// #1526 (Nearby's Mailbox found none in Stormwind): every mailbox of the release data had no side, so
// Nearby, which shows only your side's mailboxes, dropped them all. pfQuest gives each its side (`fac`).
#[test]
fn mailboxes_carry_pfquest_s_side() {
	let out = build(&common::golden("data").join("input"));
	let objects = &out.files.iter().find(|(n, _)| n == "objects").unwrap().1;
	let o: serde_json::Value = serde_json::from_str(objects).unwrap();
	let side = |id: &str| (o[id]["roles"].clone(), o[id]["faction"].clone());
	assert_eq!(side("142075"), (serde_json::json!(["mailbox"]), serde_json::json!("A")), "Stormwind's");
	assert_eq!(side("143981"), (serde_json::json!(["mailbox"]), serde_json::json!("H")));
}

// The neutral towns' mailboxes (Booty Bay, Gadgetzan, ...) have no `fac` in pfQuest; their side is the
// one pfQuest's mailbox list gives (AH). A `fac` wins; an object off that list gets no side.
#[test]
fn a_mailbox_without_fac_takes_the_side_of_pfquest_s_mailbox_list() {
	use forge_data::pfquest::{IdMap, Raw};
	use forge_guide::js::{parse_json, V};
	let ids = |pairs: &[(i64, V)]| pairs.iter().cloned().collect::<IdMap>();
	let row = |fac: &str| parse_json(&format!(r#"{{ "coords": [[50, 50, 12, 900]]{fac} }}"#)).unwrap();
	let raw = Raw {
		quests: IdMap::new(),
		units: IdMap::new(),
		objects: ids(&[(1, row("")), (2, row(r#", "fac": "A""#)), (3, row(""))]),
		items: Default::default(),
		refloot: Default::default(),
		areatrigger: IdMap::new(),
		meta: [("mailbox".to_string(), ids(&[(-1, V::str("AH")), (-2, V::str("H"))]))].into_iter().collect(),
		loc_quests: IdMap::new(),
		loc_units: IdMap::new(),
		loc_objects: ids(&[(1, V::str("Mailbox")), (2, V::str("Mailbox")), (3, V::str("Crate"))]),
		loc_items: IdMap::new(),
	};
	let n = forge_data::normalize::normalize(&raw, &|_| Some(1429), forge_data::spawns::DEFAULTS);
	let side = |id: &str| n.objects.get(id).get("faction");
	assert_eq!((side("1").as_str(), side("2").as_str(), side("3").is_nullish()), (Some("AH"), Some("A"), true));
}
