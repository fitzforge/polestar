//! Checkout quest corrections reach the writer without changing unrelated route goals.

use forge_data::corrections;
use forge_guide::js::{parse_json, stringify, Obj};
use forge_writer::{fixes, post, Data};
use serde_json::{json, Map, Value};
use std::collections::{BTreeMap, HashSet};
use std::path::Path;

#[test]
fn applejack_corrections_remove_accepts_and_preserve_the_elwynn_route() {
	// #2312: these two quests open on their hand-in window and never enter the log.
	// The old accept of 91738 also made While Here offer it with no Thunder Applejack.
	let repo = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..");
	let records: Value = serde_json::from_str(&std::fs::read_to_string(repo.join("forever-db/corrections/quests.json")).unwrap()).unwrap();
	let ids = [91736, 91738];
	let selected: Map<String, Value> = ids.iter().filter_map(|q| records.get(q.to_string()).map(|record| (q.to_string(), record.clone()))).collect();
	let correction = parse_json(&json!({ "quests": selected }).to_string()).unwrap();
	// Existing public quest records supply the identities; the test does not supply direct itself.
	let quests: Map<String, Value> = std::fs::read_to_string(repo.join("forever-db/data/quest.jsonl"))
		.unwrap()
		.lines()
		.map(|line| serde_json::from_str::<Value>(line).unwrap())
		.filter(|q| ids.contains(&q["id"].as_u64().unwrap()))
		.map(|q| (q["id"].to_string(), q))
		.collect();
	assert_eq!(quests.len(), 2);
	let quests = parse_json(&Value::Object(quests).to_string()).unwrap();
	let applied = corrections::apply(&correction, quests.as_obj().unwrap(), &Obj::new(), &Obj::new(), &Obj::new(), false);
	let data = Data { quests: serde_json::from_str(&stringify(&quests, None)).unwrap(), ..Data::default() };
	let tips: Value = serde_json::from_str(&std::fs::read_to_string(repo.join("data/guide-fixes.json")).unwrap()).unwrap();
	let tips =
		json!({ "fixes": tips["fixes"].as_array().unwrap().iter().filter(|r| ["820-applejack-still", "823-de-vries-apple-treat"].contains(&r["id"].as_str().unwrap_or(""))).collect::<Vec<_>>() });
	assert_eq!(tips["fixes"].as_array().unwrap().len(), 2);

	for path in ["forge/seed/guides/forever/alliance/human/01-elwynn-forest.guide", "guides/forever/alliance/human/01-elwynn-forest.guide"] {
		let source = std::fs::read_to_string(repo.join(path)).unwrap();
		let mut files = vec![source.clone()];
		post::direct_hand_ins(&mut files, &data);
		for q in ids {
			assert!(!files[0].lines().any(|line| line.split_whitespace().take(2).eq(["accept", &q.to_string()])), "{path}: quest {q} must not be accepted");
			let hand_ins: Vec<_> = files[0].lines().filter(|line| line.split_whitespace().take(2).eq(["turnin", &q.to_string()])).collect();
			assert_eq!(hand_ins.len(), 1, "{path}: one hand-in of {q}");
			assert!(hand_ins[0].split_whitespace().any(|word| word == "direct"), "{path}: {q} is handed in directly");
		}
		// Only remove the two accepts and mark their hand-ins. This retains the required Applejack
		// collect, optional still hand-in, apples purchase, tips and all other Westbrook/route goals.
		let expected = source
			.split('\n')
			.filter_map(|line| {
				if ids.iter().any(|q| line.split_whitespace().take(2).eq(["accept", &q.to_string()])) {
					return None;
				}
				for q in ids {
					if line.split_whitespace().take(2).eq(["turnin", &q.to_string()]) && !line.split_whitespace().any(|word| word == "direct") {
						return Some(line.replacen(&format!("turnin {q}"), &format!("turnin {q} direct"), 1));
					}
				}
				Some(line.to_string())
			})
			.collect::<Vec<_>>()
			.join("\n");
		assert_eq!(files[0], expected, "{path}: unrelated source must be unchanged");
		let once = files.clone();
		post::direct_hand_ins(&mut files, &data);
		assert_eq!(files, once, "{path}: repeated writing is idempotent");
		// run::run applies the tip records after direct-hand-in conversion. Their anchors must
		// still match, so future writes keep both warnings instead of reporting stale accepts.
		let apply_tips = |text| {
			let mut tree = BTreeMap::from([(path.to_string(), text)]);
			let rows =
				fixes::apply(&mut tree, &[path.to_string()], &HashSet::from([91736, 91738]), Some("Alliance"), fixes::Records { guide_fixes: Some(&tips), ..fixes::Records::default() }, Some(&data));
			(tree.remove(path).unwrap(), rows)
		};
		let (tipped, rows) = apply_tips(files[0].clone());
		assert_eq!(rows.len(), 2);
		assert!(rows.iter().all(|r| ["applied", "redundant"].contains(&r.state.as_str())), "{path}: tips remain anchored: {rows:?}");
		// The existing record normalizes Westbrook's longer seed tip. Converting the quests must
		// preserve that behavior: applying the same tips before conversion gives identical output.
		let (before, _) = apply_tips(source);
		let mut before = vec![before];
		post::direct_hand_ins(&mut before, &data);
		assert_eq!(tipped, before[0], "{path}: tip behavior and unrelated route content are preserved");
		let (again, rows) = apply_tips(tipped.clone());
		assert_eq!(again, tipped);
		assert!(rows.iter().all(|r| r.state == "redundant"), "{rows:?}");
	}
	assert_eq!(applied.records, 2);
	assert_eq!(applied.created, 0);
	assert!(applied.unused.is_empty(), "{:?}", applied.unused);
}
