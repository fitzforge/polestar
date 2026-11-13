//! An experimental guide offered by a route choice of ours (docs/PACK_FORMAT.md, "Polestar's own extra packs";
//! docs/GUIDE_FORMAT.md, `next`): our guides compile without Polestar's experimental pack, the pack's `next`
//! targets are checked where it is read (project.rs experimental_index: an unknown id, another faction's guide,
//! or the default line), and Polestar_Guides' Guides.lua carries the index the route choice reads while the pack
//! is off: each offered guide's header and its route until it rejoins ours. A compile with the offer and one
//! without it write the same files but for the offering guide's `nextChoices` line and the index. Fixture data:
//! tests/fixtures/dsl/data.

use crate::common;
use common::*;
use forge_guide::js::V;
use serde_json::{json, Value};

/// A guide of ours (`forever/alliance/<id>`), Alliance, with `head` lines after its header.
fn ours(id: &str, levels: &str, head: &[&str], body: &[&str]) -> String {
	let mut l = vec![format!("guide forever/alliance/{id}"), format!("title {id}"), "faction Alliance".into(), format!("levels {levels}"), "zone Elwynn Forest".into()];
	l.extend(head.iter().map(|s| s.to_string()));
	l.push(String::new());
	l.extend(body.iter().map(|s| s.to_string()));
	format!("{}\n", l.join("\n"))
}

/// The main guide offering `offer` (its `next` lines `nexts`), the default option and the guide after it.
fn our_files(nexts: &[&str]) -> Vec<(String, String)> {
	let head: Vec<String> = nexts.iter().map(|n| format!("next {n}")).collect();
	let head: Vec<&str> = head.iter().map(String::as_str).collect();
	vec![
		("main.guide".into(), ours("t-main", "10-20", &head, &["step One", "  accept 783", "step Two", "  turnin 783"])),
		("default.guide".into(), ours("t-default", "10-20", &["next forever/alliance/t-after", "pitch The usual route."], &["step One", "  accept 7", "step Two", "  turnin 7"])),
		("after.guide".into(), ours("t-after", "20-30", &[], &["step One", "  accept 33"])),
	]
}

/// The experimental pack's guides: exp-1 (Stranglethorn Vale, in through Elwynn Forest) goes on to exp-2, which
/// rejoins ours at t-after (with a dungeon run, and a step for those who skip it); exp-horde is the Horde's.
fn exp_files() -> Vec<(String, String)> {
	vec![
		(
			"exp-1.guide".into(),
			"guide polestar-experimental/exp-1\ntitle Experimental 1\nfaction Alliance\nlevels 10-15\nzone Stranglethorn Vale\nnext polestar-experimental/exp-2\npitch A new zone south of Elwynn Forest.\npro Fresh quests\ncon Experimental\n\nstep Through Elwynn\n  zone Elwynn Forest\n  goto 47.6,35.1 \"Kobold camp\"\n\nstep The camp\n  zone Stranglethorn Vale\n  goto 30.0,30.0 \"Camp\"\n  accept 783\n".into(),
		),
		("exp-2.guide".into(), "guide polestar-experimental/exp-2\ntitle Experimental 2\nfaction Alliance\nlevels 15-22\nzone Stranglethorn Vale\nnext forever/alliance/t-after\n\nstep Two\n  accept 7\n  accept 783\n\nstep The run\n  when dungeon \"Ragefire Chasm\"\n  accept 5261\n\nstep Without the run\n  when !dungeon \"Ragefire Chasm\"\n  accept 179\n".into()),
		("exp-horde.guide".into(), "guide polestar-experimental/exp-horde\ntitle Experimental Horde\nfaction Horde\nlevels 10-15\nzone Durotar\npitch The Horde's.\n\nstep One\n  goto 50.0,50.0 \"Camp\"\n".into()),
	]
}

fn compile_ours(files: &[(String, String)]) -> Compiled {
	let refs: Vec<(&str, &str)> = files.iter().map(|(a, b)| (a.as_str(), b.as_str())).collect();
	compile_files(&refs, &fixture_data(), Some("guides"))
}

fn compile_exp() -> Compiled {
	let files = exp_files();
	let refs: Vec<(&str, &str)> = files.iter().map(|(a, b)| (a.as_str(), b.as_str())).collect();
	compile_files(&refs, &fixture_data(), Some("polestar-experimental"))
}

/// experimental_index of `ours` against the fixture experimental pack -> (entries as JSON, errors).
fn index(ours: &Compiled) -> (Vec<V>, Vec<String>) {
	// Compiled alone here, the pack does not know our guides it hands back to (its lint reads them as context).
	let exp = compile_exp();
	assert_eq!(exp.errors.iter().filter(|e| !e.contains("`next` points to unknown guide \"forever/")).collect::<Vec<_>>(), Vec::<&String>::new());
	let mut diag = forge_guide::diag::Diagnostics::new();
	let entries = forge_guide::project::experimental_index(&ours.guides, &exp.guides, &fixture_data(), &mut diag);
	let errors = diag.sorted().iter().filter(|d| d.severity == "error").map(strip).collect();
	(entries, errors)
}

#[test]
fn our_guides_compile_with_an_experimental_offer_and_the_index_describes_its_route() {
	let r = compile_ours(&our_files(&["forever/alliance/t-default", "polestar-experimental/exp-1"]));
	assert_eq!(r.errors, Vec::<String>::new(), "the experimental pack is checked where it is read, not here");
	assert_eq!(plain(&r.guide("forever/alliance/t-main"))["nextChoices"], json!(["forever/alliance/t-default", "polestar-experimental/exp-1"]));
	let (entries, errors) = index(&r);
	assert_eq!(errors, Vec::<String>::new());
	assert_eq!(entries.len(), 1, "one entry per offered guide");
	let e: Value = plain(&entries[0]);
	assert_eq!(
		(e["id"].clone(), e["pack"].clone(), e["faction"].clone(), e["minLevel"].clone(), e["maxLevel"].clone(), e["topLevel"].clone()),
		(json!("polestar-experimental/exp-1"), json!("polestar-experimental"), json!("Alliance"), json!(10), json!(15), json!(22)),
		"its levels, and the top of its route through exp-2"
	);
	assert_eq!((e["zone"].clone(), e["zoneName"].clone()), (json!(1434), json!("Stranglethorn Vale")));
	assert_eq!(e["questIds"], json!([783, 7, 179]), "every accept of its route, each once, none of a dungeon run's (5261)");
	assert_eq!(e["joins"], json!(["forever/alliance/t-after"]), "where exp-2 hands back to ours");
	assert_eq!((e["start"]["map"].clone(), e["start"]["x"].clone(), e["start"]["y"].clone()), (json!(1429), json!(47.6), json!(35.1)), "its first located goal");
	assert_eq!((e["focus"]["map"].clone(), e["focus"]["x"].clone()), (json!(1434), json!(30)), "its first goal on its zone's map");
	assert_eq!((e["viaMap"].clone(), e["via"].clone()), (json!(1429), json!("Elwynn Forest")), "the zone its way in goes through");
	// Its texts as its guide registers them: name tokens, with the names they use.
	assert_eq!(e["pitch"], json!("A new zone south of {zone:1429}."));
	assert_eq!(e["names"], json!({ "zone:1429": "Elwynn Forest" }), "the names its texts use, no more");
	assert_eq!((e["pros"].clone(), e["cons"].clone()), (json!(["Fresh quests"]), json!(["Experimental"])));
	assert!(e.get("steps").is_none(), "no steps: a header");
}

#[test]
fn an_experimental_next_is_checked_where_its_pack_is_read() {
	// The line of `next <n>` in the main guide of `files`.
	let line = |files: &[(String, String)], n: &str| line_of(&files[0].1, &format!("next {n}"));
	// An id the pack lacks.
	let files = our_files(&["forever/alliance/t-default", "polestar-experimental/nope"]);
	let unknown = compile_ours(&files);
	assert_eq!(unknown.errors, Vec::<String>::new(), "our guides alone cannot tell");
	let (_, errors) = index(&unknown);
	assert_eq!(errors, vec![format!("main.guide:{}: `next` points to unknown guide \"polestar-experimental/nope\"", line(&files, "polestar-experimental/nope"))]);
	// The default line: an experimental guide is only ever chosen.
	let first = compile_ours(&our_files(&["polestar-experimental/exp-1", "forever/alliance/t-default"]));
	let (entries, errors) = index(&first);
	assert_eq!(entries.len(), 0);
	assert_eq!(errors.len(), 1, "{errors:?}");
	assert!(errors[0].contains("`next` offers the experimental guide \"polestar-experimental/exp-1\" first"), "{errors:?}");
	// The other faction's.
	let files = our_files(&["forever/alliance/t-default", "polestar-experimental/exp-horde"]);
	let horde = compile_ours(&files);
	let (_, errors) = index(&horde);
	assert_eq!(errors, vec![format!("main.guide:{}: `next` offers Horde guide \"polestar-experimental/exp-horde\" after a Alliance guide", line(&files, "polestar-experimental/exp-horde"))]);
	// Compiled with the experimental pack (as `forge guide lint experimental` does, ours as context), an id the
	// pack lacks is an error in the compile itself.
	let mut both = our_files(&["forever/alliance/t-default", "polestar-experimental/nope"]);
	both.extend(exp_files());
	let r = compile_ours(&both);
	assert!(r.errors.iter().any(|e| e.contains("`next` points to unknown guide \"polestar-experimental/nope\"")), "{:?}", r.errors);
}

#[test]
fn the_index_is_written_after_our_guides_and_only_when_a_guide_offers_one() {
	let r = compile_ours(&our_files(&["forever/alliance/t-default", "polestar-experimental/exp-1"]));
	let (entries, _) = index(&r);
	let iface = forge_guide::project::core_interface(&repo()).unwrap();
	let manifest = forge_guide::manifest::read_manifest(&repo().join("guides"), true).0.expect("guides/pack.json");
	let text = |files: Vec<(String, forge_guide::project::FileContent)>| -> String {
		match files.into_iter().find(|(n, _)| n == "Guides.lua").map(|(_, c)| c) {
			Some(forge_guide::project::FileContent::Text(t)) => t,
			_ => panic!("no Guides.lua"),
		}
	};
	let with = text(forge_guide::project::build_pack_files(&r.guides, &manifest, &fixture_data(), None, &V::obj(), &[], &entries, &iface, Vec::new()));
	let at = with.find("\nPolestar.RegisterExperimental({\n").expect("the index after the guides");
	let block = &with[at..];
	assert!(block.contains("\t\tid = \"polestar-experimental/exp-1\",\n\t\tpack = \"polestar-experimental\",\n"), "{block}");
	assert!(block.contains("\t\ttopLevel = 22,\n") && block.contains("\t\tjoins = { \"forever/alliance/t-after\" },\n") && block.contains("\t\tquestIds = { 783, 7, 179 },\n"), "{block}");
	assert!(block.contains("\t\tviaMap = 1429,\n\t\tvia = \"Elwynn Forest\",\n"), "{block}");
	assert!(block.ends_with("\t},\n})\n"), "{block}");
	let without = text(forge_guide::project::build_pack_files(&r.guides, &manifest, &fixture_data(), None, &V::obj(), &[], &[], &iface, Vec::new()));
	assert!(!without.contains("RegisterExperimental"));
	assert_eq!(&with[..at], without.as_str(), "the guides are written the same");
}

/// The files our pack's build writes from `files`, with the index of the experimental guides they offer.
fn build(files: &[(String, String)]) -> std::collections::BTreeMap<String, String> {
	let r = compile_ours(files);
	assert_eq!(r.errors, Vec::<String>::new());
	let (entries, errors) = index(&r);
	assert_eq!(errors, Vec::<String>::new());
	let iface = forge_guide::project::core_interface(&repo()).unwrap();
	let manifest = forge_guide::manifest::read_manifest(&repo().join("guides"), true).0.expect("guides/pack.json");
	forge_guide::project::build_pack_files(&r.guides, &manifest, &fixture_data(), None, &V::obj(), &[], &entries, &iface, Vec::new())
		.into_iter()
		.map(|(k, c)| match c {
			forge_guide::project::FileContent::Text(t) => (k, t),
			forge_guide::project::FileContent::Bytes(b) => (k, String::from_utf8_lossy(&b).into_owned()),
		})
		.collect()
}

// The route compiled both ways: with the experimental `next` line and without it, the files are the same but for
// the offering guide's `nextChoices` line, the index after the guides and the Era frame of its points' map; every
// other guide, the route's default `next` included, is written byte for byte as before.
#[test]
fn the_route_compiled_with_the_offer_and_without_it_differs_only_in_the_offer() {
	let with = build(&our_files(&["forever/alliance/t-default", "polestar-experimental/exp-1"]));
	let without = build(&our_files(&["forever/alliance/t-default"]));
	assert_eq!(with.keys().collect::<Vec<_>>(), without.keys().collect::<Vec<_>>(), "the same files");
	for (name, a) in &with {
		let b = &without[name];
		if a == b {
			continue;
		}
		let a_lines: Vec<&str> = a.lines().collect();
		let b_lines: Vec<&str> = b.lines().collect();
		let extra: Vec<&str> = a_lines.iter().copied().filter(|l| !b_lines.contains(l)).collect();
		let gone: Vec<&str> = b_lines.iter().copied().filter(|l| !a_lines.contains(l)).collect();
		assert_eq!(gone, Vec::<&str>::new(), "{name}: nothing of the route without the offer goes");
		if name == "Guides.lua" {
			assert!(a.starts_with(b.as_str()) && a[b.len()..].starts_with("\nPolestar.RegisterExperimental({\n"), "{name}: the index, after the guides");
		} else if name == "MapFrames.lua" {
			assert_eq!(extra.len(), 1, "{name}: the frame of the index's focus, in Stranglethorn Vale");
			assert!(extra[0].starts_with("\t\t[1434] = { "), "{name}: {extra:?}");
		} else {
			assert_eq!(extra, vec!["\t\t\tnextChoices = { \"forever/alliance/t-default\", \"polestar-experimental/exp-1\" },"], "{name}: only the offering guide's route choice");
		}
	}
}
