//! `forge data names` (formerly tests/i18n-names.test.js and tests/i18n-names-sources.test.js): on
//! tests/fixtures/names the packs match tests/fixtures/names/expected (the TOC's version and interface
//! lines aside); the ids kept, which source wins an id, DingDB's pin, --no-questie, the web names cache,
//! the extra kinds' ids, English names and placeholders, and the client tables' build.

use std::collections::{BTreeMap, BTreeSet};
use std::path::{Path, PathBuf};

use forge_data::names::{self, add_english, build_names, English, IdSets, Inputs, Options};
use forge_data::names_sources::{self as src, KindNames, Names, PfNames, Pin, WebNames};

use crate::common::{copy_tree, scratch};

fn root() -> PathBuf {
	PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

fn fix() -> PathBuf {
	root().join("tests/fixtures/names")
}

const DING_FILES: [&str; 4] = ["Ding/DB/CREDITS.md", "Ding/DB/Locales/deDE.lua", "Ding/DB/Locales/esMX.lua", "Ding/DB/Locales/frFR.lua"];

fn sha(f: &Path) -> String {
	use sha2::Digest;
	sha2::Sha256::digest(std::fs::read(f).unwrap()).iter().map(|b| format!("{b:02x}")).collect()
}

fn fixture_pin(dir: &Path) -> Pin {
	Pin { repo: "https://example.invalid/ding".into(), version: "v0.0.0".into(), commit: "a".repeat(40), files: DING_FILES.iter().map(|f| (f.to_string(), sha(&dir.join(f)))).collect() }
}

/// The options of a fixture build into `out`: no client tables, an empty source cache, no travel data.
fn fixture_options(out: &Path, cache: &Path) -> Options {
	let f = fix();
	let mut o = Options::new(&root());
	o.offline = true;
	o.no_tables = true;
	o.sources = cache.to_path_buf();
	o.ding = Some(f.join("ding"));
	o.pin = fixture_pin(&f.join("ding"));
	o.pfquest = Some(f.join("pfquest"));
	o.guides = f.join("Guides.lua");
	o.questdb = f.join("questdb");
	o.codex = f.join("codex");
	o.travel = cache.join("none.lua");
	o.chokepoints = cache.join("none.lua");
	o.out = out.to_path_buf();
	o.same_as_english = false;
	o
}

fn untagged(s: &str) -> String {
	s.lines().filter(|l| !l.starts_with("## Version:") && !l.starts_with("## Interface:")).collect::<Vec<_>>().join("\n")
}

/// The value of a TOC's `## <key>:` line.
fn toc_line(toc: &str, key: &str) -> String {
	toc.lines().find_map(|l| l.strip_prefix(&format!("## {key}: "))).unwrap_or_default().to_string()
}

fn files_of(dir: &Path) -> BTreeMap<String, String> {
	let mut out = BTreeMap::new();
	for d in std::fs::read_dir(dir).unwrap().flatten() {
		for f in std::fs::read_dir(d.path()).unwrap().flatten() {
			let name = format!("{}/{}", d.file_name().to_string_lossy(), f.file_name().to_string_lossy());
			out.insert(name, std::fs::read_to_string(f.path()).unwrap());
		}
	}
	out
}

#[test]
fn the_fixture_packs_match_the_expected_files() {
	let tmp = scratch("names-golden");
	let (out, cache) = (tmp.join("out"), tmp.join("cache"));
	std::fs::create_dir_all(&cache).unwrap();
	let r = names::run(&fixture_options(&out, &cache), &|_| {}).unwrap();
	assert_eq!(r.written.iter().map(|w| w.locale.as_str()).collect::<Vec<_>>(), ["deDE", "esMX", "frFR"]);
	let got = files_of(&out);
	let want = files_of(&fix().join("expected"));
	assert_eq!(got.keys().collect::<Vec<_>>(), want.keys().collect::<Vec<_>>(), "the same files");
	for (name, text) in &got {
		assert_eq!(untagged(text), untagged(&want[name]), "{name}");
	}
	let toc = &got["Polestar_frFR/Polestar_frFR.toc"];
	assert_eq!(*toc, forge_guide::toc::language_toc("frFR", &toc_line(toc, "Interface"), &toc_line(toc, "Version")), "the language folder's TOC, as `forge guide compile` writes it");
	for line in ["## LoadOnDemand: 1", "## Dependencies: Polestar", "## Group: Polestar", "Names.lua", "Texts.lua"] {
		assert!(toc.lines().any(|l| l == line), "{line}");
	}
	let lic = &got["Polestar_frFR/LICENSE-DATA.txt"];
	assert!(lic.contains(&"a".repeat(40)) && lic.contains(&sha(&fix().join("ding/Ding/DB/Locales/frFR.lua"))), "the DingDB pin");
	assert!(lic.contains("GPL-3.0") && lic.contains("MIT License"));
	assert_eq!(got["Polestar_frFR/CREDITS.md"], std::fs::read_to_string(fix().join("ding/Ding/DB/CREDITS.md")).unwrap());
	// A second build writes the same bytes.
	names::run(&fixture_options(&out, &cache), &|_| {}).unwrap();
	assert_eq!(files_of(&out), got);
}

#[test]
fn the_ids_kept_are_the_ones_the_guides_the_quest_database_and_the_codex_name() {
	let f = fix();
	let u = names::used_ids(&f.join("Guides.lua"), &f.join("questdb"), &f.join("codex")).unwrap();
	let v = |s: &BTreeSet<i64>| s.iter().copied().collect::<Vec<_>>();
	assert_eq!(v(&u.ids[0]), [7, 33, 34, 35, 176], "goal quests, pre, closedBy and preTitles, QuestDB and Codex quests");
	assert_eq!(v(&u.ids[1]), [6, 197, 240, 299, 448], "goal and candidate NPCs, text tokens, QuestDB and Codex NPCs");
	assert_eq!(v(&u.ids[2]), [68, 2843]);
	assert_eq!(v(&u.ids[3]), [750, 1528, 2862]);
	assert_eq!(u.counts[0], ("guides", [4, 4, 1, 3]));
	let e = names::used_ids(&f.join("Guides.lua"), &f.join("nowhere"), &f.join("codex")).err().unwrap();
	assert!(e.contains("forge data questdb") && e.contains("--questdb"), "{e}");
}

fn fixture_built(ding: bool) -> BTreeMap<String, names::Built> {
	let f = fix();
	let u = names::used_ids(&f.join("Guides.lua"), &f.join("questdb"), &f.join("codex")).unwrap();
	let [q, n, o, i] = u.ids;
	let ids: IdSets = [Some(q), Some(n), Some(o), Some(i), None, None, None, None, None];
	let locales = forge_guide::locales::LOCALE_CODES;
	let mut pfl = locales.to_vec();
	pfl.push("enUS");
	let pf = src::load_pfquest_names(&f.join("pfquest"), &pfl).unwrap();
	let d = ding.then(|| src::ensure_ding(&f.join("ding"), true, true, fixture_pin(&f.join("ding")), &|_| {}).unwrap());
	let dn = d.as_ref().map(|d| src::read_ding(d, &locales).unwrap());
	let english = English::default();
	build_names(&locales, &Inputs { ids: &ids, ding: dn.as_ref(), pf: &pf, wago: None, web: None, english: &english })
}

fn pairs(m: &Names) -> Vec<(i64, &str)> {
	m.iter().map(|(k, v)| (*k, v.as_str())).collect()
}

#[test]
fn dingdb_comes_first_and_pfquest_fills_the_gaps_an_english_pfquest_name_is_none() {
	let out = fixture_built(true);
	let fr = &out["frFR"];
	assert_eq!(pairs(&fr.names[0]), [(7, "Nettoyer le camp des kobolds"), (33, "Les loups à la frontière"), (176, "Avis de recherche : \"Lardeur\"")]);
	assert_eq!(pairs(&fr.names[1]), [(6, "Vermine kobold"), (240, "Maréchal Dughan"), (448, "Lardeur")], "Ding over pfQuest for 448; 197 is English in pfQuest");
	assert_eq!(pairs(&fr.names[2]), [(68, "Avis de recherche"), (2843, "Coffre cabossé")]);
	assert_eq!(pairs(&fr.names[3]), [(750, "Viande de loup coriace"), (1528, "Poignée d'avoine"), (2862, "Pierre à aiguiser brute")]);
	assert_eq!(&fr.from[..4], [[0, 0, 2, 1], [0, 0, 2, 1], [0, 0, 1, 1], [0, 0, 2, 1]]);
	assert_eq!(pairs(&out["esMX"].names[1]), [(240, "Alguacil Dughan")], "no esMX in pfQuest; Ding's English Hogger is not stored");
	assert_eq!(pairs(&out["deDE"].names[1]), [(6, "Koboldungeziefer")]);
	assert!(out["koKR"].names[1].is_empty());
}

#[test]
fn dingdb_is_pinned_a_changed_file_or_another_commit_stops_the_build() {
	let f = fix().join("ding");
	let ok = src::ensure_ding(&f, true, false, fixture_pin(&f), &|_| {}).unwrap();
	assert_eq!(ok.revision, None, "a fixture folder is not a git checkout");
	assert_eq!(ok.files.iter().map(|x| x.0.as_str()).collect::<Vec<_>>(), DING_FILES);
	let tmp = scratch("names-ding");
	let dir = tmp.join("copy");
	copy_tree(&f, &dir);
	let pin = fixture_pin(&dir);
	let fr = dir.join("Ding/DB/Locales/frFR.lua");
	let mut text = std::fs::read_to_string(&fr).unwrap();
	text.push_str("-- edited\n");
	std::fs::write(&fr, text).unwrap();
	let e = src::ensure_ding(&dir, true, false, pin.clone(), &|_| {}).err().unwrap();
	assert!(e.contains("Ding/DB/Locales/frFR.lua") && e.contains(&pin.files[3].1), "{e}");
	assert!(src::ensure_ding(&dir.join("missing"), true, false, pin.clone(), &|_| {}).err().unwrap().contains("no Ding/DB"));
	assert!(src::ensure_ding(&dir.join("missing"), false, true, pin, &|_| {}).err().unwrap().contains("--offline"));

	// A checkout at another commit: named, it stops; the cache clone moves to the pin.
	let repo = tmp.join("repo");
	copy_tree(&f, &repo);
	let g = |args: &[&str]| {
		let o = std::process::Command::new("git").args(["-c", "user.name=t", "-c", "user.email=t@t"]).args(args).current_dir(&repo).output().unwrap();
		String::from_utf8_lossy(&o.stdout).trim().to_string()
	};
	g(&["init", "--quiet"]);
	g(&["add", "."]);
	g(&["commit", "--quiet", "-m", "pinned"]);
	let pinned = g(&["rev-parse", "HEAD"]);
	std::fs::write(repo.join("NEWS"), "later\n").unwrap();
	g(&["add", "."]);
	g(&["commit", "--quiet", "-m", "later"]);
	let repo_pin = Pin { commit: pinned.clone(), ..fixture_pin(&repo) };
	let e = src::ensure_ding(&repo, true, false, repo_pin.clone(), &|_| {}).err().unwrap();
	assert!(e.contains(&format!("the pin is {pinned}")), "{e}");
	assert_eq!(src::ensure_ding(&repo, false, true, repo_pin, &|_| {}).unwrap().revision.as_deref(), Some(pinned.as_str()));

	let real = src::ding_pin();
	assert!(real.commit.len() == 40 && real.commit.bytes().all(|c| c.is_ascii_hexdigit()));
	let mut want: Vec<String> = forge_guide::locales::LOCALE_CODES.iter().map(|l| format!("Ding/DB/Locales/{l}.lua")).collect();
	want.push("Ding/DB/CREDITS.md".into());
	want.sort();
	assert_eq!(real.files.iter().map(|x| x.0.clone()).collect::<Vec<_>>(), want);
	assert!(real.files.iter().all(|(_, h)| h.len() == 64));
}

#[test]
fn no_questie_pfquest_only_and_a_language_without_names_loses_its_names_but_keeps_its_texts() {
	let out = fixture_built(false);
	assert_eq!(pairs(&out["frFR"].names[1]), [(6, "Vermine kobold"), (448, "Lardeur (pfQuest)")]);
	assert_eq!(pairs(&out["frFR"].names[0]), [(7, "Nettoyer le camp des kobolds"), (176, "Avis de recherche (pfQuest)")]);
	let tmp = scratch("names-noquestie");
	let (dir, cache) = (tmp.join("out"), tmp.join("cache"));
	for d in ["Polestar_esMX", "Polestar_frFR", "Polestar_Names_esMX", "Polestar_Names_frFR"] {
		std::fs::create_dir_all(dir.join(d)).unwrap();
		std::fs::write(dir.join(d).join("Names.lua"), "-- stale\n").unwrap();
	}
	// Our guides' texts (`forge guide compile`) share the language folder.
	std::fs::write(dir.join("Polestar_esMX/Texts.lua"), "-- texts\n").unwrap();
	std::fs::write(dir.join("Polestar_frFR/Texts.lua"), "-- texts\n").unwrap();
	std::fs::create_dir_all(&cache).unwrap();
	let mut o = fixture_options(&dir, &cache);
	o.no_questie = true;
	let r = names::run(&o, &|_| {}).unwrap();
	assert_eq!(r.written.iter().map(|w| w.locale.as_str()).collect::<Vec<_>>(), ["deDE", "frFR"]);
	assert!(!dir.join("Polestar_esMX/Names.lua").exists(), "the stale names are gone");
	assert!(dir.join("Polestar_esMX/Texts.lua").exists() && dir.join("Polestar_frFR/Texts.lua").exists(), "the texts stay");
	assert!(!dir.join("Polestar_Names_esMX").exists() && !dir.join("Polestar_Names_frFR").exists(), "the old folders are gone");
	assert!(!dir.join("Polestar_frFR/CREDITS.md").exists());
	let pin = fixture_pin(&fix().join("ding"));
	let ding_only: Vec<String> =
		["Maréchal Dughan", "Les loups à la frontière", "Viande de loup coriace", "Alguacil Dughan"].map(String::from).into_iter().chain(pin.files.iter().map(|f| f.1.clone())).collect();
	for (name, text) in files_of(&dir) {
		for d in &ding_only {
			assert!(!text.contains(d.as_str()), "{name} holds {d}");
		}
	}
	assert!(files_of(&dir)["Polestar_frFR/Names.lua"].contains("Lardeur (pfQuest)"));
	let json: serde_json::Value = serde_json::from_str(&r.json()).unwrap();
	assert!(json["ding"].is_null() && json["wago"].is_null() && json["web"].is_null());
	assert_eq!(json["locales"]["frFR"]["names"]["npc"], 2);
	assert_eq!(json["locales"]["frFR"]["sameAsEnglish"]["npc"], 1, "Marshal McBride, whose only French name is the English one");
}

#[test]
fn offline_without_cached_client_tables_stops_and_writes_nothing() {
	let tmp = scratch("names-notables");
	let (out, cache) = (tmp.join("out"), tmp.join("cache"));
	std::fs::create_dir_all(&cache).unwrap();
	let mut o = fixture_options(&out, &cache);
	o.no_tables = false;
	let e = names::run(&o, &|_| {}).err().unwrap();
	assert!(e.contains("no forever client tables"), "{e}");
	assert!(!out.exists());
	o.locales = vec!["xxXX".into()];
	assert!(names::run(&o, &|_| {}).is_err());
}

fn write_json(file: &Path, v: serde_json::Value) {
	std::fs::create_dir_all(file.parent().unwrap()).unwrap();
	std::fs::write(file, v.to_string()).unwrap();
}

const T0: &str = "2026-10-16T00:00:00.000Z";
const T1: &str = "2026-10-17T00:00:00.000Z";

#[test]
fn cached_web_lists_and_tooltips_bracketed_names_are_none_objectives_read() {
	use serde_json::json;
	let s = scratch("names-web");
	write_json(&s.join("web/codex/lists/npc.json"), json!({ "type": "npc", "chunks": [{ "rows": [{ "id": 5, "name": "Npc 5 " }, { "id": 7, "name": "Npc 7" }] }] }));
	write_json(
		&s.join("web/names/ruRU/lists/npc.json"),
		json!({ "type": "npc", "chunks": [
			{ "fetchedAt": T1, "rows": [{ "id": 5, "name": "Нпс 5" }, { "id": 7, "name": "[Npc 7]" }] },
			{ "fetchedAt": T0, "rows": [{ "id": 150, "name": "Нпс 150" }, { "id": 151, "name": "[PH] Нпс" }] },
		] }),
	);
	write_json(&s.join("web/names/ruRU/npc/150.json"), json!({ "id": 150, "name": "Tip 150", "fetchedAt": T0 }));
	write_json(&s.join("web/names/ruRU/npc/251.json"), json!({ "id": 251, "name": "Tip 251", "fetchedAt": T1 }));
	write_json(&s.join("web/names/ruRU/npc/404.json"), json!({ "id": 404, "notFound": true, "fetchedAt": T1 }));
	write_json(
		&s.join("web/names/ruRU/quest/92742.json"),
		json!({ "id": 92742, "name": "Задание", "fetchedAt": T0, "tooltip": "<table><tr><td><b class=\"q\">Задание</b><br />Убейте всех в лагере.<br /><br /><span class=\"q\">Requirements:</span></td></tr></table>" }),
	);
	let ru = src::load_web_names(&s, "ruRU").unwrap();
	assert_eq!(pairs(&ru.names[1]), [(5, "Нпс 5"), (150, "Нпс 150"), (251, "Tip 251")], "brackets and [PH] are no names; the list row first");
	assert_eq!(pairs(&ru.english[1]), [(5, "Npc 5"), (7, "Npc 7")]);
	assert_eq!(ru.names[0].get(&92742).map(String::as_str), Some("Задание"));
	assert_eq!(ru.objective.get(&92742).map(String::as_str), Some("Убейте всех в лагере."));
	assert_eq!(ru.fetched, Some((T0.to_string(), T1.to_string())));
	let none = src::load_web_names(&s.join("none"), "deDE").unwrap();
	assert!(none.names.iter().all(|m| m.is_empty()) && none.objective.is_empty() && none.fetched.is_none());
}

fn m(pairs: &[(i64, &str)]) -> Names {
	pairs.iter().map(|(k, v)| (*k, v.to_string())).collect()
}

fn set(ids: &[i64]) -> Option<BTreeSet<i64>> {
	Some(ids.iter().copied().collect())
}

#[test]
fn per_id_the_client_tables_win_then_the_web_names_dingdb_and_pfquest() {
	let ids: IdSets = [set(&[1, 2]), set(&[1, 2, 3, 4]), set(&[]), set(&[10, 11]), set(&[36]), None, set(&[72]), set(&[2]), set(&[1, 2])];
	let wago: BTreeMap<String, KindNames> = [(
		"ruRU".to_string(),
		[
			("item", m(&[(10, "Клиент 10")])),
			("map", m(&[(36, "Мертвые копи"), (999, "x")])),
			("encounter", m(&[(230, "Событие")])),
			("faction", m(&[(72, "Штормград")])),
			("taxi", m(&[(2, "Штормград, Элвиннский лес")])),
		]
		.into_iter()
		.collect(),
	)]
	.into();
	let web: BTreeMap<String, WebNames> = [(
		"ruRU".to_string(),
		WebNames { names: [m(&[(2, "Веб 2")]), m(&[(1, "Веб 1")]), m(&[]), m(&[(10, "Веб 10"), (11, "Веб 11")])], objective: m(&[(2, "Цель из веба")]), ..Default::default() },
	)]
	.into();
	let ding: BTreeMap<String, [Names; 4]> = [("ruRU".to_string(), [m(&[(1, "Динг 1")]), m(&[(1, "Динг 1"), (2, "Динг 2")]), m(&[]), m(&[])])].into();
	let pf: BTreeMap<String, PfNames> = [
		("ruRU".to_string(), PfNames { kinds: [m(&[]), m(&[(3, "Пф 3"), (4, "Same")]), m(&[]), m(&[])], objective: m(&[(1, "Убить$Bвсех"), (2, "Пф цель")]) }),
		("enUS".to_string(), PfNames { kinds: [m(&[]), m(&[(4, "Same")]), m(&[]), m(&[])], objective: m(&[(1, "Kill all")]) }),
	]
	.into();
	let english = English::default();
	let out = build_names(&["ruRU"], &Inputs { ids: &ids, ding: Some(&ding), pf: &pf, wago: Some(&wago), web: Some(&web), english: &english });
	let b = &out["ruRU"];
	assert_eq!(pairs(&b.names[3]), [(10, "Клиент 10"), (11, "Веб 11")]);
	assert_eq!(pairs(&b.names[1]), [(1, "Веб 1"), (2, "Динг 2"), (3, "Пф 3")]);
	assert_eq!(pairs(&b.names[0]), [(1, "Динг 1"), (2, "Веб 2")]);
	assert_eq!(pairs(&b.names[8]), [(1, "Убить всех"), (2, "Цель из веба")], "pfQuest's $B is a space; the web names first");
	assert_eq!(
		[pairs(&b.names[4]), pairs(&b.names[5]), pairs(&b.names[6]), pairs(&b.names[7])],
		[vec![(36, "Мертвые копи")], vec![(230, "Событие")], vec![(72, "Штормград")], vec![(2, "Штормград, Элвиннский лес")]]
	);
	assert_eq!(b.from[1], [0, 1, 1, 1]);
	assert_eq!(b.from[3], [1, 1, 0, 0]);
}

#[test]
fn the_extra_ids_instances_factions_flight_points_lifts_and_event_objectives() {
	use serde_json::json;
	let dir = scratch("names-extra");
	let codex = dir.join("codex");
	write_json(&codex.join("instances.json"), json!({ "deadmines": { "map": 36 }, "brd": { "map": 230 } }));
	write_json(&codex.join("factions.json"), json!({ "72": { "id": 72 }, "76": { "id": 76 } }));
	write_json(
		&codex.join("quests.json"),
		json!({ "155": { "objectives": [{ "type": "event", "id": 78 }] }, "166": { "objectives": [{ "type": "monster", "id": 639 }] }, "200": { "objectives": [{ "type": "event", "id": 1 }] } }),
	);
	write_json(&codex.join("journal.json"), json!({ "dungeons": { "deadmines": { "bosses": [{ "quests": [{ "id": 155 }, { "id": 166 }] }] } } }));
	let travel = dir.join("TravelData.lua");
	std::fs::write(
		&travel,
		"local ADDON, ns = ...\nlocal N = ns.Nav\nN.RegisterTravelData({ taxi = { {2,0,1,2,1453,1,2,1,\"Stormwind\"}, {4,0,1,2,1436,1,2,1,\"Sentinel Hill\"} } })\nN.RegisterCrossings({})\n",
	)
	.unwrap();
	let choke = dir.join("Chokepoints.lua");
	std::fs::write(&choke, "{ kind = \"lift\", liftObject = 4170 },\n{ kind = \"lift\", liftObject = 20649 },\n").unwrap();
	let e = names::extra_ids(&codex, &travel, &choke).unwrap();
	let v = |s: &BTreeSet<i64>| s.iter().copied().collect::<Vec<_>>();
	assert_eq!([v(&e.map), v(&e.faction), v(&e.taxi), v(&e.lift_object), v(&e.objective)], [vec![36, 230], vec![72, 76], vec![2, 4], vec![4170, 20649], vec![155]]);
	assert!(names::extra_ids(&dir.join("none"), &dir.join("none.lua"), &choke).unwrap().map.is_empty());
}

#[test]
fn an_english_name_never_beats_a_translation_and_an_id_named_only_in_english_gets_none() {
	let ids: IdSets = [set(&[]), set(&[1, 2, 3, 4]), set(&[]), set(&[10]), None, None, None, None, None];
	let mut english = English::default();
	for (id, n) in [(1, "Dolanaar Sentinel"), (2, "Hogger"), (3, "Grund Drokda"), (4, "Alba Fairmoon")] {
		add_english(&mut english, "npc", id, n);
	}
	add_english(&mut english, "item", 10, "Squirrel Nut");
	let wago: BTreeMap<String, KindNames> = [("zhCN".to_string(), [("item", m(&[(10, "Squirrel Nut")]))].into_iter().collect())].into();
	let web: BTreeMap<String, WebNames> = [("zhCN".to_string(), WebNames { names: [m(&[]), m(&[(1, "Dolanaar Sentinel"), (4, "阿尔巴·晴月")]), m(&[]), m(&[])], ..Default::default() })].into();
	let ding: BTreeMap<String, [Names; 4]> = [("zhCN".to_string(), [m(&[]), m(&[(1, "泰达希尔卫兵"), (2, "Hogger"), (3, "Grund Drokda")]), m(&[]), m(&[])])].into();
	let pf: BTreeMap<String, PfNames> =
		[("zhCN".to_string(), PfNames { kinds: [m(&[]), m(&[(2, "霍格")]), m(&[]), m(&[(10, "松鼠坚果")])], ..Default::default() }), ("enUS".to_string(), PfNames::default())].into();
	let out = build_names(&["zhCN"], &Inputs { ids: &ids, ding: Some(&ding), pf: &pf, wago: Some(&wago), web: Some(&web), english: &english });
	let b = &out["zhCN"];
	assert_eq!(pairs(&b.names[1]), [(1, "泰达希尔卫兵"), (2, "霍格"), (4, "阿尔巴·晴月")]);
	assert_eq!(pairs(&b.names[3]), [(10, "松鼠坚果")]);
	assert_eq!(b.english[1].iter().copied().collect::<Vec<_>>(), [3]);
}

#[test]
fn names_get_one_space_per_white_space_run_and_placeholder_names_are_none() {
	assert_eq!(names::clean("  Avis de\n recherche\t:  \"Lardeur\" "), "Avis de recherche : \"Lardeur\"");
	let ids: IdSets = [set(&[]), set(&[]), set(&[]), set(&[1, 2, 3, 4, 5, 6, 7]), None, None, None, None, set(&[9])];
	let items = m(&[(1, "[PH] Épée"), (2, "Épée [PÉRIMÉ]"), (3, "Bâton (DNT)"), (4, "<NYI> Bottes"), (5, "Hache\nde  guerre"), (6, "[INUTILISÉ] Anneau"), (7, "Bouclier (test)")]);
	let pf: BTreeMap<String, PfNames> =
		[("frFR".to_string(), PfNames { kinds: [m(&[]), m(&[]), m(&[]), items], objective: m(&[(9, "Tuez$Bles kobolds.")]) }), ("enUS".to_string(), PfNames::default())].into();
	let english = English::default();
	let out = build_names(&["frFR"], &Inputs { ids: &ids, ding: None, pf: &pf, wago: None, web: None, english: &english });
	assert_eq!(pairs(&out["frFR"].names[3]), [(5, "Hache de guerre")]);
	assert_eq!(out["frFR"].names[8].get(&9).map(String::as_str), Some("Tuez les kobolds."));
}

#[test]
fn the_client_tables_come_from_a_build_holding_every_table_in_english_and_each_language() {
	let s = scratch("names-wago");
	let tables = [("ItemSparse", "Display_lang"), ("Map", "MapName_lang"), ("DungeonEncounter", "Name_lang"), ("Faction", "Name_lang"), ("TaxiNodes", "Name_lang")];
	let write = |build: &str, locale: Option<&str>, only: &[&str], name: Option<&str>| {
		for (t, field) in tables.iter().filter(|(t, _)| only.contains(t)) {
			let mut dir = s.join("wago").join(build);
			if let Some(l) = locale {
				dir = dir.join(l);
			}
			std::fs::create_dir_all(&dir).unwrap();
			let n = name.map(String::from).unwrap_or_else(|| format!("{t} {}", locale.unwrap_or("en")));
			std::fs::write(dir.join(format!("{t}.csv")), format!("ID,{field}\n1,{n}\n")).unwrap();
		}
	};
	let all: Vec<&str> = tables.iter().map(|t| t.0).collect();
	// 1.60.1.2 is newer but lacks ruRU's TaxiNodes: 1.60.1.1 is the one read.
	for l in [None, Some("ruRU")] {
		write("1.60.1.1", l, &all, None);
	}
	write("1.60.1.2", None, &all, None);
	write("1.60.1.2", Some("ruRU"), &all[..4], None);
	write("1.15.9.1", None, &["ItemSparse"], Some("Era"));
	write("1.15.9.1", Some("ruRU"), &["ItemSparse"], Some("Эра"));
	let got = src::load_client_names(&s, &["ruRU"], None, true, &|_| {}).unwrap();
	assert_eq!(got.builds, [("forever", "1.60.1.1".to_string()), ("era", "1.15.9.1".to_string())]);
	assert_eq!(got.names["ruRU"]["taxi"].get(&1).map(String::as_str), Some("TaxiNodes ruRU"));
	assert_eq!(got.english["map"].get(&1).map(String::as_str), Some("Map en"));
	assert!(src::load_client_names(&s, &["deDE"], None, true, &|_| {}).err().unwrap().contains("no forever client tables"));
}
