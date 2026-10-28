//! The writer's travel repair (port of tests/travel-repair.test.js): the written guides played by the
//! route's characters (playtest --honest, R1); a v1 travel line that starts where they are not is the
//! other races', and the route's own way takes them on. Plays on the committed data slice with the
//! writer golden's whole-world travel.json (tests/common, rust/tests/golden/writer); $POLESTAR_V1's
//! full data/forever when set.
#![cfg(feature = "native")]

mod common;

use forge_writer::travel::{repair_travel, Travel};
use std::collections::BTreeMap;

fn start(lines: &[&str]) -> Vec<String> {
	["guide forever/t/start", "title Start", "faction Horde", "race Orc,Troll", "levels 30-40", "next forever/t/shared"].iter().chain(lines).map(|s| s.to_string()).collect()
}

fn shared(lines: &[&str]) -> Vec<String> {
	["guide forever/t/shared", "title Shared", "faction Horde", "levels 30-40"].iter().chain(lines).map(|s| s.to_string()).collect()
}

fn text(lines: &[String]) -> String {
	let mut l = lines.to_vec();
	l.push(String::new());
	l.join("\n")
}

fn run(start: &[String], v1: &[String], written: &[String]) -> (forge_writer::travel::Report, Vec<String>) {
	run_as(start, v1, written, &["Orc", "Troll"], None)
}

fn run_as(start: &[String], v1: &[String], written: &[String], races: &[&str], cls: Option<&str>) -> (forge_writer::travel::Report, Vec<String>) {
	let data = common::travel_ref().data;
	let v1t: BTreeMap<String, String> = [("forever/t/start.guide".to_string(), text(start)), ("forever/t/shared.guide".to_string(), text(v1))].into();
	let mut out: BTreeMap<String, String> = [("forever/t/start.guide".to_string(), text(start)), ("forever/t/shared.guide".to_string(), text(written))].into();
	let t = Travel {
		chain: vec!["forever/t/start.guide".into(), "forever/t/shared.guide".into()],
		route_races: races.iter().map(|r| r.to_string()).collect(),
		other_races: ["Orc", "Troll", "Tauren", "Undead", "Skyborne"].iter().filter(|r| !races.contains(r)).map(|r| r.to_string()).collect(),
		shared: vec!["forever/t/shared.guide".into()],
		faction: Some("Horde".into()),
		cls: cls.map(str::to_string),
	};
	let r = repair_travel(&mut out, &v1t, &t, &data, None);
	let g = out["forever/t/shared.guide"].split('\n').map(str::to_string).collect();
	(r, g)
}

/// The first line matching p in a step `only Orc,Troll`.
fn route_line(g: &[String], p: &str) -> Option<usize> {
	(0..g.len()).find(|&i| {
		if !re(&g[i], p) {
			return false;
		}
		let s = (0..=i).rev().find(|&k| g[k].starts_with("step ")).unwrap_or(0);
		g.get(s + 1).map(String::as_str) == Some("  only Orc,Troll")
	})
}

/// Whether the line starting with `start` is the other races' alone (its own `only`, or its step's).
fn others_only(g: &[String], start: &str) -> bool {
	let Some(i) = g.iter().position(|l| l.starts_with(start)) else { return false };
	if g[i].ends_with(" only Tauren,Undead,Skyborne") {
		return true;
	}
	let s = (0..=i).rev().find(|&k| g[k].starts_with("step ")).unwrap_or(0);
	g.get(s + 1).map(String::as_str) == Some("  only Tauren,Undead,Skyborne")
}

fn re(l: &str, p: &str) -> bool {
	regex::Regex::new(p).unwrap().is_match(l)
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn after_the_route_hearth_v1_zeppelin_is_the_others_and_the_way_is_written() {
	let st = start(&["zone Arathi Highlands", "", "step Hammerfall", "  goto 73.8,32.5 \"Hammerfall\"", "  sethome \"Hammerfall\"", "  getfp \"Hammerfall\"", ""]);
	let v1 = shared(&[
		"zone Stranglethorn Vale",
		"",
		"step Grom'gol",
		"  goto 32.5,29.3 \"Grom'gol\"",
		"",
		"step Zeppelin to Orgrimmar",
		"  goto 31.4,29.9 \"Zeppelin to Orgrimmar\"",
		"",
		"step Orgrimmar",
		"  zone Orgrimmar",
		"  goto 51.5,45.6 \"Orgrimmar\"",
		"",
	]);
	// The route hearths back to Hammerfall from Grom'gol before v1's zeppelin step.
	let mut written: Vec<String> = v1[..9].to_vec();
	written.extend(["step Hearth to Hammerfall", "  only Orc,Troll", "  hearth \"Hammerfall\"", ""].map(String::from));
	written.extend(v1[9..].iter().cloned());
	let (r, g) = run(&st, &v1, &written);
	assert_eq!(r.left.len(), 0, "{:?}\n{}\n{}", r.left, g.join("\n"), r.log.join("\n"));
	assert!(others_only(&g, "  goto 31.4,29.9 \"Zeppelin to Orgrimmar\""), "{}", g.join("\n"));
	// Their own crossing, for them alone, before Orgrimmar.
	let ride = route_line(&g, r#"^\s+goto .*"Zeppelin to "#).expect("their ride");
	let org = g.iter().position(|l| l == "step Orgrimmar").unwrap();
	assert!(ride > 0 && ride < org, "{}", g.join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn after_the_route_flight_v1_boat_is_the_others_and_the_way_is_written() {
	let st = start(&["zone Orgrimmar", "", "step Orgrimmar", "  goto 45.3,63.8 \"Orgrimmar flight master\"", "  getfp \"Orgrimmar\"", ""]);
	let v1 = shared(&[
		"zone The Barrens",
		"",
		"step Ratchet",
		"  goto 63.1,37.1 \"Ratchet flight master\"",
		"  getfp \"Ratchet\"",
		"",
		"step Boat to Booty Bay",
		"  goto 63.4,38.5 \"Boat to Booty Bay\"",
		"",
		"step Booty Bay",
		"  zone Stranglethorn Vale",
		"  goto 27.0,77.0 \"Booty Bay\"",
		"",
	]);
	// The route flies back to Orgrimmar from Ratchet before v1's boat step.
	let mut written: Vec<String> = v1[..10].to_vec();
	written.extend(["step Fly to Orgrimmar", "  only Orc,Troll", "  fly \"Orgrimmar\"", ""].map(String::from));
	written.extend(v1[10..].iter().cloned());
	let (r, g) = run(&st, &v1, &written);
	assert_eq!(r.left.len(), 0, "{:?}", r.left);
	assert!(others_only(&g, "  goto 63.4,38.5 \"Boat to Booty Bay\""), "{}", g.join("\n"));
	// Their own crossing (back to Ratchet's boat, by the flight they know), for them alone.
	let theirs = g.iter().position(|l| l.starts_with("  goto 63.4,38.5 \"Boat to Booty Bay\"")).unwrap();
	let ride = route_line(&g, r#"^\s+goto .*"(Boat|Zeppelin) to "#).expect("their ride");
	let bay = g.iter().position(|l| l == "step Booty Bay").unwrap();
	assert!(ride > theirs && ride < bay, "{}", g.join("\n"));
}

#[test]
fn gate_keeps_other_races() {
	use forge_writer::travel::gate;
	let rr = vec!["Orc".to_string(), "Troll".to_string()];
	let or = vec!["Tauren".to_string()];
	assert_eq!(gate("  fly \"X\"", &rr, &or, true).as_deref(), Some("  fly \"X\" only Tauren"));
	assert_eq!(gate("  fly \"X\"", &rr, &or, false), None);
	assert_eq!(gate("  fly \"X\" only Orc,Tauren -- c", &rr, &or, true).as_deref(), Some("  fly \"X\" only Tauren -- c"));
	assert_eq!(gate("  fly \"X\" only Orc", &rr, &or, true), None);
	assert_eq!(gate("  fly \"X\" only !Orc", &rr, &or, true).as_deref(), Some("  fly \"X\" only !Orc"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn a_druids_way_to_moonglade_is_its_teleport() {
	// RevSkyH3 S6: the Skyborne Druids' way from Thunder Bluff to Moonglade was a flight to Orgrimmar
	// and a 6,551 yd walk; they teleport, as v1's Moonglade steps say.
	let st = start(&["zone Thunder Bluff", "", "step Elder Rise", "  goto 76.5,27.3 \"Elder Rise\"", ""]);
	let v1 = shared(&["zone Thunder Bluff", "", "step Elder Rise", "  talk 3033 @76.5,27.3", ""]);
	let mut written = v1.clone();
	written.extend(["step Moonglade", "  only Druid", "  zone Moonglade", "  talk 11802 @52.5,40.6", ""].map(String::from));
	let (r, g) = run_as(&st, &v1, &written, &["Tauren"], Some("DRUID"));
	assert!(g.iter().any(|l| l.contains("\"Cast Teleport: Moonglade\"")), "{}\n{:?}\n{:?}", g.join("\n"), r.log, r.left);
	assert!(!g.iter().any(|l| l.starts_with("  fly ")), "{}", g.join("\n"));
}
