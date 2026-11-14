use super::*;
use crate::recordings::Establish;

const OPEN: Establish = Establish { min_days: 0.0, min_chunks: 0.0, min_upload_days: 0.0, min_pos: 0.0, min_kills: 0.0 };

/// A session of `contributor`'s character `ch` (a level 5 Human Warrior) with these events.
fn session(contributor: &str, ch: &str, events: &[String]) -> String {
	format!(
		r#"{{"schema":2,"session":"{ch}-sess","contributor":"{contributor}","charId":"{ch}","char":{{"id":"{ch}","race":"Human","class":"WARRIOR","faction":"Alliance","level":5}},"build":70862,"started":1000,"received":5000,"contributorSince":1000,"contributorChunks":30,"uploadDays":3,"maps":{{}},"events":[{}]}}"#,
		events.join(",")
	)
}

/// Quest 900 (given by NPC 50) and quest 800; `extra` merges into 900's record.
fn quests(extra: &str) -> String {
	format!(
		r#"{{"800":{{"id":800,"title":"First","minLevel":1,"start":{{"npc":[51]}},"objectives":[],"source":["questie-forever"]}},
		"900":{{"id":900,"title":"Second","zone":1426,"start":{{"npc":[50]}},"objectives":[{{"type":"kill","id":70,"count":5}}],"source":["questie-forever"]{extra}}}}}"#
	)
}

fn learn_with(sessions: &[String], quests: &str, corrections: &str, verdicts: &Verdicts) -> (Output, V) {
	learn_in(sessions, quests, corrections, verdicts, &|_q| true, false, None)
}

/// `learn_with` where `scope` is the Forever-new quests, `all_spots` learns every quest's objective spots and `eg`
/// are EG Link's objective positions.
fn learn_in(sessions: &[String], quests: &str, corrections: &str, verdicts: &Verdicts, scope: &dyn Fn(i64) -> bool, all_spots: bool, eg: Option<&[crate::players::EgTick]>) -> (Output, V) {
	let cfg = Config { exclude: FxHashSet::default(), min_build: None, establish: OPEN, min_voters: 3 };
	let mut frames = FxHashMap::default();
	frames.insert(1426, (1000.0, 1000.0));
	let data = Data {
		quests: parse_json(quests).unwrap(),
		npcs: parse_json(r#"{"70":{"id":70,"spawns":{"1426":{"pts":[[50,50]]}}}}"#).unwrap(),
		objects: V::obj(),
		items: V::obj(),
		zones: V::obj(),
		corrections: parse_json(corrections).unwrap(),
		frames,
		built_at: V::Null,
	};
	let mut l = Learner::new(&cfg, verdicts, scope, all_spots);
	if let Some(eg) = eg {
		l.add_eg(eg);
	}
	for (i, s) in sessions.iter().enumerate() {
		l.add(&format!("s{i}.json"), s);
	}
	let out = l.finish(&data, (None, 0, 0), None);
	let q = parse_json(&out.quests).unwrap();
	(out, q)
}

fn learn(sessions: &[String], quests: &str) -> V {
	learn_with(sessions, quests, "{}", &Verdicts::default()).1
}

fn window(t: f64, avail: &str, not_offered: &str) -> String {
	format!(r#"{{"t":{t},"e":"offer","npc":50,"map":1426,"x":40,"y":40,"available":[{avail}],"active":[],"log":[],"done":[],"notOffered":[{not_offered}]}}"#)
}

fn turnin(t: f64, q: i64) -> String {
	format!(r#"{{"t":{t},"e":"turnin","q":{q},"npc":51}}"#)
}

/// Refused 900 at level 5 without 800, hands 800 in at 100, offered 900 at 110.
fn unlock(refusal_at: f64, extra: &[String]) -> Vec<String> {
	let mut ev = vec![r#"{"t":0,"e":"session","lvl":5}"#.to_string(), window(refusal_at, "", "900"), turnin(100.0, 800)];
	ev.extend(extra.iter().cloned());
	ev.push(window(110.0, "900", ""));
	ev
}

fn pre_of(q: &V) -> Vec<(f64, String)> {
	q.get("900").get("pre").items().iter().map(|f| (f.get("value").num(), f.get("status").to_js_string())).collect()
}

#[test]
fn a_refusal_then_an_offer_after_the_hand_in_is_a_prerequisite_co_occurrence_is_nothing() {
	let two: Vec<String> = ["c1", "c2"].iter().map(|c| session(c, &format!("{c}x"), &unlock(10.0, &[]))).collect();
	assert_eq!(pre_of(&learn(&two, &quests(""))), vec![(800.0, "trusted".into())]);
	assert_eq!(pre_of(&learn(&two[..1], &quests(""))), vec![(800.0, "gap".into())], "one counted voter: provisional");
	// Handed 800 in, then offered 900, never refused: what the guides do, not what the game needs.
	let co: Vec<String> = ["c1", "c2", "c3"].iter().map(|c| session(c, &format!("{c}x"), &[r#"{"t":0,"e":"session","lvl":5}"#.into(), turnin(100.0, 800), window(110.0, "900", "")])).collect();
	assert!(learn(&co, &quests("")).get("900").get("pre").is_undef());
}

#[test]
fn detail_windows_and_windows_right_after_a_hand_in_are_no_refusals() {
	// A detail window of the same NPC with the refusal: the window shows one quest.
	let detail = r#"{"t":10.5,"e":"detail","q":901,"npc":50}"#.to_string();
	let s: Vec<String> = ["c1", "c2"].iter().map(|c| session(c, &format!("{c}x"), &unlock(10.0, std::slice::from_ref(&detail)))).collect();
	assert!(learn(&s, &quests("")).get("900").get("pre").is_undef());
	// A window 1 s after handing 800 in may show the lists from before it.
	let lag: Vec<String> =
		["c1", "c2"].iter().map(|c| session(c, &format!("{c}x"), &[r#"{"t":0,"e":"session","lvl":5}"#.into(), turnin(100.0, 800), window(101.0, "", "900"), window(110.0, "900", "")])).collect();
	assert!(learn(&lag, &quests("")).get("900").get("pre").is_undef());
}

#[test]
fn offered_without_it_contradicts_and_the_two_thirds_rule_decides() {
	let never = |_v: usize| false;
	let set = |n: usize| (0..n).collect::<FxHashSet<usize>>();
	assert_eq!(quorum(&set(3), 1, 3, &never), Some(Status::Trusted));
	assert_eq!(quorum(&set(3), 2, 3, &never), Some(Status::Conflict), "3 of 5 is under two thirds");
	assert_eq!(quorum(&set(2), 0, 3, &never), Some(Status::Gap));
	assert_eq!(quorum(&set(0), 2, 3, &never), None);
	// Our data says 900 needs 800; three counted players were offered it without 800.
	let s: Vec<String> = ["c1", "c2", "c3"].iter().map(|c| session(c, &format!("{c}x"), &[r#"{"t":0,"e":"session","lvl":5}"#.into(), window(110.0, "900", ""), turnin(500.0, 800)])).collect();
	let q = learn(&s, &quests(r#","preAll":[800]"#));
	assert_eq!(q.get("900").get("notPre").at(0).get("status").as_str(), Some("trusted"));
	let q = learn(&s[..2], &quests(r#","preAll":[800]"#));
	assert_eq!(q.get("900").get("notPre").at(0).get("status").as_str(), Some("gap"), "two players don't override our data");
}

#[test]
fn corrections_win() {
	let s: Vec<String> = ["c1", "c2"].iter().map(|c| session(c, &format!("{c}x"), &unlock(10.0, &[]))).collect();
	let corrections = r#"{"quests":{"900":{"set":{"pre":[]}}}}"#;
	let (out, q) = learn_with(&s, &quests(""), corrections, &Verdicts::default());
	assert!(out.conflicts.contains("\"class\": \"vs-correction\""), "{}", out.conflicts);
	assert!(out.report.contains("correction kept"));
	// Consumers leave a corrected field alone, whatever the snapshot says.
	let rec = parse_json(&quests("")).unwrap().get("900");
	let corrected = parse_json(corrections).unwrap().get("quests").get("900").get("set");
	assert!(!apply_prereqs(&rec, &q.get("900"), &corrected, true));
	assert!(apply_prereqs(&rec, &q.get("900"), &V::obj(), false));
	assert_eq!(stringify(&rec.get("preAll"), None), "[800]");
}

fn tick(t: f64, x: f64, y: f64) -> String {
	format!(r#"{{"t":{t},"e":"progress","q":900,"oi":1,"cur":1,"max":5,"map":1426,"x":{x},"y":{y},"type":"monster"}}"#)
}

#[test]
fn objective_spots_cluster_per_voter_and_drop_noise() {
	let objectives = r#"{"t":1,"e":"objectives","q":900,"objectives":[{"type":"monster","max":5}]}"#.to_string();
	let near = |dx: f64| vec![objectives.clone(), tick(2.0, 60.0 + dx, 60.0), tick(3.0, 60.5 + dx, 60.2)];
	let mut s: Vec<String> = [("c1", 0.0), ("c2", 0.3), ("c3", -0.2)].iter().map(|(c, dx)| session(c, &format!("{c}x"), &near(*dx))).collect();
	// 350 yd away from the others: noise, and a voter that disagrees.
	s.push(session("c4", "c4x", &[objectives.clone(), tick(2.0, 90.0, 90.0)]));
	// A tick on a boat is never a spot.
	s.push(session("c5", "c5x", &[objectives.clone(), r#"{"t":2,"e":"ride","on":true}"#.into(), tick(3.0, 10.0, 10.0)]));
	let q = learn(&s, &quests(""));
	let at = q.get("900").get("objectives").at(0).get("at");
	assert_eq!(at.get("status").as_str(), Some("trusted"), "{}", stringify(&at, None));
	assert_eq!(at.get("counted").num(), 3.0);
	let spot = at.get("value").at(0);
	assert_eq!(at.get("value").len(), 1);
	assert!((spot.get("x").num() - 60.25).abs() < 0.3 && (spot.get("y").num() - 60.1).abs() < 0.2, "{}", stringify(&spot, None));
	// 100 yd from our data's NPC spawn at 50,50 is more than AGREE_YD: trusted recordings replace it.
	let (out, _) = learn_with(&s, &quests(""), "{}", &Verdicts::default());
	assert!(out.conflicts.contains("\"class\": \"replaces\""));
	// One counted player: provisional; an established player is needed at all.
	let q = learn(&s[..1], &quests(""));
	assert_eq!(q.get("900").get("objectives").at(0).get("at").get("status").as_str(), Some("gap"));
	let anon = session("anon-0123456789abcdef", "ax", &near(0.0));
	assert!(learn(&[anon], &quests("")).get("900").is_undef());
}

#[test]
fn scope_all_learns_every_quest_s_objective_spots_and_prerequisites_only_for_the_forever_new_ones() {
	let objectives = r#"{"t":1,"e":"objectives","q":900,"objectives":[{"type":"monster","max":5}]}"#.to_string();
	let s: Vec<String> = ["c1", "c2", "c3"]
		.iter()
		.map(|c| {
			let mut ev = unlock(10.0, &[]);
			ev.extend([objectives.clone(), tick(120.0, 60.0, 60.0), tick(121.0, 60.2, 60.1)]);
			session(c, &format!("{c}x"), &ev)
		})
		.collect();
	// 900 is no Forever-new quest here: nothing is learned of it...
	let classic = |q: i64| q != 900;
	let (out, q) = learn_in(&s, &quests(""), "{}", &Verdicts::default(), &classic, false, None);
	assert!(q.get("900").is_undef());
	assert!(out.meta.contains("\"scope\": \"forever-new\""));
	// ...but its objective spots with --scope all, while its prerequisites stay unlearned.
	let (out, q) = learn_in(&s, &quests(""), "{}", &Verdicts::default(), &classic, true, None);
	assert_eq!(q.get("900").get("objectives").at(0).get("at").get("status").as_str(), Some("trusted"));
	assert!(q.get("900").get("pre").is_undef());
	assert!(out.meta.contains("\"scope\": \"all\""));
}

#[test]
fn eg_link_positions_are_one_more_voter_for_a_spot_players_back_never_a_spot_of_their_own() {
	let objectives = r#"{"t":1,"e":"objectives","q":900,"objectives":[{"type":"monster","max":5}]}"#.to_string();
	let two: Vec<String> = ["c1", "c2"].iter().map(|c| session(c, &format!("{c}x"), &[objectives.clone(), tick(2.0, 60.0, 60.0), tick(3.0, 60.3, 60.1)])).collect();
	let eg = |x: f64, y: f64| vec![crate::players::EgTick { quest: 900, line: 1, build: 70888, map: 1426, x, y }];
	let learn_eg = |s: &[String], eg: &[crate::players::EgTick]| learn_in(s, &quests(""), "{}", &Verdicts::default(), &|_q| true, false, Some(eg));
	let at = |q: &V| q.get("900").get("objectives").at(0).get("at");
	// Two counted players: a gap.
	assert_eq!(at(&learn_eg(&two, &[]).1).get("status").as_str(), Some("gap"));
	// EG Link's positions in their spot: a second source agrees, trusted, the spot marked as backed by it.
	let (out, q) = learn_eg(&two, &eg(60.2, 60.0));
	assert_eq!(at(&q).get("status").as_str(), Some("trusted"));
	assert_eq!(at(&q).get("value").at(0).get("counted").num(), 3.0);
	assert!(at(&q).get("value").at(0).get("eg").truthy());
	assert!(out.meta.contains("\"egLink\": {") && out.meta.contains("\"positions\": 1"), "{}", out.meta);
	// 300 yd off, EG Link changes nothing...
	let q = learn_eg(&two, &eg(90.0, 90.0)).1;
	assert_eq!(at(&q).get("status").as_str(), Some("gap"));
	assert!(at(&q).get("value").at(0).get("eg").is_undef());
	// ...and on a line no player ticked it learns nothing.
	assert!(learn_eg(&[], &eg(60.2, 60.0)).1.get("900").is_undef());
}

#[test]
fn eg_link_objective_positions_are_read_from_the_cache_of_every_listed_build() {
	let dir = std::env::temp_dir().join(format!("forge-learn-eg-{}", std::process::id()));
	let eg = dir.join("eg-link").join(&crate::players::EG_COMMIT[..12]);
	assert_eq!(crate::players::load_eg_positions(&dir), Ok(None), "nothing cached");
	std::fs::create_dir_all(eg.join("wowf/1.60.1.70888")).unwrap();
	std::fs::write(eg.join("index.json"), r#"{"products":{"wowf":{"1.60.1.70888":{"objectives":{"records":1}},"1.60.1.70862":{"loot":{"records":1}}}}}"#).unwrap();
	std::fs::write(
		eg.join("wowf/1.60.1.70888/objectives.json"),
		r#"{"quests":{"900":{"1":{"gains":2,"positions":[{"uiMap":1426,"mapX":0.5,"mapY":0.625},{"uiMap":1426,"mapX":0.61}]}}},"completed":{}}"#,
	)
	.unwrap();
	let got = crate::players::load_eg_positions(&dir).unwrap().unwrap();
	let _ = std::fs::remove_dir_all(&dir);
	assert_eq!(got, vec![crate::players::EgTick { quest: 900, line: 1, build: 70888, map: 1426, x: 50.0, y: 62.5 }]);
}

#[test]
fn a_voter_beyond_three_mads_is_set_aside() {
	let pt = |voter: usize, x: f64| spots::Pt { voter, map: 1, x, y: 0.0 };
	// Three voters at 0, one 55 yd off, linked to them through a fifth at 30.
	let found = spots::locate(&[pt(0, 0.0), pt(1, 0.0), pt(2, 0.0), pt(3, 55.0)]);
	assert_eq!(found.spots.len(), 1);
	assert_eq!(found.spots[0].voters, vec![0, 1, 2]);
	assert!(found.outliers.contains(&3));
	// Two players 300 yd apart: neither is noise, each its own spot.
	let found = spots::locate(&[pt(0, 0.0), pt(1, 300.0)]);
	assert_eq!(found.spots.len(), 2);
}

#[test]
fn one_person_under_two_contributors_votes_once() {
	let s: Vec<String> = ["c1", "c2"].iter().map(|c| session(c, &format!("{c}x"), &unlock(10.0, &[]))).collect();
	let mut v = Verdicts::default();
	v.person.insert("c1".into(), "c1".into());
	v.person.insert("c2".into(), "c1".into());
	let (_, q) = learn_with(&s, &quests(""), "{}", &v);
	assert_eq!(pre_of(&q), vec![(800.0, "gap".into())]);
	let f = q.get("900").get("pre").at(0);
	assert_eq!((f.get("voters").num(), f.get("counted").num()), (1.0, 1.0));
	// Excluded or suspect contributors never count.
	let mut v = Verdicts::default();
	v.out.insert("c2".into());
	assert_eq!(pre_of(&learn_with(&s, &quests(""), "{}", &v).1), vec![(800.0, "gap".into())]);
}

#[test]
fn the_snapshot_names_no_contributor_character_or_session() {
	let s: Vec<String> = ["zzsecretA", "zzsecretB", "zzsecretC"].iter().map(|c| session(c, &format!("{c}-char"), &unlock(10.0, &[tick(105.0, 60.0, 60.0)]))).collect();
	let (out, q) = learn_with(&s, &quests(""), "{}", &Verdicts::default());
	assert!(q.get("900").get("pre").truthy() && q.get("900").get("objectives").truthy());
	for (name, text) in [("quests.json", &out.quests), ("meta.json", &out.meta), ("report.md", &out.report), ("conflicts.json", &out.conflicts)] {
		assert!(!text.contains("zzsecret"), "{name} names a contributor or character: {text}");
		assert!(!text.contains("-sess"), "{name} names a session");
	}
}

#[test]
fn a_pinned_minimum_level_needs_two_voters_and_consumers_take_trusted_only() {
	// Refused at 4 with everything done, offered at 5 with nothing handed in between.
	let ev = |c: &str| {
		session(c, &format!("{c}x"), &[r#"{"t":0,"e":"session","lvl":4}"#.into(), turnin(5.0, 800), window(10.0, "", "900"), r#"{"t":50,"e":"level","lvl":5}"#.into(), window(60.0, "900", "")])
	};
	let data = quests(r#","pre":[800],"minLevel":3"#);
	let q = learn(&[ev("c1"), ev("c2"), ev("c3")], &data);
	let f = q.get("900").get("minLevel");
	assert_eq!((f.get("value").num(), f.get("status").as_str()), (5.0, Some("trusted")), "{}", stringify(&f, None));
	assert_eq!(min_level(&q.get("900"), &V::obj()), Some(5));
	let q = learn(&[ev("c1"), ev("c2")], &data);
	assert_eq!(q.get("900").get("minLevel").get("status").as_str(), Some("gap"), "changing our data's level takes three");
	assert_eq!(min_level(&q.get("900"), &V::obj()), None);
}

#[test]
fn the_codex_takes_recorded_prerequisites_and_objective_spots() {
	use crate::codex::{merge::merge_codex, Forever, Inputs};
	let objectives = r#"{"t":1,"e":"objectives","q":900,"objectives":[{"type":"monster","max":5}]}"#.to_string();
	// Two players unlock 900 by handing 800 in (trusted); one ticks its objective (provisional).
	let mut s: Vec<String> = ["c1", "c2"].iter().map(|c| session(c, &format!("{c}x"), &unlock(10.0, &[]))).collect();
	s.push(session("c3", "c3x", &[objectives, tick(2.0, 61.0, 62.0)]));
	let data = quests("");
	let (_, snapshot) = learn_with(&s, &data, "{}", &Verdicts::default());
	let quests_v = parse_json(&data).unwrap();
	for q in quests_v.values() {
		q.set("end", parse_json(r#"{"npc":[50]}"#).unwrap());
	}
	let forever = Forever {
		items: V::obj(),
		npcs: V::obj(),
		objects: V::obj(),
		quests: quests_v,
		zones: V::obj(),
		factions: V::obj(),
		professions: V::obj(),
		trainers: V::obj(),
		map_frames: V::obj(),
		meta: parse_json(r#"{"builtAt":"2026-11-09T00:00:00.000Z","sources":[]}"#).unwrap(),
		instances: V::Null,
		spawnz: V::Null,
		dungeons: V::Null,
	};
	let inputs = |learned: Snapshot| Inputs {
		forever: clone_forever(&forever),
		atlasloot: None,
		rarescanner: None,
		local_extras: false,
		recorded: V::obj(),
		learned,
		client: None,
		web: None,
		curated: Vec::new(),
		curated_gates: V::Null,
		curated_vendors: V::Null,
		entrances: Vec::new(),
		entrance_table: V::Null,
		levels_table: V::obj(),
		rep_table: V::obj(),
		attunement_table: V::Null,
		store_xp: Default::default(),
		journal_quests: Vec::new(),
		warnings: Vec::new(),
	};
	let without = merge_codex(&inputs(Snapshot::default())).quests.get("900");
	assert_eq!(stringify(&without.get("pre"), None), "[]");
	assert!(without.get("objectives").at(0).get("map").is_undef());
	let codex = merge_codex(&inputs(Snapshot { quests: snapshot.clone(), corrections: V::obj() })).quests.get("900");
	assert_eq!(stringify(&codex.get("pre"), None), "[800]");
	let o = codex.get("objectives").at(0);
	assert_eq!((o.get("map").num(), o.get("x").num(), o.get("y").num(), o.get("provisional").truthy()), (1426.0, 61.0, 62.0, true));
	// A correction's prerequisites stand.
	let corrections = parse_json(r#"{"quests":{"900":{"set":{"pre":[]}}}}"#).unwrap();
	let codex = merge_codex(&inputs(Snapshot { quests: snapshot, corrections })).quests.get("900");
	assert_eq!(stringify(&codex.get("pre"), None), "[]");
}

fn clone_forever(f: &crate::codex::Forever) -> crate::codex::Forever {
	crate::codex::Forever {
		items: f.items.json_clone(),
		npcs: f.npcs.json_clone(),
		objects: f.objects.json_clone(),
		quests: f.quests.json_clone(),
		zones: f.zones.json_clone(),
		factions: f.factions.json_clone(),
		professions: f.professions.json_clone(),
		trainers: f.trainers.json_clone(),
		map_frames: f.map_frames.json_clone(),
		meta: f.meta.json_clone(),
		instances: V::Null,
		spawnz: V::Null,
		dungeons: V::Null,
	}
}
